@RestResource(urlMapping='/validateuser')
global with sharing class CommunityUserValidator {
  @HttpGet
    global static string doGet() {
       	String usrnm = RestContext.request.params.get('username');
        String pwd = RestContext.request.params.get('password');
        
        String orgId = label.FlameComm_orgId;
        String communityUrl = label.FlameComm_Url;
        
       
        Http http = new Http();
        HttpRequest request = new HttpRequest();
       // request.setEndpoint(communityUrl+'/services/Soap/u/48.0');
        request.setEndpoint(communityUrl+'/services/Soap/u/48.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml');
        request.setHeader('SOAPAction', '""');
        
        request.setBody('<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:partner.soap.sforce.com">'+ 
          '<SOAP-ENV:Header>'+
            '<ns1:LoginScopeHeader>'+
                '<ns1:organizationId>'+orgId+'</ns1:organizationId>'+
            '</ns1:LoginScopeHeader>'+
          '</SOAP-ENV:Header>'+
           '<SOAP-ENV:Body>'+
           '<ns1:login> '+
                 '<ns1:username>'+usrnm+'</ns1:username>  '+
                 '<ns1:password>'+pwd+'</ns1:password> '+
             '</ns1:login>  '+
           '</SOAP-ENV:Body>'+
           '</SOAP-ENV:Envelope>');
        
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if(response.getStatusCode() != 200) {
            return 'Invalid';
        } else {
            return 'Valid';
        }
        //turn response;   
    }

}