@isTest(seeAlldata=false)
private class Test_ApplicationStatusTest {
    public static Account testAccount;
    public static Contact testContact;
    public static User testUser;
    public static Application__c testApp;
    public static Admit_Card__c testAdmitCard;
    private static void generateTestData(){
        
        Profile testProfile = [select Id From Profile Where Name = 'FLAME- Applicant Community' Limit 1];
        
        testAccount = new Account(Name = 'Test Flame Addmissions');
        insertSObject(testAccount);
        
        testContact = new Contact(LastName = 'Test Contact Test Name',AccountId = testAccount.Id);
        insertSObject(testContact);
        
        testUser = new User(Alias = 'tstand', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='TestUser1', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = testProfile.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com',ContactId = testContact.Id);
        insertSObject(testUser);
        
        testApp = new Application__c(Contact__c  = testContact.Id, Application_Submission_Status__c = 'In-Progress');
        insertSObject(testApp);
        
        testAdmitCard = new Admit_Card__c(Name = 'Test AdmitCard', Application__c = testApp.Id,FUA_Broadcast_Admit_Card__c = true, Reporting_Date__c = System.Date.today(), Contact__c = testContact.Id);
        
        insertSObject(testAdmitCard);
            
        List<Document> docs = new List<Document>();
        Folder folder = [Select id from folder where name='Flame Static Content'];
        Document doc = new Document();
        doc.Name = 'BeforeBroadcastingAdmitCard';
        doc.FolderId = folder.Id;
        doc.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc);
        Document doc1 = new Document();
        doc1.Name = 'AfterBroadcastingAdmitCard';
        doc1.FolderId = folder.Id;
        doc1.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc1);
        insert docs;    
            
            
    }
    private static void insertSObject(SObject testObject){
        
        try{
            insert testObject;
            
        }catch(exception ex){
            
            ex.getMessage();
            System.debug('Error at '+ex.getCause() + ex.getMessage());
        }
    }
    public static testMethod void testApplicationStatus(){
        generateTestData();
        System.runAs(testUser){
           //  FUA_ApplicationStatusController testASC = new FUA_ApplicationStatusController();
            Pagereference testPage = Page.ApplicationStatus;
            Test.setCurrentPage(testPage);
        }
    }
    
}