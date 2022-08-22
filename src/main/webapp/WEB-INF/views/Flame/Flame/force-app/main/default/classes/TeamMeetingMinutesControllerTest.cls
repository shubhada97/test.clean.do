@isTest
private class TeamMeetingMinutesControllerTest{

    static private Flame_Event__c objFE;
    static private Contact objCon;
    static private Flame_Event__c objFE1;
    static private Contact objCon1;
    static private Account objAcc;
    static private Attachment objAtt;
    static private Attachment objAtt1;
   
 
    static void LoadData() 
    {
         CreateAccount();
         CreateContact();
         CreateFlameEvent();
         CreateAttachment();
        
    }
    
    static void LoadData1() 
    {
         CreateAccount();
         CreateContact();
         CreateContact1();
         CreateFlameEvent1();
         CreateAttachment1();
        
    }
    
    static testMethod void validateMyMeeting() 
    {   
        LoadData();
        TeamMeetingMinutesController objMMC = new TeamMeetingMinutesController();
        objMMC.strContId = objCon.Id;
        TeamMeetingMinutesController.wrapperClass objWC = new TeamMeetingMinutesController.wrapperClass();
            objMMC.showMyTeamMeetingMinutes();
            objMMC.redirectToFlameEvent();
        
  
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
    
    static void CreateContact1()
    {

        Id FuEmployeeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId(); 

        objCon1 = new Contact();
        objCon1.LastName = 'Test';
        objCon1.Email = 'Test@gmail.com';
        objCon1.AccountID = objAcc.Id;
        objCon1.RecordTypeId = FuEmployeeRecordTypeId;
        //objCon1.Manager_To__c =objCon.Id;
        insert objCon1;
       
    }
    static void CreateFlameEvent()
    {
       objFE = new Flame_Event__c();
       //objFE.Meeting_Department__c = 'Department of finance';
       objFE.Meeting_Notes__c = 'TestAcc';
       objFE.Meeting_type__c = 'Yearly Meeting';
       objFE.Contact__c = objCon.Id;
        insert objFE;
    }
    
    static void CreateFlameEvent1()
    {
       objFE1 = new Flame_Event__c();
      // objFE1.Meeting_Department__c = 'Department of finance';
       objFE1.Meeting_Notes__c = 'TestAcc';
       objFE1.Meeting_type__c = 'Yearly Meeting';
       objFE1.Contact__c = objCon1.Id;
        insert objFE1;
    }
    static void CreateAttachment(){
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        objAtt = new Attachment();
        objAtt.Name= 'Test';
        objAtt.body = bodyBlob;
        objAtt.parentID =objFE.Id;
        insert objAtt; 
        
        
    }
   
   static void CreateAttachment1(){
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        objAtt1 = new Attachment();
        objAtt1.Name= 'Test';
        objAtt1.body = bodyBlob;
        objAtt1.parentID =objFE1.Id;
        insert objAtt1; 
        
        
    }
}