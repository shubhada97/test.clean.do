@isTest
public class Flame_EmailForApprovalTest {
    
    @testSetup static void setup() {
        Account accObj = new Account();
        accObj.Name='Test Account';
        insert accObj;
        
        Contact conObj2 = new Contact();
        conObj2.AccountId = accObj.id;
        conObj2.LastName = 'Test Contact11';
        conObj2.Employee_Id__c = 100;
        conObj2.Earned_Leave_Balance__c = 10;
        conObj2.Casual_Leave_Balance__c = 5;
        conObj2.Email = 'test1@test1.com';
        conObj2.Maternity_Paternity_Leave_Balance__c = 20;
        conObj2.Faculty_Researching_and_Consulting__c = 10;
        conObj2.CompOff_Balance__c = 10;
        insert conObj2;
        System.debug('conObj2 ====='+conObj2.Email );
        
        Contact conObj = new Contact();
        conObj.AccountId = accObj.id;
        conObj.LastName = 'Test Contact';
        conObj.Employee_Id__c = 102;
        conObj.Earned_Leave_Balance__c = 10;
        conObj.Casual_Leave_Balance__c = 5;
        conObj.Email = 'test@test.com';
        conObj.Maternity_Paternity_Leave_Balance__c = 20;
        conObj.ReportsToId = conObj2.Id;
        conObj.Faculty_Researching_and_Consulting__c = 10;
        conObj.CompOff_Balance__c = 10;
        insert conObj;
        System.debug('conObj ====='+conObj.Id);
        System.debug('conObj Repo====='+conObj.ReportsToId);
        

        Employee_Calendar__c empRecord1 = new Employee_Calendar__C();
        empRecord1.Applied_For_Regularization__c = false;
        empRecord1.Expected_In_Time__c = Time.newInstance(9, 0, 0, 0);
        empRecord1.Expected_Out_Time__c = Time.newInstance(9, 0, 0, 0);
        empRecord1.Comments__c = 'tester is testing';
        empRecord1.Manager_Comments__c = 'OK';
        empRecord1.Date__c = System.Today().addDays(2);
        empRecord1.Employee_Code__c = '102';
        empRecord1.Contact_Name__c = conObj.id;
        empRecord1.OnDuty_Leave__c = 'Official Regularized Visit';
        empRecord1.Status__c = 'Pending';
        
        Employee_Calendar__c empRecord2 = new Employee_Calendar__C();
        empRecord2.Applied_For_Regularization__c = false;
        empRecord2.Expected_In_Time__c = Time.newInstance(9, 0, 0, 0);
        empRecord2.Expected_Out_Time__c = Time.newInstance(9, 0, 0, 0);
        empRecord2.Comments__c = 'tester is testing';
        empRecord2.Manager_Comments__c = 'OK';
        empRecord2.Date__c = System.Today().addDays(2);
        empRecord2.Employee_Code__c = '102';
        empRecord2.Contact_Name__c = conObj.id;
        empRecord2.OnDuty_Leave__c = 'Official Regularized Visit';
        empRecord2.Status__c = 'Pending';
        
        insert empRecord1;
        insert empRecord2;
        
        empRecord1.Status__c = 'Approved';
        empRecord2.Status__c = 'Rejected';
        
        update empRecord1;
        update empRecord2;
        
    }
    
    
    
    Static testMethod void AccountClassTest() {
        List<Employee_Calendar__C> listOfLeaveLedger = [Select Id,Contact_Name__r.Email,Comments__c,Contact_Name__r.ReportsTo.Email,Manager_Comments__c,Contact_Name__r.Name,Status__c,Contact_Name__r.ReportsToId from Employee_Calendar__c];
        Flame_EmailForApproval.sendUpdateEmailForPunch(listOfLeaveLedger);
    }
    
}