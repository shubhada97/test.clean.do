public class EmailUtility {

  public static void sendSOPDoc(String AppId, String EmailAddress, String SenderDisplayName, String SubjectName, String FileName) 
  {
    String[] toAddresses = new String[]{EmailAddress};
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    //mail.setFromAddress(toAddresses);
    mail.setToAddresses(toAddresses);
    mail.setSenderDisplayName(SenderDisplayName);
    mail.setSubject(SubjectName);
    
    String body = 'Dear Applicant' +  + ',<BR><br> ';
           body += 'Please find attached a copy of your FLAME University application.<br><br>';
           body += 'Kindly note that this is a system generated email. Do not reply to this communication. <br><br> If you have any question or need help, you can contact us via various channels listed below.<br><UL style="list-style-type:disc;margin-left:2%"><li>Call us toll free at <a href="callto://1800-209-4567">1800-209-4567</a></li><li>Email us at <a style="text-decoration: none;color:#F58634" href="mailto:admission@flame.edu.in">admission@flame.edu.in</a> for admission inquires, or at <a style="text-decoration: none;color:#F58634" href="mailto:techsupport@flame.edu.in">techsupport@flame.edu.in</a> for technical support.</li></ul></li>';
          /* body += 'Sincerely,<br>';
           body += 'FLAME University Admissions Committee';*/
    mail.setHtmlBody(body);
    
    List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();

   for (Attachment a : [select Name, Body, BodyLength from Attachment where ParentId=:AppId and Name =:FileName order By LastModifiedDate limit 1])
   {
       Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
       efa.setFileName(a.Name);
       efa.setBody(a.Body);
       fileAttachments.add(efa);
   } 

   mail.setFileAttachments(fileAttachments);
   
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
   
  }

}