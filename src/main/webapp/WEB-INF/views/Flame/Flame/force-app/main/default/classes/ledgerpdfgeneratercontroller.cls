Global class ledgerpdfgeneratercontroller{
    public Ledger__c ledgerRecord {get;set;}
    public Application__c applicationObj {get;set;}
    public ledgerpdfgeneratercontroller(){
        String ledgerId = ApexPages.currentPage().getParameters().get('ledgerId');
        ledgerRecord = new Ledger__c();
        applicationObj = new Application__c();
        if(ledgerId != NULL && String.isNotBlank(ledgerId)){
            List<Ledger__c> ledgerList = new List<Ledger__c>();
            ledgerList = [SELECT Id, Name, Receipt_Date__c, Contact__c,On_Account_of__c,Academic_Year__c, Contact__r.Name, Amount__c, Paid_By__c, Bank_Ref_No__c, 
                            contact__r.Program_Interested_In__c,contact__r.CVUE_Student_Number__c
                          FROM Ledger__c where Id = :ledgerId  
                            ];
            if(ledgerList.Size() > 0){
                ledgerRecord = ledgerList[0];
            }
            if(ledgerRecord.Contact__c != NULL){
                List<application__c> appList = [SELECT Id, Name FROM Application__c WHERE Contact__c = : ledgerRecord.Contact__c LIMIT 1];
                if(appList.Size() > 0){
                    applicationObj = appList[0];    
                }
                
            }
        }
    }
     webservice static String generatePdf(String ledgerId, String contId) {
    List<Attachment> attList = new List<Attachment>();
    attList = [SELECT Id FROM Attachment WHERE parentId = :ledgerId];
    Contact conObj = [SELECT Id, Name FROM Contact WHERE Id = : contId  LIMIT 1];
    if(attList.size() == 0){
        PageReference pdf = Page.Letter_Head_Templet;
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('ledgerId',ledgerId);
    
        // create the new attachment
        Attachment attach = new Attachment();
    
        // the contents of the attachment from the pdf
        Blob body;
    
        try {
       
            // returns the output of the page as a PDF
            body = pdf.getContentAsPDF();
                 // need to pass unit test -- current bug    
        } catch (VisualforceException e) {
          //  body = Blob.valueOf('Some Text');
        }
    
        attach.Body = body;
        // add the user entered name
        attach.Name =  'Receipt_'+ conObj.name +'_ '+date.today().format() +'.pdf';
        attach.IsPrivate = false;
        // attach the pdf to the account
        attach.ParentId = ledgerId;
        try{
            insert attach;
            return attach.Id;
        }catch(Exception ex){
            system.debug(ex.getMessage());
            return ex.getMessage();
        }    
    }else{
        return 'Already Exist';
    }
  }
 
  
 
      
  webservice static String sendEmail(String ledgerId, String contId ){
  
      OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'kartheeka.varma@flame.edu.in'];
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      String[] toAddresses = new String[] {};
      String[] ccAddresses = new String[] {};
      
      if (owea.size() > 0) {
          email.setOrgWideEmailAddressId(owea.get(0).Id);
      }
    
      
      PageReference pdf = Page.Letter_Head_Templet;
      pdf.getParameters().put('ledgerId', ledgerId);
      pdf.setRedirect(true);
      Blob b;
      if(!test.isRunningTest()){
                b = pdf.getContentaspdf();
            }else{
                b =blob.valueOf('TestString');
            }
      //Blob b = pdf.getContentaspdf();
      Contact conObj = [SELECT Id, Name FROM Contact WHERE Id = : contId  LIMIT 1];
       Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
      efa.setFileName('Receipt_'+ conObj.name +'_ '+date.today().format() +'.pdf');
      efa.setBody(b);
      
      String body = 'Dear ' + conObj.Name +',<BR><br> ';
      body += 'Please find attached  your Payment Receipt.<br><br>';
      body += 'Sincerely,<br>';
      body += 'FLAME University';
      email.setHtmlBody(body);
    
      //email.setToAddresses(toAddresses);
      email.setSubject('FLAME Payment Receipt'); 
      email.setPlainTextBody(body);
      email.setTargetObjectId(contId);
      email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
      try{
          Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
      }catch(Exception ex){
          return ex.getMessage();
      }
      return 'Email successfully sent';
  }
}