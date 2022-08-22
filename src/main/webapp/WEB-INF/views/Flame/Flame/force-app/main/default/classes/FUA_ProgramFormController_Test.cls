@isTest
public class FUA_ProgramFormController_Test {
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
       FUA_ProgramFormController prog = new FUA_ProgramFormController(); 
            prog.program = 'Undergraduate (B.A.,BBA,B.Sc.)';
            prog.round = 'Early Decision Cycle (12th - 13th Dec 2015)';
            prog.choices='jhhi';
            prog.compExam=TRUE;
            prog.selectedExam='dfghdf';
            prog.oldPassword = 'dsdsdfd433355';
            prog.newPassword = 'dsdsdfd43';
            prog.verifyNewPassword = 'dsdsdfd43';
            prog.round = 'Regular Cycle III (26th - 27th May 2016)';
            prog.center = 'Ahmedabad';
            prog.AddCompetitionExams();
            prog.RemoveCompetitionExams();
            prog.addHealth();
            prog.clearList();
            prog.FindRounds();
            prog.FindCenters();
           // prog.saveAllData();
            prog.getPrograms();
           
           
            PageReference pref = Page.PersonalDetails_1;       
            Test.setCurrentPage(pref);
          
            
          
                prog.findcontactController();
           
          
                prog.findcontactController();
           
        
                prog.findcontactController();
           
        
        Test.stopTest();  
        }
        
    }
    
  

    }