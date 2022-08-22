@isTest
public class DeviceTokenStoreForPushNotificationTest {
    
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            String body = '{"deviceId":"68280362ce52055a","deviceToken":"edgsWiQrTIyRxP-DV1VUbW:APA91bGTvOwxMTw6O3Ll2GJJiLiIt8DsMN3unz93ouWzPdZIe9LZW_J07iWhhOnvWdeoLXv4lyv_4vpiXYcyYNapx4cPrrZUOnZJYJziTdGGLE1fKoiqxylgBwQeMEEZHi_oYyj-TJu9","userName":"harshal-flame@techilaservice.com"}';
            res.setBody(body);
            res.setStatusCode(200);
            return res;
        }        
    }
    
    @isTest static  void testGetCallout() {
        
        Profile p                           = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u                              = new User(Alias = 'standt', Email='test1@test.com', 
                                                       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                                       LocaleSidKey='en_US', ProfileId = p.Id,                                               
                                                       TimeZoneSidKey='America/Los_Angeles', UserName='standarduserj@testorg.com');
        insert u;
        
        Device_token__c dt = new Device_token__c();
        dt.DeviceId__c ='68280362ce52055a';
        dt.Device_Token__c ='edgsWiQrTIyRxP-DV1VUbW:APA91bGTvOwxMTw6O3Ll2GJJiLiIt8DsMN3unz93ouWzPdZIe9LZW_J07iWhhOnvWdeoLXv4lyv_4vpiXYcyYNapx4cPrrZUOnZJYJziTdGGLE1fKoiqxylgBwQeMEEZHi_oYyj-TJu9';
        dt.User__c =u.Id;
        dt.UserName__c =u.Username;
        insert dt;
        
        
        
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());  
        RestRequest request = new RestRequest();
        
        request.requestUri ='https://techila-flameu.cs74.force.com/notification/services/apexrest/deviceToken';
        
        request.httpMethod = 'POST';
        String status = 'Update';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(JSON.serializePretty(status)); 
        
        RestResponse res = new RestResponse();
        RestContext.request = request;
        RestContext.response = res;
        
        DeviceTokeStoreForPushNotificationAPI.doGetAndSaveDeviceToken(dt.DeviceId__c,dt.Device_Token__c,dt.UserName__c);
        
        
        Test.stopTest();
    }   
    
    @isTest static  void testGetCallout1() {
        
        
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());  
        RestRequest request = new RestRequest();
        
        request.requestUri ='https://techila-flameu.cs74.force.com/notification/services/apexrest/deviceToken';
        
        request.httpMethod = 'POST';
        String status = 'Insert';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(JSON.serializePretty(status)); 
        
        RestResponse res = new RestResponse();
        RestContext.request = request;
        RestContext.response = res;
        
        Profile p                           = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u                              = new User(Alias = 'standt', Email='test1@test.com', 
                                                       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                                       LocaleSidKey='en_US', ProfileId = p.Id,                                               
                                                       TimeZoneSidKey='America/Los_Angeles', UserName='standarduserj@testorg.com');
        insert u;
        
        Device_token__c dt1 = new Device_token__c();
        
        DeviceTokeStoreForPushNotificationAPI.doGetAndSaveDeviceToken(dt1.DeviceId__c,dt1.Device_Token__c,u.UserName);
        
        Test.stopTest();
    }   
}