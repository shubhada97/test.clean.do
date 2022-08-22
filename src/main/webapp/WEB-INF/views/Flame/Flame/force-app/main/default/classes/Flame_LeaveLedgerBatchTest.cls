@isTest
public class Flame_LeaveLedgerBatchTest {
    @isTest
    static void deTest(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=2;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.Earned_Leave_Balance__c=2;
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                contactObj.Date_of_Joining__c = date.parse('11/11/2019');
                contactObj.Classfication_Staff__c = true;
            }
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        try{
            Flame_LeaveLedgerBatch uca = new Flame_LeaveLedgerBatch();
            Id batchId = Database.executeBatch(uca);
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest1(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=3;
                contactObj.Earned_Leave_Balance__c=60;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                contactObj.Date_of_Joining__c = date.parse('15/02/2020');
                contactObj.Classfication_Staff__c = true;
            }
            
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        try{
            Flame_LeaveLedgerBatch uca = new Flame_LeaveLedgerBatch();
            Id batchId = Database.executeBatch(uca);
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest2(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=2;
                contactObj.Earned_Leave_Balance__c=2;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                contactObj.Date_of_Joining__c = date.parse('03/05/2020');
                contactObj.Classfication_Staff__c = true;
            }
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        Leave_Setting__mdt leaveSettingObj=[SELECT Id, Label, Max_Earned_Leave__c, Max_Casual_Leave__c, Monthly_Earned_Leave_Credit__c, Max_Earned_Leave_Carry__c, Max_Casual_Leave_Carry__c, Monthly_Casual_Leave_Credit__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
        Flame_UpdateYearlyLeaveLedger.updateLeaveLedger(listOfContacts, leaveSettingObj);
        Test.stopTest();
    }
    
    @isTest
    static void deTest3(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=null;
                contactObj.Earned_Leave_Balance__c=null;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                contactObj.Date_of_Joining__c = date.parse('02/01/2020');
                contactObj.Classfication_Staff__c = true;
            }
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        
        try{
            Flame_LeaveLedgerBatch uca = new Flame_LeaveLedgerBatch();
            Id batchId = Database.executeBatch(uca);
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest4(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=3;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.Earned_Leave_Balance__c=58;
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                contactObj.Date_of_Joining__c = date.parse('02/01/2020');
                contactObj.Classfication_Staff__c = true;
            }
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        
        try{
            Flame_LeaveLedgerBatch uca = new Flame_LeaveLedgerBatch();
            Id batchId = Database.executeBatch(uca);
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest5(){
        Test.startTest();
        Id RecordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Department').getRecordTypeId();
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<1;i++){
            Account accountObj=new Account();
            accountObj.Name='Tester account'+i;
            accountObj.RecordTypeId=RecordTypeIdAccount;
            accList.add(accountObj);
        }
        insert accList;
        
        List<Contact> listOfContacts=new List<Contact>();
        for(Integer i=0;i<1;i++){
            Contact contactObj=new Contact();
            if(i<1){
                contactObj.lastName='Test kk'+i;
                contactObj.Casual_Leave_Balance__c=5;
                contactObj.Earned_Leave_Balance__c=58;
                contactObj.Primary_Contact_Type__c = 'Staff';
                contactObj.AccountId=accList[i].Id;
                contactObj.Email='kkram'+i+'@gmail.com';
                contactObj.RecordTypeId=RecordTypeIdContact;
                contactObj.Employee_Id__c=101;
                Date Join_Date = Date.newInstance(Date.today().year(), Date.today().month(), (Date.today().Day()-17));
                contactObj.Date_of_Joining__c = Join_Date;
                contactObj.Classfication_Staff__c = true;
            }
            listOfContacts.add(contactObj);
        }
        insert listOfContacts;
        
        try{
            Flame_LeaveLedgerBatch uca = new Flame_LeaveLedgerBatch();
            Id batchId = Database.executeBatch(uca);
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
}