public class ProgressBarCtrl_1 {
 public id reportid {get;set;}
     public String URL { get; set; }
    public Decimal applicationProgress{get;set;}
    public String applicationCompStages{get;set;}
    public String appId{get;set;}
    public String appsubmissionStatus{get;set;}
    public String applicationCompStages1{get;set;}
    public User currentUser{get;set;}
    public String Application_Reference_ID{get;set;}
    public List<Application__c> application{get;set;}
    public boolean validPageCheck{get;set;}
    
    public String name{get;set;}
    public String phone{get;set;}
    public String email{get;set;}
    public String countryCode{get;set;}
    public boolean applicationCreated{get;set;}
    public Contact Con{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    
    public boolean IsBroadcasted{get;set;}
    public boolean Isempty{get;set;}
   
    public static boolean IsApplicationDeclined{get;set;}
    public ProgressBarCtrl_1(){
     IsApplicationDeclined=false;
        applicationCreated = false;
        IsBroadcasted = false;
        validPageCheck = false;
        Isempty = false;
        currentUser = [select ContactId,Contact.Name,Contact.Email,Contact.FU_Mobile_Phone_Code__c,Contact.MobilePhone from User where Id = :UserInfo.getUserId()];
        //Con = [Select ID,Email From Contact Where ID =: currentUser.ContactId];
       
        application = [select Id,ApplicationPDFLink__c,(select FUA_Broadcast_Admit_Card__c from Admit_Cards__r ),Admission_Status__c, Contact__r.Name,Contact__r.Email,Contact__r.FU_Mobile_Phone_Code__c,Contact__r.MobilePhone,Completed_Stages__c,Application_Reference_ID__c,Application_Progress__c,Application_Submission_Status__c,FLM_Declineoffer__c from Application__c where Contact__c =: currentUser.ContactId];
         try{
          List<Application__c> application = new List<Application__c>();
          if(application!=null){
           
            applicationCompStages1 = application[0].Completed_Stages__c;
            appsubmissionStatus = application[0].Application_Submission_Status__c;
            System.debug('applicationCompStages' +applicationCompStages1);
         }
         } 
         catch(Exception e){
         }
        
        if(application.size() > 0  && application[0].Admit_Cards__r.size() > 0){
            if(application[0].Admit_Cards__r[0].FUA_Broadcast_Admit_Card__c == true){
                IsBroadcasted = true;
            }
        }
        
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
            applicationCompStages1 = application[0].Completed_Stages__c;
            Application_Reference_ID = application[0].Application_Reference_ID__c;
            appsubmissionStatus = application[0].Application_Submission_Status__c;
            if(application[0].Application_Submission_Status__c == 'Submitted' || application[0].Application_Submission_Status__c == 'Completed'){
                validPageCheck = true;
            }
            else{
                validPageCheck = false;
            }
            
            
           //declineoffer
           if(application[0].FLM_Declineoffer__c){
             IsApplicationDeclined=true;
         } 
        }
        else{
            applicationProgress = 0;
        }
        
        name = currentUser.Contact.Name;
        phone = currentUser.Contact.MobilePhone;
        email = currentUser.Contact.Email;
        countryCode = currentUser.Contact.FU_Mobile_Phone_Code__c;
    }
      
    public pageReference redirect(){
        if(applicationCreated == false){
            return new PageReference('/apex/ProgramForm_1');
        }
        else{
            return null;
        }
    }
    
    public pageReference ApplicationPDFNext(){
            return new PageReference('/apex/AdmitPage_1');
    }
    public pageReference changepassword(){
            return new PageReference('/apex/ChangePasswordCustom_1');
    }
    
   
    
    public Pagereference DownloadApplicationPDF(){
        try{
            CreateApplicationPDFAttachmnet_1.CreateApplicationPDF(application[0]);
            application = [select Id,ApplicationPDFLink__c,(select FUA_Broadcast_Admit_Card__c from Admit_Cards__r ),Admission_Status__c, Contact__r.Name,Contact__r.Email,Contact__r.FU_Mobile_Phone_Code__c,Contact__r.MobilePhone,Completed_Stages__c,Application_Reference_ID__c,Application_Progress__c,Application_Submission_Status__c from Application__c where Contact__c =: currentUser.ContactId];
            return new PageReference(application[0].ApplicationPDFLink__c);
        }
        catch(Exception e){
            system.debug('Exception : ' + e.getMessage());
            return null;
        }
    }
    
   public void saveAllD(){
        ApplicationPDFNext();
      }
    
}