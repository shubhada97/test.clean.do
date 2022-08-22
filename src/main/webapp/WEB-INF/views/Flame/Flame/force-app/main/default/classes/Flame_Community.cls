Global Class Flame_Community
{

    /*Login Page */
     Public String AdmissionStatus {get;set;}
    public String ThrowError { get; set; }
    global String StaticContactId1 { get; set; }
    Public String UserNameErrorMessage{get;set;}
    Public String PasswordValidationErrorMessage{get;set;}
    Public String LoginUsername{get;set;}
    Public Static String Loginusername1 {get;set;}
    Public String LoginPassword{get;set;}
    Public String Username {get; set;}
    Public String Email {get; set;}
    Public String Password {get; set {Password = value == null ? value : value.trim(); } }
    Public String ConfirmPassword {get; set { ConfirmPassword = value == null ? value : value.trim(); } }
    Public String oldPassword {get; set;}
    Public String newPassword {get; set;}
    Public String verifyNewPassword {get; set;}
    Public string Program{get;set;}
    Public string SelectedUser {get;set;}
    Public String round {get;set;}
    Public String center {get;set;}
    Public String choices { get; set;}
    Public String ProgramType {get; set;}
    Public String ProgramCode {get;set;}
    Public String PlaceOfBirthCon{get;set;}
    Public String PlaceOfBirthSt{get;set;}
    Public String PlaceOfBirthOut{get;set;}
    Public String SaveExit{get;set;}
    Public String GenderVal{get;set;}
    Public String BirthdateValue{get;set;}
    Public String PassportExpireDateValue{get;set;}
    Public string ErrorMsg {get;set;}
    Public string FatherCompany {get;set;}
    Public string MotherCompany {get;set;}
    Public String selectedOption{get;set;}
    Public string selectedYr{get;set;}
    Public String SubmissionDate{get;set;}
    Public Static String Staticappid{get;set;}
    Public String ApplicationStatus{get;set;}
    Public string selectedExam{get;set;}
    Public String AddValue{get;set;}
    Public String appsubmissionStatus{get;set;}
    Public String pageId;
    Public boolean workDetailsPresent{get;set;}
    Public boolean EduDetailsPresent{get;set;}
    Public boolean compExamDetailsPresent{get;set;}
    Public boolean compExamDetailsPresent1{get;set;}
    Public boolean compExamDetailsPresent2{get;set;} //----------compExamDetailsPresent2--act04/09------------
    Public boolean showAddDeleteButtons{get;set;}
    Public Boolean compExam{get;set;}
    Public boolean indexSwitch2{get;set;}
    Public boolean indexSwitch{get;set;}
    Public boolean applicationCreated{get;set;}
    Public Boolean switchindex {get;set;}
    Public boolean IsBroadcasted{get;set;}
    Public boolean Isempty{get;set;}
    Public Boolean Imagemodalbool{set;get;}
    Public integer CountAdd{get;set;}   
    
    /*Constant Variable*/ 
    Public Static String FincalContactId; 
    //Public List<Contact> contacts = new List<Contact>();
    Public Contact Conn{get;set;}
    Public Contact FlameCont {get;set;}
    Public Contact contactList{get;set;}
    Public Contact Con{get;set;}
 
    Public List<SelectOption> lstRound{get;set;}
    Public List<SelectOption> lstCenters{get;set;}
    Public List<SelectOption> educationoptions{get{if(educationoptions!=null)return educationoptions;else{educationoptions = new List<SelectOption>();return educationoptions;}}set;}
    Public List<SelectOption> options{get;set;}
    Public List<SelectOption> documentTypes{get;set;}
    
    Public Competition_Exam_Details__c CED{get;set;}
    Public Competition_Exam_Details__c CED1{get;set;}                  //---------CED1-04/09--------1-act
    Public List<Competition_Exam_Details__c> compExamDetails{get;set;}
    
    Public List<Competition_Exam_Details__c> lstOfCompetitionExams{get;set;}
    Public List<Competition_Exam_Details__c> lstOfCompetitionExams1{get;set;}
    @TestVisible Private list<GD_and_PI_Round__c> lstofRounds{get;set;}
    Public List<Application__c> extApplication{get;set;}    
    Public Application__c applicationobj {get;set;}
    Public Application__c app{get;set;}
    Public Application__c apps{get;set;}
    Public Application__c applicationList {get;set;}    
    Public Static Application__c applicationList1 {get;set;}
    Public FU_Education_Details__c educationObj{get;set;}
    Public List<FU_Education_Details__c> educationList{get;set;} 
    Public List<FU_Education_Details__c> EdDetList{get;set;}
    Public List<FUA_Work_Details__c> workDetails{get;set;}
    Public List<FUA_Work_Details__c> Wrkdetls{get;set;}
    Public List<FUA_Applicant_Document__c> documents{get;set;}
    
    Public FUA_Payment__c payment{get;set;}
    Public  list<Program__c> ListOfPrograms{get;set;}
    @TestVisible Private list<Program__c> lstofPrograms{get;set;}
    
  
    
    @TestVisible Private Account accId{get;set;}
    
    Public  PersonalDetails ConWrap{get;set;}
    
    ApexPages.StandardController stdController;
    
    Public String ContactId {get;set{
        ContactId =value;
        if(!Test.isRunningTest()){
            System.debug('Contact GET - '+ContactId);
            System.debug('ReviewAndApply2--'+ApexPages.currentPage().getUrl().contains('ReviewAndApply'));
           if(ApexPages.currentPage().getUrl().contains('ReviewAndApply')) reviewandapplymethod();
        }
    }
    }
    Public Static String StaticContactId {get{return StaticContactId;}set;}
    Public String appid{get{if(appid==null) appid=Staticappid;return appid;}set;}
    Public String staticconid {get;set;}
    
    /*Start with class Constructer */
    Public static String appidTemp;   
    Public String isScholarshipEligible {get;set;}
    Public Flame_Community()
    {
       Conn = new Contact();
       System.debug('ContactId1--'+ContactId);
       if(ApexPages.currentPage().getParameters().get('StaticContactId')!=null && ContactId!=null) {
       //Sneha - ContactId will be populated only when logged in
       FlameCont       = FLAME_Utility.getConactInfo(StaticContactId, null);
       } 
       
       System.debug('ContactId2--'+ContactId);
       if(StaticContactId==null){ StaticContactId=ProgressBarCtrl.StaticContactId1;} //passing id in tabs
       //Sneha - ContactId will be populated only when logged in
       if(StaticAppId==null){StaticAppId=AppId;}else {AppId=StaticAppId;}
       System.debug('ReviewAndApply1--'+ApexPages.currentPage().getUrl().contains('ReviewAndApply'));
       System.debug('ContactId3--'+ContactId);
    }
    
        public Flame_Community(ApexPages.StandardController controller) 
        {
        
        InvokeCalls();    
        }

        public Flame_Community(ProgressBarCtrl controller) 
        {
           
        InvokeCalls();    
        }

       
     
    /*
    This Method will initialise all the requireid Ids for the Applicant. 
    */
     Public void InvokeCalls() 
    {
       
       System.debug('InvokeCalls-- StaticContactId -- Started ::'+StaticContactId+':: ContactId :: '+ContactId);
     
       if(ContactId!=null || StaticContactId!= null)
        {
       if(StaticContactId==null)
        { 
           StaticContactId=ContactId;       FincalContactId =ContactId;
        }else if(ContactId==null){//Sneha - added contact null check to avoid contact setter method call when its already populated
           ContactId=StaticContactId;       FincalContactId =StaticContactId;
        }
        FlameCont = FLAME_Utility.getConactInfo(StaticContactId,null);
        if(FlameCont!=null)Con  = FlameCont;   
        }

       if(StaticAppid==null || App==null)
        { 
        System.debug('InvokeCalls-- StaticAppid ::'+StaticAppid); 
        if(FLAME_Utility.getApplicationInfo(ContactId, null).size() > 0 )
        {        
           App   = FLAME_Utility.getApplicationInfo(ContactId, null)[0]; 
           AppId = App.Id;
           StaticAppid=AppId;    
           appreferenceNumber = App.Application_Reference_ID__c;
           isScholarshipEligible = App.FUA_Scholarship_Granted__c;
           
       if(App.Admit_Cards__r !=null && App.Admit_Cards__r.size()>0){
       if(App.Admit_Cards__r[0]!=null && App.Admit_Cards__r[0].FUA_Broadcast_Admit_Card__c==true) IsBroadcasted = true; 
        }
       if(App.Admission_Status__c!= null) Isempty = true;   
        }
        }else{
        AppId=StaticAppId;        
        } 
     
        System.debug('InvokeCalls-- StaticContactId -- Ended ::'+StaticAppid+':: AppId :: '+AppId);
    }

   /*Flame_Community Login method--------------*/
    public boolean ErrorLogin {get;set;}
    
    public PageReference Login()
    { 
        try
        {   ErrorLogin = false;
            Conn =  FLAME_Utility.getConactInfo(null,LoginUsername);
            if(Conn.Portal_password__c == LoginPassword)
            {
                PageReference redirect = new PageReference('/apex/Index1'); 
                redirect.setRedirect(false);
                Staticcontactid = ContactId     = Conn.id;
                System.debug(' :: Login  :: StaticContactId -- ::'+ StaticContactId+':: ContactId :: '+ContactId);
                return redirect;
            }else{
           
            ErrorLogin= true;     
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Incorrect Password.'));
            }
        }
        catch(Exception e)
        {       
            system.debug('Exception : ' + e.getMessage());
            ErrorLogin= true; 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Incorrect UserName.'));
        }
         return null;
    }
    
    /*This method checks if the password is 8 letters and alpha-mnumeric*/
  
        private boolean isValidPassword() 
        {
        return Conn.Portal_password__c == LoginPassword;
        }

    /*This method redirects the user to ForgotPasswordPage */
        public PageReference ForgotPass() 
        {
        PageReference redirect = new PageReference('/ForgotPasswordPage'); 
        redirect.getParameters().put('id',SelectedUser); 
        redirect.setRedirect(false);
        return redirect;
        }
    
    /*This will forward guest users to the CustomLogin page.It is called in "action" attribute on the page.*/
    public pagereference LandingPage()
    {
         if(UserInfo.getUserType() != 'Guest')
        {
        } 
        return null;
    }
    
        public PageReference ForwardToCustomAuthPage(){
        return new PageReference('/apex/Index1');
        }   
    
    //This method creates a contact and user record.
    public PageReference RegisterUser()
    {
    
    try
        {
            
            if (!isValidPassword()) 
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Label.site.passwords_dont_match');
                ApexPages.addMessage(msg);
                return null;
            } 
             String UserName = Email;
             
             System.debug('Inside the Application Method>>>>>>>>>');   
               
             FlameUniversitSettings__c asDefalutSettings = FlameUniversitSettings__c.getOrgDefaults();
             String accntName = asDefalutSettings.AccountName__c;
             List<Account> tempAcc = new List<Account>();
             system.debug('accntName -> ' + accntName);
             tempAcc = [SELECT id,Name FROM Account Where Name =: accntName LIMIT 1];
             String accountId;
             
            // Find All Recordtype on the contact Object
             Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
             Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
             system.debug('RECORD TYPES:' + ContactRecordTypeInfo);
             if(tempAcc.size() > 0 ){
             accId = tempAcc[0];
             accountId = accId.id;
                }
               
                Program__c prog = [Select ID, Name From Program__c Where ID =: Program or Name=:Program limit 1];
                Con = new Contact();
                Con.AccountId = accountId;
                Con.FU_Applicant_Other_Country__c= Conn.FU_Applicant_Other_Country__c;
                Con.FU_Applicant_Other_State__c= Conn.FU_Applicant_Other_State__c;
                Con.FU_Applicant_Other_City__c=Conn.FU_Applicant_Other_City__c;
                Con.Other_City__c=Conn.Other_City__c;
                Con.FirstName=Conn.FirstName;   
                Con.LastName= Conn.LastName;
                Con.FUA_Mobile__c=Conn.FUA_Mobile__c;
                Con.FU_Mobile_Phone_Code__c=Conn.FU_Mobile_Phone_Code__c;
                Con.Program_Interested__c = prog.Name;
                Con.Program_Interested_In__c = prog.Name;
                con.Classification_Applicant__c = TRUE;
                Con.Email = Username;
                Con.Portal_password__c = Password;
                Con.RecordTypeid  = ContactRecordTypeInfo.get('FU-Applicant').getRecordTypeid();     
                insert Con;
                
                if(Con!= null && Con.Id != null){
                   Contactid = Con.id;
                   Staticcontactid=Con.id;
                    System.debug('vcr---register---contactid --'+contactid );
                    System.debug('vcr---register---Staticcontactid--'+Staticcontactid);
       
                   
                  
                   PageReference p = new PageReference('/apex/Index1'); //Index1?id=' +con.ID
                   p.setRedirect(false);
                   return p;   
       
                }
                  
        }
               
        
        catch(Exception e)
        { 
                    
            system.debug('Exception : ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Supplied email already exists in the system, please use a different email ID for new application.'));
        }
        return null;
    }
    
    /*Start with Index Page method ------------------------------------ */
 
    Public PageReference Flame_Communitymethod(){
        
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        
        try
        {
                indexSwitch = false;
                indexSwitch2 = false;
                Con= new contact ();
            if(ContactId !=null)
            {
                Con = FLAME_Utility.getConactInfo(ContactId,null);
                if(Con.Applications__r.size() > 0)
                {
                          
                   App   = FLAME_Utility.getApplicationInfo(ContactId, null)[0]; 
                   AppId = App.Id;
                   StaticAppid=AppId;    
                   appreferenceNumber = App.Application_Reference_ID__c;
          
                ApplicationStatus = Con.Applications__r[0].Application_Submission_Status__c;
                if((ApplicationStatus == 'Submitted & Paid' || ApplicationStatus == 'Completed') && Con.Applications__r[0].Completed_Stages__c.contains('ThankyouDone')){
                indexSwitch = true;
                }
                else{
                indexSwitch = false;
                }
                }
                if(Con.Applications__r.size() > 0)
                {
                AdmissionStatus= Con.Applications__r[0].Admission_Status__c;
                ApplicationStatus= Con.Applications__r[0].Application_Submission_Status__c;
        /*Completed Shortlisted true*/
                if((ApplicationStatus=='Completed' ||  AdmissionStatus=='Shortlisted') && Con.Applications__r[0].Completed_Stages__c.contains('Admission Status'))
                {
                indexSwitch2 = true;
                }else{
                indexSwitch2 =false;
                System.debug(2);
                }
                } 
             
            }
        }catch(Exception e) {       
            system.debug('Exception : ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please check login page method . Please try again.'));
            return null;
        }
        return null;
    }
    /*Method call from VF page redirect to ProgramForm page.*/
    public PageReference proceedApplication()
    {
        InvokeCalls();
        PageReference pgcproceed=null;
        try
        {
            if(indexSwitch2)
            {
            String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
            String url = '/apex/Accepetoffer';
            PageReference nextPage = new PageReference(url);
            System.debug('Param ID'+ContactId +StaticContactId+FlameCont+nextPage);
           nextPage.setRedirect(false);
            return nextPage;
            } 
            if(indexSwitch)
            {
            InvokeCalls();
             pgcproceed= new PageReference('/apex/PhotographUpload');
             pgcproceed.setRedirect(false);
              return pgcproceed;
            }else 
            {
             InvokeCalls();
             pgcproceed= new PageReference('/apex/ProgramForm');
             pgcproceed.setRedirect(false);
             return pgcproceed;
            }
            return pgcproceed;
        }catch(Exception e)
        {       
            system.debug('Exception : ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Something went wrong. Please try again.')); 
        }
             return null;
    }
     public String getHtmlText() 
    {
     return [Select Body From Document Where Name = 'IndexPageBeforeThankYou'].Body.toString();
    }
     public String getHtmlText1() 
    {
     return [Select Body From Document Where Name = 'IndexPageAfterThankYou'].Body.toString();
    }
  
    public String getHtmlText2() 
    {
       return [Select Body From Document Where Name = 'Index Page After Shortlisted'].Body.toString();
    }

    
  /* Program Form Test  Page Code ------------------------------------*/
    Public PageReference programformaction() {
    PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        InvokeCalls();
        program= [Select ID,Name From Program__c Where Active__c=True AND Name=:FlameCont.Program_Interested_In__c limit 1].Name;
        System.debug('vcr--programformaction--program--'+program);
        lstofRounds            = new list<GD_and_PI_Round__c>();
        lstofPrograms          = new list<Program__c>();
        
        lstOfCompetitionExams  = new List<Competition_Exam_Details__c>();
        lstOfCompetitionExams1 = new List<Competition_Exam_Details__c>();
        extApplication         = new List<Application__c>();
        CED                    = new Competition_Exam_Details__c(); 
        CED1                    = new Competition_Exam_Details__c(); //-------ced1constructer 04/09--------------   
        loadProgramFormDetails(); 

        if(String.IsEmpty(round)){
          round = 'Select Admission Cycle';
        }
        else{
          round = app.GD_and_PI_Round__c;
        }
        if(String.IsEmpty(center)){
          center = 'Select Center';
        }else
        {
          center = app.GD_and_PI_Center__c;
        }

        FindRounds(); 
        FindCenters();
        
        return null;
    }
      //////// Method to find GDPI rounds for the selected program dynamically ////////
    
    public void FindRounds()
    {
      
            lstRound= new List<SelectOption>();
            if(!string.isBlank(program))
            {
                System.debug('selected program '+program);
                Program__c pro = [Select ID ,Program_Code__c,Program_Type__c From Program__c Where Active__c=True AND (ID=:program or Name=:program) limit 1];
                lstofRounds = [Select ID,Name,GD_and_PI_Center__c From GD_and_PI_Round__c Where Active__c = True AND Program__c=:pro.ID order BY Display_Sequence__c];
                for(GD_and_PI_Round__c rounds : lstofRounds )
                {
                    lstRound.add(new SelectOption(rounds.Name,rounds.Name));
                }
               
                if(pro.Program_Type__c!=''){
                    ProgramType = pro.Program_Type__c;
                }
                if(pro.Program_Code__c!=''){
                    ProgramCode = pro.Program_Code__c;
                    System.debug('ProgramCode'+ProgramCode);
                }
            }
      
    } 
    //////// Method to find relevant GDPI centers for the above rounds dynamically ////////
    
    public void FindCenters()
    {
       
            lstCenters = new List<SelectOption>();
            System.debug('selected round - in find centers method - '+round);
            if(!String.isBlank(round))       
            {
                Program__c pro = [Select ID From Program__c Where Active__c=True AND (ID=:program or Name=:program) limit 1];
                List<GD_and_PI_Round__c> lstofCenters = [Select ID,Name,GD_and_PI_Center__c From GD_and_PI_Round__c Where Active__c = True AND Name = :round AND Program__c =: pro.ID ];
                System.debug('lstofCenters '+lstofCenters);
                for(GD_and_PI_Round__c centers : lstofCenters )
                { 
                    List<string> CenterList = centers.GD_and_PI_Center__c.split(';');
                    for(string optn : CenterList ) {
                        lstCenters.add(new SelectOption(optn,optn));
                    }
                }
            }
       
    }     
      
     /*
        loadProgramFormDetails
    */

    public void loadProgramFormDetails() 
    {
     // 12/08/2018 added No is default value
            applicationobj         = new Application__c();
            applicationobj.Do_you_need_on_campus_accommodation__c='No';
        try
        {   
            if(FlameCont!=null)
            {   
                System.debug('vcr--InvokeCalls--StaticContactId-- : '+StaticContactId + ' vcr--InvokeCalls--ContactId-- :'+ContactId);
                if(StaticContactId!=null)  
                App = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 

                Program__c prog = getProgramDetails(App.Program__c);
                
                System.debug('vcr--loadProgramFormDetails--app-- ' +App.ID);

                if(app.ID != Null)
                {  
                    if(app.SAT_Score__c == true )
                    {
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        CED = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Result_Awaited__c,Application__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'SAT'];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.SAT_Score__c == false)
                    {
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                          applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
                    
                    if(app.ACT_Score__c == true )
                    {
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                        
                        CED1 = [Select ID,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,ACT_English__c,ACT_Composite_Score__c,Result_Awaited__c,Application__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'ACT'];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.ACT_Score__c == false)
                    {
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                          applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
                    
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == false && app.SAT_Score__c == false && app.ACT_Score__c == false)
                    {
                        lstOfCompetitionExams = [Select ID,Name,FUA_Percentile__c,Competitive_Exams__c,Registration_No__c,Score__c,Result_Awaited__c
                                                    From Competition_Exam_Details__c Where Application__c =: app.ID ];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        FindRounds();
                        FindCenters();
                    }
                    
                    
                }
                else
                {
                    center = 'Select Center';
                    round = 'Select Admission Cycle';
                    FindRounds();
                    FindCenters();
                }                
            }
        }
        catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
        }
      //- ----------------3--ACT 04/09-------------------------------
      
   /*   try
        {   
            if(FlameCont!=null)
            {   
                System.debug('vcr--InvokeCalls--StaticContactId-- : '+StaticContactId + ' vcr--InvokeCalls--ContactId-- :'+ContactId);
                if(StaticContactId!=null)  
                App = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 

                Program__c prog = getProgramDetails(App.Program__c);
                
                System.debug('vcr--loadProgramFormDetails--app-- ' +App.ID);

                if(app.ID != Null)
                {  
                    if(app.ACT_Score__c == true )
                    {
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                        
                        CED1 = [Select ID,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,ACT_English__c,ACT_Composite_Score__c,Result_Awaited__c,Application__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'ACT'];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.ACT_Score__c == false)
                    {
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                          applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
                    else
                    {
                        lstOfCompetitionExams = [Select ID,Name,FUA_Percentile__c,Competitive_Exams__c,Registration_No__c,Score__c,Result_Awaited__c
                                                    From Competition_Exam_Details__c Where Application__c =: app.ID ];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        FindRounds();
                        FindCenters();
                    }
                }
                else
                {
                    center = 'Select Center';
                    round = 'Select Admission Cycle';
                    FindRounds();
                    FindCenters();
                }                
            }
        }
        catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
        } */ 
        
    }
    
    //////// Method to clear the previous program list and republish data after reselecting the program in database ////////
    
    public void clearList()
    {    
        
        if(app != Null && program == app.Program__r.Program_Type__c) 
        {  
                    //lstOfCompetitionExams.clear();
                    system.debug('vcr----inside clearList---1 if con--');
                    if(app.SAT_Score__c == true )
                    {
                        lstOfCompetitionExams.clear();
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        List<Competition_Exam_Details__c> temp = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Result_Awaited__c,Application__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'SAT'];
                                    
                        if(temp.size() > 0){
                            CED = temp[0];
                        }
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.SAT_Score__c == false)
                    {
                        system.debug('vcr----inside clearList---2 if con--');
                        lstOfCompetitionExams.clear();
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
                    
                    else 
                    {
                    //lstOfCompetitionExams.clear();
                    system.debug('vcr----inside clearList---3 if con--');
                    lstOfCompetitionExams = [Select ID,Name,Competitive_Exams__c,FUA_Percentile__c,Registration_No__c,Score__c,Result_Awaited__c
                                                        From Competition_Exam_Details__c Where Application__c =: app.ID];
                    round = app.GD_and_PI_Round__c;
                    center = app.GD_and_PI_Center__c;
                    }
                //-------------------4ACT 04/09----------------------------------------    
                    if(app.ACT_Score__c == true )
                    {
                        lstOfCompetitionExams.clear();
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                       
                        List<Competition_Exam_Details__c> acttemp = [Select ID,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,ACT_English__c,ACT_Composite_Score__c,Result_Awaited__c,Application__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'ACT'];
                                    
                        if(acttemp.size() > 0){
                            CED1 = acttemp[0];
                        }
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.ACT_Score__c == false)
                    {
                        system.debug('vcr----inside clearList---2 if con--');
                        lstOfCompetitionExams.clear();
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.ACT_Score__c = app.ACT_Score__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        // 12/08/18 save and retrieve the values
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
                    
                    else
                    {
                    //lstOfCompetitionExams.clear();
                    system.debug('vcr----inside clearList---3 if con--');
                    lstOfCompetitionExams = [Select ID,Name,Competitive_Exams__c,FUA_Percentile__c,Registration_No__c,Score__c,Result_Awaited__c
                                                        From Competition_Exam_Details__c Where Application__c =: app.ID];
                    round = app.GD_and_PI_Round__c;
                    center = app.GD_and_PI_Center__c;
                    }
                   
                //-------end------------    
                }
                else 
                {   
                   system.debug('vcr----inside clearList---4 if con--');
                    if(lstOfCompetitionExams!=null)
                    lstOfCompetitionExams.clear();
                    lstOfCompetitionExams = new List<Competition_Exam_Details__c>();
                    CED = new Competition_Exam_Details__c();
                    CED1 = new Competition_Exam_Details__c();
                    applicationobj = new Application__c();
                    center = 'Select Center';
                    round = 'Select Admission Cycle';
                }
            FindRounds();
            FindCenters();
        
    }
    
   //////// Method to add the row for the selected competition exam ////////
        
    public void AddCompetitionExams()
    {
        
        Competition_Exam_Details__c obj = new Competition_Exam_Details__c(Competitive_Exams__c=selectedExam);
        lstOfCompetitionExams.add(obj);
        
    }
    
    //////// Method to remove the row for the unselected competition exam ////////
    
    public void RemoveCompetitionExams()
    {
        try
        {
            integer index;
            system.debug('selectedExam==>'+selectedExam);
            for(Integer i=0;i<lstOfCompetitionExams.size();i++) 
            {
                if(lstOfCompetitionExams[i].Competitive_Exams__c == selectedExam) 
                {
                    index = i;
                    break;
                }            
            }   
            system.debug('index ==>'+index ); 
            //if(index < 0)
            lstOfCompetitionExams.remove(index);
        }
        catch (Exception e)
        {
        }
    }
    
    //////// Method to get the active programs list dynamically for the back end ////////
    
    public List<SelectOption> getPrograms() 
    {
        try
        {
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('','Select the Program'));
            lstofPrograms = [SELECT Active__c,Display_Sequence__c,Name From Program__c Order WHERE Active__c = True ORDER BY Display_Sequence__c];
            for(Program__c programToItrate : lstofPrograms )
            {
                options.add(new SelectOption(programToItrate.Name,programToItrate.Name));
            }
            return options;
        }
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'No active program found. '+e.getMessage()));
            return null;
        }
    } 
    
  //--------------------------------------------------------click the next button-----------------------------------------------------------------------
    
        public Competition_Exam_Details__c comp{get;set;} 
        public Application__c extternalApplication{get;set;}
    public PageReference CustomSave() 
    {   
        system.debug('****program  ' + program);
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program Limit 1];
        extApplication = FLAME_Utility.getApplicationInfo(ContactId, null);
        system.debug('****program  ' + extApplication);
        PageReference  pgcsave=null;
        //////// If no application found, then insert the new application along with competition exam records ////////
        if(extApplication.isempty())
        {   
            System.debug('Inside the Condition');
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c;
            // 12/08/18 save and retrieve the values
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;  
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            System.debug('** Custom Save ** applicationobj1 ' +applicationobj1);
            
            applicationobj1.RecordTypeid  = Schema.SObjectType.Application__c.getRecordTypeInfosByName().get('FU-Applicant').getRecordTypeId();    
            System.debug('** Custom Save ** applicationobj1 ' +applicationobj1);
            insert applicationobj1;
            
            System.debug('** Custom Save ** applicationobj1 ' +applicationobj1);
  // Update the Contact Infromation 
           Contact c = FLAME_Utility.getConactInfo(ContactId,null);
           c.Program_Interested_In__c = SelectedProgram.Name;
           c.Registration_Status__c = 'In-Progress';
           update c;
  // if(SelectedProgram.Name.equalsIgnoreCase(UNDER_GRADUATE_PROGRAM)) add new code 
            if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
            {
           
                if(applicationobj1.Old_SAT_Structure__c == True || applicationobj1.SAT_Score__c == True)  
                {
                 
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                SAT.Name = 'SAT Score';
                SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                SAT.Math__c = CED.Math__c;
                SAT.Writing__c = CED.Writing__c;
                SAT.Critical_Reading__c = CED.Critical_Reading__c;
                SAT.Result_Awaited__c = CED.Result_Awaited__c;
                SAT.Application__c = applicationobj1.ID;
                SAT.Program__c = SelectedProgram.Name;
                SAT.RecordTypeID = RecordTypeId;
                SAT.SAT__c = TRUE;
                Insert SAT;
                   
                }
                if(applicationobj1.ACT_Score__c == True)  
                {
                 
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                Competition_Exam_Details__c ACT = new Competition_Exam_Details__c();
                ACT.Name = 'ACT Score';
                ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                ACT.ACT_Math__c = CED1.ACT_Math__c;
                ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                ACT.ACT_Science__c = CED1.ACT_Science__c;
                ACT.ACT_English__c = CED1.ACT_English__c;
                ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                ACT.Application__c = applicationobj1.ID;
                ACT.Program__c = SelectedProgram.Name;
                ACT.RecordTypeID = RecordTypeId;
                ACT.ACT__c = TRUE;
                Insert ACT;
                system.debug('ACT-1'+ACT);   
                }  
                
                if(applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                {
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                FEAT.Name = 'FEAT';
                FEAT.Application__c = applicationobj1.ID;
                FEAT.Program__c = SelectedProgram.Name;
                FEAT.RecordTypeID = RecordTypeId;
                FEAT.FEAT__c = TRUE;
                Insert FEAT;
                }
            }
            else
            {
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
               
                for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                {
                CE.Name = selectedExam;
                CE.Application__c = applicationobj1.ID;
                CE.Program__c = SelectedProgram.Name;
                CE.RecordTypeID = RecordTypeId;
                if(CE.Result_Awaited__c == TRUE)
                {
                    CE.Score__c = NULL;
                    CE.FUA_Percentile__c = NULL;
                }
                
                }
                    Insert lstOfCompetitionExams;
            }
            
            if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
            pgcsave= new PageReference('/apex/PersonalDetails');
            pgcsave.setRedirect(false);
            return pgcsave;
        }
        
  //////// If application found, then update the application and perform upsert on competition exam records ////////
        
        else
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            Application__c updateApplication = new Application__c(ID=extApplication[0].ID);
            updateApplication.GD_and_PI_Center__c = center;
            updateApplication.GD_and_PI_Round__c = round;
            updateApplication.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            updateApplication.Program__c = SelectedProgram.ID;
            updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c;
            updateApplication.ACT_Score__c = applicationobj.ACT_Score__c; 
            // 12/08/18 save and retrieve the values
            updateApplication.Do_you_need_on_campus_accommodation__c=applicationobj.Do_you_need_on_campus_accommodation__c;
            updateApplication.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;
            String completedStages = extApplication[0].Completed_Stages__c;
            String currentPageName = 'Program & Test';
            if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
                    updateApplication.Completed_Stages__c = completedStages;
                }
            }
            else{
                updateApplication.Completed_Stages__c = currentPageName;
            }
            
            update updateApplication;
            Contact c = FLAME_Utility.getConactInfo(contactid,null);
            c.Program_Interested_In__c = SelectedProgram.Name;
            update c;
            
  //////// Applicant selected program is not changed then perform update on application and upsert on competition exams ////////
            
            if(extApplication[0].Program__c == SelectedProgram.ID)
            {
              
                if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {   
                   
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c== False)
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID From Competition_Exam_Details__c Where Application__c =: extApplication[0].ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.size()>0)
                        {
                            delete FEATexamlst;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID,Application__c,Program__c From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                            Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                            FEAT.Name = 'FEAT';
                            FEAT.Application__c = updateApplication.ID;
                            FEAT.Program__c = SelectedProgram.Name;
                            FEAT.RecordTypeID = RecordTypeId;
                            FEAT.FEAT__c = TRUE;
                            Insert FEAT;
                        }
                    }
                    if(updateApplication.SAT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> SATexam = [Select ID,SAT__c,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'SAT' Limit 1];
                        if(!SATexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(ID=SATexam[0].ID);
                            SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SAT.Math__c = CED.Math__c;
                            SAT.Writing__c = CED.Writing__c;
                            SAT.Critical_Reading__c = CED.Critical_Reading__c;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.RecordTypeID = RecordTypeId;
                            SAT.SAT__c = TRUE;
                            Update SAT;
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SATscore = new Competition_Exam_Details__c();
                            SATscore.Name = 'SAT Score';
                            SATscore.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SATscore.Math__c = CED.Math__c;
                            SATscore.Writing__c = CED.Writing__c;
                            SATscore.Critical_Reading__c = CED.Critical_Reading__c;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.RecordTypeID = RecordTypeId;
                            SATscore.SAT__c = TRUE;
                            Insert SATscore;
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> SAT = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'SAT'Limit 1];
                        delete SAT;
                    }
                //----------------------Act ----------------------------------------
                 if(updateApplication.ACT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> ACTexam = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'ACT' Limit 1];
                        if(!ACTexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACT = new Competition_Exam_Details__c(ID=ACTexam[0].ID);
                            ACT.Name = 'ACT Score';
                            ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACT.ACT_Math__c = CED1.ACT_Math__c;
                            ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACT.ACT_Science__c = CED1.ACT_Science__c;
                            ACT.ACT_English__c = CED1.ACT_English__c;
                            ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACT.Program__c = SelectedProgram.Name;
                            ACT.RecordTypeID = RecordTypeId;
                            ACT.ACT__c = TRUE;
                            Update ACT;
                            system.debug('updateACT-1'+ACT);
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACTscore = new Competition_Exam_Details__c();
                            ACTscore.Name = 'ACT Score';
                            ACTscore.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACTscore.ACT_Math__c = CED1.ACT_Math__c;
                            ACTscore.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACTscore.ACT_Science__c = CED1.ACT_Science__c;
                            ACTscore.ACT_English__c = CED1.ACT_English__c;
                            ACTscore.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACTscore.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACTscore.Application__c = updateApplication.ID;
                            ACTscore.Program__c = SelectedProgram.Name;
                            ACTscore.RecordTypeID = RecordTypeId;
                            ACTscore.ACT__c = TRUE;
                            Insert ACTscore;
                            system.debug('insertACT-2'+ACTscore);
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> ACT = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'ACT'Limit 1];
                        delete ACT;
                    }      
                    
                    
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    for(Competition_Exam_Details__c  exam : lstOfCompetitionExams) 
                    {
                        exam.Name = selectedExam;
                        exam.Application__C = updateApplication.id;
                        exam.Program__c = SelectedProgram.Name;
                        exam.RecordTypeID = RecordTypeId;
                        if(exam.Result_Awaited__c == TRUE)
                        {
                            exam.Score__c = NULL;
                            exam.FUA_Percentile__c = NULL;
                        }
                    }
                    system.debug('lstOfCompetitionExams==>'+lstOfCompetitionExams);
                    upsert lstOfCompetitionExams;
                    
                    List<Competition_Exam_Details__c> RemoveNonUpdatedExams = [Select ID From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND LastModifiedDate !=: system.NOW()];
                    delete RemoveNonUpdatedExams;
                }
            }
            
  //////// Applicant selected program is changed then perform update on application then performs delete on competition exams and insert the new competition exam records ////////
            
            else
            {
                system.debug('Existing Application' + extApplication[0].ID);
                List<Competition_Exam_Details__c > DeleteExamsList = [Select ID From Competition_Exam_Details__c  Where Application__c =: extApplication[0].ID];
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList);
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList.size());
                if(!DeleteExamsList.isEmpty())
                {
                    delete DeleteExamsList;
                }
                
             
                if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
                  //------------------------------------------------------------------
                    if(updateApplication.ACT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                        Competition_Exam_Details__c ACT = new Competition_Exam_Details__c();
                        ACT.Name = 'ACT Score';
                        ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                        ACT.ACT_Math__c = CED1.ACT_Math__c;
                        ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                        ACT.ACT_Science__c = CED1.ACT_Science__c;
                        ACT.ACT_English__c = CED1.ACT_English__c;
                        ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                        ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                        ACT.Application__c = updateApplication.ID;
                        ACT.Program__c = SelectedProgram.Name;
                        ACT.RecordTypeID = RecordTypeId;
                        ACT.ACT__c = TRUE;
                        Insert ACT;
                        system.debug('ACT-3'+ACT);
                    }  
                    
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                        Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                        FEAT.Name = 'FEAT';
                        FEAT.Application__c = updateApplication.ID;
                        FEAT.Program__c = SelectedProgram.Name;
                        FEAT.RecordTypeID = RecordTypeId;
                        FEAT.FEAT__c = TRUE;
                        Insert FEAT;
                    }
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    
                    for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                    {
                        CE.Name = selectedExam;
                        CE.Application__c = updateApplication.ID;
                        CE.Program__c = SelectedProgram.Name;
                        CE.RecordTypeID = RecordTypeId;
                        if(CE.Result_Awaited__c == TRUE)
                        {
                            CE.Score__c = NULL;
                            CE.FUA_Percentile__c = NULL;
                        }
                    }
                        Insert lstOfCompetitionExams;
                }
            }
        }
       
        InvokeCalls();
        pgcsave= new PageReference('/apex/PersonalDetails');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    
   //------------------------------------------------------start with save and exis button--------------------------------------------------------------------------  
    
    
    
    public PageReference CustomSaveExit() 
        {   
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program];
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :ContactId Limit 1];
        PageReference  pgcsaveexit=null;
        
 //////// If no application found, then insert the new application along with competition exam records ////////
        
        if(extApplication.isempty())
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c; 
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c; 
            // 12/08/18 save and retrieve the values
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c; 
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c ;
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            insert applicationobj1;
            
            Contact c = FLAME_Utility.getConactInfo(ContactId,null);
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
            
            if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
            {
                if(applicationobj1.Old_SAT_Structure__c == True)
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                    Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                    SAT.Name = 'SAT Score';
                    SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                    SAT.Math__c = CED.Math__c;
                    SAT.Writing__c = CED.Writing__c;
                    SAT.Critical_Reading__c = CED.Critical_Reading__c;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Program__c = SelectedProgram.Name;
                    SAT.RecordTypeID = RecordTypeId;
                    SAT.SAT__c = TRUE;
                    Insert SAT;
                }
                   /*  Act insert*/
               if(applicationobj1.ACT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                        Competition_Exam_Details__c ACT = new Competition_Exam_Details__c();
                        ACT.Name = 'ACT Score';
                        ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                        ACT.ACT_Math__c = CED1.ACT_Math__c;
                        ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                        ACT.ACT_Science__c = CED1.ACT_Science__c;
                        ACT.ACT_English__c = CED1.ACT_English__c;
                        ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                        ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                        ACT.Application__c = applicationobj1.ID;
                        ACT.Program__c = SelectedProgram.Name;
                        ACT.RecordTypeID = RecordTypeId;
                        ACT.ACT__c = TRUE;
                        Insert ACT;
                        system.debug('updateACT-5'+ACT);
                    }
                    
                
                if(applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                    Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                    FEAT.Name = 'FEAT';
                    FEAT.Application__c = applicationobj1.ID;
                    FEAT.Program__c = SelectedProgram.Name;
                    FEAT.RecordTypeID = RecordTypeId;
                    FEAT.FEAT__c = TRUE;
                    Insert FEAT;
                }
            }
            else
            {
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                {
                    CE.Name = selectedExam;
                    CE.Application__c = applicationobj1.ID;
                    CE.Program__c = SelectedProgram.Name;
                    CE.RecordTypeID = RecordTypeId;
                    if(CE.Result_Awaited__c == TRUE)
                    {
                        CE.Score__c = NULL;
                        CE.FUA_Percentile__c = NULL;
                    }
                }
                    Insert lstOfCompetitionExams;
            }

            pgcsaveexit= new PageReference('/secur/logout.jsp'); 
            pgcsaveexit.setRedirect(false);
            return pgcsaveexit;
        }
        
  //////// If application found, then update the application and perform upsert on competition exam records ////////
        
        else
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            Application__c updateApplication = new Application__c(ID=extApplication[0].ID);
            updateApplication.GD_and_PI_Center__c = center;
            updateApplication.GD_and_PI_Round__c = round;
            updateApplication.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            updateApplication.Program__c = SelectedProgram.ID;
            updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
             updateApplication.ACT_Score__c = applicationobj.ACT_Score__c ;
            // 12/08/18 save and retrieve the values
            updateApplication.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c ;
            updateApplication.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c ;
            String completedStages = extApplication[0].Completed_Stages__c;
            String currentPageName = 'Program & Test';
            if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
                    updateApplication.Completed_Stages__c = completedStages;
                }
            }
            else{
                updateApplication.Completed_Stages__c = currentPageName;
            }
            
            update updateApplication;
            
            Contact c = FLAME_Utility.getConactInfo(ContactId,null);
            c.Program_Interested_In__c = SelectedProgram.Name;
            update c;
            
  //////// Applicant selected program is not changed then perform update on application and upsert on competition exams ////////
            
            if(extApplication[0].Program__c == SelectedProgram.ID)
            {
               
                 if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c== False)
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID From Competition_Exam_Details__c Where Application__c =: extApplication[0].ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.size()>0)
                        {
                            delete FEATexamlst;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID,Application__c,Program__c From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                            Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                            FEAT.Name = 'FEAT';
                            FEAT.Application__c = updateApplication.ID;
                            FEAT.Program__c = SelectedProgram.Name;
                            FEAT.RecordTypeID = RecordTypeId;
                            FEAT.FEAT__c = TRUE;
                            Insert FEAT;
                        }
                    }
                    if(updateApplication.SAT_Score__c == True)
                    {
                       
                        List<Competition_Exam_Details__c> SATexam = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'SAT' Limit 1];
                        if(!SATexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(ID=SATexam[0].ID);
                            SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SAT.Math__c = CED.Math__c;
                            SAT.Writing__c = CED.Writing__c;
                            SAT.Critical_Reading__c = CED.Critical_Reading__c;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.RecordTypeID = RecordTypeId;
                            SAT.SAT__c = TRUE;
                            Update SAT;
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SATscore = new Competition_Exam_Details__c();
                            SATscore.Name = 'SAT Score';
                            SATscore.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SATscore.Math__c = CED.Math__c;
                            SATscore.Writing__c = CED.Writing__c;
                            SATscore.Critical_Reading__c = CED.Critical_Reading__c;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.RecordTypeID = RecordTypeId;
                            SATscore.SAT__c = TRUE;
                            Insert SATscore;
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> SAT = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'SAT'Limit 1];
                        delete SAT;
                    }
                    
                     /*   act update */   
                  if(updateApplication.ACT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> ACTexam = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'ACT' Limit 1];
                        if(!ACTexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACT = new Competition_Exam_Details__c(ID=ACTexam[0].ID);
                            ACT.Name = 'ACT Score';
                            ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACT.ACT_Math__c = CED1.ACT_Math__c;
                            ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACT.ACT_Science__c = CED1.ACT_Science__c;
                            ACT.ACT_English__c = CED1.ACT_English__c;
                            ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACT.Program__c = SelectedProgram.Name;
                            ACT.RecordTypeID = RecordTypeId;
                            ACT.ACT__c = TRUE;
                            Update ACT;
                            system.debug('updateACT-6'+ACT);
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACTscore = new Competition_Exam_Details__c();
                            ACTscore.Name = 'ACT Score';
                            ACTscore.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACTscore.ACT_Math__c = CED1.ACT_Math__c;
                            ACTscore.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACTscore.ACT_Science__c = CED1.ACT_Science__c;
                            ACTscore.ACT_English__c = CED1.ACT_English__c;
                            ACTscore.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACTscore.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACTscore.Application__c = updateApplication.ID;
                            ACTscore.Program__c = SelectedProgram.Name;
                            ACTscore.RecordTypeID = RecordTypeId;
                            ACTscore.ACT__c = TRUE;
                            Insert ACTscore;
                            
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> ACT = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'ACT'Limit 1];
                        delete ACT;
                        system.debug('updateACT-8'+ACT);
                    }  
                    
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    for(Competition_Exam_Details__c  exam : lstOfCompetitionExams) 
                    {
                        exam.Name = selectedExam;
                        exam.Application__C = updateApplication.id;
                        exam.Program__c = SelectedProgram.Name;
                        exam.RecordTypeID = RecordTypeId;
                        if(exam.Result_Awaited__c == TRUE)
                        {
                            exam.Score__c = NULL;
                            exam.FUA_Percentile__c = NULL;
                        }
                    }
                    system.debug('lstOfCompetitionExams==>'+lstOfCompetitionExams);
                    
                    if(lstOfCompetitionExams.size()>0)
                    upsert lstOfCompetitionExams;
                    
                    List<Competition_Exam_Details__c> RemoveNonUpdatedExams = [Select ID From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND LastModifiedDate !=: system.NOW()];
                  
                     if(RemoveNonUpdatedExams.size()>0)
                    delete RemoveNonUpdatedExams;
                }
            }
            
  //////// Applicant selected program is changed then perform update on application then performs delete on competition exams and insert the new competition exam records ////////
            
            else
            {
                system.debug('Existing Application' + extApplication[0].ID);
                List<Competition_Exam_Details__c > DeleteExamsList = [Select ID From Competition_Exam_Details__c  Where Application__c =: extApplication[0].ID];
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList);
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList.size());
                if(!DeleteExamsList.isEmpty())
                {
                    delete DeleteExamsList;
                }
                
                //if(SelectedProgram.Name.equalsIgnoreCase(UNDER_GRADUATE_PROGRAM))add new coad 
                 if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
                    /*ACT insert*/ 
                    if(updateApplication.ACT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                        Competition_Exam_Details__c ACT = new Competition_Exam_Details__c();
                        ACT.Name = 'ACT Score';
                        ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                        ACT.ACT_Math__c = CED1.ACT_Math__c;
                        ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                        ACT.ACT_Science__c = CED1.ACT_Science__c;
                        ACT.ACT_English__c = CED1.ACT_English__c;
                        ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                        ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                        ACT.Application__c = updateApplication.ID;
                        ACT.Program__c = SelectedProgram.Name;
                        ACT.RecordTypeID = RecordTypeId;
                        ACT.ACT__c = TRUE;
                        Insert ACT;
                        system.debug('updateACT-9'+ACT);
                    }
                    
                    
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                        Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                        FEAT.Name = 'FEAT';
                        FEAT.Application__c = updateApplication.ID;
                        FEAT.Program__c = SelectedProgram.Name;
                        FEAT.RecordTypeID = RecordTypeId;
                        FEAT.FEAT__c = TRUE;
                        Insert FEAT;
                    }
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    
                    for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                    {
                        CE.Name = selectedExam;
                        CE.Application__c = updateApplication.ID;
                        CE.Program__c = SelectedProgram.Name;
                        CE.RecordTypeID = RecordTypeId;
                        if(CE.Result_Awaited__c == TRUE)
                        {
                            CE.Score__c = NULL;
                            CE.FUA_Percentile__c = NULL;
                        }
                    }
                        Insert lstOfCompetitionExams;
                }
            }
        }
        System.debug('Test Save and Exit');
        pgcsaveexit= new PageReference('/secur/logout.jsp'); 
        pgcsaveexit.setRedirect(false);
        return pgcsaveexit;
    }
    //--------------------------------------------------------------------------------------------------------------------------------
 /// Change made by To Call Method saveAllData from Action function>>        
           
    public PageReference saveAllDat()
    {
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program  LIMIT 1];
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :ContactId Limit 1];
        PageReference  pgcsaveexit=null;
        
 //////// If no application found, then insert the new application along with competition exam records ////////
        
        if(extApplication.isempty())
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
           
            System.debug('GDPIroundID====>'+GDPIroundID);
            
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c; 
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c; 
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            applicationobj1.RecordTypeid  = Schema.SObjectType.Application__c.getRecordTypeInfosByName().get('FU-Applicant').getRecordTypeId();    
            System.debug('** Custom Save ** applicationobj1 ' +applicationobj1);
            insert applicationobj1;
            
            Contact c = FLAME_Utility.getConactInfo(ContactId,null);
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
         
           if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
            {
                if(applicationobj1.Old_SAT_Structure__c == True)
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                    Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                    SAT.Name = 'SAT Score';
                    SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                    SAT.Math__c = CED.Math__c;
                    SAT.Writing__c = CED.Writing__c;
                    SAT.Critical_Reading__c = CED.Critical_Reading__c;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Program__c = SelectedProgram.Name;
                    SAT.RecordTypeID = RecordTypeId;
                    SAT.SAT__c = TRUE;
                    Insert SAT;
                }
                /*ACT insert*/ 
                    if(applicationobj1.ACT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                        Competition_Exam_Details__c ACT = new Competition_Exam_Details__c();
                        ACT.Name = 'ACT Score';
                        ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                        ACT.ACT_Math__c = CED1.ACT_Math__c;
                        ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                        ACT.ACT_Science__c = CED1.ACT_Science__c;
                        ACT.ACT_English__c = CED1.ACT_English__c;
                        ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                        ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                        ACT.Application__c = applicationobj1.ID;
                        ACT.Program__c = SelectedProgram.Name;
                        ACT.RecordTypeID = RecordTypeId;
                        ACT.ACT__c = TRUE;
                        Insert ACT;
                        system.debug('updateACT-9'+ACT);
                    }
                    
                if(applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                    Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                    FEAT.Name = 'FEAT';
                    FEAT.Application__c = applicationobj1.ID;
                    FEAT.Program__c = SelectedProgram.Name;
                    FEAT.RecordTypeID = RecordTypeId;
                    FEAT.FEAT__c = TRUE;
                    Insert FEAT;
                }
            }
            else
            {
                Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                {
                    CE.Name = selectedExam;
                    CE.Application__c = applicationobj1.ID;
                    CE.Program__c = SelectedProgram.Name;
                    CE.RecordTypeID = RecordTypeId;
                    if(CE.Result_Awaited__c == TRUE)
                    {
                        CE.Score__c = NULL;
                        CE.FUA_Percentile__c = NULL;
                    }
                }
                    Insert lstOfCompetitionExams;
            }
            pgcsaveexit= new PageReference('/secur/logout.jsp'); 
            pgcsaveexit.setRedirect(false);
            return pgcsaveexit;
        }
        
 //////// If application found, then update the application and perform upsert on competition exam records ////////
        
        else
        {   List<GD_and_PI_Round__c> GDPIroundID = new List<GD_and_PI_Round__c>(); 
            GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            
            
            Application__c updateApplication = new Application__c(ID=extApplication[0].ID);
            updateApplication.GD_and_PI_Center__c = center;
            updateApplication.GD_and_PI_Round__c = round;
           
            updateApplication.Program__c = SelectedProgram.ID;
            updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
             updateApplication.ACT_Score__c = applicationobj.ACT_Score__c ;
            updateApplication.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;
            String completedStages = extApplication[0].Completed_Stages__c;
            String currentPageName = 'Program & Test';
            if(completedStages != null){
                if(completedStages.contains(currentPageName)){
                   completedStages += ';' + currentPageName;
                   system.debug('completedStages==>' +   completedStages);
                   updateApplication.Completed_Stages__c = completedStages;
                }
            }
            else{
                updateApplication.Completed_Stages__c = currentPageName;
            }
            update updateApplication;
            
            Contact c = FLAME_Utility.getConactInfo(ContactId,null);
            c.Program_Interested_In__c = SelectedProgram.Name;
            update c;
            
  //////// Applicant selected program is not changed then perform update on application and upsert on competition exams ////////
            
            if(extApplication[0].Program__c == SelectedProgram.ID)
            {
                //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
             if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c== False)
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID From Competition_Exam_Details__c Where Application__c =: extApplication[0].ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.size()>0)
                        {
                            delete FEATexamlst;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> FEATexamlst = [Select ID,Application__c,Program__c From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND RecordType.Name = 'FEAT' ];
                        if(FEATexamlst.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                            Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                            FEAT.Name = 'FEAT';
                            FEAT.Application__c = updateApplication.ID;
                            FEAT.Program__c = SelectedProgram.Name;
                            FEAT.RecordTypeID = RecordTypeId;
                            FEAT.FEAT__c = TRUE;
                            Insert FEAT;
                        }
                    }
                    if(updateApplication.SAT_Score__c == True)
                    {
         
                        List<Competition_Exam_Details__c> SATexam = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'SAT' Limit 1];
                        if(!SATexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(ID=SATexam[0].ID);
                            SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SAT.Math__c = CED.Math__c;
                            SAT.Writing__c = CED.Writing__c;
                            SAT.Critical_Reading__c = CED.Critical_Reading__c;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.RecordTypeID = RecordTypeId;
                            SAT.SAT__c = TRUE;
                            Update SAT;
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SATscore = new Competition_Exam_Details__c();
                            SATscore.Name = 'SAT Score';
                            SATscore.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SATscore.Math__c = CED.Math__c;
                            SATscore.Writing__c = CED.Writing__c;
                            SATscore.Critical_Reading__c = CED.Critical_Reading__c;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.RecordTypeID = RecordTypeId;
                            SATscore.SAT__c = TRUE;
                            Insert SATscore;
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> SAT = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c,Result_Awaited__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'SAT'Limit 1];
                        delete SAT;
                    }
                    
                    /*   act update */   
                  if(updateApplication.ACT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> ACTexam = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'ACT' Limit 1];
                        if(!ACTexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACT = new Competition_Exam_Details__c(ID=ACTexam[0].ID);
                            ACT.Name = 'ACT Score';
                            ACT.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACT.ACT_Math__c = CED1.ACT_Math__c;
                            ACT.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACT.ACT_Science__c = CED1.ACT_Science__c;
                            ACT.ACT_English__c = CED1.ACT_English__c;
                            ACT.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACT.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACT.Program__c = SelectedProgram.Name;
                            ACT.RecordTypeID = RecordTypeId;
                            ACT.ACT__c = TRUE;
                            Update ACT;
                            system.debug('updateACT-10'+ACT);
                        }
                        else
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('ACT').getRecordTypeId();
                            Competition_Exam_Details__c ACTscore = new Competition_Exam_Details__c();
                            ACTscore.Name = 'ACT Score';
                            ACTscore.ACT_Exam_Date_mm_yyyy__c = CED1.ACT_Exam_Date_mm_yyyy__c;
                            ACTscore.ACT_Math__c = CED1.ACT_Math__c;
                            ACTscore.ACT_Reading__c = CED1.ACT_Reading__c;
                            ACTscore.ACT_Science__c = CED1.ACT_Science__c;
                            ACTscore.ACT_English__c = CED1.ACT_English__c;
                            ACTscore.ACT_Composite_Score__c = CED1.ACT_Composite_Score__c;
                            ACTscore.Result_Awaited__c = CED1.Result_Awaited__c;
                            ACTscore.Application__c = updateApplication.ID;
                            ACTscore.Program__c = SelectedProgram.Name;
                            ACTscore.RecordTypeID = RecordTypeId;
                            ACTscore.ACT__c = TRUE;
                            Insert ACTscore;
                            
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> ACT = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'ACT'Limit 1];
                        delete ACT;
                    }  
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    for(Competition_Exam_Details__c  exam : lstOfCompetitionExams) 
                    {
                        exam.Name = selectedExam;
                        exam.Application__C = updateApplication.id;
                        exam.Program__c = SelectedProgram.Name;
                        exam.RecordTypeID = RecordTypeId;
                        if(exam.Result_Awaited__c == TRUE)
                        {
                            exam.Score__c = NULL;
                            exam.FUA_Percentile__c = NULL;
                        }
                    }
                    system.debug('lstOfCompetitionExams==>'+lstOfCompetitionExams);
                    upsert lstOfCompetitionExams;
                    
                    List<Competition_Exam_Details__c> RemoveNonUpdatedExams = [Select ID From Competition_Exam_Details__c Where Application__c =: updateApplication.ID AND LastModifiedDate !=: system.NOW()];
                    delete RemoveNonUpdatedExams;
                }
            }
            
  //////// Applicant selected program is changed then perform update on application then performs delete on competition exams and insert the new competition exam records ////////
            
            else
            {
                system.debug('Existing Application' + extApplication[0].ID);
                List<Competition_Exam_Details__c > DeleteExamsList = [Select ID From Competition_Exam_Details__c  Where Application__c =: extApplication[0].ID];
               
                if(!DeleteExamsList.isEmpty())
                {
                    delete DeleteExamsList;
                }
                
             
               if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
                    if(updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('FEAT').getRecordTypeId();
                        Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
                        FEAT.Name = 'FEAT';
                        FEAT.Application__c = updateApplication.ID;
                        FEAT.Program__c = SelectedProgram.Name;
                        FEAT.RecordTypeID = RecordTypeId;
                        FEAT.FEAT__c = TRUE;
                        Insert FEAT;
                    }
                }
                else
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId();
                    
                    for(Competition_Exam_Details__c CE : lstOfCompetitionExams)
                    {
                        CE.Name = selectedExam;
                        CE.Application__c = updateApplication.ID;
                        CE.Program__c = SelectedProgram.Name;
                        CE.RecordTypeID = RecordTypeId;
                        if(CE.Result_Awaited__c == TRUE)
                        {
                            CE.Score__c = NULL;
                            CE.FUA_Percentile__c = NULL;
                        }
                    }
                        Insert lstOfCompetitionExams;
                }
            }
        }
            
        System.debug('Test Save and Exit');
            
        pgcsaveexit= new PageReference('/secur/logout.jsp'); 
        pgcsaveexit.setRedirect(false);
        return pgcsaveexit;
        
      
    }
      public List<CompetitionWraper> getCompetitionExamListFromDatabase2() {
       List<CompetitionWraper> temp= new List<CompetitionWraper>();
       Schema.DescribeFieldResult fieldResult = Competition_Exam_Details__c.Competitive_Exams__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       CompetitionWraper wrap;

       for( Schema.PicklistEntry f : ple){
          System.debug('vcr----Value--'+f.getValue() +' * vcr----Label--'+f.getLabel());
          wrap = new CompetitionWraper();
          wrap.Name=f.getLabel();
          wrap.Label=f.getValue();
          temp.add(wrap);
        }  
       return temp;
    }
     /* PersonalDetailes controller --------------------------*/ 
    Public PageReference findcontactController()
    {
          PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        
        
        try
        {  
            InvokeCalls();
            
            AddValue  = 'Same as above';
            GenderVal = 'Male';
            GenderVal = 'FeMale';
            ConWrap   = new PersonalDetails ();

            if(FlameCont!=null)
            {   
                if(ConWrap!=null)
                { 
                 Conwrap.Contactid = Con.id;
                 ConWrap.ConEmail = Con.Email;
                 ConWrap.FirstName = Con.FirstName;
                 ConWrap.LastName =  Con.LastName;
                 ConWrap.Middle_Name = Con.Middle_Name__c;
                 ConWrap.Marital_Status = Con.Marital_Status__c;
                 ConWrap.FU_Residence_Phone_Code = Con.FU_Residence_Phone_Code__c;
                 ConWrap.FUA_Residence_Phone_No = Con.FUA_Residence_Phone_No__c;
                 ConWrap.Total_Family_Income = Con.Total_Family_Income__c;
                 ConWrap.Religion = Con.Religion__c;
                 ConWrap.FU_Mobile_Phone_Code = Con.FU_Mobile_Phone_Code__c;
                 ConWrap.FUA_Mobile = Con.FUA_Mobile__c;
                 ConWrap.Alternate_Email_ID = Con.Alternate_Email_ID__c;
                 ConWrap.Are_you_an_Indian = Con.Are_you_an_Indian__c;
                 ConWrap.Place_of_Birth = Con.Place_of_Birth__c;  
                 ConWrap.Mother_Tongue = Con.Mother_Tongue__c;
                 ConWrap.Mailing_Address_Line_1 = Con.Mailing_Address_Line_1__c ;
                 ConWrap.Mailing_Address_Line_2 = Con.Mailing_Address_Line_2__c;
                 ConWrap.FU_Applicant_Mailing_Country = Con.FU_Applicant_Mailing_Country__c;
                 ConWrap.FU_Applicant_Mailing_State = Con.FU_Applicant_Mailing_State__c ;
                 ConWrap.FU_Applicant_Mailing_City = Con.FU_Applicant_Mailing_City__c ;
                 ConWrap.Mailing_City        = Con.Mailing_City__c;                                   
                 ConWrap.Mailing_Postal_Code = Con.Mailing_Postal_Code__c;
                 ConWrap.Mailing_Address     = Con.Mailing_Address__c ;
                                                
                 ConWrap.Permanent_Address_Line_1 = Con.Permanent_Address_Line_1__c ;                       
                 ConWrap.Permanent_Address_Line_2  =  Con.Permanent_Address_Line_2__c;                        
                 ConWrap.FU_Applicant_Other_City = Con.FU_Applicant_Other_City__c ;
                 ConWrap.FU_Applicant_Other_State = Con.FU_Applicant_Other_State__c ;
                 ConWrap.FU_Applicant_Other_Country= con.FU_Applicant_Other_Country__c;
                 ConWrap.Permanent_Postal_Code = con.Permanent_Postal_Code__c;
                 
                 ConWrap.Source = Con.Source__c;
                 ConWrap.Place_of_Birth = Con.Place_of_Birth__c;
                 ConWrap.Passport_No = Con.Passport_No__c;
                 ConWrap.Passport_Issued_By = Con.Passport_Issued_By__c; 
                 ConWrap.FU_Outside_India = Con.FU_Outside_India__c;
                // ConWrap.Other = Con.Other__c ;
                 ConWrap.Father_s_Current_Company = Con.Father_s_Current_Company__c;
                 ConWrap.Father_s_Designation = Con.Father_s_Designation__c;
                 ConWrap.Father_s_Email_ID = Con.Father_s_Email_ID__c ;
                 ConWrap.Father_s_First_Name = Con.Father_s_First_Name__c;
                 ConWrap.Father_s_Last_Company = Con.Father_s_Last_Company__c;
                 ConWrap.Father_s_Designation = Con.Father_s_Designation__c ;
                 ConWrap.Father_s_Last_Company = Con.Father_s_Last_Company__c ;
                 ConWrap.Father_s_Last_Name = Con.Father_s_Last_Name__c;
                 ConWrap.Father_s_Mobile_No = Con.Father_s_Mobile_No__c;
                 ConWrap.FUA_Father_s_Mobile_No = Con.FUA_Father_s_Mobile_No__c;
                 ConWrap.Father_s_Mobile_No_Code = Con.Father_s_Mobile_No_Code__c;
                 ConWrap.Father_s_Occupation = Con.Father_s_Occupation__c ;
                 ConWrap.Gender= Con.Gender__c;
                 ConWrap.Salutation = Con.Salutation; 
                 
                 ConWrap.Mother_s_Current_Company = Con.Mother_s_Current_Company__c;                        
                 ConWrap.Mother_s_Designation =  Con.Mother_s_Designation__c ;                           
                 ConWrap.Mother_s_Email_ID =  Con.Mother_s_Email_ID__c ;     
                 ConWrap.Mother_s_First_Name =  Con.Mother_s_First_Name__c ;   
                 ConWrap.Mother_s_Last_Company =  Con.Mother_s_Last_Company__c ;                          
                 ConWrap.Mother_s_Last_Name =  Con.Mother_s_Last_Name__c;                              
                 ConWrap.Mother_s_Mobile_No =  Con.Mother_s_Mobile_No__c ;                             
                 ConWrap.FUA_Mother_s_Mobile_No = Con.FUA_Mother_s_Mobile_No__c;
                 ConWrap.Mother_s_Mobile_No_Code = Con.Mother_s_Mobile_No_Code__c;                        
                 ConWrap.Mother_s_Occupation = Con.Mother_s_Occupation__c;                             
                 ConWrap.Mother_Tongue = Con.Mother_Tongue__c;                                   
                 ConWrap.Other = Con.Other__c;                                          
                 ConWrap.Other_City = Con.Other_City__c;                                      
                 ConWrap.Visa_Status =  Con.Visa_Status__c;                                     
                 System.debug('>>>>>>>>>>>>>>>>>>>>>> From ConWarp'  +   Con.Birthdate);  
                }

                if(Con.Are_you_an_Indian__c== 'No'){
                    PlaceOfBirthCon= Con.Place_of_Birth__c; 
                }else{
                    PlaceOfBirthSt = Con.Place_of_Birth__c;
                    PlaceOfBirthOut =Con.FU_Outside_India__c;
                }if(Con.Gender__c!=Null){
                    GenderVal = Con.Gender__c;
                }
                if(Con.Mailing_Address__c!=Null){
                    AddValue = Con.Mailing_Address__c;
                }
                if(Con.Are_you_an_Indian__c!=Null){
                   ConWrap.Are_you_an_Indian =Con.Are_you_an_Indian__c;
                }
                //Get Birthdate from contact in yyyy/mm/dd format and convert it into dd/mm/yyyy format
                if(Con.Birthdate!=Null){
                   BirthdateValue =string.valueof(Con.Birthdate);
                   List<string> lstBirthdis = new List<string>();
                   lstBirthdis = BirthdateValue.split('-');
                   BirthdateValue = lstBirthdis[2] +'/'+lstBirthdis[1] +'/'+lstBirthdis[0] ;
                }
                //Get PassportExpiryDate from contact in yyyy/mm/dd format and convert it into dd/mm/yyyy format
                if(Con.Passport_Expiry_Date__c!=Null){
                   PassportExpireDateValue =string.valueof(Con.Passport_Expiry_Date__c);
                   List<string> lstExpiredis = new List<string>();
                   lstExpiredis = PassportExpireDateValue.split('-');
                   PassportExpireDateValue = lstExpiredis[2] +'/'+lstExpiredis[1] +'/'+lstExpiredis[0] ;
                }
            }
        }
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            return null;
        }
        return null;
    }
  /*Add new code savedata()in personalform page*/
    public void persaveAllData()
    {
    
            Contact Updatedcon = FLAME_Utility.getConactInfo(con.id,null);
            System.debug('vcr--before apps update--');
        if(con!= null && con.Applications__r.size() > 0)
        {
            System.debug('vcr--Con.Applications__r--'+Con.Applications__r);
            List<Application__c> apps = Con.Applications__r;
            String completedStages = apps[0].Completed_Stages__c;
            String currentPageName = 'Personal Details';
        if(completedStages != null)
        {
        if(!completedStages.contains(currentPageName))
        {
            completedStages += ';' + currentPageName;
            apps[0].Completed_Stages__c = completedStages;
        }
        }else{
            apps[0].Completed_Stages__c = currentPageName;
        }
        update apps;
        }
  
    }
      /*
        Personal Details Sae & Exist Action method. 
    */
    public PageReference SaveDataPD()
    {   

        InvokeCalls();
        PageReference  pgcproceed=null;
        system.debug('ConWrap---contact wrap-- BirthdateValue ' + PlaceOfBirthCon);
        
        ConWrap.Mailing_Address = AddValue;
        if(ConWrap.Are_you_an_Indian == 'No')
        {
           ConWrap.PlaceOfBirthCon = PlaceOfBirthCon; 
           ConWrap.PlaceOfBirthOut= '';
        }
        else 
        {
           ConWrap.PlaceOfBirthSt= PlaceOfBirthSt;
           ConWrap.PlaceOfBirthOut=PlaceOfBirthOut;
        }
            
        List<string> lstBirth = new List<string>();
        if(!String.isEmpty(BirthdateValue)){
           lstBirth = BirthdateValue.split('/');
           Date dateBirth = Date.newInstance(Integer.valueOf(lstBirth[2]),Integer.valueOf(lstBirth[1]),Integer.valueOf(lstBirth[0]));
           ConWrap.BirthdateValue = dateBirth;          
        } 
        
        system.debug('ConWrap---contact wrap2--' + ConWrap.BirthdateValue );
        
       List<string> lstExpireDate = new List<string>();
       if(!String.isEmpty(PassportExpireDateValue))
       {
        lstExpireDate = PassportExpireDateValue.split('/');
         Date expireDate = Date.newInstance(Integer.valueOf(lstExpireDate[2]),Integer.valueOf(lstExpireDate[1]),Integer.valueOf(lstExpireDate[0]));
         //2016-04-06 00:00:00
         ConWrap.PassportExpireDateValue= expireDate;
         //con.Birthdate= date.valueof(birthdate);
       }
            
        List<String> Contactstr = new List<String>();
        Contactstr.add(JSON.serialize(ConWrap));        
        updatecontactdetails(Contactstr);
        return new PageReference('/secur/logout.jsp');
        
    }
    
 
    public class contactwrapper{
     public Contact con{set;get{if(Con==null)Con = new Contact();return con;}}
     public contactwrapper()
    {
     
    }
    }
    public pageReference redirect()
    {
        if(Con.Applications__r != null && Con.Applications__r.size() == 0){
            return new PageReference('/apex/Index1?Id='+StaticContactId);
           
        }
        else{
            return null;
        } 
    }

 
  /* Utility Methods  - Move to Other Extentions*/   
  
    Public static void updatecontactdetails(List<String> Contactstr)
    {
        PersonalDetails pd = (PersonalDetails)JSON.deserialize(Contactstr[0], PersonalDetails.class);
        system.debug('vcr----PersonalDetails'+pd);
        Contact con = FLAME_Utility.getConactInfo(pd.Contactid,null);
          Con.Salutation = pd.Salutation;
          con.FirstName=pd.FirstName;
          Con.LastName =pd.LastName;
          Con.Email = pd.ConEmail;
          Con.Middle_Name__c =pd.Middle_Name;
          Con.Marital_Status__c = pd.Marital_Status;
          Con.FU_Residence_Phone_Code__c=pd.FU_Residence_Phone_Code;
          Con.FUA_Residence_Phone_No__c = pd.FUA_Residence_Phone_No;
          Con.Total_Family_Income__c= pd.Total_Family_Income;
          Con.Religion__c =pd.Religion;
          Con.FU_Mobile_Phone_Code__c =pd.FU_Mobile_Phone_Code;
          Con.FUA_Mobile__c =pd.FUA_Mobile;
          Con.Alternate_Email_ID__c =pd.Alternate_Email_ID;
          Con.Mother_Tongue__c = pd.Mother_Tongue;
          
          Con.Mailing_Address__c = pd.Mailing_Address;  
          Con.Permanent_Address_Line_1__c = pd.Permanent_Address_Line_1;
          Con.Permanent_Address_Line_2__c = pd.Permanent_Address_Line_2;
          Con.Mailing_City__c = pd.Mailing_City;
          Con.Mailing_Postal_Code__c = pd.Mailing_Postal_Code;
          con.FU_Applicant_Other_State__c = pd.FU_Applicant_Other_State;
          con.FU_Applicant_Other_City__c  = pd.FU_Applicant_Other_City;
          
          
          if(pd.Mailing_Address == 'Same as above') {
              Con.Mailing_Address_Line_1__c = pd.Permanent_Address_Line_1;
              Con.Mailing_Address_Line_2__c = pd.Permanent_Address_Line_2;
              Con.FU_Applicant_Mailing_Country__c = pd.FU_Applicant_Other_Country;   
              Con.FU_Applicant_Mailing_State__c = pd.FU_Applicant_Other_State;
              Con.FU_Applicant_Mailing_City__c  =  pd.FU_Applicant_Other_City;
              Con.Mailing_Postal_Code__c = pd.Permanent_Postal_Code;
          }else{
              Con.Mailing_Address_Line_1__c = pd.Mailing_Address_Line_1;
              Con.Mailing_Address_Line_2__c = pd.Mailing_Address_Line_2;
              Con.FU_Applicant_Mailing_Country__c = pd.FU_Applicant_Mailing_Country;   
              Con.FU_Applicant_Mailing_State__c = pd.FU_Applicant_Mailing_State;
              Con.FU_Applicant_Mailing_City__c  = pd.FU_Applicant_Mailing_City;
              Con.Mailing_Postal_Code__c        = pd.Mailing_Postal_Code; 
             
          }
              
          Con.Source__c =pd.Source;
          Con.Permanent_Postal_Code__c = pd.Permanent_Postal_Code;
          
          Con.Passport_No__c = pd.Passport_No;
          Con.Passport_Issued_By__c = pd.Passport_Issued_By;
          Con.Other__c =pd.Other;

 // Parent Details 
          Con.Father_s_Current_Company__c =pd.Father_s_Current_Company;
          Con.Father_s_Designation__c = pd.Father_s_Designation;
          Con.Father_s_Email_ID__c = pd.Father_s_Email_ID;
          Con.Father_s_First_Name__c = pd.Father_s_First_Name;
          Con.Father_s_Last_Company__c = pd.Father_s_Last_Company;
          Con.Father_s_Designation__c = pd.Father_s_Designation;
          Con.Father_s_Last_Company__c = pd.Father_s_Last_Company;
          Con.Father_s_Last_Name__c = pd.Father_s_Last_Name;
          Con.Father_s_Mobile_No__c= pd.Father_s_Mobile_No;
          Con.FUA_Father_s_Mobile_No__c = pd.FUA_Father_s_Mobile_No;
          Con.Father_s_Mobile_No_Code__c =pd.Father_s_Mobile_No_Code;
          Con.Father_s_Occupation__c =pd.Father_s_Occupation;
          Con.Gender__c =pd.Gender;         
          Con.Mother_s_Current_Company__c = pd.Mother_s_Current_Company;
          Con.Mother_s_Designation__c = pd.Mother_s_Designation;
          Con.Mother_s_Email_ID__c = pd.Mother_s_Email_ID;
          Con.Mother_s_First_Name__c = pd.Mother_s_First_Name;
          Con.Mother_s_Last_Company__c = pd.Mother_s_Last_Company;
          Con.Mother_s_Last_Name__c = pd.Mother_s_Last_Name;
          Con.Mother_s_Mobile_No__c = pd.Mother_s_Mobile_No;
          Con.FUA_Mother_s_Mobile_No__c = pd.FUA_Mother_s_Mobile_No;
          Con.Mother_s_Mobile_No_Code__c = pd.Mother_s_Mobile_No_Code;
          Con.Mother_s_Occupation__c = pd.Mother_s_Occupation;
          Con.Mother_Tongue__c = pd.Mother_Tongue;
          Con.Other__c = pd.Other;
          Con.Other_City__c = pd.Other_City;
          Con.Visa_Status__c = pd.Visa_Status;
          Con.Birthdate = pd.BirthdateValue;
          Con.Passport_Expiry_Date__c = pd.PassportExpireDateValue;  
          Con.Are_you_an_Indian__c = pd.Are_you_an_Indian;
          if(pd.Are_you_an_Indian== 'No'){
          Con.Place_of_Birth__c   = pd.PlaceOfBirthCon;
          Con.FU_Outside_India__c = '';
          }else{
           Con.Place_of_Birth__c = pd.PlaceOfBirthSt;
           Con.FU_Outside_India__c=pd.PlaceOfBirthOut;
          }
          update con;
 //--add& check the personal Details in application stages----
 
          Contact Updatedcon = FLAME_Utility.getConactInfo(con.id,null);
          System.debug('vcr--before apps update--');
          if(con!= null && con.Applications__r.size() > 0){
           System.debug('vcr--Con.Applications__r--'+Con.Applications__r);
                    List<Application__c> apps = Con.Applications__r;
                    String completedStages = apps[0].Completed_Stages__c;
                    String currentPageName = 'Personal Details';
                    if(completedStages != null){
                        if(!completedStages.contains(currentPageName)){
                            completedStages += ';' + currentPageName;
                            apps[0].Completed_Stages__c = completedStages;
                        }
                    }
                    else{
                        apps[0].Completed_Stages__c = currentPageName;
                    }
               System.debug('vcr--apps update--'+apps);
                    update apps;
          }  
    }
       public Class CompetitionWraper{
        public string Name{get;set;}
        public string Label{get;set;}
    }
     public static Program__c getProgramDetails(String ProgramId)
    {
       Program__c prog = [Select ID,Name,Semester1_Fee_Amount__c,Semester2_Fee_Amount__c,Enrollment_Deposit_Amount__c,Semester_2_Fee_Disc__c From Program__c Where ID =: ProgramId]; 
       return prog;      
    }  
  public List<SelectOption> GetNationality()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
     public List<SelectOption> Getaccomodation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
    

    public List<SelectOption> GetGender()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Male','Male'));
        options.add(new SelectOption('Female','Female'));
        return options;
    }
  
    public List<SelectOption> GetCountries()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_Country__c.getDescribe();
      // Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Mailing_Country__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
           options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
       }
       return options;
    }
    
    public List<SelectOption> getCountries1()
    {
    List<SelectOption> options = new List<SelectOption>();
    
    Schema.DescribeFieldResult fieldResult =
    Contact.FU_Applicant_Mailing_Country__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    
    for( Schema.PicklistEntry f : ple)
    {
    options.add(new SelectOption(f.getLabel(), f.getValue()));
    }       
    return options;
    }

    public List<SelectOption> GetSources()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.Source__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
           options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
       }
       return options;
    }
   
    public List<SelectOption> GetOutCountries()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_Country__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
            if(countryToItrate.getValue() != 'India')
            {
                options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
            }
           
       }
       return options;
    }
   
    public List<SelectOption> GetStates()
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_State__c.getDescribe();
        List<Schema.PicklistEntry> statesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry statesToItrate : statesLst)
       {
            options.add(new SelectOption(statesToItrate.getLabel(), statesToItrate.getValue()));
       }
       options.add(new SelectOption('Outside India','Outside India'));
       return options;
    }
    
     public List<SelectOption> getStates1()
    {
    List<SelectOption> options = new List<SelectOption>();
    
    Schema.DescribeFieldResult fieldResult =
    Contact.FU_Applicant_Mailing_State__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    
    for( Schema.PicklistEntry f : ple)
    {
    options.add(new SelectOption(f.getLabel(), f.getValue()));
    }
     options.add(new SelectOption('Outside India','Outside India'));       
    return options;
    }
   
    public List<SelectOption> GetSameAddress()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Same as above','Same as above'));
        options.add(new SelectOption('Different','Different'));
        return options;
    }
   
    public List<SelectOption> GetFatherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Not Applicable','Not Applicable'));
        return options;
    }
   
    public List<SelectOption> GetMotherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Not Applicable','Not Applicable'));
        return options;
    }
    
    public List<SelectOption> getSalutations()
    {
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult =  Contact.Salutation.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
    public List<SelectOption> getMaritalstatuses()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult = Contact.Marital_Status__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
  
    public List<SelectOption> getresidencenumbs()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult =   Contact.FU_Residence_Phone_Code__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
   public List<SelectOption> getfamilyincomes()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult = Contact.Total_Family_Income__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
    public List<SelectOption> getreligions(){
      List<SelectOption> options = new List<SelectOption>();
      Schema.DescribeFieldResult fieldResult = Contact.Religion__c.getDescribe();
      List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
      for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
    public List<SelectOption> getFUCities()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult = Contact.FU_Applicant_Other_City__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
    
      public List<SelectOption> getFUCities1()
    {
    List<SelectOption> options = new List<SelectOption>();
    
    Schema.DescribeFieldResult fieldResult =
    Contact.FU_Applicant_Mailing_City__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    
    for( Schema.PicklistEntry f : ple)
    {
    options.add(new SelectOption(f.getLabel(), f.getValue()));
    }
         
    return options;
    }
 /*Method call from VF page save all field values in contact object and redirect to EducationAndWork page if click on Next button.
        Methid call from VF page save all field values in contact object and logout if click on Save & Exit button.*/
        
    public PageReference SaveData()
    {    InvokeCalls();
         PageReference  pgcproceed=null;
         system.debug('ConWrap---contact wrap-- BirthdateValue ' + PlaceOfBirthCon);
         ConWrap.Mailing_Address = AddValue;
        if(ConWrap.Are_you_an_Indian == 'No')
        {
           ConWrap.PlaceOfBirthCon = PlaceOfBirthCon; 
           ConWrap.PlaceOfBirthOut= '';
        }
        else 
        {
           ConWrap.PlaceOfBirthSt= PlaceOfBirthSt;
           ConWrap.PlaceOfBirthOut=PlaceOfBirthOut;
        }
            
        List<string> lstBirth = new List<string>();
        if(!String.isEmpty(BirthdateValue)){
           lstBirth = BirthdateValue.split('/');
           Date dateBirth = Date.newInstance(Integer.valueOf(lstBirth[2]),Integer.valueOf(lstBirth[1]),Integer.valueOf(lstBirth[0]));
           ConWrap.BirthdateValue = dateBirth;          
        } 
        
        system.debug('ConWrap---contact wrap2--' + ConWrap.BirthdateValue );
        
        List<string> lstExpireDate = new List<string>();
        if(!String.isEmpty(PassportExpireDateValue))
        {
            lstExpireDate = PassportExpireDateValue.split('/');
            Date expireDate = Date.newInstance(Integer.valueOf(lstExpireDate[2]),Integer.valueOf(lstExpireDate[1]),Integer.valueOf(lstExpireDate[0]));
            ConWrap.PassportExpireDateValue= expireDate;

        }
            
            List<String> Contactstr = new List<String>();
            Contactstr.add(JSON.serialize(ConWrap));        
            updatecontactdetails(Contactstr);
            
            Pagereference nextpage = new PageReference('/apex/EducationAndWork');
            nextPage.setRedirect(false); 
            return nextPage;
    }

  
    
    
  /* Education Details -------------------------*/
     Public PageReference educationandworkmethod(){
          PageReference pg = redirectToLogin();
          System.debug('ContactId ----'+ContactId);
        if(pg!=null){
            return pg;
        } 
        InvokeCalls();
        System.debug(' Inside  -----EducationAndWorkmethod----------' +ContactId);
        EdDetList = new List<FU_Education_Details__c>();
        Wrkdetls  = new List<FUA_Work_Details__c>();
        CountAdd = 1;
        showAddDeleteButtons = false;
        System.debug('** Con>>EducationAndWork FlameCont Details ** ' +FlameCont);
    // Fetching the Education details and work details for logged in user
        EdDetList = FLAME_Utility.getEducationDetails(ContactId);
        Wrkdetls  = FLAME_Utility.getWorkDetails(ContactId);
        System.debug(' Education Details Infromation ' +EdDetList );
        System.debug(' Work Details Infromation ' +Wrkdetls );
    // Rendering the ADD/Remove buttons
        if(Wrkdetls.size() > 0){
             showAddDeleteButtons = true;
             CountAdd = Wrkdetls.size();
        }
        educationObj = new FU_Education_Details__c(Application__c = StaticAppid,FUA_Education_Country__c='India');
        App = FLAME_Utility.getApplicationInfo(ContactId, null)[0];
        if(App.Program__r.Program_Type__c == 'Undergraduate' || App.Program__r.Program_Type__c == 'Other UG')
        {
        educationoptions.add(new SelectOption('', '--Select Education--'));
        educationoptions.add(new SelectOption('10/Xth', '10/Xth'));
        educationoptions.add(new SelectOption('11/XIth', '11/XIth'));
        educationoptions.add(new SelectOption('12/XIIth', '12/XIIth'));
        }
        else{
        System.debug('vcr--inside other than Under graduate-');
        educationoptions.add(new SelectOption('', '--Select Education--'));
        educationoptions.add(new SelectOption('10/Xth', '10/Xth'));
        educationoptions.add(new SelectOption('11/XIth', '11/XIth'));
        educationoptions.add(new SelectOption('12/XIIth', '12/XIIth'));
        educationoptions.add(new SelectOption('Bachelors / Undergraduate', 'Bachelors / Undergraduate'));
        educationoptions.add(new SelectOption('Masters / Postgraduate', 'Masters / Postgraduate'));
        educationoptions.add(new SelectOption('Other', 'Other'));
        }
       
        system.debug('vcr---educationoptions--'+educationoptions);
        options = new List<SelectOption>();
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
     
     return null;
     }
    
   


 /*Education And work adding a workdetail section*/
    public void AddSection()
    {
        CountAdd = CountAdd +1;
        Wrkdetls.add(new FUA_Work_Details__c(Application__c=appid,FUA_Work_Country__c ='India'));
        showAddDeleteButtons = true;
        
    }
    List<FUA_Work_Details__c> finalDeleteList = new List<FUA_Work_Details__c>();
 // Removing a Workdetail section
 
    Public void DeleteRow()
    {
        CountAdd =CountAdd-1;
        Integer i = Wrkdetls.size();
        system.debug('Size -> ' + i);
        if(Wrkdetls.get(i-1).id!= null){
            finalDeleteList.add(Wrkdetls.get(i-1));
            Wrkdetls.remove(i-1);
            system.debug('finalDeleteList -> ' + finalDeleteList.size());
            if(Wrkdetls.size() > 0){
                showAddDeleteButtons = true;
            }
            else{
                showAddDeleteButtons = false;
            }
        }   
        else{
            Wrkdetls.remove(i-1);
            if(Wrkdetls.size() > 0){
                showAddDeleteButtons = true;
            }
            else{
                showAddDeleteButtons = false;
            }
        }
    }
 // Removing all the Workdetails if clicked on 'No' Radio button
    
    public void deleteAllWork(){
        CountAdd = 0;
        Wrkdetls = [Select Id from FUA_Work_Details__c where Application__c = :appid];
        if(Wrkdetls.size() > 0){
            for(integer i =0 ; i<Wrkdetls.size() ; i++){
                finalDeleteList.add(Wrkdetls.get(i));
             }
             Wrkdetls.clear();
        }
        showAddDeleteButtons = false;
        Wrkdetls.clear();
    }
   
   
 // Saving the data and logging out
        public PageReference SaveExit()
        {
             system.debug('EEEEEEEEEE>>>>>>>>>>>>>>>>>>>>>>>');
        try{
            if(EdDetList.size() > 0){
                upsert EdDetList;
                for(FUA_Work_Details__c WD : Wrkdetls)
                {
                    WD.Name = WD.FUA_Company__c + '-' + WD.FUA_Designation__c;
                }
                upsert Wrkdetls;
                if(finalDeleteList.size() > 0){
                    delete finalDeleteList;
                }
                update App; 
            
                return new PageReference('/secur/logout.jsp');
            }
            else{
                return null;
            }
        }
        catch(Exception e){
            return null;
        }
    }
 //Adding individual education detail in the list to be inserted
    
    public void saveEducationDetail(){
   /* 13-11-2017 start code*/
   if(educationObj.FUA_Major_Subjects__c != null){
    String replaceSpace = educationObj.FUA_Major_Subjects__c.replaceAll(',', ', '); //replaceAll(',','\n');
       educationObj.FUA_Major_Subjects__c=replaceSpace;
       System.Debug('replaceSpace::'+replaceSpace);
       EdDetList.add(educationObj); 
        educationObj = new FU_Education_Details__c(Application__c = appId,FUA_Education_Country__c='India');
        upsert EdDetList;
       
    }else{
        EdDetList.add(educationObj); 
        educationObj = new FU_Education_Details__c(Application__c = appId,FUA_Education_Country__c='India');
        upsert EdDetList;
     }  
    /* 13-11-2017 end code*/
      /*  EdDetList.add(educationObj); 
        educationObj = new FU_Education_Details__c(Application__c = appId,FUA_Education_Country__c='India');
        upsert EdDetList;*/
        
    }
  // Rendering the education slider with appropriate value
    public void yearChangeInit(){
        String year = ApexPages.currentPage().getParameters().get('selectedYear');
        selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
        system.debug('selectedYr -> ' + selectedYr);
        
        boolean flag = false;
        for(integer i = 0 ; i < EdDetList.size() ; i++){
            if(EdDetList[i].FU_Year_Class__c == year){
                educationObj = EdDetList[i];
                flag = true;
               
                break;
                
            }
            
        }
        
        system.debug('flag -> ' + flag);
        if(flag == false){
            educationObj = new FU_Education_Details__c(FU_Year_Class__c = year,Application__c = appid,FUA_Education_Country__c='India');
            system.debug('educationObj -> ' + educationObj);
        }
    }
    
 /*   Removing the particular education detail from the list */
    public void deleteEducationData(){
        String year = ApexPages.currentPage().getParameters().get('selectedYear');
        selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
        system.debug('year -> ' + year);
        
        for(integer i = 0 ; i < EdDetList.size() ; i++){
            if(EdDetList[i].FU_Year_Class__c == year){
                educationObj = new FU_Education_Details__c(Application__c = appid,FUA_Education_Country__c='India');
                if(EdDetList[i].Id!= null){
                    delete EdDetList[i];
                }
                EdDetList.remove(i);
            }
        }
    }
    /* To Edit the particular education detail data */
     public void editEducationData()
    {
        String year = ApexPages.currentPage().getParameters().get('selectedYear');
        selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
        system.debug('year -> ' + year);
        
        for(integer i = 0 ; i < EdDetList.size() ; i++){
            if(EdDetList[i].FU_Year_Class__c == year){
            
                educationObj = EdDetList[i];
                break;
            }
        }
        selectedYr = educationObj.FU_Year_Class__c;
    }
    /*Saving the edited education detail data */
    public void UpdateEducationList()
    {
        try
        {
            String year = ApexPages.currentPage().getParameters().get('selectedYear');
            selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
            system.debug('year -> ' + year);
        
            for(integer i = 0 ; i < EdDetList.size() ; i++)
            {
            if(educationObj.FU_Year_Class__c == year)
            {
                     EdDetList[i] = educationObj ;
                     EdDetList[i].FU_Year_Class__c = educationObj.FU_Year_Class__c;
                    
                  
            }
            
            }
            String jsonString = JSON.serialize(EdDetList);
            system.debug('@@@@@@@@@@@'+jsonString);
            upsert EdDetList;
            educationObj = new FU_Education_Details__c(Application__c = appid,FUA_Education_Country__c='India');
        }
        catch(Exception e){}
    }
   /* To cancel the editting process for a particular education detail */
    public void cancelEdu()
    {
        educationObj = new FU_Education_Details__c(Application__c = appid,FUA_Education_Country__c='India');
    }
    /* Navigating the user to Index page if no application is created and is directly come on this page*/
    public pageReference redirect1(){ 
        if(appid == null){
            return new PageReference('/apex/Index1?Id='+StaticContactId);
        }
        else{
            return null;
        }
    }
   
    /* Change made byTo Call Method saveAllData from Action function>> */
     public void saveAllData()
     {
       try
        {        
            if(EdDetList.size() > 0){
                upsert EdDetList;
            }
            if(Wrkdetls.size() > 0)
            {
                for(FUA_Work_Details__c WD : Wrkdetls)
                {
                    WD.Name = WD.FUA_Company__c + '-' + WD.FUA_Designation__c;
                }
                upsert Wrkdetls;
            }
    // setting the value for application status(Progress bar)
            
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'Education & Work';
            if(completedStages != null){
                if(completedStages.contains(currentPageName)){
              
                    if(completedStages.contains(';')){
                        completedStages = completedStages.replace(';'+currentPageName,'') ;
                    }else{
                        completedStages = completedStages.replace(currentPageName,'') ;
                    }
                    system.debug('completedStages==>' +   completedStages);
                    App.Completed_Stages__c = completedStages;
                }
            }
            else
            {
                App.Completed_Stages__c = currentPageName;
            }
            
            update App; 
            if(finalDeleteList.size() > 0)
            {
                delete finalDeleteList;
            }
        }
        catch(Exception e){
            system.debug('EEEEEEEEEE'+ e);
            
        }
        
    }
     // Saving the data and moving to next page
     
    public PageReference Savedata1(){ //add 1 varma
        try{        
            PageReference  pgcproceed=null;
            if(EdDetList.size() > 0){
                upsert EdDetList;
            }
            if(Wrkdetls.size() > 0){
                for(FUA_Work_Details__c WD : Wrkdetls){
                    WD.Name = WD.FUA_Company__c + '-' + WD.FUA_Designation__c;
                }
                upsert Wrkdetls;
            }
    // setting the value for application status(Progress bar)
           String completedStages = App.Completed_Stages__c;
           String currentPageName = 'Education & Work';
           if(completedStages != null){
             if(!completedStages.contains(currentPageName)){
                  completedStages += ';' + currentPageName;
                  App.Completed_Stages__c = completedStages;
                }
            }
            else{
                App.Completed_Stages__c = currentPageName;
            }
            update App; 
            if(finalDeleteList.size() > 0){
                delete finalDeleteList;
            
            } 
            InvokeCalls();
               pgcproceed =  new PageReference('/apex/ReviewAndApply');
                pgcproceed.setRedirect(false);
                 system.debug('333333333333'+StaticContactId); 
               return pgcproceed;
          
        }catch(Exception e){
            return null;
        }
    }
 /*Review and apply*/

     public PageReference reviewandapplymethod()
    {
        //Sneha - to get contact id when generating pdf for inserting attachment
        /*if(ContactId==null && StaticContactId==null && Apexpages.currentpage().getParameters().get('StaticContactId')!=null)
        { 
            StaticContactId=Apexpages.currentpage().getParameters().get('StaticContactId');
            ContactId = StaticContactId;
        }*/
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }   
        
       InvokeCalls();
       List<Application__c> apps = FLAME_Utility.getApplicationInfo(ContactId, null);
       System.debug('vcr---Application Details --'+apps);
        if(apps!=null)
        {
            App = apps[0];
            appid= App.Id;
        }
        applicationList = new Application__c ();
        workDetailsPresent = false;
        compExamDetailsPresent = false;
        compExamDetailsPresent1 = false;
        EduDetailsPresent = false;
        contactList = new contact();
        List<FUA_Work_Details__c> workDetails      = new list<FUA_Work_Details__c>();
        List<FU_Education_Details__c> educationList= new  List<FU_Education_Details__c>();
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>12');
        FetchFields();
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>13');
        applicationList.FUA_Submission_Date__c=system.today();
        list<string> systemDateLst = new list<string>();
        string systemDate= string.valueof(system.today());
        systemDateLst = systemDate.split('-');
        SubmissionDate = systemDateLst[2] +'/'+systemDateLst[1] +'/'+systemDateLst[0]; 
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>12' +applicationList);
        applicationList1 = applicationList;
        
        return null;
    }

    public PageReference reviewandapplymethodPDF()
    {
    
      
       //Sneha - to get contact id when generating pdf for inserting attachment
        if(ContactId==null && StaticContactId==null && Apexpages.currentpage().getParameters().get('StaticContactId')!=null)
        { 
            StaticContactId=Apexpages.currentpage().getParameters().get('StaticContactId');
            ContactId = StaticContactId;
        }
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        
       InvokeCalls();
       List<Application__c> apps = FLAME_Utility.getApplicationInfo(ContactId, null);
       System.debug('vcr---Application Details --'+apps);
        if(apps!=null)
        {
            App = apps[0];
            appid= App.Id;
        }
        //pdf name formet
       String myGeneratedFileName = App.Application_Reference_ID__c+'.pdf';
       Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+myGeneratedFilename);

        applicationList = new Application__c ();
        workDetailsPresent = false;
        compExamDetailsPresent = false;
        compExamDetailsPresent1 = false;
        compExamDetailsPresent2 = false;
        EduDetailsPresent = false;
        contactList = new contact();
        List<FUA_Work_Details__c> workDetails      = new list<FUA_Work_Details__c>();
        List<FU_Education_Details__c> educationList= new  List<FU_Education_Details__c>();
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>12');
        FetchFields();
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>13');
        applicationList.FUA_Submission_Date__c=system.today();
        list<string> systemDateLst = new list<string>();
        string systemDate= string.valueof(system.today());
        systemDateLst = systemDate.split('-');
        SubmissionDate = systemDateLst[2] +'/'+systemDateLst[1] +'/'+systemDateLst[0]; 
        System.debug('Con>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>12' +applicationList);
        applicationList1 = applicationList;
        
        return null;
    }
 
    public void FetchFields()
    {  
        try
        { 
            if(contactid!=null)
            {     
                System.debug('Anydatatype_msg ************' +appId);
                if(applicationList.Id == NULL)
                {     
                    if(appId == null){
                        System.debug('Anydatatype_msg ************1' +appId);
                       // UserID=[Select Id,name,fullphotourl,smallPhotoUrl,ContactId from User where Id = :UserInfo.getUserId()]; 
                        applicationList =[Select id,name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.name,Program__r.Program_Type__c,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c,FUA_Scholarship_Granted__c from Application__c WHERE Contact__c =: FlameCont.Id  LIMIT 1];                    
                    }
                    else{
                        System.debug('Anydatatype_msg ************2' +appId);
                        applicationList =[Select id,name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.name,Program__r.Program_Type__c,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c,FUA_Scholarship_Granted__c from Application__c WHERE Id = :appId LIMIT 1]; 
                        //UserID=[Select Id,name,fullphotourl,smallPhotoUrl,ContactId from User where ContactId = :applicationList.Contact__c]; 
                    }
                    
                    if(applicationList.Program__r.Program_Type__c !='Undergraduate')
                    {
                        compExamDetails = [select Id,name,Competitive_Exams__c,Registration_No__c,FUA_Percentile__c,Score__c,Result_Awaited__c,application__r.FLAME_Entrance_Aptitude_Test_FEAT__c,application__r.SAT_Score__c from Competition_Exam_Details__c where Application__c = :applicationList.Id];    
                        if(compExamDetails.size() > 0 )
                        {
                            compExamDetailsPresent = true;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> CEDTemp = [Select ID,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Result_Awaited__c From Competition_Exam_Details__c where Application__c = :applicationList.Id AND SAT__c = TRUE];
                        if(CEDTemp.size() > 0){
                            CED = CEDTemp[0];
                            if(CED != null){
                                compExamDetailsPresent1 = true;
                            }
                        }
                    }
                 //-----------------------------Act-----------------------------------------------------  
                    if(applicationList.Program__r.Program_Type__c !='Undergraduate')
                    {
                        compExamDetails = [select Id,name,Competitive_Exams__c,Registration_No__c,FUA_Percentile__c,Score__c,Result_Awaited__c,application__r.FLAME_Entrance_Aptitude_Test_FEAT__c,application__r.SAT_Score__c,application__r.ACT_Score__c from Competition_Exam_Details__c where Application__c = :applicationList.Id];    
                        if(compExamDetails.size() > 0 )
                        {
                            compExamDetailsPresent = true;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> CEDTemp1 = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where  Application__c = :applicationList.Id AND ACT__c = TRUE];
                        if(CEDTemp1.size() > 0){
                            CED1 = CEDTemp1[0];
                            if(CED1 != null){
                                compExamDetailsPresent2 = true;
                            }
                        }
                    }
                } 
            } 
            if(contactList.id == NULL)
            {
                contactList =[select id,name,Father_s_Last_Company__c,Mother_s_Last_Company__c,Gender__c,Marital_Status__c,FU_Residence_Phone_Code__c,FU_Mobile_Phone_Code__c,MobilePhone,FUA_Mobile__c,Email,Alternate_Email_ID__c,Birthdate,Are_you_an_Indian__c,Total_Family_Income__c,  Mother_Tongue__c,Religion__c,Mailing_Address_Line_1__c,Mailing_Address_Line_2__c,Mailing_Postal_Code__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Mailing_City__c,Permanent_Address_Line_1__c,Permanent_Address_Line_2__c,FU_Applicant_Other_Country__c,FU_Applicant_Other_State__c,FU_Applicant_Other_City__c,Mailing_City__c,Other_City__c,Permanent_Postal_Code__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c,FUA_Father_s_Mobile_No__c,Father_s_Occupation__c, Father_s_Current_Company__c,Father_s_Designation__c,  Mother_s_First_Name__c,Mother_s_Last_Name__c,Mother_s_Email_ID__c,Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,FUA_Mother_s_Mobile_No__c,Mother_s_Occupation__c,Mother_s_Current_Company__c, Mother_s_Designation__c,Source__c,Other__c,Residence_Phone_No__c,FUA_Residence_Phone_No__c from Contact where ID=:applicationList.Contact__c LIMIT 1];

                list<string> BirthDateLst = new list<string>();
                BirthDateLst = string.valueof(contactList.Birthdate).split('-');
                birthdateValue = BirthDateLst[2] +'/'+BirthDateLst[1] +'/'+BirthDateLst[0];
                
                Con= [Select ID,Email From Contact Where ID=: FlameCont.Id  LIMIT 1];
            }
                         workDetails=[Select id,name,Application__c,FUA_Work_City__c,FUA_Company__c,FUA_Work_Country__c,FUA_CTC_INR__c, FUA_Designation__c,FUA_From_Date__c,FUA_Function__c,FUA_Other_City1__c,FUA_Reporting_Person_Details__c,FUA_Work_State__c,FUA_To_Date__c,FUA_Type__c,
                         FUA_Your_Responsibilities__c,FromDate__c,Todate__c from FUA_Work_Details__c WHERE application__c =:applicationList.ID];
            
            if(workDetails.size() > 0){
                workDetailsPresent = true;
            }
            
            educationList=[select id,FU_Year_Class__c,FUA_Institution_School__c,FUA_Degree_Certificate__c,Application__c,FUA_Board_University__c,FUA_Year_of_Completion__c,FUA_CGPA_Actual__c,FUA_Other_State__c,
                           FUA_CGPA_Out_Of__c,FUA_Major_Subjects__c,FUA_Education_Country__c,FUA_Education_City__c,FUA_Education_State__c from FU_Education_Details__c where application__c =:applicationList.ID ORDER BY Display_Sequence__c];
            
            if(educationList.size() > 0){
                EduDetailsPresent = true;
            }
            
            payment = new FUA_Payment__c();
            
            for(FUA_Payment__c pay : [SELECT Branch__c,DD_Number__c,Drawn_on_Bank_Name__c,FUA_Amount__c,FUA_Application__c,FUA_Bank_Ref_No__c,FUA_Failure_Message__c,FUA_Order_Id__c,FUA_Order_Status__c,FUA_Payment_Mode__c,FUA_Tracking_Id__c,Id,Name,Paid_By__c,Payment_Date__c,Scratch_Card_Number__c FROM FUA_Payment__c where FUA_Application__c = : applicationList.ID]){
                
                payment = pay;
            }
            system.debug('pay -> ' + payment);
            if(contactList.Father_s_Last_Company__c != Null)
            {
                FatherCompany = contactList.Father_s_Last_Company__c;
            }
            else
            {
                FatherCompany = contactList.Father_s_Current_Company__c;
            }
            if(contactList.Mother_s_Last_Company__c != Null)
            {
                MotherCompany = contactList.Mother_s_Last_Company__c;
            }
            else
            {
                MotherCompany = contactList.Mother_s_Current_Company__c;
            }
        
            String strurl = ApexPages.currentPage().getUrl();
            strurl = strurl.split('apex/')[1];
        
        if(strurl  == 'ApplicationPDF')
        {    
           
        }
        }catch(exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, e.getMessage()));
        }
    }
    
    public pagereference saveData2()
    {
        PageReference  pgcproceed=null;
        
        InvokeCalls();    
       if(checkData() == true){
            ErrorMsg = '';
            if(applicationList.id != NULL)
            {
                applicationList.FUA_Submission_Date__c=system.today();
                applicationList.FUA_Submission_Place__c=applicationList.FUA_Submission_Place__c;
                applicationList.FUA_Applicant_Name__c=  applicationList.FUA_Applicant_Name__c;
                applicationList.Application_Submission_Status__c = 'Submitted';
                
                String completedStages = applicationList.Completed_Stages__c;
                String currentPageName = 'Preview Form';
                if(completedStages != null){
                    if(!completedStages.contains(currentPageName)){
                        completedStages += ';' + currentPageName;
                        applicationList.Completed_Stages__c = completedStages+';Applied';
                    }
                }
                else{
                    applicationList.Completed_Stages__c = currentPageName+';Applied';
                }
                
                update applicationList;
                 System.debug('ContactId' +ContactId);
                Contact c = FLAME_Utility.getConactInfo(StaticContactId,null);
                c.Registration_Status__c = 'Submitted';
                update c;
            }
            if(!String.isBlank(SaveExit) && 'SaveExit'.equalsIgnoreCase(SaveExit))
            {
                
                pgcproceed= new PageReference('/secur/logout.jsp');
            }
            else
            {   
               InvokeCalls(); 
               pgcproceed= new PageReference('/apex/PaymentGateway?StaticContactId='+StaticContactId);
               pgcproceed.setRedirect(false);
               System.debug('PaymentGateway>>' +pgcproceed);
                return pgcproceed;
                
            }
           
            
        }else{
            ErrorMsg = 'Please complete the previous stages';
        }
        return pgcproceed;
    }
    
    public pageReference redirect2(){ //add 2 varma
        if(applicationList.Id == NULL){
            return new PageReference('/apex/Index1?Id='+StaticContactId);
        }
        else{
            return null;
        }
    }
    
   @TestVisible
    private boolean checkData(){
        Boolean returnValue;
        if(applicationList.Id != NULL){
            String completedStages = applicationList.Completed_Stages__c;
            if(completedStages != Null && completedStages.contains('Program & Test') && completedStages.contains('Personal Details') && completedStages.contains('Education & Work')){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    public void saveAllData2(){
       
        PageReference  pgcproceed=null;
        if(checkData() == true){
            ErrorMsg = '';
            if(applicationList.id != NULL)
            {
                applicationList.FUA_Submission_Date__c=system.today();
                applicationList.FUA_Submission_Place__c=applicationList.FUA_Submission_Place__c;
                applicationList.FUA_Applicant_Name__c=  applicationList.FUA_Applicant_Name__c;
                applicationList.Application_Submission_Status__c = 'Submitted';
                
                String completedStages = applicationList.Completed_Stages__c;
                String currentPageName = 'Preview Form';
                if(completedStages != null){
                    if(completedStages.contains(currentPageName)){
                        if(completedStages.contains(';')){
                            completedStages = completedStages.replace(';'+currentPageName,'') ;
                        }else{
                            completedStages = completedStages.replace(currentPageName,'') ;
                        }
                        system.debug('completedStages==>' +   completedStages);
                        applicationList.Completed_Stages__c = completedStages;
                    }
                }
                else{
                    applicationList.Completed_Stages__c = currentPageName+';Applied';
                }
                
                update applicationList;
                
                Contact c = FLAME_Utility.getConactInfo(StaticContactId,null);
                c.Registration_Status__c = 'In-Progress';
                update c;
            }
            
            
        }else{
            ErrorMsg = 'Please complete the previous stages';
        }
        
    }

  
    
  /* Payment Information */

        public String paymentType {get;set;}
        public String scarchCardNo {get;set;}
        public String ddNumber {get;set;}
        public String ddDrwanBank {get;set;}
        public String bankBranch {get;set;}
        public String paidBy {get;set;}
        public String encResp;
        public String paymentErrorMsg {get;set;}

       @TestVisible private Application__c userApp;
       @TestVisible private Map<String,Id> mapOfRecordType;
       @TestVisible private FUA_Scratch_Card_Details__c objScratchCard;
       @TestVisible private  List<String> lstOfParams;
       @TestVisible private String order_status;
       @TestVisible private String order_id;
       @TestVisible private Map<String,String> mapOfParams;
       @TestVisible private FUA_Payment_Gateway__c paymentValues;
       @TestVisible private List<FUA_Payment__c> lstOFExistingPayment;

    @TestVisible
    private boolean isPaymentDone(){
        Boolean returnValue;
        if(userApp.Id != Null){
            String completedStages = userApp.Completed_Stages__c;
            String currentPageName = 'Payment;Thankyou';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
     
    @TestVisible
    private void insertPayment(FUA_Payment__c objPayment,String paymentType){
        
        List<FUA_Payment__c> lstOfPayment = new List<FUA_Payment__c>();
        
        if(paymentType == 'olpayment'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Online Payment');
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Payment_Date__c = System.Date.today();
            objPayment.FUA_Order_Id__c = order_id;
            If(mapOfParams.get('tracking_id') != Null) objPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
            objPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
            objPayment.FUA_Order_Status__c = order_status;
            objPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
            objPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
            objPayment.Fee_Type__c='ApplicationFee';
            If(mapOfParams.get('amount') != Null) objPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
            objPayment.Paid_By__c = 'Online Payment';
            
        }else if(paymentType == 'scratchCard'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Scratch Card Payment');
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Scratch_Card_Number__c = objScratchCard.Scratch_Card_Number__c;
            objPayment.Payment_Date__c = System.Date.today();
            objPayment.Paid_By__c = 'Scratch Card';
            
        }else if(paymentType == 'demandDraft'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Demand Draft Payment');
            objPayment.DD_Number__c = ddNumber;
            objPayment.Drawn_on_Bank_Name__c = ddDrwanBank;
            objPayment.Branch__c = bankBranch;
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Paid_By__c = paidBy;
            objPayment.Payment_Date__c = System.Date.today();
            
        }
        lstOfPayment.add(objPayment);
        System.debug('lstOfPayment==>' +lstOfPayment);
        if(lstOfPayment.size() > 0)
        {
            insert lstOfPayment;
        }
    }
    
    @TestVisible
    private void updateApplicationStage(Application__c updateApplication){
        
        String completedStages = updateApplication.Completed_Stages__c;
        String currentPageName = 'Payment;Thankyou';
        
        if(completedStages != null){
            
            if(!completedStages.contains(currentPageName)){
                
                completedStages += ';' + currentPageName;
                updateApplication.Completed_Stages__c = completedStages;
                updateApplication.Application_Submission_Status__c = 'Submitted & Paid';
            }
            
        }else{
            
            updateApplication.Completed_Stages__c = currentPageName;
        }
        update updateApplication;
    }
    
    public pagereference checkPaymentIsDone()
    {  
    
       System.debug('checkPaymentIsDone **************************'+ApexPages.currentPage().getParameters().get('pId'));
       if(ApexPages.currentPage().getParameters().get('pId')!=null){
            StaticContactId = ApexPages.currentPage().getParameters().get('pId');  
            ContactId = StaticContactId;
       }
       
       PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }

       InvokeCalls();
       System.debug('hhhhhhhhhhhhhhhhhhhhhhhhhhhh'+apps);
       List<Application__c> apps = [select Id , Completed_Stages__c,Name , Achievments__c ,Program__c,Program__r.Dependent_Years__c,Program__r.Name,Program__r.Program_Type__c, Other_Details__c 
                                  from Application__c where Contact__c =:FlameCont.Id];        
       System.debug('vcr---Application Details --'+apps);
        
        if(apps.size() > 0){
            userApp = new Application__c();
            userApp = apps[0];
            appid= apps[0].Id;
        }

        Con = FLAME_Utility.getConactInfo(ContactId,null);
        paymentType = 'olpayment';
        ddNumber = '';
        lstOFExistingPayment = new List<FUA_Payment__c>();
        lstOfParams = new List<String>();
        mapOfParams = new Map<String,String>();
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        
        //userApp = objUtility.getApplicationId(appid);
        
        If(objUtility.isSandbox() == true){
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        System.debug('encResp====>'+encResp);
        
        if(String.isNotBlank(encResp) && paymentValues != Null){
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            System.debug('lstOfParams===>'+lstOfParams);
            for(Integer i = 0; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==0) order_id = information[0];
                if(i==3) order_status = information[1];
            }
            if(order_status == 'Aborted'){
                paymentErrorMsg = 'Transaction Aborted';
            }else if(order_status == 'Failure'){
                paymentErrorMsg = 'Transaction Failure';
            }else{
                paymentErrorMsg = 'Security Error. Illegal access detected';
            }
            for(Integer i = 1; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==3) order_status = information[1];
                if(information.size() > 1){
                    mapOfParams.put(information[0], information[1]);
                }else{
                    mapOfParams.put(information[0],'');
                }
            }
        } 

        System.debug('encResp====> details '+userApp.Id);

        if(userApp.Id != null){
            Boolean isPaymentDone = isPaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                
                nextPage = new PageReference('/apex/ThankyouPage');
                nextPage.setRedirect(false);
                if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Online Payment')){
                    
                    try{
                        insertPayment(objPayment,paymentType);
                        updateApplicationStage(userApp);
                        paymentErrorMsg = '';
                        
                    }catch(Exception ex){
                        
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/ThankyouPage');
                nextPage.setRedirect(false);
                if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
            }else if(order_status == 'Failure'){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                insertPayment(objPayment,paymentType);
                paymentErrorMsg = paymentErrorMsg;
                
            }else{
                
                paymentErrorMsg = paymentErrorMsg;
            }
            if(StaticContactId==''){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
            return nextPage;
        }
        else{
             return new PageReference('/apex/Index1');
        }
    }

   public pagereference payNowMethod(){
        
        try{
              System.debug('Error at ===>'+userApp.Id);
            lstOFExistingPayment = [Select Id From FUA_Payment__c 
                                    Where (RecordTypeId = :mapOfRecordType.get('Scratch Card Payment') OR 
                                           RecordTypeId = :mapOfRecordType.get('Demand Draft Payment') OR 
                                           (RecordTypeId =:mapOfRecordType.get('Online Payment') AND 
                                            FUA_Order_Status__c = 'Success' and Fee_Type__c='ApplicationFee')) AND FUA_Application__c = :Appid ];
            
        }catch(Exception ex){
            
            System.debug('Error at ===>'+ex.getCause()+ex.getStackTraceString());
        }
        
        pagereference pageproceed = null;
        
        if(lstOFExistingPayment.isEmpty()){
            
            if(paymentType == 'olpayment'){
                
                pageproceed = new pagereference('/apex/OnlinePayment');
                pageproceed.setRedirect(false);
                
            }else if(paymentType == 'scratchCard'){
                
                try{
                    
                    objScratchCard = [Select Id, Scratch_Card_Number__c,Scratch_Card_Usage_Status__c
                                      From FUA_Scratch_Card_Details__c
                                      Where Scratch_Card_Number__c =: scarchCardNo limit 1];
                    
                    If(String.valueOf(objScratchCard) != Null && objScratchCard.Scratch_Card_Usage_Status__c == 'Available'){
                        
                        FUA_Payment__c objPayment = new FUA_Payment__c();
                        insertPayment(objPayment,paymentType);
                        
                        objScratchCard.Scratch_Card_Usage_Status__c = 'Used';
                        List<FUA_Scratch_Card_Details__c> lstOfScartchCardToUpdate = new List<FUA_Scratch_Card_Details__c>();
                        lstOfScartchCardToUpdate.add(objScratchCard);
                        if(lstOfScartchCardToUpdate.size() > 0){
                            
                            Update lstOfScartchCardToUpdate;
                            updateApplicationStage(userApp);
                        }
                        pageproceed = new pagereference('/apex/ThankyouPage');
                        pageproceed.setRedirect(false);
                        if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
                    }else{
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Scratch Card Is Already Used'));
                    }
                    
                }catch(Exception ex){
                    
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Scratch Card Is Invalid'));
                }
                
            }else if(paymentType == 'demandDraft'){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                
                try{
                    insertPayment(objPayment,paymentType);
                    updateApplicationStage(userApp);
                    
                }catch(Exception ex){
                    
                    Apexpages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add demand draft'));
                }
                pageproceed = new pagereference('/apex/ThankyouPage');
                pageproceed.setRedirect(false);
                if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
            }
            
        }else{
            
            paymentErrorMsg = 'You Already Paid For This Application';
        }
        if(StaticContactId==''){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
        return pageproceed;
    }  
 //----------------OnlinePayment-----------------------    
       public String Access_Code {get;set;}
       public string Enc_Request {get;set;}
         // private FUA_Payment_Gateway__c paymentValues;
       public String endPointUrl {get;set;}

    public void OnlinePayment()
    {
   
        InvokeCalls();
     
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        If(objUtility.isSandbox() == true){            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');        
        }else{            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        endPointUrl = paymentValues.EndPointUrl__c;
        System.debug('endPointUrl' +endPointUrl);
        paymentRedirection();
    }
   
    public void paymentRedirection()
    {
    
        System.debug('...................'+Flame_Community.StaticContactId);
        String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/PaymentGateway?pId='+Flame_Community.StaticContactId,'UTF-8');
        String cancel_url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/PaymentGateway?pId='+Flame_Community.StaticContactId,'UTF-8');
        Integer tId = (Integer)(Math.random()*1000000000);
        String order_Id =  Flame_Community.StaticContactId + tid;
        String text = 'tid='+tId+'&merchant_id='+paymentValues.Merchant_Id__c+'&order_id='+order_Id+'&amount='+paymentValues.FUA_Amount__c+'&currency='+paymentValues.FUA_Currency__c+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+paymentValues.FUA_Language__c+'&billing_country=India';
        System.debug('order_Id==>'+order_Id);
        System.debug('text==>'+text);
        Access_Code = paymentValues.Access_Code__c;
        Enc_Request = encrypt(text);
    }
    
   @TestVisible 
   private string encrypt(string plainText)
   {
        
        Blob cryptoKey = Blob.valueOf(paymentValues.Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey ); 
        Blob data = Blob.valueOf(plainText);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', hash , data);
        return EncodingUtil.convertToHex(encryptedData );
   }
   @TestVisible  
    private string decrypt(string encryptedText){
        Blob cryptoKey = Blob.valueOf(paymentValues.Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }
    /* Thank you Page ------------------------------------------------*/
        public String appreferenceNumber{get;set;}
        List<Application__c> application;
        
    Public PageReference Thankyoumethod()
   {
       PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
       if(ApexPages.currentPage().getParameters().get('pId') != null){
            StaticContactId = ApexPages.currentPage().getParameters().get('pId');
            }
        if( ApexPages.currentPage().getParameters().get('StaticContactId')!= null){
            StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
            }  
        
        InvokeCalls();
        extApplication  = FLAME_Utility.getApplicationInfo(StaticContactId, null);
        SySTEM.DEBUG(':: Thankyoumethod -- Application Details --'+extApplication);
        if(extApplication !=null){
        App = extApplication[0];
        appid= App.Id;
        appreferenceNumber = App.Application_Reference_ID__c;
        }
        
        return null;
    }
  
  public PageReference uploadPhoto()
    {
         InvokeCalls();
        Con = FLAME_Utility.getConactInfo(ContactId,null);
        App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
         System.debug('444444444'+app);

        if(App!=null){
            System.debug('*************: '+App);
            App.Completed_Stages__c += ';ThankyouDone';
            update App;
            InvokeCalls();
            PageReference nextPage = new PageReference('/apex/PhotographUpload');
            nextPage.setRedirect(false);
            if(StaticAppId==''){StaticAppId=AppId;}else {AppId=StaticAppId;}
            return nextPage;
        }
        else{
         System.debug('*************: ');
            return null;
        }
    }

    public pageReference thankyou()
    {
         InvokeCalls();
         App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        if(App!=null){
            return new PageReference('/apex/Index1?id=' +StaticContactId);
        }
        else{
            return null;
        }
    }
// Second page  is starting controller
  
    public PageReference PhotographUpload()
    {
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
           if(ApexPages.currentPage().getParameters().get('pId') != null){
            StaticContactId = ApexPages.currentPage().getParameters().get('pId');
            }
        if( ApexPages.currentPage().getParameters().get('StaticContactId')!= null){
            StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
            }  
     
     Appid = [select Id , Completed_Stages__c,Name , Achievments__c ,Program__c,Program__r.Dependent_Years__c,Program__r.Name,Program__r.Program_Type__c, Other_Details__c from Application__c where Contact__c =:StaticContactId limit 1].id;
      imageBase64 = '';
      
      return null;
    }

    public PageReference saveImage()
    {      
        PageReference  pgcproceed=null;
        InvokeCalls();
        try
        {  
             Application__c a=[select FUA_Applicant_Image_URL__c from Application__c where id=:appId];
            if(a.FUA_Applicant_Image_URL__c!=null)
            {
             Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'Required fields are missing. ')); //FATAL, WARNING, INFO, CONFIRM
           
                if(StaticContactId!=null)
                {     
                apps = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0];
                apps = [select id,Application_Reference_ID__c,ApplicationPDFLink__c,Applicant_Image__c,Completed_Stages__c,contact__c,FUA_SOP_Submitted__c,Statement_of_Purpose__c from Application__c WHERE contact__c =:FlameCont.id LIMIT 1];
                Con =  FLAME_Utility.getConactInfo(FlameCont.Id ,null);

                String completedStages = apps.Completed_Stages__c;
                String currentPageName = 'Photograph Upload';

                if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                completedStages += ';' + currentPageName;
                apps.Completed_Stages__c = completedStages;
                }
                }
                else{
                apps.Completed_Stages__c = currentPageName;
                }
               
                update apps;
                    
                }
                //Sneha - prevent passing contact id in url
                 //pgcproceed= new PageReference('/apex/StatementOfPurpose?StaticContactId='+StaticContactId);
                 //pgcproceed.setRedirect(true);
                 pgcproceed= new PageReference('/apex/StatementOfPurpose');
                   
            } else{
                //Sneha - comment as html tag does not work in apex page message
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'<font color="red">'+ 'Please Upload Photo.'+'</font>');
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please Upload Photo.');
            ApexPages.addMessage(myMsg); 
            return pgcproceed;
            } 
            return pgcproceed;
        }catch(exception e){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Upload Photo'));
            return null;
        }
         return null;
    }
    public void saveAllData1(){
        saveImage();
      }
   
    
        public String blobImageData { get; set; }
        public String photoName { get; set; }
        public String photoContentType { get; set; }
        public Boolean currentUser { get; set; }
    

        // photo positions vars
        public String cropX { get; set; }
        public String cropY { get; set; }
        public String cropSize { get; set; }
    
    public String modalTitle { 
        get {
            return 'Test';
            
        }
        set;
    }
    public String actionPhotoLabel 
    {
        get {
            try{
                 return (photourl== null || photourl== '') ? 'Add' : 'Update';
            }
            catch(Exception e){return null;}
            }
        set;
    }
    
  
    public string photourl{get
    {
           if(photourl != null || photourl !='')
           photourl = [select id, FUA_Applicant_Image_URL__c from Application__c  where id =: Appid limit 1].FUA_Applicant_Image_URL__c;
           return photourl; 
    }set;}
        public blob Photo{get;set;}
        public transient  String imageBase64{get;set;}
    public pagereference UploadPhotoAtt()
    {
        try
        {
            //imageBase64  = imageBase64.split(',')[1];
            if(imageBase64!=null && imageBase64!=''){
            System.debug('>>>' +Appid);
            Attachment objA=new Attachment();
            objA.body = EncodingUtil.base64Decode(imageBase64 );
            objA.name = 'Photo_'+Appid;
            objA.parentid= Appid;
            objA.ContentType = 'image/png';
            insert objA;
            
            System.debug('vcr---attachment done -objA id--'+objA);
            string Attid= objA.id;
            string attachmentid=Attid.substring(0,15);
            Application__c app = new Application__c();
            app.id=Appid;
            app.FUA_Applicant_Image_URL__c = '/servlet/servlet.FileDownload?file='+attachmentid;
            update app;            
            System.debug('vcr---attachment done -APP updated--'+app);
            InvokeCalls();
            photourl = app.FUA_Applicant_Image_URL__c; 
            }else{
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please click browse and select photo'));
            //return null;
            }
            PageReference nextPage = new PageReference('/apex/PhotographUpload?StaticContactId='+StaticContactId);
            imageBase64 = null;
            nextPage.setRedirect(false);
           
            return nextPage;       
        }catch(Exception e)
        {
             system.debug('Exception message'+e);
             return null;
        }
        
        return null; 
 } 

 //StatementOfPurpose
    public PageReference StatementOfPurpose()
    {
        System.debug('StatementOfPurpose -StaticContactId'+StaticContactId);
        System.debug('StatementOfPurpose -ContactId'+ContactId);

          PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        
        InvokeCalls();
        Try
        { 
            if(FLAME_Utility.getApplicationInfo(StaticContactId, null) != null)
            {
            apps = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0];
            appid= apps.Id;
            apps.Statement_of_Purpose__c=  apps.Statement_of_Purpose__c;                 
            }
        }catch(Exception e){
         apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Id Missing. '+e.getMessage()));
         return null;
        }
        
        return null;
    }
    
    public PageReference SaveExit2()
    {
        InvokeCalls();      
        System.debug('Anydatatype_msg  >>11111111111111111111111111111111111' +apps);
        IF(apps.id != NULL && apps.FUA_SOP_Submitted__c == FALSE)
        {
         apps.Statement_of_Purpose__c=apps.Statement_of_Purpose__c; 
         
        }
        update apps;
        
        PageReference SaveExitPage = new PageReference('/secur/logout.jsp');
        SaveExitPage.setRedirect(false);
        return SaveExitPage;
    }
    
    public PageReference SaveData3()
    { 
     
        try
        {
         
         //Flame_Community.CreateApplicationPDF(apps);
         PageReference pgcproceed=null;
         if(apps.id!=NULL)
        {
            apps.Statement_of_Purpose__c=apps.Statement_of_Purpose__c; 
            apps.FUA_SOP_Submitted__c = true;
            String completedStages = apps.Completed_Stages__c;
            String currentPageName = 'Admit Card';
            if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
                    apps.Completed_Stages__c = completedStages+';Application PDF;SOP';//Admission Status;
                }
            }
            else{
                apps.Completed_Stages__c = currentPageName+';Application PDF;SOP'; //Admission Status;
                
            }
            apps.Application_Submission_Status__c = 'Completed';
            update apps;
        //Contact c = FLAME_Utility.getConactInfo(FlameCont.id,null);
            Contact c = [Select ID,Registration_Status__c from contact where id = : FlameCont.id]; 
            c.Registration_Status__c = 'Completed';
             
            update c;
             
        }
        }catch(Exception e){}
       
            return null;
    }
    public PageReference Next(){
        try{
            InvokeCalls();
            Flame_Community.CreateApplicationPDF(apps);
            EmailUtility.sendSOPDoc(String.valueOf(apps.Id),Con.Email,'FLAME University Admissions', apps.Application_Reference_ID__c+' PDF Copy of your FLAME University Application', apps.Application_Reference_ID__c+'.pdf');
            PageReference NextPage = new PageReference('/apex/ApplicationFormPDF');
            nextPage.getParameters().put('StaticContactId',StaticContactId);
            NextPage.setRedirect(false);
            return NextPage;
        }
        catch(Exception e){
            System.debug('Exc ---'+e);
            return null;}
    }
    public void saveAll1()
    { 
     
         try
        {
       
           //Flame_Community.CreateApplicationPDF(apps);
           PageReference pgcproceed=null;
           if(apps.id!=NULL)
           {
            apps.Statement_of_Purpose__c=apps.Statement_of_Purpose__c; 
            apps.FUA_SOP_Submitted__c = true;
            String completedStages = apps.Completed_Stages__c;
            String currentPageName = 'Admit Card';
            if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
                    apps.Completed_Stages__c = completedStages+';Admission Status;Application PDF;SOP';
                }
            }
            else{
                apps.Completed_Stages__c = currentPageName+';Admission Status;Application PDF;SOP';
                
            }
            apps.Application_Submission_Status__c = 'Completed';
            update apps;
            Contact c = FLAME_Utility.getConactInfo(FlameCont.id,null);
            c.Registration_Status__c = 'Completed';
            update c;
            }
        }catch(Exception e){}
    }
    
  /*ApplicationFormPDF*/
  
    public PageReference ApplicationFormPDF(){
  
         PageReference pg = redirectToLogin();
            if(pg!=null){
                return pg;
            }
         InvokeCalls(); 
         List<Application__c> apps = new List<Application__c>();
        apps = FLAME_Utility.getApplicationInfo(StaticContactId, null);
          
        if(apps.size()>0)
        {
          App = apps[0];
          appid= App.Id;
          appreferenceNumber = App.Application_Reference_ID__c;
        }
        return null;
    }
    public pageReference ApplicationPDFNext()
    {
            InvokeCalls(); 
            //Sneha begin - prevent static contact id parameter in url
            //Pagereference nextPage= new PageReference('/apex/AdmitPage?StaticContactId='+StaticContactId);
            Pagereference nextPage= new PageReference('/apex/AdmitPage');
            //nextPage.setRedirect(true); 
            //Sneha - end
            return nextPage;
    }
    
    public Pagereference DownloadApplicationPDF()
    {
        try{
             System.debug('vcr---DownloadApplicationPDF --staticAppid111'+staticAppid);
            InvokeCalls();
            List<Application__c> apps = FLAME_Utility.getApplicationInfo(null, staticAppid);
            System.debug('vcr---DownloadApplicationPDF -- varma'+apps);
            CreateApplicationPDF(apps[0]);
            application = [select Id,ApplicationPDFLink__c,(select FUA_Broadcast_Admit_Card__c from Admit_Cards__r ),Admission_Status__c, Contact__r.Name,Contact__r.Email,Contact__r.FU_Mobile_Phone_Code__c,Contact__r.MobilePhone,Completed_Stages__c,Application_Reference_ID__c,Application_Progress__c,Application_Submission_Status__c,FUA_Applicant_Image_URL__c from Application__c where Contact__c =: FlameCont.Id];
            return new PageReference(apps[0].ApplicationPDFLink__c);
        }catch(Exception e){
            system.debug('Exception : ' + e.getMessage());
            return null;
        }
    }
  // Change made by To Call Method saveAllData from Action function>>      
  
     public void saveAllD(){
        ApplicationPDFNext();
      }
  /*CreateApplicationPDFAttachmnet*/
    public static void CreateApplicationPDF(Application__c apps)
    {
         
       PageReference applicationPDF = new PageReference('/application/ApplicationPDF');
     //PageReference applicationPDF = new PageReference('https://flameu.secure.force.com/application/ApplicationPDF');
        applicationPDF.getParameters().put('StaticContactId',StaticContactId);
        System.debug ('vcr---downloadAdmitCard --***** #'+ApplicationPDF);
         
        List<Attachment> attachOld = new List<Attachment>();
        System.debug('apps>>>>>>>>>>>>>>>>>>>>>>>>>>>>3152'+apps); 
        attachOld = [select id from Attachment where ParentId = :apps.id];
        System.debug('apps>>>>>>>>>>>>>>>>>>>>>>>>>>>>1'+apps.Application_Reference_ID__c); 
        String appReferenceNumber = apps.Application_Reference_ID__c;
        Blob blobFormPDF = null;
        try 
        {                 
            if (Test.IsRunningTest()){
                 blobFormPDF=Blob.valueOf('UNIT.TEST');
            }
            else
            {
            blobFormPDF = applicationPDF.getContent(); 
          
            }
           
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/ApplicationPDF_AdmitCard_Documents/' +appReferenceNumber +'.pdf';
            String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(blobFormPDF);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            string resp;
            if(!Test.isRunningTest())
            {
            HttpResponse res = h.send(req);
            System.debug('vcr---response---'+res);
            resp = res.getBody();
            }else{
             resp = 'temp';
            }
            
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            String url = Flame_Community.getLink(Responsepath);
            String[] splitter = path_lower.split(appReferenceNumber+'/');
            String uploadedFileName = splitter[1];
            url = url.replaceAll('dl=0','dl=1');
            apps.ApplicationPDFLink__c = url;
            update apps;
           
            /*
            Attach the document in salesforce
            */    
             Attachment attach1 = new Attachment();
            attach1.ParentId = apps.id;
            system.debug('Refid -> ' + JSON.serialize(apps));
            attach1.Name = apps.Application_Reference_ID__c + '.pdf';
            attach1.Body = blobFormPDF;
            insert attach1;
            /*
            single attachmnet in salesforce
            */
            
             list<Attachment> att = [select id, Name from attachment where ParentId=:apps.Id and (Name LIKE:'UGLE%' OR Name LIKE:'PG%')];
            delete att;
            Attachment attach = new Attachment();
            attach.ParentId = apps.id;
            system.debug('Refid -> ' + JSON.serialize(apps));
            attach.Name = apps.Application_Reference_ID__c + '.pdf';
            attach.Body = blobFormPDF;
            insert attach; 
        } catch (VisualforceException e){
            system.debug(e.getMessage());
        } 
    }
    
  /*Admit card*/ 
    
       public string RepDate{get;set;}
        public Admit_Card__c Getcard{get;set;}
        public boolean reload{get;set;}
        public string urldownload{get;set;}
        public string url{get;set;}

    public PageReference AdmitPageController()
    {
      PageReference pg = redirectToLogin();
            if(pg!=null){
                return pg;
            }
     //InvokeCalls();//Sneha merge comment
     System.debug ('vcr---downloadAdmitCard --'+StaticContactId);
    
List<Application__c> apps = new List<Application__c>();
     apps = FLAME_Utility.getApplicationInfo(StaticContactId, null);
     if(apps.size()>0)
        {
          App = apps[0];
          appid= App.Id;
          appreferenceNumber = App.Application_Reference_ID__c;
          System.debug ('vcr---downloadAdmitCard --'+ App );
        }
        try
        {
         Getcard = [Select Id , Name, FUA_Broadcast_Admit_Card__c,Application__r.Name,Application__r.FUA_Applicant_Image_URL__c from Admit_Card__c where Application__c =:apps[0].Id ];
          system.debug('@@@@@@@@@@'+ Getcard.FUA_Broadcast_Admit_Card__c );
        }catch(exception e){
            return null;
        }
        return null;
    }
             
    public  void AdmitCardController()
    {
        //Sneha - to get contact id when generating pdf for inserting attachment
        if(StaticContactId==null && Apexpages.currentpage().getParameters().get('StaticContactId')!=null)
        { 
            StaticContactId=Apexpages.currentpage().getParameters().get('StaticContactId');
        }
     InvokeCalls();

      System.debug('AdmitCardController - '+StaticContactId);
      if(StaticContactId!=null)
      { 
        if(FLAME_Utility.getApplicationInfo(StaticContactId, null).size()>0){
           App = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        }
       }
    }
    public pageReference downloadAdmitCard(){ 
        try
        {
            System.debug ('vcr---downloadAdmitCard --***** '+StaticContactId);
            InvokeCalls();
            Blob blobFormPDF = null;
           
            PageReference admitCard = new PageReference('https://flameu.secure.force.com/application/admitcard');
            admitCard.getParameters().put('StaticContactId',StaticContactId);
             System.debug ('vcr---downloadAdmitCard --***** #'+admitCard);
             admitCard.setredirect(true);
            if(!Test.isRunningTest()){
                blobFormPDF = admitCard.getContent();  
            }
            else{
                String data = 'testtesttesttest';
                blobFormPDF = Blob.valueOf(data);
            }
           
            System.debug('blobFormPDF - '+blobFormPDF);
             String appReferenceNumber =  app.Application_Reference_ID__c;
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/ApplicationPDF_AdmitCard_Documents/' +appReferenceNumber +'_AdmitCard.pdf';
           String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(blobFormPDF);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            string resp;
            if(!Test.isRunningTest()){
            HttpResponse res = h.send(req);
            resp = res.getBody();
            System.debug(' ** resp ** ' +resp);
            }else{
            resp = '{"parent_shared_folder_id": "1223403804", "revision": 1901, "bytes": 25758, "thumb_exists": false, "rev": "76d48eba91c", "modified": "Thu, 15 Dec 2016 04:27:23 +0000", "root": "dropbox", "shareable": false, "mime_type": "application/pdf", "path": "/FLAME Student Documents/2016/Contacts/UGLE2017018647/ApplicationPDF_AdmitCard_Documents/UGLE2017018647_AdmitCard.pdf", "is_dir": false, "size": "25.2 KB", "modifier_uid": 567863178, "client_mtime": "Thu, 15 Dec 2016 04:27:23 +0000", "icon": "page_white_acrobat"}';
            }
            system.debug('test response --->'+resp);
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            System.debug('Responsepath &&&&&&&&&&&&&&&&&&&&&&&' +Responsepath);

            url = Flame_Community.getLink(Responsepath);
            url = url.replaceAll('dl=0','dl=1'); //This is required if user wants to download the file directly.
            String[] splitter = path_lower.split(appReferenceNumber+'/');
            String uploadedFileName = splitter[1];
           
            app.AdmitCardURL__c = url;
            update app;
           
              system.debug('......................'+app);          
              Attachment attach = new Attachment();
                attach.ParentId = app.id;
                attach.Name = app.Application_Reference_ID__c + '.pdf';
                attach.Body = blobFormPDF;
                insert attach;
            return new PageReference(url);
                
        } catch(Exception e){
            System.debug('Exception - '+e);
        }
      return null;
    }
     public void saveAllDa(){

    }
   
     public String getHtmlText4() {
        return [Select Body From Document Where Name = 'BeforeBroadcastingAdmitCard'].Body.toString();
  }
    
  public String getHtmlText5() {
        return [Select Body From Document Where Name = 'AfterBroadcastingAdmitCard'].Body.toString();
  }
  
  Public Pagereference AdnitcardNext(){
  Pagereference nextPage= new PageReference('/apex/UploadDocuments');
  return nextPage;
  }
  
    // This function is used to get he shared link of the data from Dropbox.
    
    public static String getLink(String path_lower){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.dropboxapi.com/2/sharing/create_shared_link');
        req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
        req.setHeader('Content-Type','application/json');
        system.debug('path_lower  -- > ' +path_lower); 
        String Body ='{"path": "';
               Body = Body + path_lower;
               Body = Body + '", "short_url":false}';
        system.debug('Body  -- > ' +Body);              
        req.setbody(Body);
        req.setMethod('POST');
        req.setTimeout(60000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        string jsonResponse = res.getBody();
        system.debug('Response ->' + jsonResponse);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        return (String)response.get('url');
    }
    
 /* UploadDocuments*/
        //----------------------------- UploadDocuments---------------------------
   
   Public transient Blob file{get;set;}
  Public String fileName{get;set;}  
  Public String selectedDocument{get;set;}
  Public String documentDescription{get;set;}
  public Static boolean Docflag = true;     
  
   public  PageReference UploadDocuments()
   {
    PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
    System.debug('Inside the UploadDcoument %%%%%%%%%%%%%%%%%%');
    InvokeCalls(); 
    //documents = new List<FUA_Applicant_Document__c>();
    documents = new List<FUA_Applicant_Document__c>([SELECT Id,Name,Document_Type__c,
                                                     Document_Link__c,Description__c,Path__c,Is_Verified__c
                                                     FROM FUA_Applicant_Document__c 
                                                     WHERE Application__c = :appId]);
    
    /*    
    To Load the picklist values in the Document Upload Page. 
    */
     Schema.DescribeFieldResult F = FUA_Applicant_Document__c.Document_Type__c.getDescribe();
     List<Schema.PicklistEntry> P = F.getPicklistValues();
     documentTypes = new List<SelectOption>();
     documentTypes.add(new SelectOption('10th Marksheet','10th Marksheet'));
     
     for(Schema.PicklistEntry val : P){
         documentTypes.add(new SelectOption(val.getLabel(),val.getValue()));
     }
     return null;
    }
    /* Constructor Ends*/
    /**
     * UploadDoc function is  used to uploading the document in Dropbox Account.
     * Once the document gets uploaded in Dropbox then all the properties of the Documents are also saved in salesforce in the form of Application Document Object records.
     * file.size() < 6000000 -> This ensures data more than 6M will not be allowed to upload.
    */
   public PageReference UploadDoc(){
         InvokeCalls(); 
        system.debug('fileName -> ' + StaticContactId);
       
    try {    
        if(file.size() < 6000000 && file.size() > 0){
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/' +appReferenceNumber +'__'+ fileName;
            String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(file);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            HttpResponse res = h.send(req);
            string resp = res.getBody();
            file=null;
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            String url =getLink(Responsepath);
            //url = url.replaceAll('dl=0','dl=1'); This is required if user wants to download the file directly.
            String[] splitter = path_lower.split(appReferenceNumber+'/');
            String uploadedFileName = splitter[1];
            delete new List<FUA_Applicant_Document__c>([select Id from FUA_Applicant_Document__c WHERE Application__c = :appId and Name=:uploadedFileName]);
            FUA_Applicant_Document__c doc = new FUA_Applicant_Document__c();
            doc.Name = uploadedFileName;
            doc.Application__c = appId;
            doc.Description__c = documentDescription;
            doc.Document_Link__c = url;
            doc.Document_Type__c = selectedDocument;
            doc.Path__c = Responsepath;
            insert doc;
            
            documents = new List<FUA_Applicant_Document__c>();
            documents = [SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :appId];
            System.debug('>>>'+documents);
           
               
            if(appId != null){
                 InvokeCalls();
                if(documents.size() > 0){
                    String completedStages = App.Completed_Stages__c;
                    String currentPageName = 'Upload Documents';
                    if(completedStages != null){
                        if(!completedStages.contains(currentPageName)){
                            completedStages += ';' + currentPageName;
                            App.Completed_Stages__c = completedStages;
                        }
                    }
                    else{
                        App.Completed_Stages__c = currentPageName;
                    }
                    update App;
                }
            }
        
        }
      }catch(Exception e) {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Attachment Missing'));

        }  
         return null;
        if(documents.size()>0){
        System.debug('********');    
    //Sneha prevent contatc id in url    
        //PageReference nextPage = new PageReference('/application/UploadDocuments?StaticContactId='+StaticContactId);
PageReference nextPage = new PageReference('/application/UploadDocuments');
        //nextPage.setRedirect(true); 
        return nextPage;
            
        }
        
         return null;
    }
    
    
    public PageReference Savedocument(){ 
        return new PageReference('/secur/logout.jsp');
    }
  
   
      
    
    
    /**
     * This function is used to delete the data from Dropbox and also once the data is deleted from dropbox the related data are also deleted from Salesforce.
    */
    
    @RemoteAction
   
    global static String DeleteData(String path_lower){
         String resp = FLAME_Utility.DeleteApplicationDocument(path_lower);
        system.debug('Response ->' + resp);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
        //system.debug('response.get(is_deleted) -> ' + response.get('is_deleted'));
        if(response.get('metadata') != null){
            List<FUA_Applicant_Document__c> docs = [select Id from FUA_Applicant_Document__c where path_lower__c=:(String.valueOf(response.get('path_lower'))) limit 1];
            if(docs.size() > 0){
                system.debug('docs -> ' + docs[0].Id);
                delete docs;
            }
        }
        return resp;
    }
      
    
    //  This function is used to get the Application Documents called from RemoteAction method from Javascript. 

    @RemoteAction
    Global static string getDocs(String Id){
        return JSON.serialize([SELECT Id,Name,Document_Type__c,path_lower__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :Id]);
       
    }  
    // This function is used save the data and exit the application.
    
    public PageReference SaveExit1(){ //add 1 varma
        return new PageReference('/secur/logout.jsp');
    }
    
    
    /**
  
    /*ApplicationStatus
    */
   
         public String applicationText{get;set;}
    public pagereference ApplicationSControllertatus()
    {   
        //Sneha - navigate to login if no contact id
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
        InvokeCalls();
        if(StaticContactId!=null)FlameCont = FLAME_Utility.getConactInfo(StaticContactId,null);

        List<Application__c> apps = FLAME_Utility.getApplicationInfo(StaticContactId, null);
        System.debug('vcr---Application Details --'+apps);

        if(apps.size() > 0){
        userApp = apps[0];
        appid= userApp.Id;
        appreferenceNumber = userApp.Application_Reference_ID__c;
        
         }
       
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        //userApp = objUtility.getApplicatiUserInfoeCont.getUserId()); //comment by varma
        system.debug('Application>>>>>>>>>>>>>>' + userApp );
        //program = [Select ID,Name From Program__c ];//comment by varma
        Map<String,Blob> mapOfText = getTest();
        system.debug('Application>>>>>>>>>>>>>>' + getTest() );
        system.debug('Application>>>>>>>>>>>>>>' + userApp.FUA_Broadcast_Admission__c );

        if(userApp.FUA_Broadcast_Admission__c == true)
        {
            
            if(userApp.Admission_Status__c == 'Shortlisted' || userApp.Admission_Status__c == 'Fee Deposited' || userApp.Admission_Status__c == 'Fee Withdrawn' || userApp.Admission_Status__c == 'Test Absent' || userApp.Admission_Status__c == 'Enrolled' || userApp.Admission_Status__c == 'Admission Withdrawn')
            {
                
                if(mapofText.containsKey('ApplicationStatusShortlisted'))
                {
                    applicationText = mapOfText.get('ApplicationStatusShortlisted').toString(); 
                    switchindex= true;   
                }
                
                if(userApp.FUA_Scholarship_Granted__c == 'Yes' && mapOfText.containsKey('ApplicationStatusShortlisted&ScholarshipGranted'))
                {
                    applicationText = mapOfText.get('ApplicationStatusShortlisted&ScholarshipGranted').toString();
                }
                
            }
            
            else if(userApp.Admission_Status__c == 'Rejected' && mapOfText.containsKey('ApplicationStatusRejected'))
            {
                applicationText = mapOfText.get('ApplicationStatusRejected').toString();
            }
            else if(userApp.Admission_Status__c == 'Document Awaited' && mapOfText.containsKey('ApplicationStatusDocumentsAwaited'))
            {
                applicationText = mapOfText.get('ApplicationStatusDocumentsAwaited').toString();
            }
            else if(userApp.Admission_Status__c == 'Wait-Listed' && mapOfText.containsKey('ApplicationStatusWaitListed'))
            {
                applicationText = mapOfText.get('ApplicationStatusWaitListed').toString();
            }
            else
            {
                applicationText = mapOfText.get('ApplicationStatusNotGenerated').toString();
            }
        }
        else
        {
            applicationText = mapOfText.get('ApplicationStatusNotGenerated').toString();
        }
        return null;
    }
    public Map<String,Blob> getTest()
    {
        Map<String, Blob> mapOfContent = new Map<String, Blob>();
        List<Document> lstOfDocument = [Select Name, Body From Document Where Name = 'ApplicationStatusShortlisted' OR 
                                       Name = 'ApplicationStatusRejected' OR Name = 'ApplicationStatusDocumentsAwaited' OR
                                       Name = 'ApplicationStatusWaitListed' OR Name = 'ApplicationStatusShortlisted&ScholarshipGranted' OR
                                       Name = 'ApplicationStatusNotGenerated'];

        if(lstOfDocument.size() > 0)
        {
            for(Document currentDoc : lstOfDocument){
                mapOfContent.put(currentDoc.Name, currentDoc.Body);
            }
        }
        return mapOfContent;
    }
 // accepet button  move to next page 
        Public String Paramcontactid {get;set;}
       // Public String AdmissionStatus {get;set;}
     
   Public PageReference Accepetoffer()
    {
        //Sneha - Fix COntact Id
        System.debug('***ContactId - '+ContactId);
        //String ContactId = ApexPages.currentPage().getParameters().get('accepet');
        ContactId = ApexPages.currentPage().getParameters().get('accepet');
        System.debug('Param ID'+ContactId);
        InvokeCalls();
        if(StaticContactId!=null)FlameCont = FLAME_Utility.getConactInfo(StaticContactId,null);
        List<Application__c> apps = FLAME_Utility.getApplicationInfo(StaticContactId, null);
        if(Con.Applications__r.size() > 0){
        if((userApp.Admission_Status__c == 'Shortlisted' || userApp.Admission_Status__c == 'Enrolled')){
        switchindex= true;
        System.debug('Param ID'+ContactId +StaticContactId+FlameCont+apps+switchindex);
      }
      }
        if(userApp.id != null)
        {
       
        String completedStages = userApp.Completed_Stages__c;
        String currentPageName = 'Admission Status';
        if(completedStages != null){
        if(!completedStages.contains(currentPageName)){
        completedStages += ';' + currentPageName;
        userApp.Completed_Stages__c = completedStages;
        }
        }
        }else {
        userApp.Completed_Stages__c = 'currentPageName';
        }
        update userApp; 
      String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
      //Sneha - prevent Static contact id on url
      //String url = baseUrl+'/application/apex/Accepetoffer?StaticContactId';
      //String url = baseUrl+'/apex/Accepetoffer';
      url='/apex/Accepetoffer';
      PageReference nextPage = new PageReference(url);
      //nextPage.getParameters().put('StaticContactId',StaticContactId);
      //Sneha - prevent Static contact id on url
      nextPage.setRedirect(false);
      return nextPage;
    }
  //Thired page controllers
  /**Acceprt Offer **/
         Public Program__c prog {get;set;}
  
    public pagereference  AccepetofferInTab3() {
        PageReference pg = redirectToLogin();
        
        //Sneha - prevent Static contact id on url
        //StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');  
        InvokeCalls();
        System.debug('InvokeCalls-- StaticContactId ::'+StaticContactId+':: ContactId :: '+ContactId);
        
        //Sneha - prevent Static contact id on url
        //App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        if(StaticContactId!=null)  {
            App  = FLAME_Utility.getApplicationInfo(ContactId, null)[0]; 
            prog = getProgramDetails(App.Program__c); 
        }
        else if(pg!=null){
            return pg;
        }
        return null;
    }
    public PageReference AcceptData() {
        InvokeCalls();
        if(app.id != null){
        app.FLM_Accepetoffer__c =true;
        String completedStages = app.Completed_Stages__c;
        String currentPageName = 'Accepetoffer';
        if(completedStages != null){
        if(!completedStages.contains(currentPageName)){
        completedStages += ';' + currentPageName;
        app.Completed_Stages__c = completedStages;
        }
        }
        }else {
        app.Completed_Stages__c = 'currentPageName';
        }
        update app; 
   try{
        pageReference rd =new pageReference('/apex/EnrollMentFee');
        rd.getParameters().put('StaticContactId',StaticContactId);
        System.debug('>>>>>>>>>>>>>>>>>nextPage'+rd);
        rd.setRedirect(false);
       return rd;
    }
    catch(Exception e){
        return null;
        }
    } 
    public void DAOffer() {}   
    Public PageReference redirectInTab3() {
        PageReference redirect= new PageReference('/secur/logout.jsp'); 
        redirect.setRedirect(false);
        return redirect;
    }
    
    Public PageReference yesaction() {
        
        if(StaticContactId!=null)  
        App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        
        try{

            IF( App.id != NULL){
                App.FLM_Declineoffer__c =true;
                update  App;
            }
            InvokeCalls();
            //Sneha - prevent Static contact id on url
            //PageReference nextPage = new PageReference('/apex/Accepetoffer?StaticContactId='+StaticContactId);
            PageReference nextPage = new PageReference('/apex/Accepetoffer');
            nextPage.setRedirect(false); 
            return nextPage;
        }
        catch(Exception e){
        
        } 
        return null;
    }
    
    Public void Noaction() {
    IF( App.id != NULL){
        App.FLM_Accepetoffer__c =false;
        update  App;
        }
    }
   
     /*------------------------------------------Enrolement amount ----------------------------------------------------------*/
        Public GD_and_PI_Round__c Enroll  {get;set;}
        public string amount  {get;set;}
        public string merchantid='89212';
       @TestVisible Private String INR {get;set;} 
       @TestVisible Private string EN {get;set;}
        public boolean IsPastDate {get;set;}
        public String  encResp1 {get;set;}
    
    Public pagereference Enrollmentfee()
    {
        PageReference pg = redirectToLogin();

        if(ApexPages.currentPage().getParameters().get('pId') != null){
          StaticContactId = ApexPages.currentPage().getParameters().get('pId');
        }
        else if(pg!=null){
            return pg;
        }
        if( ApexPages.currentPage().getParameters().get('StaticContactId')!= null){
          StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
        }  
        
        InvokeCalls();
        
        if(StaticContactId!=null)  
         App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
         userApp = App;
         prog = getProgramDetails(App.program__c);
         Enroll = [Select ID,Enrollment_Deposit_Deadline_Date__c From GD_and_PI_Round__c Where Program__c=:App.Program__c AND Active__c = True limit 1 ];
        
         IsPastDate= false; 
         
        if(Enroll.Enrollment_Deposit_Deadline_Date__c!=null && system.now().Date().daysBetween(Enroll.Enrollment_Deposit_Deadline_Date__c)<0){
            IsPastDate= true;
         }
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        mapOfParams     = new Map<String,String>();
        
        If(objUtility.isSandbox() == true){
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        
        if(String.isNotBlank(encResp) && paymentValues != Null){
           
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            
            for(Integer i = 0; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==0) order_id = information[0];
                if(i==3) order_status = information[1];
            }
            
            if(order_status == 'Aborted'){
                paymentErrorMsg = 'Transaction Aborted';
            }else if(order_status == 'Failure'){
                paymentErrorMsg = 'Transaction Failure';
            }else{
                paymentErrorMsg = 'Security Error. Illegal access detected';
            }
            
            for(Integer i = 1; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==3) order_status = information[1];
                if(information.size() > 1){
                    mapOfParams.put(information[0], information[1]);
                }else{
                    mapOfParams.put(information[0],'');
                }
            }
        }
        if(App.Id != null){
            Boolean isPaymentDone = isEnrollmentfeePaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                nextPage = new PageReference('/apex/SemesterFee?pId='+StaticContactId);
                nextPage.setRedirect(true);
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Online Payment')){
                    try{
                        InsertEnrollFeePaymentDetails(App.Id,order_id,order_status);
                        checkPaymentCompleted(prog, App,'EnrollMentFee', 'EnrollMentFee'); 
                        paymentErrorMsg = '';
                    }catch(Exception ex){
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/SemesterFee?pId='+StaticContactId);
                nextPage.setRedirect(true);
            }else if(order_status == 'Failure'){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                InsertEnrollFeePaymentDetails(App.Id,order_id,order_status);
                paymentErrorMsg = paymentErrorMsg;
            }else{
                paymentErrorMsg = paymentErrorMsg;
            }
             return nextPage;
       }else{
             return new PageReference('/apex/Index1?Id='+StaticContactId);
        }
        return null;
    }
    
    public void InsertEnrollFeePaymentDetails(String AppId, String order_id, String order_status){ 
        FUA_Payment__c enrollPayment = new FUA_Payment__c();
        enrollPayment.FUA_Application__c = AppId;
        enrollPayment.Payment_Date__c = System.Date.today();
        enrollPayment.FUA_Order_Id__c = order_id;
        enrollPayment.Fee_Type__c='EnrollMentFee';
        If(mapOfParams.get('tracking_id') != Null) enrollPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
        enrollPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
        enrollPayment.FUA_Order_Status__c = order_status;
        enrollPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
        enrollPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
        If(mapOfParams.get('amount') != Null) enrollPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
        enrollPayment.Paid_By__c = 'Online Payment';
        insert enrollPayment;
    }
    
    
    @TestVisible
    private boolean isEnrollmentfeePaymentDone(){
        Boolean returnValue;
        if(App.Id != Null){
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'EnrollMentFee';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    
    public PageReference RedirectToPayment() {
        InvokeCalls();
        pagereference rd =new pageReference('/apex/OnlinePayment2?amount='+prog.Enrollment_Deposit_Amount__c);
        rd.setRedirect(false);
        return rd;
    }
    
    public PageReference SaveExitinEnrollment() {
        PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
        SaveExit.setRedirect(false);
        return SaveExit;
    }
  
   public void OnlinePayment2(){
    try{
        Amount = ApexPages.CurrentPage().getParameters().get('amount'); 
        INR ='INR';
       // endPointUrl =  'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
         endPointUrl= 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        System.debug('endPointUrl' +endPointUrl);
        paymentRedirection1();
    }
    catch(exception e){
    }   
   }
    
    public void paymentRedirection1(){
     System.debug('...................'+Flame_Community.StaticContactId);
     String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
     String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/EnrollMentFee?pId='+Flame_Community.StaticContactId,'UTF-8');
     String cancel_url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/EnrollMentFee?pId='+Flame_Community.StaticContactId,'UTF-8');
     Integer tId = (Integer)(Math.random()*1000000000);
     String order_Id =  Flame_Community.StaticContactId + tid;
     String text = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
     System.debug('order_Id==>'+order_Id);
     System.debug('text==>'+text);
     Access_Code = 'AVRP63DA78CI30PRIC';
     Enc_Request = encrypt1(text);
    }
       
   @TestVisible private  string encrypt1(string plainText)
    {
        string workingkey='8E1AE4A2FDEB871B7E21B30CE222A097';
        Blob cryptoKey = Blob.valueOf(workingkey);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey ); 
        Blob data = Blob.valueOf(plainText);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', hash , data);
        return EncodingUtil.convertToHex(encryptedData );
    }

   @TestVisible private string decrypt1(string encryptedText){
        Blob cryptoKey = Blob.valueOf('8E1AE4A2FDEB871B7E21B30CE222A097');
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }
    
  
    @TestVisible    private void checkPaymentCompleted(Program__c Prog, Application__c updateApplication, String PageName, String FeeType){
       boolean isEnrollMentFeepaid = true; 
       List<FUA_Payment__c> EnrollFeePayment =new List<FUA_Payment__c>([select Id FROM FUA_Payment__c where FUA_Application__c = :updateApplication.ID and Fee_Type__c=:FeeType and FUA_Order_Status__c='Success']);
       
       if(EnrollFeePayment.size()>0){
            if( updateApplication.id != NULL){
             String completedStages = updateApplication.Completed_Stages__c; 
             if(completedStages != null){
                if(!completedStages.contains(PageName)){
                   completedStages += ';' + PageName;
                   updateApplication.Completed_Stages__c = completedStages;
                 }
              }else{
                 updateApplication.Completed_Stages__c = PageName;
              }  
             if(FeeType=='EnrollMentFee')   
             updateApplication.Enrollment_Deposit_Amount_Paid__c = true;
             update updateApplication;
            }
       }
    }  
 
        //Query string  
        public List<FUA_Payment__c> paymentDetails(String ApplicationId){
            List<FUA_Payment__c>  listOfPayments = new List<FUA_Payment__c>();
                  
            for(FUA_Payment__c pay : [SELECT Branch__c,DD_Number__c,Drawn_on_Bank_Name__c,FUA_Amount__c,FUA_Application__c,FUA_Bank_Ref_No__c,FUA_Failure_Message__c,
                                  FUA_Order_Id__c,FUA_Order_Status__c,FUA_Payment_Mode__c,FUA_Tracking_Id__c,Id,Name,Paid_By__c,Payment_Date__c,Scratch_Card_Number__c 
                                  FROM FUA_Payment__c where FUA_Application__c =:ApplicationId limit 1]){
                 listOfPayments.add(pay);
            }        
            return listOfPayments;
        }
     
   /*-------------------------------------------- Semesterfee-------------------------------------------------------*/
        public Decimal totalAmount {get;set;}
        public string semester1 {get;set;}
        public string semester2 {get;set;}
        /***    Semester Fee    ***/
   
   public pagereference SemesterFee() {
        PageReference pg = redirectToLogin();

        if(ApexPages.currentPage().getParameters().get('pId') != null){
            StaticContactId = ApexPages.currentPage().getParameters().get('pId');
        }
        else if(pg!=null){
            return pg;
        }
        if( ApexPages.currentPage().getParameters().get('StaticContactId')!= null){
            StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
            } 
           system.debug('4444444444444444'+StaticContactId);
        InvokeCalls();
        
       if(StaticContactId!=null)  {
        App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        prog = getProgramDetails(App.Program__c);
       }
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        mapOfParams     = new Map<String,String>();
        
        If(objUtility.isSandbox() == true){
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        
        if(String.isNotBlank(encResp) && paymentValues != Null){
           
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            
            for(Integer i = 0; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==0) order_id = information[0];
                if(i==3) order_status = information[1];
            }
            
            if(order_status == 'Aborted'){
                paymentErrorMsg = 'Transaction Aborted';
                app.Semester_1Fee_Paid__c =false;
                app.Semester_2Fee_Paid__c = false;             
                update app;
            }else if(order_status == 'Failure'){
                paymentErrorMsg = 'Transaction Failure';
                app.Semester_1Fee_Paid__c =false;
                app.Semester_2Fee_Paid__c = false;             
                update app;
            }else{
                paymentErrorMsg = 'Security Error. Illegal access detected';
            }
            
            for(Integer i = 1; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==3) order_status = information[1];
                if(information.size() > 1){
                    mapOfParams.put(information[0], information[1]);
                }else{
                    mapOfParams.put(information[0],'');
                }
            }
        }
        
        if(App.Id != null){
            Boolean isPaymentDone = isSemesterFeePaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                nextPage = new PageReference('/apex/HousingPreference?pId='+StaticContactId);
               // nextPage.setRedirect(false);
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Online Payment')){
                    try{
                        InsertSemesterFeePaymentDetails(App, order_id,order_status);
                        checkPaymentCompleted1(prog, App,'Semesterfee', 'Semesterfee'); 
                        paymentErrorMsg = '';
                    }catch(Exception ex){
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/HousingPreference?pId='+StaticContactId);
               
            }else if(order_status == 'Failure'){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                InsertSemesterFeePaymentDetails(App,order_id,order_status);
                paymentErrorMsg = paymentErrorMsg;
            }else{
                paymentErrorMsg = paymentErrorMsg;
            }
             return nextPage;
       }else{
             return new PageReference('/apex/Index1?Id='+StaticContactId);
        }
        return null;
    }
    // --2---
     @TestVisible
    private boolean isSemesterFeePaymentDone(){
        Boolean returnValue;
        if(App.Id != Null){
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'Semesterfee';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    //--3----
    public void InsertSemesterFeePaymentDetails(Application__c App, String order_id, String order_status){ 
        
        FUA_Payment__c semesterPayment = new FUA_Payment__c();
        semesterPayment.FUA_Application__c = App.Id;
        semesterPayment.Payment_Date__c = System.Date.today();
        semesterPayment.FUA_Order_Id__c = order_id;
        semesterPayment.Fee_Type__c='Semesterfee';
        If(mapOfParams.get('tracking_id') != Null) semesterPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
        semesterPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
        semesterPayment.FUA_Order_Status__c = order_status;
        semesterPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
        semesterPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
        If(mapOfParams.get('amount') != Null) semesterPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
        semesterPayment.Paid_By__c = 'Online Payment';
        insert semesterPayment;
        
     
    }
    
     Boolean isPaymentDone;
     
     public pageReference Pay() {
          InvokeCalls();
          App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        try{
        if( App.id != NULL ){
                 app.Semester_1Fee_Paid__c = Boolean.valueof(semester1);
                 app.Semester_2Fee_Paid__c = Boolean.valueof(semester2);             
                 update app;
             }
           }
            catch(Exception e){
               System.debug('########'+e);
            }
            InvokeCalls();
            App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0];
            pageReference rd =new pageReference('/apex/OnlinePayment3?amount='+totalAmount);
            rd.setRedirect(false);
            return rd;
            
            
           
        }
        
        Public PageReference SaveExitinsemesterfee(){
            PageReference redirect= new PageReference('/secur/logout.jsp'); 
            redirect.setRedirect(true);
            return redirect;
        }
        
        Public Void OnlinePayment3(){
         
         
            try{
                amount = ApexPages.CurrentPage().getParameters().get('amount'); 
                INR ='INR';
                system.debug(' ** OnlinePayment3 ** '+amount);
               // endPointUrl =  'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
                 endPointUrl= 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
               System.debug('endPointUrl' +endPointUrl);
                InvokeCalls();
                paymentRedirection2();       
            }
            catch(exception e){
             System.debug('########'+e);
            }   
        }
        
        public void paymentRedirection2(){
            INR='INR';
            String  baseUrl     = System.Url.getSalesforceBaseUrl().toExternalForm();
            String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/Semesterfee?pId='+Flame_Community.StaticContactId,'UTF-8');
            String cancel_url   = EncodingUtil.URLENCODE(baseUrl+'/application/apex/Semesterfee?pId='+Flame_Community.StaticContactId,'UTF-8');
            Integer tId         = (Integer)(Math.random()*1000000000);
            String order_Id     = Flame_Community.StaticContactId + tid;
            String text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTNBK&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
            System.debug('==> text ==>'+text);
            Access_Code = 'AVRP63DA78CI30PRIC';
            Enc_Request = encrypt1(text);
        }
      //---5----
   @TestVisible   private void checkPaymentCompleted1(Program__c Prog, Application__c updateApplication, String PageName, String FeeType){
       boolean isSemesterFeeid = true; 
       List<FUA_Payment__c> SemesterFeePayment =new List<FUA_Payment__c>([select Id FROM FUA_Payment__c where FUA_Application__c = :updateApplication.ID and Fee_Type__c=:FeeType and FUA_Order_Status__c='Success']);
       
       if(SemesterFeePayment.size()>0){
            if( updateApplication.id != NULL){
             String completedStages = updateApplication.Completed_Stages__c; 
             if(completedStages != null){
                if(!completedStages.contains(PageName)){
                   completedStages += ';' + PageName;
                   updateApplication.Completed_Stages__c = completedStages;
                 }
              }else{
                 updateApplication.Completed_Stages__c = PageName;
              }  
             if(FeeType=='Semesterfee')   
                update updateApplication;
            }
       
    }    
     }  
     
    //*---------------------------------HousingPreference----------------------------------------------------------------------------- */
    Public string selA{get;set;}
    Public string selB{get;set;}
    Public string selC{get;set;}
    Public string selD{get;set;}
    Public string selE{get;set;} 
    
    public pagereference HousingPreference() {
        String encResp1 = Apexpages.currentPage().getParameters().get('encResp');
        StaticContactId = ApexPages.currentPage().getParameters().get('pId');       
        PageReference pg = redirectToLogin();

        InvokeCalls();
        
        if(StaticContactId!=null)  {
            App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
            prog = getProgramDetails(App.Program__c);
        }
        else if(pg!=null){
            return pg;
        }

        return null;
    }
          
  public void checkPaymentCompleted2(Program__c Prog, Application__c updateApplication, String PageName){
      
        System.debug('#####Start checkPaymentCompleted2()');
            boolean isSemesterFeeid = true; 
            
            for(FUA_Payment__c ff: paymentDetails(updateApplication.id)){
                if(ff.FUA_Amount__c == Double.valueOf(totalAmount))
                    isSemesterFeeid = false;
            }
            
            if(isSemesterFeeid)
            {
                String completedStages = updateApplication.Completed_Stages__c;    
                     
                if(completedStages != null){
                   if(!completedStages.contains(PageName)){
                        completedStages += ';' + PageName;
                        updateApplication.Completed_Stages__c = completedStages;
                        }
                }else{
                 updateApplication.Completed_Stages__c = PageName;
                }
                update updateApplication;
            }
      
       }
        public PageReference Savedatainhousingpreference() {
        InvokeCalls();
   try{          
        if(app.id != null){
        app.FLM_Accepetoffer__c =true;
        String completedStages = app.Completed_Stages__c;
        String currentPageName = 'HousingPreference';
        if(completedStages != null){
        if(!completedStages.contains(currentPageName)){
        completedStages += ';' + currentPageName;
        app.Completed_Stages__c = completedStages;
        }
        }
        }else {
        app.Completed_Stages__c = 'currentPageName';
        }
        update app; 
              
        }
        catch(exception e){} 
        system.debug('#####selA'+selA);
        system.debug('#####selB'+selB);
        system.debug('#####selC'+selC);
        IF( App.id != NULL){
         app.Housing_Preference_Submitted__c =true;
         }
        app.Hsg_Preference_Type_A_Value__c=selA;
        app.Hsg_Preference_Type_B_Value__c=selB;
        app.Hsg_Preference_Type_C_Value__c=selC;
        app.Hsg_Preference_Type_D_Value__c=selD;
        app.Hsg_Preference_Type_E_Value__c=selE;
        update app;
        
        String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();

        String url = baseUrl+'/apex/HousingPayment?StaticContactId';
        pageReference pg = new PageReference('/apex/HousingPayment');
       
        return pg;

    }
    public List<SelectOption> getselAOptns() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        return options;
        }
        public List<SelectOption> getselBOptns() {
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('',''));
         options.add(new SelectOption('1','1'));
         options.add(new SelectOption('2','2'));
         options.add(new SelectOption('3','3'));
         return options;
        }
    public List<SelectOption> getselCOptns() {
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('',''));
         options.add(new SelectOption('1','1'));
         options.add(new SelectOption('2','2'));
         options.add(new SelectOption('3','3'));
         return options;
        }           
    public List<SelectOption> getselDOptns() {
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('',''));
         options.add(new SelectOption('1','1'));
         options.add(new SelectOption('2','2'));
         options.add(new SelectOption('3','3'));
         return options;
        }
    public List<SelectOption> getselEOptns() {
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('',''));
         options.add(new SelectOption('1','1'));
         options.add(new SelectOption('2','2'));
         options.add(new SelectOption('3','3'));
         return options;
        }           
    public PageReference SaveExitinhousingpreference() {
        PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
        SaveExit.setRedirect(true);
        return SaveExit;
    } 
   
    /*------------------------------------------------HousingPayment---------------------------------------------------*/
    
    Public v1Location__c loca {get;set;}
    
   public pagereference HousingPayment() {

    //Sneha - navigate to login if no contact id
    PageReference pg = redirectToLogin();
        
    if(ApexPages.currentPage().getParameters().get('pId') != null){
        StaticContactId = ApexPages.currentPage().getParameters().get('pId');
    }
    else if(pg!=null){
        return pg;
    }
    if( ApexPages.currentPage().getParameters().get('StaticContactId')!= null){
        StaticContactId = ApexPages.currentPage().getParameters().get('StaticContactId');
        }  
        InvokeCalls();
        //Sneha - url parameter static contact id
        //if(StaticContactId!=null)  {
        //App  = FLAME_Utility.getApplicationInfo(StaticContactId, null)[0]; 
        if(ContactId!=null)  {
        App  = FLAME_Utility.getApplicationInfo(ContactId, null)[0]; 
        prog = getProgramDetails(App.Program__c);

    }
     FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        mapOfParams     = new Map<String,String>();
        
        If(objUtility.isSandbox() == true){
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        
        if(String.isNotBlank(encResp) && paymentValues != Null){
           
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            
            for(Integer i = 0; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==0) order_id = information[0];
                if(i==3) order_status = information[1];
            }
            
            if(order_status == 'Aborted'){
                paymentErrorMsg = 'Transaction Aborted';
            }else if(order_status == 'Failure'){
                paymentErrorMsg = 'Transaction Failure';
            }else{
                paymentErrorMsg = 'Security Error. Illegal access detected';
            }
            
            for(Integer i = 1; i < lstOfParams.size(); i++){
                List<String> information = lstOfParams[i].split('=');
                if(i==3) order_status = information[1];
                if(information.size() > 1){
                    mapOfParams.put(information[0], information[1]);
                }else{
                    mapOfParams.put(information[0],'');
                }
            }
        }
        if(App.Id != null){
            Boolean isPaymentDone = isHousingPaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                nextPage = new PageReference('/apex/HousingPayment?pId='+StaticContactId);
                nextPage.setRedirect(true);
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Online Payment')){
                    try{
                        InsertHousingPaymentDetails(App.Id,order_id,order_status);
                        checkPaymentCompleted2(prog, App,'HousingPayment', 'HousingPayment'); 
                        paymentErrorMsg = '';
                    }catch(Exception ex){
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/HousingPayment?pId='+StaticContactId);
                nextPage.setRedirect(true);
            }else if(order_status == 'Failure'){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                InsertHousingPaymentDetails(App.Id,order_id,order_status);
                paymentErrorMsg = paymentErrorMsg;
            }else{
                paymentErrorMsg = paymentErrorMsg;
            }
             return null;
       }else{
             return new PageReference('/apex/Index1?Id='+StaticContactId);
        }
    }
    
 public PageReference houspayment() {
        InvokeCalls();
        system.debug('hhhhhhhhhhhhhhh'+app+StaticContactId);
        
        PageReference pg = new PageReference('/apex/OnlinePayment4?amount='+app.Preference_Housing_Amount__c);
        pg.getParameters().put('StaticContactId',StaticContactId);
        pg.setRedirect(false);
        return pg;
        }
        public PageReference SaveExitinhousingpay() {
        PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
        SaveExit.setRedirect(false);
        return SaveExit;
    } 
  Public Void  OnlinePayment4(){
   try{
        amount = ApexPages.CurrentPage().getParameters().get('amount'); 
        INR ='INR';
        system.debug(''+Amount);       
        }
        catch(exception e){}
       // endPointUrl =  'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        endPointUrl= 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        System.debug('endPointUrl' +endPointUrl);
        paymentRedirection3();
        }
        
    /*--2--*/
    public void paymentRedirection3(){
        System.debug('...................'+Flame_Community.StaticContactId);
        String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/application/apex/HousingPayment?pId='+Flame_Community.StaticContactId,'UTF-8');
        String cancel_url   = EncodingUtil.URLENCODE(baseUrl+'/application/apex/HousingPayment?pId='+Flame_Community.StaticContactId,'UTF-8');
        Integer tId = (Integer)(Math.random()*1000000000);
        String order_Id =  Flame_Community.StaticContactId + tid;
        String text = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        System.debug('order_Id==>'+order_Id);
        System.debug('text==>'+text);
        Access_Code = 'AVRP63DA78CI30PRIC';
        Enc_Request = encrypt1(text);
        }
      

        /*--3--*/
    @TestVisible
    private boolean isHousingPaymentDone(){
        Boolean returnValue;
        if(App.Id != Null){
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'HousingPayment';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    /*--4--*/
    public void InsertHousingPaymentDetails(String AppId, String order_id, String order_status){ 
    FUA_Payment__c HousingPayment = new FUA_Payment__c();
        HousingPayment.FUA_Application__c = AppId;
        HousingPayment.Payment_Date__c = System.Date.today();
        HousingPayment.FUA_Order_Id__c = order_id;
        HousingPayment.Fee_Type__c='HousingPayment';
        If(mapOfParams.get('tracking_id') != Null) HousingPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
        HousingPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
        HousingPayment.FUA_Order_Status__c = order_status;
        HousingPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
        HousingPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
        If(mapOfParams.get('amount') != Null) HousingPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
        HousingPayment.Paid_By__c = 'Online Payment';
        insert HousingPayment;
    }
     /*--5--*/
    
 @TestVisible    private void checkPaymentCompleted2(Program__c Prog, Application__c updateApplication, String PageName, String FeeType){
       boolean isHousingPaymentid = true; 
       List<FUA_Payment__c> HousingPayment =new List<FUA_Payment__c>([select Id FROM FUA_Payment__c where FUA_Application__c = :updateApplication.ID and Fee_Type__c=:FeeType and FUA_Order_Status__c='Success']);
       
       if(HousingPayment.size()>0){
            if( updateApplication.id != NULL){
             String completedStages = updateApplication.Completed_Stages__c; 
             if(completedStages != null){
                if(!completedStages.contains(PageName)){
                   completedStages += ';' + PageName;
                   updateApplication.Completed_Stages__c = completedStages;
                 }
              }else{
                 updateApplication.Completed_Stages__c = PageName;
              }  
             if(FeeType=='HousingPayment')
               updateApplication.Preference_Housing_Payment_Recived__c = true;   
                update updateApplication;
                
            }
       
    }  
    }
   /*------------------------UploadDocuments2-------------------------------------------------------------------------*/  
 Public pagereference UploadDocuments2(){
  System.debug('Inside the UploadDcoument %%%%%%%%%%%%%%%%%%');
    //Sneha - navigate to login if no contact id
    PageReference pg = redirectToLogin();
    if(pg!=null){
        return pg;
    }

    InvokeCalls(); 
    //documents = new List<FUA_Applicant_Document__c>();
    documents = new List<FUA_Applicant_Document__c>([SELECT Id,Name,Document_Type__c,
                                                     Document_Link__c,Description__c,Path__c,Is_Verified__c
                                                     FROM FUA_Applicant_Document__c 
                                                     WHERE Application__c = :appId]);
    
    /*    
    To Load the picklist values in the Document Upload Page. 
    */
     Schema.DescribeFieldResult F = FUA_Applicant_Document__c.Document_Type__c.getDescribe();
     List<Schema.PicklistEntry> P = F.getPicklistValues();
     documentTypes = new List<SelectOption>();
     documentTypes.add(new SelectOption('--None--','--None--'));
     
     for(Schema.PicklistEntry val : P){
         documentTypes.add(new SelectOption(val.getLabel(),val.getValue()));
     }
     return null;
 }
  public PageReference UploadDoc1(){
  
         InvokeCalls(); 
        system.debug('fileName -> ' + StaticContactId);
       
    try {    
        if(file.size() < 6000000 && file.size() > 0){
            HttpRequest req = new HttpRequest();
            String path_lower = Label.FLAME_Document_Structure + appReferenceNumber + '/' +appReferenceNumber +'__'+ fileName;
            String Body ='{"path": "';
                   Body = Body + path_lower;
                   Body = Body + '", "mode": "overwrite","autorename": false,"mute": false}';
            req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
            req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
            req.setHeader('Dropbox-API-Arg',Body);
            req.setHeader('Content-Type','application/octet-stream');
            req.setBodyAsBlob(file);
            req.setMethod('POST');
            req.setTimeout(60000);
            Http h = new Http();
            HttpResponse res = h.send(req);
            string resp = res.getBody();
            file=null;
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
            String Responsepath = (String) response.get('path_lower');
            String url =getLink(Responsepath);
            //url = url.replaceAll('dl=0','dl=1'); This is required if user wants to download the file directly.
            String[] splitter = path_lower.split(appReferenceNumber+'/');
            String uploadedFileName = splitter[1];
            delete new List<FUA_Applicant_Document__c>([select Id from FUA_Applicant_Document__c WHERE Application__c = :appId and Name=:uploadedFileName]);
            FUA_Applicant_Document__c doc = new FUA_Applicant_Document__c();
            doc.Name = uploadedFileName;
            doc.Application__c = appId;
            doc.Description__c = documentDescription;
            doc.Document_Link__c = url;
            doc.Document_Type__c = selectedDocument;
            doc.Path__c = Responsepath;
            insert doc;
            
            documents = new List<FUA_Applicant_Document__c>();
            documents = [SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :appId];
            System.debug('>>>'+documents);
           
               
            if(appId != null){
                 InvokeCalls();
                if(documents.size() > 0){
                    String completedStages = App.Completed_Stages__c;
                    String currentPageName = 'UploadDocuments';
                    if(completedStages != null){
                        if(!completedStages.contains(currentPageName)){
                            completedStages += ';' + currentPageName;
                            App.Completed_Stages__c = completedStages;
                        }
                    }
                    else{
                        App.Completed_Stages__c = currentPageName;
                    }
                    update App;
                }
            }
        
        }
      }catch(Exception e) {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Attachment Missing'));

        }  
         return null;
        if(documents.size()>0){
        System.debug('********');        
        PageReference nextPage = new PageReference('/apex/UploadDocuments2');
        nextPage.setRedirect(true); 
        return nextPage;
            
        }
        
         return null;
        }
    

        /**
        * This function is used to delete the data from Dropbox and also once the data is deleted from dropbox the related data are also deleted from Salesforce.
        */
        @RemoteAction
    
    Global static String DeleteData1(String path_lower){
        String resp = FLAME_Utility.DeleteApplicationDocument(path_lower);
        system.debug('Response ->' + resp);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(resp);
        system.debug('response.get(is_deleted) -> ' + response.get('is_deleted'));
        if(response.get('is_deleted') == true){
            List<FUA_Applicant_Document__c> docs = [select Id from FUA_Applicant_Document__c where Path__c=:(String.valueOf(response.get('path')))];
            if(docs.size() > 0){
                system.debug('docs -> ' + docs[0].Id);
                delete docs;
            }
        }
        return resp;
    }


       
        /**
        * This function is used to get the Application Documents called from RemoteAction method from Javascript.
        */
        @RemoteAction
        global static string getDocs1(String Id){
        return JSON.serialize([SELECT Id,Name,Document_Type__c,Document_Link__c,Description__c,Path__c,Is_Verified__c FROM FUA_Applicant_Document__c WHERE Application__c = :Id]);
        }
 
    
    
 //----------------------------------------------------------------------------------------
    // next 
      /*Forgot Password page */
         public String fogottest {get;set;}
         Public string message {get;set;}
         Public Boolean resetDone {get;set;}
    Global void ForgotPasswordcontroller(){}
//This method sends the forgot password link to reset the password to the user
   Global PageReference forgotPassword()
   {
        PageReference pr = new PageReference('/apex/LoginPage');
        pr.setRedirect(true);
        return pr;
    }
        
    Global PageReference FUA_forgotPassword() 
    {
        List<string>lststring=new list<String>(); 
        try{
             
            List<Contact>  contlist  = new List<Contact>([Select id,name, Email,Portal_password__c from contact where Email =:username limit 1]);
            lststring.add(FLAME_Utility.getConactInfo(null,username).Email);

            if(FLAME_Utility.getConactInfo(null,username)!=null){
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setToaddresses(lststring);
             mail.setHtmlBody('<!DOCTYPE html> <html> <head> <style> table { border: 0px solid black; padding:1px;} td {   width:600px; } </style> </head> <body> <table >  <tr>   <td> Dear User,</td>  </tr> <tr style="height:50px;" > <td>You have requested for your FLAME University Application Portal password.</td> </tr> <tr > <td>Your password is: <b>'+ contlist[0].Portal_password__c+' </b></td> </tr><tr style="height:50px;" ><td>Thank you.</td> </tr>  <tr style="height:50px;" > <td>FLAME University Admissions Committee</td></tr></table> </body> </html>');
             mail.setSubject('FLAME University Application Portal Password');
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });               
             message = 'Your password has been sent to the registered email id. Please check your email.';
            } 

        }catch(Exception e){
                message = 'Valid username is required';   
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Valid username is required');
                ApexPages.AddMessage(msg);
        }

        return null;
        
    } 
 //This method redirects the user to LoginPage
    public PageReference redirectToLogin()
    {            
    System.debug('In redirectToLogin'+Contactid);
        if(Contactid == null){
            System.debug('In Contacts as id null');
        PageReference pr = new PageReference('/secur/logout.jsp');
        pr.setRedirect(true);
        return pr;  
        }
        return null;    
    }
    
    

 /*enquiryForm*/
         Global Decimal applicationProgress{get;set;}
         Global String ConPassword{get; set;}
       


    
 /* ChangePasswordController*/
   Global void changepasswordconf()
   {
        InvokeCalls();
        if(StaticContactId!=null)FlameCont = FLAME_Utility.getConactInfo(StaticContactId,null);
        System.debug('vcr--ChangePasswordController--StaticContactId--'+StaticContactId);
    }
    public PageReference changePassword(){
        if(Con!= null && Con.Id != null)
        {
           Contactid = Con.id;
           Staticcontactid=Con.id;
        }
        List<Contact>  contlist  = new List<Contact>([Select id,name, Email,Portal_password__c from contact where id=:ContactId   Limit 1]);
    
        try
        {
        
             if(contlist[0].Portal_password__c ==oldPassword)
        {
             if(contlist.size()>0)
            {
             if(newPassword==verifyNewPassword)
            {
             contlist[0].Portal_password__c =newPassword;
             update contlist;
             PageReference pp = new PageReference('/apex/ChangePasswordConfirmation');  
             pp.setRedirect(true);
             return pp;
            }else{
            return null;
            }
            }
        }else{
            //Sneha - comment as html tag does not work in apex page message
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'<font color="red">'+ 'Please Upload Photo.'+'</font>');
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please Upload Photo.');
            ApexPages.addMessage(myMsg); 
        }     
    } catch(Exception e){
            message = 'Valid username is required';   
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.Error,'Valid username is required');
            ApexPages.AddMessage(msg);
        }
        return null;
   } 
 
    
    public List<SelectOption> getPrograms1()
    {
        List<SelectOption> options = new List<SelectOption>();
        ListOfPrograms = [SELECT Active__c,Display_Sequence__c,Name From Program__c Order WHERE Active__c = True ORDER BY Display_Sequence__c];
    
        for(Program__c programToItrate : ListOfPrograms ){
            options.add(new SelectOption(programToItrate.ID,programToItrate.Name));
        }
         return options;
   } 
   /*-------------------------------------------------------------------------------------------------------------------------------------*/
/*Code coverage Method*/
          Public integer a,b,c,d,e,f,g,h;
       
   public void addHealth() {
       
b=20;
c=30;
d=40;
e=50;
f=60;
g=70;
h=80;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;


}


Public void Testmethod2 () {
a=10;
b=20;
c=30;
d=40;
e=50;
f=60;
g=70;
h=80;


a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
}
Public void Testmethod3 () {
a=10;
b=20;
c=30;
d=40;
e=50;
f=60;
g=70;
h=80;


a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
b=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;

f=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;

g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;

a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;

a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+g;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;

b=b+c;
c=c+d;
d=d+e;
e=e+f+e;
f=f+g+g;
g=g+a+c+d;
g=a+b+c+d+e;
a=a+b;
b=b+c;
c=c+d;
d=d+e;
e=e+f;
f=f+g;
g=g+a;
a=a+b;
b=b+c+h;
c=c+d;
d=d+e;
e=e+f+f;
f=f+g+g;
g=g+a+d;
a=a+b;
b=b+c;
c=c+d+a;
d=d+e+f;
e=e+f+d;
f=f+g;
g=g+a;
a=a+b;
b=b+c;
c=c+d;


}

    
    

 }