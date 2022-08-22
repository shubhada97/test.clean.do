@isTest  
private class FUA_Login_Page_Controller_Test1 {
   Public static void setupData(){
        TestDataHandler.createTestData();
    }
     
    

    public  static testMethod void testContructor1(){
        System.Test.StartTest();
         Profile p = [SELECT Id FROM Profile WHERE Name = 'FLAME- Applicant Community' Limit 1];
         User user = [select id, ContactId from User where  ProfileId =: p.Id limit 1];
            system.debug('>>>>>>>>'+user.id);
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
            
            FUA_Login_Page_Controller  fuaLogin = new FUA_Login_Page_Controller ();
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
            fuaLogin.Conn = portalContact;
            //fuaLogin.Program = 'Test';
            
            fuaLogin.ForgotPass();
            fuaLogin.LandingPage();
            fuaLogin.ForwardToCustomAuthPage();
            fuaLogin.Login();
            fuaLogin.getPrograms();
            fuaLogin.RegisterUser();
        
        System.Test.StopTest();
    }
    
  
    

  
}