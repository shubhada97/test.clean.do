public class syncEmployeeCalendarFromWifi {
	
    /*
		Update Employee Calendar Data based on condition  
		Match with Username in Wifi Data
		Find Punch In and Out Logs from Wifi Data
	*/
    public void updateEmployeCalendarData(List<Raw_Employee_Punch__c> rawData) {
        Datetime systemDate = System.now()-1;
        String newTimeDate = systemDate.format('yyyy-MM-dd');
        String currentStartDate = newTimeDate +' 00:05:00';
		Datetime startDate = Datetime.valueOfGmt(currentStartDate);
            
        String currentEndDate = newTimeDate +' 23:59:59';
        DateTime endDate = Datetime.valueOfGmt(currentEndDate);
        
        system.debug('startDate::'+startDate);
        system.debug('endDate::'+endDate);
        String logOut ='logged out';
        String logIn ='logged in';
        List<String> userList = new List<String>{}; 
        List<String> userListEC = new List<String>{}; 
        if (!rawData.isEmpty()) {
            For(Raw_Employee_Punch__c record : rawData){ 
                String[] splitted = record.User_Name__c.split('\\@');
                userList.add(splitted[0]);
             }
        }
        
        system.debug('updateEmploye userList::'+userList);
        List<Employee_Calendar__c> missPunchOuts = [Select Id, Punch_In_DateTime__c,Punch_Out_DateTime__c,User__r.Username,
                                                    CreatedDate from Employee_Calendar__c where Punch_Out_DateTime__c =: null
                                                    AND CreatedDate >=: startDate AND CreatedDate <=: endDate];
       
        // Update Missing PunchOut time in Employe Calendar
   
        system.debug('missPunchOuts::'+missPunchOuts);
        if (!missPunchOuts.isEmpty()) {
            for(Employee_Calendar__c punchOutData : missPunchOuts){
                if(punchOutData.User__r.Username!=null){
                    String[] splitted = punchOutData.User__r.Username.split('\\@');
                    system.debug('splitted::'+splitted[0]);
                	String username = splitted[0];
                    // finish for loop
                	// check empty list 
                
                	List<Raw_Employee_Punch__c> rawEmployees = [Select Status__c,User_Name__c,Message__c,Timelog__c,CreatedDate from Raw_Employee_Punch__c
                                                            Where User_Name__c =: splitted[0] AND Timelog__c >=:currentStartDate AND Timelog__c <=:currentEndDate
                                                            AND Status__c =: 'Successful' Order by Timelog__c desc];
                        system.debug('rawEmployee::'+rawEmployees);
                        if (!rawEmployees.isEmpty()) {
                            Integer flag = 0;
                            for(Raw_Employee_Punch__c rowEmp : rawEmployees){
                                system.debug('rawEmployee contains Logout::'+rowEmp.Message__c.contains(logOut));
                                Datetime punchOutTime = Datetime.valueOf(rowEmp.Timelog__c);
                                system.debug('rowEmp.User_Name__c::'+rowEmp.User_Name__c+'=='+username);
                                system.debug('punchOutTime::'+punchOutTime);
                                if(rowEmp.User_Name__c.contains(username) && rowEmp.Message__c.contains(logOut) && flag==0){
                                   // add into list
                                   punchOutData.Punch_Out_DateTime__c = punchOutTime;
                                   punchOutData.LogIn_Status__c = 'Stop';
                                   update punchOutData;
                                   flag =1;
                                   system.debug('After Update punchOutData::'+punchOutData);
                                }
                            } 
                        }  
            		}
                }
        } 
        // update list is empty
        
        List<Employee_Calendar__c> missPunchIns = [Select Id, Punch_In_DateTime__c,Punch_Out_DateTime__c,User__r.Username,CreatedDate from Employee_Calendar__c 
                                                   where Punch_In_DateTime__c =: null AND CreatedDate >=: startDate AND CreatedDate <=: endDate];
        system.debug('missPunchIns::'+missPunchIns);
        
        // Update Missing PunchOut time in Employe Calendar
        if (!missPunchIns.isEmpty()) {
            for(Employee_Calendar__c punchInData : missPunchIns){
                if(punchInData.User__r.Username != null){
                    String[] splitted = punchInData.User__r.Username.split('\\@');
                    system.debug('splitted::'+splitted[0]);
                    String username = splitted[0];
                    List<Raw_Employee_Punch__c> rawEmployees = [Select Status__c,User_Name__c,Message__c,Timelog__c,CreatedDate from Raw_Employee_Punch__c 
                                                                Where User_Name__c =:splitted[0] AND Timelog__c >=:currentStartDate AND Timelog__c <=:currentEndDate 
                                                                AND Status__c =: 'Successful' Order by Timelog__c asc];
                    system.debug('missPunchIns rawEmployee::'+rawEmployees);
                    if (!rawEmployees.isEmpty()) {
                        Integer flag = 0;
                        for(Raw_Employee_Punch__c rowEmp : rawEmployees){
                            Datetime punchInTime = Datetime.valueOf(rowEmp.Timelog__c);
                            system.debug('missPunchIns punchInTime::'+punchInTime);
                            system.debug('missPunchIns condition check username::'+rowEmp.User_Name__c+'=='+username);
                            if(rowEmp.User_Name__c.contains(username)){
                                system.debug('missPunchIns username true::'+username);
                                if(rowEmp.Message__c.contains(logIn) && flag==0){
                                   punchInData.Punch_In_DateTime__c = punchInTime;
                                   punchInData.LogIn_Status__c = 'Stop';
                                   update punchInData;
                                   flag =1;
                               }  
                        } 
                      }
                    }
                }
            }
        } 
        
        List<Employee_Calendar__c> missAllPunchs = [Select Id, Punch_In_DateTime__c,Punch_Out_DateTime__c,User__r.Username,CreatedDate from Employee_Calendar__c 
                                                    where Punch_Out_DateTime__c =: null AND Punch_In_DateTime__c =: null AND CreatedDate >=: startDate AND CreatedDate <=: endDate];
        system.debug('missAllPunchs::'+missAllPunchs);
        
        // Update Missing PunchAll time in Employe Calendar
        if (!missAllPunchs.isEmpty()) {
            for(Employee_Calendar__c punchAllData : missAllPunchs){
                if(punchAllData.User__r.Username != null){
                    String[] splitted = punchAllData.User__r.Username.split('\\@');
					system.debug('splitted::'+splitted[0]);
                	String username = splitted[0];
                	List<Raw_Employee_Punch__c> rawEmployees = [Select Status__c,User_Name__c,Message__c,Timelog__c,CreatedDate from Raw_Employee_Punch__c 
                                                            Where User_Name__c =:splitted[0] AND Timelog__c >=:currentStartDate AND Timelog__c <=:currentEndDate 
                                                            AND Status__c =: 'Successful' Order by Timelog__c asc];
                
                	system.debug('rawEmployee::'+rawEmployees);
                    if (!rawEmployees.isEmpty()) {
             		Integer flag = 0;
                    for(Raw_Employee_Punch__c rowEmp : rawEmployees){
                        system.debug('rawEmployee contains Logout::'+rowEmp.Message__c.contains(logOut));
                        Datetime punchInTime = Datetime.valueOf(rowEmp.Timelog__c);
                        Datetime punchOutTime = Datetime.valueOf(rowEmp.Timelog__c);
                        if(rowEmp.User_Name__c.contains(username)){
                            if(rowEmp.Message__c.contains(logIn)  && flag==0){
                                punchAllData.Punch_In_DateTime__c = punchInTime;
                                punchAllData.LogIn_Status__c = 'Stop';
                                update punchAllData;
                                flag=1;
                            }else if(rowEmp.Message__c.contains(logOut)){
                                punchAllData.Punch_Out_DateTime__c = punchOutTime;
                                punchAllData.LogIn_Status__c = 'Stop';
                                update punchAllData;
                            	}
                        	}
                    	} 
                	}
                }  
            }
        }
        
        List<Employee_Calendar__c> missUserName = [Select Id, Punch_In_DateTime__c,Punch_Out_DateTime__c,User__r.Username,CreatedDate from Employee_Calendar__c 
                                                   where CreatedDate >=: startDate AND CreatedDate <=: endDate];
        
        system.debug('missUserName::'+missUserName);
        if (!missUserName.isEmpty()) {
            For(Employee_Calendar__c record : missUserName){
                String[] splitted = record.User__r.Username.split('\\@');
                String username = splitted[0];
                userListEC.add(username);
             }
        }
        system.debug('userListEC::'+userListEC);
        List<String> missUserList = new List<String>{}; 
        For(String use_record : userList){ 
            if(!userListEC.contains(use_record)){
                missUserList.add(use_record);
            }
        }
        system.debug('missUserList::'+missUserList);
        
        // Update Missing PunchAll time in Employe Calendar
         Datetime punchInTime;
         Datetime punchOutTime;
         List<Employee_Calendar__c> newEmployess = new List<Employee_Calendar__c>{};
         List<String> userExist = new List<String>{}; 
        if (!missUserList.isEmpty()) {
            system.debug('missUserList::'+missUserList);
            Date yesterDayDate = System.today()-1;
            for(String missUser : missUserList){
                List<Raw_Employee_Punch__c> rawEmploye1 = [Select Status__c,User_Name__c,Message__c,Timelog__c,CreatedDate from Raw_Employee_Punch__c 
                                                           Where User_Name__c =:missUser AND Timelog__c >=:currentStartDate AND Timelog__c <=:currentEndDate 
                                                           AND Status__c =: 'Successful' Order by Timelog__c asc];
                system.debug('rawEmploye1::'+rawEmploye1.size());
                if (!rawEmploye1.isEmpty()) {
             		Integer flag = 0;
                    String searchUser= missUser+'@%';
                    List<Employee_Calendar__c> empCalUser = [SELECT Id, User__r.Username, Contact_Name__c, User__c FROM Employee_Calendar__c where User__r.Username LIKE : searchUser AND Contact_Name__c != null limit 1];
                    
                    String userID =null;
                    String contactID =null;
                    
                    system.debug('empCalUser Size'+ empCalUser);
                    
                    if(empCalUser.size() >0){
                        userID = empCalUser.get(0).User__c;
                        contactID = empCalUser.get(0).Contact_Name__c;
                    }else{
                        User userRecord = [Select Id from User where Email LIKE : searchUser limit 1];
                        userID = userRecord.Id;
                        //contactID = empCalUser.Contact_Name__c;
                    }
                    
                    for(Raw_Employee_Punch__c rowEmp : rawEmploye1){
                        if(rowEmp.Message__c.contains(logIn)  && flag==0){
                            system.debug('punchInTime::'+punchInTime);
                            punchInTime = Datetime.valueOf(rowEmp.Timelog__c);
                            flag =1;
                        }else if(rowEmp.Message__c.contains(logOut)){
                            punchOutTime = Datetime.valueOf(rowEmp.Timelog__c);
                            system.debug('punchOutTime::'+punchOutTime);
                        }
                    }
                         system.debug('userExist::'+userExist);
                         system.debug('check condition::'+userExist.contains(missUser));

                          if(!userExist.contains(missUser)){
                            Employee_Calendar__c empCal = New Employee_Calendar__c();
                            empCal.Punch_In_DateTime__c = punchInTime;
                            empCal.Punch_Out_DateTime__c = punchOutTime;
                            empCal.User__c = userID;
                        	empCal.Contact_Name__c = contactID;
                            empCal.Date__c = yesterDayDate;
                            empCal.LogIn_Status__c = 'Stop';
                            newEmployess.add(empCal);
                            userExist.add(missUser);
                            system.debug('newEmployess::'+newEmployess);
                          }    
                       
                    } 
                }
               insert newEmployess;
            system.debug('Insert newEmployess::'+newEmployess);
            }
       
        system.debug('missUserList::'+missUserList);
        
    }
    
    /*
		Get today Wifi Logs Data  
		Match with Username in Wifi Data
		Find Punch In and Out Logs from Wifi Data
	*/
    public void getWifiTodayData() {
        //DateTime dt;
        Datetime systemDate = System.now()-1;
        String timeDate = systemDate.format('yyyy-MM-dd');
        String currentStartDate = timeDate +' 00:05:00';
		Datetime startDate = Datetime.valueOfGmt(currentStartDate);
            
        String currentendDate = timeDate +' 23:59:59';
        DateTime endDate = Datetime.valueOfGmt(currentendDate);

        String username ='';
        List<String> userList = new List<String>{};  
        List<User> orgUsers = [Select Username from User where IsActive =: true];
        
        For(User userdata : orgUsers){
                String[] splitted = userdata.Username.split('\\@');
                userList.add(splitted[0]);
         }
        system.debug('userList::'+userList);
        
        List<Raw_Employee_Punch__c> rawEmployeeLogs = [Select Event_Type__c,Message__c,Severity__c,Source__c,Status__c,User_Name__c,
                                                       Timelog__c, CreatedDate from Raw_Employee_Punch__c Where User_Name__c IN :userList AND
                                                       Timelog__c >=:currentStartDate AND Timelog__c <=:currentendDate AND Status__c =: 'Successful'];
        //List<Raw_Employee_Punch__c> rawEmployeeLogs = [Select Event_Type__c,Message__c,Severity__c,Source__c,Status__c,User_Name__c,Timelog__c from Raw_Employee_Punch__c Where Timelog__c >=:rawTimelog1 AND Timelog__c <=:rawTimelog2 AND Status__c =: 'Successful'];
        system.debug('rawEmployeeLogs::'+rawEmployeeLogs);
        system.debug('rawEmployeeLogs size '+rawEmployeeLogs.size());
        if (rawEmployeeLogs.isEmpty()) {
			return;
        }else{
            updateEmployeCalendarData(rawEmployeeLogs);
        }
    }
    
    
    
     /*
		Get today Wifi Logs Data  
		Match with Username in Wifi Data
		Find Punch In and Out Logs from Wifi Data
	*/
    public void deleteDateData() {
        Datetime systemDate = System.now()-5;
        String timeDate = systemDate.format('yyyy-MM-dd');
        String currentStartDate = timeDate +' 00:05:00';
		Datetime startDate = Datetime.valueOfGmt(currentStartDate);
            
        String currentendDate = timeDate +' 23:59:59';
        DateTime endDate = Datetime.valueOfGmt(currentendDate);
        
        List<Raw_Employee_Punch__c> rawEmployeeLogs = [Select Event_Type__c,Message__c,Severity__c,Source__c,Status__c,User_Name__c,
                                                       CreatedDate from Raw_Employee_Punch__c 
                                                       Where CreatedDate >=:startDate AND CreatedDate <=:endDate];
       
         system.debug('rawEmployeeLogs size '+rawEmployeeLogs.size());
        if (!rawEmployeeLogs.isEmpty()) {
            delete rawEmployeeLogs;
			system.debug('Record has been deleted');
        }
    }
    
}