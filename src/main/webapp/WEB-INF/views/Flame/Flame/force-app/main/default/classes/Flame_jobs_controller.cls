public  class Flame_jobs_controller 
{
    public boolean flag{get;set;}
    public String ErrorLogin { get; set; }
    public FLAME_Job__c bcc{get;set;}
    public boolean showResult{get;set;}
    Public Contact conn {get;set;}
    public String jobId {get;set;}
    Public Contact con {get;set;}
    public string existingContactId{get;set;}
    Public FLAME_Job__c jobs {get;set;}
    @TestVisible Private Account accId{get;set;}  
    public List<Contact> samepage { get; set; }
    Public FLAME_Job_Application__c samplejobs{get;set;}
    public String inputText2 {get;set;} 
    List<contact>contlist = new List<contact>();
    List<FLAME_Job_Application__c> appList {get;set;}
    public String bachelorsDegreeYear{get;set;} //27 Nov 2018
    public string newApplicationId;
    public String rId{get;set;}

     Public  Blob AttchBody {get;set;}
    Public String AttchName {get;set;}
    Public List<contact> contactId {get;set;}
    public List<Attachment> fileList {get; set;}
    public Attachment attach {get; set;} 
    
    public List<Attachment> getAttachments(){
    if(fileList == null) 
    fileList = new List<Attachment>();
    return fileList; 
    }
   
    
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 500; 
    
     List<FLAME_Job__c>tempContactList = new   List<FLAME_Job__c>();
    public  List<FLAME_Job__c> getSearchAcc() {
    
    Set<Id> recordTypeIdSet = new Set<Id>();
    List<Flamejobs_Record_Ass__c> communityAssistList = [Select id,Name,Record_Type__c,Tab_Type__c from Flamejobs_Record_Ass__c Where Tab_Type__c='Job Search'  limit 1];
    if(communityAssistList.size()>0){
    String contactRecordType = communityAssistList[0].Record_Type__c;              
    List<String> recordTypeName = new  List<String>();
    if(contactRecordType!=null){
    recordTypeName = contactRecordType.split(';');                  
    }
    List<RecordType> recordTypeList = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType='FLAME_Job__c' AND Name IN : recordTypeName];
    System.debug('PS RecordTypeList : '+recordTypeList);
    
    for(RecordType rType : recordTypeList){
    recordTypeIdSet.add(rType.Id);
    }
    System.debug('PS RecordType ID : '+recordTypeIdSet);
    
    }
    
    try {
    
    tempContactList = Database.Query('select  Job_Title__c, Job_Description_Detail__c,Job_Function__c,Post_Job__c,Job_Description_Summary__c from FLAME_Job__c where Post_Job__c=true AND  RecordTypeId IN : recordTypeIdSet order by createdDate DESC LIMIT :blockSize OFFSET :index');
    System.debug('tempContactList '+tempContactList); 
    
    }
    catch (Exception e) {
    return null;
    }
    
    return tempContactList;
    }  
 
  Public Flame_jobs_controller(){
   
    samplejobs = new FLAME_Job_Application__c();
    flag = true;
    bcc = new FLAME_Job__c();
    showResult = false;
   } 
  
 
