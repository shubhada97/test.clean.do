//Developer Name: Shubhada Kurumkar

public without sharing class MyGroupController {
//account controller class
    @AuraEnabled(cacheable = true)
    public static List<CollaborationGroup> getCollaborationGroup()
    {
            return [SELECT Id, Name, MemberCount FROM CollaborationGroup  ];
    }
}