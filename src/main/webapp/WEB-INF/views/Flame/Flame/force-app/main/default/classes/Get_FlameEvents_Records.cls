public class Get_FlameEvents_Records {
    @AuraEnabled(cacheable=true)
    public static List<Flame_Event__c> listOfAnnouncement(){
        List<Flame_Event__c> myEventList = [SELECT Id,Heading__c,Content__c,IsActive__c,OwnerId,RecordType.Name FROM Flame_Event__c WHERE IsActive__c = true AND RecordType.Name = 'Announcement'];
        return myEventList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Flame_Event__c> listOfNews(){
        List<Flame_Event__c> myEventList = [SELECT Id,Heading__c,Content__c,IsActive__c,OwnerId,RecordType.Name FROM Flame_Event__c WHERE IsActive__c = true AND RecordType.Name= 'News'];
        return myEventList;
    }
}