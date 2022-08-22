@istest
public class Flame_PayRollTest {
    
    testmethod static void test2()
    {
        Flame_PayRoll_Controller flame = new Flame_PayRoll_Controller();
        flame.month = 2;
        flame.year = '2020';
        Payroll_Advice__c p = new Payroll_Advice__c(Employee_Id__c = 101, Month_Year_Flag__c = '22020');
        insert p;
        flame.submitSingle();
        flame.updateRecords();
    }
    
    testmethod static void test3() 
    {
        Flame_PayRoll_Controller flame = new Flame_PayRoll_Controller();
        flame.month = 2;
        flame.year = '2020';
        flame.submitSingle();
        flame.save();
        flame.callTOsave();
    }
    
    testmethod static void test4()
    {
        Date FromDate = date.newinstance(2020, 2, 20);
        Date ToDate = date.newinstance(2020, 2, 21);
        Date FromDate2 = date.newinstance(2020, 2, 26);
        Date ToDate2 = date.newinstance(2020, 2, 28);
        
        Test.startTest();
        
        Account acc = new Account(Name = 'Test Account');
        Insert acc;
        
        Profile proffaculty = [select id from profile where name LIKE 'Faculty'];
        Id RecordTypeIdContact = Schema.SObjectType.contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdDebitLeaveLedger = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Debit').getRecordTypeId();
        
        
        //Create Contact saheel
        Contact consaheel = Flame_TestDataFactory.createContact('Saheel','Deshpande','Faculty',
                                                                acc.Id,'saheel@gmail.com',RecordTypeIdContact,101,date.parse('1/1/2020'),
                                                                'Administration','Faculty of Liberal Education',null,'Female');//contactObj3.Id
        
        Contact cc = Flame_TestDataFactory.createContact('Krishnakant','Test','Faculty',
                                                         acc.Id,'kkrams111@gmail.com',RecordTypeIdContact,100,date.parse('11/11/2019'),
                                                         'Administration','Faculty of Liberal Education',consaheel.id,'male');
        
        //Create User saheel
        User usersaheel = Flame_TestDataFactory.createUser(consaheel,proffaculty.Id);
        
        //Create User krishnakant
        User userkk = Flame_TestDataFactory.createUser(cc,proffaculty.Id);
        
        Employee_Calendar__c empPunchkk1 = Flame_TestDataFactory.createEmployeeCalendar(cc.id,cc.Employee_Id__c,Date.newInstance(2020, 2, 10),'Present');
        
        Employee_Calendar__c empPunchKK2 = Flame_TestDataFactory.createEmployeeCalendar(consaheel.id,consaheel.Employee_Id__c,Date.newInstance(2020, 2, 11),'Present');
        
        Employee_Calendar__c empPunchKK3 = Flame_TestDataFactory.createEmployeeCalendar(cc.id,cc.Employee_Id__c,Date.newInstance(2020, 2, 12),'Half Day');
        
        
        Leave_ledger__c leave = new Leave_ledger__c();
        leave.From_Date__c = Date.newInstance(2020, 2, 14);
        leave.To_Date__c = Date.newInstance(2020, 2, 14);
        leave.Approved__c = true;
        leave.Status__c = 'Approved';
        leave.Leave_Action__c = 'Debit';
        insert leave;
        
        
        List<contact> conlist = [select lastname from contact];
        system.debug('conlist of pappu: '+conlist);
        
        
        Flame_PayRoll_Controller flame = new Flame_PayRoll_Controller();
        flame.month = 3;
        flame.year = '2020';
        
        flame.getYearsList();
        flame.submitSingle();
        flame.save();
        flame.ExportToCSV();
        
        PageReference payRollexportPage = Page.Flame_ExportTable;
        ApexPages.currentPage().getParameters().put('MonthYear','32020');  
        Test.setCurrentPage(payRollexportPage);
        
        Flame_ExportTableClass expCl = new Flame_ExportTableClass();
        
        
        
        Test.stopTest();
        
    }
    
    
}