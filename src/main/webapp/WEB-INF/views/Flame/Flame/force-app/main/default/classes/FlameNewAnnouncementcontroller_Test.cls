@isTest
private class FlameNewAnnouncementcontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Flame_Announcement__c flame_announcement_Obj = new Flame_Announcement__c(Content__c = '14', Heading__c = 'Headi879', Image__c = '16', IsActive__c = false, Role__c = 'Student');
    Insert flame_announcement_Obj; 
    test.stopTest();
  }
  static testMethod void test_save_UseCase1(){
    List<Flame_Announcement__c> flame_announcement_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Announcement__c];
    System.assertEquals(true,flame_announcement_Obj.size()>0);
    FlameNewAnnouncementcontroller obj01 = new FlameNewAnnouncementcontroller();
    obj01.emp = flame_announcement_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
   // obj01.save();
  }
  static testMethod void test_closePopup_UseCase1(){
    List<Flame_Announcement__c> flame_announcement_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Announcement__c];
    System.assertEquals(true,flame_announcement_Obj.size()>0);
    FlameNewAnnouncementcontroller obj01 = new FlameNewAnnouncementcontroller();
    obj01.emp = flame_announcement_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
    obj01.closePopup();
  }
  static testMethod void test_Requesttosend_UseCase1(){
    List<Flame_Announcement__c> flame_announcement_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Announcement__c];
    System.assertEquals(true,flame_announcement_Obj.size()>0);
    FlameNewAnnouncementcontroller obj01 = new FlameNewAnnouncementcontroller();
    obj01.emp = flame_announcement_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
   // obj01.Requesttosend();
  }
  static testMethod void test_getSearchError_UseCase1(){
    List<Flame_Announcement__c> flame_announcement_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Announcement__c];
    System.assertEquals(true,flame_announcement_Obj.size()>0);
    FlameNewAnnouncementcontroller obj01 = new FlameNewAnnouncementcontroller();
    obj01.emp = flame_announcement_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
    obj01.getSearchError();
  }
}