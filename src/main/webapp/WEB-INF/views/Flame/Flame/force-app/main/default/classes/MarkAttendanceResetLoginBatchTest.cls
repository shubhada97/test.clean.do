@isTest
public class MarkAttendanceResetLoginBatchTest {

     @testSetup 
    static void setup() {
        List<employee_calendar__c> employeeCal = new List<employee_calendar__c>();
                DateTime dt1 = System.now();
                Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
        // insert 200 accounts
        for (Integer i=0;i<200;i++) {
            
            employeeCal.add(new employee_calendar__c(LogIn_Status__c='Start', In_Time__c =InTime,
                GeoLocation_Start__Latitude__s =18.5234, GeoLocation_Start__Longitude__s =73.7318,RecordTypeId='0120K000001I5k6QAC'));
        }
        insert employeeCal;
       
    }
        static testmethod void test() {        
        Test.startTest();
        MarkAttendanceResetLogInBatch mk = new MarkAttendanceResetLogInBatch();
        Id batchId = Database.executeBatch(mk);
        Test.stopTest();
           // Integer con=[select count() from contact];
        // after the testing stops, assert records were inserted properly
        System.assertEquals(200, [select count() from employee_calendar__c]);
       // System.assertEquals(200, [select count() from account]);
        }
}