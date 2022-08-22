public class FUA_StatementOfPurpose_Controller {
    public user userID{get;set;}
    public Contact Con{get;set;}
    public Application__c apps{get;set;}
    public string StatementofPurpose{get;set;}
    public String SaveExit{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    
    ApexPages.StandardController stdController;
   
    public FUA_StatementOfPurpose_Controller(){
        findcontactController();
        
    }
   
    public void findcontactController()
    {
        try{
            if(!String.IsEmpty(UserInfo.getUserId())){
                userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
                Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
                apps = [select id,Application_Reference_ID__c,ApplicationPDFLink__c,Completed_Stages__c,FUA_SOP_Submitted__c,Statement_of_Purpose__c,contact__c from Application__c WHERE contact__c =: userID.ContactID]; 
                apps.Statement_of_Purpose__c=  apps.Statement_of_Purpose__c;                               
            }
        }
        catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Id Missing. '+e.getMessage()));
        }       
    }
    
    public PageReference Next(){
        try{
            CreateApplicationPDFAttachmnet_1.CreateApplicationPDF(apps);
            EmailUtility.sendSOPDoc(String.valueOf(apps.Id),Con.Email,'FLAME University Admissions', apps.Application_Reference_ID__c+' PDF Copy of your FLAME University Application', apps.Application_Reference_ID__c+'.pdf');
            PageReference NextPage = new PageReference('/apex/ApplicationFormPDF_1');
            NextPage.setRedirect(true);
            return NextPage;
        }
        catch(Exception e){return null;}
    }
    
    public PageReference SaveExit()
    {
        IF(apps.id != NULL && apps.FUA_SOP_Submitted__c == FALSE)
        {
            apps.Statement_of_Purpose__c=apps.Statement_of_Purpose__c; 
            /*if(apps.FUA_SOP_Submitted__c == TRUE)
            {
                apps.FUA_SOP_Submitted__c = TRUE;
            }
            else
            {
                apps.FUA_SOP_Submitted__c = FALSE;
            }*/
        }
        update apps;
        
        PageReference SaveExitPage = new PageReference('/secur/logout.jsp');
        SaveExitPage.setRedirect(true);
        return SaveExitPage;
    }
    
    public void SaveData()
    {    
      try{
       // stdController.save();
     //  CreateApplicationPDFAttachmnet_1.CreateApplicationPDF(apps);
       PageReference pgcproceed=null;
       system.debug('SaveExit>>'+SaveExit);
        if(apps.id!=NULL)
        {
            apps.Statement_of_Purpose__c=apps.Statement_of_Purpose__c; 
            apps.FUA_SOP_Submitted__c = TRUE;
            
            String completedStages = apps.Completed_Stages__c;
            String currentPageName = 'Admit Card';
            if(completedStages != null){
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
                    apps.Completed_Stages__c = completedStages+';Application PDF;SOP';
                }
            }
            else{
                apps.Completed_Stages__c = currentPageName+';Application PDF;SOP';
            }
            apps.Application_Submission_Status__c = 'Completed';
            apps.Admission_Status__c = 'Completed';
            update apps;
            
            Contact c = [Select ID,Registration_Status__c from contact where id = :UserID.ContactID];
            c.Registration_Status__c = 'Completed';
            update c;
        }
    }
    catch(Exception e){}
 }
 public void saveAll()
    { 
     
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
                    apps.Completed_Stages__c = completedStages+';Application PDF;SOP';
                }
            }
            else{
                apps.Completed_Stages__c = currentPageName+';Application PDF;SOP';
                
            }
            apps.Application_Submission_Status__c = 'Completed';
            apps.Admission_Status__c = 'Completed';
            apps.Admission_Status__c = 'Completed';
            update apps;
           Contact c = [Select ID,Registration_Status__c from contact where id = :UserID.ContactID];
            c.Registration_Status__c = 'Completed';
            update c;
            }
        
    }
}