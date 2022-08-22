@isTest
private class flameNewscontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Flame_News__c flame_news_Obj = new Flame_News__c(Content__c = '14', Heading__c = 'Headi297', Image__c = '16', IsActive__c = false, Role__c = 'Student');
    Insert flame_news_Obj; 
    test.stopTest();
  }
  static testMethod void test_save_UseCase1(){
    List<Flame_News__c> flame_news_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_News__c];
    System.assertEquals(true,flame_news_Obj.size()>0);
    flameNewscontroller obj01 = new flameNewscontroller();
    obj01.emp = flame_news_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
   // obj01.save();
  }
  static testMethod void test_closePopup_UseCase1(){
    List<Flame_News__c> flame_news_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_News__c];
    System.assertEquals(true,flame_news_Obj.size()>0);
    flameNewscontroller obj01 = new flameNewscontroller();
    obj01.emp = flame_news_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
    obj01.closePopup();
  }
  static testMethod void test_Requesttosend_UseCase1(){
    List<Flame_News__c> flame_news_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_News__c];
    System.assertEquals(true,flame_news_Obj.size()>0);
    flameNewscontroller obj01 = new flameNewscontroller();
    obj01.emp = flame_news_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
    obj01.Requesttosend();
  }
  static testMethod void test_getSearchError_UseCase1(){
    List<Flame_News__c> flame_news_Obj  =  [SELECT Content__c,Heading__c,Image__c,IsActive__c,Role__c from Flame_News__c];
    System.assertEquals(true,flame_news_Obj.size()>0);
    flameNewscontroller obj01 = new flameNewscontroller();
    obj01.emp = flame_news_Obj[0];
    obj01.IsCreated = false;
    obj01.searchError = 'test data';
    obj01.getSearchError();
  }
}