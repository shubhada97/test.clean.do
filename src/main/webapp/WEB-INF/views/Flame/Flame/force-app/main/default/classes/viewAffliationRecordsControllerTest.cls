@isTest
private Class viewAffliationRecordsControllerTest
{
 static private Account objAcc;
 static private Contact objCon;
 static private hed__Affiliation__c objaff;
 
    static void LoadData() {
        CreateAccount();
        CreateContact();
        CreateAffilcation();
    }
    
    static testMethod void validateController() {   
      LoadData();
        Test.StartTest();
        viewAffliationRecordsController obj = new viewAffliationRecordsController();
        Test.StopTest();
    }
   
    static void CreateAccount(){
        Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('University Body').getRecordTypeId();
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       objAcc.RecordTypeID =devRecordTypeId;
       insert objAcc;
    }
    
    static void CreateContact() {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
       insert objCon;
    }
    
    static void CreateAffilcation() {
       objaff = new hed__Affiliation__c();
       objaff.hed__Account__c = objAcc.id;
       objaff.hed__Contact__c =objCon.id;
       objaff.hed__Role__c ='Student';
       objaff.hed__Status__c ='Current';
       insert objaff;
    }

}