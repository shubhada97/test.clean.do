@isTest
public class Flame_AttendenceInfoClassTest {
    
    @testSetup static void setup() { 
        Profile proffaculty = [select id from profile where name LIKE 'Faculty'];
        
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        Id RecordTypeIdDebitLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Debit').getRecordTypeId();
        Id RecordEmployeePunch = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId();
        
        //Create Account
        Account accountObj = Flame_TestDataFactory.createAccount('Faculty Account',RecordTypeIdAccount);
        
        //Create Contact krishnakant
        Contact conkk = Flame_TestDataFactory.createContact('Krishnakant','Borse','Faculty',
                                                            accountObj.Id,'krishna@gmail.com',RecordTypeIdContact,102,date.parse('1/1/2019'),
                                                            'Administration','Faculty of Liberal Education',null,'male');
        
        //Create Contact and Akshay
        Contact conakshay = Flame_TestDataFactory.createContact('Akshay','Shinde','Faculty',
                                                                accountObj.Id,'akshay@gmail.com',RecordTypeIdContact,100,date.parse('1/1/2020'),
                                                                'Administration','Faculty of Liberal Education',conkk.id,'Female');//contactObj3.Id
        
        //Create User akshay
        User userakshay = Flame_TestDataFactory.createUser(conakshay,proffaculty.Id);
                
        //Create User krishnakant
        User userkk = Flame_TestDataFactory.createUser(conkk,proffaculty.Id);
        
        //Call Classes
        Database.executeBatch(new Flame_WeekEndsHolidayBatch()); // holiday leave
        
        //employee punch
        Employee_Calendar__c empPunchAkshay = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 10),'Present');
        
        Employee_Calendar__c empPunchKK2 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 11),'Absent');
        
        Employee_Calendar__c empPunchKK3 = Flame_TestDataFactory.createEmployeeCalendar(conakshay.id,conakshay.Employee_Id__c,Date.newInstance(2020, 2, 12),'Half Day');
        
        Employee_Calendar__c empC = new Employee_Calendar__c();
        empC.Date__c = system.today().addDays(2);
        empC.Employee_Code__c = string.valueOf(conakshay.Employee_Id__c);
        empC.Contact_Name__c = conakshay.id;
        empC.In_Time__c = Time.newInstance(9, 0, 0, 0);
        empC.Out_Time__c = Time.newInstance(9, 0, 0, 0);
        empC.RecordTypeId = RecordEmployeePunch;
        empC.OnDuty_Leave__c = 'Full Day Leave';
        insert empC;
    }
    
    @isTest
    static void testCalendar(){
        Contact ctcAkshay = [select id, firstname from contact where firstname ='Akshay' limit 1];
        User getakshayuser=[Select id, FirstName, LastName, Email,ContactId,Department,CommunityNickname,Alias,IsActive,LanguageLocaleKey ,TimeZoneSidKey,LocaleSidKey,EmailEncodingKey,
                            ReceivesInfoEmails,Username,ProfileId,UserPermissionsChatterAnswersUser from User where ContactId =: ctcAkshay.id Limit 1];
        
        system.runAs(getakshayuser){
            PageReference FlameMyCalendar = Page.Flame_AttendenceInfo;
            Test.setCurrentPage(FlameMyCalendar);
            
            
            Flame_AttendenceInfoClass myCal = new Flame_AttendenceInfoClass();
            
            PageReference FlameCalCompo = Page.AttendancePage;
            Test.setCurrentPage(FlameCalCompo);
            
            
            AttendancePageClass.getEvents();
        }
    }
}