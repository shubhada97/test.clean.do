@isTest
public class Flame_RegularizationAttendenceInfoTest {
    
    @testSetup static void setup() { 
        Profile proffaculty = [select id from profile where name LIKE 'Faculty'];
        Profile profstaff = [select id from profile where name LIKE 'Staff'];
        //UserRole ur = [Select PortalType, PortalAccountId From UserRole where PortalType =:'None' limit 1];
        
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        Id RecordTypeIdDebitLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Debit').getRecordTypeId();
        Id RecordTypeIdCreditLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();
        //--------------------------------------------
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman',
            Email='bruce.wayne@testerg.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );

        //--------------------------------------------
        System.runAs ( portalAccountOwner1 ) {
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
            Employee_Calendar__c empPunchAkshay = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,system.today().addDays(-3),'Present');
            
            Employee_Calendar__c empPunchKrishna = Flame_TestDataFactory.createEmployeeCalendar(conkk.id,conkk.Employee_Id__c,system.today().addDays(-3),'Present');
            
            Employee_Calendar__c empPunchSaheel = Flame_TestDataFactory.createEmployeeCalendar(consaheel.id,consaheel.Employee_Id__c,system.today().addDays(-3),'Present');
            
            Employee_Calendar__c empPunchKK2 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,system.today().addDays(-4),'Absent');
            
