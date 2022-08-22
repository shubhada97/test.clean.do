public class FUA_ReviewApply_Controller
{
Public void saveAllData(){}
    
    public User UserID{get;set;}
    public Application__c  apps{get;set;}
    public Application__c applicationList {get;set;}
    public contact contactList{get;set;}
    public contact Con{get;set;}
    public List<FU_Education_Details__c> educationList{get;set;}
    public String SaveExit{get;set;}
    public String birthdateValue{get;set;}
    Public String SubmissionDate{get;set;}
    Public list<FUA_Work_Details__c> workDetails{get;set;}
    public List<Competition_Exam_Details__c> compExamDetails{get;set;}
    public Competition_Exam_Details__c CED{get;set;}
    public Competition_Exam_Details__c CED1{get;set;}
    public FUA_Payment__c payment{get;set;}
    public boolean workDetailsPresent{get;set;}
    public boolean EduDetailsPresent{get;set;}
    public boolean compExamDetailsPresent{get;set;}
    public boolean compExamDetailsPresent1{get;set;}
     public boolean compExamDetailsPresent2{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    public string ErrorMsg {get;set;}
    public string FatherCompany {get;set;}
    public string MotherCompany {get;set;}
    
    public FUA_ReviewApply_Controller()
    {
        applicationList = new Application__c ();
        workDetailsPresent = false;
        compExamDetailsPresent = false;
        compExamDetailsPresent1 = false;
        compExamDetailsPresent2 = false;
        EduDetailsPresent = false;
        contactList = new contact();
        List<FUA_Work_Details__c> workDetails =new list<FUA_Work_Details__c>();
        List<FU_Education_Details__c> educationList=new  List<FU_Education_Details__c>();
        FetchFields();
        applicationList.FUA_Submission_Date__c=system.today();
        list<string> systemDateLst = new list<string>();
        string systemDate= string.valueof(system.today());
        systemDateLst = systemDate.split('-');
        SubmissionDate = systemDateLst[2] +'/'+systemDateLst[1] +'/'+systemDateLst[0]   ;   
           
    }
    
  
    public void FetchFields()
    { 
    system.debug('applicationList.Id>>>>>>>>>>>>>>>>>>>>>>>>'+applicationList.Id); 
        try
        { 
            if(!String.IsEmpty(UserInfo.getUserId()))
            {     
                
                String appId;
                if(ApexPages.currentPage().getParameters().get('Id') != null){
                    appId = ApexPages.currentPage().getParameters().get('Id');
                    system.debug('appId>>>>>>>>>>>>>>>>>>>>>>>>'+appId);
                }
                
                if(applicationList.Id == NULL)
                { 
                   
                    if(appId == null){
                        UserID=[Select Id,name,fullphotourl,smallPhotoUrl,ContactId from User where Id = :UserInfo.getUserId()]; 
                        applicationList =[Select id,name,Contact__r.Name,FUA_Applicant_Image_URL__c,Admission_Status__c,Completed_Stages__c,Application_Reference_ID__c,Program__r.name,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c from Application__c WHERE Contact__c =: UserID.ContactID LIMIT 1]; 
                         system.debug('applicationList.Id>>>>>>>>>>>>>>>>>>>>>>>>'+applicationList.Id);                   
                    }
                    else{
                        applicationList =[Select id,name,Contact__r.Name,Admission_Status__c,Completed_Stages__c,FUA_Applicant_Image_URL__c,Application_Reference_ID__c,Program__r.name,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c from Application__c WHERE Id = :appId LIMIT 1]; 
                        UserID=[Select Id,name,fullphotourl,smallPhotoUrl,ContactId from User where ContactId = :applicationList.Contact__c]; 
                        system.debug('applicationList.Id>>>>>>>>>>>>>>>>>>>>>>>>'+applicationList.Id);
                    }
                    
                    if(applicationList.Program__r.name != 'Undergraduate (B.A.,B.A. Hons.,BBA,B.Sc.,B.Sc. Hons.)')
                    {
                        compExamDetails = [select Id,name,Competitive_Exams__c,Registration_No__c,FUA_Percentile__c,Score__c,Result_Awaited__c,application__r.FLAME_Entrance_Aptitude_Test_FEAT__c,application__r.SAT_Score__c from Competition_Exam_Details__c where Application__c = :applicationList.Id];    
                        if(compExamDetails.size() > 0 )
                        {
                            compExamDetailsPresent = true;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> CEDTemp = [Select ID,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Result_Awaited__c From Competition_Exam_Details__c where Application__c = :applicationList.Id AND SAT__c = TRUE];
                        if(CEDTemp.size() > 0){
                            CED = CEDTemp[0];
                            if(CED != null){
                                compExamDetailsPresent1 = true;
                            }
                        }
                    }
                 //Act
                  if(applicationList.Program__r.name != 'Undergraduate (B.A.,B.A. Hons.,BBA,B.Sc.,B.Sc. Hons.)')
                    {
                        compExamDetails = [select Id,name,Competitive_Exams__c,Registration_No__c,FUA_Percentile__c,Score__c,Result_Awaited__c,application__r.FLAME_Entrance_Aptitude_Test_FEAT__c,application__r.SAT_Score__c from Competition_Exam_Details__c where Application__c = :applicationList.Id];    
                        if(compExamDetails.size() > 0 )
                        {
                            compExamDetailsPresent = true;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> CEDTemp1 = [Select ID,ACT_Exam_Date_mm_yyyy__c,ACT_Reading__c,ACT_Math__c,ACT_English__c,ACT_Science__c,ACT_Composite_Score__c,Result_Awaited__c From Competition_Exam_Details__c where Application__c = :applicationList.Id AND ACT__c = TRUE];
                        if(CEDTemp1.size() > 0){
                            CED1 = CEDTemp1[0];
                            if(CED1 != null){
                                compExamDetailsPresent2 = true;
                            }
                        }
                    }
             
                    //-----------------------------Act-----------------------------------------------------  
                  /*  if(applicationList.Program__r.name =='Undergraduate (B.A.,BBA,B.Sc.)')
                    {
                        compExamDetails = [select Id,name,Competitive_Exams__c,Registration_No__c,FUA_Percentile__c,Score__c,Result_Awaited__c,application__r.FLAME_Entrance_Aptitude_Test_FEAT__c,application__r.SAT_Score__c,application__r.ACT_Score__c,ACT__c from Competition_Exam_Details__c where Application__c = :applicationList.Id];    
                        if(compExamDetails.size() > 0 )
                        {
                            compExamDetailsPresent = true;
                        }
                    }
                    else
                    {
                        List<Competition_Exam_Details__c> CEDTemp1 = [Select ID,ACT__c,Name,ACT_Exam_Date_mm_yyyy__c,ACT_Math__c,ACT_Reading__c,ACT_Science__c,Result_Awaited__c,ACT_English__c,ACT_Composite_Score__c From Competition_Exam_Details__c 
                                                                Where  Application__c = :applicationList.Id AND ACT__c = TRUE];
                        if(CEDTemp1.size() > 0){
                            CED1 = CEDTemp1[0];
                          system.debug('>>>>>>>>>>>>>CED1'+CED1);   
                            if(CED1 != null){
                                compExamDetailsPresent2 = true;
                            }
                        }
                    }  */
                    
                } 
            } 
            if(contactList.id == NULL)
            {
                contactList =[select id,name,Father_s_Last_Company__c,Mother_s_Last_Company__c,Gender__c,Marital_Status__c,FU_Residence_Phone_Code__c,FU_Mobile_Phone_Code__c,MobilePhone,FUA_Mobile__c,Email,Alternate_Email_ID__c,
                              Birthdate,Are_you_an_Indian__c,Total_Family_Income__c,  Mother_Tongue__c,Religion__c,Mailing_Address_Line_1__c,Mailing_Address_Line_2__c,Mailing_Postal_Code__c,
                              FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Mailing_City__c,Permanent_Address_Line_1__c,Permanent_Address_Line_2__c,FU_Applicant_Other_Country__c,
                              FU_Applicant_Other_State__c,FU_Applicant_Other_City__c,Mailing_City__c,Other_City__c,Permanent_Postal_Code__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,
                              Father_s_Mobile_No__c,FUA_Father_s_Mobile_No__c,Father_s_Occupation__c, Father_s_Current_Company__c,Father_s_Designation__c,  Mother_s_First_Name__c,Mother_s_Last_Name__c,Mother_s_Email_ID__c,  Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,FUA_Mother_s_Mobile_No__c,Mother_s_Occupation__c,Mother_s_Current_Company__c,
                              Mother_s_Designation__c,Source__c,Other__c,Residence_Phone_No__c,FUA_Residence_Phone_No__c from Contact where ID=:applicationList.Contact__c LIMIT 1];
                list<string> BirthDateLst = new list<string>();
                BirthDateLst = string.valueof(contactList.Birthdate).split('-');
                birthdateValue = BirthDateLst[2] +'/'+BirthDateLst[1] +'/'+BirthDateLst[0];
                
                Con= [Select ID,Email From Contact Where ID=: UserID.ContactID LIMIT 1];
            }
            workDetails=[Select id,name,Application__c,FUA_Work_City__c,FUA_Company__c,FUA_Work_Country__c,FUA_CTC_INR__c, FUA_Designation__c,FUA_From_Date__c,FUA_Function__c,FUA_Other_City1__c,FUA_Reporting_Person_Details__c,FUA_Work_State__c,FUA_To_Date__c,FUA_Type__c,
                         FUA_Your_Responsibilities__c,FromDate__c,Todate__c from FUA_Work_Details__c WHERE application__c =:applicationList.ID];
            
            if(workDetails.size() > 0){
                workDetailsPresent = true;
            }
            
            educationList=[select id,FU_Year_Class__c,FUA_Institution_School__c,FUA_Degree_Certificate__c,Application__c,FUA_Board_University__c,FUA_Year_of_Completion__c,FUA_CGPA_Actual__c,
                           FUA_CGPA_Out_Of__c,FUA_Major_Subjects__c,FUA_Education_Country__c,FUA_Education_State__c,FUA_Education_City__c from FU_Education_Details__c where application__c =:applicationList.ID ORDER BY Display_Sequence__c];
            
            if(educationList.size() > 0){
                EduDetailsPresent = true;
            }
            
            payment = new FUA_Payment__c();
            
            for(FUA_Payment__c pay : [SELECT Branch__c,DD_Number__c,Drawn_on_Bank_Name__c,FUA_Amount__c,FUA_Application__c,FUA_Bank_Ref_No__c,FUA_Failure_Message__c,FUA_Order_Id__c,FUA_Order_Status__c,FUA_Payment_Mode__c,FUA_Tracking_Id__c,Id,Name,Paid_By__c,Payment_Date__c,Scratch_Card_Number__c FROM FUA_Payment__c where FUA_Application__c = : applicationList.ID]){
                
                payment = pay;
            }
            system.debug('pay -> ' + payment);
            if(contactList.Father_s_Last_Company__c != Null)
            {
                FatherCompany = contactList.Father_s_Last_Company__c;
            }
            else
            {
                FatherCompany = contactList.Father_s_Current_Company__c;
            }
            if(contactList.Mother_s_Last_Company__c != Null)
            {
                MotherCompany = contactList.Mother_s_Last_Company__c;
            }
            else
            {
                MotherCompany = contactList.Mother_s_Current_Company__c;
            }
        
        String strurl = ApexPages.currentPage().getUrl();
        strurl = strurl.split('apex/')[1];
        
        if(strurl  == 'ApplicationPDF'){    
            //Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+applicationList.Application_Reference_ID__c+'.pdf');   
        }
        }
        catch(exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, e.getMessage()));
        }
    }
    
    public pagereference saveData()
    {
        PageReference  pgcproceed=null;
        if(checkData() == true){
            ErrorMsg = '';
            if(applicationList.id != NULL)
            {
                applicationList.FUA_Submission_Date__c=system.today();
                applicationList.FUA_Submission_Place__c=applicationList.FUA_Submission_Place__c;
                applicationList.FUA_Applicant_Name__c=  applicationList.FUA_Applicant_Name__c;
                applicationList.Application_Submission_Status__c = 'Submitted';
                applicationList.Admission_Status__c = 'Submitted Not Paid';
                String completedStages = applicationList.Completed_Stages__c;
                String currentPageName = 'Preview Form';
                if(completedStages != null){
                    if(!completedStages.contains(currentPageName)){
                        completedStages += ';' + currentPageName;
                        applicationList.Completed_Stages__c = completedStages+';Applied';
                    }
                }
                else{
                    applicationList.Completed_Stages__c = currentPageName+';Applied';
                }
                
                update applicationList;
                
                Contact c = [Select ID,Registration_Status__c from contact where id = :UserID.ContactID];
                c.Registration_Status__c = 'Submitted';
                update c;
            }
            if(!String.isBlank(SaveExit) && 'SaveExit'.equalsIgnoreCase(SaveExit))
            {
                
                pgcproceed= new PageReference('/secur/logout.jsp');
            }
            else
            {
                pgcproceed= new PageReference('/apex/PaymentGateway_1');                
            }
            pgcproceed.setRedirect(true);
            
        }else{
            ErrorMsg = 'Please complete the previous stages';
        }
        return pgcproceed;
    }
    
   
    
    private boolean checkData(){
        Boolean returnValue;
        if(applicationList.Id != NULL){
            String completedStages = applicationList.Completed_Stages__c;
            if(completedStages != Null && completedStages.contains('Program & Test') && completedStages.contains('Personal Details') && completedStages.contains('Education & Work')){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    
}