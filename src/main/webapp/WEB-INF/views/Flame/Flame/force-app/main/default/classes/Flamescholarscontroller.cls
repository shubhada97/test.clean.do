Public class Flamescholarscontroller{
Public String profileurl {get;set;}
public List<Contact> contacts {get; set;}
Public List<Contact_Education__c> educations {get;set;}
Public List<Application__c> applications {get;set;}
Public Application__c application {get;set;}
Public Boolean displayPopUp {get;set;}
public string contactId {get; set;}
public string newApplicationId;
public List<Application__c> application1 {get;set;}
//constructer
Public Flamescholarscontroller()
{
application = new Application__c();
//pass the id one vfpage to another
contactId =ApexPages.currentPage().getParameters().get('contactId');
 contacts = [select id,Name, Mother_s_First_Name__c, Mother_s_Mobile_No_Code__c,Date_of_Birth__c,
            Mother_s_Mobile_No__c,MobilePhone,Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
            Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
            Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
            Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
            Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
            Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
            FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
            FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
            Are_you_an_Indian__c,OtherStreet, Contact_Photo__c,Program_Interested_In__c,Contact_Photo_Url__c from contact where id=:contactId LIMIT 1];
            
 educations = [select id,Year_Class__c,Institution_School__c,Degree_Certificate__c,Contact__c,Board_University__c,Year_of_Completion__c,Percent_CGPA_Out_of__c,Percent_CGPA__c,
              Major_Subjects__c,Education_Country__c,Education_City__c,Education_State__c from Contact_Education__c where Contact__c=:contactId order by createdDate ASC Limit 10 ]; 
              
              
    application1 = new List<Application__c>();             
    Id appid = ApexPages.currentPage().getParameters().get('status');
    if(appid != null){
    application1 = [select id,name,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Applicant_Name__c,FUA_Submission_Place__c,
    FUA_Submission_Date__c,Application_Reference_ID__c,Program__r.name from Application__c where id=:appid  limit 1];
    system.debug('>>>>>>>>>>>>>>>>>>>>>>>'+application1);
    }else{
    application1 = [select id,name,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Applicant_Name__c,FUA_Submission_Place__c,
    FUA_Submission_Date__c,Application_Reference_ID__c,Program__r.name from Application__c where contact__r.id=:contactId  limit 1];
    system.debug('>>>>>>>>>>>>>>>>>>>>>>>'+application1);
    }             
    
  
     // to fetch the profile image to display the pdf.
     list<ContentDocumentLink> fethimage = new list<ContentDocumentLink>();
      fethimage = [SELECT ContentDocument.Title,LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =: contactId  and ContentDocument.Title='Profie Image' limit 1];
     
     list<ContentVersion> fethimagecontentversion = new list<ContentVersion>();
     
     if(fethimage.size()> 0 )
     {
     fethimagecontentversion =[Select id from ContentVersion where ContentDocumentId = : fethimage[0].ContentDocumentId   limit 1];
     }  
     if(fethimagecontentversion.size()> 0 )
     {
     profileurl ='/sfc/servlet.shepherd/version/download/' + fethimagecontentversion[0].id ;
     } 
     
     system.debug('profileurl ' + profileurl );   
 }
//submit method.

Public PageReference submit(){
    
    String label =  System.Label.Scholarsprogram;
    String label2 =  System.Label.FSP_Completed_Stages;
    Application__c app = new Application__c();
    Date todaysDate = system.today();
    Id RecordTypeId = Schema.SObjectType.Application__c.getRecordTypeInfosByName().get('FU-Applicant').getRecordTypeId();
    app.Contact__c = ApexPages.currentPage().getParameters().get('contactId');
    app.Program__c = label;
    app.RecordTypeID = RecordTypeId;
    app.FUA_Applicant_Name__c = application.FUA_Applicant_Name__c;
    app.FUA_Submission_Place__c = application.FUA_Submission_Place__c;
    app.Statement_of_Purpose__c = application.Statement_of_Purpose__c;
    app.FUA_Submission_Date__c  = todaysDate;
    app.Achievments__c = application.Achievments__c;
    app.Other_Details__c = application.Other_Details__c;
    app.Application_Submission_Status__c = 'Completed';
    app.Completed_Stages__c =label2;
    app.FUA_SOP_Submitted__c = true;
    //check the duplicate record insert.
    List< Application__c> oldAppList = [Select id,Name,Contact__r.id,Program__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Applicant_Name__c,FUA_Submission_Place__c,
   FUA_Submission_Date__c  from  Application__c where  contact__c=: contactId And Program__c=:System.Label.Scholarsprogram   limit 1 ]; 
    if(oldAppList.size() == 0 ){
    insert app;
    system.debug('>>>>>>>'+app.id);
    displayPopUp= true;
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your application has been successfully submitted.'));  
    }else{
    ApexPages.addmessage (new ApexPages.Message(ApexPages.Severity.ERROR,'You have already applied for the job, please check applied jobs section for status.'));
    }
    if(app.id!= null){
    PageReference pdf = new PageReference('/apex/Flame_popup_message_page?contactId=' + contactId + '&status=' + app.id);   
    pdf.setRedirect(true);  
    return pdf; 
    }
    
   
    return null;
}


public List<Contact> contactlist {get; set;}
public List<Contact_Education__c> edulist {get; set;}
Public List<Application__c> applications1 {get;set;}
Public PageReference closePopup(){
 Id id = ApexPages.currentPage().getParameters().get('contactId');
 system.debug('>>>contact >>>'+id);
 Id appid = ApexPages.currentPage().getParameters().get('status');
 system.debug('>>> appid >>'+appid);

   PageReference pdf;
        pdf  = new PageReference('/apex/Flame_scholars_pdf?contactId=' + id + '&status=' + appid);
        pdf.setRedirect(true);
        Blob body =Test.isRunningTest() ? Blob.valueOf('Test') :  pdf.getContentAsPDF();
    
    Application__c application1 = new  Application__c();
    application1 = [Select id,Name,Contact__r.id,App_Reference_ID__c from  Application__c where  id=: appid AND Contact__r.id =:id limit 1];
    Attachment attach = new Attachment(); 
    attach.parentId = appid;
    system.debug('>>>>>>>2'+appid);
    attach.Name =  'FSP' +'_ '+ application1.App_Reference_ID__c +'_ '+ date.today().format() +'.pdf';
    system.debug('>>>>>>>3'+application1.Name);
    attach.body = body;
    attach.IsPrivate = false;
    insert(attach);
 // send email   
     contact cat= new contact();
     cat =[Select id, Name,Email from contact where id=:contactId limit 1];
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();    
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(cat.Name +'_'+date.today().format() +'.pdf');
        efa.setBody(body);
        String body1 = 'Dear ' + cat.Name +',<BR><br> ';
        body1 += 'Please find attached a copy of your FLAME University application.<br><br>';
        body1 += 'Kindly note that this is a system generated email. Do not reply to this communication. <br><br> If you have any question or need help, you can contact us via various channels listed below.<br><UL style="list-style-type:disc;margin-left:2%"><li>Call us toll free at <a href="callto://1800-209-4567">1800-209-4567</a></li><li>Email us at <a style="text-decoration: none;color:#F58634" href="mailto:admission@flame.edu.in">admission@flame.edu.in</a> for admission inquires, or at <a style="text-decoration: none;color:#F58634" href="mailto:techsupport@flame.edu.in">techsupport@flame.edu.in</a> for technical support.</li></ul></li>';
        body1 += 'Sincerely,<br>';
        body1 += 'FLAME University Admissions Committee';
        email.setHtmlBody(body1);
        String[] ccAddresses = new String[] {'admission@flame.edu.in'};
        Email.setCCAddresses(ccAddresses);
        email.setSenderDisplayName('FLAME University Admissions Committee');
        
        If (cat.Email != null )
        {
        String[] toAddresses = new String[] {cat.Email};
        email.setToAddresses(toAddresses);
        }
        String str = application1.App_Reference_ID__c;
       system.debug(str.right(6)); 
        email.setSubject('FSP' +' - '+ str.right(6) + ' PDF Copy of your FLAME University Application'); 
        email.setPlainTextBody(body1);
        email.setTargetObjectId(contactId);
        system.debug('email'+email);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
        try{
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your are an email has been successfully submitted.'));
        }catch(Exception ex){
        ApexPages.addmessage (new ApexPages.Message(ApexPages.Severity.ERROR,'You have already applied for the job'));
        system.debug('111'+ex.getMessage());
        ex.getMessage();
        }
     
       PageReference pdf1;
        pdf1  = new PageReference('https://my.flame.edu.in/s/login/');
        pdf1.setRedirect(true);
        return pdf1;
}






}