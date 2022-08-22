@isTest
public class LoginPageControllerTest {
   
   public static testMethod void LoginPageControllerTest() {
       test.startTest();
       
       String username = 'harshal-flame@techilaservice.com';
       String password = 'Success@102';
       String StartUrl = label.baseCommunityUrl;
       PageReference pageReff = Page.Login_Community;
      
       pageReff.getParameters().put('uid','harshal-flame@techilaservice.com');
       pageReff.getParameters().put('pid','Success@102');
       Test.setCurrentPage(pageReff);
       Pagereference newPage = site.login(username,password,startURL);
       LoginPageController objLP = new LoginPageController();
       
       objLP.login();
       
       test.stopTest();
      	
    }

    

}