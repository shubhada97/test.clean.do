@isTest
private class Flamescholarscontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Contact contact_Obj = new Contact(LastName = 'LastName429', FirstName = 'First574', MobilePhone = '54343-58459', Email = 'Email38@test.com', HasOptedOutOfEmail = false, Gender__c = 'Male', Classification_Applicant__c = false, Classification_Student__c = false, Classfication_Withdrawn__c = false, Classification_Alumni__c = false, Classfication_Guest__c = false, Classfication_VIP__c = false, Classfication_Staff__c = false, Classfication_ExStaff__c = false, Classfication_Faculty__c = false, Classfication_ExFaculty__c = false, Classfication_FIL__c = false, Classfication_Vendor__c = false, FU_Applicant_Mailing_City__c = 'None', FU_Applicant_Mailing_Country__c = 'India', FU_Applicant_Mailing_State__c = 'None', FU_Applicant_Other_City__c = 'None', FU_Applicant_Other_Country__c = 'India', FU_Applicant_Other_State__c = 'None', FU_Mobile_Phone_Code__c = 'Afganistan(+93)', FU_Outside_India__c = 'FU_Ou844', FU_Residence_Phone_Code__c = 'Andorra  (+376)', Father_s_Current_Company__c = 'Fathe567', Father_s_Designation__c = 'Fathe704', Father_s_Email_ID__c = 'Email108@test.com', Father_s_First_Name__c = 'Fathe223', Father_s_Last_Company__c = 'Fathe735', Father_s_Last_Name__c = 'Fathe472', Father_s_Mobile_No_Code__c = 'Andorra      (+376)', Father_s_Mobile_No__c = '54343-77364', Father_s_Occupation__c = 'Working', Mailing_Address_Line_1__c = '115', Mailing_Address_Line_2__c = '116', Mailing_Address__c = 'Same as above', Mailing_City__c = 'Maili543', Mailing_Postal_Code__c = 'Maili536', Marital_Status__c = 'None', Middle_Name__c = 'Middl196', Mother_Tongue__c = 'Mothe912', Mother_s_Current_Company__c = 'Mothe745', Mother_s_Designation__c = 'Mothe222', Mother_s_Email_ID__c = 'Email125@test.com', Mother_s_First_Name__c = 'Mothe269', Mother_s_Last_Company__c = 'Mothe202', Mother_s_Last_Name__c = 'Mothe683', Mother_s_Mobile_No_Code__c = 'Andorra    (+376)', Mother_s_Mobile_No__c = '54343-86531', Mother_s_Occupation__c = 'Working', Other_City__c = 'Other687', Other__c = 'Other__c179', Passport_Expiry_Date__c = Date.today(), Passport_Issued_By__c = 'Passp636', Passport_No__c = 'Passp736', Permanent_Address_Line_1__c = '137', Permanent_Address_Line_2__c = '138', Permanent_Postal_Code__c = 'Perma337', Place_of_Birth__c = 'Place170', Program_Interested_In__c = 'Progr585', Program_Interested__c = 'Undergraduate', Registration_Status__c = 'Registered', Religion__c = 'None', Residence_Phone_No__c = '54343-13078', Source__c = 'None', Total_Family_Income__c = 'None', FUA_Mobile__c = 'FUA_M828', FUA_Mother_s_Mobile_No__c = 'FUA_M258', FUA_Residence_Phone_No__c = 'FUA_R354', Save_Withdrawal_Application__c = false, Cheque_Dispatch_Status__c = false, Student_Withdrawal_Completion__c = false, PhD__c = false, Classification_Visiting_Faculty__c = false, Classfication_Adjunct_Faculty__c = false, Send_Mass_Email__c = false, Unsubscribe_from_Mailers__c = false, hed__Deceased__c = false, hed__Do_Not_Contact__c = false, hed__Exclude_from_Household_Formal_Greeting__c = false, hed__Exclude_from_Household_Informal_Greeting__c = false, hed__Exclude_from_Household_Name__c = false, hed__FERPA__c = false, hed__Financial_Aid_Applicant__c = false, hed__HIPAA__c = false, hed__Military_Service__c = false, hed__is_Address_Override__c = false, Classification_Parent__c = false);
  //  Insert contact_Obj; 
    Contact_Education__c contact_education_Obj = new Contact_Education__c(Name = 'Name533', Contact__c = contact_Obj.id, Percent_CGPA__c = 16, Percent_CGPA_Out_of__c = '4', Board_University__c = 'STATE BOARD', Education_Country__c = 'Afghanistan', Education_State__c = 'Andaman and Nicobar Islands', Degree_Certificate__c = 'Degre465', Institution_School__c = 'Insti781', Major_Subjects__c = 'Major313', Year_Class__c = '10/Xth', Year_of_Completion__c = '2017', Institution_Name__c = 'Asian Institute of Management', Education_City__c = 'None', Education_Other_City__c = 'Educa972', Education_Other_State__c = 'Educa527');
   // Insert contact_education_Obj; 
    Application__c application = new Application__c(Application_Submission_Status__c='pending',Completed_Stages__c='payment',Contact__c=contact_Obj.id,GD_and_PI_Round__c='2017-2018',
        GD_and_PI_Center__c='pune', Statement_of_Purpose__c='asdfg',Achievments__c='kjj',Other_Details__c='assd',  FUA_Submission_Place__c='pune',
        FUA_Applicant_Name__c='varma',Admission_Status__c='sucess', FUA_Scholarship_Granted__c='yes', FLAME_Entrance_Aptitude_Test_FEAT__c=true,SAT_Score__c=true, FUA_Broadcast_Admission__c=true,ApplicationPDFLink__c='',AdmitCardURL__c='url',
        FUA_Applicant_Image_URL__c='image');
     //   Insert application;
      Attachment attach = new Attachment();
        attach.ParentId = application.id;
        attach.Name = application.Application_Reference_ID__c + '.pdf';
        attach.Body = Blob.valueOf('UNIT.TEST');
       // insert attach;    
    test.stopTest();
  }
  static testMethod void test_submit_UseCase1(){
    List<Contact> contact_Obj  =  [SELECT Id,LastName,FirstName,MailingAddress,MobilePhone,Email,Gender__c,FU_Applicant_Mailing_City__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Other_City__c,FU_Applicant_Other_Country__c,FU_Applicant_Other_State__c,FU_Mobile_Phone_Code__c,FU_Outside_India__c,FU_Residence_Phone_Code__c,Father_s_Current_Company__c,Father_s_Designation__c,Father_s_Email_ID__c,Father_s_First_Name__c,Father_s_Last_Company__c,Father_s_Last_Name__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c,Father_s_Occupation__c,Mailing_Address_Line_1__c,Mailing_Address_Line_2__c,Mailing_Address__c,Mailing_City__c,Mailing_Postal_Code__c,Marital_Status__c,Middle_Name__c,Mother_Tongue__c,Mother_s_Current_Company__c,Mother_s_Designation__c,Mother_s_Email_ID__c,Mother_s_First_Name__c,Mother_s_Last_Company__c,Mother_s_Last_Name__c,Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,Mother_s_Occupation__c,Other_City__c,Other__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Passport_No__c,Permanent_Address_Line_1__c,Permanent_Address_Line_2__c,Permanent_Postal_Code__c,Place_of_Birth__c,Program_Interested_In__c,Program_Interested__c,Registration_Status__c,Religion__c,Residence_Phone_No__c,Source__c,Total_Family_Income__c,FUA_Mobile__c,FUA_Mother_s_Mobile_No__c,FUA_Residence_Phone_No__c from Contact];
    System.assertEquals(false,contact_Obj.size()>0);
    List<Contact_Education__c> contact_education_Obj  =  [SELECT Id,Name,Contact__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Board_University__c,Education_Country__c,Education_State__c,Degree_Certificate__c,Institution_School__c,Major_Subjects__c,Year_Class__c,Year_of_Completion__c,Institution_Name__c,Education_City__c,Education_Other_City__c,Education_Other_State__c from Contact_Education__c];
    System.assertEquals(false,contact_education_Obj.size()>0);
    List<Application__c> Application_Obj  =  [Select id,Name,Contact__r.id,Program__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Applicant_Name__c,FUA_Submission_Place__c,
    FUA_Submission_Date__c  from  Application__c where  contact__c=: contact_Obj limit 100 ];
    System.assertEquals(false,Application_Obj.size()>0);
    List<Attachment> att = [Select id, name from Attachment where parentid = :Application_Obj and name = :'test.pdf'];
   // System.assertEquals(att[0].name, 'test.pdf');
    PageReference pageRef = Page.Flame_scholars_page;
    pageRef.getParameters().put('contactId','0030K00001lr4l3');
    pageRef.getParameters().put('status','a012800000c58WI');
    Test.setCurrentPage(pageRef);
    Flamescholarscontroller obj01 = new Flamescholarscontroller();
    obj01.profileurl = 'test data';
    obj01.contacts = contact_Obj;
    obj01.educations = contact_education_Obj;
    obj01.applications = new List<Application__c>();
    obj01.application = new Application__c();
    obj01.displayPopUp = false;
    obj01.contactId = '0030K00001lr4l3';
   
    obj01.contactlist = contact_Obj;
    obj01.edulist = contact_education_Obj;
    obj01.applications1 = new List<Application__c>();
    obj01.newApplicationId = 'a012800000c58WI';
   // obj01.submit();
   // obj01.closePopup();
  }
 
}