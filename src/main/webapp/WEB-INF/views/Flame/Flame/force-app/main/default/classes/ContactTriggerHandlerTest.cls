@isTest
private class ContactTriggerHandlerTest{

    static private Contact objContact;
    static private Comment_History__c  objCH;
 
    static void LoadData() 
    {
        createContact();
    }
    static testMethod void validateRecords() 
    {   
        LoadData();
        objContact.Email     = 'test@gmail.com';
        objContact.MobilePhone     = '38778765473';
        objContact.LinkedIn_profile_URL__c     = 'test1';
        objContact.LinkedIn_profile_URL__c     ='test3';
        objContact.Current_Designation__c     ='test4';
        objContact.Contact_Address_Line_1__c     ='test5';
        objContact.Contact_Address_Line_2__c     ='test6';
        update objContact; 
       
    }
  
    
    static void createContact() {
        Account Acc = new Account();
        acc.name ='testAcc';
        insert acc;
        
        Id contrecordTypeID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Alumni').getRecordTypeId();
        objContact  = new Contact();
        objContact.accountId =acc.id;
        objContact.FirstName = 'Test';
        objContact.RecordTypeid = contrecordTypeID;
        objContact.LastName  = 'Test';
        objContact.Email     = 'test@gmail.com';
        objContact.MobilePhone     = '3877876547';
        objContact.LinkedIn_profile_URL__c     = 'test';
        objContact.Current_Company__c='test';
        objContact.Current_Designation__c     ='test';
        objContact.Contact_Address_Line_1__c     ='test';
        objContact.Contact_Address_Line_2__c     ='test';
        insert objContact;
        
     }
   
}