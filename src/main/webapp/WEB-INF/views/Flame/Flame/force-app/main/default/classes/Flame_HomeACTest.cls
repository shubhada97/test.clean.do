@isTest
public class Flame_HomeACTest {
    static testMethod void testHomeAC(){
        
        Flame_Announcement__c flameAnn = new Flame_Announcement__c();
        flameAnn.Content__c = 'testAnnounce';
        flameAnn.Heading__c = 'announceHead';
        flameAnn.IsActive__c = true;
        flameAnn.Role__c = 'Student';
        insert flameAnn;      
        Flame_Announcement__c flameAnn1 = new Flame_Announcement__c();
        flameAnn1.Content__c = 'FLAME & students <> and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameAnn1.Heading__c = 'announceHead';
        flameAnn1.IsActive__c = true;
        flameAnn1.Role__c = 'Student';
        insert flameAnn1;
        
        Flame_News__c flameNew = new Flame_News__c();
        flameNew.Content__c = 'testNews';
        flameNew.Heading__c = 'newsHead';
        flameNew.IsActive__c = true;
        flameNew.Role__c = 'Student';
        insert flameNew;
        Flame_News__c flameNew1 = new Flame_News__c();
        flameNew1.Content__c = 'FLAME students and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameNew1.Heading__c = 'newsHead';
        flameNew1.IsActive__c = true;
        flameNew1.Role__c = 'Student';
        insert flameNew1;
        
        Flame_Event__c flameEvt = new Flame_Event__c();
        flameEvt.Content__c = 'testEvent';
        flameEvt.Heading__c = 'eventHead';
        flameEvt.IsActive__c = true;
        flameEvt.Role__c = 'Student';
        insert flameEvt;
        Flame_Event__c flameEvt1 = new Flame_Event__c();
        flameEvt1.Content__c = 'FLAME & students <> and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameEvt1.Heading__c = 'eventHead';
        flameEvt1.IsActive__c = true;
        flameEvt1.Role__c = 'Student';
        insert flameEvt1; 
        
        Test.startTest();
        Flame_HomeAC flameHome = new Flame_HomeAC();
        ApexPages.currentPage().getParameters().put('objectName', 'Flame_Announcement__c');
        ApexPages.currentPage().getParameters().put('recordId', 'flameAnn.Id');
        PageReference pageRef = flameHome.readMoreDetailPage();
        PageReference pageRef1 = flameHome.Viewallevents();
        PageReference pageRef2 = flameHome.ViewallNews();
        PageReference pageRef3 = flameHome.subnewAnnouncement();
        PageReference pageRef4 = flameHome.subnewEvents();
        PageReference pageRef5 = flameHome.subnewNews();
        Test.stopTest();
    }
    
    static testMethod void testHomeElse(){
        
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
        
        Flame_Announcement__c flameAnn = new Flame_Announcement__c();
        flameAnn.Content__c = 'testAnnounce';
        flameAnn.Heading__c = 'announceHead';
        flameAnn.IsActive__c = true;
        flameAnn.Role__c = 'Student';
        insert flameAnn;      
        Flame_Announcement__c flameAnn1 = new Flame_Announcement__c();
        flameAnn1.Content__c = 'FLAME students and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameAnn1.Heading__c = 'announceHead';
        flameAnn1.IsActive__c = true;
        flameAnn1.Role__c = 'Student';
        insert flameAnn1;
        
        Flame_News__c flameNew = new Flame_News__c();
        flameNew.Content__c = 'testNews';
        flameNew.Heading__c = 'newsHead';
        flameNew.IsActive__c = true;
        flameNew.Role__c = 'Student';
        insert flameNew;
        Flame_News__c flameNew1 = new Flame_News__c();
        flameNew1.Content__c = 'FLAME students and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameNew1.Heading__c = 'newsHead';
        flameNew1.IsActive__c = true;
        flameNew1.Role__c = 'Student';
        insert flameNew1;
        
        Flame_Event__c flameEvt = new Flame_Event__c();
        flameEvt.Content__c = 'testEvent';
        flameEvt.Heading__c = 'eventHead';
        flameEvt.IsActive__c = true;
        flameEvt.Role__c = 'Student';
        insert flameEvt;
        Flame_Event__c flameEvt1 = new Flame_Event__c();
        flameEvt1.Content__c = 'FLAME students and students from partner universities have a rewarding experience in their Study Abroad endeavors.'+
                                'We believe in promoting student exchange activities to help our students gain international exposure. Students can study'+
                                'for one semester in the partner universities and earn credits that contribute towards their degree and vice versa.';
        flameEvt1.Heading__c = 'eventHead';
        flameEvt1.IsActive__c = true;
        flameEvt1.Role__c = 'Student';
        insert flameEvt1;
        
        system.runAs(objUser){
        Test.startTest();
        Flame_HomeAC flameHome = new Flame_HomeAC();
        //ApexPages.currentPage().getParameters().put('objectName', 'Flame_Announcement__c');
        //ApexPages.currentPage().getParameters().put('recordId', 'flameAnn.Id');
        PageReference pageRef = flameHome.readMoreDetailPage();
        PageReference pageRef1 = flameHome.Viewallevents();
        PageReference pageRef2 = flameHome.ViewallNews();
        PageReference pageRef3 = flameHome.subnewAnnouncement();
        PageReference pageRef4 = flameHome.subnewEvents();
        PageReference pageRef5 = flameHome.subnewNews();
        Test.stopTest();  
        }
    }
}