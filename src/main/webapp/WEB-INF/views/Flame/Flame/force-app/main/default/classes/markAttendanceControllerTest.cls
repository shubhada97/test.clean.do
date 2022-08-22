@isTest
public class markAttendanceControllerTest {

     public static Employee_calendar__c empCal;
    
    public static void LoadData() 
    {
        
         CreateRecord();
        
           
    }
    public static void CreateRecord()
    {
       empCal = new Employee_calendar__c();
       // list<Employee_calendar__c> recordExist = new list<Employee_calendar__c>();
       empCal.LogIn_Status__c = 'Start';
                empCal.User__c =UserInfo.getUserId();
                DateTime dt1 = System.now();
                Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
                empCal.In_Time__c = InTime;
                empCal.GeoLocation_Start__Latitude__s = 18.5234;
                empCal.GeoLocation_Start__Longitude__s = 73.7318;
                empCal.Date__c = System.TODAY();
                empCal.RecordTypeId = '0120K000001I5k6QAC';
               // recordExist.add(empCal);
                insert empCal; //insert/update/upsert which ever suits you
        
      
               
    }
    static testMethod void validateMethods(){
        
        
        test.startTest();
        LoadData();
        
        
        test.stopTest();
    }
}