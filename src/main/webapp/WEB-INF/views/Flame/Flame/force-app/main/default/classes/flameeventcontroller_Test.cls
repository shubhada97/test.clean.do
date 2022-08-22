@isTest (seeAllData=true)
private class flameeventcontroller_Test{
 
    
  static void setupTestData(){
    test.startTest();
      
    Flame_Event__c flame_event_Obj = new Flame_Event__c();
    flame_event_Obj.Content__c = '14';
    flame_event_Obj.Event_Date__c = Date.today();
    flame_event_Obj.Heading__c = 'Headi527'; 
    flame_event_Obj.Image__c = '17'; 
    flame_event_Obj.IsActive__c = false;
    flame_event_Obj.RecordTypeId =  Schema.sObjectType.Flame_Event__c.getRecordTypeInfosByName().get('Event').getRecordTypeId();
    flame_event_Obj.RecordTypeId =  Schema.sObjectType.Flame_Event__c.getRecordTypeInfosByName().get('Announcement').getRecordTypeId();
    flame_event_Obj.RecordTypeId =  Schema.sObjectType.Flame_Event__c.getRecordTypeInfosByName().get('News').getRecordTypeId();
    flame_event_Obj.Role__c = 'Student';
    insert flame_event_Obj;
    List<Flame_Event__c> flame_event_Obj1  =  [SELECT Content__c,Event_Date__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj1.size()>0);
    
 
    Attachment objAttach = new Attachment();
        objAttach.Name = 'Unit Test Attachment Body';
        objAttach.ParentId = flame_event_Obj.Id; // the record the file is attached to
        Blob fileBody=Blob.valueOf('Unit Test Attachment Body');
      system.debug('fileBody-->'+fileBody);
        objAttach.Body =fileBody;
        insert objAttach;
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:flame_event_Obj.Id];
        System.assertEquals(1, attachments.size()); 
    test.stopTest();
  }
  static testMethod void test_save_UseCase1(){
      
    List<Flame_Event__c> flame_event_Obj  =  [SELECT Content__c,Event_Date__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    System.assertNotEquals(null, flame_event_Obj[0].Id);
    flameeventcontroller obj01 = new flameeventcontroller();
    obj01.emp = flame_event_Obj[0];
      PageReference pageRef = Page.Flame_successful_message;
        Test.setCurrentPage(pageRef);
         PageReference pageRef1 = Page.Flame_Home;
        Test.setCurrentPage(pageRef1);
   // Test.startTest();
    flameeventcontroller obj0 = new flameeventcontroller();
    Attachment attch = [select id, name, body from Attachment where parent.id=:flame_event_Obj[0].Id limit 1];
      obj0.file = attch.body;
      obj0.emp.content__C = 'ABCD';
      obj0.save();
      
    //  obj0.save1();
    //  obj0.save2();
      obj0.saveDate();
    
      //   obj0.save2();
       //  obj0.closePopup();
  //  test.stopTest();
    
    
  }
  static testMethod void test_save_UseCase2(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT Content__c,Event_Date__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    System.assertNotEquals(null, flame_event_Obj[0].Id);
    flameeventcontroller obj01 = new flameeventcontroller();
    obj01.emp = flame_event_Obj[0];
      PageReference pageRef = Page.Flame_successful_message;
        Test.setCurrentPage(pageRef);
         PageReference pageRef1 = Page.Flame_Home;
        Test.setCurrentPage(pageRef1);
   // Test.startTest();
    flameeventcontroller obj0 = new flameeventcontroller();
Attachment attch = [select id, name, body from Attachment where parent.id=:flame_event_Obj[0].Id limit 1];
      obj0.file = attch.body;
     obj0.save1();
 

}
static testMethod void test_save_UseCase3(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT Content__c,Event_Date__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    System.assertNotEquals(null, flame_event_Obj[0].Id);
    flameeventcontroller obj01 = new flameeventcontroller();
    obj01.emp = flame_event_Obj[0];
      PageReference pageRef = Page.Flame_successful_message;
        Test.setCurrentPage(pageRef);
         PageReference pageRef1 = Page.Flame_Home;
        Test.setCurrentPage(pageRef1);
    //Test.startTest();
    flameeventcontroller obj0 = new flameeventcontroller();
Attachment attch = [select id, name, body from Attachment where parent.id=:flame_event_Obj[0].Id limit 1];
      obj0.file = attch.body;
      obj0.save2();
 

}
static testMethod void test_save_UseCase4(){
    List<Flame_Event__c> flame_event_Obj  =  [SELECT Content__c,Event_Date__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_Event__c];
    System.assertEquals(true,flame_event_Obj.size()>0);
    System.assertNotEquals(null, flame_event_Obj[0].Id);
    flameeventcontroller obj01 = new flameeventcontroller();
    obj01.emp = flame_event_Obj[0];
      PageReference pageRef = Page.Flame_successful_message;
        Test.setCurrentPage(pageRef);
         PageReference pageRef1 = Page.Flame_Home;
        Test.setCurrentPage(pageRef1);
  //  Test.startTest();
    flameeventcontroller obj0 = new flameeventcontroller();
       obj0.closePopup();
 

}

}