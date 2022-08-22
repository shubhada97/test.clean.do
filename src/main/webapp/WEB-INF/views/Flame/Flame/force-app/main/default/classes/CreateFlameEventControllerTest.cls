@isTest
private class CreateFlameEventControllerTest{
 
    static private Flame_Event__c objFE;
    static private Attachment objAttach;
    static private Contact objCon;
    static private Account objAcc;
    static private string Base64;
    static private string fileName;
    static private string fileCount;
    
    static void LoadData() 
    {
        
         CreateAccount();
        CreateContact();
        CreateFlameEvent();
        CreateAttachment();
        
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
        objCon.FirstName = 'Test';
        objCon.Email = 'Test@gmail.com';
        objCon.AccountID = objAcc.Id;
        objCon.Department__c ='Adminstrator';
        objCon.RecordTypeId = FuEmployeeRecordTypeId;
        insert objCon;
       
    }
    
    static void CreateFlameEvent(){
        Id meetingRecordTypeId = Schema.SObjectType.Flame_Event__c.getRecordTypeInfosByName().get('Meeting minutes').getRecordTypeId();
        objFE = new Flame_Event__c();
        objFE.Content__c = '14';
        objFE.Event_Date__c = Date.today();
        objFE.Heading__c = 'Headi527';
        objFE.Image__c = '17'; 
        objFE.StartDateTime__c =System.today();
        objFE.IsActive__c = false;
        objFE.RecordTypeId = meetingRecordTypeId;
        objFE.Contact_Department__c='Information Systems';
        //insert objFE;
    }
    static void CreateAttachment(){
        objAttach = new Attachment();
        objAttach.Name = 'Unit Test Attachment Body.pdf';
        Blob fileBody= Blob.valueOf('Unit Test Attachment Body.pdf');
        objAttach.Body = fileBody;
        objAttach.ParentId = objFE.Id; // the record the file is attached to
        //insert  objAttach;
        List<Attachment> listToInsert = new List<Attachment>() ;
        /*objAttach = new Attachment();
        objAttach.Name = objAttach1.Name;
        objAttach.ParentId = objFE.Id; // the record the file is attached to
        objAttach.Body = objAttach1.Body;
        insert objAttach;
        SYSTEM.DEBUG('objAttach@@@'+objAttach);*/
        
    }
    static testMethod void validateSaveMethod() 
    {   
        
         LoadData();
         list<contact> lstofcon = new list<contact>();
        lstofcon.add(objCon);
         CreateFlameEventController objCLEC = new CreateFlameEventController();
          objCLEC.strconId = objCon.id;
         objCLEC.lstofCon = lstofcon;
         objCLEC.objFE = objFE;
        objCLEC.fileCount='1';
         objCLEC.base64 = 'fileBody';
         objCLEC.fileName ='pdf to store';
          objCLEC.startDate = '07/05/2021 12:30 AM';
          
        // objCLEC.myfile = objAttach;
         objCLEC.SaveData();
        objCLEC.saveFile();
        
    }
}