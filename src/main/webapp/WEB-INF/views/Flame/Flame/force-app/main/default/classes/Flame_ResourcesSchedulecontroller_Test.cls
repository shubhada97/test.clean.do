@isTest(SeeAllData=true)
public class Flame_ResourcesSchedulecontroller_Test{

Public static void setupTestData(){
    test.startTest();
    B25__Reservation__c b25_reservation_Obj = new B25__Reservation__c(B25__Has_Conflicts__c = false, B25__Has_Resource_Conflicts__c = false, B25__Has_Staff_Conflicts__c = false, B25__Skip_Subtotal_Calculation__c = false);
    Insert b25_reservation_Obj; 
    test.stopTest();
  }
 Public static testMethod void test_resources_UseCase1(){
 PageReference pageRef = Page.ResourcesSchedule;  
 Test.setCurrentPage(pageRef);
  List<B25__Reservation__c> b25_reservation_Obj  =  new List<B25__Reservation__c>();
  b25_reservation_Obj =[SELECT B25__ABRCompositeKey__c,B25__ABRSerialNr__c,B25__ABRSerialPartNr__c,B25__Account__c,B25__AutomatedBookingRule__c,
                                        B25__Base_Price__c,B25__Calculation_Method__c,B25__Contact__c,B25__EndLocal__c,B25__End_Date__c,B25__End_GMT__c,
                                        B25__End_Local_DateTime__c,B25__End__c,B25__Event_Id__c,B25__Group__c,B25__Has_Conflicts__c,B25__Has_Resource_Conflicts__c,
                                        B25__Has_Staff_Conflicts__c,B25__Hover__c,B25__Info__c,B25__IsUnassigned__c,B25__Local_End_Time__c,B25__Local_Start_Time__c,
                                        B25__MaxCapacity__c,B25__Notes__c,B25__OpportunityLineItem__c,B25__Opportunity__c,B25__Price__c,B25__Quantity__c,
                                        B25__Recurring_Reservation__c,B25__Reservation_Type__c,B25__ResourceName__c,B25__ResourceTimezone__c,B25__Resource__c,
                                        B25__Sample_Custom_Field__c,B25__SelectedLayout__c,B25__SelectedTimeframe__c,B25__Service_Costs__c,
                                        B25__Skip_Subtotal_Calculation__c,B25__Staff__c,B25__StartLocal__c,B25__Start_Date__c,B25__Start_GMT__c,
                                        B25__Start_Local_DateTime__c,B25__Start__c,B25__Status__c,B25__Subtotal__c,B25__Title__c,B25__Total_Price__c,
                                        B25__User__c,B25__Visit__c,Id,Name FROM B25__Reservation__c];
  System.assertEquals(true,b25_reservation_Obj.size()>0);
  Flame_ResourcesSchedulecontroller obj01 = new Flame_ResourcesSchedulecontroller();
  obj01.bcc = b25_reservation_Obj[0];
  obj01.reserList = b25_reservation_Obj;
  obj01.showResult = false;
  obj01.searchAccounts();
  obj01.resources();
  obj01.FirstPage();
  
  
  obj01.LastPage();
  obj01.getprev();
  obj01.getnxt();
  obj01.next();
  obj01.previous();
  
  }
}