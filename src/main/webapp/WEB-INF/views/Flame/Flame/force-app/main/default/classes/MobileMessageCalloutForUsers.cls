public class MobileMessageCalloutForUsers {
    
     @future(callout=true)
    public static void NotificationCalloutmethod1(Set<Id> messageId, Set<String> userIds)
    {   
       
        system.debug('Mobile Notification Id :::->' + messageId);
        String strResponse;
        JSONGenerator gen;
        HttpRequest req;
        HttpResponse res;
        Http http;  
        userIds.remove(null); 
        Integer sizeOfUsersId = userIds.size();
        system.debug('sizeOfUsersId-->'+sizeOfUsersId);
        system.debug('Size OF UserIds-->'+userIds.size());
        if(userIds.size() > 0){
        try 
        { 
            system.debug('If');
            system.debug('userIds-->'+userIds);
            List<String> listUserIds = new List<String>(userIds);
            List<String> splitUserIds = listUserIds[0].split(',');
            system.debug('splitUserIds-->'+splitUserIds);
            
            Set<String>  userIdsSet  = new Set<String>(splitUserIds);
            system.debug('userIdsSet-->'+userIdsSet);
            
            List<Device_Token__c> deviceTokenList= [select Id, Name, Device_Token__c,deviceId__c from Device_Token__c 
                                                    where User__c IN: userIdsSet ]; 
            system.debug('deviceTokenList-->'+deviceTokenList);
         
            List<Mobile_Notification__c> updatelist= new List<Mobile_Notification__c>(); 
            map<id,Mobile_Notification__c> mbMap = new map<id,Mobile_Notification__c>();
            if(deviceTokenList.size()>0){
            for(Mobile_Notification__c  m: [Select Id, Name,Message__c,Status__c,Sent_Time__c,Title__c from Mobile_Notification__c where Id IN :messageId])
            {
                for(Device_Token__c dt: deviceTokenList){
                    
                String senttime=string.valueof(m.Sent_Time__c);
                gen = JSON.createGenerator(false); // JSON content creator class.
                gen.writeStartObject();   // creating JSON body below line is used to generate '{' symbol.
                gen.writeStringField('to',dt.Device_Token__c);  // Used to we can say child field name ex. 'to:cuGZkByq_Uqij7-Fvy2jx4:APA91bHHUfcGYk-I7DZ25dRweUb3MHnzKbMRYfp4t4Z87FS8XtwIfvjtgrh28MZqa8nv8g0OU13QWSeM9lKIXOX7PeWbPk0OR5MeJmewWYA97cfPA_AcsblW9iWi-NAdIwqyHi3rIoNC".
                gen.writeFieldName('notification'); // we can say parent field name ex. notification {"body":"Notification body","title":"Notification Tile"}
                gen.writeStartObject();  
                gen.writeStringField('body', m.Message__c);
                gen.writeStringField('title', m.Title__c);
                gen.writeEndObject();                
                gen.writeFieldName('data');  // we can say parent field name ex. notification {"body":"Notification body","title":"Notification Tile"}
                gen.writeStartObject();
                gen.writeStringField('body', m.Message__c);
                gen.writeStringField('title', m.Title__c);
                gen.writeStringField('key_1', 'Value for key_1');
                gen.writeStringField('key_2', 'Value for key_2');
                gen.writeEndObject();               
                gen.writeEndObject();

                system.debug('Json body ->' +gen.getAsString());
                
                req = new HttpRequest();
                res = new HttpResponse();
                http = new Http();
                req.setHeader('Authorization', 'key=AAAAdSGWiO4:APA91bEe3KjQRs2T-g837U_KO7Zl68oNiaZymG2tsDc4Jb5f05Za3oRYXLfEMp4BSzsbClBOyGKmLu21hsan2S071XSIknuFgyHD75YND6bGBXdpdlZ2ULZz1IGO52cc4xTOM5yIsyfS');  //AAAAHVWcuy0:APA91bH22ETFLTWc0Z0kVfnJyPcoWZkC73RdZ3riBaBN1pquzqcZ3OJJgYQrjTRL7eeZv4ngUuQ0fjlj-UKgUU5zWhw43yuZ9ov_oBWEWClY3uQTpFQU27dNqKL2LhiBxJtcysOLWzkW            
                req.setHeader('Content-Type','application/json');  
                req.setEndpoint(Label.Mobile_Notification_Endpint);
                req.setMethod('POST');
                req.setTimeout(60000);             
                req.setBody(gen.getAsString());
                res = http.send(req);
                strResponse = res.getBody();
                
                if(res.getStatusCode() == 200 && strResponse != null && strResponse != '' && !strResponse.containsIgnoreCase('Error')) {                    
                    m.Status__c='Sent';                    
                }
                else {               
                    m.Status__c='Failed';
                }
                m.Sent_Time__c=system.now();
                m.Response_Payload__c=strResponse;
                updatelist.add(m);
                 mbMap.putAll(updatelist);
                system.debug('updatelist-->'+updatelist);
                system.debug('mbMap-->'+mbMap);
            }
        }
             }
            if(mbMap.size()>0)
            {
                update mbMap.values();
            }
            system.debug('getStatusCode ->' +res.getStatusCode() );        
            system.debug('Response ->' + strResponse );   
            
        }
        catch(Exception e) {
            System.Debug('Exception..'+e.getMessage());
           
        }
        }
        else{
            try 
        {
            system.debug('Else');
            system.debug('userIds-->'+userIds);
            List<Mobile_Notification__c> updatelist= new List<Mobile_Notification__c>();                                           
            for(Mobile_Notification__c  m: [Select Id, Name,Message__c,Status__c,Sent_Time__c,Title__c from Mobile_Notification__c where Id IN :messageId])
            {
                String senttime=string.valueof(m.Sent_Time__c);
                gen = JSON.createGenerator(false);
                
                gen.writeStartObject();
                gen.writeStringField('to','/topics/flame_notify_all');
                gen.writeFieldName('notification');
                gen.writeStartObject();
                gen.writeStringField('body', m.Message__c);
                gen.writeStringField('title', m.Title__c);
                gen.writeEndObject();                
                gen.writeFieldName('data');
                gen.writeStartObject();
                gen.writeStringField('body', m.Message__c);
                gen.writeStringField('title', m.Title__c);
                gen.writeStringField('key_1', 'Value for key_1');
                gen.writeStringField('key_2', 'Value for key_2');
                gen.writeEndObject();               
                gen.writeEndObject();

                system.debug('Json body ->' +gen.getAsString());
                
                req = new HttpRequest();
                res = new HttpResponse();
                http = new Http();
                req.setHeader('Authorization', 'key=AAAAdSGWiO4:APA91bEe3KjQRs2T-g837U_KO7Zl68oNiaZymG2tsDc4Jb5f05Za3oRYXLfEMp4BSzsbClBOyGKmLu21hsan2S071XSIknuFgyHD75YND6bGBXdpdlZ2ULZz1IGO52cc4xTOM5yIsyfS');  //AAAAHVWcuy0:APA91bH22ETFLTWc0Z0kVfnJyPcoWZkC73RdZ3riBaBN1pquzqcZ3OJJgYQrjTRL7eeZv4ngUuQ0fjlj-UKgUU5zWhw43yuZ9ov_oBWEWClY3uQTpFQU27dNqKL2LhiBxJtcysOLWzkW            
                req.setHeader('Content-Type','application/json');  
                req.setEndpoint(Label.Mobile_Notification_Endpint);
                req.setMethod('POST');
                req.setTimeout(60000);             
                req.setBody(gen.getAsString());
                res = http.send(req);
                strResponse = res.getBody();
                
                if(res.getStatusCode() == 200 && strResponse != null && strResponse != '' && !strResponse.containsIgnoreCase('Error')) {                    
                    m.Status__c='Sent';                    
                }
                else {               
                    m.Status__c='Failed';
                }
                m.Sent_Time__c=system.now();
                m.Response_Payload__c=strResponse;
                updatelist.add(m);
            }
            if(!updatelist.IsEmpty())
            {
                update updatelist;
            }
            system.debug('For All users getStatusCode ->' +res.getStatusCode() );        
            system.debug('For All users Response ->' + strResponse );
            
        } catch(Exception e) {
            System.Debug('Exception..'+e.getMessage());
           
        }
            
        }
        
    }

}