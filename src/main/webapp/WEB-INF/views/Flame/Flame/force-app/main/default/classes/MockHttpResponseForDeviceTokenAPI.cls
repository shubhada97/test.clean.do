@isTest
Global class MockHttpResponseForDeviceTokenAPI implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            String body = '{"deviceId":"68280362ce52055a","deviceToken":"edgsWiQrTIyRxP-DV1VUbW:APA91bGTvOwxMTw6O3Ll2GJJiLiIt8DsMN3unz93ouWzPdZIe9LZW_J07iWhhOnvWdeoLXv4lyv_4vpiXYcyYNapx4cPrrZUOnZJYJziTdGGLE1fKoiqxylgBwQeMEEZHi_oYyj-TJu9","userName":"harshal-flame@techilaservice.com"}';
            res.setBody(body);
            res.setStatusCode(200);
            return res;
        }        
    }