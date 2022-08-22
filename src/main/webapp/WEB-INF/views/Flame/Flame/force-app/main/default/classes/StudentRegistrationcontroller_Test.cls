@isTest
private class StudentRegistrationcontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Contact contact_Obj = new Contact(LastName = 'LastName216' );
    Insert contact_Obj; 
    test.stopTest();
  }
  static testMethod void test_RegisterUser_UseCase1(){
    List<Contact> contact_Obj  =  [SELECT LastName from Contact];
    System.assertEquals(true,contact_Obj.size()>0);
    PageReference pageRef = Page.Student_Registration_page;
    PageReference pageRef1 = Page.Student_Data_Verification;
    pageRef1.getParameters().put('id','test');
    pageRef.getParameters().put('id','test');
    Test.setCurrentPage(pageRef);
    StudentRegistrationcontroller obj01 = new StudentRegistrationcontroller();
    obj01.conn = contact_Obj[0];
    obj01.contactID = 'test data';
    obj01.StudentNumber = 'test data';
    obj01.TokenNumber = 'test data';
    obj01.ErrorLogin = false;
    obj01.IsCreated = false;
    obj01.IsTicketDetials = false;
    obj01.ischeck = false;
    obj01.RegisterUser();
    obj01.getcontact();
    obj01.datauploaded();
    obj01.popupsubmit();
    Campus_Registration__c setting = new Campus_Registration__c();
    setting.Name = 'Test';
    setting.AccountName__c = 'Test Setting';
    setting.RecordType__c = 'Fu-Student';
    insert setting;
    
    //Check we have error/page messages

    System.assert(ApexPages.hasMessages());
    System.assert(ApexPages.hasMessages());
    System.assert(ApexPages.hasMessages());
    System.assert(ApexPages.hasMessages());
 
 }
 
}