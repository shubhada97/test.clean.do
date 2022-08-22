public class AdmitCardDetailsHandler {
   
  public static void CreateAdmitCard(Set<Admit_Card__c> admitCardDetails) {
     for(Admit_Card__c ad :admitCardDetails){
          String Body = 'Dear Applicant'+',<BR> <BR>';
                 Body += 'Please find attached your FLAME University Admission Process Admit Card.<br>';  
                // Body += 'If you have any question or need help, you can contact us via various channels listed below.<br>'; 
                 Body += 'Kindly note that this is a system generated email. Do not reply to this communication. <br><br> If you have any questions or need help, you can contact us via various channels listed below.<br><UL style="list-style-type:disc;margin-left:2%"><li>Call us toll free at <a href="callto://1800-209-4567">1800-209-4567</a></li><li>Email us at <a style="text-decoration: none;color:#F58634" href="mailto:admission@flame.edu.in">admission@flame.edu.in</a> for admission inquiries, or at <a style="text-decoration: none;color:#F58634" href="mailto:techsupport@flame.edu.in">techsupport@flame.edu.in</a> for technical support.</li></ul></li>';
                 Body += 'Sincerely,<br>';
                 Body += 'FLAME University Admissions Committee';
                
          sendEmail(ad.Contact__c, ad.Applicant_Email_Address__c, ad.Name+'.pdf', ad.Name, Body);
     }   
  }
  
  @Future(callout=true)
  public static void sendEmail(String ContactId, String EmailId, String AdmitCardName, String Subject, String Body)
  {
        PageReference ref = Page.admitcard;
        ref.getParameters().put('StaticContactId', ContactId);
        ref.setRedirect(true);
        Blob b;
        try {

          if (Test.IsRunningTest()){
                 b=Blob.valueOf('UNIT.TEST');
            }
            else
            {
             b = ref.getContentAsPDF();  
            }
            } catch (VisualforceException e) {
              b = Blob.valueOf('Some Text');
            }
       // Blob b = ref.getContentAsPDF();
        //Get Orgwide Email Address
        List<OrgWideEmailAddress> orgwideIds = [select id,Address,IsAllowAllProfiles,DisplayName from OrgWideEmailAddress where Address = 'admission@flame.edu.in' limit 1];
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName(AdmitCardName);
        efa1.setBody(b);

        String addresses;
        email.setSubject( Subject +String.valueOf(DateTime.now()));
        email.setToAddresses(new String[] {ContactId});
        //email.setPlainTextBody(Body);
        email.setHtmlBody(Body);
        email.setOrgWideEmailAddressId(orgwideIds[0].Id);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
  }
  
  
}