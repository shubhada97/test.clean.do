@isTest
public class Flame_ApprovalPageClassTest {
    //this class will be use to cover LeaveApplicationController for now
    
    @testSetup static void setup() { 
        Profile proffaculty = [select id from profile where name LIKE 'Faculty'];
        Profile profstaff = [select id from profile where name LIKE 'Staff'];
        
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        Id RecordTypeIdDebitLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Debit').getRecordTypeId();
        Id RecordTypeIdCreditLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();
        
        //Create Account
        Account accountObj = Flame_TestDataFactory.createAccount('Faculty Account',RecordTypeIdAccount);
        
        //Create Contact saheel
        Contact consuresh = Flame_TestDataFactory.createContact('Suresh','Kumar','Faculty',
                                                                accountObj.Id,'saheel@gmail.com',RecordTypeIdContact,101,date.parse('1/1/2020'),
                                                                'Administration','Faculty of Liberal Education',null,'Female');//contactObj3.Id
        
        Contact consaheel = Flame_TestDataFactory.createContact('Saheel','Deshpande','Faculty',
                                                                accountObj.Id,'saheel@gmail.com',RecordTypeIdContact,101,date.parse('1/1/2020'),
                                                                'Administration','Faculty of Liberal Education',null,'Female');//contactObj3.Id
        
        //Create Contact krishnakant
        Contact conkk = Flame_TestDataFactory.createContact('Krishnakant','Borse','Faculty',
                                                            accountObj.Id,'krishna@gmail.com',RecordTypeIdContact,102,date.parse('1/1/2019'),
                                                            'Administration','Faculty of Liberal Education',consaheel.id,'male');
        
        //Create Contact and Akshay
        Contact conakshay = Flame_TestDataFactory.createContact('Akshay','Shinde','Faculty',
                                                                accountObj.Id,'akshay@gmail.com',RecordTypeIdContact,100,date.parse('1/1/2020'),
                                                                'Administration','Faculty of Liberal Education',conkk.id,'Female');//contactObj3.Id
        
        
        //Create User akshay
        User userakshay = Flame_TestDataFactory.createUser(conakshay,proffaculty.Id);
        
        //Create User saheel
        User usersaheel = Flame_TestDataFactory.createUser(consaheel,proffaculty.Id);
        
        //Create User krishnakant
        User userkk = Flame_TestDataFactory.createUser(conkk,proffaculty.Id);
        
        ContentVersion cv = New ContentVersion();
        cv.PathOnClient = 'test';
        cv.Title = 'Profie Image';
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        
        ContentVersion tempContentVersion= [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        
        ContentDocumentLink objCDL = new ContentDocumentLink(); 
        objCDL.ContentDocumentId = tempContentVersion.ContentDocumentId;
        objCDL.LinkedEntityId = conkk.Id;
        objCDL.ShareType = 'I';
        insert objCDL;    
        
        //Call Classes
        Database.executeBatch(new Flame_WeekEndsHolidayBatch()); // holiday leave
        Database.executeBatch(new Flame_LeaveLedgerBatch());//credit leave balances
        
        //employee punch
        Employee_Calendar__c empPunchAkshay = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 10),'Present');
        
        Employee_Calendar__c empPunchKrishna = Flame_TestDataFactory.createEmployeeCalendar(conkk.id,conkk.Employee_Id__c,Date.newInstance(2020, 2, 10),'Present');
        
        Employee_Calendar__c empPunchSaheel = Flame_TestDataFactory.createEmployeeCalendar(consaheel.id,consaheel.Employee_Id__c,Date.newInstance(2020, 2, 10),'Present');
        
