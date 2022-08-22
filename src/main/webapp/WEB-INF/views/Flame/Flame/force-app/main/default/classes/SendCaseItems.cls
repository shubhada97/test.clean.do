/*
 Sharath
 @Dated: 23 Dec 2019
 @Description : This class is called from Process Builder named ()
 In this class sending the pdf to contact email address,There we are using a vf Page Letter_Head_Templet
 
*/

public without sharing class SendCaseItems
{
    @InvocableMethod(label='Send an email from apex class' description='sends an email')
    public static void sendCaseItemasAttachment(list<id> strCaseID)
    {
        System.debug('strCaseID@@@@'+strCaseID);
        Contact objContact;
        User objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
         system.debug('objUser@@@'+objUser.ContactID);    
        if(objUser.ContactID != null){
            objContact = [SELECT Id, Name FROM Contact WHERE Id=:objUser.ContactId];
           
        }
        for(Case objCase :[Select id,casenumber, Case_Approval_Status__c,OwnerId,Owner.email from Case where ID =:strCaseID])
        {
      
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
         
            PageReference pdf = Page.sendViewCaseItems;
            System.debug('!!!@@@pdf@@@'+pdf );
            pdf.getParameters().put('caseid', objCase.id);
            pdf.setRedirect(true);
            Blob b;
            if(!test.isRunningTest()){
                b = pdf.getContentAsPDF();
            System.debug('@@@pdf@@@'+b);
            }
            else{
                b =blob.valueOf('TestString');
            }

            System.debug('pdf@@@'+pdf);
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
           efa.setFileName(objCase.casenumber + ' ' + '.pdf');
           efa.setBody(b);
           String body = 'Dear ' +objContact.Name +',<br><br>';
            body += 'Please find attached details of the book requisition # '+objCase.casenumber+'. <br><br>';
            body += 'Please review the attached details for any updates/changes.<br><br>';
            body += 'Reach out to library@flame.edu.in for any questions/assistance.';
            email.setHtmlBody(body);
           email.setSubject('Book Requisition #'+objCase.casenumber+''); 
           email.setPlainTextBody(body);
           email.setTargetObjectId(objContact.id);
          // string[] toaddress = New String[] {'sharath.thota@flame.edu.in'};
           //email.setToAddresses(toaddress);
           if(objCase.Case_Approval_Status__c =='Pending'){
                email.setCcAddresses(new String[]{objCase.Owner.email});
           }
           
           //email.setToAddresses(toAddresses);
           OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'erphelpdesk@flame.edu.in'];  
               if ( owea.size() > 0 ) 
               { email.setOrgWideEmailAddressId(owea.get(0).Id);}
           
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
             Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            
        }
    }

}