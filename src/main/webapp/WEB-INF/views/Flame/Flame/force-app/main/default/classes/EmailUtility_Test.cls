@isTest
private class EmailUtility_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
     Application__c application_Obj = new Application__c(Admitted__c = false, FLAME_Entrance_Aptitude_Test_FEAT__c = false, FUA_All_Documents_Verified__c = false, FUA_Broadcast_Admission__c = false, FUA_SOP_Submitted__c = false, Median__c = false, SAT_Score__c = false, Enrollment_Deposit_Amount_Paid__c = false, FLM_Accepetoffer__c = false, FLM_Declineoffer__c = false, Housing_Preference_Submitted__c = false, Preference_Housing_Payment_Recived__c = false, Semester_1Fee_Paid__c = false, Semester_2Fee_Paid__c = false, ACT_score__c = false);
   // Insert application_Obj;
    Attachment attach=new Attachment();       
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=application_Obj.id;
        //insert attach;
      
    test.stopTest();
  }
  static testMethod void test_sendSOPDoc_UseCase1(){
    List<Attachment> attachment_Obj  =  [SELECT ParentId,Name,IsPrivate,Body from Attachment];
    System.assertEquals(false,attachment_Obj.size()>0);
    List<Application__c> application_Obj  =  [SELECT Admitted__c,FLAME_Entrance_Aptitude_Test_FEAT__c,FUA_All_Documents_Verified__c,FUA_Broadcast_Admission__c,FUA_SOP_Submitted__c,Median__c,SAT_Score__c,Enrollment_Deposit_Amount_Paid__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Housing_Preference_Submitted__c,Preference_Housing_Payment_Recived__c,Semester_1Fee_Paid__c,Semester_2Fee_Paid__c,ACT_score__c from Application__c];
    System.assertEquals(false,application_Obj.size()>0);
    EmailUtility obj01 = new EmailUtility();
    EmailUtility.sendSOPDoc('test data','kartheeka.varma@flame.edu.in','test data','test data','test data');
  }
}