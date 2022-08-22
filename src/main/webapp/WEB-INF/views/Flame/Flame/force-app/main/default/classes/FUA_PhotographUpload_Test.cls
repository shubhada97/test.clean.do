@isTest(SeeAllData=true)
public class FUA_PhotographUpload_Test{
  static private Account objAcc;
  static private Contact objCon;
  static private user user_Obj ;
  static private Application__c application;
  static void setupTestData(){
  CreateAccount();
  CreateContact();
  CreateApplication();
  Test.StartTest();
  List<Application__c> app_Obj =new List<Application__c>
  ([Select Id,Name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name,Contact__c,GD_and_PI_Round__c,
    Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
    FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c from Application__c]);
    System.assertEquals(true,app_Obj.size()>0);
    FUA_PhotographUpload obj01 = new FUA_PhotographUpload();
    //System.assertEquals(null, obj01.fieldValue);
   // obj01.UserID = user_Obj[0];
    obj01.apps = new Application__c();
    obj01.Con = objCon;
   // obj01.community = '01p90000006uk2w';
    obj01.oldPassword = 'test data';
    obj01.newPassword = 'test data';
    obj01.verifyNewPassword = 'test data';
    obj01.saveImage();
    
    PageReference pageRef = Page.PhotographUpload_1;
    pageRef.getParameters().put('Id','app_Obj');
    Test.setCurrentPage(pageRef);
  
  Test.StopTest();
  }
    static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
      //insert objCon;
    } 
    static void createapplication(){
    
    application.contact__c =objCon.id;
    insert application;
    }
}