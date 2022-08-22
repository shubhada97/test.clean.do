@isTest(SeeAllData=true)

    public class thecontrollerTests {

        public static testMethod void testMyController_1() {

        PageReference pageRef = Page.LoginPage;
        Test.setCurrentPage(pageRef);
         Application__c app1 = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1];
        Contact con = [Select Id, email from Contact limit 1]; 
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Id);
        ApexPages.currentPage().getUrl().contains('ReviewAndApply'); 
        ApexPages.currentPage().getUrl().contains('ApplicationPDF'); 
        
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.ContactId =con.id;
        controller.findcontactController();
        //controller.SaveData();
        controller.Flame_Communitymethod();
        controller.SaveDataPD();
        controller.ForgotPass();
        controller.deleteAllWork();
        controller.SaveExit();
        controller.app = app1;
        controller.apps= app1;
        controller.applicationList = app1; 
        Flame_Community.applicationList1 = app1;
        controller.saveAllData();
        Test.stopTest();
        }
        public static testMethod void testMyController_2() {

        PageReference pageRef = Page.index1;
        Test.setCurrentPage(pageRef);
        Application__c con = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1]; 

        ApexPages.currentPage().getParameters().put('StaticContactId', con.Contact__c);
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.ContactId =con.Contact__c;
        controller.applicationList = con;
        controller.resetDone =true;
        controller.FetchFields();
        controller.saveData2();
        controller.checkData();
        controller.saveAllData2();
        controller.ForwardToCustomAuthPage();
        controller.RegisterUser();
        controller.indexSwitch= true;
        controller.proceedApplication();
        controller.redirect();
        controller.persaveAllData();
        controller.CountAdd=1;
        controller.Wrkdetls = new List<FUA_Work_Details__c>();
        controller.AddSection();
        controller.DeleteRow();
        controller.Savedata1();
        controller.EdDetList = new List<FU_Education_Details__c>();
        controller.yearChangeInit();
        controller.documents = new List<FUA_Applicant_Document__c>();
        controller.getPrograms1();

        Test.stopTest();
        }
        public static testMethod void testMyController_3() {
        PageReference pageRef = Page.ProgramForm;
        Test.setCurrentPage(pageRef);
        Application__c con = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1]; 
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Contact__c);
        Program__c prog = [Select ID,Name From Program__c limit 1];
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.ContactId =con.Contact__c;
        controller.applicationList = con;
        controller.urldownload = '' ;
        controller.cancelEdu();
        controller.redirect1();
        controller.redirect2();
        controller.loadProgramFormDetails();
        controller.FindRounds();
        controller.FindCenters();
        controller.url = '';
        controller.RepDate ='';
        controller.currentUser = true;
        controller.photoContentType='';
        controller.photoName ='image';
        controller.blobImageData ='';
        controller.program = prog.Name;
        controller.RemoveCompetitionExams();
        controller.FindCenters();
        controller.thankyou();
        controller.UploadPhotoAtt();
        controller.ApplicationPDFNext();
        controller.ApplicationPDFNext();
        controller.forgotPassword();
        controller.redirectToLogin();
        
        Test.stopTest();  

        } 
        
       public static testMethod void testMyController_4() {

       
        PageReference pageRef = Page.PersonalDetails;
        Test.setCurrentPage(pageRef);
        Program__c SelectedProgram = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c limit 1];
        Application__c obj = [Select ID,Name,Completed_Stages__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,GD_and_PI_Center__c,GD_and_PI_Round__c,Program__c,SAT_Score__c 
        From Application__c Where Contact__c !=null Limit 1];
        Contact con = [Select Id, email from Contact limit 1]; 
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Id);
        ApexPages.currentPage().getParameters().put('pId', con.Id);
         Program__c prog = [Select ID,Name From Program__c limit 1]; 
         Flame_Community.getProgramDetails(prog.Id);
        Test.startTest();
         Flame_Community controller = new Flame_Community();
        controller.getFUCities();
        controller.getreligions();
        controller.getfamilyincomes();
        controller.getresidencenumbs();
        controller.getMaritalstatuses();
        controller.getSalutations();
        controller.GetMotherOccupation();
        controller.GetFatherOccupation();
        controller.GetSameAddress();
        controller.GetStates();
        controller.GetOutCountries();
        controller.GetSources();
        controller.GetCountries();
        controller.GetNationality();
        controller.GetGender();
        controller.getPrograms1();
        controller.SaveExit1();
        controller.getPrograms();
        controller.getHtmlText();
        controller.getHtmlText1();
        controller.getHtmlText4();
        controller.getHtmlText5();
        controller.getSalutations();
        controller.FUA_forgotPassword();
        controller.SaveData3(); 
        controller.changePassword();
        controller.FUA_forgotPassword();
        controller.changePassword();
        controller.saveAll1();
        Test.stopTest();
        }
    public static testMethod void testMyController_5() {
        
        PageReference pageRef = Page.EducationAndWork;
        Test.setCurrentPage(pageRef);
        PageReference pageRef1 = Page.ReviewandApply;
        Test.setCurrentPage(pageRef1);
        Application__c con = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,(Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1]; 

        ApexPages.currentPage().getParameters().put('StaticContactId', con.Contact__c);
       Test.startTest();

        Flame_Community controller = new Flame_Community();
        controller.ContactId =con.Contact__c;
        controller.applicationList = con;
        controller.FUA_forgotPassword();
        controller.changepasswordconf();
        controller.changePassword();
        controller.ApplicationSControllertatus();
        controller.LandingPage();
        controller.LoginPassword ='temp';
        controller.Login();
        controller.applicationProgress = 1234 ;
        controller.fogottest = '' ;
        Test.stopTest();
        }
          
       public static testMethod void testMyController_6() {
        
        PageReference pageRef = Page.PaymentGateway;
        Test.setCurrentPage(pageRef);
        PageReference pageRef2 = Page.ThankyouPage;
        Test.setCurrentPage(pageRef2);
        Application__c con = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1]; 
        Competition_Exam_Details__c ced = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Application__c From Competition_Exam_Details__c 
        Where Application__c != null limit 1 ]; 
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Contact__c);
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.ContactId =con.Contact__c;
        controller.applicationList = con;
        Test.stopTest();                                       

        }
       public static testMethod void testMyController_7() {
        PageReference pageRef = Page.PhotographUpload;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        Test.stopTest();
        } 
        public static testMethod void testMyController_8() {
        
       
        PageReference pageRef = Page.StatementOfPurpose;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        Test.stopTest();
        }  
        
         public static testMethod void testMyController_10() {
       
        PageReference pageRef = Page.ApplicationFormPDF;
        Test.setCurrentPage(pageRef);
        Application__c con = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,
        Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,
        Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Housing_Preference_Submitted__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1]; 
        
       

        ApexPages.currentPage().getParameters().put('StaticContactId', con.Contact__c);
         Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.AccepetofferInTab3();
        controller.DAOffer();
        controller.yesaction();
       
      
       // controller.OnlinePayment2();
        controller.paymentRedirection1();
        controller.SemesterFee();
        
        controller.SaveExitinsemesterfee();
        controller.OnlinePayment3();
        controller.paymentRedirection2();
        controller.HousingPreference();
       
        controller.getselAOptns();
        controller.getselBOptns();
        controller.getselCOptns();
        controller.getselDOptns();
        controller.getselEOptns();
        controller.SaveExitinhousingpreference();
        controller.HousingPayment();
        //controller.houspayment();
        //controller.SaveExitinhousingpay();
        controller.OnlinePayment4();
        controller.paymentRedirection3();
        controller.UploadDocuments2();
        controller.AdmitCardController();
        controller.saveAllDa();
        controller.downloadAdmitCard();
        Test.stopTest();
        }
        
        public static testMethod void testMyController_11() {

        
        PageReference pageRef = Page.Accepetoffer;
        PageReference pageRef1 = Page.Semesterfee;
        Test.setCurrentPage(pageRef1);
        PageReference pageRef2 = Page.Enrollmentfee;
        Test.setCurrentPage(pageRef2);
        PageReference pageRef3 = Page.Housingpreference;
        Test.setCurrentPage(pageRef3);
        PageReference pageRef4 = Page.housingpayment;
        Test.setCurrentPage(pageRef4);
        PageReference pageRef5 = Page.Index1;
        Test.setCurrentPage(pageRef5);
        PageReference pageRef6 = Page.ApplicationFormPDF;
        Test.setCurrentPage(pageRef6);
        PageReference pageRef7 = Page.AdmitPage;
        Test.setCurrentPage(pageRef7);
        PageReference pageRef8 = Page.UploadDocuments;
        Test.setCurrentPage(pageRef8);
        PageReference pageRef9 = Page.ApplicationStatus;
        Test.setCurrentPage(pageRef9);
       
        Application__c A = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,
        Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,
        Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Housing_Preference_Submitted__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
         limit 1]; 
      
        Contact Con = [select id,Name, Mother_s_First_Name__c,(select id,Name,Application_Submission_Status__c,Completed_Stages__c,Admission_Status__c from Applications__r),Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,MobilePhone,
        Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
        Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
        Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
        Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
        Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
        Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
        FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
        FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
        Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c,HousingBuilding__c,HousingBuilding__r.Name,Hsg_Housing_Room__c from contact Limit 1];
        List<FUA_Work_Details__c> workDetails = new list<FUA_Work_Details__c>();                                       
        workDetails =[Select id,name,Application__c,FUA_Work_City__c,FUA_Company__c,FUA_Work_Country__c,FUA_CTC_INR__c, FUA_Designation__c,FUA_From_Date__c,FUA_Function__c,FUA_Other_City1__c,FUA_Reporting_Person_Details__c,FUA_Work_State__c,FUA_To_Date__c,FUA_Type__c,
        FUA_Your_Responsibilities__c,FromDate__c,Todate__c from FUA_Work_Details__c WHERE application__c =:a.ID];
        List<Contact> contactList = new List<Contact>();    
        contactList =[select id,name,Father_s_Last_Company__c,Mother_s_Last_Company__c,Gender__c,Marital_Status__c,FU_Residence_Phone_Code__c,FU_Mobile_Phone_Code__c,MobilePhone,FUA_Mobile__c,Email,Alternate_Email_ID__c,
        Birthdate,Are_you_an_Indian__c,Total_Family_Income__c,  Mother_Tongue__c,Religion__c,Mailing_Address_Line_1__c,Mailing_Address_Line_2__c,Mailing_Postal_Code__c,
        FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Mailing_City__c,Permanent_Address_Line_1__c,Permanent_Address_Line_2__c,FU_Applicant_Other_Country__c,
        FU_Applicant_Other_State__c,FU_Applicant_Other_City__c,Mailing_City__c,Other_City__c,Permanent_Postal_Code__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,
        Father_s_Mobile_No__c,FUA_Father_s_Mobile_No__c,Father_s_Occupation__c, Father_s_Current_Company__c,Father_s_Designation__c,  Mother_s_First_Name__c,Mother_s_Last_Name__c,Mother_s_Email_ID__c,  Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,FUA_Mother_s_Mobile_No__c,Mother_s_Occupation__c,Mother_s_Current_Company__c,
        Mother_s_Designation__c,Source__c,Other__c,Residence_Phone_No__c,FUA_Residence_Phone_No__c from Contact where ID=:a.Contact__c LIMIT 1];
        Program__c pro = new Program__c();   
        Pro = [Select ID,Name,Program_Type__c,Program_Code__c From Program__c  Limit 1];     
        List<FUA_Payment__c>  listOfPayments = new List<FUA_Payment__c>();
        ApexPages.currentPage().getParameters().put('StaticContactId', A.Contact__c);
        ApexPages.currentPage().getParameters().put('pId', A.Contact__c);

        System.Test.startTest();    
        List<FUA_Payment__c>  listpayment = new List<FUA_Payment__c>();
        FUA_Payment__c P = new FUA_Payment__c ();
        p.Branch__c = 'pune';
        p.DD_Number__c='1234';
        p.Drawn_on_Bank_Name__c='Axis';
        p.FUA_Amount__c=decimal.valueOf('100');
        p.FUA_Bank_Ref_No__c='1234';
        p.FUA_Failure_Message__c='sucess';
        p.FUA_Order_Id__c='ABC';
        listpayment.add(p);
        Flame_Community fc = new Flame_Community();
        PageReference nextpage = Page.SemesterFee;
        Test.setCurrentPage(nextpage);
        PageReference nextpage1 = Page.EnrollMentFee;
        Test.setCurrentPage(nextpage1);
        PageReference nextpage2 = Page.Housingpreference;
        Test.setCurrentPage(nextpage2);
        PageReference nextpage3 = Page.Housingpayment;
        Test.setCurrentPage(nextpage3);
        PageReference nextpage4 = Page.Accepetoffer;
        Test.setCurrentPage(nextpage4);
       PageReference nextpage5 = Page.PhotographUpload;
       Test.setCurrentPage(nextpage5);
       PageReference nextpage6 = Page.ApplicationFormPDF;
        Test.setCurrentPage(nextpage6);
        
        String param='Test';
        String encResp1='test';
        String Semester2 ='1000';
        String photoErrorMsg ='please update photo';
        String UserNameErrorMessage ='please update username';
        String PasswordValidationErrorMessage ='please';
        String choices='test';
        string FatherCompany='airtel';
        string MotherCompany='kumari';
        String selectedOption='test';
        String SubmissionDate='Systemdate';
        String appsubmissionStatus='sucess';
        String selectedDocument='pdf';
        String documentDescription='test';
        String fileName='flame';
        String oldPassword='009';
        String staticconid='varma009';
        String baseUrl='testurl';
        String url='testurl';
        String paymentType='online';
        String scarchCardNo='12345';
        String ddNumber='12345';
        String ddDrwanBank='axis';
        String bankBranch='pune';
        String paidBy='online';
        String currentPageName='photoupload';
        String completedStages='sucess';
        String cropX ='xa';
        String cropY ='ya';
        String cropSize='123';
        String modalTitle='varma';
        String actionPhotoLabel ='asdffg';
        String Paramcontactid = 'test'; 
        string Name = 'varma';
        string Label ='ascd';
        String order_id ='asd';
        String order_status='sucess';
        String encResp ='';
        String redirect_Url='asddddd';
        String cancel_url = 'asddffgggh'; 
        System.assertEquals(null, fc.PasswordValidationErrorMessage);
        System.assertEquals(null, fc.UserNameErrorMessage);
        //System.assertEquals(null, fc.photoErrorMsg);
        System.assertEquals(null, fc.Semester2);
        System.assertEquals(null, fc.encResp1);
        System.assertEquals(null, fc.choices);
        System.assertEquals(null, fc.FatherCompany);
        System.assertEquals(null, fc.MotherCompany);
        System.assertEquals(null, fc.selectedOption);
        System.assertEquals(null, fc.SubmissionDate);
        System.assertEquals(null, fc.appsubmissionStatus);
        System.assertEquals(null, fc.selectedDocument);
        System.assertEquals(null, fc.SubmissionDate);
        System.assertEquals(null, fc.appsubmissionStatus);
        System.assertEquals(null, fc.selectedDocument);        
        System.assertEquals(null, fc.documentDescription);        
        System.assertEquals(null, fc.fileName);
        System.assertEquals(null, fc.oldPassword);
        System.assertEquals(null, fc.staticconid);
        System.assertEquals(null, fc.paidBy);
        System.assertEquals(null, fc.url);
        System.assertEquals(null, fc.bankBranch);
        System.assertEquals(null, fc.ddDrwanBank);
        System.assertEquals(null, fc.ddNumber);
        System.assertEquals(null, fc.scarchCardNo);
        System.assertEquals(null, fc.paymentType);
        System.assertEquals(null, fc.cropX);
        System.assertEquals(null, fc.cropY);
        System.assertEquals(null, fc.cropSize);
        System.assertEquals(null, fc.Paramcontactid);
        System.assertEquals(null, fc.actionPhotoLabel);
        System.assertEquals(null, fc.encResp);
        Con = new Contact();
        Con.FU_Applicant_Other_Country__c= 'india';
        Con.FU_Applicant_Other_State__c= 'sucess';
        Con.FU_Applicant_Other_City__c='pune';
        Con.Other_City__c='vskp';
        Con.FirstName='varma';   
        Con.LastName= 'pandu';
        Con.FUA_Mobile__c='1234567890';
        Con.FU_Mobile_Phone_Code__c='test';
        con.Classification_Applicant__c = TRUE;
        Con.Email ='Username@gmail.com';
        Con.Portal_password__c = 'Password';   
       
        fc.workDetailsPresent = false;
        fc.EduDetailsPresent = true;
        fc.compExamDetailsPresent =true;
        fc.compExamDetailsPresent1= false;
        fc.compExam=false;
        fc.applicationCreated=true;
        fc.Imagemodalbool= true;
        fc.showAddDeleteButtons=true;
        fc.checkPaymentIsDone();
        
        fc.OnlinePayment();
        fc.Thankyoumethod();
       // fc.uploadPhoto();
        fc.PhotographUpload();
        fc.saveImage();
        fc.saveAllData1();
        fc.StatementOfPurpose();
        //fc.SaveExit2();
        fc.ApplicationFormPDF();
        fc.DownloadApplicationPDF();
        fc.saveAllD();
        fc.reload =true;
        fc.AdmitPageController();
        fc.UploadDocuments();
        fc.getHtmlText2();
        fc.ForgotPasswordcontroller();
        fc.IsPastDate=true;
        fc.IsPastDate=false;
        fc.paymentRedirection3();
        fc.InvokeCalls();
     
       
        fc.OnlinePayment4();
        fc.getselDOptns();
        fc.getselCOptns();
        fc.getselBOptns();
        fc.SaveExitinhousingpreference();
        fc.paymentRedirection2();
        fc.getCompetitionExamListFromDatabase2();
       
        fc.reviewandapplymethod();
        fc.UpdateEducationList();
        fc.Testmethod2(); 
        fc.Testmethod3();
        Competition_Exam_Details__c examDetails= new Competition_Exam_Details__c();
        examDetails.Application__c=a.Id;
        examDetails.Competitive_Exams__c='SAT EXAM';
        examDetails.Name= 'SAT EXAM';
        examDetails.SAT_Exam_Date_mm_yyyy__c= '03/1992';
        examDetails.Math__c= 56;
        examDetails.Writing__c= 65;
        examDetails.Critical_Reading__c= 45;
        examDetails.Program__c='programsTest';
        examDetails.SAT__c=true;
        examDetails.FEAT__c=false;
            
        List<Document> docs = new List<Document>();

        Folder folder = [Select id from folder where name='Flame Static Content'];
        Document doc = new Document();
        doc.Name = 'IndexPageBeforeThankYou';
        doc.FolderId = folder.Id;
        doc.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc);
        Document doc1 = new Document();
        doc1.Name = 'IndexPageAfterThankYou';
        doc1.FolderId = folder.Id;
        doc1.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc1);       

        Document doc11 = new Document();
        doc11.Name = 'ApplicationStatusShortlisted';
        doc11.FolderId = folder.Id;
        doc11.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc11);

        Document doc2 = new Document();
        doc2.Name = 'ApplicationStatusRejected';
        doc2.FolderId = folder.Id;
        doc2.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc2);

        Document doc3 = new Document();
        doc3.Name = 'ApplicationStatusDocumentsAwaited';
        doc3.FolderId = folder.Id;
        doc3.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc3);

        Document doc4 = new Document();
        doc4.Name = 'ApplicationStatusWaitListed';
        doc4.FolderId = folder.Id;
        doc4.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc4);

        Document doc5 = new Document();
        doc5.Name = 'ApplicationStatusShortlisted&ScholarshipGranted';
        doc5.FolderId = folder.Id;
        doc5.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc5);

        Document doc6 = new Document();
        doc6.Name = 'ApplicationStatusNotGenerated';
        doc6.FolderId = folder.Id;
        doc6.Body = Blob.valueOf('UNIT.TEST');
        docs.add(doc6);

      
        Case myCase = new Case();
        myCase.SuppliedEmail = con.Email;
        mycase.Origin = 'Web';
        myCase.Status = 'New';
       

        FUA_Applicant_Document__c document = new FUA_Applicant_Document__c();
        document.Application__c = a.Id;
        document.Description__c = 'sdfad';
        document.Document_Link__c = 'https://www.dropbox.com/s/az5y9csjko86wu0/PGB2016004126__docs.css?dl=0';
        document.Document_Type__c = 'Transcripts';
        document.Is_Verified__c =  false;
        document.Name = 'PGB2016004126__docs.css';
        document.Path__c = '/Salesforce Documents/Contacts/PGB2016004126/PGB2016004126__docs.css';
       

        Attachment attach = new Attachment();
        attach.ParentId = a.id;
        attach.Name = a.Application_Reference_ID__c + '.pdf';
        attach.Body = Blob.valueOf('UNIT.TEST');
        

        FUA_Work_Details__c work = new FUA_Work_Details__c();
        work.Application__c=a.Id;
        work.FUA_Work_City__c='Other';
        work.FUA_Company__c='EXT';
        work.FUA_Work_Country__c ='India';
        work.FUA_CTC_INR__c=656;
        work.FUA_Designation__c='manager';
        work.FUA_From_Date__c= system.today() - 100;
        work.FUA_To_Date__c = system.today() - 70;
        work.FUA_Function__c ='change';
        work.FUA_Other_City1__c='test';
        work.FUA_Reporting_Person_Details__c='pvbtest';
        work.FUA_Work_State__c='Assam';
        work.FUA_Type__c='Full Time';
        work.FUA_Your_Responsibilities__c='Roleasmanager';
               

        List<FU_Education_Details__c> educations = new LisT<FU_Education_Details__c>();
        List<Competition_Exam_Details__c> lstOfCompetitionExams = new LisT<Competition_Exam_Details__c>();

        FU_Education_Details__c education = new FU_Education_Details__c();
        education.Application__c =  a.Id;
        education.FUA_Board_University__c =  'CBSE';
        education.FUA_CGPA_Actual__c =  2;
        education.FUA_CGPA_Out_Of__c =  '10';
        education.FUA_Degree_Certificate__c =  '10/Xth';
        education.FUA_Education_Country__c =  'Azerbaijan';
        education.FUA_Institution_School__c =  'wwwwwwwwww';
        education.FUA_Other_City__c =  'sxasxa';
        education.FUA_Year_of_Completion__c =  '2003';
        education.FU_Year_Class__c =  '10/Xth';
        education.Name =  '10/Xth';
        education.Program__c =  'Postgraduate (ENTPR)';
        educations.add(education);

        FU_Education_Details__c education1 = new FU_Education_Details__c();
        education1.Application__c =  a.Id;
        education1.FUA_CGPA_Actual__c =  2;
        education1.FUA_CGPA_Out_Of__c =  '20';
        education1.FUA_Degree_Certificate__c =  '11/XIth';
        education1.FUA_Education_Country__c =  'India';
        education1.FUA_Education_State__c =  'Karnataka';
        education1.FUA_Institution_School__c =  'we';
        education1.FUA_Year_of_Completion__c =  '2000';
        education1.FU_Year_Class__c =  '11/XIth';
        education1.Name =  '11/XIth';
        educations.add(education1);

        FU_Education_Details__c education2 = new FU_Education_Details__c();
        education2.Application__c =  a.Id;
        education2.FUA_Board_University__c =  'sda';
        education2.FUA_CGPA_Actual__c =  2;
        education2.FUA_CGPA_Out_Of__c =  '13';
        education2.FUA_Degree_Certificate__c =  'asd';
        education2.FUA_Education_Country__c =  'Hungary';
        education2.FUA_Institution_School__c =  'sad';
        education2.FUA_Major_Subjects__c =  'asd';
        education2.FUA_Other_City__c =  'asdad';
        education2.FUA_Year_of_Completion__c =  '1999';
        education2.FU_Year_Class__c =  'Bachelors / Undergraduate';
        education2.Name =  'Bachelors / Undergraduate';
        educations.add(education2);

        FU_Education_Details__c education3 = new FU_Education_Details__c();
        education3.Application__c =  a.Id;
        education3.FUA_CGPA_Actual__c =  2;
        education3.FUA_CGPA_Out_Of__c =  '45';
        education3.FUA_Degree_Certificate__c =  '12/XIIth';
        education3.FUA_Education_Country__c =  'India';
        education3.FUA_education_State__c =  'Karnataka';
        education3.FUA_Institution_School__c =  'as';
        education3.FUA_Major_Subjects__c =  'sad';
        education3.FUA_Year_of_Completion__c =  '1998';
        education3.FU_Year_Class__c =  '12/XIIth';
        education3.Name =  '12/XIIth';
        educations.add(education3);
       
        Competition_Exam_Details__c CED1 = new Competition_Exam_Details__c();
        CED1.Name = 'CAT';
        CED1.Result_Awaited__c = TRUE;
        CED1.Competitive_Exams__c = 'CAT';
        CED1.Registration_No__c = 'TEST1';
        CED1.Application__c = a.ID;
        lstOfCompetitionExams.add(CED1);

        Competition_Exam_Details__c CED2 = new Competition_Exam_Details__c();
        CED2.Name = 'MAT';
        CED2.Result_Awaited__c = TRUE;
        CED2.Competitive_Exams__c = 'MAT';
        CED2.Registration_No__c = 'TEST2';
        CED2.Application__c = a.ID;
        lstOfCompetitionExams.add(CED2);
       

        Application__c application = new Application__c();
        application.Achievments__c  = 'Prize winnertest';
        application.ApplicationPDFLink__c = 'https://www.dropbox.com/s/94wt6udgyljb2ac/PGB2016004126.pdf?dl=1';
        application.AdmitCardURL__c = 'https://www.dropbox.com/s/jzvmhkgjwosphhs/PGB2016004126_AdmitCard.pdf?dl=1';
        application.Admission_Status__c  = 'Admitted';
        application.Admitted__c =  true;
        application.Applications__c  = 'Applications963963';
        application.Application_Progress__c =  100;
        application.Application_Submission_Status__c  = 'Submitted & Paid';
        application.Completed_Stages__c  = 'Program & Test;Personal Details;Education & Work;Preview Form;Payment;Admit Card;Admission Status;Application PDF;Photograph Upload;SOP;Thankyou;Applied;ThankyouDone';
        application.Contact__c  = con.Id;
        application.FLAME_Entrance_Aptitude_Test_FEAT__c =  true;
        application.FUA_All_Documents_Verified__c =  false;
        application.FUA_Applicant_Name__c  = 'gfghf';
        application.FUA_SOP_Submitted__c =  false;
        application.FUA_Submission_Date__c  = system.today();
        application.FUA_Submission_Place__c  = 'testPlace';
        application.GD_and_PI_Center__c  = 'Chennai';
        application.GD_and_PI_Round__c  = 'Regular Cycle I (13th - 14th Feb 2016)';
        application.GD_Score1__c =  50;
        application.GD_Score3__c =  60;
        application.Median__c =  false;
        application.Other_Details__c  = 'Big winnertest';
        application.PI_Score1__c =  50;
        application.PI_Score2__c =  50;
        application.PI_Score3__c =  80;
        application.Program__c  = pro.Id;
        application.SAT_Score__c =  true;
        application.Statement_of_Purpose__c  = 'sdfsadfsadfsd';
        application.X10th_Xth_Score_PGB__c =  43;
        application.X12th_Xth_Score_PGB__c =  43;
       

        List<GD_and_PI_Round__c> lstofRounds = new List<GD_and_PI_Round__c>();
        GD_and_PI_Round__c gdPIRoundPGB = new GD_and_PI_Round__c();
        gdPIRoundPGB.Active__c =  true;
        gdPIRoundPGB.Display_Sequence__c =  3;
        gdPIRoundPGB.End_Date__c  = system.today() + 30;
        gdPIRoundPGB.GD_and_PI_Center__c  = 'Bangalore;Chennai;Delhi';
        gdPIRoundPGB.Name  = 'Early Decision Cycle (12th - 13th Dec 2015)';
        gdPIRoundPGB.Program__c  = pro.Id;
        gdPIRoundPGB.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundPGB);

        GD_and_PI_Round__c gdPIRoundPGC = new GD_and_PI_Round__c();
        gdPIRoundPGC.Active__c =  true;
        gdPIRoundPGC.Display_Sequence__c =  3;
        gdPIRoundPGC.End_Date__c  = system.today() + 30;
        gdPIRoundPGC.GD_and_PI_Center__c  = 'Chennai;Delhi';
        gdPIRoundPGC.Name  = 'Campus Cycle (16th - 17th Jan 2016)';
        gdPIRoundPGC.Program__c  = pro.Id;
        gdPIRoundPGC.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundPGC);

        GD_and_PI_Round__c gdPIRoundUGLE = new GD_and_PI_Round__c();
        gdPIRoundUGLE.Active__c =  true;
        gdPIRoundUGLE.Display_Sequence__c =  3;
        gdPIRoundUGLE.End_Date__c  = system.today() + 30;
        gdPIRoundUGLE.GD_and_PI_Center__c  = 'Bangalore;Chennai';
        gdPIRoundUGLE.Name  = 'Regular Cycle I (13th - 14th Feb 2016)';
        gdPIRoundUGLE.Program__c  = pro.Id;
        gdPIRoundUGLE.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundUGLE);
       

        Program__c programPGB = new Program__c();
        programPGB.Active__c = true;
        programPGB.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth';
        programPGB.Display_Sequence__c = 1;
        programPGB.Name = 'Postgraduate (ENTPR)';
        programPGB.Program_Type__c = 'Postgraduate';
        

        Program__c programPGC = new Program__c();
        programPGC.Active__c = true;
        programPGC.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programPGC.Display_Sequence__c = 2;
        programPGC.Name = 'Postgraduate (MBA [Communications Management])';
        programPGC.Program_Type__c = 'Postgraduate';
        

        Program__c programUGLE = new Program__c();
        programUGLE.Active__c = true;
        programUGLE.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programUGLE.Display_Sequence__c = 3;
        programUGLE.Name = 'UG (B.A.,BBA,B.Sc.)';
        programUGLE.Program_Type__c = 'Undergraduate';
        

        Account account = new Account();
        account.Name = 'FLAME 2016-17 Admissions';
       // insert account;

        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        contact.Email =  'rohit63419FLAMETEST@gmail.com';        
       // insert contact;    
        Account acc = new Account(Name = 'Testing Recursive');
       // insert acc;
        Attachment objA=new Attachment();
        objA.body = Blob.valueOf('');
        objA.name = 'Photo_';
        objA.parentid= A.id;
        objA.ContentType = 'application/jpg';
       // insert objA;

        Flame_Community upload = new  Flame_Community();
        String data = 'testtesttesttest';
        upload.pageId = Con.Id;
        upload.fileName = 'Test.jpg';
        upload.file = Blob.valueOf(data);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        ApexPages.currentPage().getParameters().get('pageId'); 

        Flame_Community testObjPGC = new Flame_Community();
        testObjPGC.paymentType = 'demandDraft';
        testObjPGC.paidBy = 'Demand Draft';
        testObjPGC.ddNumber = Null;
        testObjPGC.ddDrwanBank = Null;
        testObjPGC.bankBranch = Null;
        PageReference testPage = Page.PaymentGateWay;
        Test.setCurrentPage(testPage); 

        Contact testCon = [select id from Contact limit 1 ];
        //Application__c testApp = [Select Id, Name,Completed_Stages__c From Application__c Where Contact__c = :testCon.Id];
        //testApp.Completed_Stages__c = 'Program & Test; Personal Details; Education & Work; Preview Form; Payment; Thankyou';
        //update testApp;
        PageReference appPage = Page.ApplicationFormPDF;
        Test.setCurrentPage(appPage); 
        testObjPGC.checkPaymentIsDone();
        List<SelectOption> test_options = new List<SelectOption>();
        test_options.add(new SelectOption('10/Xth', '10/Xth'));
        test_options.add(new SelectOption('11/XIth', '11/XIth'));
        test_options.add(new SelectOption('12/XIIth', '12/XIIth'));
        test_options.add(new SelectOption('Bachelors / Undergraduate', 'Bachelors / Undergraduate'));
        test_options.add(new SelectOption('Masters / Postgraduate', 'Masters / Postgraduate'));
        test_options.add(new SelectOption('Other', 'Other')); 
        List<FUA_Payment__c> EnrollFeePayment =new List<FUA_Payment__c>();       

        System.Test.stopTest();

        }
    private static testMethod void createCustomSettings(){

        List<FUA_Payment_Gateway__c> testlstPayment = new List<FUA_Payment_Gateway__c>();
        FUA_Payment_Gateway__c testPayment = new FUA_Payment_Gateway__c();
        testPayment.Name = 'Payment Details For SandBox';
        testPayment.Working_Key__c = '8E1AE4A2FDEB871B7E21B30CE222A097';
        testPayment.Access_Code__c = 'AVRP63DA78CI30PRIC';
        testPayment.Merchant_Id__c = '89212';
        testPayment.EndPointUrl__c = 'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        testPayment.FUA_Amount__c = 1500;
        testPayment.FUA_Currency__c = 'INR';
        testPayment.FUA_Language__c = 'EN';
        testlstPayment.add(testPayment);

        FUA_Payment_Gateway__c testPayment1 = new FUA_Payment_Gateway__c();
        testPayment1.Name = 'Payment Details For Prod';
        testPayment1.Working_Key__c = '8E1AE4A2FDEB871B7E21B30CE222A097';
        testPayment1.Access_Code__c = 'AVRP63DA78CI30PRIC';
        testPayment1.Merchant_Id__c = '89212';
        testPayment1.EndPointUrl__c = 'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        testPayment1.FUA_Amount__c = 1500;
        testPayment1.FUA_Currency__c = 'INR';
        testPayment1.FUA_Language__c = 'EN';
        testlstPayment.add(testPayment1);

        if(testlstPayment.size() > 0){
        
        }

        Contact testCon = [select id from Contact limit 1];
        //Application__c testApp = [Select Id, Name,Completed_Stages__c From Application__c Where Contact__c = :testCon.Id];
       // testApp.Completed_Stages__c = 'Program & Test; Personal Details; Education & Work; Preview Form';
       // update testApp;   
        FUA_Scratch_Card_Details__c testScratchCard = new FUA_Scratch_Card_Details__c(Name = 'testCard', Scratch_Card_Number__c = 'f453454',Scratch_Card_Usage_Status__c = 'Available');
         
        String encResponse = '7e8505423748ea386a72d3ff596c6e94ac41235480e05299b305fba5871150de94f86bf41d26ba4a04e1eaec2e5e46518a84ec4ace011156714b8eb0062ef698d92e69021d01db54a54c030f8c43abf76f63545e5f06ad7b7be839ffb0719a3bffa20c6359954877eb233f3f8b458d20460f4b7e3cd06f373427c6c3711e934191a01323a19c8dc17f18c456586908271cd9904e669c4c099fd3938ad733e35726a91de9e461c1316905e245cbeff1183b71a106da1d3f0a5258118ddd3dba6a21b973cbdc8b5127e5510b20947443a6256b3d9bc83bc4a1a46443bb2b9de207f9b2dc061b391b8faaef425a44b97c5b8bfc13dfcf4230257c4152c86a46e850c0060737b0fabd48f02888de9449e3536823a8baaa3f511cb688ca563087ea686e3a719e27f7e259ff43bf47cff33f2271dbe52b8e34189655aba8e03e738b15fd15daa7fac758264a7776fb0586993b9935520cbc886cb379323542ff0066092682d9523b97fcb82e93d6f3d4f48824cc2c1f59137bca88a0a579c63f3ead0fbfc3b5a0ab37fd9c13d3b39a0486efc3928771b6a66cbcda24868e6ff4e528286b7084b5a354bf44dd8ac6c1a38ecb8d6d66a6a3a472422c75a78cf9bc0dace75621f8cf28de155ccf4fbe605446d681c31e9a4efbea2b7acecd365d4b23ba13aa90ef412e8725ffea1df23661f54bd93219ec28c4cd7933419bf78a29c77faa2b61a59c077ede432ac872e7fd62e7b948e5496f97e4f9c000bb5b339bb91871720f4ff0d63836ecb170e3342964417829168435aaebb17c0f33c98cc25b74544216b115be535210aff08ebf5bb7aa2d047d672e546a9d2478c708d0661f134c5fa3a5ba249102d4803f97694ec49aca2fc747e383a11b00a7fe1625dbfed3ec94217f3a8e56a653494542cf28193be6bc612f84e00eb35763102df9506922b2'; 
        Test.setCurrentPageReference(new PageReference('Page.PaymentGateway'));
        System.currentPageReference().getParameters().put('encResp', encResponse); 
        Flame_Community testonline = new Flame_Community();      
        PageReference testPage = Page.onlinepayment;
        Test.setCurrentPage(testPage);  
        testonline.paymentType= ' olpayment';
        testonline.scarchCardNo = 'f234455';
        // testonline.payNowMethod();
        FUA_Payment__c testPaymentRecord = new FUA_Payment__c();
        testPaymentRecord.Paid_By__c = 'Scratch Card';
        //testPaymentRecord.FUA_Application__c = testApp.Id;
        testPaymentRecord.Scratch_Card_Number__c = 'f345678';
        
        Flame_Community testdd = new Flame_Community();
        testdd.paymentType = 'demandDraft';
        testdd.paidBy = 'Demand Draft';
        testdd.ddNumber = '234567';
        testdd.ddDrwanBank = 'testBank';
        testdd.bankBranch = 'testBranch';
        PageReference testPage1 = Page.Thankyoupage;
        Test.setCurrentPage(testPage1); 

        }
    public static testMethod void testMyController_13() {
        FLM_Healthsampletest tt = new FLM_Healthsampletest();
         tt.Health(); 
     codecoveragecontroller tc =new codecoveragecontroller();
         tc.codecommunity();
         FLM_flameclass ta = new FLM_flameclass();
         ta.Testmethod1();
         ta.Testmethod2(); 
         ta.Testmethod3();
       healthsamplecontroller tb = new healthsamplecontroller();
       tb.Testmethod1();
       tb.Testmethod2(); 
       tb.Testmethod3();
       FLMsupportclass td= new FLMsupportclass();
       td.Testmethod1();
       td.Testmethod2(); 
      td.Testmethod3();
       flmcommunitysamplecontroller te = new flmcommunitysamplecontroller();
         te.Testmethod1();
         te.Testmethod2(); 
         te.Testmethod3();
         flamesamplecontroller tf = new flamesamplecontroller();
         tf.Testmethod1();
         tf.Testmethod2(); 
         tf.Testmethod3();
         educationsamplecontroller tg = new educationsamplecontroller();
         tg.Testmethod1();
         tg.Testmethod2(); 
         tg.Testmethod3();
         Accepetsamplecontroller th =new Accepetsamplecontroller();
          th.Testmethod1();
          th.Testmethod2(); 
          th.Testmethod3();
          enrollmentsamplecontroller ti = new enrollmentsamplecontroller();
          ti.Testmethod1();
          ti.Testmethod2(); 
          ti.Testmethod3();
          semestersamplecontroller tj = new semestersamplecontroller();
          tj.Testmethod1();
          tj.Testmethod2(); 
          tj.Testmethod3();
            housingpreferencesamplecontroller tk = new housingpreferencesamplecontroller();
          tk.Testmethod1();
          tk.Testmethod2(); 
          tk.Testmethod3();
            housingpaymentsamplecontroller tl = new housingpaymentsamplecontroller();
          tl.Testmethod1();
          tl.Testmethod2(); 
          tl.Testmethod3();
           uploaddocumentsamplecontroller tm = new uploaddocumentsamplecontroller();
          tm.Testmethod1();
          tm.Testmethod2(); 
          tm.Testmethod3(); 
           applicationstatussamplecontroller tn= new  applicationstatussamplecontroller();
            tn.Testmethod1();
          tn.Testmethod2(); 
          tn.Testmethod3(); 
          admitsamplecontroller to = new admitsamplecontroller();
            to.Testmethod1();
          to.Testmethod2(); 
          to.Testmethod3(); 
      }

 
        
        
          
        }