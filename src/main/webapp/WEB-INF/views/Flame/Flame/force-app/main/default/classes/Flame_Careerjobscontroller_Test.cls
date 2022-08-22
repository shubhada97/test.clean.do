@isTest (seealldata=true)
private class Flame_Careerjobscontroller_Test{
 static private user objuser;
 static private Account objAcc;
 static private Contact objCon;
 static private FLAME_Job__c objjobs ;
 static private FLAME_Job_Application__c objapplication; 
 static void LoadData(){
 Createuser();
 createaccount();
 Createcontact();
 Createflamejobs();
 Createapplication();

}

static void Createuser(){
objuser = new user();
   UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
   Profile studPro = [select id from profile where name = 'Student'];
    objuser.Id = UserInfo.getUserId();
    objuser.ProfileId = studPro.Id;
    objuser.Username = 'test@test.com';
    objuser.Alias = 'test';
    objuser.Email = 't@test.com';
    objuser.FirstName = 'fname';
    objuser.LastName = 'lname';
    objuser.EmailEncodingKey = 'UTF-8';
    objuser.LocaleSidKey = 'en_US';
    objuser.LanguageLocaleKey = 'en_US';
    objuser.TimeZoneSidKey = 'America/Los_Angeles';
   // objuser.ContactId = objCon.Id;
    objuser.CommunityNickname = 'tuser';
   // insert objuser;
  }
static void Createaccount(){
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
}
static void Createcontact(){
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Student').getRecordTypeId();
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
      // insert objCon;

}
static void Createflamejobs(){
   
    objjobs = new FLAME_Job__c();
    objjobs.Job_Title__c = 'test';
    objjobs.Account__c =objAcc.Id;
    objjobs.Contact__c =objCon.Id;
   // objjobs.RecordTypeId = Schema.SObjectType.FLAME_Job__c.getRecordTypeInfosByName().get('Placements').getRecordTypeId();
  //  insert objjobs;

}
static void Createapplication(){
    objapplication = new FLAME_Job_Application__c();
    objapplication.Account__c =objAcc.Id;
    objapplication.Contact__c =objCon.Id;
   
    objapplication.FLAME_Job__c =objjobs.id;
    insert objapplication;

}
 static testMethod void validateController() { 
   // LoadData();
     objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
     objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Student').getRecordTypeId();
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
  
  
   string jobId = apexpages.currentpage().getparameters().get('objjobs.id');
   //List<FLAME_Job__c> flame_job_Obj = [SELECT id from FLAME_Job__c where id=:objjobs.id limit 1];
   //system.debug('flame_job_Obj'+flame_job_Obj);
  
  // id job =flame_job_Obj.get(0).Id;
   PageReference pageRef = Page.Flame_CareerjobslinkPage;
  // System.currentPageReference().getParameters().put('rId', job);
   pageRef.setRedirect(true);
   
    Test.StartTest();
    Flame_Careerjobscontroller flamejobs = new Flame_Careerjobscontroller();
    pageRef.getParameters().put('rId', 'job.id');
    pageRef.getParameters().put('jobId','job.id');
    Test.setCurrentPage(pageRef);
    flamejobs.getSearchAcc();
    flamejobs.contactId = 'test data';
    flamejobs.userDetails = new User();
    flamejobs.userContact = new Contact();
    flamejobs.rId = 'test data';
    flamejobs.jobs = objjobs ;
    flamejobs.payBool = false;
    flamejobs.paymentErrorMsg = 'test data';
    
    flamejobs.message = 'test data';
    flamejobs.DisplayPopup = false;
   // flamejobs.linkList = flame_job_Obj;
    flamejobs.newApplicationId = 'test data';
    flamejobs.jobtitlelink();
    flamejobs.getSearchAcc();
    flamejobs.filter();
    //flamejobs.applylink();
    
    flamejobs.ClosePopup();
    flamejobs.backtojobs();
  //  flamejobs.getDetailpage();
   // flamejobs.save();
   // flamejobs.Apply();
    
    Test.StopTest();
 } 
 
  
 
 

}