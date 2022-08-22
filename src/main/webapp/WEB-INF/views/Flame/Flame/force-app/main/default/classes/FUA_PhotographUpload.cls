public without sharing class FUA_PhotographUpload {

    public User UserID{get;set;}
    public Application__c apps{get;set;}
    public contact Con{get;set;}
    public ID community{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    Public String AppId {get;set;}
    public blob Photo{get;set;}
    public transient  String imageBase64{get;set;}

    
    public FUA_PhotographUpload(){
      UserID=[Select Id,name,fullphotourl,ContactId from User where Id = :UserInfo.getUserId()];
      apps =[Select id,name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.name,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c from Application__c WHERE Contact__c =: UserID.ContactID LIMIT 1]; 
      system.debug('applicationList.Id>>>>>>>>>>>>>>>>>>>>>>>>'+apps.Id);
      imageBase64 = '';
    }
    
   public PageReference saveImage(){      
    PageReference  pgcproceed=null;
       
        try
        {  
            Application__c a=[select FUA_Applicant_Image_URL__c from Application__c where id=:apps.id];
            if(a.FUA_Applicant_Image_URL__c!=null)
            {
            Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'Required fields are missing. ')); //FATAL, WARNING, INFO, CONFIRM
            
            if(apps.id != null)
            {     
           system.debug('>>>>>>>>>>>>>>apps.id>>>>>>>>'+apps.id);
            String completedStages = apps.Completed_Stages__c;
            String currentPageName = 'Photograph Upload';
            
            if(completedStages != null){
            if(!completedStages.contains(currentPageName))
            {
            completedStages += ';' + currentPageName;
            apps.Completed_Stages__c = completedStages;
            }
            }
            else{
            apps.Completed_Stages__c = currentPageName;
            }
            
            update apps;
            
            }
                
            pgcproceed= new PageReference('/apex/StatementOfPurpose_1');
                   
            } 
            else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'Please Upload Photo.');
            ApexPages.addMessage(myMsg); 
            return pgcproceed;
            } 
            return pgcproceed;
        }catch(exception e){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Upload Photo'));
            return null;
        }
         
    }
   
    
}