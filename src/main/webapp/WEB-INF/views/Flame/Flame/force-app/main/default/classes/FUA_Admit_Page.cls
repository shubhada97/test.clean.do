public with sharing class FUA_Admit_Page {
    public Application__c Adc{get;set;}
    public Admit_Card__c Getcard{get;set;}
    public User UserID{get;set;}
    public Contact Con{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
     public string url{get;set;}
    ApexPages.StandardController stdController;
    public FUA_Admit_Page(ApexPages.StandardController controller) {
    
    stdController = controller;
    Adc = new Application__c();
    if(!String.IsEmpty(UserInfo.getUserId())){     
            UserID=[Select Id,name,fullphotourl,ContactId from User where Id = :UserInfo.getUserId()];
          //  Con = [Select ID,Email From Contact Where ID =: UserID.ContactId];
            
        }
    try{
        Adc = [Select Id, name ,AdmitCardURL__c, Application_Reference_ID__c from Application__c where contact__c =:UserID.ContactID ];
        
        Getcard = [Select Id , Name, FUA_Broadcast_Admit_Card__c,Application__r.Name from Admit_Card__c where Application__c =:Adc.Id];
        system.debug('@@@@@@@@@@'+ Getcard.FUA_Broadcast_Admit_Card__c );
    }
    catch(Exception e){}
    }
    
    public String getHtmlText4() {
        return [Select Body From Document Where Name = 'BeforeBroadcastingAdmitCard'].Body.toString();
  }
    
  public String getHtmlText5() {
        return [Select Body From Document Where Name = 'AfterBroadcastingAdmitCard'].Body.toString();
  }
  
  Public Pagereference AdnitcardNext(){
  Pagereference nextPage= new PageReference('/apex/UploadDocuments_1');
  return nextPage;
  }
    
    public pageReference downloadAdmitCard(){
                
                try{
                    Blob blobFormPDF = null;
                    PageReference admitCard = Page.AdmitCard_1;
                    
                    if(!Test.isRunningTest()){
                        blobFormPDF = admitCard.getContent();  
                    }
                    else{
                        String data = 'testtesttesttest';
                        blobFormPDF = Blob.valueOf(data);
                    }
                    
                    String appReferenceNumber = Adc.Application_Reference_ID__c;
                    HttpRequest req = new HttpRequest();
                   
                    String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/ApplicationPDF_AdmitCard_Documents/' +appReferenceNumber +'_AdmitCard.pdf';
                    String Body ='{"path": "';
                    Body = Body + path_lower;
                    Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
                    req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
                    req.setHeader('Dropbox-API-Arg',Body);
                    req.setHeader('Content-Type','application/octet-stream');
 
                    req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
                    req.setBodyAsBlob(blobFormPDF);
                    
                    
                    
                    req.setMethod('POST');
                    req.setTimeout(60000);
                    Http h = new Http();
                    string resp;
                    if(!Test.isRunningTest()){
                    HttpResponse res = h.send(req);
                    resp = res.getBody();
                    System.debug(' ** resp ** ' +resp);
                    }else{
                    resp = '{"parent_shared_folder_id": "1223403804", "revision": 1901, "bytes": 25758, "thumb_exists": false, "rev": "76d48eba91c", "modified": "Thu, 15 Dec 2016 04:27:23 +0000", "root": "dropbox", "shareable": false, "mime_type": "application/pdf", "path": "/FLAME Student Documents/2016/Contacts/UGLE2017018647/ApplicationPDF_AdmitCard_Documents/UGLE2017018647_AdmitCard.pdf", "is_dir": false, "size": "25.2 KB", "modifier_uid": 567863178, "client_mtime": "Thu, 15 Dec 2016 04:27:23 +0000", "icon": "page_white_acrobat"}';
                    }
                    system.debug('test response --->'+resp);
                    Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
                    String Responsepath = (String) response.get('path_lower');
                    System.debug('Responsepath &&&&&&&&&&&&&&&&&&&&&&&' +Responsepath);
                    
                    url = FUA_UploadDocuments.getLink(Responsepath);
                    url = url.replaceAll('dl=0','dl=1'); //This is required if user wants to download the file directly.
                    String[] splitter = path_lower.split(appReferenceNumber+'/');
                    String uploadedFileName = splitter[1];
                    
                    Adc.AdmitCardURL__c = url;
                    update Adc;
                    
                             
                    Attachment attach = new Attachment();
                    attach.ParentId = Adc.id;
                    attach.Name = Adc.Application_Reference_ID__c + '.pdf';
                    attach.Body = blobFormPDF;
                    insert attach;
                    return new PageReference(url); 
                    
                    
                    
                    
                }
                catch(Exception e){
                   return null; 
                }
    } 
}