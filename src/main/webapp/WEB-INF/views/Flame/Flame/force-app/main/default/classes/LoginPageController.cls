public class LoginPageController {
   
    public  PageReference  login()
    {
       
        try {      
            ApexPages.PageReference pageRef =null;
            String userName = Apexpages.currentPage().getParameters().get('uid');
            String password = Apexpages.currentPage().getParameters().get('pid');
            String startUrl = label.baseCommunityUrl;
            
             pageRef = Site.login(userName, password, startUrl);
            if(Test.isRunningTest()){
            if(pageRef != null) {PageReference p = new PageReference(pageRef.getUrl());return p;
            }
                
            }
            return pageRef;
               // else{
               // return null;
           // }
            
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
   

}