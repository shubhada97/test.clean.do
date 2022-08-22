/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
Name:            BookingControllerTest.cls
Description:     Test Class for BookingController class for Bookings Calendar

Date             Version        Author           Summary of Changes 
-----------      ----------  ---------------     ------------------------------------------------------------------------------------------------
July 2019        1.0           Cloudalyze        BookingControllerTest (New)
---------------------------------------------------------------------------------------------------------------------------------------------------------- */
@isTest
public class BookingControllerTest {

    @testSetup static void setupData() {
        
        // create resource type record
        B25__Resource_Type__c resourceType = new B25__Resource_Type__c();
        resourceType.Name = 'Dummy Resource Type';
        insert resourceType;
        
        // create resource record
        B25__Resource__c resource = new B25__Resource__c();
        resource.Name = 'ARBA-101';
        resource.B25__Resource_Type__c = resourceType.Id;
        insert resource;
        
        // create reservation record
        B25__Reservation__c reservation = new B25__Reservation__c();
        reservation.B25__Start_Date__c = system.today();
        reservation.B25__End_Date__c = system.today();
        reservation.B25__Title__c = 'CSIT201-Santosh Kudtarkar-Fundamentals of Data Structures';
        reservation.B25__Start__c = system.now();
        reservation.B25__End__c = system.now().addHours(1);    
        reservation.B25__Resource__c = resource.Id;
        insert reservation;
    }
    
    @isTest static void testFetchBookings() {
        
        B25__Resource__c selectedResource = [SELECT Id FROM   B25__Resource__c WHERE  Name = 'ARBA-101'];
        List<B25__Reservation__c> reservationList = BookingController.fetchBookings(selectedResource.Id);
        system.assertEquals(1, reservationList.size());
    }
}