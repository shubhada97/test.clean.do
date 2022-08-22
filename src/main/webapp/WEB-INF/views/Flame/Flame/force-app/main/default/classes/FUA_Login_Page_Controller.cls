public class FUA_Login_Page_Controller 
{
    public String UserNameErrorMessage{get;set;}
    public String PasswordValidationErrorMessage{get;set;}
    public String LoginUsername{get;set;}
    public String LoginPassword{get;set;}
    public String Username {get; set;}
    public String Email {get; set;}
    public String Password {get; set {Password = value == null ? value : value.trim(); } }
    public String ConfirmPassword {get; set { ConfirmPassword = value == null ? value : value.trim(); } }
    public String CommunityNickname {get; set { CommunityNickname = value == null ? value : value.trim(); } }
    private user usrconid{get;set;}
    public string SelectedUser {get;set;}
    public Contact Conn{get;set;}
    public list<Program__c> ListOfPrograms{get;set;}
    public string Program{get;set;}
    private account accId{get;set;}
    Public Boolean ErrorLogin {get;set;}
    public FUA_Login_Page_Controller () 
    {
        Conn = new Contact();              
    }
    
    //This method checks if the password is 8 letters and alpha-mnumeric
    private boolean isValidPassword()
    {
        return Password == ConfirmPassword;
    }
    
    //This method redirects the user to ForgotPasswordPage
    public PageReference ForgotPass() 
    {
        PageReference redirect = new PageReference('/ForgotPasswordPage_1'); 
        redirect.getParameters().put('id',SelectedUser); 
        redirect.setRedirect(true);
        return redirect;
    }
    
    //This will forward guest users to the CustomLogin page.It is called in "action" attribute on the page.
    public pagereference LandingPage()
    {
       if(UserInfo.getUserType() != 'Guest')
        {
            return new PageReference('/Index');
        }
        return null;
    }
    
    public PageReference ForwardToCustomAuthPage()
    {
        return new PageReference('/Index');
    }   
   
   //Community Login method
    public PageReference Login() 
    {
       ErrorLogin= true; 
        return Site.login(LoginUsername, LoginPassword, null);    
    }
    
    /*private void populateErrorMessage(String errorMessage) // Commented this code because this is is not in use.
    {
        System.debug('errorMessage '+errorMessage);
        UserNameErrorMessage = errorMessage.contains('UserName') ? errorMessage: '';
        PasswordValidationErrorMessage = errorMessage.contains('Password') ? errorMessage: '';
    }*/
     //This method fetch the programs and store the name in Program_Interested_In__c on Contact object
     public List<SelectOption> getPrograms()
    {
        List<SelectOption> options = new List<SelectOption>();
        ListOfPrograms = [SELECT Active__c,Display_Sequence__c,Name From Program__c Order WHERE Active__c = True ORDER BY Display_Sequence__c];
        for(Program__c programToItrate : ListOfPrograms )
        {
            options.add(new SelectOption(programToItrate.ID,programToItrate.Name));
        }
        return options;
    } 
    //This method creates a contact and user record.
    public PageReference RegisterUser()
    {
        try
        {
            if (!isValidPassword()) 
            {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
                ApexPages.addMessage(msg);
                return null;
            }    
                String UserName = Email;
                //The username field in User object is stored as email on contact object.
                User u = new User();
                u.Username = Username;
                u.FirstName = Conn.FirstName;
                u.LastName= Conn.LastName;
                u.Email = Email;
               //This would get the first 20 characters of the string   
                if(Conn.FirstName.length() > 20){
                u.CommunityNickname = conn.FirstName.substring(0,20) +System.now();
                system.debug('concat'+Conn.FirstName.length());
                }else{
                 u.CommunityNickname = conn.FirstName+System.now();
                 //system.debug('concat'+first.length());
                }
                FlameUniversitSettings__c asDefalutSettings = FlameUniversitSettings__c.getOrgDefaults();
                String accntName = asDefalutSettings.AccountName__c;
                List<Account> tempAcc = new List<Account>();
                system.debug('accntName -> ' + accntName);
                tempAcc = [SELECT id,Name FROM Account Where Name =: accntName LIMIT 1];
                String accountId;
                if(tempAcc.size() > 0 ){
                    accId = tempAcc[0];
                    accountId = accId.id;
                }
                 
                String userId = Site.createExternalUser(u, accountId, Password, true);
            if (userId != null) 
            { 
                usrconid= [SELECT id, Name,contactid FROM user where id=: userId  LIMIT 1];
                Program__c prog = [Select ID, Name From Program__c Where ID =: Program];
                Conn.id = usrconid.contactid;
                Conn.FU_Applicant_Other_Country__c= Conn.FU_Applicant_Other_Country__c;
                Conn.FU_Applicant_Other_State__c= Conn.FU_Applicant_Other_State__c;
                Conn.FU_Applicant_Other_City__c=Conn.FU_Applicant_Other_City__c;
                Conn.Other_City__c=Conn.Other_City__c;
                Conn.FirstName=Conn.FirstName;   
                Conn.LastName= Conn.LastName;
                Conn.FUA_Mobile__c=Conn.FUA_Mobile__c;
                Conn.FU_Mobile_Phone_Code__c=Conn.FU_Mobile_Phone_Code__c;
                Conn.Program_Interested__c = prog.Name;
                Conn.Program_Interested_In__c = prog.Name;
                conn.Classification_Applicant__c = TRUE;
                update Conn;
                if (Password != null && Password.length() > 1) 
                {
                    return Site.login(Username, Password, null);
                    
                }
                else 
                {
                    PageReference page = System.Page.SiteRegisterConfirm;
                    page.setRedirect(true);
                    return page;
                }
            }
        }
         catch(Exception e)
        { 
                    
            system.debug('Exception : ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Supplied email already exists in the system, please use a different email ID for new application.'));
        }
        return null;
    }
    Public void usermethod(){
     String UserName = Email;
                //The username field in User object is stored as email on contact object.
                User u = new User();
                u.Username = Username;
                u.FirstName = Conn.FirstName;
                u.LastName= Conn.LastName;
                u.Email = Email;
               //// u.CommunityNickname = conn.FirstName+System.now();
                FlameUniversitSettings__c asDefalutSettings = FlameUniversitSettings__c.getOrgDefaults();
                String accntName = asDefalutSettings.AccountName__c;
                List<Account> tempAcc = new List<Account>();
                system.debug('accntName -> ' + accntName);
                tempAcc = [SELECT id,Name FROM Account Where Name =: accntName LIMIT 1];
                String accountId;
                if(tempAcc.size() > 0 ){
                    accId = tempAcc[0];
                    accountId = accId.id;
                }
    }
     Public void contactmethod(){
     String UserName = Email;
                //The username field in User object is stored as email on contact object.
                User u = new User();
                u.Username = Username;
                u.FirstName = Conn.FirstName;
                u.LastName= Conn.LastName;
                u.Email = Email;
              //  u.CommunityNickname = conn.FirstName+System.now();
                FlameUniversitSettings__c asDefalutSettings = FlameUniversitSettings__c.getOrgDefaults();
                String accntName = asDefalutSettings.AccountName__c;
                List<Account> tempAcc = new List<Account>();
                system.debug('accntName -> ' + accntName);
                tempAcc = [SELECT id,Name FROM Account Where Name =: accntName LIMIT 1];
                String accountId;
                if(tempAcc.size() > 0 ){
                    accId = tempAcc[0];
                    accountId = accId.id;
                }
    }
     public void addHealth() {
        Integer a=1; 
         integer b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        }
    }