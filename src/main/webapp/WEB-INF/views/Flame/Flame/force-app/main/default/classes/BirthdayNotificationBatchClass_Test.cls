@isTest (SEEALLDATA=TRUE)
public class BirthdayNotificationBatchClass_Test{
    static testMethod void BirthdayNotify(){
        Account accRec=new Account();
            accRec.Name='Flame University';
         insert accRec;
        Contact conRec=new Contact();
            conRec.LastName='Test Last';
            conRec.FirstName='Test First';
            conRec.Email='test@gmail.com';
           // conRec.BirthDate=System.Today();
            conRec.DOB__c=System.Today();
            conRec.AccountId=accRec.id;
            conRec.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
           // insert conRec;
     BirthdayNotificationBatchClass batchASD=new BirthdayNotificationBatchClass();
              Database.BatchableContext bc;
            Test.StartTest();
                batchASD.start(bc);
              //  batchASD.Execute(bc,new List<Contact>{conRec});
                batchASD.finish(bc);
            Test.StopTest();     
    }
}