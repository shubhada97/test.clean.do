global with sharing class Test_Login_Page_Extention 
{
    global String loginUsername{get;set;}
    global String loginPassword{get;set;}
    public String lastname{get;set;}
    public String firstName{get;set;}
    public String email{get;set;}
    public String Name{get;set;}
    public contact conn{get;set;}
    public contact con{get;set;}
    private user u{get;set;}
    public string selectedUser {get;set;}
    apexPages.StandardController stdController;
    public Test_Login_Page_Extention(ApexPages.StandardController controller) 
    {
        stdController=controller;
        conn = new contact();
        Contact Con = new Contact();
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
        
    public void saveData()
    { 
            
       Account a = [Select ID From Account Where Name = 'FLAMES - 2016 Admissions'];
       
        
        if(email!=null)
        {
            Contact duplicateContact = [Select ID,email from contact WHERE Email=:email limit 1];            
            if(duplicateContact==Null)
            {
                con.FirstName=firstName;
                con.LastName=lastname;
                con.Email=email;
                con.AccountId = a.ID;
                insert con;
            }
        else
        {
        //  con.adderror('This user already exists');
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.ERROR,'This user already exists')); 
        }       
    }


   }    
}