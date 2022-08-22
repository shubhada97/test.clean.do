@isTest(seeAllData=false)
private class ProgressBarCtrl_Test1 {

   private static testMethod void test() {
        System.Test.StartTest();
    
       ProgressBarCtrl_1 progress = new ProgressBarCtrl_1();
       
             
                progress.oldPassword = 'Test1';
                progress.newPassword = 'Test1';
                progress.verifyNewPassword = 'Test1';
                progress.applicationCreated = false;
                progress.redirect();
                progress.ApplicationPDFNext();
                progress.changepassword();
                progress.DownloadApplicationPDF();
                progress.saveAllD();
                progress.ApplicationPDFNext();
                String Application_Reference_ID = '123456';
                String appsubmissionStatus='Sucess';
                String applicationCompStages='waiting';
                String applicationCompStages1='Sucess';
              
               System.Test.StopTest();
        
              
    }
    
}