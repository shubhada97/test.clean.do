@isTest
Public class ApplicationDocumentTrigger_Test {
    public static Account testAccount;
    public static Contact testContact; 
    static private Account objAcc;
    static private Contact objCon;
    static Private Application__c objapp;
    static Private FUA_Applicant_Document__c objdoc;
    
 Public static void setupData(){
       CreateAccount();
       CreateContact();
       CreateApplication();
       CreateDocument();
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
 
  static void CreateDocument()
    {
     
     objdoc = new FUA_Applicant_Document__c();
     objdoc.Application__c =objapp.id;   
       
    }
    
    static void CreateApplication()
    {
       objapp = new Application__c();
       objapp.Contact__c = objcon.id;
     
    }
    private static testMethod void test() {
       Test.StartTest();
                
            
       Test.StopTest();
  
  }
  
  
  
}