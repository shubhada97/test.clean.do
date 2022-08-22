trigger MobileNotificationtrigger on Mobile_Notification__c (after insert) {
    Set<Id> MNSetId= new Set<Id>();
    Set<String> userIds= new Set<String>();
    if(trigger.isafter && trigger.isInsert)
    {
        for(Mobile_Notification__c mn:trigger.new){
            MNSetId.add(mn.Id);
            userIds.add(mn.Users__c);
        }
    }
    if(!MNSetId.IsEmpty())
    {
        system.debug('MNSetId-->'+MNSetId);
        system.debug('userIds-->'+userIds);
        Mobilemessagecallout.NotificationCalloutmethod(MNSetId,userIds);
    }
    
}