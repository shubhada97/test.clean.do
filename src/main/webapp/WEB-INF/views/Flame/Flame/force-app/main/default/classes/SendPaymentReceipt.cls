/*
 Sharath
 @Dated: 27 Feb 2019
 @Description : This class is called from Process Builder named (Ledger With Credit Type Send Email to contact)
 In this class sending the pdf to contact email address,There we are using a vf Page Letter_Head_Templet
 
*/


public class SendPaymentReceipt
{
   // @InvocableMethod(label='Send an email from apex class' description='sends an email')
    @Future(Callout=true)
    public static void sendEmailWithAttachment(string ledger, string source)
    {
        System.debug('ledger@@@@'+ledger);
        for(Ledger__c objLed :[Select id,contact__c,contact__r.Name,Contact__r.Email,contact__r.RecordType.Name from Ledger__c where ID =:ledger and contact__r.RecordType.Name='FU-Student'])
        {
        
           //UpdateLedegerRecord.sendEmailToContact(objLed.id);
            System.debug('objLed@@@'+objLed);
            System.debug('objLed@@@'+objLed.contact__c);
            System.debug('objLed@@@'+objLed.contact__r.Email);

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            PageReference pdf;
            //PageReference pdf = Page.Letter_Head_Templet;
           // PageReference pdf = Page.TestPage;
           // System.debug('!!!@@@pdf@@@'+pdf );
           if(source == 'Payment Portal')
           {
            //   String strPaymentPortalUrl = Label.Payment_Portal_Url;
            String strPaymentPortalUrl ='https://flameu.secure.force.com/Letter_Head_Templet';
            // String strPaymentPortalUrl = 'https://sharath-flameu.cs74.force.com/Letter_Head_Templet';
             System.debug('strPaymentPortalUrl@@@'+strPaymentPortalUrl);
             pdf = new PageReference(strPaymentPortalUrl);
           }
           if(source == 'Community Payment Portal')
           {
              pdf = Page.Letter_Head_Templet;
       
           }
            pdf.getParameters().put('ledgerId', objLed.id);
            pdf.setRedirect(true);
            Blob b;
            if(!test.isRunningTest()){
                b = pdf.getContentAsPDF();
                System.debug('@@@pdf@@@'+b);
            }else{
                b =blob.valueOf('TestString');
            }
            
            System.debug('pdf@@@'+pdf);
            //Blob b = pdf.getContentaspdf();
            Contact conObj = [SELECT Id, Name FROM Contact WHERE Id =: objLed.contact__c  LIMIT 1];
             System.debug('conObj @@@'+conObj.id);
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('Receipt_'+ conObj.Name +'_ '+date.today().format() +'.pdf');
            efa.setBody(b);
      
          String body = 'Dear ' + objLed.contact__r.Name +',<BR><br> ';
          body += 'Please find attached  your Payment Receipt.<br><br>';
          body += 'Sincerely,<br>';
          body += 'FLAME University';
          email.setHtmlBody(body);
        
          //email.setToAddresses(toAddresses);
           OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'tunai@flame.edu.in'];  
               if ( owea.size() > 0 ) 
               { email.setOrgWideEmailAddressId(owea.get(0).Id);}
          email.setSubject('FLAME Payment Receipt'); 
          email.setPlainTextBody(body);
          email.setTargetObjectId(conObj.id);
          email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
            Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
      
    }

}