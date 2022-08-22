@isTest
private class EventCalendarController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Flame_Event__c flame_event_Obj = new Flame_Event__c(IsActive__c = false);
    Insert flame_event_Obj; 
    test.stopTest();
  }
  static testMethod void test_init_UseCase1(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT IsActive__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    PageReference pageRef = Page.Flame_Event_Detail_Page;
    pageRef.getParameters().put('eid','test');
    Test.setCurrentPage(pageRef);
    EventCalendarController obj01 = new EventCalendarController();
    obj01.events = new list <EventCalendarController.CalendarEvent>();
    obj01.eventIdTemp = 'test data';
    obj01.st = 'test data';
    obj01.ed = 'test data';
    obj01.eventList = new List <Flame_Event__c>();
    obj01.init();
  }
  static testMethod void test_pageLoad_UseCase1(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT IsActive__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    PageReference pageRef = Page.Flame_Event_Detail_Page;
    pageRef.getParameters().put('eid','test');
    Test.setCurrentPage(pageRef);
    EventCalendarController obj01 = new EventCalendarController();
    obj01.events = new list <EventCalendarController.CalendarEvent>();
    obj01.eventIdTemp = 'test data';
    obj01.st = 'test data';
    obj01.ed = 'test data';
    obj01.eventList = new List <Flame_Event__c>();
    obj01.pageLoad();
  }
  static testMethod void test_eventDetails_UseCase1(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT IsActive__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    PageReference pageRef = Page.Flame_Event_Detail_Page;
    pageRef.getParameters().put('eid','test');
    Test.setCurrentPage(pageRef);
    EventCalendarController obj01 = new EventCalendarController();
    obj01.events = new list <EventCalendarController.CalendarEvent>();
    obj01.eventIdTemp = 'test data';
    obj01.st = 'test data';
    obj01.ed = 'test data';
    obj01.eventList = new List <Flame_Event__c>();
    EventCalendarController.CalendarEvent obj81 = new EventCalendarController.CalendarEvent();
    obj81.eventId = 'test data';
    obj81.eventTitle = 'test data';
    obj81.eventStart = 'test data';
    obj81.url = 'test data';
    obj81.className = 'test data';
   // obj81.eventlists = flame_event_Obj;
   // obj81.eventDetails();
  }
  static testMethod void test_subnewEvents_UseCase1(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT IsActive__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    PageReference pageRef = Page.Flame_Event_Detail_Page;
    pageRef.getParameters().put('eid','test');
    Test.setCurrentPage(pageRef);
    EventCalendarController obj01 = new EventCalendarController();
    obj01.events = new list <EventCalendarController.CalendarEvent>();
    obj01.eventIdTemp = 'test data';
    obj01.st = 'test data';
    obj01.ed = 'test data';
    obj01.eventList = new List <Flame_Event__c>();
    EventCalendarController.CalendarEvent obj81 = new EventCalendarController.CalendarEvent();
    obj81.eventId = 'test data';
    obj81.eventTitle = 'test data';
    obj81.eventStart = 'test data';
    obj81.url = 'test data';
    obj81.className = 'test data';
   // obj81.eventlists = flame_event_Obj;
  //  obj81.subnewEvents();
  }
  static testMethod void test_viewallevents_UseCase1(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT IsActive__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    PageReference pageRef = Page.Flame_Event_Detail_Page;
    pageRef.getParameters().put('eid','test');
    Test.setCurrentPage(pageRef);
    EventCalendarController obj01 = new EventCalendarController();
    obj01.events = new list <EventCalendarController.CalendarEvent>();
    obj01.eventIdTemp = 'test data';
    obj01.st = 'test data';
    obj01.ed = 'test data';
    obj01.eventList = new List <Flame_Event__c>();
    EventCalendarController.CalendarEvent obj81 = new EventCalendarController.CalendarEvent();
    obj81.eventId = 'test data';
    obj81.eventTitle = 'test data';
    obj81.eventStart = 'test data';
    obj81.url = 'test data';
    obj81.className = 'test data';
  //  obj81.eventlists = flame_event_Obj;
  //  obj81.viewallevents();
  }
}