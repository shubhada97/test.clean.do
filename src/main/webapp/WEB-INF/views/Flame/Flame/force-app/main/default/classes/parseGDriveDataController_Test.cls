@isTest
 public class parseGDriveDataController_Test {
    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            System.debug('End Point::'+req.getEndpoint());
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            if(req.getEndpoint() == 'callout:GoogleSheet/14jtWQT7ih9gpeEhShX4mdRjOoNLSA7LQEXZeqbBgs34/values/A2:G1009'){
                
                res.setBody('{"range": "Sheet1!A2:G1000","majorDimension": "ROWS","values": [["2022-06-27 22:20:00","Firewall Authentication","Information","User akshanth.gunda was logged out of firewall","k.vedanti666","172.16.136.137","Successful"]]}');
                
            }else if(req.getEndpoint() == 'callout:GoogleSheet'){
                
                res.setBody('{"properties":{"title": "Flame-RawEmployee"}}');
                
            }else{
                res.setBody('{"files": [{"id": "14jtWQT7ih9gpeEhShX4mdRjOoNLSA7LQEXZeqbBgs34","name": "Flame-Wifi-New"}]}');
            }
            
            return res;
        }
    }
     
     
    public class ExampleCalloutMock1 implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            System.debug('End Point1::'+req.getEndpoint());
            if(req.getEndpoint() == 'callout:GoogleSheet'){
                res.setBody('{"properties":{"title": "Flame-RawEmployee"}}');  
            }else{
                res.setBody('{"majorDimension":"ROWS","range": "Sheet1!A1:G109","values":[["Timelog__c","Event_Type__c","Severity__c","Message__c","User_Name__c","Source__c","Status__c"],["2022-06-28 08:58:00","Firewall Authentication","Information","User aahi.kelkar of group UGLE-2020 logged in successfully to Firewall through Local authentication mechanism from 172.16.139.152","annabelleallen99","172.16.139.152","Successful"]]}');
            }
            return res;
        }
    }
    
    static testmethod void testsample(){  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
		parseGDriveDataController.getDriveSheetFiles();
        Test.stopTest();
    }
     static testmethod void testsample1(){  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock1());
		parseGDriveDataController.createExcelSheetInDrive();
        Test.stopTest();
    }
     
     
 }