@isTest
private class ContactsOnGoogleMapController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Contact contact_Obj = new Contact(LastName = 'LastName664', FirstName = 'First610', HasOptedOutOfEmail = false, Classification_Applicant__c = false, Classification_Student__c = false, Classfication_Withdrawn__c = false, Classification_Alumni__c = false, Classfication_Guest__c = false, Classfication_VIP__c = false, Classfication_Staff__c = false, Classfication_ExStaff__c = false, Classfication_Faculty__c = false, Classfication_ExFaculty__c = false, Classfication_FIL__c = false, Classfication_Vendor__c = false, Save_Withdrawal_Application__c = false, Cheque_Dispatch_Status__c = false, Student_Withdrawal_Completion__c = false, PhD__c = false, Classification_Visiting_Faculty__c = false, Classfication_Adjunct_Faculty__c = false, Send_Mass_Email__c = false, Unsubscribe_from_Mailers__c = false, hed__Deceased__c = false, hed__Do_Not_Contact__c = false, hed__Exclude_from_Household_Formal_Greeting__c = false, hed__Exclude_from_Household_Informal_Greeting__c = false, hed__Exclude_from_Household_Name__c = false, hed__FERPA__c = false, hed__Financial_Aid_Applicant__c = false, hed__HIPAA__c = false, hed__Military_Service__c = false, hed__is_Address_Override__c = false, Classification_Parent__c = false);
    Insert contact_Obj; 
    test.stopTest();
  }
    
}