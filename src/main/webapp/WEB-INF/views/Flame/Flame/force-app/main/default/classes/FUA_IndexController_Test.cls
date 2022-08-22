@isTest
private class FUA_IndexController_Test {
  static private Account objAcc;
 static private Contact objCon;
 Static private user objuser;
  public static Account testAccount;
    public static Contact testContact; 
    public static User testUser;
    @testSetup static void setupData(){
       CreateAccount();
       CreateContact();
       Createuser();
    }
     static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
     //  insert objAcc;
    }
      static void Createuser()
    {
      objuser = new User();
      objuser.LanguageLocaleKey='en_US';
      objuser.ContactId = objCon.Id;
      objuser.PortalRole = 'Manager';
      objuser.FirstName = 'Genelia';
      objuser.LastName = 'Dsouza';
        
         
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
     // insert objCon;
    } 
  private static testMethod void test() {
     System.Test.StartTest();
       
    
     Profile testProfile = [select Id From Profile Where Name = 'FLAME- Applicant Community' Limit 1];
        
        testAccount = new Account(Name = 'Test Flame Addmissions');
        //insertSObject(testAccount);
       
        testContact = new Contact(LastName = 'Test Contact Test Name',AccountId = testAccount.Id,Mother_s_First_Name__c = 'testConMother',
                                 Mother_s_Mobile_No__c = '9632587458',Mother_s_Current_Company__c = 'testCompany',Mother_s_Last_Company__c = 'testLastCompany',
                                 Mother_s_Designation__c = 'testDesi',Source__c = 'Word of Mouth');
       // insertSObject(testContact);
        
        testUser = new User(Alias = 'tstand', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='TestUser1', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = testProfile.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com',ContactId = testContact.Id);
      //  insertSObject(testUser);
       Apexpages.StandardController sc = new Apexpages.StandardController( testUser);
       FUA_IndexController ext = new FUA_IndexController(sc);
        ext.addHealth();   
     
       System.Test.StopTest();

       }
}