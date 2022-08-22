@isTest

private class FUA_OnlinePaymentController_Test {
     public static Account testAccount;
    public static Contact testContact; 
    public static User testUser;
    public static Application__c testApp;

    private static void generateTestData(String nationality, String fatherOcc, String motherOcc){
        
        Profile testProfile = [select Id From Profile Where Name = 'FLAME- Applicant Community' Limit 1];
        
        testAccount = new Account(Name = 'Test Flame Addmissions');
        insertSObject(testAccount);
        
        Date birthdate = System.Date.today() - 8030;
        Date passPortExp = System.Date.today() + 365;
        testContact = new Contact(LastName = 'Test Contact Test Name',AccountId = testAccount.Id,Mother_s_First_Name__c = 'testConMother',
                                 Mother_s_Mobile_No__c = '9632587458',Mother_s_Current_Company__c = 'testCompany',Mother_s_Last_Company__c = 'testLastCompany',
                                 Mother_s_Designation__c = 'testDesi',Source__c = 'Word of Mouth',Are_you_an_Indian__c = nationality, Gender__c = 'Male',
                                 Mailing_Address__c = 'test Adress test Address 1',Birthdate = birthdate,Passport_Expiry_Date__c = passPortExp,
                                 Father_s_Occupation__c = fatherOcc, Mother_s_Occupation__c = motherOcc);
        insertSObject(testContact);
        
        testUser = new User(Alias = 'tstand', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='TestUser1', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = testProfile.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com',ContactId = testContact.Id);
        insertSObject(testUser);
        
        testApp = new Application__c(Contact__c  = testContact.Id, Application_Submission_Status__c = 'In-Progress', Completed_Stages__c = 'Program & Test');
        insertSObject(testApp);
    }    
    private static void insertSObject(SObject testObject){
        
        try{
            insert testObject;
           

        }catch(exception ex){
            
            ex.getMessage();
            System.debug('Error at '+ex.getCause() + ex.getMessage());
        }
    }
  
  

}