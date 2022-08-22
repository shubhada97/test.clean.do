public class CreateApplicationPDFAttachmnet {
 Public String staticContactid{get;set;}
    Public Static String FincalContactId;
    Public String ContactId {get{if(ContactId==null) ContactId=StaticContactId;return ContactId;}set;}
    Public Static String StaticContactId{get{return StaticContactId;}set;}
     Public Static String StaticContactId1{get;set;}
     public String staticconid {get;set{if(staticContactid==null)staticContactid=staticconid;else staticContactid=staticContactid;}}
     
     
    Public void InvokeCalls() {
      String ContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
      if(Flame_Community.StaticContactId == null) Flame_Community.StaticContactId = StaticContactId;
       if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
      //  Flame_Community flame = new Flame_Community();
      if(staticconid==null)staticconid=Flame_Community.StaticContactId; 
      if(staticContactid==null)staticContactid=Flame_Community.StaticContactId; 
      SYSTEM.DEBUG('vcr---StaticContactId---ContactId---'+StaticContactId+'---'+ContactId);
     }
     
    public static void CreateApplicationPDF(Application__c apps){
        
            //PageReference applicationPDF = Page.ApplicationPDF;
            PageReference applicationPDF = new PageReference('/apex/ApplicationPDF');

            List<Attachment> attachOld = new List<Attachment>();
            System.debug('appsHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'+apps); 
            System.debug('apps>>>>>>>>>>>>>>>>>>>>>>>>>>>>1'+apps); 
            attachOld = [select id from Attachment where ParentId = :apps.id];
            String appReferenceNumber = apps.Application_Reference_ID__c;
            Blob blobFormPDF = null;
            try {                              
                if (Test.isRunningTest()){
                    blobFormPDF=Blob.valueOf('UNIT.TEST');
                }
                else{
                    blobFormPDF = applicationPDF.getContent();  
                }
                System.debug('vcr--APPS---ID--111'+APPS.id);
                HttpRequest req = new HttpRequest();
                String path = Label.FLAME_Document_Structure + appReferenceNumber + '/ApplicationPDF_AdmitCard_Documents/' +appReferenceNumber +'.pdf';
                req.setEndpoint('https://content.dropboxapi.com/1/files_put/auto'+path);
                req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
                req.setBodyAsBlob(blobFormPDF);
                req.setMethod('PUT');
                req.setTimeout(60000);
                Http h = new Http();
                HttpResponse res = h.send(req);
                System.debug('vcr---response---'+res);
                string resp = res.getBody();
                Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
                String Responsepath = (String) response.get('path');
                String url = FUA_UploadDocuments.getLink(Responsepath);
                //url = url.replaceAll('dl=0','dl=1'); This is required if user wants to download the file directly.
                String[] splitter = path.split(appReferenceNumber+'/');
                String uploadedFileName = splitter[1];
                
                url = url.replaceAll('dl=0','dl=1');
                apps.ApplicationPDFLink__c = url;
                update apps;
                
                Attachment attach = new Attachment();
                attach.ParentId = apps.id;
                system.debug('Refid -> ' + JSON.serialize(apps));
                attach.Name = apps.Application_Reference_ID__c + '.pdf';
                attach.Body = blobFormPDF;
                upsert attach;
                System.debug('vcr--APPS---ID---222'+APPS.id);
                System.debug('vcr--attachment---ID'+attach.id);
                if(attachOld.size() > 0){
                    if(!Test.isRunningTest()){
                        //delete attachOld;
                    }
                }
            } catch (VisualforceException e) {
              system.debug(e.getMessage());
            } 
    }
     
}