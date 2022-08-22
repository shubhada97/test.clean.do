@isTest
public class markAttendanceMapControllerTest {
    
    public static Employee_calendar__c empCal;
    public static Employee_calendar__c empCal2;
    public static User u;
    
     static testMethod  void validateMethods1(){
        
         UserRole r = [select id,name from UserRole where portalType='None' limit 1];
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       
         u = new User(Alias = 'standt', Email='standard@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,  userRoleId = r.id,
            TimeZoneSidKey='America/Los_Angeles', UserName=System.now().millisecond() +'standard@testorg.com');
 insert u;
        
     System.runAs(u) {  
        //Create account
        Account portalAccount1 = new Account(
            Name = 'TestAccount',
            OwnerId = u.Id
        );
        Database.insert(portalAccount1);
    	
        //Create contact
        Contact contact1 = new Contact(
            FirstName = 'Test',
                Lastname = 'COmmunity',
            AccountId = portalAccount1.Id 	
        );
         try{
			Database.insert(contact1);
         }catch(Exception ex)   {
             
         }
//Create user
Profile portalProfile = [SELECT Id FROM Profile WHERE Name ='Faculty' Limit 1];

User user2 = new User(
	Username = System.now().millisecond() + 'test123456@test.com',
	ContactId = contact1.Id,
	ProfileId = portalProfile.Id,
   
	Alias = 'test1234',
	Email = 'test123456@test.com',
	EmailEncodingKey = 'UTF-8',
	LastName = 'McTestyy',
	CommunityNickname = 'test123456',
	TimeZoneSidKey = 'America/Los_Angeles',
	LocaleSidKey = 'en_US',
	LanguageLocaleKey = 'en_US'
);
Database.insert(user2);
          
        System.runAs(user2) {
            
              GeoLocation__mdt mdtGelocation = new GeoLocation__mdt();
            mdtGelocation.Access_Range__c = 100;
            mdtGelocation.Campus__c = 'Test';
            mdtGelocation.Label     = 'Test';
            mdtGelocation.Range_Start_Lat__c = 21.1320832;
            mdtGelocation.Range_Stop_Longt__c= 79.0986752;
            mdtGelocation.User_Name__c =user2.Username;
            
            
             List<Double> distanceInMeterList  = new List<Double>();
             List<GeoLocation__mdt> listOfCampusRanges = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c 
                                                         from GeoLocation__mdt where user_name__c =:user2.Username]; //'harshal-flame@techilaservice.com'
            system.debug('listOfCampusRanges-->'+listOfCampusRanges);

            system.debug('listOfCampusRanges Size-->'+listOfCampusRanges.size());
          //  List<GeoLocation__mdt> listOfCampusRanges1 = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c from GeoLocation__mdt];
         //   System.assertNotEquals(listOfCampusRanges.size(),listOfCampusRanges1.size());
            
            // System.assertEquals(listOfCampusRanges.size()>0,false);
            empCal2 = new Employee_calendar__c();
        // list<Employee_calendar__c> recordExist = new list<Employee_calendar__c>();
        empCal2.LogIn_Status__c = 'Start';
        empCal2.User__c = user2.id;
        empcal2.Contact_Name__c = user2.ContactId;
        DateTime dt1 = System.now();
        Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
        empCal2.In_Time__c = InTime;
        empCal2.GeoLocation_Start__Latitude__s = 21.1320832; 
        empCal2.GeoLocation_Start__Longitude__s = 79.0986752;
        empCal2.Date__c = System.TODAY();
        empCal2.RecordTypeId = '0120K000001I5k6QAC';
        // recordExist.add(empCal);
        
        database.insert(empCal2);
            
            
            
         Employee_calendar__c recordExist = new Employee_calendar__c();
        recordExist =  [SELECT Id,User__c, LogIn_Status__c,In_Time__c,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,Date__c,RecordTypeId FROM Employee_calendar__c WHERE Id = :empCal2.Id];
        
        System.assertEquals('Start', recordExist.LogIn_Status__c);
        
        database.update(recordExist); 
            
            empCal2 = new Employee_calendar__c();
        // list<Employee_calendar__c> recordExist = new list<Employee_calendar__c>();
        empCal2.LogIn_Status__c = 'Stop';
        empCal2.User__c = user2.id;
        empcal2.Contact_Name__c = user2.ContactId;
        DateTime dt2 = System.now();
        Time InTime1 = Time.newInstance(dt2.hour(), dt2.minute(), dt2.second(), dt2.millisecond());
        empCal2.In_Time__c = InTime1;
        empCal2.GeoLocation_Start__Latitude__s = 21.1320832; 
        empCal2.GeoLocation_Start__Longitude__s =79.0986752;
        empCal2.Date__c = System.TODAY();
        empCal2.RecordTypeId = '0120K000001I5k6QAC';
        // recordExist.add(empCal);
        
        database.insert(empCal2);
         
       
        MarkAttendaceMapController.getLocation();
        MarkAttendaceMapController.getLocationAfterSave();
       Test.startTest();
        MarkAttendaceMapController.saveRecord(21.1320832,79.0986752);
        MarkAttendaceMapController.saveRecord(21.1320832,79.0986752);
            Test.stopTest();
           
              
        }
        
         }
        //insert/update/upsert which ever suits you
        
        
        
