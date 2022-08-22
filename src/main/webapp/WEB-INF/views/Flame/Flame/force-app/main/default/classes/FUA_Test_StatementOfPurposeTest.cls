@isTest
private class FUA_Test_StatementOfPurposeTest {  
  
    public static void createTestData(){
        Account account = new Account();
        account.Name = 'FLAME 2016-17 Admissions';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        
        contact.Email =  'rohit63419FLAMETEST@gmail.com';        
        insert contact;
        
        FlameUniversitSettings__c data = new FlameUniversitSettings__c();
        data.Name = 'Default';
        data.AccountName__c = 'FLAME 2016-17 Admissions';
        insert data;
        
        Contact contact1 = new Contact();
        contact1.AccountId = account.Id;
        contact1.FirstName = 'Testing';
        contact1.LastName = 'Extentia';
        contact1.Email =  'rmextentia111132322@gmail.com';
        insert contact1;
        
        Profile prof = [select id from profile WHERE Name='FLAME- Applicant Community'];
        
        User user = new User();
        user.firstName = 'test1';
        user.lastName = 'test2';
        user.profileId = prof.id;
        user.username = 'test@test.com';
        user.email = 'test@test.com';
        insert user;
        }
    
    private static testMethod void testContructor1(){
        
        User user = [select id, ContactId from User Limit 1 ];
        system.debug(user);
            System.runAs(user){
                
                Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
                Test.setMock(HttpCalloutMock.class, new MockHttpSyncResponseGenerator());
                System.Test.StartTest();
                    FUA_StatementOfPurpose_Controller SOP = new FUA_StatementOfPurpose_Controller();
                    SOP.StatementofPurpose = 'asdasdasdasda';
                    SOP.SaveExit = 'sdasdasdasd';
                    SOP.oldPassword = 'dsdsdfd433355';
                    SOP.newPassword = 'dsdsdfd43';
                    SOP.verifyNewPassword = 'dsdsdfd43';
                   // SOP.SaveExit();
                    SOP.Next();
                    SOP.SaveData();
                    
                   // Application__c app = [select id, Completed_Stages__c from Application__c limit 1];
                   // app.Completed_Stages__c = 'Admission Status';
                  //  update app;
                    SOP = new FUA_StatementOfPurpose_Controller();
                    SOP.SaveData();
                    
                   // app.Completed_Stages__c = null;
                   // update app;
                    SOP = new FUA_StatementOfPurpose_Controller();
                    SOP.SaveData();
                System.Test.StopTest();
                
            }
        
    }
}