@isTest
class Mobilemessagecallout_Test
{    
    
    public class MockHttpResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            String body = '{"to" : "/topics/flame_notify_all","notification" : {"body" : "Body of Your Notification","title": "Title of Your Notification"},"data" : {"body" : "Notification Body","title": "Notification Title","key_1" : "Value for key_1","key_2" :"Value for key_2"}}';
            res.setBody(body);
            res.setStatusCode(200);
            return res;
        }
        
    }
    
    
    
    static testMethod void Flame_Message_Test()
    {
        //User
        Profile p                           = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u                              = new User(Alias = 'standt', Email='test1@test.com', 
                                                       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                                       LocaleSidKey='en_US', ProfileId = p.Id,                                               
                                                       TimeZoneSidKey='America/Los_Angeles', UserName='standarduserj@testorg.com');
        insert u;
        
        device_token__c dt = new device_token__c();
        dt.DeviceId__c = '68280362ce52055a';
        dt.Device_Token__c ='edgsWiQrTIyRxP-DV1VUbW:APA91bGTvOwxMTw6O3Ll2GJJiLiIt8DsMN3unz93ouWzPdZIe9LZW_J07iWhhOnvWdeoLXv4lyv_4vpiXYcyYNapx4cPrrZUOnZJYJziTdGGLE1fKoiqxylgBwQeMEEZHi_oYyj-TJu9';
        dt.User__c  = u.Id;
        dt.UserName__c = u.Name;
        insert dt;
        
        Mobile_Notification__c mn= new Mobile_Notification__c(); 
        
        mn.Message__c='Test Holiday message';
        mn.Status__c='Sent';
        mn.Sent_Time__c=system.now();
        mn.Title__c='Test Holiday message';
        insert mn;
        
        set<Id> mobileNotIds = new set<Id>();
        mobileNotIds.add(mn.Id);
        set<String> userIds = new set<String>();
        userIds.add(u.Id);
        if(userIds!= null){
            userIds.remove(null);
        }
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());           
        Mobilemessagecallout.NotificationCalloutmethod(mobileNotIds, userIds);
        Mobilemessagecallout.NotificationCalloutmethod(mobileNotIds, null);
        
        Test.stopTest();
    } 
    
}