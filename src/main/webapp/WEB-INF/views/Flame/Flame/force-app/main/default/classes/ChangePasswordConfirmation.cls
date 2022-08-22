Public class ChangePasswordConfirmation{
Public PageReference PasswordConfirmation(){

PageReference pgcproceed= new PageReference('/apex/LoginPage_1');
pgcproceed.setRedirect(true);
return null;
}

}