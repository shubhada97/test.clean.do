@isTest(SeeAllData = true)
global class ledgerpdfgeneratercontroller_Test{

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
        con.id = '0032800000yWyDu';
        con.FirstName = 'Anil';
        con.LastName = 'Dutt';
        con.Email = 'anil@swiftsetup.com';
        insert con;
        
        ledger__c oppNew =  new Ledger__c();
        oppNew.Academic_Year__c = '2018-19';
        oppNew.Amount__c = 16; 
        oppNew.Bank_Ref_No__c = '17';
        oppNew.Branch__c = 'Branc140';
        oppNew.Contact__c = 'a1a0K000001SZQH';
        insert oppNew;
        Blob b = Blob.valueOf('Test Data'); 
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName( quote.Name + '.pdf');
        efa.setBody(b);
        
        Attachment attachment = new Attachment();  
        attachment.ParentId = con.id;  
        attachment.Name = 'Test Attachment for Parent';  
        attachment.Body = b;  
        insert(attachment);
        List<Attachment> attachments = [select id, name from Attachment where parent.id=: con.Id];
        System.assertEquals(1, attachments.size());
        Messaging.SingleEmailMessage mail 
        = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId('00X90000001FNCN'); 
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Apexpages.currentPage().getParameters().put('id',oppNew.Id); 
        ledgerpdfgeneratercontroller.sendEmail(oppNew.id,con.id);
        
    }  
 private static testMethod void myUnitTest() 
    {
        Contact con =  new Contact();
        con.id = '0032800000yWyDu';
        con.FirstName = 'Anil';
        con.LastName = 'Dutt';
        con.Email = 'anil@swiftsetup.com';
        //insert con;

        ledger__c oppNew =  new Ledger__c();
        oppNew.Academic_Year__c = '2018-19';
        oppNew.Amount__c = 16; 
        oppNew.Bank_Ref_No__c = '17';
        oppNew.Branch__c = 'Branc140';
        oppNew.Contact__c = 'a1a0K000001SZQH';
        //insert oppNew;

       
       ledgerpdfgeneratercontroller obj01 = new ledgerpdfgeneratercontroller();
       ledgerpdfgeneratercontroller.sendEmail(oppNew.id,con.id);
       ledgerpdfgeneratercontroller.generatePdf(oppNew.id,con.id);
       
      
       
       
        }
 /* method-9*/







}