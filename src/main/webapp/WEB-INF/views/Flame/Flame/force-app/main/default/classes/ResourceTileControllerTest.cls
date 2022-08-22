/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
Name:            ResourceTileControllerTest.cls
Description:     Test Class for ResourceTileController class for Bookings Calendar

Date             Version        Author           Summary of Changes 
-----------      ----------  ---------------     ------------------------------------------------------------------------------------------------
July 2019        1.0           Cloudalyze        ResourceTileControllerTest (New)
---------------------------------------------------------------------------------------------------------------------------------------------------------- */
@isTest
public with sharing class ResourceTileControllerTest {
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
    }

    @isTest static void testGetResource(){
        System.assert(!ResourceTileController.getResources().isEmpty());
    }
}