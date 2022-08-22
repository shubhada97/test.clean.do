/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    
    public PageReference changePassword() {
        PageReference page = Site.changePassword(newPassword, verifyNewPassword, oldpassword);
        system.debug('page -> ' + page);
        if(page != null){
            return new PageReference('/apex/ChangePasswordConfirmation');    
        }
        else{
            return null;
        }
    }     
    
    public ChangePasswordController() {}
}