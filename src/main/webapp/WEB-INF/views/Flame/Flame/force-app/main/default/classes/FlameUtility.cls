Public class FlameUtility {

   public static contact getConactInfo(String ContactId){
      Contact Con = [select id,Name, Mother_s_First_Name__c,(select id,Name,Application_Submission_Status__c,Completed_Stages__c from Applications__r),Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,MobilePhone,
                      Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
                      Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
                      Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
                      Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
                      Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
                      Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
                      FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
                      FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
                      Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c from contact where Id=:ContactId Limit 1];
     return Con;  
   }

   public static contact getConactInfoByEmail(String UserEmail){
      Contact Con = [select id,Name, Mother_s_First_Name__c,(select id,Completed_Stages__c from Applications__r),Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,MobilePhone,
                      Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,
                      Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,Father_s_Mobile_No__c, FUA_Father_s_Mobile_No__c,
                      Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,
                      Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,
                      Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,
                      Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,
                      FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,
                      FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,
                      Are_you_an_Indian__c,OtherStreet, Portal_password__c,Program_Interested_In__c from contact where Email=:UserEmail Limit 1];
     return Con;  
   }
    
   public static List<Application__c> getApplicationInfo(String ContactId, String AppId){
      List<Application__c>  app;
    
      if(ContactId!=null)
      app =new List<Application__c>([Select Id,Name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name,Contact__c,GD_and_PI_Round__c,
                                    Program__c, GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
                                    FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c from Application__c 
                                    WHERE Contact__c =:ContactId  LIMIT 1]);                    
      else if(AppId!=null)
      app =new List<Application__c>([Select Id,Name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.Name,Contact__c,GD_and_PI_Round__c,
                                    Program__c,GD_and_PI_Center__c, Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,
                                    FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c from Application__c 
                                    WHERE Id =:AppId  LIMIT 1]);   
      return app;
   }  
  
   public static Program__c getProgramDetails(String ProgramId){
       Program__c prog = [Select ID,Name From Program__c Where ID =: ProgramId]; 
       return prog;      
   }  

   
    
  public String getHtmlText() 
  {
     return [Select Body From Document Where Name = 'IndexPageBeforeThankYou'].Body.toString();
  }
  
  public List<SelectOption> GetNationality()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }

   public List<SelectOption> GetGender()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Male','Male'));
        options.add(new SelectOption('Female','Female'));
        return options;
    }
  
   public List<SelectOption> GetCountries()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_Country__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
           options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
       }
       return options;
    }

   public List<SelectOption> GetSources()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.Source__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
           options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
       }
       return options;
    }
   
   public List<SelectOption> GetOutCountries()
    {
       List<SelectOption> options = new List<SelectOption>();
       Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_Country__c.getDescribe();
       List<Schema.PicklistEntry> countriesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry countryToItrate : countriesLst)
       {
            if(countryToItrate.getValue() != 'India')
            {
                options.add(new SelectOption(countryToItrate.getLabel(), countryToItrate.getValue()));
            }
           
       }
       return options;
    }
   
   public List<SelectOption> GetStates()
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult =Contact.FU_Applicant_Other_State__c.getDescribe();
        List<Schema.PicklistEntry> statesLst = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry statesToItrate : statesLst)
       {
            options.add(new SelectOption(statesToItrate.getLabel(), statesToItrate.getValue()));
       }
       options.add(new SelectOption('Outside India','Outside India'));
       return options;
    }
   
   public List<SelectOption> GetSameAddress()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Same as above','Same as above'));
        options.add(new SelectOption('Different','Different'));
        return options;
    }
   
   public List<SelectOption> GetFatherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Deceased','Deceased'));
        return options;
    }
   
   public List<SelectOption> GetMotherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Deceased','Deceased'));
        return options;
    }
    
   public List<SelectOption> getSalutations()
    {
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult =  Contact.Salutation.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
   public List<SelectOption> getMaritalstatuses()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult = Contact.Marital_Status__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
  
   public List<SelectOption> getresidencenumbs()
    {
      List<SelectOption> options = new List<SelectOption>();
        
       Schema.DescribeFieldResult fieldResult =   Contact.FU_Residence_Phone_Code__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
   public List<SelectOption> getfamilyincomes(){
      List<SelectOption> options = new List<SelectOption>();        
       Schema.DescribeFieldResult fieldResult = Contact.Total_Family_Income__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();            
       for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
   
   public List<SelectOption> getreligions(){
      List<SelectOption> options = new List<SelectOption>();
      Schema.DescribeFieldResult fieldResult = Contact.Religion__c.getDescribe();
      List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
      for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
   }
   
   public List<SelectOption> getFUCities(){
      List<SelectOption> options = new List<SelectOption>();        
       Schema.DescribeFieldResult fieldResult = Contact.FU_Applicant_Other_City__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();            
       for( Schema.PicklistEntry f : ple){
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
  }

}