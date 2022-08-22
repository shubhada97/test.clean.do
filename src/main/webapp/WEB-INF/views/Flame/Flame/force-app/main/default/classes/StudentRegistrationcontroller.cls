Public class StudentRegistrationcontroller{
    
    Public contact conn {get;set;}
    public String contactID{get;set;}
    public String StudentNumber{get;set;}
    public String TokenNumber{get; set { TokenNumber = value == null ? value : value.trim(); } }
    Public Boolean ErrorLogin {get;set;}
    Public Boolean IsCreated {get;set;}
    Public Boolean IsTicketDetials {get;set;}
    @TestVisible Private Account accId{get;set;}
    @TestVisible Private contact Id{get;set;} 
    List<contact>contact {get;set;}
    List<string> tokenKeys = new List<string>{'X5507','T8592','E6685','B9723','K4387','Y3956','D2176','Z1938','M7923','U1058'};
    List<Contact>  Con = new list<Contact>();
    public Boolean ischeck {get;set;}
    List<String> strList = new List<String>();
    
    ///Constructer
    Public StudentRegistrationcontroller(){
        conn = new contact();
        Con = new List<Contact>();
        //tokenKeys = new List<string>(); 
        IsCreated = false;
        IsTicketDetials = true;
    }
    
    
    public PageReference RegisterUser(){
      //  List<Contact> tempContactList = new List<Contact>();        
       // Set<Id> recordTypeIdSet = new Set<Id>();
      //  system.debug('StudentNumber-->'+StudentNumber);
      
      // to fetch the contact id to match the user name.
        con = [select id,CVUE_Student_Number__c, name , RecordType.Name, Account.Name from contact where CVUE_Student_Number__c =: StudentNumber limit 1];
        if(con.size()>0){
            system.debug('con-1'+con[0].id);
            string cId = con[0].id;
            for(string listitems: tokenKeys){
                //strList.add(listitems);
                
                
                //user name is equal to contact student number.
                if(con[0].CVUE_Student_Number__c == StudentNumber){
                // to fetch the all  data in custom settings.
                    List<Campus_Registration__c> cmpRegisList = Campus_Registration__c.getall().values();
                    Set<String> accNames  =new Set<String>();
                    Set<String> recTypeNames  =new Set<String>();
                    for(Campus_Registration__c cmp : cmpRegisList){
                        accNames.add(cmp.AccountName__c);
                        recTypeNames.add(cmp.RecordType__c);
                    }
                    // assign the All  selected  account names and  record type are under in  customsetting.   
                        if(accNames.contains(con[0].Account.Name) && recTypeNames.contains(con[0].RecordType.Name)){
                        // pertical list of values to assign the password values.
                            if(TokenNumber == listitems){
                                ischeck = true;
                                break;
                            }else{
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Incorrect Token Key'));
                             ischeck = false;
                            }
                                                      
                        }else{
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Incorrect Account Name'));
                            return null;
                        }
                
            
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'not a correct Student number'));
                    return null;
                }
            }
          // 'cid' means to pass the contact parameter id in one page to another page. 
            if(ischeck) {
                pagereference ApplyPage = new PageReference('/apex/Student_Data_Verification?id='+cid); 
                ApplyPage.setRedirect(true);          
                return ApplyPage; 
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Incorrect Token Key'));
                ischeck = false;
                return null;
            }
        }{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'not a correct Student number'));
            return null;
        }
        
    }
    
   // to get the contact detailes in the vfpage. 
    public List<contact> getcontact() {
    // to fetch the parameter id to assign the string.
        String cid = ApexPages.currentPage().getParameters().get('id') ; 
        if(contact == null)
            contact = [Select id,FirstName,Middle_Name__c,LastName,Other_City__c,CVUE_Student_Number__c,Program_Interested__c,Program_Interested_In__c,Classification_Applicant__c,Religion__c,Mother_Tongue__c,Student_PAN_No__c,
                       MobilePhone,Student_AADHAAR_No__c,Scholastic_Name__c,Physical_Disability__c,Category__c,Blood_Group__c,Permanent_Address_Line_1__c,Permanent_Address_Line_2__c,Mother_s_First_Name__c,Mother_s_Last_Name__c,
                       FU_Applicant_Other_City__c,FU_Applicant_Other_Country__c,Permanent_Postal_Code__c,FU_Applicant_Other_State__c,Mailing_Address_Line_1__c,Mailing_Address_Line_2__c,Father_s_First_Name__c,Father_s_Last_Name__c,
                       FU_Applicant_Mailing_City__c,Mailing_City__c,FU_Applicant_Mailing_Country__c,Mailing_Postal_Code__c,FU_Applicant_Mailing_State__c,Are_you_an_Indian__c,Withdrawal_Details_Comments__c,
                       Residence_Status__c,Father_PAN_No__c,Father_AADHAAR_No__c,FUA_Father_s_Mobile_No__c,Father_s_Email_ID__c,Mother_PAN_No__c,Mother_AADHAAR_No__c,Date_of_Birth__c,Gender__c,
                       FUA_Mother_s_Mobile_No__c,Mother_s_Email_ID__c,Reported_on_Campus__c,App_Reference_ID__c from contact where id=:cid LIMIT 10];
        return contact;
    }
    
  //once click the button to upload the data in the database.  
    public PageReference datauploaded(){
         upsert contact;
         pagereference ApplyPage = new PageReference('/apex/Student_Registration_page'); 
         ApplyPage.setRedirect(true);          
         return ApplyPage; 
    }
    
    //popup message to display in vfpage.
    public PageReference popupsubmit() {
        IsCreated = true;
        return null;
    }
    
    
    
   
}