        //  LoadData();
        
        
        
        //MarkAttendaceMapController.saveRecord(18.5234,73.7318);
        // test.stopTest();
    }
    
    static testMethod void validateMethods(){
        
        UserRole r = [select id,name from UserRole where portalType='None' limit 1];
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       
         u = new User(Alias = 'standt', Email='standard@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id,  userRoleId = r.id,
            TimeZoneSidKey='America/Los_Angeles', UserName=System.now().millisecond() +'standard@testorg.com');
 insert u;
        
     System.runAs(u) {  
        //Create account
Account portalAccount1 = new Account(
	Name = 'TestAccount',
	OwnerId = u.Id
);
Database.insert(portalAccount1);
    	
//Create contact
Contact contact1 = new Contact(
   	FirstName = 'Test',
    	Lastname = 'COmmunity',
	AccountId = portalAccount1.Id
    
    	
);
         try{
Database.insert(contact1);
         }catch(Exception ex)   {
             
         }
//Create user
Profile portalProfile = [SELECT Id FROM Profile WHERE Name ='Faculty' Limit 1];

User user1 = new User(
	Username = 'test12345@test.com',
	ContactId = contact1.Id,
	ProfileId = portalProfile.Id,
   
	Alias = 'test123',
	Email = 'test12345@test.com',
	EmailEncodingKey = 'UTF-8',
	LastName = 'McTesty',
	CommunityNickname = 'test12345',
	TimeZoneSidKey = 'America/Los_Angeles',
	LocaleSidKey = 'en_US',
	LanguageLocaleKey = 'en_US'
);
Database.insert(user1);
          
        System.runAs(user1) {
            List<Double> distanceInMeterList  = new List<Double>();
            List<GeoLocation__mdt> listOfCampusRanges1 = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c from GeoLocation__mdt];
            for(GeoLocation__mdt mdt:listOfCampusRanges1){
                Location loc1 = Location.newInstance(21.1320832,79.0986752);
            system.debug('loc1-->'+loc1);
            Location loc2 = Location.newInstance(mdt.Range_Start_Lat__c,mdt.Range_Stop_Longt__c);
            system.debug('loc2-->'+loc2);
            double dist = Location.getDistance(loc1, loc2, 'mi');
            double distInMeter = 1609.344 * dist;
            if(distInMeter <= mdt.Access_Range__c){
            distanceInMeterList.add(distInMeter);
                
            }
            }
            system.debug('distanceInMeterList-->'+distanceInMeterList);
            
            empCal = new Employee_calendar__c();
        // list<Employee_calendar__c> recordExist = new list<Employee_calendar__c>();
        empCal.LogIn_Status__c = 'Start';
        empCal.User__c = user1.id;
        empcal.Contact_Name__c = user1.ContactId;
        DateTime dt3 = System.now();
        Time InTime2 = Time.newInstance(dt3.hour(), dt3.minute(), dt3.second(), dt3.millisecond());
        empCal.In_Time__c = InTime2;
        empCal.GeoLocation_Start__Latitude__s = 21.1320832; 
        empCal.GeoLocation_Start__Longitude__s = 79.0986752;
        empCal.Date__c = System.TODAY();
        empCal.RecordTypeId = '0120K000001I5k6QAC';
        // recordExist.add(empCal);
        
        database.insert(empCal);
            
            
            
         Employee_calendar__c recordExist = new Employee_calendar__c();
        recordExist =  [SELECT Id,User__c, LogIn_Status__c,In_Time__c,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,Date__c,RecordTypeId FROM Employee_calendar__c WHERE Id = :empCal.Id];
        
        System.assertEquals('Start', recordExist.LogIn_Status__c);
        
        database.update(recordExist); 
            
            empCal = new Employee_calendar__c();
        // list<Employee_calendar__c> recordExist = new list<Employee_calendar__c>();
        empCal.LogIn_Status__c = 'Stop';
        empCal.User__c = user1.id;
        empcal.Contact_Name__c = user1.ContactId;
        DateTime dt4 = System.now();
        Time InTime3 = Time.newInstance(dt4.hour(), dt4.minute(), dt4.second(), dt4.millisecond());
        empCal.In_Time__c = InTime3;
        empCal.GeoLocation_Start__Latitude__s = 21.1320832; 
        empCal.GeoLocation_Start__Longitude__s =79.0986752;
        empCal.Date__c = System.TODAY();
        empCal.RecordTypeId = '0120K000001I5k6QAC';
        // recordExist.add(empCal);
        
        database.insert(empCal);
        //LoadData();
      //  validateMethods1();
        MarkAttendaceMapController.getLocation();
        MarkAttendaceMapController.getLocationAfterSave();
        MarkAttendaceMapController.getDisplayTime();
        test.startTest();
        MarkAttendaceMapController.saveRecord(21.1320832,79.0986752);
        MarkAttendaceMapController.saveRecord(21.1320832,79.0986752);
        
            test.stopTest();
              
        }
         }
        //insert/update/upsert which ever suits you
        
        
        
        //  LoadData();
        
        
        
        //MarkAttendaceMapController.saveRecord(18.5234,73.7318);
        // test.stopTest();
    }
    
}