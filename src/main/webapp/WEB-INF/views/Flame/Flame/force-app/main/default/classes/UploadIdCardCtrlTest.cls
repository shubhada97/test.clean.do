@isTest
public class UploadIdCardCtrlTest {
	static testMethod void testMethod1() {
        List <Contact> lstContact = new List<Contact>();
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert  testAccount;
         
         Contact c1=new Contact(
            FirstName='fname',
            LastName = 'lname',
            Email = 'email@gmail.com',
            Blood_Group__c = 'O –ve',
            CVUE_Student_Number__c = '974',
            Student_Batch__c = 'UGLE 2019 - 2022');
            Insert c1;
          lstContact.add(c1);
         
         Test.startTest();
          Test.setCurrentPage(Page.UploadIDCardVF);
          ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstContact);
          stdSetController.setSelected(lstContact);
          UploadIdCardCtrl ext = new UploadIdCardCtrl(stdSetController);
         Test.stopTest();
 	}
}