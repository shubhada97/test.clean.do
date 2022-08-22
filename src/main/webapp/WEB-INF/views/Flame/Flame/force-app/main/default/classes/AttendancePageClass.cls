global class AttendancePageClass {
    
    
    @RemoteAction
    global static List<events> getEvents() {
        try{
            User currentUser ;
            Contact con ;
            String userId ;
            List<Employee_Calendar__c> empCalendar = new List<Employee_Calendar__c>();
            Date todaysDate = System.today();
            
            userId = userinfo.getuserId();
            
            
            currentUser = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id=:userId];
            
            con = [SELECT Id, MobilePhone, Name,Email,Earned_Leave_Balance__c,Casual_Leave_Balance__c,Employee_Id__c, Designation_Name__c,Grade_Name__c, Department__c, Faculty__c, ReportsTo.Name FROM Contact where id =: currentUser.contactId];
            
            empCalendar = [SELECT Id, Name, In_Time__c, Out_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c, Employee_Code__c, IsPresent__c, RecordTypeId, RecordType.Name,OnDuty_Leave__c FROM Employee_Calendar__c Where (Employee_Code__c =: String.valueOf(con.Employee_Id__c) AND (  (Date__c >: todaysDate AND Status__c != 'Pending' AND Status__c != 'Rejected') OR Date__c <=: todaysDate) ) OR RecordType.Name =: 'Holiday Punch'];
            system.debug('empCalendar-->'+empCalendar);
            
            if(empCalendar.size()>0){
                
                List<events> lisEvents = new List<events>();
                for(Employee_Calendar__c e : empCalendar){
                    events eve = new events();
                    if(e.RecordType.Name == 'Holiday Punch'){
                        eve.name = e.Holiday_Name__c;
                        eve.rType = 'H';
                        eve.sDate = e.Date__c;
                        eve.eDate = e.Date__c; 
                        system.debug('eve.sDate-->'+eve.sDate);
                        system.debug('eve.eDate-->'+eve.eDate);
                    }
                    else{
                        
                        eve.rType = 'E';
                        
                        if(e.OnDuty_Leave__c == 'Full Day Leave' || e.OnDuty_Leave__c == 'Half Day Leave'){
                            eve.sDate = e.Date__c;
                            eve.eDate = e.Date__c;
                            eve.name = e.OnDuty_Leave__c;
                              system.debug('eve.sDate-->'+eve.sDate);
                        system.debug('eve.eDate-->'+eve.eDate);
                        }
                        else{
                            eve.name = e.IsPresent__c;
                            if(e.In_Time__c == null || e.Out_Time__c == null){
                                continue;
                            }
                            DateTime sdate = DateTime.newInstance(e.Date__c,e.In_Time__c);
                            DateTime edate = DateTime.newInstance(e.Date__c,e.Out_Time__c);
                            eve.sDate = sdate;
                            eve.eDate = edate;
                              system.debug('eve.sDate-->'+eve.sDate);
                        system.debug('eve.eDate-->'+eve.eDate);
                        }
                    }
                    lisEvents.add(eve);
                    system.debug('lisEvents-->'+lisEvents);
                }
                
                return lisEvents;
            } else{
                return null;
            }
        }
        catch(exception e){
            system.debug('error ::'+ e.getmessage());
            return  null;
        }
    }
    
    global class events{
        String name;
        String rType;
        DateTime sDate;
        DateTime eDate;
    }
}