@isTest(SeeAllData = true)
global class dupledgerpdfgeneratercontroller_Test{

/*method-1 */ 
  Public static void setupTestData(){
   
    Contact contact_Obj = new Contact(LastName = 'LastName786', FirstName = 'First106', CVUE_Student_Number__c = 'CVUE_868');
    Insert contact_Obj; 
    Id contId = [Select Id From Contact Limit 1 ].Id;

   Ledger__c ledger_Obj = new Ledger__c(Academic_Year__c = '2018-19', Amount__c = 16, Bank_Ref_No__c = '17', Branch__c = 'Branc140',  Description__c = '21',
    Fee_Type__c = 'SemesterFee', On_Account_of__c = '28', Order_ID__c = 'Order650', Order_Status__c = 'Order678', Paid_By__c = 'Demand Draft',
     Paid__c = false, Partial_Pay__c = false,Charge_1__c = '100',Charge_2__c ='101',Charge_3__c = '102',
      Source__c = 'Mass Import', Sub_Type__c = 'Application Fee', Term_Code__c = '2015/16S1', Tracking_ID__c = 42, Type__c = 'Charge',Charge_4__c = '103',Charge_5__c = '104',
      Charge_6__c = '106',Charge_7__c = '107',Contact__c=contact_Obj.id);
    Insert ledger_Obj; 
    
   
    
  }
 
 /*method-8*/
 Webservice static void sendEmailFunction(string contactId,String ledgerId)
    {
        Contact con =  new Contact();
        con.FirstName = 'Anil';
        con.LastName = 'Dutt';
        con.Email = 'anil@swiftsetup.com';
       
        
        ledger__c oppNew =  new Ledger__c();
        oppNew.Academic_Year__c = '2018-19';
        oppNew.Amount__c = 16; 
        oppNew.Bank_Ref_No__c = '17';
        oppNew.Branch__c = 'Branc140';
        oppNew.Contact__c = '0030K00001lr4l3';
        
        Blob b = Blob.valueOf('Test Data'); 
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName( quote.Name + '.pdf');
        efa.setBody(b);
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId='a1a0K000001T5Lu';
        
        
       
        List<Attachment> attachments = [select id, name from Attachment where parent.id='a1a0K000001T5Lu'];
        System.assertEquals(1, attachments.size());
        Messaging.SingleEmailMessage mail 
        = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId('00X90000001FNCN'); 
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Apexpages.currentPage().getParameters().put('id',oppNew.Id); 
        duplicateledgerpdfgeneratercontroller.sendEmail(oppNew.id,con.id);
        duplicateledgerpdfgeneratercontroller.generatePdf(oppNew.id,con.id);
        Test.StartTest();
        insert attach;
        insert oppNew;
        insert con;
        Test.StopTest();
    }  
 private static testMethod void myUnitTest() 
    {
    
    Account a = new Account();
        a.Name = 'test';
        a.Phone = '789642';
        a.BillingCity= 'bhuj';
        a.BillingPostalCode = '370001';
        a.BillingCountry = 'india';
        a.BillingLatitude = 57.5 ;
        a.BillingLongitude = 67.7;
        a.BillingState = 'Gujarat';
        a.BillingStreet = 'Main';
        
        Contact con =  new Contact();
        con.Accountid = a.id;
        con.FirstName = 'Anil';
        con.LastName = 'Dutt';
        con.Email = 'nikhil_nip@yahoo.co.in';
        //insert con;

        ledger__c oppNew =  new Ledger__c();
        oppNew.Academic_Year__c = '2018-19';
        oppNew.Amount__c = 16; 
        oppNew.Bank_Ref_No__c = '17';
        oppNew.Branch__c = 'Branc140';
        oppNew.Contact__c = '0030K00001lr4l3';
        //insert oppNew;
        Attachment attach=new Attachment();    
        
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.Body=bodyBlob;
        attach.parentId= 'a1a0K000001T5Lu';
        
        
        List<Attachment> attachments=[select id, name,body from Attachment where parent.id='a1a0K000001T5Lu'];
        System.assertEquals(2, attachments.size());


         Test.StartTest();
         insert a;
       //  insert con;
        // insert oppNew;
        // insert attach;
       duplicateledgerpdfgeneratercontroller obj01 = new duplicateledgerpdfgeneratercontroller();
     //  duplicateledgerpdfgeneratercontroller.sendEmail(oppNew.id,con.id);
      // duplicateledgerpdfgeneratercontroller.generatePdf(oppNew.id,con.id);
       
        Test.StopTest();

       
       
        }
 /* method-9*/







}