@isTest
private Class ContentVersionTriggerHandlerTest
{
    @isTest static void ContentDocumentLinkTriggerTest() {
        
        
        
        Contact con = new contact();
        con.lastName = 'test';
        Insert Con;
        
        // Create a ContentVersion
        ContentVersion ContentDoc = new ContentVersion();
        ContentDoc.Title = 'My Doc_Photograph';
        ContentDoc.ContentUrl= 'test.com';
        Insert ContentDoc;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :ContentDoc.Id];
        
        
        
        
        // Create a ContentDocumentLink
        ContentDocumentLink ContentDL = new ContentDocumentLink();
        ContentDL.ContentDocumentId = testcontent.contentdocumentid;
        ContentDL.LinkedEntityId = con.id;
        ContentDL.shareType ='I';
        Insert ContentDL;
        
        
        
        // Verify the share type is = i
        // Please query the record before assert
         //System.assertEquals(ContentDL.ShareType,'I');
        
        
    }
   
}