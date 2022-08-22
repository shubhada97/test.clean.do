public with sharing class FUA_EducationAndWorkController
{
    public List<FU_Education_Details__c> EdDetList{get;set;}
    public List<FUA_Work_Details__c> Wrkdetls{get;set;}
    public Application__c App{get;set;}
    public List<SelectOption> options{get;set;}
    public String selectedOption{get;set;}
    ApexPages.StandardController stdController;
    public boolean showAddDeleteButtons{get;set;}
    String id;
    public FU_Education_Details__c educationObj{get;set;}
    public List<SelectOption> option{get;set;}
  
    public user userID{get;set;}
    public string selectedYr{get;set;}
    public integer CountAdd{get;set;}
      
    List<FUA_Work_Details__c> finalDeleteList = new List<FUA_Work_Details__c>();
    
    //Construcor
    public FUA_EducationAndWorkController() {
        CountAdd = 1;
        showAddDeleteButtons = false;
        EdDetList = new List<FU_Education_Details__c>();
        Wrkdetls = new List<FUA_Work_Details__c>();
        App = new Application__c();
        userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        String contactId = [select ContactId from User where id = :UserInfo.getUserId()].ContactId;
       if(contactId != null){
           // Fetching the Education details and work details for logged in user
            EdDetList = [select Id,name,FU_Year_Class__c,FUA_Other_City__c,FUA_Institution_School__c,FUA_Degree_Certificate__c,FUA_Major_Subjects__c,FUA_Board_University__c,FUA_Year_of_Completion__c,FUA_CGPA_Actual__c,FUA_CGPA_Out_Of__c,FUA_Education_Country__c,FUA_Education_State__c,FUA_Education_City__c,FUA_Other_State__c from FU_Education_Details__c where Application__r.Contact__c =:contactId ORDER BY Display_Sequence__c]; 
            Wrkdetls = [Select Id , Name ,FromDate__c,Todate__c,FUA_Work_City__c , FUA_Company__c,FUA_Work_Country__c, FUA_CTC_INR__c, FUA_Designation__c  ,FUA_Function__c ,FUA_Reporting_Person_Details__c, FUA_Work_State__c,FUA_Other_City1__c, FUA_Type__c, FUA_Your_Responsibilities__c from FUA_Work_Details__c where Application__r.Contact__c=:contactId];
             system.debug('Wrkdetls>>>>>>>>>>>>'+Wrkdetls);
            // Rendering the ADD/Remove buttons
            
            if(Wrkdetls.size() > 0){
                showAddDeleteButtons = true;
                CountAdd = Wrkdetls.size();
            }
            
            List<Application__c> apps = new List<Application__c>();
            apps = [select Id , Completed_Stages__c,Name , Achievments__c ,Program__c,Program__r.Dependent_Years__c,Program__r.Name,Program__r.Program_Type__c, Other_Details__c from Application__c where Contact__c =:contactId];
            if(apps.size() > 0){
                App = apps[0];
                Id = App.Id;
             system.debug('App.Program__r.Name>>>>>>'+App.Program__r.Name);   
            }
            educationObj = new FU_Education_Details__c(Application__c = Id,FUA_Education_Country__c='India');
      
            
            option = new List<SelectOption>();
            options = new List<SelectOption>();
            options.add(new SelectOption('Yes','Yes'));
            options.add(new SelectOption('No','No'));
          
                    // Setting the picklist values based on the program selected
                    
                        if(App.Program__r.Program_Type__c == 'Undergraduate' || App.Program__r.Program_Type__c == 'Other UG' )
                        {
                         option.add(new SelectOption('', '--Select Education--'));
                         option.add(new SelectOption('10/Xth', '10/Xth'));
                         option.add(new SelectOption('11/XIth', '11/XIth'));
                         option.add(new SelectOption('12/XIIth', '12/XIIth'));
                        }
                        
                        else
                        {
                         option.add(new SelectOption('', '--Select Education--'));
                         option.add(new SelectOption('10/Xth', '10/Xth'));
                         option.add(new SelectOption('11/XIth', '11/XIth'));
                         option.add(new SelectOption('12/XIIth', '12/XIIth'));
                         option.add(new SelectOption('Bachelors / Undergraduate', 'Bachelors / Undergraduate'));
                         option.add(new SelectOption('Masters / Postgraduate', 'Masters / Postgraduate'));
                         options.add(new SelectOption('Other', 'Other'));
                         }
                  
                        
       }
    }
    // Adding a workdetail section
    public void AddSection(){
        CountAdd = CountAdd +1;
        Wrkdetls.add(new FUA_Work_Details__c(Application__c=id,FUA_Work_Country__c ='India'));
        showAddDeleteButtons = true;
        
    }
    
  
    // Removing a Workdetail section
    Public void DeleteRow()
    {
        CountAdd =CountAdd-1;
        Integer i = Wrkdetls.size();
        system.debug('Size -> ' + i);
        if(Wrkdetls.get(i-1).Id != null){
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
        Wrkdetls = [Select Id from FUA_Work_Details__c where Application__c = :Id];
        if(Wrkdetls.size() > 0){
            for(integer i =0 ; i<Wrkdetls.size() ; i++){
                finalDeleteList.add(Wrkdetls.get(i));
             }
             Wrkdetls.clear();
        }
        showAddDeleteButtons = false;
        Wrkdetls.clear();
    }
   
    // Saving the data and moving to next page
     
    public PageReference Savedata(){
        try{        
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
                if(!completedStages.contains(currentPageName)){
                    completedStages += ';' + currentPageName;
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
           return new PageReference('/apex/ReviewAndApply_1');
        }
        catch(Exception e){
            system.debug('EEEEEEEEEE'+ e);
            return null;
        }
    }
    // Saving the data and logging out
        public PageReference SaveExit(){
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
        EdDetList.add(educationObj); 
        educationObj = new FU_Education_Details__c(Application__c = Id,FUA_Education_Country__c='India');
        upsert EdDetList;
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
            educationObj = new FU_Education_Details__c(FU_Year_Class__c = year,Application__c = Id,FUA_Education_Country__c='India');
            system.debug('educationObj -> ' + educationObj);
        }
    }
    
 //   Removing the particular education detail from the list
    public void deleteEducationData(){
        String year = ApexPages.currentPage().getParameters().get('selectedYear');
        selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
        system.debug('year -> ' + year);
        
        for(integer i = 0 ; i < EdDetList.size() ; i++){
            if(EdDetList[i].FU_Year_Class__c == year){
                educationObj = new FU_Education_Details__c(Application__c = Id,FUA_Education_Country__c='India');
                if(EdDetList[i].Id!= null){
                    delete EdDetList[i];
                }
                EdDetList.remove(i);
            }
        }
    }
    // To Edit the particular education detail data
     public void editEducationData(){
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
        //Saving the edited education detail data
    public void UpdateEducationList(){
        try{
        String year = ApexPages.currentPage().getParameters().get('selectedYear');
        selectedYr = ApexPages.currentPage().getParameters().get('selectedYr');
        system.debug('year -> ' + year);
        
        for(integer i = 0 ; i < EdDetList.size() ; i++){
            if(educationObj.FU_Year_Class__c == year){
                     EdDetList[i] = educationObj ;
                     EdDetList[i].FU_Year_Class__c = educationObj.FU_Year_Class__c;
                    
                  
            }
            
        }
        String jsonString = JSON.serialize(EdDetList);
        system.debug('@@@@@@@@@@@'+jsonString);
        upsert EdDetList;
        educationObj = new FU_Education_Details__c(Application__c = Id,FUA_Education_Country__c='India');
        }
        catch(Exception e){}
    }
    // To cancel the editting process for a particular education detail
    public void cancelEdu()
    {
        educationObj = new FU_Education_Details__c(Application__c = Id,FUA_Education_Country__c='India');
    }
    // Navigating the user to Index page if no application is created and is directly come on this page
     public pageReference redirect(){
        if(Id == null){
            return new PageReference('/apex/Index');
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
}