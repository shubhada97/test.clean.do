@isTest
public class StudentInOutListDataTest {

    static testMethod void ValidateMathods(){
        	
        UserRole role = [select id,name from UserRole where portalType='None' limit 1];
        Profile profile = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        
        Account portalAccount = new Account(
                Name = 'FLAME Students'
            );
        Database.insert(portalAccount);
        
        //Create contact
        Contact contactRec = new Contact(
            FirstName = 'Flame',
            Lastname = 'Student',
            AccountId = portalAccount.Id,
            Primary_Contact_Type__c = 'Student'
        );
        
        	//Create Employee Calendar Record
        	Employee_calendar__c empCalRec = new Employee_calendar__c();
            empCalRec.LogIn_Status__c = 'Start';
            empCalRec.Contact_Name__c = contactRec.Id;
            DateTime dt1 = System.now();
            Time InTime = Time.newInstance(dt1.hour(), dt1.minute(), dt1.second(), dt1.millisecond());
            empCalRec.In_Time__c = InTime;
            empCalRec.GeoLocation_Start__Latitude__s = 21.1320832; 
            empCalRec.GeoLocation_Start__Longitude__s = 79.0986752;
            empCalRec.Date__c = System.TODAY();
            empCalRec.RecordTypeId = '0120K000001I5k6QAC';
          
        	Database.insert(empCalRec);
        
        	test.startTest();
        
        	String mainGateInEntery = 'True';
            String mainGateOutEntery = 'True';
        	String falseCondition = 'False';
        
           	StudentInOutDashboardController.getBatchOfFlameStudents();
        
        	StudentInOutDashboardController.getPrimaryContactType();
        
        	StudentInOutDashboardController.loadMainGateEnteryRecord();
        	
           	StudentInOutDashboardController.fetchBatchFilterStudents(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, mainGateOutEntery);
            StudentInOutDashboardController.fetchBatchFilterStudents(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, falseCondition);
            StudentInOutDashboardController.fetchBatchFilterStudents(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, falseCondition);
        	StudentInOutDashboardController.fetchBatchFilterStudents(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, mainGateOutEntery);
        
           	StudentInOutDashboardController.fetchEmployeeCalendarRecords();
        
        	StudentInOutDashboardController.getStudentInData(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, falseCondition);
            StudentInOutDashboardController.getStudentInData(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, mainGateOutEntery);
            StudentInOutDashboardController.getStudentInData(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, mainGateOutEntery);
            StudentInOutDashboardController.getStudentInData(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, falseCondition);
        
        	StudentInOutDashboardController.getStudentOutData(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, mainGateOutEntery);
            StudentInOutDashboardController.getStudentOutData(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, mainGateOutEntery);
            StudentInOutDashboardController.getStudentOutData(portalAccount.Id, contactRec.Primary_Contact_Type__c, mainGateInEntery, falseCondition);
            StudentInOutDashboardController.getStudentOutData(portalAccount.Id, contactRec.Primary_Contact_Type__c, falseCondition, falseCondition);
        
        	Test.stopTest();
    }
    
}