@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{   "revision": 123,   "bytes": 56204,   "thumb_exists": false,   "rev": "7b20c30805",   "modified": "Wed, 20 Apr 2016 07:27:54 +0000",   "shareable": false,   "mime_type": "application/pdf",   "path": "/Baneshwar/Test/response.pdf",   "is_dir": false,   "size": "54.9 KB",   "root": "dropbox",   "client_mtime": "Wed, 20 Apr 2016 07:27:54 +0000",   "icon": "page_white_acrobat" }');
        response.setStatusCode(200);
        return response; 
    }
}