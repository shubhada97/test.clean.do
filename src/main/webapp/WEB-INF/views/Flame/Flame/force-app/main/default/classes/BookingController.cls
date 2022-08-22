/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
Name:            BookingController.cls
Description:     Controller class for Bookings Calendar

Date             Version        Author           Summary of Changes 
-----------      ----------  ---------------     ------------------------------------------------------------------------------------------------
July 2019        1.0           Cloudalyze        BookingController (New)
---------------------------------------------------------------------------------------------------------------------------------------------------------- */
public class BookingController {

    /**********************************************************************************************************************   
        * Name :       fetchBookings
        * Author:      Cloudalyze
        * Date:        July 2019       
        * Description: Gets all current day bookings for a particular resource passed in as parameter
		* Param: 	   Id selectedResourceId - Id of the resource selected 
        * Return: 	   List<B25__Reservation__c> - list of booking records 
        * Changes:     Initial release  
    ***********************************************************************************************************************/
    @AuraEnabled
    public static List<B25__Reservation__c> fetchBookings(Id selectedResourceId) {
        
        List<B25__Reservation__c> reservationList = new List<B25__Reservation__c>();
        for(B25__Reservation__c reservation : [SELECT   Id, Name, B25__End_Date__c, B25__Start_Date__c, 
                                               		    B25__Local_End_Time__c, B25__Local_Start_Time__c, 
                                                        B25__Resource__r.Name, B25__Title__c 
                                               FROM     B25__Reservation__c
                                               WHERE    B25__Resource__c = :selectedResourceId
                                               AND      B25__Start_Date__c = TODAY
                                               ORDER BY B25__Local_Start_Time__c]) {
                                                   
        	reservationList.add(reservation);                                           
        }
        return reservationList;
    }
}