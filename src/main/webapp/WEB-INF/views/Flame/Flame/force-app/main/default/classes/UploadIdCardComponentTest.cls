@isTest
public class UploadIdCardComponentTest {
	
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
    public Static void unitTest(){
        
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
        insert cv;
        String stringIds = con.Id+',';
        
        List<Map<String, String>> UIoptions = new List <Map<String, String>>();
        Map<String, String> studDept=new Map<String, String>();  
		studDept.put('cvId',cv.Id);  
       	studDept.put('contactId',con.id);
        system.debug('studDept'+studDept);
        UIoptions.add(studDept);
        //System.runAs(portUser){
            Test.startTest();
                uploadIdCardComponentCtrl.changeFileProps2(UIoptions);
                uploadIdCardComponentCtrl.getSFBaseURL();
                uploadIdCardComponentCtrl.getContactRecords(stringIds);
            Test.stopTest();
        //} 
    }
    
    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatus('OK');
            res.setStatusCode(200);
             res.setBody('{"properties":{"title": "Flame-RawEmployee"}}');
            return res;
        }
    }
    
    public static testmethod void testsample(){  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
		uploadIdCardComponentCtrl.getAccessToken();
        Test.stopTest();
    }
    
    public class fieldWrapper{
        public String cvId;
        public String contactId;
    }
}