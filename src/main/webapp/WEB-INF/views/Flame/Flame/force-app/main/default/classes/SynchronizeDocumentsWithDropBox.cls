public class SynchronizeDocumentsWithDropBox {

    public PageReference SynchronizeDocuments(){
        String applicationId = ApexPages.currentPage().getParameters().get('Id');
        Application__c application = [select Id,Contact__c,Application_Reference_ID__c from Application__c where Id = : applicationId];
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropbox.com/1/metadata/auto'+ Label.FLAME_Document_Structure + application.Application_Reference_ID__c);
        req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
        req.setMethod('GET');
        req.setTimeout(60000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        string jsonResponse = res.getBody();
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        List<Object> data = (List<Object>) response.get('contents');
        
        Map<String,FUA_Applicant_Document__c> allDocuments = new Map<String,FUA_Applicant_Document__c>();
        
        for(FUA_Applicant_Document__c appDoc : [select id,Path__c from FUA_Applicant_Document__c where Application__c = : applicationId]){
            allDocuments.put(appDoc.Path__c,appDoc);
        }
        
        List<FUA_Applicant_Document__c> documents = new List<FUA_Applicant_Document__c>();
        
        for(Object obj : data){
           Map<String, Object> temp = (Map<String, Object>) obj; 
            String path = (String) temp.get('path');
            String url = FUA_UploadDocuments.getLink(path);
            if(path != null){    
                if(!allDocuments.containsKey(path)){
                    String[] splitter = path.split(application.Application_Reference_ID__c);
                    system.debug('splitter -> ' + splitter + ' ' +splitter.size());
                    if(splitter.size() > 1){
                        String uploadedFileName = splitter[1];
                        FUA_Applicant_Document__c doc = new FUA_Applicant_Document__c();
                        doc.Name = uploadedFileName.substring(1,uploadedFileName.length());
                        doc.Application__c = application.id;
                        doc.Description__c = 'Uploaded from Dropbox, please update the description and document type accordingly';
                        doc.Document_Link__c = url;
                        doc.Document_Type__c = 'Other Documents';
                        doc.Path__c = path;
                        documents.add(doc);
                    }
                }
            }
        }
        
        if(documents.size() > 0){
            try{
                upsert documents Document_Link__c;
            }
            catch(Exception e){
            }
        }
        
        return new PageReference('/'+applicationId);
    }
}