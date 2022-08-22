public class FUA_ForgotPasswordController
{
    public String Username {get; set;}   
    List<User> ListExistingUsers = new List<user>(); 
    public string message{get;set;}
    public boolean resetDone{get;set;}
    public FUA_ForgotPasswordController () {resetDone = false;}
    //This method sends the forgot password link to reset the password to the user
    
    public PageReference forgotPassword(){
        PageReference pr = new PageReference('/apex/LoginPage');
        pr.setRedirect(true); 
        return pr;
    }
    
    public void FUA_forgotPassword() {
        resetDone = false;
        message = '';
        ListExistingUsers =[select id,IsActive,Username from user where IsActive= True];
        for(User userToItrate : ListExistingUsers){
            if(userToItrate.Username == Username){
                boolean success = Site.forgotPassword(Username);    
                if (success){  
                    message = 'Your reset password link has been sent to you registered email id. Please check your email';
                    resetDone = true;
                    break;
                }
            }
            else{
                message = 'Valid username is required';
                resetDone = false;
            }
        }
    }
   //This method redirects the user to LoginPage
    public PageReference redirectToLogin(){            
        PageReference pr = new PageReference('/apex/LoginPage');
        pr.setRedirect(true);
        return pr;
    }
}