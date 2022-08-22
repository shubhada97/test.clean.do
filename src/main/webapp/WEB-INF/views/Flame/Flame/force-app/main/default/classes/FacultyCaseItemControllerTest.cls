@isTest
private class FacultyCaseItemControllerTest{

    static private Case objCase;
    static private Item__c objItem;
    static private Contact objCon;
    static private Account objAcc;
    
    static void LoadData() 
    {
        CreateAccount();
        CreateContact();
        CreateCase();
        CreateItem();
    }
    static testMethod void validateFacultyCaseItem() 
    {   
        LoadData();
        FacultyCaseItemController objVIC = new FacultyCaseItemController();
    }
    
    static void CreateCase()
    {
        Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Book Requisition').getRecordTypeId(); 
        
        objCase = new Case();
        objCase.Subject = 'Test';
        objCase.RecordTypeId = caseRecordTypeId ;
        objCase.ContactID = objCon.id;
        insert objCase;
    }
    static void CreateItem()
    {
         objItem = new Item__c();
         objItem.Case__c = objCase.Id;
         objItem.Quantity__c = 1; 
         objItem.Item_Description__c = 'Test';
         insert objItem;
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
    
   
}