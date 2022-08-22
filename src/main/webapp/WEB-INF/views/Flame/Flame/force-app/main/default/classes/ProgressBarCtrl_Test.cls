@isTest(seeAllData=false)
private class ProgressBarCtrl_Test {

   private static testMethod void test() {
        System.Test.StartTest();
       //  Flame_Community controller = new Flame_Community();
        
       // Flame_Community.getConactInfo(con.id);
         //controller.ContactId =con.id;
     // ApexPages.StandardController controller = new ApexPages.StandardController(con);
      
       ProgressBarCtrl progress = new ProgressBarCtrl();
       
               // Case myCase = new Case(ContactId=con.Id,Origin='Web');
               // insert myCase;
              //  progress.myCase = myCase;
                progress.oldPassword = 'Test1';
                progress.newPassword = 'Test1';
                progress.verifyNewPassword = 'Test1';
                progress.applicationCreated = false;
                progress.redirect();
                progress.CustomIndex();
                progress.CustomSave1();
                progress.CustomSave2();
                progress.CustomSave3();
                progress.CustomSave4();
                progress.CustomSave5();
                progress.CustomSave6();
                progress.CustomSave7();
                progress.CustomSave8();
                progress.CustomSave9();
                progress.CustomSave10();
                progress.CustomSave11();
                progress.CustomSave12();
                progress.CustomSave13();
                progress.CustomSave14();
                progress.CustomSave15();
                progress.CustomSave16();
                progress.CustomSave17();
                progress.CustomSave18();
                String Application_Reference_ID = '123456';
                String appsubmissionStatus='Sucess';
                String applicationCompStages='waiting';
                String applicationCompStages1='Sucess';
                progress.testclass();
               System.Test.StopTest();
        
              
    }
    
}