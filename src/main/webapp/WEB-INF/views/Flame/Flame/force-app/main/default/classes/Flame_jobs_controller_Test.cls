@isTest
public class  Flame_jobs_controller_Test{
    public static testMethod void Flame_jobs_controller(){ 
    
    
    Flamejobs_Record_Ass__c ca = new Flamejobs_Record_Ass__c();
        ca.Name = 'Job Search';
        ca.Record_Type__c = 'HR';
        ca.Tab_Type__c = 'Job Search';
        insert ca;
    Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contact con = new Contact();
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-HRApplicant').getRecordTypeId();
        con.AccountId = acc.id;
        con.FirstName = 'Test 1';
        con.LastName = 'Name';
        con.Designation_Name__c = 'Assistant Manager - ERP';
        con.Department__c ='IT';
        con.Faculty__c='Faculty of Liberal Education';
        con.Office_Room__c='R005';
        con.Email = 'Email38@test.com';              
        insert con;
    
       Contact contact = [Select id,Name from contact Where id =: con.id  limit 1];
        System.debug('Contact : +'+contact);
        System.assertEquals(con.id, contact.id);
    
    FLAME_Job__c flame_job_Obj = new FLAME_Job__c();
    flame_job_Obj.Account__c = acc.id;
    //flame_job_Obj.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('HR').getRecordTypeId();
    flame_job_Obj.Area__c = 'Finance';
    flame_job_Obj.Contact__c = con.id;
    flame_job_Obj.Job_Description_Detail__c = '23';
    flame_job_Obj.Job_Description_Summary__c = '24';
    flame_job_Obj.Job_Function__c = 'Faculty of Business - Marketing';
    flame_job_Obj.Job_Title__c = 'Job_T967';
    flame_job_Obj.Post_Job__c = false;
    flame_job_Obj.Description_Summary__c = '36';
    Insert flame_job_Obj; 
    
    FLAME_Job__c flamejobs=[SELECT Id,Name,RecordTypeId,Account__c,Area__c,Contact__c,Job_Description_Detail__c,Job_Description_Summary__c,Job_Function__c,Job_Title__c,Post_Job__c,Description_Summary__c from FLAME_Job__c ];
     System.debug('FLAME_Job__c : +'+flamejobs);
     System.assertEquals(flame_job_Obj.id, flamejobs.id);
     
   FLAME_Job_Application__c flameapplication = New FLAME_Job_Application__c(); 
    flameapplication.Account__c = acc.id;
    flameapplication.Bachelors_Degree_Title__c = 'Bache534';
    flameapplication.Bachelors_Degree_University__c = 'Bache499';
    flameapplication.Bachelors_Degree_Year__c = 'Bache185';
    flameapplication.Contact__c = con.id;
    flameapplication.FLAME_Job__c = flame_job_Obj.id;
    flameapplication.FLAME_Job_Title__c = 'FLAME766';
    flameapplication.Work_Exp_Academic_PhD__c = 25;
    flameapplication.Work_Exp_Academic__c = 26;
    flameapplication.Work_Exp_Total__c = 27;
    flameapplication.Masters_Degree_Title__c = 'Maste560';
    flameapplication.Masters_Degree_University__c = 'Maste728';
    flameapplication.Masters_Degree_Year__c = 'Maste632';
    flameapplication.PhD_University__c = 'PhD_U928';
    flameapplication.PhD_Year__c = 'PhD_Y738';
    flameapplication.PhD__c = 'YES';
    flameapplication.Previous_Employer_Designation__c = 'Previ280';
    flameapplication.Previous_Employer_Name__c = 'Previ254';
    flameapplication.Current_Employer_CTC__c = 36;
    flameapplication.Current_Employer_Date__c = 'Curre923';
    flameapplication.Current_Employer_Designation__c = 'Curre585';
    flameapplication.Current_Employer_Name__c = 'Curre636';
    flameapplication.Current_Role__c = '40';
    Insert flameapplication;
     
    FLAME_Job_Application__c flame_job_application_Obj  =  [SELECT Id,createdDate,FLAME_Job__c, Contact__c, Overall_Status__c, App_Status__c, PhD__c, 
                              PhD_University__c, PhD_Year__c, Masters_Degree_Title__c, Masters_Degree_University__c, 
                              Masters_Degree_Year__c, Bachelors_Degree_Title__c, Bachelors_Degree_University__c, 
                              Bachelors_Degree_Year__c, Flame_Faculty_Reference__c, Current_Employer_Name__c, 
                              Current_Employer_Date__c, Current_Employer_Designation__c, Current_Employer_CTC__c, 
                              Previous_Employer_Designation__c, Previous_Employer_Name__c, Work_Exp_Total__c, 
                              Work_Exp_Academic__c, Work_Exp_Academic_PhD__c, Current_Role__c, Account__c,FLAME_Job_Title__c  
                              FROM FLAME_Job_Application__c];
    System.debug('FLAME_Job_Application__c : +'+flame_job_application_Obj); 
    System.assertEquals(flameapplication.id, flame_job_application_Obj.id);
  
    
    Flame_jobs_controller obj01 = new Flame_jobs_controller();
    obj01.ErrorLogin = 'test data';
    obj01.showResult = false;
    obj01.conn = new Contact();
    obj01.jobId = 'test data';
    obj01.con = new Contact();
    obj01.bachelorsDegreeYear = 'test data';
    obj01.AttchName = 'test data';
    obj01.contactId = new List<contact>();
    obj01.fileList = new List<Attachment>();
    obj01.attach = new Attachment();
    obj01.rId = 'test data';
    obj01.BirthdateValue = 'test data';
    obj01.currentRecordId = 'test data';
    obj01.newApplicationId = 'test data';
    obj01.joblist = new List<FLAME_Job_Application__c>();
    obj01.getAttachments();
    obj01.FLAMEjobs();
    obj01.backtojobs();
    obj01.FLAMEjobAboutUs();
    obj01.FLAMEjobcontactus();
    obj01.FLAMEjobHome();
    obj01.FLAME_Jobs_Register();
    obj01.jobtitlelink();
    obj01.checkExistingContact();
    obj01.FLAME_Job_Careers();
    obj01.personalDetails();
    obj01.FLAMEjobsregisterconfirmation();
    obj01.testclass();
    obj01.testclass1();
    obj01.testclass2();
    obj01.home();
    obj01.reume();
    obj01.getSearchAcc();
   // obj01.SendEmail(); 
    
    obj01.checkExistingContact();
   
    //obj01.Apply();
    apexPages.Currentpage().getParameters().put('Id', contact.id);
    apexPages.Currentpage().getParameters().put('Id',flame_job_Obj.id);
    apexPages.Currentpage().getParameters().put('Id',flame_job_application_Obj.id);
    
    
    system.assert(flame_job_Obj.id != null);
    PageReference pageRef = Page.FLAME_Register_Jobs_page;
    pageRef.getParameters().put('contact','test');
    pageRef.getParameters().put('flame_job_Obj','test');
    pageRef.getParameters().put('flameapplication','test');
    Test.setCurrentPage(pageRef);
    
    
   }
   
   Public static void sendEmailFunction(string contactId)
    {
        Contact con =  new Contact();
        con.id = '0030w000001WX1P';
        con.FirstName = 'Anil';
        con.LastName = 'Dutt';
        con.Email = 'anil@swiftsetup.com';
        insert con;
        List<contact> conlist =new List<contact>();
        conlist.add(con);
        
        for(contact so : conlist){
         String contact = so.id;  // assignation
         }
        Messaging.SingleEmailMessage mail 
        = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
       // mail.setToaddresses(contact);
       // mail.setTemplateId('00X90000001FNCN'); 
       // mail.setFileAttachments(new Messaging.EmailFileAttachment[] {mail});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
       Flame_jobs_controller obj02 = new Flame_jobs_controller();
       obj02.SendEmail(); 
        
    }   
   
  
  }