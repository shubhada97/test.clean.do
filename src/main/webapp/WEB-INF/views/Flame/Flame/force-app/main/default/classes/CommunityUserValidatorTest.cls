@isTest
public class CommunityUserValidatorTest {

    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            String body = '{"test"}';
            res.setBody(body);
            res.setStatusCode(200);
            return res;
        }        
    }
    
    @isTest static  void testGetCallout() {
       
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());  
        RestRequest request = new RestRequest();
     
        request.requestUri =
            Label.FlameComm_Url+'/services/apexrest/validateuser';
            
        request.httpMethod = 'GET';
        
        request.params.put('username', 'twedwed@sdfsdf.sdf');
        request.params.put('password', 'tgs');
        
        RestContext.request = request;
     
        
		CommunityUserValidator.doGet();
    }   

}