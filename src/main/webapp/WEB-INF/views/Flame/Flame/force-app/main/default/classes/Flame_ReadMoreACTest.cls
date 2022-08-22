@isTest
public class Flame_ReadMoreACTest {
    public static testMethod void ReadMore(){
        Flame_Announcement__c flameAnn = new Flame_Announcement__c();
        flameAnn.Content__c = 'testAnnounce';
        flameAnn.Heading__c = 'announceHead';
        flameAnn.IsActive__c = true;
        flameAnn.Role__c = 'Student';
        insert flameAnn;
        
        ApexPages.currentPage().getParameters().put('oname', 'Flame_Announcement__c');
        ApexPages.currentPage().getParameters().put('rid',flameAnn.Id);
        Flame_ReadMoreAC rm = new Flame_ReadMoreAC();
    }
}