public class AttachmentTriggerHandler {
    public static string dropboxToken;
  @Future(callout=true)
    public static void uploadAttachmentToDropbox(Set<Id> attachmentId)
    {
        Attachment objAttach = new Attachment();
        List<Resource__c> resourceList= new List<Resource__c>();
       try{
                
               String inputPath;
               dropboxToken = getDropboxToken();
               if(dropboxToken != null || dropboxToken != '')
               {
                  List<Attachment> attachList = new List<Attachment>();
                  attachList = [select id,Name,ParentId,ContentType,Body,BodyLength from Attachment where id IN: attachmentId];
                  for(Attachment objAttachment : attachList)
                 {
                     String attachmentName = System.now()+' '+objAttachment.Name;
                     String tokenuri = 'https://content.dropboxapi.com/2/files/upload';
                     inputPath = '{"path":"/Flame Respurces/'+attachmentName+'","mode": "add","autorename": true,"mute": false}';
                     HttpRequest request = new HttpRequest();
                     request.setEndpoint(tokenuri);
                     request.setMethod('POST');
                     request.setHeader('Authorization','Bearer '+dropboxToken);
                     request.setHeader('Content-Type', 'application/octet-stream');
                     request.setHeader('Dropbox-API-Arg',inputPath);
                     request.setBodyAsBlob(objAttachment.Body);        
                     request.setTimeout(12000);
                     Http hpPut = new Http();
                     HttpResponse responseFile;
                     String jsonFileRes;
           if(!test.isRunningTest()){
                        responseFile = hpPut.send(request);
                        jsonFileRes = responseFile.getBody();
                      }else{
                            jsonFileRes = '{"url": "http://www.google.com", "path_lower":"dropbox/salesforce"}';
                      }
                     //jsonFileRes = responseFile.getBody();
                     System.debug('jsonFileRes ->'+jsonFileRes);

                     String filePath;
                     Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(jsonFileRes);
                     if(jsonMap.get('path_lower')!= null){
                         filePath = (String)jsonMap.get('path_lower');
                     }

                      String imageuri = 'https://api.dropboxapi.com/2/sharing/create_shared_link_with_settings';
                      HttpRequest requestForUrl = new HttpRequest();
                      //imageuri+=filePath+'?short_url=false';
                      requestForUrl.setEndpoint(imageuri);
                      requestForUrl.setMethod('POST');
                      requestForUrl.setHeader('Authorization','Bearer '+dropboxToken);
                      requestForUrl.setHeader('Content-Type','application/json');        
                      inputPath = '{"path":"'+filePath+'" ,"settings": {"requested_visibility": "public"}}'; 
                      requestForUrl.setBody(inputPath);        
                      requestForUrl.setTimeout(12000);
                      Http hp = new Http();
                      HttpResponse response;
                      String jsonRes;
                      if(!test.isRunningTest()){
                        response = hp.send(requestForUrl);
                        jsonRes = response.getBody();
                      }else{
                            jsonRes = '{"url": "http://www.google.com", "path":"dropbox/salesforce"}';
                      }
                      System.debug('response body -->> '+jsonRes);

                      String jsonURL;
                      Map<String, Object> jsonURLMap = (Map<String, Object>)JSON.deserializeUntyped(jsonRes);
                      if(jsonURLMap.get('url')!= null)
                      {
                          jsonURL = (String)jsonURLMap.get('url');
                          jsonURL = jsonURL.replace('?dl=0', '?dl=1');
                          System.debug('url -->> '+jsonURL);
                      }

                      Resource__c objResource = new Resource__c();
                      objResource.id = objAttachment.parentId;
                      objResource.URL__c = jsonURL;
                      //objUWDocument.Display_Size__c = FileSizeToString(objAttachment.BodyLength);
                      objResource.File_Type__c = objAttachment.ContentType;
                      resourceList.add(objResource);
                }
                System.debug('resourceList-->'+resourceList);
                if(resourceList.size()>0)
                {
                  update resourceList;  
                }                             
          }
        }   
        catch(Exception e)
        {
           System.debug('Error-->'+e.getLineNumber() +'\n  '+e.getMessage());
        }        
    }
    
    public static string getDropboxToken(){
        if(!test.isRunningTest()){
            return [SELECT Access_Token__c FROM Dropbox_Settings__c LIMIT 1].Access_Token__c;
        }else{
            return null;
        }
    }

    /*public static String FileSizeToString(Long Value){
        // string representation if a file's size, such as 2 KB, 4.1 MB, etc 
        if (Value < 1024)
          return string.valueOf(Value) + ' Bytes';
        else if (Value >= 1024 && Value < (1024*1024)){
          //KB
          Decimal kb = Decimal.valueOf(Value);
          kb = kb.divide(1024,2);
          return string.valueOf(kb) + ' KB';
        }
        else if (Value >= (1024*1024) && Value < (1024*1024*1024)){
          //MB
          Decimal mb = Decimal.valueOf(Value);
          mb = mb.divide((1024*1024),2);
          return string.valueOf(mb) + ' MB';
        }
        else{
          //GB
          Decimal gb = Decimal.valueOf(Value);
          gb = gb.divide((1024*1024*1024),2);
         
          return string.valueOf(gb) + ' GB';
        }    
    }*/
}