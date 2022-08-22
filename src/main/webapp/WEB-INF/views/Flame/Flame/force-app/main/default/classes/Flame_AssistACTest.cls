@isTest
public class Flame_AssistACTest {
    @testSetup 
    static void setup(){
        
        Community_Assist__c academicServices = new Community_Assist__c();
        academicServices.Tab_Type__c = 'Assist';
        academicServices.Record_Type__c = 'Academic Services';
        academicServices.Field_Set_API_Name__c = 'Academic_Services';
        academicServices.Name = 'Academic Services';
        insert academicServices;
        
        Community_Assist__c programOffice = new Community_Assist__c();
        programOffice.Tab_Type__c = 'Assist';
        programOffice.Record_Type__c = 'Faculty Services';
        programOffice.Field_Set_API_Name__c = 'Faculty_Services';
        programOffice.Name = 'Program Office Services';
        insert programOffice;
        
        Community_Assist__c travelRequest = new Community_Assist__c();
        travelRequest.Tab_Type__c = 'Assist';
        travelRequest.Record_Type__c = 'Travel';
        travelRequest.Field_Set_API_Name__c = 'Travel_Request';
        travelRequest.Name = 'Travel Request';
        insert travelRequest;
        
        Community_Assist__c helpDesk = new Community_Assist__c();
        helpDesk.Tab_Type__c = 'Assist';
        helpDesk.Record_Type__c = 'Help Desk';
        helpDesk.Field_Set_API_Name__c = 'Help_Desk_Services';
        helpDesk.Name = 'Help Desk Services';
        insert helpDesk;
        
        Community_Assist__c requestAssistanc = new Community_Assist__c();
        requestAssistanc.Tab_Type__c = 'Assist';
        requestAssistanc.Record_Type__c = 'Help Desk';
        requestAssistanc.Field_Set_API_Name__c = 'Request_Assistance';
        requestAssistanc.Name = 'Request & Assistance';
        insert requestAssistanc;
        
        Community_Assist__c nightout = new Community_Assist__c();
        nightout.Tab_Type__c = 'Assist';
        nightout.Record_Type__c = 'Nightout Request';
        nightout.Field_Set_API_Name__c = 'Night_Out_Request';
        nightout.Name = 'Night Out Request';
        insert nightout;
        
        Community_Assist__c requisition = new Community_Assist__c();
        requisition.Tab_Type__c = 'Assist';
        requisition.Record_Type__c = 'Requisition';
        requisition.Field_Set_API_Name__c = 'Requisition_Request';
        requisition.Name = 'Requisition';
        insert requisition;
        
        Community_Assist__c suggestions = new Community_Assist__c();
        suggestions.Tab_Type__c = 'Assist';
        suggestions.Record_Type__c = 'Help Desk';
        suggestions.Field_Set_API_Name__c = 'Suggestions';
        suggestions.Name = 'Suggestions';
        insert suggestions;
        
    }
    @isTest
    static void testInit(){    
        User objUser = new User();
        Id pId, cId;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'System Administrator'];
            User portUser = new User();
            //portUser.UserRoleId = portalRole.Id;    
            portUser.ProfileId = studPro.Id;
            portUser.Community_Contact_ID__c = cId;
            portUser.Username = 'flame@test.com';
            portUser.Alias = 'ftest';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            //portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
            objUser = portUser;        
        }
        
        System.runAs(objUser){
            Test.startTest();
            //ApexPages.currentPage().getParameters().put('atype', 'service');
            Flame_AssistAC flameAssis = new Flame_AssistAC();
			flameAssis.showCaseRecord();			
			List<SelectOption> assistOpt = flameAssis.getAssistType();
			flameAssis.actionSupportOCMethod();
			flameAssis.addNewItemList();
			flameAssis.removeNewItemList();
			flameAssis.checkTicketStatus();
			flameAssis.diningMenuStatus();
            flameAssis.guestInfoActionSupportMethod();
			flameAssis.saveCase();
            Test.stopTest();  
        }
    }
	
	@isTest
    static void showCaseTest(){
        User objUser = new User();
        Id pId, cId;
		Contact con = new Contact();
		con.LastName = 'portLast';
		insert con;
		cId = con.Id;
		
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
		
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'System Administrator'];
            User portUser = new User();
            //portUser.UserRoleId = portalRole.Id;    
            portUser.ProfileId = studPro.Id;
            portUser.Community_Contact_ID__c = cId;
            portUser.Username = 'flame@test.com';
            portUser.Alias = 'ftest';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            //portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
            objUser = portUser;        
        }
		
		//-- add attachment to controller
		Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        
		Case newCase = new Case();
		newCase.RecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Academic Services').getRecordTypeId();
		newCase.Origin ='Community Portal'; 
        newCase.ContactId = cId;
		newCase.Community_Assist_ID__c = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Academic Services'].id;		
		newCase.HelpDesk_Team__c = 'Student Service';
		newCase.Type = 'Request';
		newCase.HLP_Assist_Type__c = 'Academic Services';
		insert newCase;
		
		List<Case> caseList = [Select id from Case where id=: newCase.id];
		System.debug('New Case : '+caseList);
		System.assertEquals(1, caseList.size());
        
        System.runAs(objUser){        
        Test.startTest();
        Flame_AssistAC flameAssis = new Flame_AssistAC();
        
		//--Academic Services
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Academic Services'].id;  
		flameAssis.actionSupportOCMethod();
		flameAssis.objAttach = attach;
        flameAssis.saveCase();
		flameAssis.checkTicketStatus();
		
		//--Program Office Services
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Program Office Services'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//--Travel Request
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Travel Request'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//-Help Desk Services
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Help Desk Services'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//--Request & Assistance
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Request & Assistance'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//--Night Out Request
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Night Out Request'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//--Requisition
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Requisition'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		//-- Suggestions
		flameAssis.selectedAssist = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' AND Name='Suggestions'].id;  
		flameAssis.actionSupportOCMethod();
        flameAssis.saveCase();
		
		ApexPages.currentPage().getParameters().put('tid',caseList[0].id);
        flameAssis.checkTicketStatus();
		
		ApexPages.currentPage().getParameters().put('crcdId',caseList[0].id);
        flameAssis.showCaseRecord();
        Test.stopTest();
        }
    }
	
	@isTest
    static void diningMenuTest(){
        User objUser = new User();
        Id pId, cId;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'System Administrator'];
            User portUser = new User();
            //portUser.UserRoleId = portalRole.Id;    
            portUser.ProfileId = studPro.Id;
            portUser.Community_Contact_ID__c = cId;
            portUser.Username = 'flame@test.com';
            portUser.Alias = 'ftest';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            //portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
            objUser = portUser;        
        }
        
        Dining_Menu__c dm = new Dining_Menu__c();
        dm.Name = 'MONDAY';
        dm.BreakFast__c = 'WHEAT FLAKES';
        dm.Dinner__c = 'SWEET CORN SOUP';
        Date dt = date.today();
        dm.Date__c = dt;
        insert dm;
        
        Dining_Menu__c dm1 = new Dining_Menu__c();
        dm1.Name = 'MONDAY';
        dm1.BreakFast__c = 'WHEAT FLAKES';
        dm1.Dinner__c = 'SWEET CORN SOUP';
        Date dt1 = date.today();
        dm1.Date__c = dt1.addDays(1);
        insert dm1;
        
        Dining_Menu__c dm2 = new Dining_Menu__c();
        dm2.Name = 'Saturday';
        dm2.BreakFast__c = 'WHEAT FLAKES';
        dm2.Dinner__c = 'SWEET CORN SOUP';
        Date dt2 = date.today();
        dm2.Date__c = dt2.addDays(1);
        insert dm2;
        
        Dining_Menu__c dm3 = new Dining_Menu__c();
        dm3.Name = 'Sunday';
        dm3.BreakFast__c = 'WHEAT FLAKES';
        dm3.Dinner__c = 'SWEET CORN SOUP';
        Date dt3 = date.today();
        dm3.Date__c = dt3.addDays(-2);
        insert dm3;
        
        Dining_Menu__c dm4 = new Dining_Menu__c();
        dm4.Name = 'Sunday';
        dm4.BreakFast__c = 'WHEAT FLAKES';
        dm4.Dinner__c = 'SWEET CORN SOUP';
        Date dt4 = date.today();
        dm4.Date__c = dt4.addDays(2);
        insert dm4;
        
        System.runAs(objUser){
            Test.startTest();            
            Flame_AssistAC flameAssis = new Flame_AssistAC();
            flameAssis.selectedAssist = 'Travel Request';            
            flameAssis.diningMenuStatus();
            Test.stopTest();  
        }        
    }
}