Public Class FUL_HousingPreferencecontroller{
    public Contact Con{get;set;}
    public user userID{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public Application__c app{get;set;}
    Public string selA{get;set;}
    Public string selB{get;set;}
    Public string selC{get;set;}
    Public string selD{get;set;}
    Public string selE{get;set;} 

Public FUL_HousingPreferencecontroller(){

 userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
       FUA_UtilityClass objUtility = new FUA_UtilityClass();
       App = objUtility.getApplicationId(UserInfo.getUserId());    

}

        public PageReference Savedatainhousingpreference() {
        
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
        app.Admission_Status__c ='Fees Paid';
        update app;
        
        String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();

        String url = baseUrl+'/apex/HousingPayment_1';
        pageReference pg = new PageReference('/apex/HousingPayment_1');
       
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
        app.Admission_Status__c ='Fees Paid';
        update app;
        
        PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
        SaveExit.setRedirect(true);
        return SaveExit;
    } 
   
}