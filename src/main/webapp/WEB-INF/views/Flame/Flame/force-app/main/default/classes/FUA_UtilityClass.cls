public with sharing class FUA_UtilityClass{
    
  
    public contact getcontactId(Id userID){
    Contact con = new contact();
    try{
    User objUser = [Select Id,ContactId from User where Id = : userID Limit 1];
    con = [select id,Name, Mother_s_First_Name__c,Registration_Status__c,(select id,Name,Application_Submission_Status__c,Completed_Stages__c,Admission_Status__c from  Applications__r), Mother_s_Mobile_No_Code__c,
                      Mother_s_Mobile_No__c,MobilePhone,Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
                      Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
                      Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
                      Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
                      Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
                      Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
                      FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
                      FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
                      Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c,HousingBuilding__c,HousingBuilding__r.Name,Hsg_Housing_Room__c from contact  Where Id = :objUser.ContactId Limit 1];
  
    }catch(Exception ex){
    
    System.debug('Error at '+ex.getStackTraceString());
    }
    return con;
    
    }
  
    public Application__c getApplicationId(Id userID){
        
        Application__c userApplication = new Application__c();
        try{
            
            User objUser = [Select Id,ContactId from User where Id = : userID Limit 1];
            
            Contact objContact = [Select Id, Name From Contact Where Id = :objUser.ContactId Limit 1];
            
            userApplication = [Select Id,Name,Application_Submission_Status__c,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name, Program__r.Program_Type__c,Contact__c,GD_and_PI_Round__c,Program__r.Enrollment_Deposit_Amount__c,
                                      Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_SOP_Submitted__c,Do_you_need_on_campus_accommodation__c,Program__r.Semester1_Fee_Amount__c,
                                      FUA_Applicant_Name__c,Admission_Status__c, FUA_Scholarship_Granted__c, FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c, FUA_Broadcast_Admission__c,ApplicationPDFLink__c,AdmitCardURL__c,Program__r.Semester2_Fee_Amount__c,
                                      FUA_Applicant_Image_URL__c,FLM_Accepetoffer__c,FLM_Declineoffer__c,Semester_1Fee_Paid__c ,Semester_2Fee_Paid__c,Merit_Scholarship__c,Corporate_Scholarship__c,Type_of_Accommodation__c,ACT_score__c,Program__r.Semester_2_Fee_Disc__c,
                                      Housing_confirmed__c,Conformed_Accommodation_Type_Name__c,Preference_Housing_Amount__c,Hsg_Preference_Type_A_Value__c,Hsg_Preference_Type_B_Value__c,Hsg_Preference_Type_C_Value__c,Old_SAT_Structure__c,
                                      Hsg_Preference_Type_D_Value__c,Hsg_Preference_Type_E_Value__c,Preference_Housing_Payment_Recived__c, Housing_Preference_Submitted__c,Housing_Description__c ,Enrollment_Deposit_Amount_Paid__c,Application_Progress__c,
                                      (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c, FUA_Broadcast_Admit_Card__c from Admit_Cards__r) from Application__c  Where Contact__c =:objContact.Id Limit 1];
            
        
        }catch(Exception ex){
            
            System.debug('Error at '+ex.getStackTraceString());
        }
        return userApplication;
    }
    public Map<String,Id> getPaymentRecordType(){
        
        List<RecordType> lstOfRecordType = [Select Id, Name From RecordType Where SObjectType = 'FUA_Payment__c'];
        Map<String,Id> mapOfRecordType = new Map<String,Id>();
        if(lstOfRecordType.size() > 0){
            
            for(RecordType recordType : lstOfRecordType){
                
                mapOfRecordType.put(recordType.Name, recordType.Id);
            }   
        }
        return mapOfRecordType;
    }
    public String currentPod(){
        
        String server;
        if(ApexPages.currentPage() != null){
            
            server = ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To');
        } 
        else {
            
            server = URL.getSalesforceBaseUrl().getHost();
        }
        if(server != null && server.length() > 0){
            
            server = server.substring(0 ,server.indexOf('.'));
        }
        return server ;
    }
    public Boolean isSandbox(){
        
        String pod = currentPod();
        if (pod != null && pod.length() > 0 && pod.toUpperCase().startsWith('C')){
            return true;
        }
        return false;
    }
}