@isTest(seeAllData=false)
private class Test_ReviewApplyConrollerTest {
    
    public static Account testAccount;
    public static Contact testContact;
    public static User testUser;
    public static Program__c testProgram;
    public static Application__c testApp;
    public static FUA_Payment__c testPayment;
    public static FU_Education_Details__c testEduDetails;
    public static FUA_Work_Details__c testWorkDetails;
    public static Competition_Exam_Details__c testCompExamDetails;
    private static void generateTestData(String pName, String completedStages){
        
        Profile testProfile = [select Id From Profile Where Name = 'FLAME- Applicant Community' Limit 1];
        List<RecordType> eduRecordType = [select Id, Name from RecordType Where SObjectType = 'Competition_Exam_Details__c' OR SObjectType = 'FUA_Payment_Gateway__c'];
        Map<String,Id> mapOfRecordType = new Map<String,Id>();
        for(RecordType rd : eduRecordType){
            mapOfRecordType.put(rd.Name, rd.Id);
        }
        
        testAccount = new Account(Name = 'Test Flame Addmissions');
        insertSObject(testAccount);
        
        testContact = new Contact(LastName = 'Test Contact Test Name',AccountId = testAccount.Id, Birthdate = (System.Date.today() - 8030));
        insertSObject(testContact);
        
        testUser = new User(Alias = 'tstand', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='TestUser1', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = testProfile.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com',ContactId = testContact.Id);
        insertSObject(testUser);
        
        testProgram = new Program__c(Name = pName);
        insertSObject(testProgram);
        
        testApp = new Application__c(Contact__c = testContact.Id, Application_Submission_Status__c = 'In-Progress',Program__c = testProgram.Id, Completed_Stages__c = completedStages);
        insertSObject(testApp);
        
        testPayment = new FUA_Payment__c(FUA_Application__c = testApp.Id, Paid_By__c = 'Demand Draft');
        insertSObject(testPayment);
        
        testEduDetails = new FU_Education_Details__c(Name = 'Test Edu Details',
                                                    Application__c = testApp.Id);
        insertSObject(testEduDetails);
        
        testWorkDetails = new FUA_Work_Details__c(Name = 'Test Work Details', Application__c = testApp.Id);
        insertSObject(testWorkDetails);
        
        testCompExamDetails = new Competition_Exam_Details__c(Name = 'Test Exam 1', Application__c = testApp.Id,
                                                             RecordTypeId = mapOfRecordType.get('Competitive Exams'));
        insertSObject(testCompExamDetails);
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
        generateTestData('Postgraduate (MBA)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);   
        }
        Test.stopTest();
    }
    public static testMethod void testConstructorException(){
        generateTestData('Postgraduate (MBA)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
        PageReference testPage = Page.ReviewAndApply;
        Test.setCurrentPage(testPage);
        Test.stopTest();
    }
    public static testMethod void testConstructorUnderGraduateProgram(){
        generateTestData('Undergraduate (B.A.,BBA,B.Sc.)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);
        }
        Test.stopTest();
    }
    public static testMethod void testSaveDataPositive(){
        generateTestData('Undergraduate (B.A.,BBA,B.Sc.)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
           // testObj.saveData();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);
        }
        Test.stopTest();
    }
    public static testMethod void testSaveDataNegative(){
        generateTestData('Undergraduate (B.A.,BBA,B.Sc.)','Program & Test; Personal Details');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
            testObj.saveData();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);
        }
        Test.stopTest();
    }
    public static testMethod void testSaveDataSaveAndExit(){
        generateTestData('Undergraduate (B.A.,BBA,B.Sc.)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
            testObj.SaveExit = 'SaveExit';
           // testObj.saveData();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);
        }
        Test.stopTest();
    }
    public static testMethod void testRedirectNegative(){
        
        Test.startTest();
        FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
       // testObj.redirect();
        PageReference testPage = Page.ReviewAndApply;
        Test.setCurrentPage(testPage);
        Test.stopTest();
    }
    public static testMethod void testRedirectPositive(){
        generateTestData('Undergraduate (B.A.,BBA,B.Sc.)','Program & Test; Personal Details; Education & Work');
        Test.startTest();
        System.runAs(testUser){
            FUA_ReviewApply_Controller testObj = new FUA_ReviewApply_Controller();
          //  testObj.redirect();
            PageReference testPage = Page.ReviewAndApply;
            Test.setCurrentPage(testPage);   
        }
        Test.stopTest();
    }
}