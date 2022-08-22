@isTest
public class syncEmployeeCalendarFromWifi_Test {
	
    static testMethod void ValidateMathods(){
        
        	List<String> orgUsers = new List<String>{'abhi.skprasad','at2','at3','at1'};
            //List<String> orgUsers = new List<String>{'abhi.skprasad1','k.vedanti666','annabelleallen99','nandidhj'};
            List<String> orgUsername = new List<String>{'abhi.skprasad@gmail.com','at2@flame.edu.in.techilapp','at3@flame.edu.in.techilapp'};
            //List<String> orgUsername = new List<String>{'abhi.skprasad1@gmail.com','k.vedanti666@gmail.com','annabelleallen99@gmail.com'};
        	//First Records
        	Datetime systemDate = System.now()-1;
        	String timeDate = systemDate.format('yyyy-MM-dd');
        	Date yesterDayDate = System.today()-1;
            system.debug('systemDate:'+systemDate);
             Raw_Employee_Punch__c rawEmp = New Raw_Employee_Punch__c();
             rawEmp.Timelog__c = timeDate+' 08:59:08';
             rawEmp.Event_Type__c = 'Firewall Authentication';
             rawEmp.Severity__c = 'Information';
             rawEmp.Message__c = 'User logged in successfully';
             rawEmp.User_Name__c = orgUsers[0];
             rawEmp.Source__c = '172.16.155.96';
             rawEmp.Status__c = 'Successful';
             Insert rawEmp;
        	
        	String punchOut = timeDate+' 18:59:08';
            Datetime punchOutTime = Datetime.valueOf(punchOut);
        	
        	User empCalUser = [Select Id from User where Username =: orgUsername[0]];
        
        	Employee_Calendar__c empCal = New Employee_Calendar__c();
        	empCal.Punch_In_DateTime__c = null;
            empCal.Punch_Out_DateTime__c = punchOutTime;
           	empCal.User__c = empCalUser.Id;
            empCal.Contact_Name__c = null;
            empCal.Date__c = System.today()-1;
        	Insert empCal;
            
            Datetime yesterday = Datetime.now().addDays(-1);
			Test.setCreatedDate(empCal.Id, yesterday);
        
       		// Second Record
        	 Raw_Employee_Punch__c rawEmp1 = New Raw_Employee_Punch__c();
             rawEmp1.Timelog__c = timeDate+' 18:59:08';
             rawEmp1.Event_Type__c = 'Firewall Authentication';
             rawEmp1.Severity__c = 'Information';
             rawEmp1.Message__c = 'User aahi.kelkar was logged out of firewall';
             rawEmp1.User_Name__c = orgUsers[1];
             rawEmp1.Source__c = '172.16.155.96';
             rawEmp1.Status__c = 'Successful';
             Insert rawEmp1;
        	
        	String punchIn = timeDate+' 18:59:08';
            Datetime punchInTime = Datetime.valueOf(punchIn);
        	
            User empCalUser1 = [Select Id from User where Username =: orgUsername[1]];
        
        	Employee_Calendar__c empCal1 = New Employee_Calendar__c();
        	empCal1.Punch_In_DateTime__c = punchInTime;
            empCal1.Punch_Out_DateTime__c = null;
           	empCal1.User__c = empCalUser1.Id;
            empCal1.Contact_Name__c = null;
            empCal1.Date__c = System.today()-1;
        	Insert empCal1;
        	Test.setCreatedDate(empCal1.Id, yesterday);
        	// Third Record
        	 Raw_Employee_Punch__c rawEmp2 = New Raw_Employee_Punch__c();
             rawEmp2.Timelog__c = timeDate+' 18:59:08';
             rawEmp2.Event_Type__c = 'Firewall Authentication';
             rawEmp2.Severity__c = 'Information';
             rawEmp2.Message__c = 'User k.vedanti666 was logged out of firewall';
             rawEmp2.User_Name__c = orgUsers[2];
             rawEmp2.Source__c = '172.16.155.96';
             rawEmp2.Status__c = 'Successful';
             Insert rawEmp2;
             
        	 Raw_Employee_Punch__c rawEmp3 = New Raw_Employee_Punch__c();
             rawEmp3.Timelog__c = timeDate+' 08:59:08';
             rawEmp3.Event_Type__c = 'Firewall Authentication';
             rawEmp3.Severity__c = 'Information';
             rawEmp3.Message__c = 'User logged in successfully';
             rawEmp3.User_Name__c = orgUsers[2];
             rawEmp3.Source__c = '172.16.155.96';
             rawEmp3.Status__c = 'Successful';
             Insert rawEmp3;
         

        	User empCalUser2 = [Select Id from User where Username =: orgUsername[2]];
        
        	Employee_Calendar__c empCal2 = New Employee_Calendar__c();
        	empCal2.Punch_In_DateTime__c = null;
            empCal2.Punch_Out_DateTime__c = null;
           	empCal2.User__c = empCalUser2.Id;
            empCal2.Contact_Name__c = null;
            empCal2.Date__c = System.today()-1;
        	Insert empCal2;
        
            Test.setCreatedDate(empCal2.Id, yesterday);
        system.debug('empCal2:'+ empCal2);
        
        //4th Record of Raw Employee Punches
        Raw_Employee_Punch__c rawEmp4 = New Raw_Employee_Punch__c();
             rawEmp4.Timelog__c = timeDate+' 08:59:08';
             rawEmp4.Event_Type__c = 'Firewall Authentication';
             rawEmp4.Severity__c = 'Information';
             rawEmp4.Message__c = 'User logged in successfully';
             rawEmp4.User_Name__c = orgUsers[3];
             rawEmp4.Source__c = '172.16.155.96';
             rawEmp4.Status__c = 'Successful';
             Insert rawEmp4;
        
        test.startTest();
    		System.schedule('Wifi Logs Test', '0 40 * * * ?', new syncEmployeeCalendarFromWifiCron());
            syncEmployeeCalendarFromWifi getRecords = new syncEmployeeCalendarFromWifi();
        	getRecords.getWifiTodayData();
            getRecords.deleteDateData();
    	test.stopTest();
    }
    
}