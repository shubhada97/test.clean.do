@isTest(seeAllData=false)
private class Test_PersonalDetailsControllerTest {
    
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
    public static testMethod void testConstructor(){
        
        generateTestData('No','','');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            Apexpages.StandardController sc;
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
        }
        Test.stopTest();
    }
    public static testMethod void testConstructorIndian(){
        
        generateTestData('Yes','','');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            Apexpages.StandardController sc;
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
        }
        Test.stopTest();
    }
    public static testMethod void testConstructorException(){
        
        generateTestData('No','','');
        Test.startTest();
        PageReference testPage = Page.PersonalDetails;
        Test.setCurrentPage(testPage);
        Apexpages.StandardController sc;
        FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
        Test.stopTest();
    }
    public static testMethod void testPicklistValues(){
        
        generateTestData('Yes','','');
        Test.startTest();
        PageReference testPage = Page.PersonalDetails;
        Test.setCurrentPage(testPage);
        Apexpages.StandardController sc;
        FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
        testObj.GetGender();
        testObj.GetNationality();
        testObj.GetCountries();
        testObj.GetOutCountries();
        testObj.GetStates();
        testObj.GetSameAddress();
        testObj.GetFatherOccupation();
        testObj.GetMotherOccupation();
        Test.stopTest();
    }
    public static testMethod void testSaveData(){
        
        generateTestData('Yes','','');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            
            Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
            testObj.AddValue = 'Same as above';
            testObj.SaveData();
            
        }
        Test.stopTest();
    }
    public static testMethod void testSaveData2(){
        
        generateTestData('No','Working','Working');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            
            Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
            testObj.AddValue = '';
            testObj.SaveData();
            
        }
        Test.stopTest();
    }
    public static testMethod void testSaveData3(){
        
        generateTestData('No','Retired','Retired');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            
            Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
            testObj.AddValue = '';
            testObj.SaveData();
            
        }
        Test.stopTest();
    }
    public static testMethod void testSaveData4(){
        
        generateTestData('No','Homemaker','Homemaker');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            
            Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
            testObj.AddValue = '';
            testObj.SaveData();
            
        }
        Test.stopTest();
    }
    public static testMethod void testSaveData5(){
        
        generateTestData('No','Deceased','Deceased');
        Test.startTest();
        System.runAs(testUser){
            PageReference testPage = Page.PersonalDetails;
            Test.setCurrentPage(testPage);
            
            Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
            FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
            testObj.AddValue = '';
            testObj.SaveData();
            
        }
        Test.stopTest();
    }
    public static testMethod void testSaveData6(){
        
        generateTestData('No','Deceased','Deceased');
        Test.startTest();
        PageReference testPage = Page.PersonalDetails;
        Test.setCurrentPage(testPage);
        
        Apexpages.StandardController sc = new ApexPages.StandardController(testContact);
        FUA_PersonalDetailsController testObj = new FUA_PersonalDetailsController(sc);
        testObj.AddValue = '';
        testObj.SaveData();
        Test.stopTest();
    }
}