        Employee_Calendar__c empPunchKK2 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 11),'Absent');
        
        Employee_Calendar__c empPunchKK3 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 12),'Half Day');
        
        //insert leaves
        
        Leave_Ledger__c LeaveLedgerhKK1 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2) , System.today().addDays(2), 5 ,'Earned Leave');
        
        Leave_Ledger__c LeaveLedgerhKK2 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 5 ,'Casual Leave');
        
        Leave_Ledger__c LeaveLedgerhKK3 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdCreditLeaveLedger, 'Credit',System.today().addDays(-2) , System.today().addDays(-2), 1 ,'CompOff Request');
        
        Leave_Ledger__c LeaveLedgerhKK4 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'Consulting Leave');
        
        Leave_Ledger__c LeaveLedgerhKK5 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'Paternity Leave');
        
        Leave_Ledger__c LeaveLedgerhKK6 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'CompOff Leave');
        
    }
    
    @isTest
    static void deTest1(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            PageReference FlameLeavePage = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage);
            //ApexPages.currentPage().getParameters().put('testID',getkkuser.id);
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();   
                leaveApplication.approvalLinkBool=true;
                leaveApplication.ledger.From_Date__c = system.today().adddays(+7);
                leaveApplication.leavetype='Earned Leave';
                leaveApplication.ledger.To_Date__c = system.today().adddays(+7);
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                leaveApplication.picklistChangeMethod();
                system.debug('picklist');
                
                leaveApplication.Save();
                system.debug('save');
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser :'+listofUsers[0]);
            
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);
            //ApexPages.currentPage().getParameters().put('testID',listofUsers[0].id);
            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.indNo = '1';
                //approvalPageClassObj.changeView='Leave';
                approvalPageClassObj.changeview();
                approvalPageClassObj.showPopup();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.ApproveRecord();
                approvalPageClassObj.toogle();
                approvalPageClassObj.Cancel();
                approvalPageClassObj.successBoolMass = false;
                approvalPageClassObj.errorBoolMass = false;
                approvalPageClassObj.SuccessMsgMass = '';
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest2(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            Date Todaysdate = System.today();
            List<Employee_Calendar__c> Holiday = [SELECT Id, Name, In_Time__c, Out_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c, Employee_Code__c, IsPresent__c, RecordTypeId, RecordType.Name FROM Employee_Calendar__c Where RecordType.Name =: 'Holiday Punch' And Date__c >=: Todaysdate ORDER by Date__c  DESC ];
            
            PageReference FlameLeavePage3 = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage3);
            //ApexPages.currentPage().getParameters().put('testID',getkkuser.id);
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = Holiday[0].date__c;
                leaveApplication3.ledger.To_Date__c = Holiday[0].date__c;
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
                
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            User getapuser = [Select id from User where id =: useid Limit 1];
            
            PageReference FlameapprovalPage1 = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage1);
            //ApexPages.currentPage().getParameters().put('testID',useid);
            system.runAs(getapuser){
                Flame_ApprovalPageClass approvalPageClassObj1 = new Flame_ApprovalPageClass();
                approvalPageClassObj1.changeView='Punch';
                approvalPageClassObj1.changeview();
                approvalPageClassObj1.changeView='Leave';
                approvalPageClassObj1.changeview();
                approvalPageClassObj1.indNo = '1';
                approvalPageClassObj1.showPopup();
                approvalPageClassObj1.ManagerComments = 'Ok';
                approvalPageClassObj1.ApproveRecord();
                
                PageReference FlameapprovalPage2 = Page.Flame_ApprovalPage;
                Test.setCurrentPage(FlameapprovalPage2);
                //ApexPages.currentPage().getParameters().put('testID',useid);
                
                Flame_ApprovalPageClass approvalPageClassObj2 = new Flame_ApprovalPageClass();
                approvalPageClassObj2.indNo = '1';
                //approvalPageClassObj2.changeView='Leave';
                approvalPageClassObj2.changeview();
                approvalPageClassObj2.showPopup();
                approvalPageClassObj2.ManagerComments = 'Ok';
                approvalPageClassObj2.ApproveRecord();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest3(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            PageReference FlameLeavePage = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage);
            //ApexPages.currentPage().getParameters().put('testID',getkkuser.id);
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();   
                leaveApplication.approvalLinkBool=true;
                leaveApplication.ledger.From_Date__c = system.today().adddays(+7);
                leaveApplication.leavetype='Earned Leave';
                leaveApplication.ledger.To_Date__c = system.today().adddays(+7);
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                leaveApplication.picklistChangeMethod();
                system.debug('picklist');
                
                leaveApplication.Save();
                system.debug('save');
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser :'+listofUsers[0]);
            
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);
            //ApexPages.currentPage().getParameters().put('testID',listofUsers[0].id);
            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.indNo = '1';
                //approvalPageClassObj.changeView='Leave';
                approvalPageClassObj.changeview();
                approvalPageClassObj.showPopup();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.RejectRecord();
                approvalPageClassObj.toogle();
                approvalPageClassObj.Cancel();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest4(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            Date Todaysdate = System.today();
            List<Employee_Calendar__c> Holiday = [SELECT Id, Name, In_Time__c, Out_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c, Employee_Code__c, IsPresent__c, RecordTypeId, RecordType.Name FROM Employee_Calendar__c Where RecordType.Name =: 'Holiday Punch' And Date__c >=: Todaysdate ORDER by Date__c  DESC ];
            
            PageReference FlameLeavePage3 = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage3);

            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = Holiday[0].date__c;
                leaveApplication3.ledger.To_Date__c = Holiday[0].date__c;
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser :'+listofUsers[0]);
            
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.indNo = '1';
                //approvalPageClassObj.changeView='Leave';
                approvalPageClassObj.changeview();
                approvalPageClassObj.showPopup();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.ApproveRecord();
                approvalPageClassObj.toogle();
                approvalPageClassObj.Cancel();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest5(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            PageReference FlameLeavePage = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage);

            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();   
                leaveApplication.approvalLinkBool=true;
                leaveApplication.ledger.From_Date__c = system.today().adddays(+7);
                leaveApplication.leavetype='Earned Leave';
                leaveApplication.ledger.To_Date__c = system.today().adddays(+7);
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                leaveApplication.picklistChangeMethod();
                system.debug('picklist');
                
                leaveApplication.Save();
                system.debug('save');
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser :'+listofUsers[0]);
            
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.indNo = '1';
                //approvalPageClassObj.changeView='Leave';
                approvalPageClassObj.changeview();
                approvalPageClassObj.MassAction();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.MassReject();
                approvalPageClassObj.toogleMass();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest6(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            PageReference FlameLeavePage = Page.FlameLeaveApplication;
            Test.setCurrentPage(FlameLeavePage);

            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();   
                leaveApplication.approvalLinkBool=true;
                leaveApplication.ledger.From_Date__c = system.today().adddays(+7);
                leaveApplication.leavetype='Earned Leave';
                leaveApplication.ledger.To_Date__c = system.today().adddays(+7);
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                leaveApplication.picklistChangeMethod();
                system.debug('picklist');
                
                leaveApplication.Save();
                system.debug('save');
            }
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser :'+listofUsers[0]);
            
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.indNo = '1';
                //approvalPageClassObj.changeView='Leave';
                //approvalPageClassObj.changeview();
                approvalPageClassObj.MassAction();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.MassApprove();
                approvalPageClassObj.toogleMass();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest7(){
        Test.startTest();
        try{
            Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
            User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
            
            
            PageReference attendapageTablePage = Page.AttendancePageTable;
            Test.setCurrentPage(attendapageTablePage);
            
            system.runAs(getkkuser){
                AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
                attendancepageTavleClass.showPopupForFuture();
                attendancepageTavleClass.ledger.From_Date__c = system.today().addDays(3);
                attendancepageTavleClass.ledger.To_Date__c = system.today().addDays(3);
                attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
                attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
                attendancepageTavleClass.futurecomments = 'Testing Purpose';
                attendancepageTavleClass.insertFuturePunches();
                
            }
            
            list<ProcessInstanceWorkitem> allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                                                      ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                                                      ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem];
            string useid ;
            for(ProcessInstanceWorkitem pi :allitems ){
                system.debug('allitems :: '+pi+' , '+pi.processInstance.targetObjectId+' , '+pi.processInstance.status);
                useid = pi.ActorId;
            }
            list<User> listofUsers = [select id, name, ContactId from User where id =: useid];
            
            system.debug('current usser TestClass:'+listofUsers[0]);
            
            Contact ctcsah = [select id, firstname from contact where firstname ='Saheel' limit 1];
            //User getSsahUser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
            //                ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(listofUsers[0]){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.changeView='Punch';
                approvalPageClassObj.changeview();
                approvalPageClassObj.indNo = '1';
                approvalPageClassObj.MassAction();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.MassApprove();
                approvalPageClassObj.toogleMass();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest8(){
        Test.startTest();
        try{
            Contact ctcsah = [select id, firstname from contact where firstname ='Saheel' limit 1];
            User getSsahUser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcsah.id Limit 1];
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(getSsahUser){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.changeView='Leave';
                approvalPageClassObj.changeview();
                approvalPageClassObj.indNo = '1';
                approvalPageClassObj.MassAction();
                approvalPageClassObj.ManagerComments = 'Ok';
                approvalPageClassObj.MassApprove();
                approvalPageClassObj.toogleMass();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
   
    @isTest
    static void deTest9(){
        Test.startTest();
        try{
            Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
            User getkkUser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
            
            
            PageReference FlameapprovalPage = Page.Flame_ApprovalPage;
            Test.setCurrentPage(FlameapprovalPage);

            system.runAs(getkkUser){
                Flame_ApprovalPageClass approvalPageClassObj = new Flame_ApprovalPageClass();
                approvalPageClassObj.changeView='';
                approvalPageClassObj.changeview();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
     
    
}