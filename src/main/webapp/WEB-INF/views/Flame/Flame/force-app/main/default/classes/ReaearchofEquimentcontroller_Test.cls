@isTest
private class ReaearchofEquimentcontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Research__c research_Obj = new Research__c(Approved__c = false, Rewarded__c = false, Units_Of_Measurement__c = 'Box', Item_Description2__c = '105', Item_Description3__c = '106', Quantity2__c = 'Quant112', Quantity3__c = 'Quant702', Units_Of_Measurement2__c = 'Box', Units_of_Measurement3__c = 'Box', TRS_Requisition_For__c = 'Self', Subject__c = 'Subje809', TRS_Purpose_Of_The_Visit__c = 'TRS_P683', TRS_Message__c = '114', TRS_Mode_Of_Travel__c = 'Air', Round_Trip__c = false, TRS_Traveler_Name__c = 'TRS_T127', TRS_Traveler_Mobile__c = 'TRS_T895', Departure_Date__c = Date.today(), Departure_Pickup_Time__c = 'Depar995', Departure_Pickup_Location__c = 'Depar290', Return_Date__c = Date.today(), Return_Pickup_Location__c = 'Retur490', Return_Pickup_Time__c = 'Retur888', Travel_From__c = 'Trave642', Travel_To__c = 'Trave206', TRS_Traveler_Email__c = 'TRS_T248');
   // Insert research_Obj; 
    test.stopTest();
  }
  static testMethod void test_init_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Approved__c,Rewarded__c,Units_Of_Measurement__c,Item_Description2__c,Item_Description3__c,Quantity2__c,Quantity3__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,Departure_Date__c,Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c,Travel_From__c,Travel_To__c,TRS_Traveler_Email__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Requirementstatuspage;
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    ReaearchofEquimentcontroller obj01 = new ReaearchofEquimentcontroller();
   // obj01.Research1 = research_Obj[0];
    obj01.showContent = false;
    obj01.showContent1 = false;
    obj01.showContent2 = false;
    obj01.recordTypeNameMap = new Map<String,String>();
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.displayPopUp = false;
    obj01.downloadId = 'test data';
    obj01.editId = 'test data';
    obj01.init();
  }
  static testMethod void test_addNewItemList_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Approved__c,Rewarded__c,Units_Of_Measurement__c,Item_Description2__c,Item_Description3__c,Quantity2__c,Quantity3__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,Departure_Date__c,Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c,Travel_From__c,Travel_To__c,TRS_Traveler_Email__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Requirementstatuspage;
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    ReaearchofEquimentcontroller obj01 = new ReaearchofEquimentcontroller();
   // obj01.Research1 = research_Obj[0];
    obj01.showContent = false;
    obj01.showContent1 = false;
    obj01.showContent2 = false;
    obj01.recordTypeNameMap = new Map<String,String>();
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.displayPopUp = false;
    obj01.downloadId = 'test data';
    obj01.editId = 'test data';
    obj01.addNewItemList();
  }
  static testMethod void test_addNewItemList1_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Approved__c,Rewarded__c,Units_Of_Measurement__c,Item_Description2__c,Item_Description3__c,Quantity2__c,Quantity3__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,Departure_Date__c,Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c,Travel_From__c,Travel_To__c,TRS_Traveler_Email__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Requirementstatuspage;
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    ReaearchofEquimentcontroller obj01 = new ReaearchofEquimentcontroller();
    //obj01.Research1 = research_Obj[0];
    obj01.showContent = false;
    obj01.showContent1 = false;
    obj01.showContent2 = false;
    obj01.recordTypeNameMap = new Map<String,String>();
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.displayPopUp = false;
    obj01.downloadId = 'test data';
    obj01.editId = 'test data';
    obj01.addNewItemList1();
  }
  static testMethod void test_removeNewItemList1_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Approved__c,Rewarded__c,Units_Of_Measurement__c,Item_Description2__c,Item_Description3__c,Quantity2__c,Quantity3__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,Departure_Date__c,Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c,Travel_From__c,Travel_To__c,TRS_Traveler_Email__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Requirementstatuspage;
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    ReaearchofEquimentcontroller obj01 = new ReaearchofEquimentcontroller();
   // obj01.Research1 = research_Obj[0];
    obj01.showContent = false;
    obj01.showContent1 = false;
    obj01.showContent2 = false;
    obj01.recordTypeNameMap = new Map<String,String>();
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.displayPopUp = false;
    obj01.downloadId = 'test data';
    obj01.editId = 'test data';
    obj01.removeNewItemList1();
  }
  static testMethod void test_removeNewItemList2_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Approved__c,Rewarded__c,Units_Of_Measurement__c,Item_Description2__c,Item_Description3__c,Quantity2__c,Quantity3__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,Departure_Date__c,Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c,Travel_From__c,Travel_To__c,TRS_Traveler_Email__c from Research__c];
    System.assertEquals(false,research_Obj.size()>0);
    PageReference pageRef = Page.Requirementstatuspage;
    pageRef.getParameters().put('editId','test');
    pageRef.getParameters().put('downloadId','test');
    Test.setCurrentPage(pageRef);
    ReaearchofEquimentcontroller obj01 = new ReaearchofEquimentcontroller();
   // obj01.Research1 = research_Obj[0];
    obj01.showContent = false;
    obj01.showContent1 = false;
    obj01.showContent2 = false;
    obj01.recordTypeNameMap = new Map<String,String>();
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.displayPopUp = false;
    obj01.downloadId = 'test data';
    obj01.editId = 'test data';
    obj01.removeNewItemList2();
    // obj01.saveCase();
     obj01.closePopup();
    obj01.getResearchs();
    obj01.getResearchtravel();
    obj01.Newrequisition();
    obj01.recordEdited();
    obj01.recordEdited1();
   // obj01.GetRecordediting();
   // obj01.Saveedit();
    obj01.download();
    //obj01.GetRecordFetching();
    obj01.Newtravelrequest();
    obj01.savetravelrequest();
    obj01.closePopup1();
    obj01.download1();
  }
  
  
}