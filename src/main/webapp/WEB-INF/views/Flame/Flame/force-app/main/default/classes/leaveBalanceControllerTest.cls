@isTest
public class leaveBalanceControllerTest {
     
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
            Username = System.now().millisecond() + 'test2@testerrs.com',
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
            Contact conkk = Flame_TestDataFactory.createContact('Krishnakant','Borse','Staff',
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
            
        }
    }
    
    
    @isTest
    static void testmethod1(){
        
        leaveBalanceController.getAllContacts();
        leaveBalanceController.getContactCatalogue('1', '1', false);
        leaveBalanceController.getContactCatalogue('1', '1', true);
        leaveBalanceController.getProductCatalogueBySearch('1', 'Krishna', '1', false);
        leaveBalanceController.getProductCatalogueBySearch('1', '102', '1', false);
        leaveBalanceController.getProductCatalogueBySearch('1', 'Krishna', '1', true);
        
        list<contact> allContacts = [Select id, Name, Employee_Id__c ,Gender__c ,Primary_Contact_Type__c From Contact];
        
        List<Object> newlist = new List<object>();
        
        Map<Object,Object> jsonMap1 =  new Map<Object,Object>();
        
        jsonMap1.put('Name', allContacts[0].Name);
        jsonMap1.put('Employee_Name__c', allContacts[0].id);
        jsonMap1.put('Primary_Contact_Type__c', allContacts[0].Primary_Contact_Type__c);
        jsonMap1.put('Gender__c', allContacts[0].Gender__c);
        jsonMap1.put('Employee_Id__c', allContacts[0].Employee_Id__c);
        jsonMap1.put('Earn_Leave__c', 1);
        jsonMap1.put('Casual_Leave__c', 2);
        jsonMap1.put('Paternity_Leave__c', -1);
        jsonMap1.put('Faculty_Leave__c', 'NA');
        jsonMap1.put('CompOff_Leave__c', 1);
        
                          
        Map<Object,Object> jsonMap2 =  new Map<Object,Object>();
        
        jsonMap2.put('Name', allContacts[1].Name);
        jsonMap2.put('Employee_Name__c', allContacts[1].id);
        jsonMap2.put('Primary_Contact_Type__c', allContacts[1].Primary_Contact_Type__c);
        jsonMap2.put('Gender__c', allContacts[1].Gender__c);
        jsonMap2.put('Employee_Id__c', allContacts[1].Employee_Id__c);
        jsonMap2.put('Earn_Leave__c', 0);
        jsonMap2.put('Casual_Leave__c', 0);
        jsonMap2.put('Paternity_Leave__c', 1);
        jsonMap2.put('Faculty_Leave__c', '-1');
        jsonMap2.put('CompOff_Leave__c', 1);
        
                          
        Map<Object,Object> jsonMap3 =  new Map<Object,Object>();
        
        jsonMap3.put('Name', allContacts[2].Name);
        jsonMap3.put('Employee_Name__c', allContacts[2].id);
        jsonMap3.put('Primary_Contact_Type__c', allContacts[2].Primary_Contact_Type__c);
        jsonMap3.put('Gender__c', allContacts[2].Gender__c);
        jsonMap3.put('Employee_Id__c', allContacts[2].Employee_Id__c);
        jsonMap3.put('Earn_Leave__c', -1);
        jsonMap3.put('Casual_Leave__c', -2);
        jsonMap3.put('Paternity_Leave__c', 0);
        jsonMap3.put('Faculty_Leave__c', '2');
        jsonMap3.put('CompOff_Leave__c', -1);
        
        newlist.add(jsonMap1);
        newlist.add(jsonMap2);
        newlist.add(jsonMap3);

        system.debug('list size'+newlist.size());
        leaveBalanceController.createLeave(newlist);
        
    }
    
}