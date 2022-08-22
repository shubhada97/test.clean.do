public with sharing class ChatterController {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getfollowing()
    {

            Set<Id> idset=new Set<Id>();
            List<String> nameList=new List<String>();
            List<EntitySubscription> listId=[Select ParentId from EntitySubscription  where SubscriberId= '0050p000002j6IAAAY'];
            for(EntitySubscription e:listId)
            {
            
                idset.add(e.ParentId);
            }
            List<Contact> userList=[Select Id, Name from Contact where Id IN :idset];
            
            return userList;

    }

    @AuraEnabled(cacheable = true)
    public static List<Contact> getfollowers()
    {
           
            Set<Id> idset=new Set<Id>();
            List<EntitySubscription> listId=[Select SubscriberId from EntitySubscription  where ParentId= '0050p000002j6IAAAY'];
            for(EntitySubscription e:listId)
            {
            
                idset.add(e.SubscriberId);
            }
            List<Contact> userList=[Select Id, Name from Contact where Id IN :idset];
            return userList;
           
    }
}