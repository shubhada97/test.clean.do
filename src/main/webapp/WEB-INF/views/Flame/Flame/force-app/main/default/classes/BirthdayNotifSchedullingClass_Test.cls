@isTest(SEEALLDATA=True)
public class BirthdayNotifSchedullingClass_Test{
    static testMethod void BirthDayNotify(){
         Test.StartTest();
        BirthdayNotificationSchedullingClass sh1 = new BirthdayNotificationSchedullingClass ();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Apex Batch', sch, sh1); 
        Test.stopTest(); 
    
    }


}