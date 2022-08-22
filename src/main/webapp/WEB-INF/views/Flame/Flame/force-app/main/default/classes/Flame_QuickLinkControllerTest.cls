@isTest
public class Flame_QuickLinkControllerTest {
    static testMethod void testQuickLink(){
        String roleStr = '';
        User objUser;
        Id pId;
        Id cId;
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'Student'];
            User portUser = new User();
            portUser.ProfileId = studPro.Id;
            portUser.Username = 'test2@test.com';
            portUser.Alias = 'test';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
        }        
        
        List<Resource__c> resList = new List<Resource__c>();
        Resource__c res1 = new Resource__c();
        res1.Category__c = 'Academic Resources';
        res1.Sub_Category__c = 'Forms';
        res1.Link_URL__c = 'www.google.com';
        res1.Role__c = 'Student';
        res1.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Links').getRecordTypeId();
        resList.add(res1);
        
        Resource__c res2 = new Resource__c();
        res2.Category__c = 'Academic Resources';
        res2.Sub_Category__c = 'Forms';
        res2.Role__c = 'Student';
        res2.Link_URL__c = 'www.google.com';
        res2.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Links').getRecordTypeId();
        resList.add(res2);
        
        Resource__c res3 = new Resource__c();
        res3.Category__c = 'Academic Resources';
        res3.Sub_Category__c = 'Forms';
        res3.Link_URL__c = 'www.salesforce.com';
        res3.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Links').getRecordTypeId();
        resList.add(res3);
        
        objUser = [SELECT ID, Profile.Name, profileId FROM User WHERE Id =:pId LIMIT 1];
        roleStr = objUser.Profile.Name;
        system.debug('roleStr-->'+roleStr);

        Apexpages.currentPage().getParameters().put('input1', 'Academic Resources');
        Test.startTest();
        insert resList;
        Flame_QuickLinkController fqlc = new Flame_QuickLinkController();
        fqlc.roleString = roleStr;
        fqlc.Header = 'Academic Resources';
        fqlc.quickLinkcategry();
        Test.stopTest();
        //list<Resource__c> rc = fqlc.QuickLinkWrapperList[1];
        system.assertEquals(res2.Link_URL__c, fqlc.QuickLinkWrapperList[1].objRes.Link_URL__c);
    }
}