@isTest
private class ShowFilesControllerTest{

    static private Flame_Event__c objFE;
    static private Contact objCon;
    static private Account objAcc;
    static private Attachment objAtt;
   
 
    static void LoadData() 
    {
        CreateAccount();
        CreateContact();
        CreateAttachment(); 
    }
    
    static testMethod void validateController() 
    {   
        LoadData();
        ShowFilesController SFC = new ShowFilesController();
        SFC.strContId = objCon.id;
        SFC.showFiles();
  
    }
    static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    static void CreateContact()
    {

        Id FuEmployeeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId(); 

        objCon = new Contact();
        objCon.LastName = 'Test';
        objCon.Email = 'Test@gmail.com';
        objCon.AccountID = objAcc.Id;
        objCon.RecordTypeId = FuEmployeeRecordTypeId;
        insert objCon;
       
    }
    static void CreateAttachment(){
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        objAtt = new Attachment();
        objAtt.Name= 'Test';
        objAtt.body = bodyBlob;
        objAtt.parentID = objCon.Id;
        insert objAtt; 
        
        
    }
   
}