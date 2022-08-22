@isTest
global class DeleteDataMockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{     "size": "0 bytes",     "is_deleted": true,     "bytes": 0,     "thumb_exists": false,     "rev": "1f33043551f",     "modified": "Wed, 10 Aug 2011 18:21:30 +0000",     "path": "/Salesforce Documents/Contacts/PGB2016004126/PGB2016004126__docs.css",     "is_dir": false,     "icon": "page_white_text",     "root": "dropbox",     "mime_type": "text/plain",     "revision": 492341 }');
        response.setStatusCode(200);
        return response; 
    }
}