global with sharing class Test_Login_Page_controller{
    global String loginUsername{get;set;}
    global String loginPassword{get;set;}
    public String username{get;set;}    
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    public String lastname{get;set;}
    public String firstName{get;set;}
    public String country{get;set;}
    public String city{get;set;}
    public String mobile{get;set;}
    public String programInterestedIn{get;set;}
    public String email{get;set;}
    public String Name{get;set;}
    public contact con{get;set;}
    public string selectedUser {get;set;}
    global Test_Login_Page_controller()
     {
     con=new contact();
     }
     
    global PageReference forwardToCustomAuthPage() {
        return new PageReference('/ProgramForm');
    }
    
    global PageReference login() 
    {
        return Site.login(loginUsername, loginPassword, null);     
    }  
    
    public PageReference forgotPass() 
    {  
    PageReference redirect = new PageReference('/apex/TestForgotPassword'); 
    redirect.getParameters().put('id',selectedUser); 
    redirect.setRedirect(true);
    return redirect;
    }
      
     private boolean isValidPassword()
     {
        return password == confirmPassword;
     }
    public pagereference registerUser() 
    {
      
           // it's okay if password is null - we'll send the user a random password in that case
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }    

        String profileId = null; // To be filled in by customer.
        String roleEnum = null; // To be filled in by customer.
        String accountId = ''; // To be filled in by customer.
        
        String userNameForUser = email;

        User u = new User();
        u.Username = userNameForUser;
        u.Email = email;
        u.FirstName = firstName;
        u.LastName = lastname;
        u.CommunityNickname = communityNickname;
        u.ProfileId = profileId;
        
        String userId = Site.createPortalUser(u, accountId, password);
      
        if (userId != null)
        { 
            if (password != null && password.length() > 1)
            {
                return Site.login(userNameForUser, password, ApexPages.currentPage().getParameters().get('startURL'));
            }
            else 
            {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
             
         return null;
    }
    public void insertContact()
    {        
         con.AccountId = '001N000000cuYfW';
         /*con.FirstName= firstName;
         con.MailingCountry= country;
         con.MailingCity= city;
         con.MobilePhone= mobile;
         con.Program_Interested__c= programInterestedIn;
         con.Email= email;*/
         con.LastName= lastname;        
         insert con; 
         system.debug('####con'+con);
    }
  }