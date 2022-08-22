@isTest
public class TrackLeaveControllerTest {
    
    
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
        User userkk = Flame_TestDataFactory.createUser(conkk,profstaff.Id);
        
        
        //Call Classes
        Database.executeBatch(new Flame_WeekEndsHolidayBatch()); // holiday leave
        Database.executeBatch(new Flame_LeaveLedgerBatch());//credit leave balances
        
        
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
        //Get User List
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.ledger.From_Date__c = system.today();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.ledger.To_Date__c = system.today();
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                system.debug('save');
                leaveApplication.Cancel();
                
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.ledger.From_Date__c = system.today().adddays(+2);
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.ledger.To_Date__c = system.today().adddays(+2);
                leaveApplication2.ledger.Total_Days__c = 1;
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                system.debug('save');
                leaveApplication2.Cancel();
                
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.ledger.From_Date__c = system.today().adddays(+3);
                leaveApplication3.leavetype='Earned Leave';
                leaveApplication3.ledger.To_Date__c = system.today().adddays(+3);
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.Save();
                system.debug('save');
                leaveApplication3.Cancel();
                
                LeaveApplicationController leaveApplication4 = new LeaveApplicationController();
                leaveApplication4.ledger.From_Date__c = system.today().adddays(-2);
                leaveApplication4.leavetype='Earned Leave';
                leaveApplication4.ledger.To_Date__c = system.today().adddays(-2);
                leaveApplication4.ledger.Total_Days__c = 1;
                leaveApplication4.ledger.Reason__c = 'Testing' ;
                
                leaveApplication4.Save();
                system.debug('save');
                leaveApplication4.Cancel();
                
                LeaveApplicationController leaveApplication5 = new LeaveApplicationController();
                leaveApplication5.ledger.From_Date__c = system.today().adddays(-5);
                leaveApplication5.leavetype='Casual Leave';
                leaveApplication5.ledger.To_Date__c = system.today().adddays(-5);
                leaveApplication5.ledger.Total_Days__c = 1;
                leaveApplication5.ledger.Reason__c = 'Testing' ;
                
                leaveApplication5.Save();
                system.debug('save');
                leaveApplication5.Cancel();
                
                PageReference FlametrackLeave = Page.TrackLeave;
                Test.setCurrentPage(FlametrackLeave);
                ApexPages.currentPage().getParameters().put('indexnumber','1');
                
