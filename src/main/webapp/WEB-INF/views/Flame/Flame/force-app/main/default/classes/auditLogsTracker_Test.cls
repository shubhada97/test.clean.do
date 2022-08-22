@isTest
public class auditLogsTracker_Test {
    
    static testMethod void ValidateMathods(){
        test.startTest(); 
        	
        	System.schedule('Activity Logs Tracker15', '0 40 * * * ?', new auditLogTrackerCron ());
            auditLogsTracker logScanner = new auditLogsTracker();
        	logScanner.parseAuditLogs();
		
        Test.stopTest();
    }
}