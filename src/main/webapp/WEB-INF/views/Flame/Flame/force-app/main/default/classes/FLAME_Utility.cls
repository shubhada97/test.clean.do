/*
* FLAME_Utility class
*
* Summary:  This class contains all SOQL required for the FLame_Community Class.
* Created By: Kartheeka
* Created Date: 12/06/2017
*
*/

Global class FLAME_Utility {

 /* Contact Information */
 public static contact getConactInfo(String ContactId, String UserEmail){
      List<Contact>  Cont = new list<Contact>();

    if(ContactId!=null) {
       Cont = new list<Contact>([select id,Name, Mother_s_First_Name__c,Registration_Status__c,(select id,Name,Application_Submission_Status__c,Completed_Stages__c,Admission_Status__c from  Applications__r), Mother_s_Mobile_No_Code__c,
                      Mother_s_Mobile_No__c,MobilePhone,Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
                      Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
                      Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
                      Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
                      Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
                      Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
                      FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
                      FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
                      Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c,HousingBuilding__c,HousingBuilding__r.Name,Hsg_Housing_Room__c from contact where Id=:ContactId Limit 1]); }
    else{
      Cont = new list<Contact>([select id,Name, Mother_s_First_Name__c,Registration_Status__c,(select id,Completed_Stages__c,Admission_Status__c from Applications__r),Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,MobilePhone,
                      Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
                      Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
                      Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
                      Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
                      Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
                      Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
                      FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
                      FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
                      Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c,HousingBuilding__c,HousingBuilding__r.Name,Hsg_Housing_Room__c from contact where Email=:UserEmail And RecordType.developername='FU_Applicant' Limit 1]);

    }
     return Cont[0];
 }

 /* Application Information */

 public static List<Application__c> getApplicationInfo(String ContactId, String AppId){
      List<Application__c>  app = new list<Application__c>();

      if(ContactId!=null)
        app =new List<Application__c>([Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
                                      Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_SOP_Submitted__c,Do_you_need_on_campus_accommodation__c,
                                      FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,
                                      FUA_Applicant_Image_URL__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,ACT_score__c,
                                      Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,Old_SAT_Structure__c,
                                      Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Preference_Housing_Payment_Recived__c, Housing_Preference_Submitted__c,Housing_Description__c ,Enrollment_Deposit_Amount_Paid__c,Application_Progress__c,
                                      (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c 
                                      WHERE Contact__c =:ContactId  LIMIT 1]);                    
      else if(AppId!=null)
        app =new List<Application__c>([Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name,Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,
                                      Program__c,GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_SOP_Submitted__c,Do_you_need_on_campus_accommodation__c,
                                      FUA_Applicant_Name__c,Admission_Status__c,FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,ACT_score__c,
                                      FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,Enrollment_Deposit_Amount_Paid__c,Application_Progress__c,
                                      Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,Old_SAT_Structure__c,
                                      Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Preference_Housing_Payment_Recived__c, Housing_Preference_Submitted__c,Housing_Description__c  from Application__c 
                                      WHERE Id =:AppId  LIMIT 1]);   

      return app;
 }  
 
 Public static List<FU_Education_Details__c> getEducationDetails(String ContactId){
    return [select Id,Name,FU_Year_Class__c,FUA_Other_City__c,FUA_Education_City__c,FUA_Other_State__c,FUA_Institution_School__c,FUA_Degree_Certificate__c,FUA_Major_Subjects__c,FUA_Board_University__c,FUA_Year_of_Completion__c,FUA_CGPA_Actual__c,FUA_CGPA_Out_Of__c,FUA_Education_Country__c,FUA_Education_State__c from FU_Education_Details__c where Application__r.Contact__c =: ContactId ORDER BY Display_Sequence__c]; //ContactId
 } 
   
 Public static List<FUA_Work_Details__c> getWorkDetails(String ContactId){ 
    return  [Select Id,Name,FromDate__c,Todate__c,FUA_Work_City__c , FUA_Company__c,FUA_Work_Country__c, FUA_CTC_INR__c, FUA_Designation__c  ,FUA_Function__c ,FUA_Reporting_Person_Details__c, FUA_Work_State__c,FUA_Other_City1__c, FUA_Type__c, FUA_Your_Responsibilities__c from FUA_Work_Details__c where Application__r.Contact__c =:ContactId Limit 1];
 }
   
 /* Index pages Inforamtion */
   
 public String getHtmlText(){
     return [Select Body From Document Where Name = 'IndexPageBeforeThankYou'].Body.toString();
 }
    
 public String getHtmlText1(){
     return [Select Body From Document Where Name = 'IndexPageAfterThankYou'].Body.toString();
 }
  
 public String getHtmlText2(){
       return [Select Body From Document Where Name = 'Index Page After Shortlisted'].Body.toString();
 }
 
 public static Program__c getProgramDetails(String ProgramId){
    Program__c prog = [Select ID,Name,Semester1_Fee_Amount__c,Semester2_Fee_Amount__c,Enrollment_Deposit_Amount__c,Semester_2_Fee_Disc__c From Program__c Where ID =: ProgramId]; 
    return prog;      
 }  
 
 public List<SelectOption> getPrograms1()
 {
      List<SelectOption> options = new List<SelectOption>();
      List<Program__c> ListOfPrograms = [SELECT Active__c,Display_Sequence__c,Name From Program__c Order WHERE Active__c = True ORDER BY Display_Sequence__c];
    
      for(Program__c programToItrate : ListOfPrograms){
            options.add(new SelectOption(programToItrate.ID,programToItrate.Name));
      }
      return options;
 } 
  
    
    @future(callout=true)
      public static void DeleteApplicationFuture(String path_lower){
          try{
                path_lower=path_lower.subString(1,path_lower.length());
                String Body ='{"path": "';
                Body = Body + path_lower;
                Body = Body + '"}';
                system.debug('Body  -- > ' +Body);   
                system.debug('path -> ' +path_lower);
                system.debug('path -> ' + path_lower);
                string httpURL = 'https://api.dropboxapi.com/2/files/delete_v2';
                HttpRequest req = new HttpRequest();
                req.setEndpoint(httpURL);
                req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
                req.setHeader('Content-Type','application/json');
                req.setbody(Body);
                req.setMethod('POST');
                req.setTimeout(60000);
                Http h = new Http();
                HttpResponse res = h.send(req);
                string resp = res.getBody();
          }
          catch(Exception e){}
    }
   @RemoteAction   
  global static String DeleteApplicationDocument(String path){
        path = path.subString(1,path.length());
        system.debug('path -> ' + path);
        string httpURL = 'https://api.dropboxapi.com/1/fileops/delete';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(httpURL);
        req.setbody('root=auto&path='+path);
        req.setHeader('Authorization', 'Bearer ' + Label.DropboxAPI);
        req.setMethod('POST');
        req.setTimeout(60000);
        Http h = new Http();
        HttpResponse res = h.send(req);
        string resp = res.getBody();
        return resp;
    }
        
      
    

}