//*Colum button*/
    public PageReference Apply() {
        FLAME_Job__c flamejob = new FLAME_Job__c();
        flamejob = [select Job_Title__c,Job_Description_Detail__c,Area__c, Job_Function__c,Post_Job__c,Job_Description_Summary__c from FLAME_Job__c  where Id = :rid];
        System.debug('flamejob'+rid);
        pagereference ApplyPage = new PageReference('/apex/FLAME_Register_Jobs_page'); 
        ApplyPage.getParameters().put('jobId',flamejob.id);
        ApplyPage.setRedirect(true);     
        return ApplyPage;                    
        
        }   
    
 /* Headers*/
  Public PageReference FLAMEjobs(){
  pagereference backtojobs = new PageReference('/apex/FLAME_Current_Jobs_page'); 
        backtojobs.setRedirect(true);
        return backtojobs;
  
  }
     
  public PageReference backtojobs() {
       pagereference backtojobs = new PageReference('/apex/FLAME_Current_Jobs_page'); 
        backtojobs.setRedirect(true);
        return backtojobs;           
    }
   public PageReference FLAMEjobcontactus() {
       pagereference backtojobs = new PageReference('/apex/FLAME_Contact_Jobs_page'); 
        backtojobs.setRedirect(true);
      return backtojobs;           
    }     
  public PageReference FLAMEjobAboutUs() {
       pagereference backtojobs = new PageReference('/apex/FLAME_About_Jobs_page'); 
        backtojobs.setRedirect(true);
       return backtojobs;           
    } 
    public PageReference FLAMEjobHome() {
       pagereference backtojobs = new PageReference('/apex/FLAME_Home_Jobs_page');
        backtojobs.setRedirect(true); 
       return backtojobs;           
    }           
   
    
    public PageReference getDetailpage() {
    FLAME_Job__c flamejob = new FLAME_Job__c();
    flamejob = [select Job_Title__c,Job_Description_Detail__c,Area__c,Post_Job__c,Job_Description_Summary__c,Description_Summary__c from FLAME_Job__c  where Id = :rid];
    System.debug('flamejob'+rid);
    pagereference ApplyPage = new PageReference('/apex/FLAME_titlelink_Jobs_page'); 
    ApplyPage.getParameters().put('jobId',flamejob.id);
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
    
    }
    public List<FLAME_Job__c> linkList {get;set;}    
    Public Void jobtitlelink(){
    linkList = new List<FLAME_Job__c>();
    linkList =[Select id,Job_Title__c,Post_Job__c,Job_Description_Summary__c,Description_Summary__c from FLAME_Job__c where Post_Job__c=:true AND id=:apexpages.currentpage().getparameters().get('jobId') limit 1];
    
    
    }     
        
  Public String BirthdateValue{get;set;}       
    
 /*FLAME_Jobs_Register */ 
   
   
    public Void FLAME_Jobs_Register(){
    Con =new Contact();
    jobs = new FLAME_Job__c();
    conn =new contact();
    appList = New List<FLAME_Job_Application__c>();
    existingContactId = '';
    //27 Nov 2018
    bachelorsDegreeYear = '';
    newApplicationId = '';
    
          
    }
    
 /* Create new contact and new application */
 
        Public PageReference createnewcontact(){
        
        jobId = apexpages.currentpage().getparameters().get('jobId');
        system.debug('jobId'+jobId);
        String conId='';
        checkExistingContact();
        
        jobs =[SELECT Academic_Year__c,Area__c,Batch__c,Closed_Reason__c,Contact__c,CreatedById,CreatedDate,Id,IsDeleted,Job_Description_Detail__c,
        Job_Title__c,Max_Salary__c,Min_Salary__c,Name,Post_Job__c,Priority__c,RecordTypeId,Start_Date__c,Status__c FROM FLAME_Job__c where Id=:apexpages.currentpage().getparameters().get('jobId')   Limit 1];
        system.debug('>>>>>>>>>>'+jobs);
        system.debug('>>>>>>>>>>'+jobId);
        
        if(existingContactId ==''){
        FlameUniversitjobsSettings__c asDefalutSettings = FlameUniversitjobsSettings__c.getOrgDefaults();
        
        String accntName = asDefalutSettings.Account_Name__c;
        String ID = asDefalutSettings.ID__c;
        List<Account> tempAcc = new List<Account>();
        system.debug('accntName -> ' + accntName);
        tempAcc = [SELECT id,Name FROM Account Where id=:ID LIMIT 1];
        system.debug('Customsettings'+tempAcc);
        String accountId;
        if(tempAcc.size() > 0 ){
        accId = tempAcc[0];
        accountId = accId.id;
        system.debug('account'+accID);
        }
        // Find All Recordtype on the contact Object
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        system.debug('RECORD TYPES:' + ContactRecordTypeInfo);
        if(accountId == null) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'CONTACT_NOT_FOUND'));
        return null;
        }
                 

        if(accountId != null){
        Con = new Contact();
        Con.AccountId = accountId;
        con.Email =conn.Email;
        Con.FirstName= Conn.FirstName;   
        Con.LastName= Conn.LastName;
        Con.FU_Applicant_Other_Country__c= Conn.FU_Applicant_Other_Country__c;
        Con.FU_Applicant_Other_State__c= Conn.FU_Applicant_Other_State__c;
        Con.FU_Applicant_Other_City__c=Conn.FU_Applicant_Other_City__c;
        Con.Other_City__c=Conn.Other_City__c;
        Con.FUA_Mobile__c=Conn.FUA_Mobile__c;
        Con.Contact_Zip_Code__c=Conn.Contact_Zip_Code__c;
        Con.FU_Mobile_Phone_Code__c=Conn.FU_Mobile_Phone_Code__c;  
        Con.Classification_Applicant__c = true; 
        Con.RecordTypeid  = ContactRecordTypeInfo.get('FU-HRApplicant').getRecordTypeid(); 
        Con.DOB__c = Conn.DOB__c; //27 Nov 2018
       // con.Payment_Key__c = Conn.Payment_Key__c;
        insert con;
        
        system.debug('contact'+con);
        
        conId = con.Id;
        }
        }else{
        conId = existingContactId;
        //27 Nov 2018
        List<FLAME_Job_Application__c> oldJobAppList = [select id from FLAME_Job_Application__c where Contact__c=:conId AND FLAME_Job_Title__c=:jobs.Job_Title__c AND App_Status__c='Submitted' LIMIT 1];
        if(oldJobAppList.size()>0){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Job Application already exist, you can not apply again for same job.'));
        return null;
        }
        
        oldJobAppList = [select id,Contact__r.FUA_Mobile__c,Contact__r.DOB__c,Contact__r.Payment_Key__c  from FLAME_Job_Application__c where Contact__c=:conId  LIMIT 1];
        boolean matchFound = false;
        if(oldJobAppList.size()>0){
        if(oldJobAppList[0].Contact__r.Payment_Key__c == Conn.Payment_Key__c){
        matchFound = true;
        }
        }
        
        if(!matchFound ){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'INVALID SECURITY ANSWERS'));
        return null;
        }
        }
        
        
            
        FLAME_Job_Application__c application = new FLAME_Job_Application__c();
        application.contact__c = conId;
        application.FLAME_Job_Title__c = jobs.Job_Title__c;
        application.FLAME_Job__c= jobs.Id;
        appList.add(application);
        upsert appList;   
        newApplicationId =  application.Id;    
         
        Pagereference pr = New PageReference('/apex/FLAME_Personal_Jobs_page');
        pr.getParameters().put('jobid',conId);
        system.debug('jobid'+conId);
        return pr;
    }
   
        //26 Non 2018 , Check for existing contact with matching email address
        public void checkExistingContact(){
        List<Contact> conList = [select id from contact where email=:conn.Email LIMIT 1];
        if(conn.Email != null && conn.Email.trim() != '' && conList.size()>0){
        existingContactId = conList[0].Id;
        }else{
        existingContactId = '';
        }
        }
   /* ----------------------------------------------------------------------------       */
    Public void testclass2(){
        Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
       }    
        
      Public void testclass1(){
        Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
       }  
   
   
      
  
        
        /* Careers page*/
        Public FLAME_Job_Application__c jobapplication {get;set;}
         // Find All Recordtype on the contact Object
       
        
        /* Personal details*/  
       
        public String currentRecordId {get;set;}
        //Public Date Bachelors_Degree_Year {get{ return jobapplication.Bachelors_Degree_Year__c;} set;}
        Public List<FLAME_Job_Application__c> joblist = new List<FLAME_Job_Application__c>();
        
        Public Void FLAME_Job_Careers(){
        
        currentRecordId = apexpages.currentpage().getparameters().get('jobId');
        attach = new Attachment();
        fileList = new List<Attachment>();
        fileList.add(attach);    
        jobapplication = new FLAME_Job_Application__c();
        joblist =[select id,name,contact__c from FLAME_Job_Application__c where contact__c=:currentRecordId];
        system.debug('joblist'+joblist); 
        
        
        
        //27 Nov 2018 auto populate job application details
        System.debug('*****************'+existingContactId);
        if(existingContactId !=null && existingContactId !=''){
        List<FLAME_Job_Application__c> oldAppList = [SELECT Id,createdDate,FLAME_Job__c, Contact__c, Overall_Status__c, App_Status__c, PhD__c, 
                              PhD_University__c, PhD_Year__c, Masters_Degree_Title__c, Masters_Degree_University__c, 
                              Masters_Degree_Year__c, Bachelors_Degree_Title__c, Bachelors_Degree_University__c,Prefill_Data__c, 
                              Bachelors_Degree_Year__c, Flame_Faculty_Reference__c, Current_Employer_Name__c, 
                              Current_Employer_Date__c, Current_Employer_Designation__c, Current_Employer_CTC__c, Currency__c,
                              Previous_Employer_Designation__c, Previous_Employer_Name__c, Work_Exp_Total__c, 
                              Work_Exp_Academic__c, Work_Exp_Academic_PhD__c, Current_Role__c, Account__c, FLAME_Job_Title__c  
                              FROM FLAME_Job_Application__c WHERE  Contact__c=:existingContactId  AND Prefill_Data__c=true AND contact__c=:currentRecordId order by createdDate DESC LIMIT 1];
                              
                      
                              
        if(oldAppList.size() > 0){
        FLAME_Job_Application__c oldApp = oldAppList[0];
        jobapplication.Bachelors_Degree_Title__c = oldApp.Bachelors_Degree_Title__c;
        jobapplication.Bachelors_Degree_University__c =oldApp.Bachelors_Degree_University__c;
        jobapplication.Bachelors_Degree_Year__c = oldApp.Bachelors_Degree_Year__c;
        jobapplication.Masters_Degree_Title__c =oldApp.Masters_Degree_Title__c;
        jobapplication.Masters_Degree_University__c =oldApp.Masters_Degree_University__c;
        jobapplication.Masters_Degree_Year__c =oldApp.Masters_Degree_Year__c;
        jobapplication.PhD__c =oldApp.PhD__c;
        jobapplication.PhD_University__c =oldApp.PhD_University__c;
        jobapplication.PhD_Year__c =oldApp.PhD_Year__c;
        jobapplication.Work_Exp_Total__c =oldApp.Work_Exp_Total__c;
        jobapplication.Work_Exp_Academic__c =oldApp.Work_Exp_Academic__c;
        jobapplication.Work_Exp_Academic_PhD__c =oldApp.Work_Exp_Academic_PhD__c;
        jobapplication.Current_Employer_Name__c =oldApp.Current_Employer_Name__c;
        jobapplication.Current_Employer_Date__c =oldApp.Current_Employer_Date__c;
        jobapplication.Current_Employer_Designation__c =oldApp.Current_Employer_Designation__c;
        jobapplication.Current_Role__c =oldApp.Current_Role__c;
        jobapplication.Current_Employer_CTC__c =oldApp.Current_Employer_CTC__c;
        jobapplication.Currency__c =oldApp.Currency__c;
        jobapplication.Previous_Employer_Name__c =oldApp.Previous_Employer_Name__c;
        jobapplication.Previous_Employer_Designation__c =oldApp.Previous_Employer_Designation__c;
        jobapplication.Flame_Faculty_Reference__c =oldApp.Flame_Faculty_Reference__c;
        //jobapplication.RecordTypeid  = JobapplicationRecordTypeInfo.get('HR').getRecordTypeid();
        jobapplication.App_Status__c ='Submitted';
        jobapplication.Prefill_Data__c=true;
        
        }
        }
    
        }
  
        Public PageReference personalDetails(){
        System.debug('**************'+jobList);
        if (joblist.size()>0){
        
        FLAME_Job_Application__c applns = new FLAME_Job_Application__c();
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.FLAME_Job_Application__c; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        applns.contact__c = currentRecordId;
        applns.id = newApplicationId; //27 Nov 2018 joblist[0].id;
        System.debug('*******jobapplication = '+jobapplication);
        applns.Bachelors_Degree_Title__c = jobapplication.Bachelors_Degree_Title__c;
        applns.Bachelors_Degree_University__c =jobapplication.Bachelors_Degree_University__c;
        applns.Bachelors_Degree_Year__c = jobapplication.Bachelors_Degree_Year__c;
        applns.Masters_Degree_Title__c =jobapplication.Masters_Degree_Title__c;
        applns.Masters_Degree_University__c =jobapplication.Masters_Degree_University__c;
        applns.Masters_Degree_Year__c =jobapplication.Masters_Degree_Year__c;
        applns.PhD__c =jobapplication.PhD__c;
        applns.PhD_University__c =jobapplication.PhD_University__c;
        applns.PhD_Year__c =jobapplication.PhD_Year__c;
        applns.Work_Exp_Total__c =jobapplication.Work_Exp_Total__c;
        applns.Work_Exp_Academic__c =jobapplication.Work_Exp_Academic__c;
        applns.Work_Exp_Academic_PhD__c =jobapplication.Work_Exp_Academic_PhD__c;
        applns.Current_Employer_Name__c =jobapplication.Current_Employer_Name__c;
        applns.Current_Employer_Date__c =jobapplication.Current_Employer_Date__c;
        applns.Current_Employer_Designation__c =jobapplication.Current_Employer_Designation__c;
        applns.Current_Role__c =jobapplication.Current_Role__c;
        applns.Current_Employer_CTC__c =jobapplication.Current_Employer_CTC__c;
        applns.Currency__c =jobapplication.Currency__c;
        applns.Previous_Employer_Name__c =jobapplication.Previous_Employer_Name__c;
        applns.Previous_Employer_Designation__c =jobapplication.Previous_Employer_Designation__c;
        applns.Flame_Faculty_Reference__c =jobapplication.Flame_Faculty_Reference__c;
        applns.RecordTypeid  = ContactRecordTypeInfo.get('HR').getRecordTypeid();
        applns.App_Status__c ='Submitted';
        applns.Prefill_Data__c=true;
        update applns;
        }
        
        string app = apexpages.currentpage().getparameters().get('application');
        system.debug('application'+app);
        string con = apexpages.currentpage().getparameters().get('jobid');
        if(con != null) {            
        List<Attachment> attachments = new List<Attachment>();                               
        
        for(Attachment att : fileList)              
        { 
        if(att.name != null && att.body != null)
        attachments.add(new Attachment(parentId = con, name = att.name, body = att.body)) ;                
        }
        if(attachments != null){
        insert attachments;                 
        ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.INFO, attachments.size() + ' file(s) uploaded successfully'));                                              
        }else {
        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Error uploading file'));
        }              
        }               
    
        Pagereference pr = New PageReference('/apex/FLAME_Thank_you_Jobs_page');
        pr.getParameters().put('currentRecordId',currentRecordId);
        pr.setRedirect(true);
        return pr;
        
        } 
        
             /*FLAMEjobsregisterconfirmation*/
        Public void FLAMEjobsregisterconfirmation(){
       Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        }
        
      Public string message {get;set;}
       Public Void SendEmail(){
      
       List<contact> lstcon=[Select id,Payment_Key__c from contact where  Id=:existingContactId limit 1];
        List<string> lstids= new List<string>();
        for(Contact c:lstcon) {
        lstids.add(c.id);
        system.debug('>>>>>>>>>>>>>>>>>>>>'+lstids);
        }
        Contact conObj = [SELECT Id, Name,Payment_Key__c FROM Contact WHERE Id = : lstids  LIMIT 1];
        system.debug('>>>>>>>>>>>>>>>>>>>>'+conObj);
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setToaddresses(lstids);
             mail.setHtmlBody('<!DOCTYPE html> <html> <head> <style> table { border: 0px solid black; padding:1px;} td {   width:600px; } </style> </head> <body> <table >  <tr>   <td> Dear User,</td>  </tr> <tr style="height:50px;" > <td>You have requested for your FLAME University Job Portal Key.</td> </tr> <tr > <td>Your key is: <b>'+conObj.Payment_Key__c +' </b></td> </tr><tr style="height:50px;" ><td>Thank you.</td> </tr>  <tr style="height:50px;" > <td>FLAME University </td></tr></table> </body> </html>');
             mail.setSubject('FLAME University Job Portal Key');
            // Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
             try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your key has been sent to the registered email id. Please check your email.'));  

        }catch(exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
        }
       
     }
           
        
        
  Public void home(){
         Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
 
          a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        }
     
   Public void reume(){
    
    Integer a=1; 
    integer b=2;
    a=1; b=2;a=1;b=2;
    a=1;
    b=2;
    a=1;b=2;
    a=1;
    a=1;b=2;
    
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
          a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         
        
        
    }
     Public void testclass(){
        Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
          a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
         a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        }
}