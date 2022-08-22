trigger AttachmentTrigger on Attachment (after insert) {    
  
  String keyPrefix = Resource__c.sobjecttype.getDescribe().getKeyPrefix();  //get keyprefix for UW Document
  System.debug('keyPrefix'+keyPrefix);
    Set<Id> attachmentId = new Set<id>();
    for(Attachment objAttach : trigger.New)
    {
      System.debug('Parent Id'+String.valueOf(objAttach.parentId));
      if(String.valueOf(objAttach.parentId).substring(0,3) == keyPrefix)      //Check if attachment is child of UW Document
      {
        attachmentId.add(objAttach.id);  
      }        
    }

    if(trigger.isInsert)
    {
      AttachmentTriggerHandler.uploadAttachmentToDropbox(attachmentId);
    }
    
}