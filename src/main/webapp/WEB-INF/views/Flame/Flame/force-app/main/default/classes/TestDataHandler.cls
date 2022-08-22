@isTest(seeAllData=true)
public class TestDataHandler {

    public static void createTestData(){
        Account account = new Account();
        account.Name = 'FLAME 2016-17 Admissions';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        
        contact.Email =  'rohit63419FLAMETEST@gmail.com';        
        insert contact;
        
        FlameUniversitSettings__c data = new FlameUniversitSettings__c();
        data.Name = 'Default';
        data.AccountName__c = 'FLAME 2016-17 Admissions';
        insert data;
        
        Contact contact1 = new Contact();
        contact1.AccountId = account.Id;
        contact1.FirstName = 'Testing';
        contact1.LastName = 'Extentia';
        contact1.Email =  'rmextentia111132322@gmail.com';
        insert contact1;
        
    
        Program__c programPGB = new Program__c();
        programPGB.Active__c = true;
        programPGB.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth';
        programPGB.Display_Sequence__c = 1;
        programPGB.Name = 'Postgraduate (MBA)';
        insert programPGB;
        
        Program__c programPGC = new Program__c();
        programPGC.Active__c = true;
        programPGC.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programPGC.Display_Sequence__c = 2;
        programPGC.Name = 'Postgraduate (MBA [Communications Management])';
        insert programPGC;
        
        Program__c programUGLE = new Program__c();
        programUGLE.Active__c = true;
        programUGLE.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programUGLE.Display_Sequence__c = 3;
        programUGLE.Name = 'Undergraduate (B.A.,BBA,B.Sc.)';
        insert programUGLE;
        
        List<GD_and_PI_Round__c> lstofRounds = new List<GD_and_PI_Round__c>();
        
        GD_and_PI_Round__c gdPIRoundPGB = new GD_and_PI_Round__c();
        gdPIRoundPGB.Active__c =  true;
        gdPIRoundPGB.Display_Sequence__c =  3;
        gdPIRoundPGB.End_Date__c  = system.today() + 30;
        gdPIRoundPGB.GD_and_PI_Center__c  = 'Bangalore;Chennai;Delhi';
        gdPIRoundPGB.Name  = 'Early Decision Cycle (12th - 13th Dec 2015)';
        gdPIRoundPGB.Program__c  = programPGB.Id;
        gdPIRoundPGB.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundPGB);
        
        GD_and_PI_Round__c gdPIRoundPGC = new GD_and_PI_Round__c();
        gdPIRoundPGC.Active__c =  true;
        gdPIRoundPGC.Display_Sequence__c =  3;
        gdPIRoundPGC.End_Date__c  = system.today() + 30;
        gdPIRoundPGC.GD_and_PI_Center__c  = 'Chennai;Delhi';
        gdPIRoundPGC.Name  = 'Campus Cycle (16th - 17th Jan 2016)';
        gdPIRoundPGC.Program__c  = programPGC.Id;
        gdPIRoundPGC.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundPGC);
        
        GD_and_PI_Round__c gdPIRoundUGLE = new GD_and_PI_Round__c();
        gdPIRoundUGLE.Active__c =  true;
        gdPIRoundUGLE.Display_Sequence__c =  3;
        gdPIRoundUGLE.End_Date__c  = system.today() + 30;
        gdPIRoundUGLE.GD_and_PI_Center__c  = 'Bangalore;Chennai';
        gdPIRoundUGLE.Name  = 'Regular Cycle I (13th - 14th Feb 2016)';
        gdPIRoundUGLE.Program__c  = programUGLE.Id;
        gdPIRoundUGLE.Start_Date__c  = system.today();
        lstofRounds.add(gdPIRoundUGLE);
        
        insert lstofRounds;
        
        Application__c application = new Application__c();
        application.Achievments__c  = 'Prize winnertest';
        application.ApplicationPDFLink__c = 'https://www.dropbox.com/s/94wt6udgyljb2ac/PGB2016004126.pdf?dl=1';
        application.AdmitCardURL__c = 'https://www.dropbox.com/s/jzvmhkgjwosphhs/PGB2016004126_AdmitCard.pdf?dl=1';
        //application.Admission_Status__c  = 'Admitted';
        application.Admitted__c =  true;
        application.Applications__c  = 'Applications963963';
        application.Application_Progress__c =  100;
        application.Application_Submission_Status__c  = 'Submitted & Paid';
        application.Completed_Stages__c  = 'Program & Test;Personal Details;Education & Work;Preview Form;Payment;Admit Card;Admission Status;Application PDF;Photograph Upload;SOP;Thankyou;Applied;ThankyouDone';
        application.Contact__c  = contact.Id;
        application.FLAME_Entrance_Aptitude_Test_FEAT__c =  true;
        application.FUA_All_Documents_Verified__c =  false;
        application.FUA_Applicant_Name__c  = 'gfghf';
        application.FUA_SOP_Submitted__c =  false;
        application.FUA_Submission_Date__c  = system.today();
        application.FUA_Submission_Place__c  = 'testPlace';
        application.FUI_GD_and_PI_Round__c  = gdPIRoundUGLE.id;
        application.GD_and_PI_Center__c  = 'Chennai';
        application.GD_and_PI_Round__c  = 'Regular Cycle I (13th - 14th Feb 2016)';
        application.GD_Score1__c =  50;
        application.GD_Score3__c =  60;
        application.Median__c =  false;
        application.Other_Details__c  = 'Big winnertest';
        application.PI_Score1__c =  50;
        application.PI_Score2__c =  50;
        application.PI_Score3__c =  80;
        application.Program__c  = programPGC.Id;
        
        application.SAT_Score__c =  true;
        application.Statement_of_Purpose__c  = 'sdfsadfsadfsd';
        application.X10th_Xth_Score_PGB__c =  43;
        application.X12th_Xth_Score_PGB__c =  43;
        insert application;
        
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
        education.Program__c =  'Postgraduate (MBA)';
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
        
        insert educations;
        
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
        
        insert lstOfCompetitionExams;
        
       
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
        insert work;
            
        FUA_Applicant_Document__c document = new FUA_Applicant_Document__c();
        document.Application__c = application.Id;
        document.Description__c = 'sdfad';
        document.Document_Link__c = 'https://www.dropbox.com/s/az5y9csjko86wu0/PGB2016004126__docs.css?dl=0';
        document.Document_Type__c = 'Transcripts';
        document.Is_Verified__c =  false;
        document.Name = 'PGB2016004126__docs.css';
        document.Path__c = '/Salesforce Documents/Contacts/PGB2016004126/PGB2016004126__docs.css';
        insert document;
        
        Attachment attach = new Attachment();
        attach.ParentId = application.id;
        attach.Name = application.Application_Reference_ID__c + '.pdf';
        attach.Body = Blob.valueOf('UNIT.TEST');
        insert attach;
        
        Case myCase = new Case();
        myCase.SuppliedEmail = contact.Email;
        mycase.Origin = 'Web';
        myCase.Status = 'New';
        insert mycase;
        
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
        
        insert docs;
        
        
        
      
    }
}