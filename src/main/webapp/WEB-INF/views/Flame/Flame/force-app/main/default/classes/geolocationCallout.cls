public class geolocationCallout {
    
    @future(callout=true)
    static public void newAccmethod(set<id> listOfConIds){
        
        for(Contact c : [SELECT Contact_City__c,Contact_State__c,Contact_Country__c FROM Contact WHERE id =: listOfConIds]){
            
            String address ='';
            
            
            if (c.Contact_City__c != null)
                
                address += c.Contact_City__c +', ';
            
            if (c.Contact_State__c != null)
                
                address += c.Contact_State__c +' ';
            
            if (c.Contact_Zip_Code__c != null)

             address += c.Contact_Zip_Code__c +', ';



            
            
            if (c.Contact_Country__c != null)
                
                address += c.Contact_Country__c;
            
            address = EncodingUtil.urlEncode(address, 'UTF-8');
            
            // build callout
            
            Http h = new Http();
            
            HttpRequest req = new HttpRequest();
            
            req.setHeader('API-KEY', 'AIzaSyDZMrolrF5d2xfNw7l_Wh7jNKLlz5d7PEo');
            
            req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+ address +'&sensor=false');
           // req.setEndpoint('https://api.positionstack.com/v1/forward?access_key=6ef790af3db6013cbb57b94daf50a11f&query='+ address +'');
            
            req.setMethod('GET');
            
            req.setTimeout(5000);
            try{
                
                // callout
                
                HttpResponse res = h.send(req);
                
                // parse coordinates from response
                
                JSONParser parser = JSON.createParser(res.getBody());
                
                double lat = null;
                
                double lon = null;
                
                while (parser.nextToken() != null) {
                    
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                        
                        (parser.getText() == 'location')){
                            
                            parser.nextToken(); // object start
                            
                            while (parser.nextToken() != JSONToken.END_OBJECT){
                                
                                String txt = parser.getText();
                                
                                parser.nextToken();
                                
                                if (txt == 'lat')
                                    
                                    lat = parser.getDoubleValue();
                                
                                else if (txt == 'lng')
                                    
                                    lon = parser.getDoubleValue();
                                
                            }
                            
                        }
                    
                }
                
                // update coordinates if we get back
                
                if (lat != null){
                    
                    system.debug(lat+' '+lon);
                    
                    c.GoogleLatitude__c = String.valueOf(lat);
                    system.debug(c.GoogleLatitude__c+'c.GoogleLatitude__c');
                    
                    c.GoogleLongitude__c = String.valueOf(lon);
                    system.debug(c.GoogleLongitude__c +'c.GoogleLongitude__c');
                    //update c;
                    
                }
                
            }
            
            catch (Exception e) {
                
                system.debug(e);
                
            }
            
        }
        
    }
    
    
    
}