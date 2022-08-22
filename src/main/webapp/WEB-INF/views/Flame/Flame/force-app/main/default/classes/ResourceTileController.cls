/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
Name:            ResourceTileController.cls
Description:     Controller class for Bookings Calendar

Date             Version        Author           Summary of Changes 
-----------      ----------  ---------------     ------------------------------------------------------------------------------------------------
July 2019        1.0           Cloudalyze        ResourceTileController (New)
---------------------------------------------------------------------------------------------------------------------------------------------------------- */
global without sharing class ResourceTileController {
    /**********************************************************************************************************************   
        * Name :       getResources
        * Author:      Cloudalyze
        * Date:        July 2019       
        * Description: Gets all resources
        * Return: 	   List<B25__Resourcec__c> - list of resources record
        * Changes:     Initial release  
    ***********************************************************************************************************************/
    @AuraEnabled
    public static List<B25__Resource__c> getResources(){
        return [SELECT Id, Name FROM B25__Resource__c];
    }
}