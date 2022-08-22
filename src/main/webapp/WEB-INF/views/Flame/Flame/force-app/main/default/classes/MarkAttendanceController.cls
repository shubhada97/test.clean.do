public class MarkAttendanceController {
    public decimal latt { get; set; }       
    public decimal longt { get; set; }
    public boolean isShow{get; set;}
    public boolean isShow2{get; set;}
    public Id recordTypeId;
    public Double dist;
    public Double distInMeter;
   // public boolean btnPunchInBlueDisable {get; set;} 
    public boolean btnPunchInGrayDisable {get; set;}
   // public boolean btnPunchOutBlueDisable {get; set;}
    public boolean btnPunchOutGrayDisable {get; set;}
    
    public  MarkAttendanceController(){
       recordTypeId = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId();
        System.debug('recordTypeId-->'+recordTypeId);
        //  isShow = true;
        List<Employee_Calendar__c> recordCheck = [select ID,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,In_Time__c,Out_Time__c,User__c,LogIn_Status__c from Employee_Calendar__c where user__c =: UserInfo.getUserId() and LogIn_Status__c =:'Start' limit 1];
        system.debug('record'+recordCheck);
        
        IF(recordCheck.size() > 0){
            isShow2 = true;
            isShow = false;
            btnPunchInGrayDisable = true;
          
        }
        else{
            isShow2 = false;
            isShow = true;
            btnPunchOutGrayDisable = true;
        }
    }
   /* public void saveRecord() {
        //  try {
        system.debug('latt-->'+latt);
        system.debug('longt-->'+longt);
       
        List<Double> distanceInMeterList  = new List<Double>();
        List<GeoLocation__mdt> listOfCampusRanges1 = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c from GeoLocation__mdt];
        for(GeoLocation__mdt mdt:listOfCampusRanges1){
            
        Location loc1 = Location.newInstance(latt,longt);
            system.debug('loc1-->'+loc1);
		Location loc2 = Location.newInstance(mdt.Range_Start_Lat__c,mdt.Range_Stop_Longt__c);
            system.debug('loc2-->'+loc2);
		 dist = Location.getDistance(loc1, loc2, 'mi');
         distInMeter = 1609.344 * dist;
            system.debug('campus-->'+mdt.Campus__c);
            system.debug('dist-->'+dist);
            system.debug('distInMeter-->'+distInMeter);
            system.debug('Access Range-->'+mdt.Access_Range__c);
            if(distInMeter <= mdt.Access_Range__c){
                 distanceInMeterList.add(dist);
                 
                }
        }
        system.debug('distanceInMeterList-->'+distanceInMeterList);
       // List<GeoLocation__mdt> listOfCampusRanges = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c from GeoLocation__mdt where Range_Start_Lat__c>=:latt AND Range_Stop_Longt__c <=:longt];
       // system.debug('listOfCampusRanges-->'+listOfCampusRanges);
        List<Employee_Calendar__c> recordExists = [select ID,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,In_Time__c,Out_Time__c,User__c,LogIn_Status__c,Date__c,RecordTypeId from Employee_Calendar__c where user__c =: UserInfo.getUserId() and LogIn_Status__c =:'Start' limit 1];
        system.debug('recordExists-->'+recordExists);
        If(distanceInMeterList.size() > 0){
            IF(recordExists.size() > 0){
                system.debug('User-->'+UserInfo.getUserId());
                // LogTime__c lt = new LogTime__c();
                //intialize your object if already done not needed, then assign as follows
                recordExists[0].LogIn_Status__c = 'Stop';
                recordExists[0].User__c =UserInfo.getUserId();
                //     DateTime dtDateTime = system.now();
                //Time sTime = dtDateTime.format('hh:mm a');
                DateTime dt = System.now();
                Time myTime = Time.newInstance(dt.hour(), dt.minute(), dt.second(), dt.millisecond());
                recordExists[0].Out_Time__c =  myTime;
                recordExists[0].GeoLocation_Stop__Latitude__s = latt;
                recordExists[0].GeoLocation_Stop__Longitude__s = longt;
                recordExists[0].Date__c = System.TODAY();
                recordExists[0].recordTypeId =recordTypeId;
                update recordExists; //insert/update/upsert which ever suits you
                isShow2 = false;
                isShow = true;
                btnPunchOutGrayDisable = true;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'LogOut Successfully.'));
            }
            else{
                system.debug('Inser-->');
                Employee_Calendar__c lt = new Employee_Calendar__c();
                //intialize your object if already done not needed, then assign as follows
                lt.LogIn_Status__c = 'Start';
                lt.User__c =UserInfo.getUserId();
                DateTime dt1 = System.now();
                Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
                lt.In_Time__c = InTime;
                lt.GeoLocation_Start__Latitude__s = latt;
                lt.GeoLocation_Start__Longitude__s = longt;
                lt.Date__c = System.TODAY();
                lt.RecordTypeId = recordTypeId;
                insert lt; //insert/update/upsert which ever suits you
                isShow2 = true;
                isShow = false;
                btnPunchInGrayDisable = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'LogIn Successfully..'));
               // ApexPages.getMessages().clear();
                
            } 
            //    }catch(Exception e) {
            //    system.debug('EEEE:'+e.getMessage());
            // Generic exception handling code here.
            //    } 
            
        }
        else{
            System.debug('Else');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'you are outside the campus.'));
            
        }
    }*/
    
}