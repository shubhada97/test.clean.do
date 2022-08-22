@isTest
Public class Researchgrantcontroller_Test{

 static void setupTestData(){
    test.startTest();
    Research__c research_Obj = new Research__c(Rewarded__c = false, Approved__c = false);
    Insert research_Obj; 
  Account portalAccount = new Account(name = 'portalAccount');//create a portal account first
  insert portalAccount;
  Contact portalContact = new contact(LastName = 'portalContact', AccountId = portalAccount.Id); //create a portal contact
  insert portalContact;
  User u1 = new User( email='genelia.dsouza@gmail.com',
                Alias = 'GDS',
                TimeZoneSidKey='America/New_York',
                EmailEncodingKey='ISO-8859-1',
                LocaleSidKey='en_US', 
                LanguageLocaleKey='en_US',
                ContactId = portalContact.Id,
                PortalRole = 'Manager',
                FirstName = 'Genelia',
                LastName = 'Dsouza');
    test.stopTest();
  }
  static testMethod void test_Next_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Rewarded__c,Approved__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Research_Grant_Request_Page;
    pageRef.getParameters().put('input1','test');
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    Researchgrantcontroller obj01 = new Researchgrantcontroller();
    obj01.FinishCommand = 'test data';
    obj01.disabledButton = 'test data';
    obj01.contactId = 'test data';
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.editId = 'test data';
    obj01.downloadId = 'test data';
    obj01.Next();
   // obj01.Saveedit();
   // obj01.Save();
    obj01.download();
    obj01.ClosePopup();
    
    obj01.recordEdited();
  }

}