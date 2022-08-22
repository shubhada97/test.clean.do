@isTest()
public class Flame_TestDataFactory {
    public static void TestDataFactory(){
        system.debug('testfactory start');
    }
    
    //Account Creation
    public static Account createAccount(String Name,Id RecordTypeIdAccount)
    {
        system.debug('account test factory');
        Account accountObj = new Account();
        accountObj.Name = Name;
        accountObj.RecordTypeId = RecordTypeIdAccount;
        insert accountObj;
        return accountObj;
    }
    
    //Contact Creation
    public static Contact createContact(String fName,String lName,String primaryContactType,Id accountId,String email,Id recordTypeId,Integer employeeId,
                                        Date dateofJoining,String department,String faculty,Id ReportsToId,String Gender)
    {
        Contact contactObj = new Contact();
        contactObj.FirstName = fName;                              
        contactObj.LastName = lName;
        contactObj.Primary_Contact_Type__c = primaryContactType;
        contactObj.AccountId = accountId;
        contactObj.Email = email;
        contactObj.RecordTypeId = recordTypeId;
        contactObj.Employee_Id__c = employeeId;
        contactObj.Date_of_Joining__c = dateofJoining;
        contactObj.Department = department;
        contactObj.Faculty__c = faculty;
        contactObj.ReportsToId = ReportsToId;
        contactObj.Gender__c = Gender;  
        contactObj.Earned_Leave_Balance__c = 5;
        contactObj.Casual_Leave_Balance__c = 5;
        contactObj.Faculty_Researching_and_Consulting__c = 5;
        contactObj.CompOff_Balance__c = 5;
        contactObj.Maternity_Paternity_Leave_Balance__c = 5;
        contactObj.Classfication_Staff__c = true;
        
        insert contactObj;  
        
        return contactObj;
    }
    
    
    
    //User Creation
    public static User createUser(Contact cont,Id ProfileId)
    {
        User userObj = new User();
        userObj.FirstName = cont.firstName;
        userObj.LastName = cont.lastName.substring(0,3);
        userObj.Email = cont.Email;
        userObj.ContactId = cont.id;
        userObj.CommunityNickname = cont.lastName.substring(0,3);
        userObj.Alias = cont.firstName.substring(0,1) + cont.lastName.substring(0,2);
        userObj.IsActive = true;
        userObj.LanguageLocaleKey = 'en_US';
        userObj.TimeZoneSidKey = 'Asia/Kolkata';
        userObj.LocaleSidKey = 'en_IN';
        userObj.EmailEncodingKey = 'ISO-8859-1';
        userObj.Username = cont.Email;
        userObj.ProfileId = ProfileId;
        
        insert userObj;
        
        return userObj;
        
        
    }
    
    //Employee Calendar Creation
    public static Employee_Calendar__c createEmployeeCalendar(Id contacID, Decimal EmployeeCode,Date punchDate,String attendance)
    {
        Id RecordTypeIdEmpPunch = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId();
        
        Employee_Calendar__c employeeCalendarObj = new Employee_Calendar__c();
        employeeCalendarObj.RecordTypeId = RecordTypeIdEmpPunch;
        employeeCalendarObj.Contact_Name__c = contacID;
        employeeCalendarObj.Employee_Code__c = String.valueOf(EmployeeCode);
        employeeCalendarObj.Date__c = punchDate;
        employeeCalendarObj.In_Time__c = Time.newInstance(9, 0, 0, 0);
        if(attendance == 'Present')
        {
            employeeCalendarObj.Out_Time__c = Time.newInstance(6, 0, 0, 0);
        }
        else if(attendance == 'Half Day')
        {
            employeeCalendarObj.Out_Time__c = Time.newInstance(12, 0, 0, 0);
        }
        else if(attendance == 'Absent'){
            employeeCalendarObj.Out_Time__c = Time.newInstance(9, 0, 0, 0);
        }
        else if(attendance == 'Future'){
            user getsu = [select id from user where ContactId =: contacID];
            employeeCalendarObj.Punch_Request_Submitter__c = getsu.id;
            employeeCalendarObj.Out_Time__c = Time.newInstance(9, 0, 0, 0);
            employeeCalendarObj.Expected_In_Time__c = Time.newInstance(9, 0, 0, 0);
            employeeCalendarObj.Expected_Out_Time__c = Time.newInstance(6, 0, 0, 0);
            employeeCalendarObj.OnDuty_Leave__c = 'Official Regularized Visit';
            employeeCalendarObj.Comments__c = 'Testing';
            employeeCalendarObj.Applied_For_Regularization__c = true;
            employeeCalendarObj.Status__c = 'Pending';
        }
        insert employeeCalendarObj;
        if(attendance == 'Future'){
            
            contact con = [SELECT Id,ReportsToId FROM Contact where id =: contacID];
            user userapprover = [SELECT Id, Name, ContactId FROM User WHERE ContactId =: con.ReportsToId];
            //ReportsToId
            //Flow.Interview.Regularization_Approval_Flow submitForApproval = new Flow.Interview.Regularization_Approval_Flow(new map<String,Object>{'RecordId' => employeeCalendarObj.Id,'CurrentUserId' => getsu.Id,'Approvar' => userapprover.Id});
           // submitForApproval.start();
        }
        return employeeCalendarObj;
        
    }
    
    //Leave Ledger
    public static Leave_Ledger__c createLeaveLedger(Id ContactId ,Decimal ContactEmployeeId ,Id Approver,Id submitter,Id recordTypeId,String LeaveAction, Date fromDate , Date toDate ,Decimal totalDays , String leaveType)
    {
        Leave_Ledger__c leaveApplication = new Leave_Ledger__c();
        leaveApplication.Employee_Name__c = ContactId;
        leaveApplication.Applied_To__c = Approver;
        leaveApplication.Leave_Action__c = LeaveAction;
        leaveApplication.RecordTypeId = recordTypeId;
        leaveApplication.Employee_Id__c = ContactEmployeeId;
        leaveApplication.Leave_Request_Submitter__c = submitter;
        leaveApplication.OwnerId = submitter;
        leaveApplication.Leave_Type__c = leaveType;
        if(leaveType == 'CompOff Request'){
            leaveApplication.Status__c = 'Approved';
            leaveApplication.From_Date__c = fromDate;
            leaveApplication.CompOff_Expired__c = false;
            leaveApplication.CompOff_Used__c = false;
        }
        else{
            leaveApplication.From_Date__c = fromDate;
            leaveApplication.To_Date__c = toDate;
        }
        leaveApplication.Total_Days__c = totalDays;
        leaveApplication.Reason__c = 'Testing fac' ;
        
        insert leaveApplication;                                   
        
        return leaveApplication;
    }
    
}