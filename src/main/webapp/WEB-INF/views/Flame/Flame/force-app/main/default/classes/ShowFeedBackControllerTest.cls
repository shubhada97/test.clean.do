@isTest
private Class ShowFeedBackControllerTest
{
 static private Account objAcc;
 static private Contact objCon;
 static private Ledger__c objLed;
 static private hed__Course__c objCourse;
 static private hed__Term__c objTerm;
 static private hed__Course_Offering__c objCourseOffering;
 static private hed__Course_Enrollment__c objCourseEnr;
 
    static void LoadData() 
    {
     
        CreateAccount();
        CreateContact();
        CreateLedger();
        CreateCourse();
        CreateTerm();
        CreateCourseOffering();
        CreateCourseEnrol();
    }
    
    static testMethod void validateController() 
    {   
    
        LoadData();
        Test.StartTest();
        ShowFeedBackController objCLUC = new  ShowFeedBackController();
        objCLUC.strCCId = objCourseEnr.id;
        objCLUC.isAcedmicM = true;
        objCLUC.isAcedmicE = true;
        objCLUC.strterm = 'EndTerm';
        objCLUC.SaveFeedBack();
        list<SelectOption> objSelection  =  objCLUC.getRadioOptions();
        list<SelectOption> objSelection1  =  objCLUC.getSRadioOptions();

        Test.StopTest();
    }
    
    static testMethod void validateController2() 
    {   
    
        LoadData();
        Test.StartTest();
        ShowFeedBackController objCLUC = new  ShowFeedBackController();
        objCLUC.strCCId = objCourseEnr.id;
        objCLUC.isAcedmicM = true;
        objCLUC.isAcedmicE = true;
        objCLUC.strterm = 'MidTerm';
        objCLUC.SaveFeedBack();
        list<SelectOption> objSelection  =  objCLUC.getRadioOptions();
        list<SelectOption> objSelection1  =  objCLUC.getSRadioOptions();

        Test.StopTest();
    }
    
    static testMethod void validateController1() 
    {   
    
        LoadData();
        Test.StartTest();
        ShowFeedBackController objCLUC = new  ShowFeedBackController();
        objCLUC.strCCId = objCourseEnr.id;
        objCLUC.isSports = true;
        objCLUC.SaveFeedBack();
        list<SelectOption> objSelection  =  objCLUC.getRadioOptions();
        list<SelectOption> objSelection1  =  objCLUC.getSRadioOptions();

        Test.StopTest();
    }
 
    static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
       insert objCon;
    }
    
    static void CreateLedger()
    {
       objLed = new Ledger__c();
       objLed.Contact__c = objCon.id;
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
       objCourseOffering.hed__Faculty__c = objCon.id;
       objCourseOffering.hed__Term__c = objTerm.id;
       insert objCourseOffering;
    }
    static void CreateCourseEnrol()
    { 
       objCourseEnr = new hed__Course_Enrollment__c();
       objCourseEnr.hed__Course_Offering__c = objCourseOffering.id; 
       insert objCourseEnr;
    }

}