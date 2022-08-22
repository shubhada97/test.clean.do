Public Class FUA_AccepetOffercontroller{
    public user userID{get;set;}
    public Contact Con{get;set;}
    public Application__c app{get;set;}
    public String SaveExit{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    String id;
    ApexPages.StandardController stdController;
    
 //constructer
    
 Public FUA_AccepetOffercontroller(){
 
 findcontactController();
 }
 
 public void findcontactController()
    {
        try{
            if(!String.IsEmpty(UserInfo.getUserId())){
                userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
                Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
                List<Application__c> apps = new List<Application__c>();
                apps = [select id,Application_Reference_ID__c,Program__r.Name,Completed_Stages__c,FLM_Declineoffer__c,FLM_Accepetoffer__c,contact__c from Application__c WHERE contact__c =: userID.ContactID]; 
                if(apps.size() > 0){
                App = apps[0];
                Id = App.Id;
                                             
            }
        }
        }
        catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Id Missing. '+e.getMessage()));
        }       
    }
    
  Public PageReference yesaction() {
    
        try{

            IF( App.id != NULL){
                App.FLM_Declineoffer__c =true;
                update  App;
            }
          
            PageReference nextPage = new PageReference('/apex/Accepetoffer_1');
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
    
     public PageReference AcceptData() {
      
        if(App.id != Null){
        App.FLM_Accepetoffer__c =true;
        String completedStages = App.Completed_Stages__c;
        String currentPageName = 'Accepetoffer';
        if(completedStages != null){
        if(!completedStages.contains(currentPageName)){
        completedStages += ';' + currentPageName;
        App.Completed_Stages__c = completedStages;
        }
        }
        }else {
        App.Completed_Stages__c = 'currentPageName';
        }
        update App; 
   try{
        pageReference rd =new pageReference('/apex/EnrollMentFee_1');
       // rd.getParameters().put('ContactId',userID.ContactId);
        System.debug('>>>>>>>>>>>>>>>>>nextPage'+rd);
        rd.setRedirect(true);
       return rd;
    }
    catch(Exception e){
        return null;
        }
    } 
    public void DAOffer() {}   
 
    
}