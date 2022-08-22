@isTest
global class CommunityUserValidatorMock implements HttpCalloutMock   {
global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('Valid');
        response.setStatusCode(200);
        return response; 
    
}
}