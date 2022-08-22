@isTest(seeAllData=false)
public class FUA_PaymentGatewayController_Test {
    
     public static void createTestData(){
        Account account = new Account();
        account.Name = 'FLAME 2016-17 Admissions';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        
        contact.Email =  'rohit63419FLAMETEST@gmail.com';        
        insert contact;
        
        FlameUniversitSettings__c data = new FlameUniversitSettings__c();
        data.Name = 'Default';
        data.AccountName__c = 'FLAME 2016-17 Admissions';
        insert data;
        
        Contact contact1 = new Contact();
        contact1.AccountId = account.Id;
        contact1.FirstName = 'Testing';
        contact1.LastName = 'Extentia';
        contact1.Email =  'rmextentia111132322@gmail.com';
        insert contact1;
        }
  public static testMethod void test() {
        System.Test.StartTest();
         Profile p = [SELECT Id FROM Profile WHERE Name='FLAME- Applicant Community'];
        User user = [select id,ContactId,profile.id from User where  profile.id =:p.id limit 1];
     
        System.Test.StopTest();
  }
Public static void PaymentGateway(){
    PageReference pageRef = Page.PaymentGateway;
    pageRef.getParameters().put('encResp','test');
    Test.setCurrentPage(pageRef);
  FUA_PaymentGatewayController obj01 = new FUA_PaymentGatewayController();

}
}