@isTest(seeAllData=false)
public class ProgramTestDataHandlerNew {
   public static void ProgramTestData(){
        Account account = new Account();
        account.Name = 'UploadDocTesting';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        contact.Email =  'rohit63419FLAMETEST@gmail.com';
        insert contact;
        
        Contact contact1 = new Contact();
        contact1.AccountId = account.Id;
        contact1.FirstName = 'Testing';
        contact1.LastName = 'Extentia';
        contact1.Email =  'rmextentia1111@gmail.com';
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.AccountId = account.Id;
        contact2.FirstName = 'Testing';
        contact2.LastName = 'Extentia';
        contact2.Email =  'rmextentia0001@gmail.com';
        insert contact2;
        
        Contact contact3 = new Contact();
        contact3.AccountId = account.Id;
        contact3.FirstName = 'Testing';
        contact3.LastName = 'gaurav';
        contact3.Email =  'gaurav@gmail.com';
        insert contact3;        
        
        Profile profile = [SELECT id from Profile where Name='FLAME- Applicant Community'];
        
        User user = new User();
        user.Alias =  'rpati';
        user.CommunityNickname =  'rohit.rohit63419Test@gmail.com';
        user.ContactId =  contact.Id;
        user.Country =  'India';
        //user.CountryCode =  'IN';
        user.DefaultGroupNotificationFrequency =  'N';
        user.DigestFrequency =  'N';
        user.Email =  'rohit63419FLAMETEST@gmail.com';
        user.EmailEncodingKey =  'ISO-8859-1';
        user.EmailPreferencesAutoBcc =  true;
        user.EmailPreferencesAutoBccStayInTouch =  false;
        user.EmailPreferencesStayInTouchReminder =  true;
        user.FirstName =  'Rohit';
        user.ForecastEnabled =  false;
        user.IsActive =  true;
        user.LanguageLocaleKey =  'en_US';
        user.LastName =  'Patil';
        user.LocaleSidKey =  'en_US';
        user.ProfileId =  profile.Id;
        user.ReceivesAdminInfoEmails =  false;
        user.ReceivesInfoEmails =  false;
        user.TimeZoneSidKey =  'GMT';
        user.Username =  'rohit63419Test@gmail.com';
        user.CompanyName =  null;
        insert user;
        
        User user1 = new User();
        user1.Alias =  'test2';
        user1.CommunityNickname =  'rohit.rmextentia1111@gmail.com';
        user1.ContactId =  contact1.Id;
        user1.Country =  'India';
        //user1.CountryCode =  'IN';
        user1.DefaultGroupNotificationFrequency =  'N';
        user1.DigestFrequency =  'N';
        user1.Email =  'rmextentia1111@gmail.com';
        user1.EmailEncodingKey =  'ISO-8859-1';
        user1.EmailPreferencesAutoBcc =  true;
        user1.EmailPreferencesAutoBccStayInTouch =  false;
        user1.EmailPreferencesStayInTouchReminder =  true;
        user1.FirstName =  'Rohit';
        user1.ForecastEnabled =  false;
        user1.IsActive =  true;
        user1.LanguageLocaleKey =  'en_US';
        user1.LastName =  'Patil';
        user1.LocaleSidKey =  'en_US';
        user1.ProfileId =  profile.Id;
        user1.ReceivesAdminInfoEmails =  false;
        user1.ReceivesInfoEmails =  false;
        user1.TimeZoneSidKey =  'GMT';
        user1.Username =  'rmextentia1111@gmail.com';
        user1.CompanyName =  null;
        insert user1;
        
        User user2 = new User();
        user2.Alias =  'test1';
        user2.CommunityNickname =  'rohit.rmextentia0001@gmail.com';
        user2.ContactId =  contact2.Id;
        user2.Country =  'India';
        //user2.CountryCode =  'IN';
        user2.DefaultGroupNotificationFrequency =  'N';
        user2.DigestFrequency =  'N';
        user2.Email =  'rmextentia0001@gmail.com';
        user2.EmailEncodingKey =  'ISO-8859-1';
        user2.EmailPreferencesAutoBcc =  true;
        user2.EmailPreferencesAutoBccStayInTouch =  false;
        user2.EmailPreferencesStayInTouchReminder =  true;
        user2.FirstName =  'Rohit';
        user2.ForecastEnabled =  false;
        user2.IsActive =  true;
        user2.LanguageLocaleKey =  'en_US';
        user2.LastName =  'Patil';
        user2.LocaleSidKey =  'en_US';
        user2.ProfileId =  profile.Id;
        user2.ReceivesAdminInfoEmails =  false;
        user2.ReceivesInfoEmails =  false;
        user2.TimeZoneSidKey =  'GMT';
        user2.Username =  'rmextentia0001@gmail.com';
        user2.CompanyName =  null;
        insert user2;
        
        User user3 = new User();
        user3.Alias =  'test3';
        user3.CommunityNickname =  'gaurav.rmextentia0001@gmail.com';
        user3.ContactId =  contact3.Id;
        user3.Country =  'India';
        //user2.CountryCode =  'IN';
        user3.DefaultGroupNotificationFrequency =  'N';
        user3.DigestFrequency =  'N';
        user3.Email =  'rmextentia0001@gmail.com';
        user3.EmailEncodingKey =  'ISO-8859-1';
        user3.EmailPreferencesAutoBcc =  true;
        user3.EmailPreferencesAutoBccStayInTouch =  false;
        user3.EmailPreferencesStayInTouchReminder =  true;
        user3.FirstName =  'Rohit';
        user3.ForecastEnabled =  false;
        user3.IsActive =  true;
        user3.LanguageLocaleKey =  'en_US';
        user3.LastName =  'Agrawal';
        user3.LocaleSidKey =  'en_US';
        user3.ProfileId =  profile.Id;
        user3.ReceivesAdminInfoEmails =  false;
        user3.ReceivesInfoEmails =  false;
        user3.TimeZoneSidKey =  'GMT';
        user3.Username =  'gaurav@gmail.com';
        user3.CompanyName =  null;
        insert user3;        
        
        Program__c programPGB = new Program__c();
        programPGB.Active__c = true;
        programPGB.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth';
        programPGB.Display_Sequence__c = 1;
        programPGB.Name = 'Postgraduate (ENTPR)';
        programPGB.Program_Type__c = 'Postgraduate';
        insert programPGB;
        
        /*Program__c programPGBinactive = new Program__c();
        programPGBinactive.Active__c = false;
        programPGBinactive.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth';
        programPGBinactive.Display_Sequence__c = 4;
        programPGBinactive.Name = 'Postgraduate (ENTPR)';
        insert programPGBinactive;*/
        
        Program__c programPGC = new Program__c();
        programPGC.Active__c = true;
        programPGC.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programPGC.Display_Sequence__c = 2;
        programPGC.Program_Type__c = 'Postgraduate';
        programPGC.Name = 'Postgraduate (MBA [Communications Management])';
        insert programPGC;
        
        Program__c programUGLE = new Program__c();
        programUGLE.Active__c = true;
        programUGLE.Dependent_Years__c = '10/Xth;11/XIth;12/XIIth;Bachelors / Undergraduate;Masters / Postgraduate;Graduate Institution';
        programUGLE.Display_Sequence__c = 3;
        programUGLE.Name = 'UG (B.A.,BBA,B.Sc.)';
        programUGLE.Program_Type__c = 'Undergraduate';
        insert programUGLE;
        
        List<GD_and_PI_Round__c> lstofRounds = new List<GD_and_PI_Round__c>();
        
        GD_and_PI_Round__c gdPIRoundPGB = new GD_and_PI_Round__c();
        gdPIRoundPGB.Active__c =  true;
        gdPIRoundPGB.Display_Sequence__c =  3;
        gdPIRoundPGB.End_Date__c  = system.today() + 30;
        gdPIRoundPGB.GD_and_PI_Center__c  = 'Bangalore;Chennai;Delhi';
        gdPIRoundPGB.Name  = 'Regular Cycle I (13th - 14th Feb 2016)';
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
        application.Admission_Status__c  = 'Admitted';
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
        application.Program__c  = programUGLE.Id;
        application.SAT_Score__c =  true;
        application.Statement_of_Purpose__c  = 'sdfsadfsadfsd';
        application.X10th_Xth_Score_PGB__c =  43;
        application.X12th_Xth_Score_PGB__c =  43;
        insert application;
        
        Application__c application1 = new Application__c();
        application1.Achievments__c  = 'Prize winnertest';
        application1.Admission_Status__c  = 'Admitted';
        application1.Admitted__c =  true;
        application1.Applications__c  = 'Applications9639639';
        application1.Application_Progress__c =  100;
        application1.Application_Submission_Status__c  = 'Submitted & Paid';
        application1.Completed_Stages__c  = 'Program & Test;Personal Details;Education & Work;Preview Form;Payment;Admit Card;Admission Status;Application PDF;Photograph Upload;SOP;Thankyou;Applied;ThankyouDone';
        application1.Contact__c  = contact2.Id;
        application1.FLAME_Entrance_Aptitude_Test_FEAT__c =  false;
        application1.FUA_All_Documents_Verified__c =  false;
        application1.FUA_Applicant_Name__c  = 'gfghf';
        application1.FUA_SOP_Submitted__c =  false;
        application1.FUA_Submission_Date__c  = system.today();
        application1.FUA_Submission_Place__c  = 'testPlace';
        application1.FUI_GD_and_PI_Round__c  = gdPIRoundPGB.id;
        application1.GD_and_PI_Center__c  = 'Pune';
        application1.GD_and_PI_Round__c  = 'Regular Cycle II (23rd - 24th Apr 2016)';
        application1.GD_Score1__c =  50;
        application1.GD_Score3__c =  60;
        application1.Median__c =  false;
        application1.Other_Details__c  = 'Big winnertest';
        application1.PI_Score1__c =  50;
        application1.PI_Score2__c =  50;
        application1.PI_Score3__c =  80;
        application1.Program__c  = programPGB.Id;
        application1.SAT_Score__c =  false;
        application1.Statement_of_Purpose__c  = 'sdfsadfsadfsd';
        application1.X10th_Xth_Score_PGB__c =  43;
        application1.X12th_Xth_Score_PGB__c =  43;
        insert application1;
        
        List<Competition_Exam_Details__c> lstOfCompetitionExams = new LisT<Competition_Exam_Details__c>();
        
        Competition_Exam_Details__c CED3 = new Competition_Exam_Details__c();
        CED3.Name = 'CAT';
        CED3.Result_Awaited__c = TRUE;
        CED3.Competitive_Exams__c = 'CAT';
        CED3.Registration_No__c = 'TEST1';
        CED3.Application__c = application1.ID;
        CED3.Program__c='Postgraduate (ENTPR)';
        //CED3.RecordTypeID='012N00000000lWe';
        //lstOfCompetitionExams.add(CED1);
        insert CED3;        
        
        Competition_Exam_Details__c CED1 = new Competition_Exam_Details__c();
        CED1.Name = 'CAT';
        CED1.Result_Awaited__c = TRUE;
        CED1.Competitive_Exams__c = 'CAT';
        CED1.Registration_No__c = 'TEST1';
        CED1.Application__c = application.ID;
        CED1.Program__c='Postgraduate (ENTPR)';
        //CED1.RecordTypeID='012N00000000lWe';
        //lstOfCompetitionExams.add(CED1);
        insert CED1;
        
        Competition_Exam_Details__c CED2 = new Competition_Exam_Details__c();
        CED2.Name = 'MAT';
        CED2.Result_Awaited__c = TRUE;
        CED2.Competitive_Exams__c = 'MAT';
        CED2.Registration_No__c = 'TEST2';
        CED2.Application__c = application.ID;
        CED2.Program__c='Postgraduate (ENTPR)';
        //CED2.RecordTypeID='012N00000000lWe';
        //lstOfCompetitionExams.add(CED2);
        insert CED2;
        
        //insert lstOfCompetitionExams;
               
        Competition_Exam_Details__c examDetails= new Competition_Exam_Details__c();
        examDetails.Application__c=application.Id;
        examDetails.Competitive_Exams__c='SAT EXAM';
        examDetails.Name= 'SAT EXAM';
        examDetails.SAT_Exam_Date_mm_yyyy__c= '03/1992';
        examDetails.Math__c= 56;
        examDetails.Writing__c= 65;
        examDetails.Critical_Reading__c= 45;
        examDetails.Program__c='UG (B.A.,BBA,B.Sc.)';
        //examDetails.RecordTypeID='012N00000000lWP';
        examDetails.SAT__c=true;
        examDetails.FEAT__c=false;
        insert examDetails; 
        
        Competition_Exam_Details__c FEAT = new Competition_Exam_Details__c();
        FEAT.Name = 'FEAT';
        FEAT.Application__c = application.Id;
        FEAT.Program__c = 'UG (B.A.,BBA,B.Sc.)';
        FEAT.FEAT__c = TRUE;
        //FEAT.RecordTypeID = '012N00000000lWZ';
        Insert FEAT;
    }

}