public with sharing class PersonalDetailsController 
{
    //public List<SelectOption> LstGender{get;set;}
    //public List<SelectOption> Lstindian{get;set;}
    public string genderValue{get;set;}
    public string addValue{get;set;}
    public string ntnlValue{get;set;}
    public String contactId{get;set;}
    public Contact con{get;set;}
    public String occupationVal{get;set;}
    public String fatOccupationVal{get;set;}
    public String matOccupationVal{get;set;}
    public String addressLineOne{get;set;}
    public String addressLineTwo{get;set;}
    public String malAddLineOne{get;set;}
    public String malAddLineTwo{get;set;}
    ApexPages.StandardController stdController;
    public PersonalDetailsController(ApexPages.StandardController controller) 
    {
        stdController = controller;
        ntnlValue='Yes';
        genderValue = 'Male';
        addValue= 'Same as above';
        findcontactController();
        //LstGender = new List<SelectOption>();
        //Lstindian = new List<SelectOption>();
        //gender();
        //areYouIndian();
    }
    public Boolean show
    {   
        get{ return ntnlValue== 'No';}
    }
    public Boolean showAdd
    {   
        get{ return addValue== 'Different';}
    }
    public Boolean fatWorking 
    {   
        get{ return fatOccupationVal== 'Working';}
    }
    /*public Boolean showAdd
    {   
        get{ return addValue== 'Different';}
    }*/
    public void findcontactController()
    {
        try
        {
            contactId = ApexPages.currentPage().getParameters().get('id');
            con = [select id, name, Gender__c, Are_you_an_Indian__c from contact where id = :contactId];
            system.debug('con'+con.name);
        }
        catch(Exception e)
        {
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
        }
       
    }
    /*public void gender()
    {
        Schema.DescribeFieldResult fieldResult = Contact.Gender__c.getDescribe();
        List<Schema.PicklistEntry> gndrvalue = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry gn : gndrvalue)
        {
            LstGender.add(new SelectOption(gn.getLabel(), gn.getValue()));
        }
    }*/
    /*public void areYouIndian()
    {
        Schema.DescribeFieldResult fieldResult = Contact.Are_you_an_Indian__c.getDescribe();
        List<Schema.PicklistEntry> indiavalue = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry ind : indiavalue)
        {
            Lstindian.add(new SelectOption(ind.getLabel(), ind.getValue()));
        }
    }*/
    public List<SelectOption> getNationality()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
    public List<SelectOption> getGender()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Male','Male'));
        options.add(new SelectOption('Female','Female'));
        return options;
    }
    public void saveData()
    {    
        stdController.save();
        // PageReference  pgcsave=null;
        con.Gender__c = genderValue;
        con.Are_you_an_Indian__c = ntnlValue;
        con.Father_s_Occupation__c = fatOccupationVal;
        con.Mother_s_Occupation__c  = matOccupationVal;
        con.OtherStreet = addressLineOne + ',' + addressLineTwo; 
        if(addValue== 'Different')
        {
            con.MailingStreet  = malAddLineOne +','+ malAddLineTwo;
        }
            //con.MailingStreet  = malAddLineOne +','+ malAddLineTwo;
        else
        {
            con.MailingStreet = addressLineOne + ',' + addressLineTwo;
        }
        update con;
        //pgcsave= new PageReference('/apex/PersonalDetails?id='+contactId); 
        //pgcsave.setRedirect(true);
        //return pgcsave;
    }
    public List<SelectOption> getSameAddress()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Same as above','Same as above'));
        options.add(new SelectOption('Different','Different'));
        return options;
    }
    public List<SelectOption> getFatherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working ','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Deceased','Deceased'));
        return options;
    }
    public List<SelectOption> getMotherOccupation()
    {        
        List<SelectOption> options=new List<SelectOption>();            
        options.add(new SelectOption('Working ','Working'));
        options.add(new SelectOption('Retired','Retired'));
        options.add(new SelectOption('Homemaker','Homemaker'));
        options.add(new SelectOption('Deceased','Deceased'));
        return options;
    }
    
    /*public PageReference CustomSaveExit() 
    {    
        stdController.save();
        // PageReference  pgcsave=null;
        con.Gender__c = genderValue;
        con.Are_you_an_Indian__c = ntnlValue;
        con.Father_s_Occupation__c = fatOccupationVal;
        con.Mother_s_Occupation__c  = matOccupationVal;
        con.OtherStreet = addressLineOne + ',' + addressLineTwo; 
        if(addValue== 'Different')
        {
            con.MailingStreet  = malAddLineOne +','+ malAddLineTwo;
        }
            //con.MailingStreet  = malAddLineOne +','+ malAddLineTwo;
        else
        {
            con.MailingStreet = addressLineOne + ',' + addressLineTwo;
        }
        update con;
        return UserInfo.getUserType() != 'Guest' ? new PageReference( '/apex/Test_Login_Page') : null ;
        //pgcsaveexit= new PageReference('/apex/Test_Login_Page'); 
        //pgcsaveexit.setRedirect(true);
        //return pgcsaveexit;
    }*/

}