                TrackLeaveController trackLeaveControllerObj = new TrackLeaveController();
                trackLeaveControllerObj.toogle();
                trackLeaveControllerObj.Cancel();
                trackLeaveControllerObj.filterStatus = 'Pending';
                trackLeaveControllerObj.filterLeaveType = 'Earned Leave';
                trackLeaveControllerObj.getfilterList();
                trackLeaveControllerObj.indNo = 1;
                trackLeaveControllerObj.submit();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        } 
        Test.stopTest();
    }
    
    
    @isTest
    static void deTest2(){
        Test.startTest();
        //Get User List
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.ledger.From_Date__c = system.today();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.ledger.To_Date__c = system.today();
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                system.debug('save');
                leaveApplication.Cancel();
                
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.ledger.From_Date__c = system.today().adddays(+2);
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.ledger.To_Date__c = system.today().adddays(+2);
                leaveApplication2.ledger.Total_Days__c = 1;
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                system.debug('save');
                leaveApplication2.Cancel();
                
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.ledger.From_Date__c = system.today().adddays(+3);
                leaveApplication3.leavetype='Earned Leave';
                leaveApplication3.ledger.To_Date__c = system.today().adddays(+3);
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.Save();
                system.debug('save');
                leaveApplication3.Cancel();
                
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
                approvalPageClassObj.MassApprove();
                approvalPageClassObj.toogleMass();
                
            }
            
            system.runAs(getkkuser){
                PageReference FlametrackLeave = Page.TrackLeave;
                Test.setCurrentPage(FlametrackLeave);
                ApexPages.currentPage().getParameters().put('indexnumber','1');
                
                TrackLeaveController trackLeaveControllerObj = new TrackLeaveController();
                trackLeaveControllerObj.filterStatus = 'Approved';
                trackLeaveControllerObj.getfilterList();
                Integer lastIndex = trackLeaveControllerObj.leaveTrackList.size();
                trackLeaveControllerObj.indNo = lastIndex;
                trackLeaveControllerObj.submit();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        } 
        Test.stopTest();
    }
    
    
    @isTest
    static void deTest3(){
        Test.startTest();
        //Get User List
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.ledger.From_Date__c = system.today();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.ledger.To_Date__c = system.today();
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                system.debug('save');
                leaveApplication.Cancel();
                
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.ledger.From_Date__c = system.today().adddays(+2);
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.ledger.To_Date__c = system.today().adddays(+2);
                leaveApplication2.ledger.Total_Days__c = 1;
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                system.debug('save');
                leaveApplication2.Cancel();
                
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.ledger.From_Date__c = system.today().adddays(+3);
                leaveApplication3.leavetype='Earned Leave';
                leaveApplication3.ledger.To_Date__c = system.today().adddays(+3);
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.Save();
                system.debug('save');
                leaveApplication3.Cancel();
                
                LeaveApplicationController leaveApplication4 = new LeaveApplicationController();
                leaveApplication4.ledger.From_Date__c = system.today().adddays(-2);
                leaveApplication4.leavetype='Earned Leave';
                leaveApplication4.ledger.To_Date__c = system.today().adddays(-2);
                leaveApplication4.ledger.Total_Days__c = 1;
                leaveApplication4.ledger.Reason__c = 'Testing' ;
                
                leaveApplication4.Save();
                system.debug('save');
                leaveApplication4.Cancel();
                
                LeaveApplicationController leaveApplication5 = new LeaveApplicationController();
                leaveApplication5.ledger.From_Date__c = system.today().adddays(-5);
                leaveApplication5.leavetype='Casual Leave';
                leaveApplication5.ledger.To_Date__c = system.today().adddays(-5);
                leaveApplication5.ledger.Total_Days__c = 1;
                leaveApplication5.ledger.Reason__c = 'Testing' ;
                
                leaveApplication5.Save();
                system.debug('save');
                leaveApplication5.Cancel();
                
                PageReference FlametrackLeave = Page.TrackLeave;
                Test.setCurrentPage(FlametrackLeave);
                ApexPages.currentPage().getParameters().put('indexnumber','1');
                
                TrackLeaveController trackLeaveControllerObj = new TrackLeaveController();
                trackLeaveControllerObj.toogle();
                trackLeaveControllerObj.Cancel();
                trackLeaveControllerObj.filterStatus = 'None';
                trackLeaveControllerObj.filterLeaveType = 'None';
                trackLeaveControllerObj.getfilterList();
                trackLeaveControllerObj.indNo = 1;
                trackLeaveControllerObj.submit();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        } 
        Test.stopTest();
    }
    
    
    @isTest
    static void deTest4(){
        Test.startTest();
        //Get User List
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            system.runAs(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.ledger.From_Date__c = system.today();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.ledger.To_Date__c = system.today();
                leaveApplication.ledger.Total_Days__c = 1;
                leaveApplication.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                system.debug('save');
                leaveApplication.Cancel();
                
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.ledger.From_Date__c = system.today().adddays(+2);
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.ledger.To_Date__c = system.today().adddays(+2);
                leaveApplication2.ledger.Total_Days__c = 1;
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                system.debug('save');
                leaveApplication2.Cancel();
                
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.ledger.From_Date__c = system.today().adddays(+3);
                leaveApplication3.leavetype='Earned Leave';
                leaveApplication3.ledger.To_Date__c = system.today().adddays(+3);
                leaveApplication3.ledger.Total_Days__c = 1;
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.Save();
                system.debug('save');
                leaveApplication3.Cancel();
                
                LeaveApplicationController leaveApplication4 = new LeaveApplicationController();
                leaveApplication4.ledger.From_Date__c = system.today().adddays(-2);
                leaveApplication4.leavetype='Earned Leave';
                leaveApplication4.ledger.To_Date__c = system.today().adddays(-2);
                leaveApplication4.ledger.Total_Days__c = 1;
                leaveApplication4.ledger.Reason__c = 'Testing' ;
                
                leaveApplication4.Save();
                system.debug('save');
                leaveApplication4.Cancel();
                
                LeaveApplicationController leaveApplication5 = new LeaveApplicationController();
                leaveApplication5.ledger.From_Date__c = system.today().adddays(-5);
                leaveApplication5.leavetype='Casual Leave';
                leaveApplication5.ledger.To_Date__c = system.today().adddays(-5);
                leaveApplication5.ledger.Total_Days__c = 1;
                leaveApplication5.ledger.Reason__c = 'Testing' ;
                
                leaveApplication5.Save();
                system.debug('save');
                leaveApplication5.Cancel();
                
                PageReference FlametrackLeave = Page.TrackLeave;
                Test.setCurrentPage(FlametrackLeave);
                ApexPages.currentPage().getParameters().put('indexnumber','1');
                
                TrackLeaveController trackLeaveControllerObj = new TrackLeaveController();
                trackLeaveControllerObj.toogle();
                trackLeaveControllerObj.Cancel();
                trackLeaveControllerObj.filterStatus = 'Pen';
                trackLeaveControllerObj.filterLeaveType = 'Earned Leave';
                trackLeaveControllerObj.getfilterList();
                trackLeaveControllerObj.indNo = 1;
                trackLeaveControllerObj.submit();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        } 
        Test.stopTest();
    }
    
    
}