@isTest
private class FUA_Login_Page_Controller_Test {
    public static Account testAccount;
    public static Contact testContact; 
    public static User testUser;
    static private Account objAcc;
 static private Contact objCon;
    @testSetup static void setupData(){
       CreateAccount();
       CreateContact();
    }
     static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
     //  insert objAcc;
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
     // insert objCon;
    } 
    
    private static testMethod void testContructor1(){
     PageReference pageRef = Page.SiteRegisterConfirm;
        Test.setCurrentPage(pageRef);
       
        
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
            FUA_Login_Page_Controller fuaLogin = new FUA_Login_Page_Controller();
            fuaLogin.UserNameErrorMessage = 'TestUserNameErrorMessage';
            fuaLogin.PasswordValidationErrorMessage = 'TestPasswordValidationErrorMessage';
            fuaLogin.LoginUsername = 'testtesttest@test.com';
            fuaLogin.LoginPassword = 'testtesttest';
            fuaLogin.Username = 'rohit63419Test@gmail.com';
            fuaLogin.Email = 'rohit63419Test@gmail.com';
            fuaLogin.Password = 'password';
            fuaLogin.ConfirmPassword = 'password';
            fuaLogin.CommunityNickname = 'password';
            fuaLogin.Program='Postgraduate (MBA)';           
            fuaLogin.SelectedUser  = 'rohit63419Test@gmail.com';
            fuaLogin.Conn = testContact;
            //fuaLogin.Program = 'Test';
            fuaLogin.usermethod();
            fuaLogin.contactmethod();
            fuaLogin.ForgotPass();
            fuaLogin.LandingPage();
            fuaLogin.ForwardToCustomAuthPage();
            fuaLogin.Login();
            fuaLogin.getPrograms();
            fuaLogin.RegisterUser();
            fuaLogin.addHealth();
        System.Test.StopTest();
    }
    }