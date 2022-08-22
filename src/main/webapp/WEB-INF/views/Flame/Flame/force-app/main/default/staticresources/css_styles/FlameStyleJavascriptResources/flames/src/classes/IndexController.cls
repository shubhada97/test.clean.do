public with sharing class IndexController 
{
    private user userID{get;set;}
    ApexPages.StandardController stdController;
    public IndexController(ApexPages.StandardController controller) 
    {
        //userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
    }
    public pagereference logout()
    {
                return UserInfo.getUserType() != 'Guest' ? new PageReference( '/apex/Test_Login_Page') : null ;
    }
    public PageReference proceedApplication() 
    {    
        /*PageReference  pgcproceed=null;
        pgcproceed= new PageReference('/apex/ProgramForm?id='+ userID.ContactId); 
        pgcproceed.setRedirect(true);*/
        return null;
    }
}