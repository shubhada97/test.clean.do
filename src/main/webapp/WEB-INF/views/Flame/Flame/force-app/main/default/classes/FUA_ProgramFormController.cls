public  class FUA_ProgramFormController 
{
    public Competition_Exam_Details__c comp{get;set;} 
    public Application__c applicationobj {get;set;}
    public String program {get;set;}
    public String round {get;set;}
    public String center {get;set;}
    public String choices { get; set;}
    //public Boolean compExam{get;set;}
    public Boolean compExam{get;set;}
    private list<GD_and_PI_Round__c> lstofRounds{get;set;}
    private list<Program__c> lstofPrograms{get;set;}
    //public List<SelectOption> examComp{get;set;}
    public List<SelectOption> CompetitionExamListFromDatabase{get;set;}
    public List<Competition_Exam_Details__c> lstOfCompetitionExams{get;set;}
    List<Competition_Exam_Details__c> lstOfCompetitionExams1{get;set;}
    
    public user userID{get;set;}
    public string selectedExam{get;set;}
    public Contact Con{get;set;}
    public Contact findContact{get;set;}
    public List<SelectOption> lstRound{get;set;}
    public List<SelectOption> lstCenters{get;set;}
    public Competition_Exam_Details__c CED{get;set;}
    public Competition_Exam_Details__c CED1{get;set;}
    public List<Application__c> extApplication{get;set;}
    public Application__c app{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public String ProgramType {get; set;}
    public String ProgramCode {get;set;}
    ApexPages.StandardController stdController;
    public FUA_ProgramFormController() 
    {
        
       // stdController = Con;
        lstofRounds = new list<GD_and_PI_Round__c>();
        lstofPrograms = new list<Program__c>();
        applicationobj = new Application__c();
        lstOfCompetitionExams = new List<Competition_Exam_Details__c>();
        lstOfCompetitionExams1 = new List<Competition_Exam_Details__c>();
        CompetitionExamListFromDatabase = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Competition_Exam_Details__c.Competitive_Exams__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
          CompetitionExamListFromDatabase.add(new SelectOption(f.getLabel(), f.getValue()));
        }   
        extApplication = new List<Application__c>();
        CED = new Competition_Exam_Details__c();
        CED1 = new Competition_Exam_Details__c();
        findcontactController();
     
        userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
                  FUA_UtilityClass objUtility = new FUA_UtilityClass(); 
                  App = objUtility.getApplicationId(UserInfo.getUserId()); 
                  con = objUtility.getcontactId(UserInfo.getUserId());
                  program = con.Program_Interested_In__c;
        
        if(String.IsEmpty(round))
        {
            round = 'Select Admission Cycle';
        }
        else
        {
            round = app.GD_and_PI_Round__c;
        }
        if(String.IsEmpty(center))
        {
            center = 'Select Center';
        }
        else
        {
            center = app.GD_and_PI_Center__c;
        }
        FindRounds();
        FindCenters();
    }
        
    public void findcontactController()
    {
            applicationobj         = new Application__c();
            applicationobj.Do_you_need_on_campus_accommodation__c='No';
        try
        {
            if(!String.IsEmpty(UserInfo.getUserId()))
            {
               
                  userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
                  FUA_UtilityClass objUtility = new FUA_UtilityClass(); 
                  App = objUtility.getApplicationId(UserInfo.getUserId()); 
                  con = objUtility.getcontactId(UserInfo.getUserId()); 
                  Program__c prog = [Select ID,Name From Program__c Where ID =: app.Program__c];
                
                
                if(app.ID != Null)
                {  
                    if(app.Old_SAT_Structure__c == True || app.SAT_Score__c == true )
                    {
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        CED = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Application__c,Result_Awaited__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'SAT'];
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
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
                        //lstOfCompetitionExams1 = lstOfCompetitionExams;
                        program = prog.Name;
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        
                        FindRounds();
                        FindCenters();
                        //applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                    }
                }
                else
                {
                    center = 'Select Center';
                    round = 'Select Admission Cycle';
                    FindRounds();
                    FindCenters();
                }
                FindRounds();
                FindCenters();
            }
        }
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            
        }
       
    }
    
    //////// Method to clear the previous program list and republish data after reselecting the program in database ////////
    
    public void clearList()
    {    
         /*try
         {   */
               if(app != Null && program == app.Program__r.name) 
                {  
                    //lstOfCompetitionExams.clear();
                    if(app.Old_SAT_Structure__c == True ||app.SAT_Score__c == true )
                    {
                        lstOfCompetitionExams.clear();
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        List<Competition_Exam_Details__c> temp = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Application__c,Result_Awaited__c From Competition_Exam_Details__c 
                                    Where Application__c =: app.ID AND RecordType.Name = 'SAT'];
                                    
                        if(temp.size() > 0){
                            CED = temp[0];
                        }
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                        
                    }
                    else if(app.FLAME_Entrance_Aptitude_Test_FEAT__c == true && app.SAT_Score__c == false)
                    {
                        lstOfCompetitionExams.clear();
                        round = app.GD_and_PI_Round__c;
                        center = app.GD_and_PI_Center__c;
                        applicationobj.SAT_Score__c = app.SAT_Score__c;
                        applicationobj.Old_SAT_Structure__c = app.Old_SAT_Structure__c;
                        applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c = app.FLAME_Entrance_Aptitude_Test_FEAT__c;
                        applicationobj.Do_you_need_on_campus_accommodation__c = app.Do_you_need_on_campus_accommodation__c;
                        FindRounds();
                        FindCenters();
                    }
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
                    lstOfCompetitionExams = [Select ID,Name,Competitive_Exams__c,FUA_Percentile__c,Registration_No__c,Score__c,Result_Awaited__c
                                                        From Competition_Exam_Details__c Where Application__c =: app.ID];
                    round = app.GD_and_PI_Round__c;
                    center = app.GD_and_PI_Center__c;
                    }
                }
                else 
                {
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
         /*}
         catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Application Id Missing. '+e.getMessage()));
        }*/
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
    
    //////// Method to find GDPI rounds for the selected program dynamically ////////
    
    public void FindRounds()
    {
        try
        {
            lstRound= new List<SelectOption>();
            if(!string.isBlank(program))
            {
                System.debug('selected program '+program);
                Program__c pro = [Select ID,Program_Code__c,Program_Type__c From Program__c Where Active__c=True AND Name=:program ];
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
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'No GDPI Rounds found. '+e.getMessage()));
        }
    } 
    
    //////// Method to find relevant GDPI centers for the above rounds dynamically ////////
    
    public void FindCenters()
    {
        try
        {
            lstCenters = new List<SelectOption>();
            System.debug('selected round - in find centers method - '+round);
            if(!String.isBlank(round))       
            {
                Program__c pro = [Select ID From Program__c Where Active__c=True AND Name=:program];
                List<GD_and_PI_Round__c> lstofCenters = [Select ID,Name,GD_and_PI_Center__c From GD_and_PI_Round__c Where Active__c = True AND Name = :round AND Program__c =: pro.ID limit 1 ];
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
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'No GDPI centers available. '+e.getMessage()));
        }
    }     
    
    public PageReference CustomSave() 
    {   
        system.debug('****program  ' + program);
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program AND Active__c =:TRUE LIMIT 1];
        
        system.debug('****SelectedProgram  ' + SelectedProgram);
        
        //Program__c SelectedProgram = [Select ID,Name From Program__c Where Name = 'Postgraduate (MBA)'];
        //system.debug('Selected Program >>>>>>>>>>>>>' +SelectedProgram);
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :userID.ContactId Limit 1];
       
        System.debug('extApplication==>'+extApplication);
        
        PageReference  pgcsave=null;
        
        //////// If no application found, then insert the new application along with competition exam records ////////
        
        if(extApplication.isempty())
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
           
            System.debug('GDPIroundID==>'+GDPIroundID);
            
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= userID.ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c;
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;  
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Admission_Status__c = 'In Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            insert applicationobj1;
            System.debug('applicationobj1 ->'+applicationobj1);
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
            //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
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
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
            pgcsave= new PageReference('/apex/PersonalDetails_1');
            pgcsave.setRedirect(true);
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
            updateApplication.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
            updateApplication.ACT_Score__c = applicationobj.ACT_Score__c;
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
            system.debug('updateApplication>>>>>>>>>>>>>>>>'+updateApplication);
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            update c;
             system.debug('c>>>>>>>>>>2>>>>>>'+c);
 
            //////// Applicant selected program is not changed then perform update on application and upsert on competition exams ////////
            
            if(extApplication[0].Program__c == SelectedProgram.ID)
            {
             system.debug('SelectedProgram.Program_Type__c>>>>>>>>>>3>>>>>>'+SelectedProgram.Program_Type__c);
 
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
                        if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
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
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
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
                
                //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
                if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
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
        pgcsave= new PageReference('/apex/PersonalDetails_1');
        pgcsave.setRedirect(true);
        return pgcsave;
    }
    
    public PageReference CustomSaveExit() 
        {   
     /*   Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program AND Active__c =: TRUE LIMIT 1];
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :userID.ContactId Limit 1];
        PageReference  pgcsaveexit=null;
        
        //////// If no application found, then insert the new application along with competition exam records ////////
        
    /*    if(extApplication.isempty())
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= userID.ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c; 
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;  
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            insert applicationobj1;
            
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
            //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
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
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Program__c = SelectedProgram.Name;
                    SAT.RecordTypeID = RecordTypeId;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
            pgcsaveexit.setRedirect(true);
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
            updateApplication.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
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
            
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
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
                    if( updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> SATexam = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'SAT' Limit 1];
                        if(!SATexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(ID=SATexam[0].ID);
                            SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SAT.Math__c = CED.Math__c;
                            SAT.Writing__c = CED.Writing__c;
                            SAT.Critical_Reading__c = CED.Critical_Reading__c;
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.RecordTypeID = RecordTypeId;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.RecordTypeID = RecordTypeId;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
                            SATscore.SAT__c = TRUE;
                            Insert SATscore;
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> SAT = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'SAT'Limit 1];
                        delete SAT;
                    }
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
                
               // if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
               if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if( updateApplication.Old_SAT_Structure__c == True|| updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
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
        pgcsaveexit.setRedirect(true);
        return pgcsaveexit; */
         system.debug('****program  ' + program);
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program AND Active__c =:TRUE LIMIT 1];
        
        system.debug('****SelectedProgram  ' + SelectedProgram);
        
        //Program__c SelectedProgram = [Select ID,Name From Program__c Where Name = 'Postgraduate (MBA)'];
        //system.debug('Selected Program >>>>>>>>>>>>>' +SelectedProgram);
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :userID.ContactId Limit 1];
       
        System.debug('extApplication==>'+extApplication);
        
        PageReference  pgcsave=null;
        
        //////// If no application found, then insert the new application along with competition exam records ////////
        
        if(extApplication.isempty())
        {
            GD_and_PI_Round__c GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
           
            System.debug('GDPIroundID==>'+GDPIroundID);
            
            Application__c applicationobj1 = new Application__c();
            applicationobj1.GD_and_PI_Center__c = center;
            applicationobj1.GD_and_PI_Round__c = round;
            applicationobj1.FUI_GD_and_PI_Round__c = GDPIroundID.ID;
            applicationobj1.Contact__c= userID.ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c;
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;  
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Admission_Status__c = 'In Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            insert applicationobj1;
            System.debug('applicationobj1 ->'+applicationobj1);
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
            //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
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
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
                PageReference  pgcsaveexit=null;    
                pgcsaveexit= new PageReference('/secur/logout.jsp'); 
                pgcsaveexit.setRedirect(true);
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
            updateApplication.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
            updateApplication.ACT_Score__c = applicationobj.ACT_Score__c;
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
            system.debug('updateApplication>>>>>>>>>>>>>>>>'+updateApplication);
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            update c;
             system.debug('c>>>>>>>>>>2>>>>>>'+c);
 
            //////// Applicant selected program is not changed then perform update on application and upsert on competition exams ////////
            
            if(extApplication[0].Program__c == SelectedProgram.ID)
            {
             system.debug('SelectedProgram.Program_Type__c>>>>>>>>>>3>>>>>>'+SelectedProgram.Program_Type__c);
 
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
                        if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
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
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
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
                
                //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
                if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
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
        PageReference  pgcsaveexit=null;    
        pgcsaveexit= new PageReference('/secur/logout.jsp'); 
        pgcsaveexit.setRedirect(true);
        return pgcsaveexit;
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
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
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
    
    // Change made by <<Akhilesh>> at Techila <<>> on <<19-09-2016>>. <<To Call Method saveAllData from Action function>>        
           
    public PageReference saveAllData(){
        //CustomSaveExit();
        /*PageReference pgcsaveexit= new PageReference('/secur/logout.jsp'); 
        pgcsaveexit.setRedirect(true);
        return pgcsaveexit; */
        
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c Where Name =: program AND Active__c =: TRUE LIMIT 1];
        extApplication = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
                                            From Application__c Where Contact__c = :userID.ContactId Limit 1];
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
            applicationobj1.Contact__c= userID.ContactId;
            applicationobj1.Program__c= SelectedProgram.ID;
            applicationobj1.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            applicationobj1.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            applicationobj1.SAT_Score__c = applicationobj.SAT_Score__c;
            applicationobj1.ACT_Score__c = applicationobj.ACT_Score__c;  
            applicationobj1.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;  
            applicationobj1.Application_Submission_Status__c = 'In-Progress';
            applicationobj1.Admission_Status__c = 'In Progress';
            applicationobj1.Completed_Stages__c = 'Program & Test';
            insert applicationobj1;
            
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
            c.Program_Interested_In__c = SelectedProgram.Name;
            c.Registration_Status__c = 'In-Progress';
            update c;
            
            //if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
           if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
            {
                if( applicationobj1.Old_SAT_Structure__c == True|| applicationobj1.SAT_Score__c == True)
                {
                    Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                    Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                    SAT.Name = 'SAT Score';
                    SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                    SAT.Math__c = CED.Math__c;
                    SAT.Writing__c = CED.Writing__c;
                    SAT.Critical_Reading__c = CED.Critical_Reading__c;
                    SAT.Application__c = applicationobj1.ID;
                    SAT.Program__c = SelectedProgram.Name;
                    SAT.RecordTypeID = RecordTypeId;
                    SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
            pgcsaveexit.setRedirect(true);
            return pgcsaveexit;
        }
        
        //////// If application found, then update the application and perform upsert on competition exam records ////////
        
        else
        {   List<GD_and_PI_Round__c> GDPIroundID = new List<GD_and_PI_Round__c>(); 
            GDPIroundID = [Select ID From GD_and_PI_Round__c Where Program__c =: SelectedProgram.ID AND Name =: round AND Active__c = True];
            
            
            Application__c updateApplication = new Application__c(ID=extApplication[0].ID);
            updateApplication.GD_and_PI_Center__c = center;
            updateApplication.GD_and_PI_Round__c = round;
            if(GDPIroundID.size()>0){
                System.debug('GDPIroundID==>'+GDPIroundID);            
                updateApplication.FUI_GD_and_PI_Round__c = GDPIroundID[0].ID;
            }
            updateApplication.Program__c = SelectedProgram.ID;
            updateApplication.FLAME_Entrance_Aptitude_Test_FEAT__c = applicationobj.FLAME_Entrance_Aptitude_Test_FEAT__c;
            updateApplication.Do_you_need_on_campus_accommodation__c = applicationobj.Do_you_need_on_campus_accommodation__c;
            updateApplication.SAT_Score__c = applicationobj.SAT_Score__c ;
            updateApplication.ACT_Score__c = applicationobj.ACT_Score__c ;
            updateApplication.Old_SAT_Structure__c = applicationobj.Old_SAT_Structure__c;
            String completedStages = extApplication[0].Completed_Stages__c;
            String currentPageName = 'Program & Test';
            if(completedStages != null){
                if(completedStages.contains(currentPageName)){
                   // completedStages += ';' + currentPageName;
                   // updateApplication.Completed_Stages__c = completedStages;
                  if(completedStages.contains(';')){
                      completedStages = completedStages.replace(';'+currentPageName,'') ;
                  }else{
                      completedStages = completedStages.replace(currentPageName,'') ;
                      
                  }
                    system.debug('completedStages==>' +   completedStages);
                    updateApplication.Completed_Stages__c = completedStages;
                }
            }
            else{
                updateApplication.Completed_Stages__c = currentPageName;
            }
            
            update updateApplication;
            
            Contact c = [Select ID,Program_Interested_In__c from contact where id = :userID.ContactId];
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
                    if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
                    {
                        //Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(Application__c=updateApplication.ID);
                        List<Competition_Exam_Details__c> SATexam = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c From Competition_Exam_Details__c 
                                                                Where Application__c =: extApplication[0].ID AND RecordType.Name = 'SAT' Limit 1];
                        if(!SATexam.isempty())
                        {
                            Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                            Competition_Exam_Details__c SAT = new Competition_Exam_Details__c(ID=SATexam[0].ID);
                            SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                            SAT.Math__c = CED.Math__c;
                            SAT.Writing__c = CED.Writing__c;
                            SAT.Critical_Reading__c = CED.Critical_Reading__c;
                            SAT.Program__c = SelectedProgram.Name;
                            SAT.RecordTypeID = RecordTypeId;
                            SAT.Result_Awaited__c = CED.Result_Awaited__c;
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
                            SATscore.Application__c = updateApplication.ID;
                            SATscore.Program__c = SelectedProgram.Name;
                            SATscore.RecordTypeID = RecordTypeId;
                            SATscore.Result_Awaited__c = CED.Result_Awaited__c;
                            SATscore.SAT__c = TRUE;
                            Insert SATscore;
                        }
                        
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> SAT = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Math__c,Writing__c,Critical_Reading__c From Competition_Exam_Details__c 
                                                                Where Application__c =: updateApplication.ID AND RecordType.Name = 'SAT'Limit 1];
                        delete SAT;
                    }
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
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList);
                system.debug('list details>>>>>>>>>>>>>>>>' + DeleteExamsList.size());
                if(!DeleteExamsList.isEmpty())
                {
                    delete DeleteExamsList;
                }
                
               // if(SelectedProgram.Name.equalsIgnoreCase('UG (B.A.,BBA,B.Sc.)'))
               if(SelectedProgram.Program_Type__c.equalsIgnoreCase('Undergraduate'))
                {
                    if(updateApplication.Old_SAT_Structure__c == True || updateApplication.SAT_Score__c == True)
                    {
                        Id RecordTypeId = Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('SAT').getRecordTypeId();
                        Competition_Exam_Details__c SAT = new Competition_Exam_Details__c();
                        SAT.Name = 'SAT Score';
                        SAT.SAT_Exam_Date_mm_yyyy__c = CED.SAT_Exam_Date_mm_yyyy__c;
                        SAT.Math__c = CED.Math__c;
                        SAT.Writing__c = CED.Writing__c;
                        SAT.Critical_Reading__c = CED.Critical_Reading__c;
                        SAT.Application__c = updateApplication.ID;
                        SAT.Program__c = SelectedProgram.Name;
                        SAT.RecordTypeID = RecordTypeId;
                        SAT.Result_Awaited__c = CED.Result_Awaited__c;
                        SAT.SAT__c = TRUE;
                        Insert SAT;
                    }
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
        pgcsaveexit.setRedirect(true);
        return pgcsaveexit;
        
      
    }
    public List<SelectOption> Getaccomodation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
}