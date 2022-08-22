@isTest
public class FUA_UploadDocuments2_Test {
    static testMethod void myUnitTest() {
        Profile p = [
            select Id
            from Profile
            where Name = 'System Administrator'
        ];

      User objUser;
        Id pId;
        Id cId;

        User u = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName='1512434@dfe1.COM'
        );
         Application__c app = new Application__c (
           Contact__c  = cId
       
       );

        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'FLAME- Applicant Community'];
            User portUser1 = new User();
            portUser1.ProfileId = studPro.Id;
            portUser1.Username = 'test1@test.com';
            portUser1.Alias = 'test';
            portUser1.Email = 't@test.com';
            portUser1.FirstName = 'fname';
            portUser1.LastName = 'lname';
            portUser1.EmailEncodingKey = 'UTF-8';
            portUser1.LocaleSidKey = 'en_US';
            portUser1.LanguageLocaleKey = 'en_US';
            portUser1.TimeZoneSidKey = 'America/Los_Angeles';
            portUser1.ContactId = cId;
            portUser1.CommunityNickname = 'tuser';
            insert portUser1;
            pId = portUser1.Id;   
            objUser = portUser1;
        }
       
        system.runAs(objUser){
        Test.startTest();
        FUA_UploadDocuments2 flameHome = new FUA_UploadDocuments2();
            String data = 'testtesttesttest';
            flameHome.pageId = cid;
           
            flameHome.fileName = 'Test.jpg';
            flameHome.file = Blob.valueOf(data);
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
           // flameHome.UploadDoc();
           FUA_UploadDocuments2 upload = new FUA_UploadDocuments2();
           
            upload.fileName = 'Test.jpg';
            Test.setMock(HttpCalloutMock.class, new DeleteDataMockHttpResponseGenerator());
            FUA_UploadDocuments.DeleteData('Test/Test');
        
        Test.stopTest();  
        }
        
    }
    
  
     private class RestMock implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'your Json Response';
            
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
    }
    static testMethod void service_call() {
        
        Test.setMock(HttpCalloutMock.class, new RestMock());
        Test.startTest();

        

        Test.StopTest();


    }
      }