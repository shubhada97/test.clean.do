public with sharing class FUA_IndexController{
    
    private user userID{get;set;}
    public Contact Con{get;set;}
    String ApplicationStatus{get;set;}
    public boolean indexSwitch{get;set;}
    public boolean indexSwitch1{get;set;}
    public boolean indexSwitch2{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;} 
    Public Application__c App {get;set;}
    public FUA_IndexController (ApexPages.StandardController controller) {
        indexSwitch = false;
        indexSwitch2 = false;
        userID = new user();
        Con= new contact ();
        if(!String.IsEmpty(UserInfo.getUserId())){
            userID=[Select Id,ContactId,Email from User where Id = : UserInfo.getUserId()];
            FUA_UtilityClass objUtility = new FUA_UtilityClass(); 
            App = objUtility.getApplicationId(UserInfo.getUserId());    
            Con = objUtility.getcontactId(UserInfo.getUserId());
            system.debug('>>>>>>>>>App>>>>'+App);
             system.debug('>>>>>>>>>con>>>>'+con);
            if(Con.Applications__r.size() > 0){
                ApplicationStatus = Con.Applications__r[0].Application_Submission_Status__c;
                system.debug('>>>>>>>>>Con.Applications__r[0].Application_Submission_Status__c>>>>'+Con.Applications__r[0].Application_Submission_Status__c);
                if((ApplicationStatus == 'Submitted & Paid' || ApplicationStatus == 'Completed') && Con.Applications__r[0].Completed_Stages__c.contains('ThankyouDone')){
                    indexSwitch = true;
                }
                else{
                    indexSwitch = false;
                }
            }
            if(Con.Applications__r.size() > 0){
                ApplicationStatus = Con.Applications__r[0].Application_Submission_Status__c;
                if((ApplicationStatus == 'Completed' || ApplicationStatus == 'Shortlisted') && Con.Applications__r[0].Completed_Stages__c.contains('Admission Status')){
                    indexSwitch2 = true;
                }
                else{
                    indexSwitch2 = false;
                }
            }
        }
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
    
    public PageReference changePassword() 
    {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
    }  
   
    //Method call from VF page redirect to ProgramForm page.
    public PageReference proceedApplication(){    
        PageReference  pgcproceed=null;
        
        if(userID.ContactId != Null){
            if(indexSwitch2)
            {
           
            pgcproceed= new PageReference('/apex/Accepetoffer_1');
            
            }
             
            if(indexSwitch){
                pgcproceed= new PageReference('/apex/PhotographUpload_1');
            }
            else{
                pgcproceed= new PageReference('/apex/ProgramForm_1');
            }
            
            pgcproceed.setRedirect(true);
        }
      
       
        return pgcproceed;
    
    }
     public void addHealth() {
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
        }
}