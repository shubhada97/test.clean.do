@isTest
public class FUL_HousingPreferencecontroller_Test {
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
    FUL_HousingPreferencecontroller obj01 = new FUL_HousingPreferencecontroller();
   // obj01.Con = cId;
  //  obj01.userID = portUser1.id;
    obj01.oldPassword = 'test data';
    obj01.newPassword = 'test data';
    obj01.verifyNewPassword = 'test data';
    obj01.app = new Application__c();
    obj01.selA = 'test data';
    obj01.selB = 'test data';
    obj01.selC = 'test data';
    obj01.selD = 'test data';
    obj01.selE = 'test data';
   // obj01.Savedatainhousingpreference();
    obj01.getselAOptns();
    obj01.getselBOptns();
     obj01.getselCOptns();
     obj01.getselDOptns();
     obj01.getselEOptns();
    // obj01.SaveExitinhousingpreference();
        
        Test.stopTest();  
        }
        
    }
    
  }