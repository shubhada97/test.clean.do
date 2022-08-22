@isTest
private class flameworkrelayController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    FLAMEWorkRelayFormsList__c flameworkrelayformslist_Obj = new FLAMEWorkRelayFormsList__c(Name = 'Name919', Category__c = 'Categ576', FieldSetAPIName__c = 'Field463', ProfileName__c = '14', RecordType__c = 'Recor333', TabType__c = 'TabTy497', WorkRelayFromID__c = 'WorkR864', FormDescription__c = '18');
    Insert flameworkrelayformslist_Obj; 
    test.stopTest();
  }
  static testMethod void test_ResourceCategory_UseCase1(){
    List<FLAMEWorkRelayFormsList__c> flameworkrelayformslist_Obj  =  [SELECT Id,Name,Category__c,FieldSetAPIName__c,ProfileName__c,RecordType__c,TabType__c,WorkRelayFromID__c,FormDescription__c from FLAMEWorkRelayFormsList__c];
    System.assertEquals(true,flameworkrelayformslist_Obj.size()>0);
    PageReference pageRef = Page.FLAMEWorkRelayForms;
    pageRef.getParameters().put('rId','test');
    Test.setCurrentPage(pageRef);
    flameworkrelayController obj01 = new flameworkrelayController();
    obj01.categoryList = new List<String>();
    obj01.WorkRelayList = flameworkrelayformslist_Obj;
    obj01.customSettingCategoryList = flameworkrelayformslist_Obj;
    obj01.customSettingSubCategoryList = flameworkrelayformslist_Obj;
    obj01.rString = 'test data';
    obj01.getSubCategory = 'test data';
    obj01.Header = 'test data';
    obj01.Header2 = 'test data';
    obj01.bool = false;
    obj01.objUser = new user();
    obj01.subCategoryList = new List<String>();
    obj01.roleString = 'test data';
    obj01.documentList = new List<Document>();
    obj01.resource = new Resource__c();
    obj01.rid = 'test data';
    obj01.ResourceCategory();
  }
  static testMethod void test_ResourceLink_UseCase1(){
    List<FLAMEWorkRelayFormsList__c> flameworkrelayformslist_Obj  =  [SELECT Id,Name,Category__c,FieldSetAPIName__c,ProfileName__c,RecordType__c,TabType__c,WorkRelayFromID__c,FormDescription__c from FLAMEWorkRelayFormsList__c];
    System.assertEquals(true,flameworkrelayformslist_Obj.size()>0);
    PageReference pageRef = Page.FLAMEWorkRelayForms;
    pageRef.getParameters().put('rId','test');
    Test.setCurrentPage(pageRef);
    flameworkrelayController obj01 = new flameworkrelayController();
    obj01.categoryList = new List<String>();
    obj01.WorkRelayList = flameworkrelayformslist_Obj;
    obj01.customSettingCategoryList = flameworkrelayformslist_Obj;
    obj01.customSettingSubCategoryList = flameworkrelayformslist_Obj;
    obj01.rString = 'test data';
    obj01.getSubCategory = 'test data';
    obj01.Header = 'test data';
    obj01.Header2 = 'test data';
    obj01.bool = false;
    obj01.objUser = new user();
    obj01.subCategoryList = new List<String>();
    obj01.roleString = 'test data';
    obj01.documentList = new List<Document>();
    obj01.resource = new Resource__c();
    obj01.rid = 'test data';
   // obj01.ResourceLink();
  }
  static testMethod void test_proceedtoback_UseCase1(){
    List<FLAMEWorkRelayFormsList__c> flameworkrelayformslist_Obj  =  [SELECT Id,Name,Category__c,FieldSetAPIName__c,ProfileName__c,RecordType__c,TabType__c,WorkRelayFromID__c,FormDescription__c from FLAMEWorkRelayFormsList__c];
    System.assertEquals(true,flameworkrelayformslist_Obj.size()>0);
    PageReference pageRef = Page.FLAMEWorkRelayForms;
    pageRef.getParameters().put('rId','test');
    Test.setCurrentPage(pageRef);
    flameworkrelayController obj01 = new flameworkrelayController();
    obj01.categoryList = new List<String>();
    obj01.WorkRelayList = flameworkrelayformslist_Obj;
    obj01.customSettingCategoryList = flameworkrelayformslist_Obj;
    obj01.customSettingSubCategoryList = flameworkrelayformslist_Obj;
    obj01.rString = 'test data';
    obj01.getSubCategory = 'test data';
    obj01.Header = 'test data';
    obj01.Header2 = 'test data';
    obj01.bool = false;
    obj01.objUser = new user();
    obj01.subCategoryList = new List<String>();
    obj01.roleString = 'test data';
    obj01.documentList = new List<Document>();
    obj01.resource = new Resource__c();
    obj01.rid = 'test data';
    obj01.proceedtoback();
  }
}