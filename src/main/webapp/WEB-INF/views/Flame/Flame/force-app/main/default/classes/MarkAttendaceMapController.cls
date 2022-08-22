public  class MarkAttendaceMapController {
    
    @AuraEnabled
    public static List<Employee_Calendar__c> getLocation(){
        List<Employee_Calendar__c>  empCal = [select user__r.Name,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,GeoLocation_Start__Latitude__s,GeoLocation_Start__Longitude__s,LogIn_Status__c from Employee_Calendar__c where User__c =:UserInfo.getUserId() and LogIn_Status__c =:'Start' limit 1 ];  // order by createddate desc
        system.debug('empCal-->'+empCal);
        if(empCal != Null){
            return empCal;
        }
        else{
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Employee_Calendar__c> getDisplayTime(){
        List<Employee_Calendar__c>  empCal1 = [select user__r.Name,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,GeoLocation_Start__Latitude__s,GeoLocation_Start__Longitude__s,LogIn_Status__c,CREATEDDATE,Date__c,In_Time__c,Out_Time__c,Punch_In_DateTime__c,Punch_Out_DateTime__c from Employee_Calendar__c where User__c =:UserInfo.getUserId()  ORDER BY CREATEDDATE DESC  limit 1 ]; //and (Punch_Out_DateTime__c != null OR Punch_In_DateTime__c!= null) // order by createddate desc
        system.debug('empCal1-->'+empCal1);
        if(empCal1 != Null){
            return empCal1;
        }
        else{
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Employee_Calendar__c> getLocationAfterSave(){
        List<Employee_Calendar__c>  empCal = [select User__r.Name,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,GeoLocation_Start__Latitude__s,GeoLocation_Start__Longitude__s,LogIn_Status__c from Employee_Calendar__c where User__c =:UserInfo.getUserId() limit 1 ];  //and LogIn_Status__c =:'Start'
        system.debug('empCal-->'+empCal);
        if(empCal != Null){
            return empCal;
        }
        else{
            return null;
        }
    }
    
    @AuraEnabled
    public static string saveRecord(Decimal latt, Decimal longt) {
        //  try {
        system.debug('latt-->'+latt);
        system.debug('longt-->'+longt);
        
        List<Double> distanceInMeterList  = new List<Double>();
        system.debug('UserName-->'+UserInfo.getUserName());
         
        List<GeoLocation__mdt> listOfCampusRanges = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c
                                                     from GeoLocation__mdt where User_Name__c =: UserInfo.getUserName()];
        System.debug('listOfCampusRanges-->'+listOfCampusRanges);
        System.debug('listOfCampusRanges size-->'+listOfCampusRanges.size());
        if(listOfCampusRanges.size() > 0){
            system.debug('Not restricted for UserName');
        Id recordTypeId = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId();
        System.debug('recordTypeId-->'+recordTypeId);
        List<Employee_Calendar__c> recordExists = [select ID,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,In_Time__c,Out_Time__c,User__c,LogIn_Status__c,Date__c,RecordTypeId,Contact_Name__c,Employee_code__c,Punch_Out_Datetime__c from Employee_Calendar__c where user__c =: UserInfo.getUserId() and LogIn_Status__c =:'Start' limit 1];
        system.debug('recordExists-->'+recordExists);
        
        user u = [select id,name,ContactId,userName from user where id =:UserInfo.getUserId()];
        system.debug('contact user-->'+u);
        contact recordTypeIdCOntact = [select id,recordTypeId,Employee_Id__c,CVUE_Student_Number__c from contact where id =:u.ContactId];
        system.debug('recordTypeIdCOntact-->'+recordTypeIdCOntact);
        
        RecordType recordTypeName = [select name from RecordType where id=:(String)recordTypeIdCOntact.RecordTypeId];
		system.debug('recordTypeName-->'+recordTypeName);
            
         IF(recordExists.size() > 0){
                system.debug('User-->'+UserInfo.getUserId());
                // LogTime__c lt = new LogTime__c();
                /*intialize your object if already done not needed, then assign as follows*/
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
                recordExists[0].Contact_Name__c = u.ContactId;
                recordExists[0].Punch_Out_Datetime__c = System.now();
                if(recordTypeName.name == 'FU-Employee'){
                   recordExists[0].Employee_code__c = String.ValueOf(recordTypeIdCOntact.Employee_Id__c);
                }
                if(recordTypeName.name == 'FU-Student'){
                    recordExists[0].Employee_code__c = String.ValueOf(recordTypeIdCOntact.CVUE_Student_Number__c);
                }
                update recordExists; //insert/update/upsert which ever suits you
                
               
            }
            else{
                system.debug('Inser-->');
                Employee_Calendar__c lt = new Employee_Calendar__c();
                /*intialize your object if already done not needed, then assign as follows*/
                lt.LogIn_Status__c = 'Start';
                lt.User__c =UserInfo.getUserId();
                DateTime dt1 = System.now();
                Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
                lt.In_Time__c = InTime;
                lt.GeoLocation_Start__Latitude__s = latt;
                lt.GeoLocation_Start__Longitude__s = longt;
                lt.Date__c = System.TODAY();
                lt.RecordTypeId = recordTypeId;
                lt.Contact_Name__c = u.ContactId;
                lt.Punch_In_DateTime__c = System.now();
                if(recordTypeName.name == 'FU-Employee'){
                   lt.Employee_code__c = String.ValueOf(recordTypeIdCOntact.Employee_Id__c);
                }
                if(recordTypeName.name == 'FU-Student'){
                    lt.Employee_code__c = String.ValueOf(recordTypeIdCOntact.CVUE_Student_Number__c);
                }
                insert lt; //insert/update/upsert which ever suits you
                
               
                
            }
             IF(recordExists.size() > 0){
                return 'true';
            }else
            {
                return 'false';
            }
        }
        else{
        List<GeoLocation__mdt> listOfCampusRanges1 = [SELECT Campus__c,Range_Start_Lat__c,Range_Stop_Longt__c,Access_Range__c from GeoLocation__mdt];
        for(GeoLocation__mdt mdt:listOfCampusRanges1){
            system.debug('campus-->'+mdt.Campus__c);
            Location loc1 = Location.newInstance(latt,longt);
            system.debug('loc1-->'+loc1);
            Location loc2 = Location.newInstance(mdt.Range_Start_Lat__c,mdt.Range_Stop_Longt__c);
            system.debug('loc2-->'+loc2);
            double dist = Location.getDistance(loc1, loc2, 'mi');
            double distInMeter = 1609.344 * dist;
            system.debug('campus-->'+mdt.Campus__c);
            system.debug('dist-->'+dist); 
            system.debug('distInMeter-->'+distInMeter);
            system.debug('Access Range-->'+mdt.Access_Range__c);
            if(distInMeter <= mdt.Access_Range__c){
                distanceInMeterList.add(dist);
                
            }
        }
        system.debug('distanceInMeterList-->'+distanceInMeterList);
        
        Id recordTypeId = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId();
        System.debug('recordTypeId-->'+recordTypeId);
        List<Employee_Calendar__c> recordExists = [select ID,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,In_Time__c,Out_Time__c,User__c,LogIn_Status__c,Date__c,RecordTypeId,Contact_Name__c,Employee_code__c from Employee_Calendar__c where user__c =: UserInfo.getUserId() and LogIn_Status__c =:'Start' limit 1];
        system.debug('recordExists-->'+recordExists);
        
        user u = [select id,name,ContactId,userName from user where id =:UserInfo.getUserId()];
        system.debug('contact user-->'+u);
        contact recordTypeIdCOntact = [select id,recordTypeId,Employee_Id__c,CVUE_Student_Number__c from contact where id =:u.ContactId];
        system.debug('recordTypeIdCOntact-->'+recordTypeIdCOntact);
        
        RecordType recordTypeName = [select name from RecordType where id=:(String)recordTypeIdCOntact.RecordTypeId];
		system.debug('recordTypeName-->'+recordTypeName);
        
        If(distanceInMeterList.size() > 0){
            IF(recordExists.size() > 0){
                 system.debug('Update-->');
                system.debug('User-->'+UserInfo.getUserId());
                // LogTime__c lt = new LogTime__c();
                /*intialize your object if already done not needed, then assign as follows*/
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
                recordExists[0].Contact_Name__c = u.ContactId;
                recordExists[0].Punch_Out_Datetime__c = System.now();
                if(recordTypeName.name == 'FU-Employee'){
                   recordExists[0].Employee_code__c = String.ValueOf(recordTypeIdCOntact.Employee_Id__c);
                }
                if(recordTypeName.name == 'FU-Student'){
                    recordExists[0].Employee_code__c = String.ValueOf(recordTypeIdCOntact.CVUE_Student_Number__c);
                }
                update recordExists; //insert/update/upsert which ever suits you
                
               
            }
            else{
                system.debug('Inser-->');
                Employee_Calendar__c lt = new Employee_Calendar__c();
                /*intialize your object if already done not needed, then assign as follows*/
                lt.LogIn_Status__c = 'Start';
                lt.User__c =UserInfo.getUserId();
                DateTime dt1 = System.now();
                Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
                lt.In_Time__c = InTime;
                lt.GeoLocation_Start__Latitude__s = latt;
                lt.GeoLocation_Start__Longitude__s = longt;
                lt.Date__c = System.TODAY();
                lt.RecordTypeId = recordTypeId;
                lt.Contact_Name__c = u.ContactId;
                lt.Punch_In_DateTime__c = System.now();
                if(recordTypeName.name == 'FU-Employee'){
                   lt.Employee_code__c = String.ValueOf(recordTypeIdCOntact.Employee_Id__c);
                }
                if(recordTypeName.name == 'FU-Student'){
                    lt.Employee_code__c = String.ValueOf(recordTypeIdCOntact.CVUE_Student_Number__c);
                }
                insert lt; //insert/update/upsert which ever suits you
                
               
                
            } 
          
            
        }
        else{
            System.debug('Else');
          
        }
        //   system.debug('recordExists[0].LogIn_Status__c-->'+recordExists[0].LogIn_Status__c);
        If(distanceInMeterList.size() > 0){
            IF(recordExists.size() > 0){
                return 'true';
            }else
            {
                return 'false';
            }
        }
        else{
            return null;
        }
        }
    }
    
}