public  class FUA_PersonalDetailsController 
{
    public String AddValue{get;set;}
    public Contact Con{get;set;}
    public User UserID{get;set;}
    public String PlaceOfBirthCon{get;set;}
    public String PlaceOfBirthSt{get;set;}
    public String PlaceOfBirthOut{get;set;}
    public String SaveExit{get;set;}
    public String GenderVal{get;set;}
    public String BirthdateValue{get;set;}
    public String PassportExpireDateValue{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;} 
    ApexPages.StandardController stdController;
    public FUA_PersonalDetailsController (ApexPages.StandardController controller) 
    {
        stdController = controller;
        AddValue = 'Same as above';
        GenderVal = 'Male';
        findcontactController();

    }
        //Method call from constructor initialies field values and get contact of current user. 
    private void findcontactController()
    {
        try
        {
            if(!String.IsEmpty(UserInfo.getUserId()))
            {
                UserID=[Select Id,ContactId, Name from User where Id = : UserInfo.getUserId()];
                Con = [select id,Mother_s_First_Name__c,(select id,Completed_Stages__c from Applications__r),Mother_s_Mobile_No_Code__c,Mother_s_Mobile_No__c,MobilePhone,Mother_s_Current_Company__c,Mother_s_Last_Company__c,Mother_s_Designation__c,Source__c,Other__c,Mother_s_Last_Name__c,Mother_s_Occupation__c,Mother_s_Email_ID__c,FUA_Mother_s_Mobile_No__c, FirstName,Passport_No__c,Father_s_Email_ID__c,Father_s_Mobile_No_Code__c,FUA_Father_s_Mobile_No__c,Father_s_Current_Company__c,Father_s_Last_Company__c,Father_s_Designation__c,Father_s_First_Name__c,Father_s_Last_Name__c,Father_s_Occupation__c,Mother_Tongue__c,Visa_Status__c,Passport_Expiry_Date__c,Passport_Issued_By__c,Middle_Name__c,FUA_Residence_Phone_No__c,Birthdate,Alternate_Email_ID__c,Email,FUA_Mobile__c,FU_Mobile_Phone_Code__c,Religion__c,Total_Family_Income__c,FU_Residence_Phone_Code__c,Salutation,Marital_Status__c, LastName,name,Mailing_Address__c,Mailing_Address_Line_2__c,FU_Outside_India__c,Mailing_Address_Line_1__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Mailing_City__c,Mailing_Postal_Code__c,Mailing_City__c,Place_of_Birth__c ,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,FU_Applicant_Other_State__c,FU_Applicant_Other_City__c, Other_City__c,Permanent_Address_Line_1__c, Permanent_Address_Line_2__c ,Gender__c,Are_you_an_Indian__c,OtherStreet from contact where id =:UserID.ContactId];
                if(Con.Are_you_an_Indian__c== 'No')
                {
                    PlaceOfBirthCon= Con.Place_of_Birth__c; 
                }
                else
                {
                    PlaceOfBirthSt = Con.Place_of_Birth__c;
                    PlaceOfBirthOut=Con.FU_Outside_India__c;
                }
                if(Con.Gender__c!=Null)
                {
                    GenderVal = Con.Gender__c;
                }
                if(Con.Mailing_Address__c!=Null)
                {
                    AddValue = Con.Mailing_Address__c;
                }
                if(Con.Are_you_an_Indian__c!=Null)
                {
                   Con.Are_you_an_Indian__c =Con.Are_you_an_Indian__c;
                }
                //Get Birthdate from contact in yyyy/mm/dd format and convert it into dd/mm/yyyy format
                if(Con.Birthdate!=Null)
                {
                   BirthdateValue =string.valueof(Con.Birthdate);
                   List<string> lstBirthdis = new List<string>();
                   lstBirthdis = BirthdateValue.split('-');
                   BirthdateValue = lstBirthdis[2] +'/'+lstBirthdis[1] +'/'+lstBirthdis[0] ;
                }
                //Get PassportExpiryDate from contact in yyyy/mm/dd format and convert it into dd/mm/yyyy format
                if(Con.Passport_Expiry_Date__c!=Null)
                {
                   PassportExpireDateValue =string.valueof(Con.Passport_Expiry_Date__c);
                   List<string> lstExpiredis = new List<string>();
                   lstExpiredis = PassportExpireDateValue.split('-');
                   PassportExpireDateValue = lstExpiredis[2] +'/'+lstExpiredis[1] +'/'+lstExpiredis[0] ;
                }
            }
        }
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
        }
       
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
        options.add(new SelectOption('Not Applicable','Not Applicable'));
        return options;
    }
    public List<SelectOption> GetMotherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Not Applicable','Not Applicable'));
        return options;
    }
        //Method call from VF page save all field values in contact object and redirect to EducationAndWork page if click on Next button.
        //Methid call from VF page save all field values in contact object and logout if click on Save & Exit button.
    public PageReference SaveData()
    {    
        stdController.save();
        PageReference  pgcproceed=null;
        system.debug('BirthdateValue' + BirthdateValue);
        //BirthdateValue = BirthdateValue.split('/');
       //system.debug('bithval[0]' + BirthdateValue);
        
        try
        {
            if(AddValue == 'Same as above')
            {
                Con.Mailing_Address_Line_1__c=Con.Permanent_Address_Line_1__c;
                Con.Mailing_Address_Line_2__c=Con.Permanent_Address_Line_2__c;
                Con.FU_Applicant_Mailing_City__c=Con.FU_Applicant_Other_City__c;
                Con.FU_Applicant_Mailing_Country__c=Con.FU_Applicant_Other_Country__c;
                //Con.FU_Applicant_Mailing_State__c= Con.FU_Applicant_Other_State__c;
                Con.FU_Applicant_Mailing_State__c=Con.FU_Applicant_Other_State__c;
                Con.Mailing_Postal_Code__c=Con.Permanent_Postal_Code__c;
                Con.Mailing_City__c=Con.Other_City__c;
            }
            else
            {
                Con.Mailing_Address_Line_1__c=Con.Mailing_Address_Line_1__c;
                Con.Mailing_Address_Line_2__c=Con.Mailing_Address_Line_2__c;
                Con.FU_Applicant_Mailing_City__c=Con.FU_Applicant_Mailing_City__c;
                Con.FU_Applicant_Other_Country__c=Con.FU_Applicant_Other_Country__c;
                //Con.FU_Applicant_Mailing_State__c= Con.FU_Applicant_Mailing_State__c;
                Con.FU_Applicant_Mailing_State__c=Con.FU_Applicant_Mailing_State__c;
                Con.Mailing_Postal_Code__c=Con.Mailing_Postal_Code__c;
                Con.Mailing_City__c=Con.Mailing_City__c;
            }
            if(Con.Are_you_an_Indian__c== 'No')
            {
                Con.Place_of_Birth__c = PlaceOfBirthCon; 
                Con.FU_Outside_India__c = '';
            }
            else 
            {
                Con.Place_of_Birth__c = PlaceOfBirthSt;
                Con.FU_Outside_India__c=PlaceOfBirthOut;
            }
            if(con.Father_s_Occupation__c == 'Working')
            {
                //Con.Father_s_Email_ID__c = Con.Father_s_Email_ID__c;
                //Con.Father_s_Mobile_No_Code__c = Con.Father_s_Mobile_No_Code__c
                //con.FUA_Father_s_Mobile_No__c = con.FUA_Father_s_Mobile_No__c;
                Con.Father_s_Current_Company__c =Con.Father_s_Current_Company__c;
                Con.Father_s_Last_Company__c ='';
                Con.Father_s_Designation__c = Con.Father_s_Designation__c;
            }
            else if(con.Father_s_Occupation__c == 'Retired')
            {
                //Con.Father_s_Email_ID__c = Con.Father_s_Email_ID__c;
                //Con.Father_s_Mobile_No_Code__c = Con.Father_s_Mobile_No_Code__c;
                //con.FUA_Father_s_Mobile_No__c = con.FUA_Father_s_Mobile_No__c;
                Con.Father_s_Current_Company__c ='';
                Con.Father_s_Last_Company__c = Con.Father_s_Last_Company__c; 
                Con.Father_s_Designation__c = Con.Father_s_Designation__c; 
            }
            else if(con.Father_s_Occupation__c == 'Homemaker')
            {
                //Con.Father_s_Email_ID__c = Con.Father_s_Email_ID__c;
                //Con.Father_s_Mobile_No_Code__c = Con.Father_s_Mobile_No_Code__c;
                //con.FUA_Father_s_Mobile_No__c = con.FUA_Father_s_Mobile_No__c;
                Con.Father_s_Current_Company__c ='';
                Con.Father_s_Last_Company__c = '';
                Con.Father_s_Designation__c = '';
            }
            else if(con.Father_s_Occupation__c == 'Deceased')
            {
                Con.Father_s_Email_ID__c = '';
                Con.Father_s_Mobile_No_Code__c = '';
                Con.FUA_Father_s_Mobile_No__c ='';
                Con.Father_s_Current_Company__c ='';
                Con.Father_s_Last_Company__c = ''; 
                Con.Father_s_Designation__c = '';
            }
            //Con.Birthdate= date.valueof(Birthdate);
            if(con.Mother_s_Occupation__c == 'Working')
            {
                //Con.Mother_s_Email_ID__c = Con.Mother_s_Email_ID__c;
                //Con.Mother_s_Mobile_No_Code__c = Con.Mother_s_Mobile_No_Code__c
                //con.FUA_Mother_s_Mobile_No__c = con.Mother_s_Mobile_No__c;
                Con.Mother_s_Current_Company__c =Con.Mother_s_Current_Company__c;
                Con.Mother_s_Last_Company__c ='';
                Con.Mother_s_Designation__c = Con.Mother_s_Designation__c;
            }
            else if(con.Mother_s_Occupation__c == 'Retired')
            {
                //Con.Mother_s_Email_ID__c = Con.Mother_s_Email_ID__c;
                //Con.Mother_s_Mobile_No_Code__c = Con.Mother_s_Mobile_No_Code__c;
                //con.FUA_Mother_s_Mobile_No__c = con.Mother_s_Mobile_No__c;
                Con.Mother_s_Current_Company__c ='';
                Con.Mother_s_Last_Company__c = Con.Mother_s_Last_Company__c; 
                Con.Mother_s_Designation__c = Con.Mother_s_Designation__c; 
            }
            else if(con.Mother_s_Occupation__c == 'Homemaker')
            {
                //Con.Mother_s_Email_ID__c = Con.Mother_s_Email_ID__c;
                //Con.Mother_s_Mobile_No_Code__c = Con.Mother_s_Mobile_No_Code__c;
                //con.FUA_Mother_s_Mobile_No__c = con.Mother_s_Mobile_No__c;
                Con.Mother_s_Current_Company__c ='';
                Con.Mother_s_Last_Company__c = '';
                Con.Mother_s_Designation__c = '';
            }
            else if(con.Mother_s_Occupation__c == 'Deceased')
            {
                Con.Mother_s_Email_ID__c = '';
                Con.Mother_s_Mobile_No_Code__c= '';
                Con.FUA_Mother_s_Mobile_No__c ='';
                Con.Mother_s_Current_Company__c ='';
                Con.Mother_s_Last_Company__c = ''; 
                Con.Mother_s_Designation__c = '';
            }
            //Get BirthdateValue from page in dd/mm/yyyy, Convert it into yyyy/mm/dd and update it into Birthdate field in Contact
            List<string> lstBirth = new List<string>();
            if(!String.isEmpty(BirthdateValue))
            {
                lstBirth = BirthdateValue.split('/');
                Date dateBirth = Date.newInstance(Integer.valueOf(lstBirth[2]),Integer.valueOf(lstBirth[1]),Integer.valueOf(lstBirth[0]));
                //date.valueOf('2016-04-06 00:00:00')
                con.Birthdate= dateBirth;
                //con.Birthdate= date.valueof(birthdate);
            }
            //Get PassportExpireDateValue from page in dd/mm/yyyy, Convert it into yyyy/mm/dd and update it into PassportExpireDate field in Contact
            List<string> lstExpireDate = new List<string>();
            if(!String.isEmpty(PassportExpireDateValue))
            {
                lstExpireDate = PassportExpireDateValue.split('/');
                Date expireDate = Date.newInstance(Integer.valueOf(lstExpireDate[2]),Integer.valueOf(lstExpireDate[1]),Integer.valueOf(lstExpireDate[0]));
                //2016-04-06 00:00:00
                con.Passport_Expiry_Date__c= expireDate;
                //con.Birthdate= date.valueof(birthdate);
            }
            Con.Mailing_Address__c = AddValue;
            Con.Gender__c = GenderVal;
            //Con.Passport_Expiry_Date__c=date.valueof(PassportExpireDate);
            //Con.Salutation = Con.Salutation;
            UserID.FirstName = Con.FirstName;
            UserID.LastName= Con.LastName;
            update Con;
            
            if(Con != null && Con.Applications__r.size() > 0){
                List<Application__c> apps = Con.Applications__r;
                String completedStages = apps[0].Completed_Stages__c;
                String currentPageName = 'Personal Details';
                if(completedStages != null){
                    if(!completedStages.contains(currentPageName)){
                        completedStages += ';' + currentPageName;
                        apps[0].Completed_Stages__c = completedStages;
                    }
                }
                else{
                    apps[0].Completed_Stages__c = currentPageName;
                }
                update apps;
            }
            update UserID;
        }
        catch(exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, e.getMessage()));
        }
        if(!String.isBlank(SaveExit) && 'SaveExit'.equalsIgnoreCase(SaveExit))
        {
            pgcproceed= new PageReference('/secur/logout.jsp');
            //pgcproceed.setRedirect(true);
            //return pgcproceed;
        }
        else
        {
            pgcproceed= new PageReference('/apex/EducationAndWork_1');
            //pgcproceed.setRedirect(true);
            //return pgcproceed;
        }
        pgcproceed.setRedirect(true);
        return pgcproceed;
    }
        
    public pageReference redirect()
    {
        if(Con.Applications__r != null && Con.Applications__r.size() == 0){
            return new PageReference('/apex/Index');
        }
        else{
            return null;
        }
    }
}