            Employee_Calendar__c empPunchKK3 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,system.today().addDays(-5),'Half Day');
            
            //insert leaves
            /*
            Leave_Ledger__c LeaveLedgerhKK1 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2) , System.today().addDays(2), 5 ,'Earned Leave');
            
            Leave_Ledger__c LeaveLedgerhKK2 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 5 ,'Casual Leave');
            
            Leave_Ledger__c LeaveLedgerhKK3 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdCreditLeaveLedger, 'Credit',System.today().addDays(-2) , System.today().addDays(-2), 1 ,'CompOff Request');
            
            Leave_Ledger__c LeaveLedgerhKK4 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'Consulting Leave');
            
            Leave_Ledger__c LeaveLedgerhKK5 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'Paternity Leave');
            
            Leave_Ledger__c LeaveLedgerhKK6 = Flame_TestDataFactory.createLeaveLedger(conkk.id,conkk.Employee_Id__c, usersaheel.id, userkk.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(-2), System.today().addDays(-2), 1 ,'CompOff Leave');
            
            Leave_Ledger__c LeaveLedgerhAK1 = Flame_TestDataFactory.createLeaveLedger(conakshay.id,conakshay.Employee_Id__c, userkk.id, userakshay.id, RecordTypeIdDebitLeaveLedger, 'Debit',System.today().addDays(2), System.today().addDays(2), 1 ,'Paternity Leave');
            */
        }
    }
    
    @isTest
    static void testmethod1(){
        
        
        Contact ctckk = [select id, firstname from contact where firstname ='Krishnakant' limit 1];
        User getkkuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                        ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctckk.id Limit 1];
        
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getkkuser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getkkuser.id);
        system.runAs(getkkuser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            attendancepageTavleClass.closePopup();
            attendancepageTavleClass.toogle();
            attendancepageTavleClass.Cancel();
            attendancepageTavleClass.indNo = '1';
            attendancepageTavleClass.showPopup();
            attendancepageTavleClass.expInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.expOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.comments = 'Testing Purpose';
            attendancepageTavleClass.updatePunches();
            attendancepageTavleClass.showPopupForFuture();
            attendancepageTavleClass.ledger.From_Date__c = system.today().addDays(3);
            attendancepageTavleClass.ledger.To_Date__c = system.today().addDays(3);
            attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.futurecomments = 'Testing Purpose';
            attendancepageTavleClass.insertFuturePunches();
            
        }
    }    
    
    @isTest
    static void testmethod2(){
        
        
        Contact ctcSaheel = [select id, firstname from contact where firstname ='Saheel' limit 1];
        User getSaheeluser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcSaheel.id Limit 1];
        
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getSaheeluser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getSaheeluser.id);
        system.runAs(getSaheeluser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            attendancepageTavleClass.closePopup();
            attendancepageTavleClass.toogle();
            attendancepageTavleClass.Cancel();
            attendancepageTavleClass.indNo = '1';
            attendancepageTavleClass.showPopup();
            attendancepageTavleClass.expInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.expOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.comments = 'Testing Purpose';
            attendancepageTavleClass.updatePunches();
            attendancepageTavleClass.showPopupForFuture();
            attendancepageTavleClass.ledger.From_Date__c = system.today().addDays(2);
            attendancepageTavleClass.ledger.To_Date__c = system.today().addDays(2);
            attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.futurecomments = 'Testing Purpose';
            attendancepageTavleClass.insertFuturePunches();
            
        }
    }    
    
    @isTest
    static void testmethod3(){
        
        
        Contact ctcAkshay = [select id, firstname from contact where firstname ='Akshay' limit 1];
        User getakshayuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcAkshay.id Limit 1];
        
        Date todaysDate = System.today();
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        system.runAs(getakshayuser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            attendancepageTavleClass.closePopup();
            attendancepageTavleClass.toogle();
            attendancepageTavleClass.Cancel();
            attendancepageTavleClass.indNo = '1';
            attendancepageTavleClass.showPopup();
            attendancepageTavleClass.expInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.expOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.comments = 'Testing Purpose';
            attendancepageTavleClass.updatePunches();
            list<employee_calendar__c> getHoliday = [select id, date__c from Employee_calendar__c where recordtype.Name = 'Holiday Punch' and Date__c >=: todaysDate limit 1];
            attendancepageTavleClass.showPopupForFuture();            
           // attendancepageTavleClass.ledger.From_Date__c = getHoliday[0].date__c;
            //attendancepageTavleClass.ledger.To_Date__c = getHoliday[0].date__c;
          //  attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
          //  attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
           attendancepageTavleClass.futurecomments = 'Testing Purpose';
            attendancepageTavleClass.insertFuturePunches();
        }
        
    }    
    
    @isTest
    static void testmethod4(){
        
        
        Contact ctcAkshay = [select id, firstname from contact where firstname ='Akshay' limit 1];
        User getakshayuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcAkshay.id Limit 1];
        
        Date todaysDate = System.today();
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        system.runAs(getakshayuser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            attendancepageTavleClass.closePopup();
            attendancepageTavleClass.toogle();
            attendancepageTavleClass.Cancel();
            attendancepageTavleClass.indNo = '1';
            attendancepageTavleClass.showPopup();
            attendancepageTavleClass.expInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.expOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.comments = 'Testing Purpose';
            attendancepageTavleClass.updatePunches();
            list<employee_calendar__c> getHoliday = [select id, date__c from Employee_calendar__c where recordtype.Name = 'Employee Punch' and Date__c <=: todaysDate limit 1];
            attendancepageTavleClass.showPopupForFuture();
            attendancepageTavleClass.ledger.From_Date__c = getHoliday[0].date__c;
            attendancepageTavleClass.ledger.To_Date__c = getHoliday[0].date__c;
            attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.futurecomments = 'Testing Purpose';
            attendancepageTavleClass.insertFuturePunches();
            
        }
    }    
    
    
    @isTest
    static void testmethod5(){
        
        
        Contact ctcAkshay = [select id,Employee_Id__c ,firstname from contact where firstname ='Akshay' limit 1];
        User getakshayuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcAkshay.id Limit 1];
        
        Employee_Calendar__c empPunchakshay = Flame_TestDataFactory.createEmployeeCalendar(ctcAkshay.id,ctcAkshay.Employee_Id__c,system.today().addDays(-20),'Absent');
        
        Date todaysDate = System.today();
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        system.runAs(getakshayuser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            
            Integer indNumber ;
            
            for(Employee_Calendar__c ecmp : attendancepageTavleClass.punches){
                if(ecmp.Date__c == system.today().addDays(-20)){
                    indNumber = attendancepageTavleClass.punches.indexOf(ecmp);
                }
            }
            
            attendancepageTavleClass.indNo = string.valueOf(indNumber);
            attendancepageTavleClass.showPopup();
            attendancepageTavleClass.expInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.expOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.comments = 'Testing Purpose';
            attendancepageTavleClass.updatePunches();
            
        }
    }    
    
    @isTest
    static void testmethod6(){
        
        
        Contact ctcAkshay = [select id,Employee_Id__c ,firstname from contact where firstname ='Akshay' limit 1];
        User getakshayuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcAkshay.id Limit 1];
        
        Employee_Calendar__c empPunchakshay = Flame_TestDataFactory.createEmployeeCalendar(ctcAkshay.id,ctcAkshay.Employee_Id__c,system.today().addDays(-20),'Absent');
        
        Date todaysDate = System.today();
        
        PageReference flameregularizePage = Page.Flame_Regularization;    
        Test.setCurrentPage(flameregularizePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        Flame_Regularization regulInst = new Flame_Regularization();
        
        
        PageReference attendapageTablePage = Page.AttendancePageTable;
        Test.setCurrentPage(attendapageTablePage);
        ApexPages.currentPage().getParameters().put('testID',getakshayuser.id);
        system.runAs(getakshayuser){
            AttendancePageTableClass attendancepageTavleClass = new AttendancePageTableClass();
            
            Integer indNumber ;
            
            for(Employee_Calendar__c ecmp : attendancepageTavleClass.punches){
                if(ecmp.Date__c == system.today().addDays(-20)){
                    indNumber = attendancepageTavleClass.punches.indexOf(ecmp);
                }
            }
            
            attendancepageTavleClass.indNo = string.valueOf(indNumber);
            attendancepageTavleClass.showPopupForFuture();
            attendancepageTavleClass.ledger.From_Date__c = system.today().addDays(2);
            attendancepageTavleClass.ledger.To_Date__c = system.today().addDays(2);
            attendancepageTavleClass.futureexpInTime = Time.newInstance(9, 0, 0, 0);
            attendancepageTavleClass.futureexpOutTime = Time.newInstance(6, 0, 0, 0);
            attendancepageTavleClass.futurecomments = 'Testing Purpose';
            attendancepageTavleClass.insertFuturePunches();
            
        }
    }    
    
}