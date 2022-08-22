@isTest(seeAllData=false)
private class PersonalDetail_Test {
  static void test_PersonalDetail() {
     System.Test.startTest();    
  PersonalDetails pd = New PersonalDetails();
    String Contactid='';
    String Salutation='mail';
    String FirstName='varma';
    String LastName='kartheek';
    String ConEmail='kartheek@gmail.com';
     
    String Alternate_Email_ID ='kartheek@gmail.com';
    String Analytics_Registration_Status  ='complete';
    String FU_Applicant_Mailing_City ='pune'; 
    String FU_Applicant_Mailing_Country='india';   
    String FU_Applicant_Mailing_State ='mh';
    String FU_Applicant_Other_City ='pune';   
    String FU_Applicant_Other_Country ='india';
    String FU_Applicant_Other_State ='mh';
    String Are_you_an_Indian ='yes';
      
    String Cheque_Dispatch_Status ='sucess';
    String Classfication_ExFaculty ='dsfs'; 
    String Classfication_ExStaff ='yes'; 
    String Classfication_Faculty ='yes';
    String Classfication_FIL  ='asdd';
    String Classfication_Guest ='varma';
    String Classfication_Staff ='somi';   
    String Classfication_Vendor ='hari';  
    String Classfication_VIP  ='vvip';
    String Classfication_Withdrawn ='withdeaw';
    String Classification_Alumni ='alumi'; 
    String Classification_Applicant ='varma'; 

   System.assertEquals(null, pd.Contactid);
   System.assertEquals(null, pd.Salutation);
   System.assertEquals(null, pd.FirstName);
   System.assertEquals(null, pd.LastName);
   System.assertEquals(null, pd.ConEmail);
   
   System.assertEquals(null, pd.Alternate_Email_ID);
   System.assertEquals(null, pd.Analytics_Registration_Status);
    System.assertEquals(null, pd.Are_you_an_Indian);
    System.assertEquals(null, pd.FU_Applicant_Other_State);
    System.assertEquals(null, pd.FU_Applicant_Other_Country);
    System.assertEquals(null, pd.FU_Applicant_Other_City);
    System.assertEquals(null, pd.FU_Applicant_Mailing_State);
    System.assertEquals(null, pd.FU_Applicant_Mailing_Country);
    System.assertEquals(null, pd.FU_Applicant_Mailing_City);
    
    System.assertEquals(null, pd.Classfication_ExStaff); 
    System.assertEquals(null, pd.Classfication_Faculty);
    System.assertEquals(null, pd.Classfication_FIL);
    System.assertEquals(null, pd.Classfication_Guest);
    System.assertEquals(null, pd.Classfication_Staff);
    System.assertEquals(null, pd.Classfication_Vendor);
    System.assertEquals(null, pd.Classfication_VIP);
    System.assertEquals(null, pd.Classfication_Withdrawn);
    System.assertEquals(null, pd.Classification_Alumni);
    System.assertEquals(null, pd.Classification_Applicant);
    System.assertEquals(null, pd.Classfication_ExFaculty);
    System.assertEquals(null, pd.Cheque_Dispatch_Status);
      
        
        
   System.Test.stopTest(); 
 }
}