public with sharing class FUA_UploadDocuments {
    
    /* Public member varialbles starts*/
    public transient Blob file{get;set;}
    public String appId{get;set;}
    public String selectedDocument{get;set;}
    public String documentDescription{get;set;}
    public String fileName{get;set;}
    public List<SelectOption> documentTypes{get;set;}
    public String appReferenceNumber{get;set;}
    public List<FUA_Applicant_Document__c> documents{get;set;}
    public String contId{get;set;}
    public String pageId;
    public Contact Con{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    /* Public member varialbles ends*/
    
    /* Static member varialbles starts*/
    static String appidTemp;
    /* Static member varialbles starts*/
    
    /* Private member varialbles starts*/
    List<Application__c> application;
    List<Contact> contacts = new List<Contact>();
    /* Private member varialbles starts*/
    
    
    /* Constructor starts*/
    public FUA_UploadDocuments(){
        pageId = ApexPages.currentPage().getParameters().get('Id');
        application = new List<Application__c>();
        if(pageId == null){
            system.debug('UserId 1 -> ' + UserInfo.getUserId());
            contId = [select ContactId from User where Id = :UserInfo.getUserId()].ContactId;
            Con = [select Id,Email from Contact where Id = :contId];
            application = [select Id,Completed_Stages__c,Application_Reference_ID__c from Application__c where Contact__c =: contId];
        }
        else{
            application = [select Id,Completed_Stages__c,Application_Reference_ID__c from Application__c where Id =: pageId];
        }
        
        if(application.size() > 0){
            appId = application[0].Id;
            appReferenceNumber = application[0].Application_Reference_ID__c;
        }
        appidTemp = appId;
        if(appId != null){
            documents = new List<FUA_Applicant_Document__c>();
            documents = [SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c
                         FROM FUA_Applicant_Document__c 
                         WHERE Application__c = :appId];
        }
        
        Schema.DescribeFieldResult F = FUA_Applicant_Document__c.Document_Type__c.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();
        documentTypes = new List<SelectOption>();
        documentTypes.add(new SelectOption('10th Marksheet','10th Marksheet'));
        for(Schema.PicklistEntry val : P){
            documentTypes.add(new SelectOption(val.getLabel(),val.getValue()));
        }
    }
    /* Constructor Ends*/
    
    
    
    /**
     * UploadDoc function is  used to uploading the document in Dropbox Account.
     * Once the document gets uploaded in Dropbox then all the properties of the Documents are also saved in salesforce in the form of Application Document Object records.
     * file.size() < 6000000 -> This ensures data more than 6M will not be allowed to upload.
    */
    public PageReference UploadDoc(){
        system.debug('fileName -> ' + fileName);
        if(file.size() < 6000000 && file.size() > 0){
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/' +appReferenceNumber +'__'+ fileName;
            String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(file);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            HttpResponse res = h.send(req);
            string resp = res.getBody();
            system.debug('>>>>>>>>>>>>>>>>>>>>>'+resp);
            file=null;
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            String url =getLink(Responsepath);
            //url = url.replaceAll('dl=0','dl=1'); This is required if user wants to download the file directly.
            String[] splitter = path_lower.split(appReferenceNumber+'/');
            String uploadedFileName = splitter[1];
            delete new List<FUA_Applicant_Document__c>([select Id from FUA_Applicant_Document__c WHERE Application__c = :appId and Name=:uploadedFileName]);
            FUA_Applicant_Document__c doc = new FUA_Applicant_Document__c();
            doc.Name = uploadedFileName;
            doc.Application__c = appId;
            doc.Description__c = documentDescription;
            doc.Document_Link__c = url;
            doc.Document_Type__c = selectedDocument;
            doc.Path__c = Responsepath;
            insert doc;
           
            if(appId != null){
                documents = new List<FUA_Applicant_Document__c>();
                documents = [SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :appId];
                if(documents.size() > 0){
                    String completedStages = application[0].Completed_Stages__c;
                    String currentPageName = 'Upload Documents';
                    if(completedStages != null){
                        if(!completedStages.contains(currentPageName)){
                            completedStages += ';' + currentPageName;
                            application[0].Completed_Stages__c = completedStages;
                        }
                    }
                    else{
                        application[0].Completed_Stages__c = currentPageName;
                    }
                    update application;
                }
            }
            if(pageId != null){
                PageReference uploadPage =  new PageReference('/apex/GlobalUploadDocuments_1');
                uploadPage.getParameters().put('FileUpload', '1');
                uploadPage.setRedirect(true);
                return uploadPage;
            }
            else{
                return new PageReference('/apex/UploadDocuments_1');
            }
        }
        else{
            system.debug('Max size limit exceeded ' + file.size());
            return null;
        }
    }
    
    /**
     * This function is used to delete the data from Dropbox and also once the data is deleted from dropbox the related data are also deleted from Salesforce.
    */
    @RemoteAction
   
    public static String DeleteData(String path_lower){
         String resp = FLAME_Utility.DeleteApplicationDocument(path_lower);
        system.debug('Response ->' + resp);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
        //system.debug('response.get(is_deleted) -> ' + response.get('is_deleted'));
        if(response.get('metadata') != null){
            List<FUA_Applicant_Document__c> docs = [select Id from FUA_Applicant_Document__c where path_lower__c=:(String.valueOf(response.get('path_lower'))) limit 1];
            if(docs.size() > 0){
                system.debug('docs -> ' + docs[0].Id);
                delete docs;
            }
        }
        return resp;
    }
  
    
  // This function is used to get he shared link of the data from Dropbox.
    
    public static String getLink(String path_lower){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropboxapi.com/2/sharing/create_shared_link');
        req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
        req.setHeader('Content-Type','application/json');
        system.debug('path_lower  -- > ' +path_lower); 
        String Body ='{"path": "';
               Body = Body + path_lower;
               Body = Body + '", "short_url":false}';
        system.debug('Body  -- > ' +Body);              
        req.setbody(Body);
        req.setMethod('POST');
        req.setTimeout(60000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        string jsonResponse = res.getBody();
        system.debug('Response ->' + jsonResponse);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        return (String)response.get('url');
    }
    
    /**
     * This function is used save the data and exit the application.
    */
    public PageReference SaveExit(){
        return new PageReference('/secur/logout.jsp');
    }
    
    
    /**
     * This function is used to get the Application Documents called from RemoteAction method from Javascript.
    */
    @RemoteAction
    public static string getDocs(String Id){
        return JSON.serialize([SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :Id]);
    }
    
    
}