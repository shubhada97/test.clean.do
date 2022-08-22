public without sharing class ShowFilesController {
    public User objUser {get;set;}
    public string strContId{get;set;}
    public Contact objContact;
    public list<ContentDocumentLink> lstofCDL{get;set;}
    public list<Attachment> lstofAttc {get;set;}
         
    public ShowFilesController()
    {
        lstofAttc  = new List<Attachment>();
        lstofCDL = new List<ContentDocumentLink>();
        objContact = new Contact();
        objUser = new User();
        objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];    
        if(objUser.ContactID != null){
            objContact = [SELECT Id,Name,RecordTypeId,RecordType.Name FROM Contact WHERE Id=:objUser.ContactId];
            strContId = objContact.Id;
        }
      // strContId = '0030p000001F3CvAAK'; 
        showFiles();
       
    }
         
    public void showFiles(){
        if(strContId != null){
            /*for(ContentDocumentLink objCDL:[SELECT Id, ContentDocumentId,ContentDocument.title, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId =: strContId]){
            if(objCDL.ContentDocument.title.contains('portal')){
            lstofCDL.add(objCDL);
            }*/

            for(Attachment objA:[SELECT Id, ParentId,ContentType, Name FROM Attachment where ParentId=: strContId]){
                 if(objA.Name.contains('Portal')){
                lstofAttc.add(objA);
                 }
            }
        }
    }
      
}