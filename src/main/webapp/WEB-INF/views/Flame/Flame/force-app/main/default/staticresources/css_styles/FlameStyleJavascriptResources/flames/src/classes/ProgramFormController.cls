public with sharing class ProgramFormController 
{
    private Application__c applicationobj{get;set;}
    public String program {get;set;}
    public String round {get;set;}
    public String center {get;set;}
    public String choices { get; set;}
    //public Boolean compExam{get;set;}
    public Boolean compExam{get;set;}
    
    private list<GD_and_PI_Round__c> lstofRounds{get;set;}
    private list<Program__c> lstofPrograms{get;set;}
    public List<SelectOption> examComp{get;set;}
    public List<Competition_Exam_Details__c> lstOfCompetitionExams{get;set;}
    ApexPages.StandardController stdController;
    private user userID{get;set;}
    public string selectedExam{get;set;}
    
    public Competition_Exam_Details__c CED {get;set;}
    
    
    public ProgramFormController(ApexPages.StandardController con) 
    {
        stdController = con;
        lstofRounds = new list<GD_and_PI_Round__c>();
        lstofPrograms = new list<Program__c>();
        applicationobj = new Application__c();
        
        lstOfCompetitionExams = new List<Competition_Exam_Details__c>();
      //  lstOfCompetitionExams.add(new Competition_Exam_Details__c());
        
        examComp = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Competition_Exam_Details__c.Competitive_Exams__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
          examComp.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        //userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        //system.debug('userID'+userID);
        //system.debug('ContactId'+userID.ContactId);
    }
        
    public void AddCompetitionExams()
    {
        Competition_Exam_Details__c obj = new Competition_Exam_Details__c(Competitive_Exams__c=selectedExam);
        lstOfCompetitionExams.add(obj);
    }
    
    public void RemoveCompetitionExams()
    {
        Competition_Exam_Details__c obj = new Competition_Exam_Details__c(Competitive_Exams__c=selectedExam);
        lstOfCompetitionExams.add(obj);
    }
    
    public List<SelectOption> getPrograms()
    {
        List<SelectOption> options = new List<SelectOption>();
        lstofPrograms = [SELECT Active__c,Display_Sequence__c,Name From Program__c Order WHERE Active__c = True ORDER BY Display_Sequence__c];
        for(Program__c programToItrate : lstofPrograms )
        {
            options.add(new SelectOption(programToItrate.ID,programToItrate.Name));
        }
        return options;
    } 
    
    public List<SelectOption> getRounds()
    {
        List<SelectOption> options = new List<SelectOption>();
        lstofRounds = [Select ID,Name,GD_and_PI_Center__c From GD_and_PI_Round__c Where Active__c = True];
        for(GD_and_PI_Round__c rounds : lstofRounds )
        {
            options.add(new SelectOption(rounds.Name,rounds.Name));
        }
        return options;
    } 
    
    public List<SelectOption> getCenters()
    {
        List<SelectOption> options = new List<SelectOption>();
        List<GD_and_PI_Round__c> lstofCenters = [Select ID,Name,GD_and_PI_Center__c From GD_and_PI_Round__c Where Name = :round ];
        for(GD_and_PI_Round__c centers : lstofCenters )
        { 
            List<string> CenterList = centers.GD_and_PI_Center__c.split(';');
            for(string optn : CenterList ) {
                options.add(new SelectOption(optn,optn));
            }
        }
        return options;
    }     
    
   /* ​public List<SelectOption> getCompExam()
    {
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult =Competition_Exam_Details__c.Competitive_Exams__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }*/
    /*public PageReference CustomSave() 
    {    
        PageReference  pgcsave=null;
        applicationobj = (Application__c)stdController.getRecord();
        applicationobj.GD_and_PI_Center__c =center;
        applicationobj.GD_and_PI_Round__c =round;
        applicationobj.Contact__c=userID.ContactId;
        Insert applicationobj;
        //stdController.save();
        pgcsave= new PageReference('/apex/PersonalDetails?id='+ userID.ContactId); 
        pgcsave.setRedirect(true);
        return pgcsave;
    }
    public PageReference CustomSaveExit() 
    {    
        PageReference  pgcsaveexit=null;
        applicationobj = (Application__c)stdController.getRecord();
        applicationobj.GD_and_PI_Center__c =center;
        applicationobj.GD_and_PI_Round__c =round;
        applicationobj.Contact__c=userID.ContactId;
        Insert applicationobj;
        //stdController.save();
        pgcsaveexit= new PageReference('/apex/Test_Login_Page'); 
        pgcsaveexit.setRedirect(true);
        return pgcsaveexit;
    }*/

}