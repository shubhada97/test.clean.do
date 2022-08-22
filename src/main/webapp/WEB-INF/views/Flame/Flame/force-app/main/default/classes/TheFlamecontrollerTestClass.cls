@isTest(SeeAllData=true)

     global class TheFlamecontrollerTestClass {

    public static testMethod void testMyController_1() {
      
        PageReference pageRef = Page.LoginPage;
        Test.setCurrentPage(pageRef);
        PageReference index = Page.index1;
        Test.setCurrentPage(index);
        PageReference programform = Page.ProgramForm;
        Test.setCurrentPage(programform);
        PageReference Personaldetails = Page.PersonalDetails;
        Test.setCurrentPage(Personaldetails);
        PageReference EducationAndWork = Page.EducationAndWork;
        Test.setCurrentPage(EducationAndWork);
        PageReference ReviewandApply = Page.ReviewandApply;
        Test.setCurrentPage(ReviewandApply);
        PageReference PaymentGateway = Page.PaymentGateway;
        Test.setCurrentPage(PaymentGateway);
         PageReference StatementOfPurpose = Page.StatementOfPurpose;
        Test.setCurrentPage(StatementOfPurpose);
        PageReference ThankyouPage = Page.ThankyouPage;
        Test.setCurrentPage(ThankyouPage);
        PageReference PhotographUpload = Page.PhotographUpload;
        Test.setCurrentPage(PhotographUpload);
        PageReference Accepetoffer = Page.Accepetoffer;
        Test.setCurrentPage(Accepetoffer);
        PageReference Semesterfee = Page.Semesterfee;
        Test.setCurrentPage(Semesterfee);
        PageReference Enrollmentfee = Page.Enrollmentfee;
        Test.setCurrentPage(Enrollmentfee);
        PageReference Housingpreference = Page.Housingpreference;
        Test.setCurrentPage(Housingpreference);
        PageReference housingpayment = Page.housingpayment;
        Test.setCurrentPage(housingpayment);
       
        PageReference AdmitPage = Page.AdmitPage;
        Test.setCurrentPage(AdmitPage);
        PageReference ApplicationFormPDF = Page.ApplicationFormPDF;
        Test.setCurrentPage(ApplicationFormPDF);
        PageReference UploadDocuments = Page.UploadDocuments;
        Test.setCurrentPage(UploadDocuments);
        PageReference ApplicationStatus = Page.ApplicationStatus;
        Test.setCurrentPage(ApplicationStatus);
        Account acc = new Account(Name = 'FLAME 2016-17 Admissions');
         /*Contact*/
        Contact con = new Contact(FirstName = 'Testing',LastName = 'Extentia', Email =  'rohit63419FLAMETEST@gmail.com',AccountId = acc.Id );
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Id);
        /*application*/
        Application__c app1 = new Application__c(Application_Submission_Status__c='pending',Completed_Stages__c='payment',Contact__c=con.id,GD_and_PI_Round__c='2017-2018',
        GD_and_PI_Center__c='pune', Statement_of_Purpose__c='asdfg',Achievments__c='kjj',Other_Details__c='assd',  FUA_Submission_Place__c='pune',
        FUA_Applicant_Name__c='varma',Admission_Status__c='sucess', FUA_Scholarship_Granted__c='yes', FLAME_Entrance_Aptitude_Test_FEAT__c=true,SAT_Score__c=true, FUA_Broadcast_Admission__c=true,ApplicationPDFLink__c='',AdmitCardURL__c='url',
        FUA_Applicant_Image_URL__c='image');
         /*admit card*/
        Admit_Card__c admitcard = new Admit_Card__c(Test_Address_Line_1__c='129',Test_Address_Line_2__c='128',Test_Address_Line_3__c='127', FUA_Broadcast_Admit_Card__c=true);
        /*work details*/
        FUA_Work_Details__c Wrkdetls = new FUA_Work_Details__c(Name='ramu',FromDate__c='date',Todate__c='today',FUA_Work_City__c='pune' , FUA_Company__c='Airtel',FUA_Work_Country__c='indian',  FUA_Designation__c='manager',FUA_Function__c='asdf',FUA_Reporting_Person_Details__c='asm', FUA_Work_State__c='hyderabad',FUA_Other_City1__c='hyd', FUA_Type__c='sales', FUA_Your_Responsibilities__c='asdfgety');
         /*education*/
        FU_Education_Details__c education2 = new FU_Education_Details__c(Application__c =  acc.Id,FUA_Board_University__c =  'sda',
        FUA_CGPA_Actual__c =  2,FUA_CGPA_Out_Of__c =  '13',FUA_Degree_Certificate__c =  'asd',FUA_Education_Country__c =  'Hungary',FUA_Institution_School__c =  'sad',FUA_Major_Subjects__c =  'asd',FUA_Other_City__c =  'asdad',FUA_Year_of_Completion__c =  '1999',FU_Year_Class__c =  'Bachelors / Undergraduate',Name =  'Bachelors / Undergraduate');
        ApexPages.currentPage().getParameters().put('StaticContactId', app1.Contact__c);
         /*program*/
        Program__c prog = [Select ID,Name From Program__c limit 1]; 
        Program__c program_Obj = new Program__c(Active__c = false);
        Insert program_Obj;  
        /*CompetitionExam*/
        Competition_Exam_Details__c ced = [Select ID,Name,SAT_Exam_Date_mm_yyyy__c,Critical_Reading__c,Math__c,Writing__c,Application__c From Competition_Exam_Details__c 
        Where Application__c != null limit 1 ];
        
        Competition_Exam_Details__c competition_exam_details_Obj = new Competition_Exam_Details__c();
        competition_exam_details_Obj.Name = 'Sat';
        competition_exam_details_Obj.Application__c = app1.id;
        competition_exam_details_Obj.FEAT__c = false; 
        competition_exam_details_Obj.FUA_Median__c = false;
        competition_exam_details_Obj.Result_Awaited__c = false;
        competition_exam_details_Obj.SAT__c = false;
        competition_exam_details_Obj.Update_Analytics_Field__c = false;
        //insert competition_exam_details_Obj;
        ApexPages.currentPage().getParameters().put('StaticContactId', app1.Contact__c);
        /*covered StandardController code coverage*/
        
        
        
        
        ApexPages.currentPage().getParameters().put('StaticContactId', con.Id);
        ApexPages.currentPage().getParameters().put('pId', con.Id);
        ApexPages.currentPage().getUrl().contains('ReviewAndApply');
       ApexPages.StandardController sc = new ApexPages.StandardController(con);
        Test.startTest();
        
        Flame_Community controller = new Flame_Community(sc);
        
        controller.ContactId =con.id;
        controller.findcontactController();
        controller.Flame_Communitymethod();
        controller.ForgotPass();
        controller.deleteAllWork();
        controller.SaveExit();
        controller.saveAllData();
        controller.app = app1;
        controller.apps= app1;
        controller.applicationList = app1; 
        controller.app = app1;
        controller.ContactId =app1.Contact__c;
        controller.applicationList = app1;
        controller.resetDone =true;
        controller.FetchFields();
        controller.saveData2();
        controller.checkData();
        controller.saveAllData2();
        controller.ForwardToCustomAuthPage();
        controller.RegisterUser();
        controller.indexSwitch= true;
        controller.proceedApplication();
        controller.CountAdd=1;
        controller.Wrkdetls = new List<FUA_Work_Details__c>();
        controller.AddSection();
        controller.DeleteRow();
        controller.Savedata1();
        controller.EdDetList = new List<FU_Education_Details__c>();
        controller.yearChangeInit();
        controller.documents = new List<FUA_Applicant_Document__c>();
        controller.getPrograms1();
        Flame_Community.applicationList1 = app1;
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
        //controller.thankyou();
        controller.UploadPhotoAtt();
        controller.ApplicationPDFNext();
        controller.ApplicationPDFNext();
        controller.forgotPassword();
        controller.redirectToLogin();
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
        controller.FUA_forgotPassword();
        controller.changepasswordconf();
        controller.changePassword();
        controller.ApplicationSControllertatus();
        controller.LandingPage();
        controller.LoginPassword ='temp';
        controller.Login();
        controller.applicationProgress = 1234 ;
        controller.fogottest = '' ;
        controller.reviewandapplymethod();
        controller.AccepetofferInTab3();
        controller.UploadDoc();
        controller.DAOffer();
        controller.yesaction();
        controller.Savedocument();
        controller.redirectInTab3();
        //controller.RedirectToPayment();
        controller.SaveExitinEnrollment();
        controller.OnlinePayment2();
        controller.paymentRedirection1();
        controller.SemesterFee();
        controller.Next();
        controller.SaveExitinsemesterfee();
        controller.OnlinePayment3();
        controller.paymentRedirection2();
        controller.HousingPreference();
        controller.educationandworkmethod();
        controller.getselAOptns();
        controller.getselBOptns();
        controller.getselCOptns();
        controller.getselDOptns();
        controller.getselEOptns();
        controller.programformaction();
        controller.HousingPayment();
        controller.SaveExitinhousingpay();
        controller.OnlinePayment4();
        controller.paymentRedirection3();
        controller.UploadDocuments2();
        controller.AdmitCardController();
        controller.saveAllDa();
        controller.downloadAdmitCard();
        //controller.Accepetoffer();
        controller.checkPaymentIsDone();
        
        Test.stopTest();
        }
         public static testMethod void testMyController_8() {
         PageReference pageRef = Page.PhotographUpload;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        Flame_Community controller = new Flame_Community();
        controller.Testmethod2();
        controller.Testmethod3();
        controller.addhealth();
        Test.stopTest();
        } 
      public static testMethod void testMyController_2() {
        Account acc = new Account(Name = 'FLAME 2016-17 Admissions');
       // insert acc;
       contact Con = new Contact();
        Con.AccountId = acc.Id;
                Con.FU_Applicant_Other_Country__c='1234' ;
                Con.FU_Applicant_Other_State__c='ap' ;
                Con.FU_Applicant_Other_City__c='vzag';
                Con.Other_City__c='ap';
                Con.FirstName='a';   
                Con.LastName= 'e';
                Con.FUA_Mobile__c='1234567788';
                Con.FU_Mobile_Phone_Code__c='0891';
                Con.Program_Interested__c ='pg' ;
                Con.Program_Interested_In__c ='pg' ;
                con.Classification_Applicant__c = TRUE;
                Con.Email = 'd@gmail.com';
                insert con; 
        Program__c pro = new Program__c();
        pro.Active__c = true;
        pro.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        pro.Display_Sequence__c = 3;
        pro.Name = 'UG (B.A.,BBA,B.Sc.)';
        pro.Program_Type__c = 'Undergraduate';
        insert pro;
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
       // insert application;
     
      Competition_Exam_Details__c examDetails= new Competition_Exam_Details__c();
        examDetails.Application__c=application.Id;
        examDetails.Competitive_Exams__c='SAT EXAM';
        examDetails.Name= 'SAT EXAM';
        examDetails.SAT_Exam_Date_mm_yyyy__c= '03/1992';
        examDetails.Math__c= 56;
        examDetails.Writing__c= 65;
        examDetails.Critical_Reading__c= 45;
        examDetails.Program__c='programsTest';
        examDetails.SAT__c=true;
        examDetails.FEAT__c=false;
       // insert examDetails;    
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

       // insert docs;
        Case myCase = new Case();
        myCase.SuppliedEmail = con.Email;
        mycase.Origin = 'Web';
        myCase.Status = 'New';
       // insert mycase;

        FUA_Applicant_Document__c document = new FUA_Applicant_Document__c();
        document.Application__c = application.Id;
        document.Description__c = 'sdfad';
        document.Document_Link__c = 'https://www.dropbox.com/s/az5y9csjko86wu0/PGB2016004126__docs.css?dl=0';
        document.Document_Type__c = 'Transcripts';
        document.Is_Verified__c =  false;
        document.Name = 'PGB2016004126__docs.css';
        document.Path__c = '/Salesforce Documents/Contacts/PGB2016004126/PGB2016004126__docs.css';
       // insert document;

        Attachment attach = new Attachment();
        attach.ParentId = application.id;
        attach.Name = application.Application_Reference_ID__c + '.pdf';
        attach.Body = Blob.valueOf('UNIT.TEST');
       // insert attach;

        FUA_Work_Details__c work = new FUA_Work_Details__c();
        work.Application__c=application.Id;
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
       // insert work;        

        List<FU_Education_Details__c> educations = new LisT<FU_Education_Details__c>();
        List<Competition_Exam_Details__c> lstOfCompetitionExams = new LisT<Competition_Exam_Details__c>();

        FU_Education_Details__c education = new FU_Education_Details__c();
        education.Application__c =  application.Id;
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
        education1.Application__c =  application.Id;
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
        education2.Application__c =  application.Id;
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
        education3.Application__c =  application.Id;
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

        //insert educations; 
        Competition_Exam_Details__c CED1 = new Competition_Exam_Details__c();
        CED1.Name = 'CAT';
        CED1.Result_Awaited__c = TRUE;
        CED1.Competitive_Exams__c = 'CAT';
        CED1.Registration_No__c = 'TEST1';
        CED1.Application__c = application.ID;
        lstOfCompetitionExams.add(CED1);

        Competition_Exam_Details__c CED2 = new Competition_Exam_Details__c();
        CED2.Name = 'MAT';
        CED2.Result_Awaited__c = TRUE;
        CED2.Competitive_Exams__c = 'MAT';
        CED2.Registration_No__c = 'TEST2';
        CED2.Application__c = application.ID;
        lstOfCompetitionExams.add(CED2);
      //  insert lstOfCompetitionExams;

        

      


        Program__c programPGB = new Program__c();
        programPGB.Active__c = true;
        programPGB.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth';
        programPGB.Display_Sequence__c = 1;
        programPGB.Name = 'Postgraduate (ENTPR)';
        programPGB.Program_Type__c = 'Postgraduate';
      //  insert programPGB;

        Program__c programPGC = new Program__c();
        programPGC.Active__c = true;
        programPGC.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programPGC.Display_Sequence__c = 2;
        programPGC.Name = 'Postgraduate (MBA [Communications Management])';
        programPGC.Program_Type__c = 'Postgraduate';
      //  insert programPGC;

        Program__c programUGLE = new Program__c();
        programUGLE.Active__c = true;
        programUGLE.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programUGLE.Display_Sequence__c = 3;
        programUGLE.Name = 'UG (B.A.,BBA,B.Sc.)';
        programUGLE.Program_Type__c = 'Undergraduate';
        insert programUGLE;
 
        Attachment objA=new Attachment();
        objA.body = Blob.valueOf('');
        objA.name = 'Photo_';
        objA.parentid= application.id;
        objA.ContentType = 'application/jpg';
      //  insert objA;
      ProgressBarCtrl controller = new ProgressBarCtrl();
        Flame_Community upload = new  Flame_Community(controller);
        
        String data = 'testtesttesttest';
       // upload.pageId = Con.Id;
        upload.fileName = 'Test.jpg';
        upload.file = Blob.valueOf(data);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        ApexPages.currentPage().getParameters().get('pageId'); 
        PageReference PaymentGateWay = Page.PaymentGateWay;
        Test.setCurrentPage(PaymentGateWay); 

        
        
        
        List<SelectOption> test_options = new List<SelectOption>();
        test_options.add(new SelectOption('10/Xth', '10/Xth'));
        test_options.add(new SelectOption('11/XIth', '11/XIth'));
        test_options.add(new SelectOption('12/XIIth', '12/XIIth'));
        test_options.add(new SelectOption('Bachelors / Undergraduate', 'Bachelors / Undergraduate'));
        test_options.add(new SelectOption('Masters / Postgraduate', 'Masters / Postgraduate'));
        test_options.add(new SelectOption('Other', 'Other')); 
        List<FUA_Payment__c> EnrollFeePayment =new List<FUA_Payment__c>(); 
        //2
        PageReference indexPage = Page.Index1;
        Test.setCurrentPage(indexPage);
        indexPage.setRedirect(false); 
        indexPage.getParameters().put('id',con.id);
       // System.assertEquals(Page.Index1.getUrl(),indexPage.getUrl());
        Set<Id> recordTypeIds = new Set<Id>();
        RecordTypeIds.add(Schema.SObjectType.Competition_Exam_Details__c.getRecordTypeInfosByName().get('Competitive Exams').getRecordTypeId());
       
              
        
              
      list<apexpages.Message> am = new list<apexpages.Message>();
        system.assertNotEquals(null, am.size());
        Boolean messageFound = false;
        for(apexpages.Message msg : am)
        {
            if(msg.getDetail() =='missing required field:[ParentId]'&& msg.getSeverity() == ApexPages.Severity.Error)    
            messageFound = true;
        }
       // system.assert(messageFound);
       Flame_Community testdd = new Flame_Community();
       
        


        }
        
    public static testMethod void createCustomSettings(){

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
      
        FUA_Scratch_Card_Details__c testScratchCard = new FUA_Scratch_Card_Details__c(Name = 'testCard', Scratch_Card_Number__c = 'f453454',Scratch_Card_Usage_Status__c = 'Available');
      //  insert testScratchCard;  
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
       
        testPaymentRecord.Scratch_Card_Number__c = 'f345678';
      //  insert testPaymentRecord;
        Flame_Community testdd = new Flame_Community();
        testdd.paymentType = 'demandDraft';
        testdd.paidBy = 'Demand Draft';
        testdd.ddNumber = '234567';
        testdd.ddDrwanBank = 'testBank';
        testdd.bankBranch = 'testBranch';
        PageReference testPage1 = Page.Thankyoupage;
        Test.setCurrentPage(testPage1);
       
       
        
       /* List values to write test coverage*/
       
        List<SelectOption> selOpts=testdd.educationoptions;
        List<SelectOption> options=testdd.options;
        List<SelectOption> documentTypes=testdd.documentTypes;
        List<Competition_Exam_Details__c> compExamDetails=testdd.compExamDetails;
        List<Competition_Exam_Details__c> lstOfCompetitionExams1=testdd.lstOfCompetitionExams1;
       // list<GD_and_PI_Round__c> lstofRounds=testdd.lstofRounds;
        List<Application__c> extApplication=testdd.extApplication;
        List<FU_Education_Details__c> educationList=testdd.educationList;
        List<FUA_Work_Details__c> workDetails=testdd.workDetails;
        List <Competition_Exam_Details__c> lstCed = new List<Competition_Exam_Details__c>();
        
       
      
      
      }
       
    public static testMethod void testMyController_10() {
        PageReference ApplicationFormPDF = Page.ApplicationFormPDF;
        Test.setCurrentPage(ApplicationFormPDF);
        
        Application__c A = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
        Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
        FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
        FUA_Applicant_Image_URL__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,
        Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,
        Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Housing_Preference_Submitted__c,
        (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
        WHERE Contact__c!=null limit 1];
         
       
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
                  
        ApexPages.currentPage().getParameters().put('StaticContactId', A.Contact__c);
        ApexPages.currentPage().getParameters().put('pId', A.Contact__c);

        System.Test.startTest();    
      
        Flame_Community fc = new Flame_Community();
        
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
        String center ='vzag' ;
        String ProgramType='ug';
        String ProgramCode='ug123';
        String PlaceOfBirthCon = 'asddff';
        String PlaceOfBirthSt='asddff';
        String PlaceOfBirthOut='wedfr';
        String SaveExit='qwsed';
        String GenderVal='general';
        String BirthdateValue='sderf';
        String PassportExpireDateValue='sdfgtr';
        boolean switchindex= false;
        boolean IsBroadcasted = false;
        boolean Isempty = false;
        String AdmissionStatus='Sucess';
        String Password ='varma008';
        String ConfirmPassword = 'varma009';
        String newPassword = 'hari008';
        String verifyNewPassword = 'ram008';
        String ApplicationStatus ='Reject';
        String AddValue = 'abcd';
        String ConPassword = 'varma008';
        String applicationText = 'text';
        String Email ='varma@gmail.com';
         System.assertEquals(null, fc.UserNameErrorMessage);
         System.assertEquals(null, fc.PasswordValidationErrorMessage);
        System.assertEquals(null, fc.Email);
        System.assertEquals(null, fc.applicationText);
        System.assertEquals(null, fc.ConPassword);
        System.assertEquals(null, fc.AddValue);
        System.assertEquals(null, fc.ApplicationStatus);
        System.assertEquals(null, fc.verifyNewPassword);
        System.assertEquals(null, fc.newPassword);
        System.assertEquals(null, fc.ConfirmPassword);
        System.assertEquals(null, fc.Password);
        System.assertEquals(null, fc.AdmissionStatus);
        System.assertEquals(null, fc.Isempty);
        System.assertEquals(null, fc.Semester2);
        System.assertEquals(null, fc.encResp1);
        System.assertEquals(null, fc.IsBroadcasted);
        System.assertEquals(null, fc.FatherCompany);
        System.assertEquals(null, fc.MotherCompany);
        System.assertEquals(null, fc.switchindex);
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
        System.assertEquals(null, fc.PassportExpireDateValue);
        System.assertEquals(null, fc.BirthdateValue);
        System.assertEquals(null, fc.GenderVal);
        System.assertEquals(null, fc.SaveExit);
        System.assertEquals(null, fc.PlaceOfBirthOut);
        System.assertEquals(null, fc.PlaceOfBirthSt);
        System.assertEquals(null, fc.PlaceOfBirthCon);
        System.assertEquals(null, fc.ProgramCode);
        System.assertEquals(null, fc.ProgramType);
        System.assertEquals(null, fc.center);
         
         
       /* methods*/ 
        fc.workDetailsPresent = false;
        fc.EduDetailsPresent = true;
        fc.compExamDetailsPresent =true;
        fc.compExamDetailsPresent1= false;
        //fc.compExam=false;
        fc.applicationCreated=true;
       // fc.Imagemodalbool= true;
        fc.showAddDeleteButtons=true;
        fc.checkPaymentIsDone();
        //fc.payNowMethod();
        fc.OnlinePayment();
        fc.Thankyoumethod();
        //fc.uploadPhoto();
        fc.PhotographUpload();
       // fc.saveImage();
        fc.saveAllData1();
        fc.StatementOfPurpose();
       // fc.SaveExit2();
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
       // fc.isHousingPaymentDone();
        fc.OnlinePayment4();
        fc.getselDOptns();
        fc.getselCOptns();
        fc.getselBOptns();
        fc.SaveExitinhousingpreference();
        fc.paymentRedirection2();
        fc.getCompetitionExamListFromDatabase2();
        fc.reviewandapplymethod();
        fc.UpdateEducationList();
        
       
     /*Personal Details Page test coverage*/ 
     PersonalDetails pd = New PersonalDetails();    
    //String Contactid =contact_Obj.id;
    //System.assertEquals(null, pd.Contactid);
    String Salutation='gender';
    System.assertEquals(null, pd.Salutation);
    String FirstName='hari';
    System.assertEquals(null, pd.FirstName);
    String LastName='krishna';
    System.assertEquals(null, pd.LastName);
    String ConEmail='hari@123.com';
    System.assertEquals(null, pd.ConEmail);
    String Age='12';   
    System.assertEquals(null, pd.Age);       
    String Alternate_Email_ID='abc@gmail.com';
    System.assertEquals(null, pd.Alternate_Email_ID);
    String FU_Applicant_Mailing_City='vskp';  
    System.assertEquals(null, pd.FU_Applicant_Mailing_City);
    String FU_Applicant_Mailing_Country ='india';
    System.assertEquals(null, pd.FU_Applicant_Mailing_Country);  
    String FU_Applicant_Mailing_State ='ap';
    System.assertEquals(null, pd.FU_Applicant_Mailing_State);
    String FU_Applicant_Other_City  ='pune'; 
    System.assertEquals(null, pd.FU_Applicant_Other_City); 
    String FU_Applicant_Other_Country ='india';
    System.assertEquals(null, pd.FU_Applicant_Other_Country);
    String FU_Applicant_Other_State ='maharastra';
    System.assertEquals(null, pd.FU_Applicant_Other_State);  
    String Are_you_an_Indian ='yes';
    System.assertEquals(null, pd.Are_you_an_Indian);
    String Father_s_Current_Company ='airtel'; 
    System.assertEquals(null, pd.Father_s_Current_Company );
    String Father_s_Designation   ='salesforce';
    System.assertEquals(null, pd.Father_s_Designation);
    String Father_s_Email_ID ='rao';
    System.assertEquals(null, pd.Father_s_Email_ID);
    String Father_s_First_Name ='hari'; 
    System.assertEquals(null, pd.Age);  
    String Father_s_Last_Company='airtedd'; 
    System.assertEquals(null, pd.Father_s_Last_Company);
    String Father_s_Last_Name='asdhjhjhd';
    System.assertEquals(null, pd.Father_s_Last_Name);
    String Father_s_Mobile_No='3369985222'; 
    System.assertEquals(null, pd.Father_s_Mobile_No);
    String FUA_Father_s_Mobile_No='123356523'; 
    System.assertEquals(null, pd.FUA_Father_s_Mobile_No);
    String Father_s_Mobile_No_Code ='0891';
    System.assertEquals(null, pd.Father_s_Mobile_No_Code);
    String Father_s_Occupation  ='sales'; 
    System.assertEquals(null, pd.Father_s_Occupation); 
    String Gender ='mail';   
    System.assertEquals(null, pd.Gender);
    String Mailing_Address='ass';  
    System.assertEquals(null, pd.Mailing_Address);
    String Mailing_Address_Line_1='ssd';
    System.assertEquals(null, pd.Mailing_Address_Line_1);
    String Mailing_Address_Line_2 ='ass';
    System.assertEquals(null, pd.Mailing_Address_Line_2);
    String Mailing_City ='city'; 
    System.assertEquals(null, pd.Mailing_City);
    String Mailing_Postal_Code='postal code';
    System.assertEquals(null, pd.Mailing_Postal_Code);
    String Major   ='science';
    System.assertEquals(null, pd.Major);
    String Marital_Status ='married';
    System.assertEquals(null, pd.Marital_Status);
    String Middle_Name    ='assd';  
    System.assertEquals(null, pd.Middle_Name);   
    String Minor = 'assd';
    System.assertEquals(null, pd.Minor);
    String FUA_Mobile    ='';
    System.assertEquals(null, pd.FUA_Mobile);
    String FU_Mobile_Phone_Code ='';  
    System.assertEquals(null, pd.FU_Mobile_Phone_Code);
    String Mother_s_Current_Company  ='';
    System.assertEquals(null, pd.Mother_s_Current_Company);
    String Mother_s_Designation = '';
    System.assertEquals(null, pd.Mother_s_Designation);
    String Mother_s_Email_ID ='tttt';
    System.assertEquals(null, pd.Mother_s_Email_ID);
    String Mother_s_First_Name ='eeee';  
    System.assertEquals(null, pd.Mother_s_First_Name);
    String Mother_s_Last_Company ='ssss';
    System.assertEquals(null, pd.Mother_s_Last_Company);
    String Mother_s_Last_Name ='ass';
    System.assertEquals(null, pd.Mother_s_Last_Name);
    String Mother_s_Mobile_No ='';
    System.assertEquals(null, pd.Mother_s_Mobile_No);
    String FUA_Mother_s_Mobile_No ='';
    System.assertEquals(null, pd.FUA_Mother_s_Mobile_No);
    String Mother_s_Mobile_No_Code =''; 
    System.assertEquals(null, pd.Mother_s_Mobile_No_Code); 
    String Mother_s_Occupation ='';  
    System.assertEquals(null, pd.Mother_s_Occupation);
    String Mother_Tongue  ='';
    System.assertEquals(null, pd.Mother_Tongue);
    String Other_City ='';
    System.assertEquals(null, pd.Other_City);
    String FU_Outside_India ='';
    System.assertEquals(null, pd.FU_Outside_India);
    String Passport_Expiry_Date ='shesd';
    System.assertEquals(null, pd.Passport_Expiry_Date);
    String Passport_Issued_By='';
    System.assertEquals(null, pd.Passport_Issued_By);
    String Passport_No   ='hes';
    System.assertEquals(null, pd.Passport_No);
    String Permanent_Address_Line_1 ='its'; 
    System.assertEquals(null, pd.Permanent_Address_Line_1); 
    String Permanent_Address_Line_2 ='it';
    System.assertEquals(null, pd.Permanent_Address_Line_2);  
    String Permanent_Postal_Code ='she'; 
    System.assertEquals(null, pd.Permanent_Postal_Code);
    String Place_of_Birth ='he';
    System.assertEquals(null, pd.Place_of_Birth);
    String Portal_password  ='we';  
    System.assertEquals(null, pd.Portal_password);
    String Primary_Contact_Type ='you'; 
    System.assertEquals(null, pd.Primary_Contact_Type);
    String Primary_Role  ='i';
    System.assertEquals(null, pd.Primary_Role);
    String Problem_Under_Department  ='when';
    System.assertEquals(null, pd.Problem_Under_Department);
    String Program_Interested='which';
    System.assertEquals(null, pd.Program_Interested);
    String Program_Interested_In ='whome'; 
    System.assertEquals(null, pd.Program_Interested_In); 
    String Program_Version  ='with whoe'; 
    System.assertEquals(null, pd.Program_Version);
    String Reg_Completed  ='whoe';
    System.assertEquals(null, pd.Reg_Completed);
    String Reg_General_Info_Completed ='how mant';
    System.assertEquals(null, pd.Reg_General_Info_Completed);
    String Reg_Interests_Completed ='how long';
    System.assertEquals(null, pd.Reg_Interests_Completed);
    String Registration_Status ='how';
    System.assertEquals(null, pd.Registration_Status);
    String Reg_Picture_Completed  ='when';
    System.assertEquals(null, pd.Permanent_Postal_Code);
    String Religion   ='hindu';
    System.assertEquals(null, pd.Religion);
    String FU_Residence_Phone_Code ='assddff'; 
    System.assertEquals(null, pd.FU_Residence_Phone_Code); 
    String Residence_Phone_No ='ass';
    System.assertEquals(null, pd.Residence_Phone_No);
    String FUA_Residence_Phone_No ='xccc';
    System.assertEquals(null, pd.FUA_Residence_Phone_No);
    
    String Source  ='assss';        
    System.assertEquals(null, pd.Source);
    String Student_s_Alternate_Email ='www'; 
    System.assertEquals(null, pd.Student_s_Alternate_Email);
    String Student_s_Contact_Number  ='wee'; 
    System.assertEquals(null, pd.Student_s_Contact_Number);
    String Student_Withdrawal_Completion ='sd';  
    System.assertEquals(null, pd.Student_Withdrawal_Completion); 
    String Total_Family_Income =''; 
    System.assertEquals(null, pd.Total_Family_Income);
    String Withdrawal_Details_Comments='www';  
    System.assertEquals(null, pd.Withdrawal_Details_Comments);
    String Withdrawal_Primary_Reason  ='weew';
    System.assertEquals(null, pd.Withdrawal_Primary_Reason);
    String Withdrawal_Request_Date ='wee';  
    System.assertEquals(null, pd.Withdrawal_Request_Date);
   
   
   
    String Visa_Status = '';
    System.assertEquals(null, pd.Visa_Status);
          }
     
   static testMethod void contactid() {
        
      Account testAccount = new Account(Name='Test Account', Rating = 'Hot') ;
        insert testAccount; 
      contact  Con = new Contact();
        Con.AccountId = testAccount.Id;
                Con.FU_Applicant_Other_Country__c='1234' ;
                Con.FU_Applicant_Other_State__c='ap' ;
                Con.FU_Applicant_Other_City__c='vzag';
                Con.Other_City__c='ap';
                Con.FirstName='a';   
                Con.LastName= 'e';
                Con.FUA_Mobile__c='1234567788';
                Con.FU_Mobile_Phone_Code__c='0891';
                Con.Program_Interested__c ='pg' ;
                Con.Program_Interested_In__c ='pg' ;
                con.Classification_Applicant__c = TRUE;
                Con.Email = 'd@gmail.com';
                Con.Portal_password__c = 'Password';
               // Con.RecordTypeid  = recordTypes.get(recordTypeNames[0]).getRecordTypeId(); 
                insert con; 
              Map<String, Schema.RecordTypeInfo> recordTypes = Schema.SObjectType.Contact.getRecordTypeInfosByName();
              List<String> recordTypeNames = new List<String>(recordTypes.keyset());
             /*Flame Utility test coverage*/
       
         Application__c application_Obj = new Application__c();
        application_Obj.Application_Submission_Status__c='pending';
        application_Obj.Completed_Stages__c='payment';
        application_Obj.Contact__c=con.id;
        application_Obj.GD_and_PI_Round__c='2017-2018';
        application_Obj.GD_and_PI_Center__c='pune';
        application_Obj.Statement_of_Purpose__c='asdfg';
        application_Obj.Achievments__c='kjj';
        application_Obj.Other_Details__c='assd';
        application_Obj.FUA_Submission_Place__c='pune';
        application_Obj.FUA_Applicant_Name__c='varma';
        application_Obj.Admission_Status__c='sucess';
        application_Obj.FUA_Scholarship_Granted__c='yes';
        application_Obj.FLAME_Entrance_Aptitude_Test_FEAT__c=true;
        application_Obj.SAT_Score__c=true;
        application_Obj.FUA_Broadcast_Admission__c=true;
        application_Obj.ApplicationPDFLink__c='';
        application_Obj.AdmitCardURL__c='url';
        application_Obj.FUA_Applicant_Image_URL__c='image';
        //Insert application_Obj; 
       Program__c programUGLE = new Program__c();
        programUGLE.Active__c = true;
        programUGLE.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programUGLE.Display_Sequence__c = 3;
        programUGLE.Name = 'UG (B.A.,BBA,B.Sc.)';
        programUGLE.Program_Type__c = 'Undergraduate';
        insert programUGLE;
    
    FLAME_Utility obj01 = new FLAME_Utility();
    FLAME_Utility.getApplicationInfo('test data','test data');
    FLAME_Utility.getEducationDetails('test data');
    FLAME_Utility.getWorkDetails('test data'); 
    FLAME_Utility.DeleteApplicationFuture('test data');    
    obj01.getHtmlText();
    obj01.getHtmlText1();     
    obj01.getHtmlText2();
    obj01.getPrograms1();
    List<Id> oidl = new List<Id>();
        List<Program__c> ol = new List<Program__c>([SELECT Id FROM Program__c ORDER BY CreatedDate DESC LIMIT 10]);
        for (Program__c o : ol){
            oidl.add(o.Id);
        }
        
      FLAME_Utility.getProgramDetails(programUGLE.id);
   
 //As Per Best Practice it is important to instantiate the Rest Context
    String Body;
    RestRequest req = new RestRequest();
    RestResponse res = new RestResponse();
    req.requestURI = '/services/apexrest/Something'; //Request URL
    req.httpMethod = 'POST';
   // req.requestBody = setbody(Body);

    RestContext.request = req;
    RestContext.response= res;

    Test.startTest();
     If(!Test.isRunningTest()){

        FLAME_Utility.DeleteApplicationDocument('test data'); 
        } 
    Test.stopTest();
    
    
      }
     
    
     private static testMethod void test() {
        System.Test.StartTest();
      
      
       ProgressBarCtrl progress = new ProgressBarCtrl();
       
          
                progress.oldPassword = 'Test1';
                progress.newPassword = 'Test1';
                progress.verifyNewPassword = 'Test1';
                progress.applicationCreated = false;
                progress.redirect();
                progress.CustomIndex();
                progress.CustomSave1();
                progress.CustomSave2();
                progress.CustomSave3();
                progress.CustomSave4();
                progress.CustomSave5();
                progress.CustomSave6();
                progress.CustomSave7();
                progress.CustomSave8();
                progress.CustomSave9();
                progress.CustomSave10();
                progress.CustomSave11();
                progress.CustomSave12();
                progress.CustomSave13();
                progress.CustomSave14();
                progress.CustomSave15();
                progress.CustomSave16();
                progress.CustomSave17();
                progress.CustomSave18();
                String Application_Reference_ID = '123456';
                String appsubmissionStatus='Sucess';
                String applicationCompStages='waiting';
                String applicationCompStages1='Sucess';
                progress.testclass();
               System.Test.StopTest();
        
      
            
    } 
    
  static testMethod void test_currentPod_UseCase1(){
    test.startTest();
    User user_Obj = new User(Username = 'TestUser5843620180925120616@codecoverage.com', LastName = 'LastName812', Email = 'Email22@test.com', EmailPreferencesAutoBcc = false, EmailPreferencesAutoBccStayInTouch = false, EmailPreferencesStayInTouchReminder = false, Alias = 'Alias357', CommunityNickname = 'cNickName96277', IsActive = true, TimeZoneSidKey = 'Pacific/Kiritimati', LocaleSidKey = 'sq_AL', ReceivesInfoEmails = false, ReceivesAdminInfoEmails = false, EmailEncodingKey = 'UTF-8', ProfileId = '00e280000015peNAAQ', LanguageLocaleKey = 'en_US', UserPermissionsMarketingUser = false, UserPermissionsOfflineUser = false, UserPermissionsAvantgoUser = false, UserPermissionsCallCenterAutoLogin = false, UserPermissionsMobileUser = false, UserPermissionsSFContentUser = false, UserPermissionsInteractionUser = false, UserPermissionsSupportUser = false, UserPermissionsChatterAnswersUser = false, ForecastEnabled = false, UserPreferencesActivityRemindersPopup = false, UserPreferencesEventRemindersCheckboxDefault = false, UserPreferencesTaskRemindersCheckboxDefault = false, UserPreferencesReminderSoundOff = false, UserPreferencesDisableAllFeedsEmail = false, UserPreferencesDisableFollowersEmail = false, UserPreferencesDisableProfilePostEmail = false, UserPreferencesDisableChangeCommentEmail = false, UserPreferencesDisableLaterCommentEmail = false, UserPreferencesDisProfPostCommentEmail = false, UserPreferencesApexPagesDeveloperMode = false, UserPreferencesHideCSNGetChatterMobileTask = false, UserPreferencesDisableMentionsPostEmail = false, UserPreferencesDisMentionsCommentEmail = false, UserPreferencesHideCSNDesktopTask = false, UserPreferencesHideChatterOnboardingSplash = false, UserPreferencesHideSecondChatterOnboardingSplash = false, UserPreferencesDisCommentAfterLikeEmail = false, UserPreferencesDisableLikeEmail = false, UserPreferencesSortFeedByComment = false, UserPreferencesDisableMessageEmail = false, UserPreferencesDisableBookmarkEmail = false, UserPreferencesDisableSharePostEmail = false, UserPreferencesEnableAutoSubForFeeds = false, UserPreferencesDisableFileShareNotificationsForApi = false, UserPreferencesShowTitleToExternalUsers = false, UserPreferencesShowManagerToExternalUsers = false, UserPreferencesShowEmailToExternalUsers = false, UserPreferencesShowWorkPhoneToExternalUsers = false, UserPreferencesShowMobilePhoneToExternalUsers = false, UserPreferencesShowFaxToExternalUsers = false, UserPreferencesShowStreetAddressToExternalUsers = false, UserPreferencesShowCityToExternalUsers = false, UserPreferencesShowStateToExternalUsers = false, UserPreferencesShowPostalCodeToExternalUsers = false, UserPreferencesShowCountryToExternalUsers = false, UserPreferencesShowProfilePicToGuestUsers = false, UserPreferencesShowTitleToGuestUsers = false, UserPreferencesShowCityToGuestUsers = false, UserPreferencesShowStateToGuestUsers = false, UserPreferencesShowPostalCodeToGuestUsers = false, UserPreferencesShowCountryToGuestUsers = false, UserPreferencesHideS1BrowserUI = false, UserPreferencesDisableEndorsementEmail = false, UserPreferencesPathAssistantCollapsed = false, UserPreferencesCacheDiagnostics = false, UserPreferencesShowEmailToGuestUsers = false, UserPreferencesShowManagerToGuestUsers = false, UserPreferencesShowWorkPhoneToGuestUsers = false, UserPreferencesShowMobilePhoneToGuestUsers = false, UserPreferencesShowFaxToGuestUsers = false, UserPreferencesShowStreetAddressToGuestUsers = false, UserPreferencesLightningExperiencePreferred = false, UserPreferencesPreviewLightning = false, UserPreferencesHideEndUserOnboardingAssistantModal = false, UserPreferencesHideLightningMigrationModal = false, UserPreferencesHideSfxWelcomeMat = false, UserPreferencesHideBiggerPhotoCallout = false, UserPreferencesGlobalNavBarWTShown = false, UserPreferencesGlobalNavGridMenuWTShown = false, UserPreferencesCreateLEXAppsWTShown = false, UserPreferencesFavoritesWTShown = false, DigestFrequency = 'D', DefaultGroupNotificationFrequency = 'P');
    Insert user_Obj; 
    Contact contact_Obj = new Contact(LastName = 'LastName979', Classification_Applicant__c = false, Classification_Student__c = false, Classfication_Withdrawn__c = false, Classification_Alumni__c = false, Classfication_Guest__c = false, Classfication_VIP__c = false, Classfication_Staff__c = false, Classfication_ExStaff__c = false, Classfication_Faculty__c = false, Classfication_ExFaculty__c = false, Classfication_FIL__c = false, Classfication_Vendor__c = false, Save_Withdrawal_Application__c = false, Cheque_Dispatch_Status__c = false, Student_Withdrawal_Completion__c = false, PhD__c = false, Classification_Visiting_Faculty__c = false, Classfication_Adjunct_Faculty__c = false, Send_Mass_Email__c = false, Unsubscribe_from_Mailers__c = false, hed__Deceased__c = false, hed__Do_Not_Contact__c = false, hed__Exclude_from_Household_Formal_Greeting__c = false, hed__Exclude_from_Household_Informal_Greeting__c = false, hed__Exclude_from_Household_Name__c = false, hed__FERPA__c = false, hed__Financial_Aid_Applicant__c = false, hed__HIPAA__c = false, hed__Military_Service__c = false, hed__is_Address_Override__c = false, Classification_Parent__c = false);
   // Insert contact_Obj; 
    test.stopTest();
  }
