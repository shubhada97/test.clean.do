@isTest
public class ExpireCompoffRequestBatchTest {
    static testMethod void method(){
        Id accRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Academic Program').getRecordTypeId();
        Id conRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id levledRecordTypeId = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();
        
        Account acc = new Account();
        acc.Name = 'Flame Test Account';
        acc.RecordTypeId = accRecordTypeId;
        insert acc;
        
        // List<Contact> conList = new List<Contact>();
        // for(Integer i=0; i<10; i++){
        Contact conObj = new Contact();
        conObj.AccountId = acc.Id;
        conObj.LastName = 'Flame Test Contact';
        conObj.RecordTypeId = conRecordTypeId;
        conObj.lastName='Test kk';
        conObj.Casual_Leave_Balance__c=5;
        conObj.CompOff_Balance__c = 2;
        conObj.Earned_Leave_Balance__c=58;
        conObj.Primary_Contact_Type__c = 'Staff';
        conObj.Email='kkramascd@gmail.com';
        conObj.Employee_Id__c=101;
        Date Join_Date = Date.newInstance(Date.today().year(), Date.today().month(), (Date.today().Day()-17));
        conObj.Date_of_Joining__c = Join_Date;
        conObj.Classfication_Staff__c = true;
        insert conObj;
        // conList.add(conObj);
        //}
        // insert conList;
        
        Set<ID> levledId = new Set<ID>();
        List<Leave_Ledger__c> llList = new List<Leave_Ledger__c>();
        Date myDate = date.newInstance(2020,03,12);
        //for(Contact c : conList){
        Leave_Ledger__c ll = new Leave_Ledger__c();
        ll.Employee_Name__c	= conObj.Id;
        ll.Reason__c	= 'Testing Batch Class';
        ll.From_Date__c  = myDate;
        ll.To_Date__c = myDate;
        ll.Leave_Type__c = 'CompOff Request';
        ll.Status__c = 'Approved';
        ll.CompOff_Expired__c = false;
        ll.CompOff_Used__c = false;
        ll.RecordTypeId = levledRecordTypeId;
        ll.Total_days__c = 1;
        llList.add(ll);
        levledId.add(ll.Id);
        //  }
        insert llList;
        
        Test.startTest();
        ExpireCompoffRequestBatch ecr = new ExpireCompoffRequestBatch();
        Database.executeBatch(ecr);
        Test.stopTest();
        
        List<Leave_Ledger__c> levledList = [Select Id,Name,CompOff_Expired__c FROM Leave_Ledger__c WHERE Id =: levledId];
        for(Leave_Ledger__c levledObj : levledList){
            System.assertEquals(True, levledObj.CompOff_Expired__c);
        }
    }
}