public class ContentVersionTriggerHandler {
    
    private boolean Image = True;
    private integer BatchSize = 0;
  
    public ContentVersionTriggerHandler(boolean isExecuting, integer size)
    {
        Image = isExecuting;
        BatchSize = size;
    }
    
    public void OnBeforeUpdate(list<ContentVersion> triggerNew, map<id,ContentVersion> triggerNewMap, map<id,ContentVersion> triggerOldMap)
    {
       // call Before update Method
        updatePhotoUrlOnContact(triggerNew,triggerNewMap);
       
    }
    
   public void OnAfterInsert(list<ContentVersion> triggerNew, map<id,ContentVersion> triggerNewMap)
    {
        // call After Insert Method
         updatePhotoUrlOnContact(triggerNew,triggerNewMap);
    }
    
    private void updatePhotoUrlOnContact(list<ContentVersion> lstofContentVersion ,map<id,ContentVersion> mapofIdToContentVersion)
    {
        Set<Id> contentDocumentIdSet = new Set<Id>();
        Map<Id,Contact> mapofConIdToContact = new map<Id,Contact>();
        Map<Id,Id> mapOfContentDocumentIdToContactId = new Map<Id,Id>();
        List<Contact> lstContactToUpdate = new list<contact>();

        for(ContentVersion cv:lstofContentVersion)
        {
           if(cv.ContentDocumentId != null)
            {
                contentDocumentIdSet.add(cv.ContentDocumentId);
            }
                system.debug('cv'+cv.id);
        }
        
        system.debug('contentDocumentIdSet'+contentDocumentIdSet);
        List<ContentDocumentLink> lstContentDocumentLink = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE
        ContentDocumentId IN:contentDocumentIdSet];

        system.debug('List Content Document Link'+lstContentDocumentLink);

        for(ContentDocumentLink eachLink : lstContentDocumentLink){
            if(eachLink.LinkedEntityId != null && String.valueOf(eachLink.LinkedEntityId).startsWith('003')){
                mapOfContentDocumentIdToContactId.put(eachLink.ContentDocumentId, eachLink.LinkedEntityId);
        }   
        }

        for(ContentVersion eachContentVersion : lstofContentVersion){
            if(eachContentVersion.title.endsWith('Photograph'))
            if(eachContentVersion.Id != Null && mapOfContentDocumentIdToContactId.containsKey(eachContentVersion.ContentDocumentId)
            && mapOfContentDocumentIdToContactId.get(eachContentVersion.ContentDocumentId) != null){
                Id idContact = mapOfContentDocumentIdToContactId.get(eachContentVersion.ContentDocumentId);
                string strUrl = Label.ContactPhotoBaseUrl+eachContentVersion.id; 
                system.debug('Contact Id: ' + idContact );
                lstContactToUpdate.add(new Contact(Id = idContact, 
                Contact_Photo_Url__c = strUrl
                ));   

            }
        }
        system.debug(' List of Contact to Update: '+ lstContactToUpdate);
        set<id>setofConId = new set<Id>();
        list<contact> lstofContact = new list<Contact>();
        if(lstContactToUpdate != Null && lstContactToUpdate.size() > 0 )
          for(contact objCon:lstContactToUpdate )
          {
              if(!setofConId.contains(objCon.id)){
              
                  setofConId.add(objCon.id);
                  lstofContact.add(objCon);
              }
                   
          }
          if(lstofContact != null && lstofContact.size()>0)
            update lstofContact ;
    }
 
}