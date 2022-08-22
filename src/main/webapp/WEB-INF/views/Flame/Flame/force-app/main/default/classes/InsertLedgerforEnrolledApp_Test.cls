/*@isTest(SEEALLDATA=True)
public class InsertLedgerforEnrolledApp_Test{
    public static testMethod void testMethod1(){
    Account accRec=new Account();
            accRec.Name='Flame University';
          insert accRec;
        Contact conRec=new Contact();
            conRec.LastName='Test Last';
            conRec.FirstName='Test First';
            conRec.hed__WorkEmail__c='Test@gmail.com';
            conRec.BirthDate=System.Today();
            conRec.AccountId=accRec.id;
           conRec.Father_s_First_Name__c='Test Fayjer First Bame';
              conRec.Father_s_Last_Name__c='Test Father Last Name';
              conRec.Father_s_Mobile_No__c='1234567891';
              conRec.Father_s_Email_ID__c='testFather@gmail.com';
              conRec.Mother_s_First_Name__c='Test Mother First Name';
              conRec.Mother_s_Last_Name__c='Test Mother Last Name';
             conRec.hed__WorkEmail__c='Test@gmail.com';
             conRec.hed__WorkEmail__c='Test@gmail.com';
              conRec.Mother_s_Mobile_No__c='7894561237';
              conRec.Mother_s_Email_ID__c='testMother@gmail.com';
           conRec.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
            insert conRec;
       Program__c proRec=new Program__c();
           proRec.Name='Test Program';
           proRec.Active__c=true;
           proRec.Program_Code__c='PGB';
           proRec.Program_Type__c='Postgraduate';
        insert proRec;
       Application__c apprec=new Application__c();
           appRec.Program__c=proRec.id;
           appRec.App_Reference_ID__c='XYZ1BCD';
           appRec.Admission_Status__c='Fee Deposited';
           appRec.Contact__c=conRec.id;
         insert appRec; 
      FUA_Payment__c payRec=new FUA_Payment__c();
           payRec.FUA_Application__c=appRec.id;
           payRec.FUA_Order_Status__c='Success';
        insert payRec;     
         appRec.Admission_Status__c='Enrolled'; 
         update appRec;
         
    }

}*/
@isTest(SEEALLDATA=True)
public class InsertLedgerforEnrolledApp_Test{
    public static testMethod void testMethod1(){
    Account accRec=new Account();
            accRec.Name='Flame University';
          insert accRec;
        Contact conRec=new Contact();
            conRec.LastName='Test Last';
            conRec.FirstName='Test First';
            conRec.Email='test1@gmail.com';
            conRec.BirthDate=System.Today();
            conRec.AccountId=accRec.id;
           conRec.Father_s_First_Name__c='Test Fayjer First Bame';
              conRec.Father_s_Last_Name__c='Test Father Last Name';
              conRec.Father_s_Mobile_No__c='1234567891';
              conRec.Father_s_Email_ID__c='testFather@gmail.com';
              conRec.Mother_s_First_Name__c='Test Mother First Name';
              conRec.Mother_s_Last_Name__c='Test Mother Last Name';
             
              conRec.Mother_s_Mobile_No__c='7894561237';
              conRec.Mother_s_Email_ID__c='testMother@gmail.com';
           conRec.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
           // insert conRec;
       Program__c proRec=new Program__c();
           proRec.Name='Test Program';
           proRec.Active__c=true;
           proRec.Program_Code__c='PGB';
           proRec.Program_Type__c='Postgraduate';
        insert proRec;
       Application__c apprec=new Application__c();
           appRec.Program__c=proRec.id;
           appRec.App_Reference_ID__c='XYZ1BCD';
           appRec.Admission_Status__c='Fee Deposited';
           appRec.Contact__c=conRec.id;
         insert appRec; 
      FUA_Payment__c payRec=new FUA_Payment__c();
           payRec.FUA_Application__c=appRec.id;
           payRec.FUA_Order_Status__c='Success';
        insert payRec;     
         appRec.Admission_Status__c='Enrolled'; 
        
         
    }

}