@isTest
global class PicklistControllerMock implements HttpCalloutMock {
    
 
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"id": 101,"name": "India","iso2": "IN"}');
        response.setStatusCode(200);
        return response; 
    
}

}