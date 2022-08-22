public class CreateApplicationPDFAttachmnet_1 {

    public static void CreateApplicationPDF(Application__c apps){
        
            PageReference applicationPDF = Page.ApplicationPDF_1;
            List<Attachment> attachOld = new List<Attachment>();
            
            attachOld = [select id from Attachment where ParentId = :apps.id];
            System.debug('apps>>>>>>>>>>>>>>>>>>>>>'+apps);
            String appReferenceNumber = apps.Application_Reference_ID__c;
            Blob blobFormPDF = null;
            try {                              
                if (Test.IsRunningTest()){
                    blobFormPDF=Blob.valueOf('UNIT.TEST');
                }
                else{
                    blobFormPDF = applicationPDF.getContent();  
                }
               
            
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/ApplicationPDF_AdmitCard_Documents/' +appReferenceNumber +'.pdf';
            String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(blobFormPDF);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            string resp;
            if(!Test.isRunningTest())
            {
            HttpResponse res = h.send(req);
            System.debug('vcr---response---'+res);
            resp = res.getBody();
            }else{
             resp = 'temp';
            }
            
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            String url = FUA_UploadDocuments.getLink(Responsepath);
            String[] splitter = path_lower.split(appReferenceNumber+'/');
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
                if(attachOld.size() > 0){
                    if(!Test.isRunningTest()){
                       // delete attachOld;
                    }
                }
            } catch (VisualforceException e) {
              system.debug(e.getMessage());
            } 
    }
}