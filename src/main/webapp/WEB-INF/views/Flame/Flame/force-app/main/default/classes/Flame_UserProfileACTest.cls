@isTest
public class Flame_UserProfileACTest {
    
    @testSetup
    static void setup(){
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contact con = new Contact(lastName='Test Contact',AccountId=acc.id);
        insert con;
        String name = '456213_Abhinav Student_Photograph.JPG'; 
        ContentVersion cv = New ContentVersion();
        cv.PathOnClient = 'test';
        cv.Title = name;
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        
        ContentVersion tempContentVersion= [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        
        ContentDocumentLink objCDL = new ContentDocumentLink(); 
        objCDL.ContentDocumentId = tempContentVersion.ContentDocumentId;
        objCDL.LinkedEntityId = con.Id;
        objCDL.ShareType = 'I';
        insert objCDL;        
    }
    
    @isTest
    public Static void profile(){
        Contact con = [select Id, Name from Contact limit 1];
        
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'System Administrator'];
            User portUser = new User();   
            portUser.ProfileId = studPro.Id;
            portUser.Community_Contact_ID__c = con.Id;
            portUser.Username = 'flame@test.com';
            portUser.Alias = 'ftest';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.CommunityNickname = 'tuser';
            insert portUser;

        
        List<Contact> conList = [Select id, Name from contact Where id =: con.id];
        System.assertEquals(conList.size(),1);
        String name = '456213_Abhinav Student_Photograph.JPG'; 
        ContentVersion cv = New ContentVersion();
        cv.PathOnClient = 'test';
        cv.Title = name;
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
        String data = '/9j/4AAQSkZJRgABAQAAAQABAAD/4QDARXhpZgAASUkqAAgAAAACABABAgA2x';
        
        System.runAs(portUser){
            Test.startTest();
            Flame_UserProfileAC up = new Flame_UserProfileAC();
            up.file = cv;
            up.uploadProfileImage();
            Flame_UserProfileAC.saveImage(name, data, con.Id);
            up.fillProjectTasks();
            up.getItemsList();
            up.enterInputMode();
            up.exitInputMode();
            up.ShowPopup();
            up.ClosePopup();
            Test.stopTest();
        } 
    }
}