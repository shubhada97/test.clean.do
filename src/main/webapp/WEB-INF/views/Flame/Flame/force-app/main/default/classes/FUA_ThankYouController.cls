public class FUA_ThankYouController {   
    
    public String appreferenceNumber{get;set;}
    public user userID{get;set;}
    public Contact Con{get;set;}
    List<Application__c> application;
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    Public Application__c userApp {get;set;}
    public FUA_thankyouController(){
        String contId =[select ContactId from User where Id = :UserInfo.getUserId()].ContactId;
        userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
        application = [select Id,Application_Reference_ID__c,Completed_Stages__c,Application_Submission_Status__c from Application__c where Contact__c =: contId];
        if(application.size() > 0){
            appreferenceNumber = application[0].Application_Reference_ID__c;
        }
         FUA_UtilityClass objUtility = new FUA_UtilityClass();
         userApp = objUtility.getApplicationId(UserInfo.getUserId());
    }
    
    public PageReference uploadPhoto(){
        if(application.size() > 0){
            //application[0].Application_Submission_Status__c = 'Submitted';
            application[0].Completed_Stages__c += ';ThankyouDone';
            update application;
            return new PageReference('/apex/PhotographUpload_1');
        }
        else{
            return null;
        }
    }
    
    public pageReference redirect(){
        if(application.size() == 0){
            return new PageReference('/apex/Index');
        }
        else{
            return null;
        }
        
    }
}