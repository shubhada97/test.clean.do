@isTest
private class ShowStudentLetterGradeControllerTest{

    static private Account objAcc;
    static private Contact objCon;
    static private Contact objCon1;
    static private Contact objPF;
    static private Ledger__c objLed;
    static private hed__Course__c objCourse;
    static private hed__Term__c objTerm;
    static private hed__Course_Offering__c objCourseOffering;
    static private hed__Course_Enrollment__c objCourseEnr;
    static private hed__Course_Enrollment__c objCourseEnr1;
    static private Course_feedback__c  objCFB;
    static private Course_feedback__c  objCFB1;
 
    static void LoadData() 
    {
     
        CreateAccount();
        CreateContact();
        //CreatePF();
        // CreateLedger();
        CreateCourse();
        CreateTerm();
        CreateCourseOffering();
        CreateCourseEnrol();
        CreateCourseFeedBack();
    }
    
    static testMethod void validateController() 
    {   
    
       //LoadData();
        
        User objUser;
        Id pId;
        Id cId;       
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){
            
             CreateAccount();
             CreateContact();
             
             
             system.debug('objCon.RecordType.Name@@@'+objCon.RecordType.Name);
             
             Contact objC = [Select Id, RecordType.Name , RecordTypeId from Contact where RecordTypeId =:objCon.RecordTypeId];
             system.debug('objC@@@@'+objC.RecordType.Name);
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'Student'];
            User portUser = new User();
            portUser.ProfileId = studPro.Id;
            portUser.Username = 'test1@test.com';
            portUser.Alias = 'test1';
            portUser.Email = 't@test1.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.ContactId = objC.Id;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;
            System.debug('portUser@@@@'+portUser);
            System.debug('portUser@@@@'+portUser.ContactId);
            
            
        objUser = [SELECT ID,ContactId, Profile.Name, profileId FROM User WHERE Id =: pId LIMIT 1];
         System.debug('objUser!!@@@@'+objUser.ContactId);
         CreatePF();
        CreateCourse();
        CreateTerm();
        CreateCourseOffering();
        CreateCourseEnrol();
        CreateCourseFeedBack();
     
        ShowStudentLetterGradeController objCLUC = new  ShowStudentLetterGradeController  ();
        objCLUC.objUser = objUser;
        objCLUC.objContact = objC;
        //objCLUC.objContact.RecordType.Name='FU-Student';
        objCLUC.strContId = objC.id;
        objCLUC.objCF = objCourseOffering;
        System.debug('objCLUC.objContact.RecordType.Name@@@'+objCLUC.objContact.RecordType.Name);
        
        objCLUC.Search();
        
        objCourseOffering.Academic_Year__c ='2018-19';
       objCourseOffering.Term__c = null;
       update objCourseOffering;
       objCLUC.Search();
       
       objCourseOffering.Academic_Year__c = null;
       objCourseOffering.Term__c = '2018/19S1';
       update objCourseOffering;
       objCLUC.Search();
        
        
        
        
        }       
     
        
    }
   static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    static void CreateContact()
    {

       Id FuStudentRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Student').getRecordTypeId(); 
           
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
      objCon.RecordTypeId = FuStudentRecordTypeId;
      //objCon.RecordType.Name= 'FU-Student';
       insert objCon;
       system.debug('objCon@@@@'+objCon.RecordType.Name);
       system.debug('objCon@@@@'+objCon.RecordTypeId);
       
    }
    
    static void CreateContact1()
    {

       Id FuEmployeeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId(); 
           
       objCon1 = new Contact();
       objCon1.LastName = 'Test';
       objCon1.Email = 'Test@gmail.com';
       objCon1.AccountID = objAcc.Id;
      objCon1.RecordTypeId = FuEmployeeRecordTypeId;
      //objCon.RecordType.Name= 'FU-Student';
       insert objCon1;
       system.debug('objCon@@@@'+objCon1.RecordType.Name);
       system.debug('objCon@@@@'+objCon1.RecordTypeId);
       
    }
    
     static void CreatePF()
    {
        Id FuStudentRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Student').getRecordTypeId(); 
       objPF = new Contact();
       objPF.LastName = 'Test1';
       objPF.Email = 'Tes1t@gmail.com';
       objPF.AccountID = objAcc.Id;
       objPF.RecordTypeId = FuStudentRecordTypeId;
       insert objPF;
    }
    
    static void CreateLedger()
    {
       objLed = new Ledger__c();
       //objLed.Contact__c = objCon.id;
       insert objLed;
    }
    static void CreateCourse()
    { 
       objCourse = new hed__Course__c();
       objCourse.Name = 'TestCourse';
       objCourse.hed__Course_ID__c = 'Test';
       objCourse.hed__Account__c =objAcc.id; 
       insert objCourse;
    }
    static void CreateTerm()
    { 
       objTerm = new hed__Term__c();
       objTerm.Name = '2018/19S1';
       objTerm.hed__Account__c =objAcc.id; 
       insert objTerm;
    }
    
    
    static void CreateCourseOffering()
    { 
       objCourseOffering = new hed__Course_Offering__c();
       objCourseOffering.Name = 'test';
       objCourseOffering.hed__Course__c = objCourse.id; 
     //  objCourseOffering.hed__Faculty__c = objCon.id;
       objCourseOffering.hed__Term__c = objTerm.id;
       objCourseOffering.Academic_Year__c ='2018-19';
       objCourseOffering.Term__c = '2018/19S1';
       insert objCourseOffering;
    }
    static void CreateCourseEnrol()
    { 
       objCourseEnr = new hed__Course_Enrollment__c();
       objCourseEnr.hed__Course_Offering__c = objCourseOffering.id; 
       objCourseEnr.hed__Contact__c = objCon.id;
       
       insert objCourseEnr;
    }
    
    static void CreateCourseEnrol1()
    { 
       objCourseEnr1 = new hed__Course_Enrollment__c();
       objCourseEnr1.hed__Course_Offering__c = objCourseOffering.id; 
       objCourseEnr1.hed__Contact__c = objCon1.id;
       
       insert objCourseEnr1;
    }
    
    static void CreateCourseFeedBack()
    { 
       objCFB = new Course_feedback__c();
       objCFB.Course_Connection__c = objCourseEnr.id; 
       objCFB.Contact__c = objCon.id;
       objCFB.Primary_Faculty__c = objPF.id;
       objCFB.Secondary_Faculty__c = objPF.id;
       objCFB.Third_Faculty__c = objPF.id;
       objCFB.Fourth_Faculty__c = objPF.id;
       insert objCFB;
    }
    static void CreateCourseFeedBack1()
    { 
       objCFB1 = new Course_feedback__c();
       objCFB1.Course_Connection__c = objCourseEnr1.id; 
       objCFB1.Contact__c = objCon1.id;
       objCFB1.Primary_Faculty__c = objCon1.id;
       objCFB1.Secondary_Faculty__c = objPF.id;
       objCFB1.Third_Faculty__c = objPF.id;
       objCFB1.Fourth_Faculty__c = objPF.id;
       insert objCFB1;
    }
    
      

}