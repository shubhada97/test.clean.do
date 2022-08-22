global with sharing class CustomLoginController 
{
    public string selectedUser {get;set;}
    global String loginUsername{get;set;}
    global String loginPassword{get;set;}
    public String username{get;set;}    
    //public String password {get; set {password = value == null ? value : value.trim(); } }
    public Contact con {get;set;}
    
    public CustomLoginController ()
    {
        con = new Contact();
    }

    public PageReference forgotPass() 
    {
        PageReference redirect = new PageReference('/apex/TestForgotPassword'); 
        redirect.getParameters().put('id',selectedUser); 
        redirect.setRedirect(true);
        return redirect;
    }
    
    public PageReference login() 
    {
        return null;
    }
    
    public void savedata()
    {
        /*Contact newContact = new Contact();
        newContact.FirstName=con.FirstName;
        newContact.LastName=con.lastName;
        newContact.Email=con.email;
        insert newContact;*/
        
        User u = new User();
        u.FirstName = con.FirstName;
        u.LastName = con.lastName;
        u.Email = con.email;
        u.ProfileId = '00eN0000000Dwp7';
        u.EmailEncodingKey ='UTF-8';
        u.LanguageLocaleKey ='en_US'; 
        u.LocaleSidKey='en_US';
        u.TimeZoneSidKey='America/Los_Angeles';
        u.Alias = 'test';
        u.CommunityNickname = 'NickName';
        //u.ContactID = newContact.ID;
        u.UserRoleID='00E28000000GI7W';
        insert u;
    
    }
    
}