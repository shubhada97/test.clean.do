@isTest
public class LeaveApplicationControllerTest {
    
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
    static void earnleave1(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            System.runas(getkkuser){
                
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Earned Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(-3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(-2);
                leaveApplication.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                
                leaveApplication.toogle();
                
                leaveApplication.Cancel();
                
                leaveApplication.reDirect();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave2(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(3);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave3(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(6);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave4(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(50);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave5(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(50);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave6(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(30);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(30);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave7(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(-30);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(-30);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave8(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(2);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave9(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(5);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void earnleave10(){
        Test.startTest();
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Earned Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(7);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(6);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void casualLeave1(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
                
                leaveApplication.toogle();
                
                leaveApplication.Cancel();
                
                leaveApplication.reDirect();
                
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Casual Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(8);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(50);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication.Save();
                
                leaveApplication.toogle();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void casualLeave2(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(3); 
                leaveApplication.ledger.Half_Day__c = true;
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void casualLeave3(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Casual Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(6); 
                leaveApplication.ledger.Half_Day__c = true;
                
                leaveApplication.Save();
                
                leaveApplication.toogle();
                
                leaveApplication.Cancel();
                
                leaveApplication.reDirect();
                
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void casualLeave4(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication2 = new LeaveApplicationController();
                leaveApplication2.leavetype='Casual Leave';
                leaveApplication2.picklistChangeMethod();
                leaveApplication2.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication2.ledger.To_Date__c = System.today().addDays(50);
                leaveApplication2.ledger.Reason__c = 'Testing' ;
                
                leaveApplication2.Save();
                
                leaveApplication2.toogle();
                
                leaveApplication2.Cancel();
                
                leaveApplication2.reDirect();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void paternityleave1(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Paternity Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(3); 
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void paternityleave2(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Paternity Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(6); 
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void paternityleave3(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Akshay' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Maternity Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void paternityleave4(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Paternity Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq1(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Request';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = system.today().addDays(3);
                leaveApplication.ledger.To_Date__c = system.today().addDays(3); 
                
                leaveApplication.SaveCR();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq2(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = system.today().addDays(6);
                leaveApplication3.ledger.To_Date__c = system.today().addDays(6);
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq3(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){            
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Request';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = system.today().addDays(3);
                leaveApplication.ledger.To_Date__c = system.today().addDays(50); 
                
                leaveApplication.SaveCR();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq4(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Request';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = system.today().addDays(6);
                leaveApplication.ledger.To_Date__c = system.today().addDays(50); 
                
                leaveApplication.SaveCR();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq5(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = system.today().addDays(4);
                leaveApplication3.ledger.To_Date__c = system.today().addDays(4);
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq6(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = system.today().addDays(5);
                leaveApplication3.ledger.To_Date__c = system.today().addDays(5);
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void compoffReq7(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        system.debug('kk:: '+ ctckk);
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication3 = new LeaveApplicationController();
                leaveApplication3.leavetype='CompOff Request';
                leaveApplication3.picklistChangeMethod();
                leaveApplication3.ledger.From_Date__c = system.today().addDays(7);
                leaveApplication3.ledger.To_Date__c = system.today().addDays(7);
                leaveApplication3.ledger.Reason__c = 'Testing' ;
                
                leaveApplication3.SaveCR();
                
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void cmpleave1(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(3); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void cmpleave2(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(6); 
                
                leaveApplication.Save();
            }
            
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void cmpleave3(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void cmpleave4(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='CompOff Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void consultingleave1(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Consulting Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(3); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void consultingleave2(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Consulting Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(6); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void consultingleave3(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Consulting Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(3);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }        
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void consultingleave4(){
        Test.startTest();
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        try{
            System.runas(getkkuser){
                LeaveApplicationController leaveApplication = new LeaveApplicationController();
                leaveApplication.leavetype='Consulting Leave';
                leaveApplication.picklistChangeMethod();
                leaveApplication.ledger.From_Date__c = System.today().addDays(6);
                leaveApplication.ledger.To_Date__c = System.today().addDays(50); 
                
                leaveApplication.Save();
            }
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
}