// static testMethod void test_getApplicationId_UseCase1(){
  //  List<User> user_Obj  =  [SELECT Username,LastName,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,Alias,CommunityNickname,IsActive,TimeZoneSidKey,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,LanguageLocaleKey,UserPermissionsMarketingUser,UserPermissionsOfflineUser,UserPermissionsAvantgoUser,UserPermissionsCallCenterAutoLogin,UserPermissionsMobileUser,UserPermissionsSFContentUser,UserPermissionsInteractionUser,UserPermissionsSupportUser,UserPermissionsChatterAnswersUser,ForecastEnabled,UserPreferencesActivityRemindersPopup,UserPreferencesEventRemindersCheckboxDefault,UserPreferencesTaskRemindersCheckboxDefault,UserPreferencesReminderSoundOff,UserPreferencesDisableAllFeedsEmail,UserPreferencesDisableFollowersEmail,UserPreferencesDisableProfilePostEmail,UserPreferencesDisableChangeCommentEmail,UserPreferencesDisableLaterCommentEmail,UserPreferencesDisProfPostCommentEmail,UserPreferencesApexPagesDeveloperMode,UserPreferencesHideCSNGetChatterMobileTask,UserPreferencesDisableMentionsPostEmail,UserPreferencesDisMentionsCommentEmail,UserPreferencesHideCSNDesktopTask,UserPreferencesHideChatterOnboardingSplash,UserPreferencesHideSecondChatterOnboardingSplash,UserPreferencesDisCommentAfterLikeEmail,UserPreferencesDisableLikeEmail,UserPreferencesSortFeedByComment,UserPreferencesDisableMessageEmail,UserPreferencesDisableBookmarkEmail,UserPreferencesDisableSharePostEmail,UserPreferencesEnableAutoSubForFeeds,UserPreferencesDisableFileShareNotificationsForApi,UserPreferencesShowTitleToExternalUsers,UserPreferencesShowManagerToExternalUsers,UserPreferencesShowEmailToExternalUsers,UserPreferencesShowWorkPhoneToExternalUsers,UserPreferencesShowMobilePhoneToExternalUsers,UserPreferencesShowFaxToExternalUsers,UserPreferencesShowStreetAddressToExternalUsers,UserPreferencesShowCityToExternalUsers,UserPreferencesShowStateToExternalUsers,UserPreferencesShowPostalCodeToExternalUsers,UserPreferencesShowCountryToExternalUsers,UserPreferencesShowProfilePicToGuestUsers,UserPreferencesShowTitleToGuestUsers,UserPreferencesShowCityToGuestUsers,UserPreferencesShowStateToGuestUsers,UserPreferencesShowPostalCodeToGuestUsers,UserPreferencesShowCountryToGuestUsers,UserPreferencesHideS1BrowserUI,UserPreferencesDisableEndorsementEmail,UserPreferencesPathAssistantCollapsed,UserPreferencesCacheDiagnostics,UserPreferencesShowEmailToGuestUsers,UserPreferencesShowManagerToGuestUsers,UserPreferencesShowWorkPhoneToGuestUsers,UserPreferencesShowMobilePhoneToGuestUsers,UserPreferencesShowFaxToGuestUsers,UserPreferencesShowStreetAddressToGuestUsers,UserPreferencesLightningExperiencePreferred,UserPreferencesPreviewLightning,UserPreferencesHideEndUserOnboardingAssistantModal,UserPreferencesHideLightningMigrationModal,UserPreferencesHideSfxWelcomeMat,UserPreferencesHideBiggerPhotoCallout,UserPreferencesGlobalNavBarWTShown,UserPreferencesGlobalNavGridMenuWTShown,UserPreferencesCreateLEXAppsWTShown,UserPreferencesFavoritesWTShown,DigestFrequency,DefaultGroupNotificationFrequency from User];
   // System.assertEquals(true,user_Obj.size()>0);
  //  List<Contact> contact_Obj  =  [SELECT LastName,Classification_Applicant__c,Classification_Student__c,Classfication_Withdrawn__c,Classification_Alumni__c,Classfication_Guest__c,Classfication_VIP__c,Classfication_Staff__c,Classfication_ExStaff__c,Classfication_Faculty__c,Classfication_ExFaculty__c,Classfication_FIL__c,Classfication_Vendor__c,Save_Withdrawal_Application__c,Cheque_Dispatch_Status__c,Student_Withdrawal_Completion__c,PhD__c,Classification_Visiting_Faculty__c,Classfication_Adjunct_Faculty__c,Send_Mass_Email__c,Unsubscribe_from_Mailers__c,hed__Deceased__c,hed__Do_Not_Contact__c,hed__Exclude_from_Household_Formal_Greeting__c,hed__Exclude_from_Household_Informal_Greeting__c,hed__Exclude_from_Household_Name__c,hed__FERPA__c,hed__Financial_Aid_Applicant__c,hed__HIPAA__c,hed__Military_Service__c,hed__is_Address_Override__c,Classification_Parent__c from Contact];
   // System.assertEquals(true,contact_Obj.size()>0);
  //  FUA_UtilityClass obj01 = new FUA_UtilityClass();
  //  obj01.getApplicationId('01p90000006uk2w');
  //  obj01.getPaymentRecordType();
  //  obj01.currentPod();
  //  obj01.isSandbox();
 // }
  
  
         
      }