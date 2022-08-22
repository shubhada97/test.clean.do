@isTest
global class GDriveDataCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"files":["id":"1BSH3tGl-F2z7DfX2g-LaThQPsQksXi-Ab7jPWdr3LEQ","name":"Flame-Wifi"]}');
        res.setStatusCode(200);
        return res;
    }
}