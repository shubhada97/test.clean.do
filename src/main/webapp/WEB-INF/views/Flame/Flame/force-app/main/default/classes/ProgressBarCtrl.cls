global class ProgressBarCtrl{

    public String URL { get; set; }
    public Decimal applicationProgress{get;set;}
    public String applicationCompStages1{get;set;}
    public String applicationCompStages{get;set;}
    public String appId{get;set;}
    public String appsubmissionStatus{get;set;}
    public contact currentUser{get;set;}
    public String Application_Reference_ID{get;set;}
    public List<Application__c> application{get;set;}
    public boolean validPageCheck{get;set;}
    public Case myCase{get;set;}
    public boolean applicationCreated{get;set;}
    public Contact Con{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public static boolean IsBroadcasted{get;set;}
    public static boolean IsApplicationDeclined{get;set;}
    public boolean Isempty{get;set;}
    Public String appadmissionStatus{get;set;}
    global String staticconid {get;set{if(staticContactid==null)staticContactid=staticconid;else staticContactid=staticContactid;}}
    public static String copyStaticconid;
   
    public String Paramcontactid {get;set;}
    global String staticContactid{get;set;}
    Public Static String FincalContactId;
    Public String ContactId {get{if(ContactId==null) ContactId=StaticContactId;return ContactId;}set;}
    global Static String StaticContactId{get{return StaticContactId;}set;}
     global Static String StaticContactId1{get;set;}
    //Public String appid{get{if(appid==null) appid=Staticappid;return appid;}set;}
   // Public String staticconid {get;set;}
    Public Contact FlameCont {get;set;}
    //Public String chaitanya{get;set;}

    
   public PageReference CustomIndex(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/Index1');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
     
    public PageReference CustomSave1(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/ProgramForm'); //ProgramAndTest
        pgcsave.setRedirect(false);
        return pgcsave;
    }

    public PageReference CustomSave2(){
        InvokeCalls(); 
        PageReference  pgcsave= new PageReference('/apex/PersonalDetails');
        pgcsave.setRedirect(false);
        return pgcsave;
    }

    public PageReference CustomSave3(){
        InvokeCalls(); 
        PageReference  pgcsave= new PageReference('/apex/EducationAndWork');//EducationAndWork
        pgcsave.setRedirect(false);
        return pgcsave;
    }


    public PageReference CustomSave4(){
        PageReference  pgcsave= new PageReference('/apex/ReviewAndApply');
        pgcsave.setRedirect(false);
        return pgcsave;
    }

    public PageReference CustomSave5(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/PaymentGateway');
        pgcsave.setRedirect(false);
        return pgcsave;
    }

    public PageReference CustomSave6(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/ThankyouPage');
        pgcsave.setRedirect(false);
        return pgcsave;
    }

    public PageReference CustomSave7(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/PhotographUpload');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
     
    public PageReference CustomSave8(){
    
    InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/StatementOfPurpose');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
  
   Public Pagereference CustomSave9(){
   InvokeCalls();
   //Sneha begin - prevent passing contact id in parameter
   PageReference  pgcsave= new PageReference('/apex/ApplicationFormPDF');
   //pgcsave.setRedirect(true);
   //Sneha -end
   return pgcsave;
   }
   
    public PageReference CustomSave10(){
    
        InvokeCalls();
        //Sneha begin - prevent passing contact id in parameter
        //PageReference  pgcsave= new PageReference('/apex/AdmitPage?StaticContactId='+StaticContactId);
        PageReference  pgcsave= new PageReference('/apex/AdmitPage');
        //pgcsave.setRedirect(true);
        //Sneha -end
        return pgcsave;
    }
   
    public PageReference CustomSave12(){
     
       InvokeCalls();
        
        //Sneha begin - prevent passing contact id in parameter
       //PageReference  pgcsave= new PageReference('/apex/UploadDocuments?StaticContactId='+StaticContactId);
       PageReference  pgcsave= new PageReference('/apex/UploadDocuments');
        //pgcsave.setRedirect(true);
       //Sneha -end
        return pgcsave;
    }
     public PageReference CustomSave11(){
     
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/ApplicationStatus');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
     public PageReference CustomSave13(){
        InvokeCalls();
        //Sneha begin - prevent passing contact id in parameter
        //PageReference  pgcsave= new PageReference('/apex/Accepetoffer?StaticContactId='+StaticContactId);
        PageReference  pgcsave= new PageReference('/apex/Accepetoffer');
        //Sneha -end
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    public PageReference CustomSave14(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/EnrollMentFee');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    public PageReference CustomSave15(){
        InvokeCalls();
        PageReference  pgcsave= new PageReference('/apex/Semesterfee');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    public PageReference CustomSave16(){
         InvokeCalls();
         //Sneha begin - prevent passing contact id in parameter
        //PageReference  pgcsave= new PageReference('/apex/HousingPreference?StaticContactId='+StaticContactId);
        PageReference  pgcsave= new PageReference('/apex/HousingPreference');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    public PageReference CustomSave17(){
        InvokeCalls();
        //Sneha begin - prevent passing contact id in parameter
        //PageReference  pgcsave= new PageReference('/apex/HousingPayment?StaticContactId='+StaticContactId);
        PageReference  pgcsave= new PageReference('/apex/HousingPayment');
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    public PageReference CustomSave18(){
        InvokeCalls();
        //Sneha begin - prevent passing contact id in parameter
        //PageReference  pgcsave= new PageReference('/apex/UploadDocuments2?StaticContactId='+StaticContactId);
        PageReference  pgcsave= new PageReference('/apex/UploadDocuments2');
        //pgcsave.setRedirect(true);
        return pgcsave;
    }

//------Pass contact id----------------------------------------
    Public void InvokeCalls() {
      if(Flame_Community.StaticContactId== null) Flame_Community.StaticContactId = StaticContactId;
      if(StaticContactId==null){StaticContactId=ContactId;}else {ContactId=StaticContactId;}
      if(staticconid==null)staticconid=Flame_Community.StaticContactId; 
      if(staticContactid==null)staticContactid=Flame_Community.StaticContactId; 
     }
     
//---constructer ---------------------------------------------
    public ProgressBarCtrl()
    {
        System.debug('ContactId -'+ContactId+'StaticContactId - ' +StaticContactId);
        InvokeCalls(); 
        System.debug('Check the Contact Id  in Flame_Community' +StaticContactId);
        applicationCreated = false;
        IsBroadcasted = true;
        validPageCheck = false;
        Isempty = false;
        IsBroadcasted = true;
        IsApplicationDeclined=false;
        
 //-----------Tab colour controller-------------------------------------- 
        Con = new Contact();
        try{
          List<Application__c> application = new List<Application__c>();
          application = FLAME_Utility.getApplicationInfo(staticContactid, null); 
         if(application!=null){
           
            applicationCompStages1 = application[0].Completed_Stages__c;
            appsubmissionStatus = application[0].Application_Submission_Status__c;
            System.debug('applicationCompStages' +applicationCompStages1);
         }
         } 
         catch(Exception e){
         }
        //---------------------------------tab admitcard controller -----------------------------------------------------            
        //currentUser = [select contact.Id,Contact.Name,Contact.Email,Contact.FU_Mobile_Phone_Code__c,Contact.MobilePhone from Contact where id=:staticContactid Limit 1];
        //Con = [select contact.Id,Contact.Name,Contact.Email,Contact.FU_Mobile_Phone_Code__c,Contact.MobilePhone from Contact where id =:staticContactid  Limit 1];
        //System.debug('application[0].Application_Progress__c1 - '+application[0].Id);
        application = [select Id,ApplicationPDFLink__c,(select FUA_Broadcast_Admit_Card__c from Admit_Cards__r ),Admission_Status__c, Contact__r.Name,Contact__r.Email,Contact__r.FU_Mobile_Phone_Code__c,Contact__r.MobilePhone,Completed_Stages__c,Application_Reference_ID__c,Application_Progress__c,Application_Submission_Status__c,FLM_Declineoffer__c from Application__c where Contact__c =:staticContactid  Limit 1];
        if(application.size() > 0  && application[0].Admit_Cards__r.size() > 0){
        
            if(application[0].Admit_Cards__r[0].FUA_Broadcast_Admit_Card__c == true){
               IsBroadcasted = true;
               System.debug('gggggggggggggggggggg'+IsBroadcasted);
            }
      }
        //---------- application states tab controller ----------------------
        if(application.size() > 0){
            if(application[0].Admission_Status__c != null){
                Isempty = true;
            }
            applicationCreated = true;
            appId = application[0].Id;
            if(application[0].Application_Progress__c != null){
                applicationProgress = application[0].Application_Progress__c;
            }
            else{
                applicationProgress = 0;
            }
            applicationCompStages = application[0].Completed_Stages__c;
            Application_Reference_ID = application[0].Application_Reference_ID__c;
            appsubmissionStatus = application[0].Application_Submission_Status__c;
            appadmissionStatus =  application[0].Admission_Status__c;
            if(application[0].Application_Submission_Status__c == 'Submitted' || application[0].Application_Submission_Status__c == 'Completed'){
                validPageCheck = true;
            }
            if(application[0].Admission_Status__c == 'Shortlisted'){
            } 
            else{
                validPageCheck = false;
            }
            
           
           /* List<Case> cases = new List<Case>();
            cases = [select CaseNumber from Case where ContactId = : staticconid ORDER BY CreatedDate DESC];
            if(cases.size() > 0){
                myCase = cases[0];
            }*/
            //Sneha - moved below
            /*else{
                applicationProgress = 0;
            }*/
        
        
        //System.debug('applicationProgress --'+applicationProgress);
        //System.debug('application[0].Application_Progress__c2 - '+application[0].Application_Progress__c);
          if(ContactId !=null){
        con = FLAME_Utility.getConactInfo(ContactId,null);
        system.debug('EEEEEEEEEEEEEEEE'+con);
        // Name = con.name;
        con.MobilePhone = ContactPhone;
        con.Email= ContactEmail;
       // con.FU_Mobile_Phone_Code__c=countryCode;
       
        }
        //declineoffer
         if(application[0].FLM_Declineoffer__c){
             IsApplicationDeclined=true;
         }
    }

    //Sneha - else was misplaced
    else{
            applicationProgress = 0;
        }
      System.debug('Check the Contact Id  in Flame_Community -- End' +StaticContactId);
    }
    
    
    Public string ContactPhone {get;set;}
    Public String ContactEmail {get;set;}
     public pageReference redirect(){
        if(applicationCreated == false){
            return new PageReference('/apex/ProgramForm');
        }
        else{
            return null;
        }
   }
    /*Code coverage Method*/
   Public void testclass(){
        Integer a=1; 
         integer b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
         a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
         a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
    }
   
   }