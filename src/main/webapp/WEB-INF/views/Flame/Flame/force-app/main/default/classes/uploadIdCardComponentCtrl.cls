public class uploadIdCardComponentCtrl {
    
    public  static String token;
    
    /*To generate Access token Method*/
    @AuraEnabled
    public static String getAccessToken(){
        
        List<Id_Card_RestAPI__mdt> apiParams = [SELECT UserName__c,Password__c,Consumer_Key__c,Consumer_Secret__c,EndPoint__c from Id_Card_RestAPI__mdt];
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String body = 'grant_type=password&client_id='+apiParams[0].Consumer_Key__c+'&client_secret='+apiParams[0].Consumer_Secret__c+'&username='+apiParams[0].UserName__c+'&password='+apiParams[0].Password__c;
        request.setEndpoint('https://test.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody(body);
        
        HttpResponse response = http.send(request);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        if(response.getStatusCode() == 200){
            System.debug('results ' + response.getBody());
            token = (String)results.get('access_token');
            System.debug('token-->'+token);
            return token;
        }else{
            throw new CalloutException('FAILED TO GET TOKEN');
        } 
    }
    
    @AuraEnabled
    public static String getSFBaseURL(){
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        return sfdcBaseURL;
    }
    
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContactRecords(String ContactIds)
    {
        List<Id> contactRecordIds = ContactIds.split(',');
        List<Contact> contactLst = [SELECT Id, Name,Blood_Group__c,Student_Batch__c,CVUE_Student_Number__c FROM CONTACT where Id IN:contactRecordIds order by Contact_Photo__c asc];
        
        return contactLst;
    }

   /* @AuraEnabled                            
    public static Id saveTheChunkFile(Id parentId, String fileName, String base64Data, String contentType, String fileId){
        system.debug('fileName:'+fileName);
        system.debug('contentType:'+contentType);
        system.debug('fileId:'+fileId);
        system.debug('parentId:'+parentId);

        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        if ( String.isBlank(fileId) ) {
            
            //fileId = saveFileData(parentId, fileName, base64Data);
            //fileId = saveFileWithApi(parentId, fileName, base64Data);
        } else {
            //appendToFile(fileId, base64Data);
        }

        return Id.valueOf(fileId);
    }
    
    
    @AuraEnabled                            
    public static Id saveFileWithApi(Id parentId, String fileName, String base64Data){
        
        String token = getAccessToken();
        system.debug('saveFileWithApi:'+fileName);
        system.debug('parentId:'+parentId);
        system.debug('token:::'+token);
        
        	base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
		
            Http h = new Http();    
            HttpRequest req = new HttpRequest();
        	req.setTimeout(120000);
            req.setHeader('Authorization', 'Bearer ' +token);
        	req.setHeader('Content-Type', 'application/json;charset=UTF-8');  
            String body = '{'+'"Title":"'+fileName+'","PathOnClient":"/'+fileName+'","VersionData":"'+base64Data+'","IsMajorVersion":false}';
        	system.debug('body:::'+body);
            req.setEndpoint('https://flame--techila.my.salesforce.com/services/data/v54.0/sobjects/ContentVersion');
            req.setMethod('POST');
            req.setBody(body);
            HttpResponse res = h.send(req);
        	system.debug('saveFileData contentToInsert'+res.getStatusCode());
        
        /*if(res.getStatusCode() == 200){
			Map<String, Object> jsonMap1 = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        	String contentVId = (String)jsonMap1.get('id');
            
            ContentVersion contentToInsert = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVId];  
            system.debug('saveFileData contentToInsert'+contentToInsert);
            ContentDocumentLink cl = new ContentDocumentLink();
            cl.ContentDocumentId = contentToInsert.ContentDocumentId;
            cl.LinkedEntityId = parentId; 
            cl.ShareType = 'V';
            cl.Visibility = 'AllUsers';
            insert cl;
        } 
        return Id.valueOf(parentId);
    }*/

   /* @AuraEnabled
     public static Id saveFileData(Id recordId, String fileName, String base64Data )  {
        
        Datetime systemDate = System.now();
        String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        List<ContentDocumentLink> contentDocumentList = [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: recordId order by ContentDocument.CreatedDate desc limit 1];
        system.debug('contentDocumentList size:'+contentDocumentList.size());
		if(contentDocumentList.size()>0){
            For(ContentDocumentLink contd :contentDocumentList){
                ContentVersion contentVersionList1 = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE ContentDocumentId =: contd.ContentDocumentId limit 1];
                system.debug('contentVersionList1:'+contentVersionList1);
                String newName = contentVersionList1.Title;
               	contentVersionList1.Title = newName+'_Old_'+newTimeDate;
                System.debug('Old File Name::'+newName+'_Old_'+newTimeDate);
                Update contentVersionList1;
                system.debug('Update contentVersionList1:'+contentVersionList1);
            }
        }
        
        system.debug('saveFileData method');
        system.debug('saveFileData fileName'+fileName);
        ContentVersion contentToInsert =new ContentVersion(); 
        contentToInsert.Title =fileName; 
        contentToInsert.VersionData=EncodingUtil.base64Decode(base64Data);
        contentToInsert.PathOnClient='/' + fileName ;
        contentToInsert.IsMajorVersion = false;
        insert contentToInsert; 
        
        system.debug('saveFileData contentToInsert'+contentToInsert.id);
        
        
        contentToInsert = [select id, ContentDocumentId from ContentVersion WHERE Id =: contentToInsert.Id];
        system.debug('saveFileData contentToInsert'+contentToInsert);
        ContentDocumentLink cl = new ContentDocumentLink();
        cl.ContentDocumentId = contentToInsert.ContentDocumentId;
        cl.LinkedEntityId = recordId; 
        cl.ShareType = 'V';
        cl.Visibility = 'AllUsers';
        insert cl;
        
		system.debug('saveFileData cl'+cl.Id);        
        return contentToInsert.id;

    } 


    @AuraEnabled
    public static void appendToFile(Id contentDocumentId, String base64Data) {
        //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        system.debug('appendToFile contentDocumentId'+contentDocumentId);       
        ContentVersion versionData = [
            SELECT Id, VersionData,ContentDocumentId
            FROM ContentVersion
            WHERE Id = :contentDocumentId
        ];
		
        system.debug('appendToFile versionData'+versionData);    
        
        String existingBody     = EncodingUtil.base64Encode(versionData.VersionData);
        versionData.VersionData = EncodingUtil.base64Decode(existingBody + base64Data); 
		
        update versionData;
    } */

    /* @AuraEnabled
    public static void changeFileProps(String conId, String cvId){
        Id cdId;
        Id contactId = conId;
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where id =: cvId];
        
        for(ContentVersion cv : cvList){
            cdId = cv.ContentDocumentId;
        } 
        
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = cdId;
        cDe.LinkedEntityId = conId; 
        cDe.ShareType = 'V'; 
        cDe.Visibility = 'AllUsers';
        insert cDe;
        
        //List<ContentDocumentLink> cvList1 = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where ContentDocumentId =: cdId];
            //system.debug('cdId::'+cdId);
            //system.debug('ContacID::'+cvList1[0].LinkedEntityId);
            //system.debug('cvList1:::'+cvList1.size());
            
           /* String newName = cv.Title;
            System.debug('newName'+cv.Title);
            Integer intIndex = newName.indexOf('.');
            Integer lasCharLen = newName.length()-intIndex;
            //System.debug('New length'+newName.substring(0,newName.length()-lasCharLen));
            cv.Title = newName.substring(0,newName.length()-lasCharLen);
            //cv.OwnerId = contactId;
            Update cv; */
        
        /*Datetime systemDate = System.now();
        String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        List<ContentDocumentLink> contentDocumentList = [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: conId order by ContentDocument.CreatedDate desc limit 1 offset 1];
        system.debug('contentDocumentList size:'+contentDocumentList.size());
		if(contentDocumentList.size()>0){
            For(ContentDocumentLink contd :contentDocumentList){
                ContentVersion contentVersionList1 = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE ContentDocumentId =: contd.ContentDocumentId limit 1];
                system.debug('contentVersionList1:'+contentVersionList1);
                String newName = contentVersionList1.Title;
               	contentVersionList1.Title = newName+'_Old_'+newTimeDate;
                System.debug('Old File Name::'+newName+'_Old_'+newTimeDate);
                Update contentVersionList1;
                system.debug('Update contentVersionList1:'+contentVersionList1);
            }
        } 
        
        
    } */

    @AuraEnabled
    public static void changeFileProps2(List<Map<String, String>> arrayData){
        
        System.debug(arrayData[0].get('cvId'));
        System.debug(arrayData[0].get('contactId'));
        //System.debug('Length' + arrayData.size());
		System.debug('conIdToCVIdList' + arrayData);
        Datetime systemDate = System.now();
        String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        
        List<String> contentIds = new List<String>();
        List<String> contactIds = new List<String>();
        List<ContentDocumentLink> contentDocLinks = new List<ContentDocumentLink>();
        List<ContentDocumentLink> contentDocumentList = new List<ContentDocumentLink>();
        For(integer i= 0; i<arrayData.size(); i++){
            contentIds.add(arrayData[i].get('cvId'));
            contactIds.add(arrayData[i].get('contactId'));
            
            ContentVersion cvList = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where id =: arrayData[i].get('cvId')];
            ContentDocumentLink cDe = new ContentDocumentLink();
                cDe.ContentDocumentId = cvList.ContentDocumentId;
                cDe.LinkedEntityId = arrayData[i].get('contactId'); 
                cDe.ShareType = 'V'; 
                cDe.Visibility = 'AllUsers';
                contentDocLinks.add(cDe);
         }
        
        if(contentDocLinks.size()>0){
            Insert contentDocLinks;
        }
        
        List<ContentVersion> cvLists = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where id IN :contentIds];
        
        if(cvLists.size()>0){
            For(ContentVersion contV :cvLists){
                System.debug('contV'+contV);
                String newName = contV.Title;
                System.debug('newName'+contV.Title);
                Integer intIndex = newName.indexOf('.');
                if(intIndex>0){
                    Integer lasCharLen = newName.length()-intIndex;
                    contV.Title = newName.substring(0,newName.length()-lasCharLen);
                 } 
            }
        }
        if(cvLists.size()>0){
            update cvLists;
        }
        
        
        
            /*if(contentDocLinks.size()>0){
                For(ContentDocumentLink contd :contentDocLinks){
                    ContentVersion contentVersionList1 = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE ContentDocumentId =: contd.ContentDocumentId limit 2];
                    system.debug('contentVersionList1:'+contentVersionList1);
                    String newName1 = contentVersionList1.Title;
                    contentVersionList1.Title = newName1+'_Old_'+newTimeDate;
                    System.debug('Old File Name::'+newName1+'_Old_'+newTimeDate);
                    Update contentVersionList1;
                    system.debug('Update contentVersionList1:'+contentVersionList1);
                }
            } */
        
    }
}