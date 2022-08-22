public class LeaveApplicationController {
    
    public String leavetype{get;set;}
    public List<SelectOption> LeaveTypes{get;set;}
    public String userId { get; set; } 
    public User currentUser{get;set;} 
    public Leave_Ledger__c ledger{get;set;}
    public Leave_Setting__mdt leaveSettingObj {get;set;}
    public Contact con{get;set;}
    public Boolean approvalLinkBool {get;set;}
    public List<Leave_Ledger__c> listLedger {get;set;}
    public List<Leave_ledger__c> LeaveLedgerForCompOff{get;set;}
    public RecordType recTypeId {get;set;}
    public boolean successBool {get; set;}
    public boolean errorBool {get; set;}
    public List<balanceData> listBalanceData{get;set;}		// List to show leave balance and available balance
    
    public string SuccessMsg {get;set;}
    public boolean displayPanel1 {get; set;}
    public boolean displayPanel2 {get; set;}
    //public boolean cpLeave {get;set;}
    public Decimal EarnAvail {get;set;}			// capture available balance
    public Decimal CasualAvail {get;set;}		// capture available balance
    public Decimal Pat_MatAvail {get;set;}		// capture available balance
    public Decimal FacultyAvail {get;set;}		// capture available balance
    public Decimal CompAvail {get;set;}			// capture available balance
    public Date todayDate {get; set;}
    
    public List<ContentVersion> contentVersionList {get;set;}
    public List<ContentDocument> contentDocumentList {get;set;}
    public String publicURL {get;set;}
    public ContentVersion file{get; set;}
    
    //Controller Method
    public LeaveApplicationController(){    
        
        userId = userinfo.getuserId();
        
        LeaveTypes = new List<SelectOption>();
        ledger = new Leave_Ledger__c();
        currentUser = new User();
        recTypeId = new RecordType();
        boolean display;
        Datetime dt = (Datetime)system.today(); 
        todayDate = system.today();
        
        
        file= new ContentVersion();
        contentVersionList = new List<ContentVersion>();
        contentDocumentList = new List<ContentDocument>();
        publicURL='';
        
        currentUser=[Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id=: userId];
        system.debug('currentUser.contactID '+currentUser.contactId);
        con = [Select Id,Name,Employee_Id__c from Contact Where Id =: currentUser.contactId];
        recTypeId = [Select Id From RecordType  Where SobjectType = 'Leave_Ledger__c' and DeveloperName = 'Debit'];
        
        system.debug('currentUser:: '+currentUser);
        system.debug('if someone reprts to me > :: '+[SELECT id, name FROM Contact WHERE ReportsToId =: con.Id]);
        if([SELECT COUNT() FROM Contact WHERE ReportsToId =: currentUser.ContactId] > 0){
            approvalLinkBool = true;
        }
        else{
            approvalLinkBool = false;
        }
        
        getContactFields();
    }
    
    //Get all the required details for leave submition
    public void getContactFields(){
        try{
            
            listBalanceData = new List<balanceData>();
            ledger = new Leave_Ledger__c();
            LeaveTypes = new List<SelectOption>();
            leaveSettingObj = new Leave_Setting__mdt();
            listLedger = new List<Leave_Ledger__c>();
            LeaveLedgerForCompOff = new List<Leave_Ledger__c>();
            successBool = false;
            errorBool = false;
            
            ledger.Leave_Action__c = 'Debit';
            ledger.RecordTypeId = recTypeId.id;
            
            ledger.From_Date__c = System.today();
            ledger.To_Date__c = System.today();
            
            EarnAvail = 0.0;
            CasualAvail = 0.0;
            Pat_MatAvail = 0.0;
            FacultyAvail = 0.0;
            CompAvail = 0.0;
            //--------new leave type code should come here-----------------//Start
            // 			*INITIALIZE VARIABLES WITH ZERO*
            //--------new leave type code should come here-----------------//End
            
            
            
            //--------new leave type code should come here-----------------//Start
            
            //		*ADD NEW CUSTOM METADA SETTING TO THIS SOQL*
            leaveSettingObj = [SELECT Id, Sandwich_Earned__c, Sandwich_Casual__c,Casual_Leave_Max_Days_Apply__c,Year_Start_In_Month__c,Sandwich_CompOff__c, Sandwich_Maternity_Paternity__c,CompOff_Past_maximum_Days__c,CompOff_Expiration_Days__c, Sandwich_Faculty_Researching_and_Consult__c, Future_Leave_Maximum_Days__c,Past_Leave_Maximum_Days__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
            
            //		*ADD NEW LEAVE BALANCE FIELD OF CONTACT TO THIS OBJECT*
            con = [SELECT Id, MobilePhone,Date_of_Joining__c,Blood_Group__c,CompOff_Balance__c,Name,Email,primary_contact_type__c,Earned_Leave_Balance__c,Gender__c,Casual_Leave_Balance__c, Designation_Name__c,Grade_Name__c, Department__c, Faculty__c,Faculty_Researching_and_Consulting__c,Maternity_Paternity_Leave_Balance__c, ReportsTo.Name,ReportsToId,Employee_Id__c,DOB__c,Contact_Address_Line_1__c,Permanent_Address_Line_1__c,Contact_Address_Line_2__c,Permanent_Address_Line_2__c,FU_Applicant_Other_City__c,FU_Applicant_Other_State__c,FU_Applicant_Other_Country__c,Contact_City__c,Contact_State__c,Contact_Country__c  FROM Contact where id =:currentUser.contactId];    
            
            //--------new leave type code should come here-----------------//End
            
            User userApprover = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where contactId =: con.ReportsToId];
            
            System.debug('Contant of User '+con);
            System.debug('Approvar of User '+userApprover);
            
            ledger.Employee_Name__c = con.id;
            ledger.Employee_Id__c = con.Employee_Id__c;
            ledger.Leave_Request_Submitter__c = currentUser.Id;
            
            ledger.Applied_To__c = userApprover.id;
            ledger.Apply_To__c = userApprover.Name;
            
            
            //--------Get all Pending leaves to get available Balances-----------------//Start
            List<Leave_Ledger__c> llList = [SELECT Id,Employee_Name__r.Name, RecordType.Name, Leave_Type__c, Total_Days__c FROM Leave_Ledger__c where status__c ='Pending' and Employee_Name__c=: currentUser.contactId AND RecordType.Name = 'Debit'];
            system.debug('===== LLlist' +llList);
            
            for(Leave_Ledger__c ll :llList){
                system.debug('leave ledger :' +ll);
                system.debug('total balance :' +ll.Total_Days__c);
                if(ll.Leave_Type__c == 'Earned Leave'){
                    EarnAvail = EarnAvail + ll.Total_Days__c;
                }
                else if(ll.Leave_Type__c == 'Casual Leave'){
                    CasualAvail = CasualAvail + ll.Total_Days__c;
                }
                else if(ll.Leave_Type__c == 'Paternity Leave' || ll.Leave_Type__c == 'Maternity Leave'){
                    Pat_MatAvail = Pat_MatAvail + ll.Total_Days__c;
                }
                else if(ll.Leave_Type__c == 'Consulting Leave' || ll.Leave_Type__c == 'Researching Leave'){
                    FacultyAvail = FacultyAvail + ll.Total_Days__c;
                }
                else if(ll.Leave_Type__c == 'CompOff Leave'){
                    CompAvail = CompAvail + ll.Total_Days__c;
                }
                //--------new leave type code should come here-----------------//Start
                //		*CHECK WITH LEAVE TYPE NAME AND ADD INTO RESPECTIVE VARIABLE*
                //--------new leave type code should come here-----------------//End
            }
            
            if(con.Earned_Leave_Balance__c != null){
                EarnAvail = con.Earned_Leave_Balance__c - EarnAvail;
            }
            else{
                EarnAvail = 0;
            }
            if(con.Casual_Leave_Balance__c != null){
                CasualAvail = con.Casual_Leave_Balance__c - CasualAvail;
            }
            else{
                CasualAvail = 0;
            }
            if(con.Maternity_Paternity_Leave_Balance__c != null){
                Pat_MatAvail = con.Maternity_Paternity_Leave_Balance__c - Pat_MatAvail;
            }
            else{
                Pat_MatAvail = 0;
            }
            if(con.Faculty_Researching_and_Consulting__c != null){
                FacultyAvail = con.Faculty_Researching_and_Consulting__c - FacultyAvail;
            }
            else{
                FacultyAvail = 0;
            }
            if(con.CompOff_Balance__c != null){
                CompAvail = con.CompOff_Balance__c - CompAvail;
            }
            else{
                CompAvail = 0;
            }
            //--------new leave type code should come here-----------------//Start
            //		*CHECK WITH LEAVE TYPE NAME AND ADD INTO RESPECTIVE VARIABLE*
            //--------new leave type code should come here-----------------//End
            
            //--------Get all Pending leaves to get available Balances-----------------//End
            
            
            //--------Get all values of pick list and prepare according to current user-----------------//Start
            
            Schema.DescribeFieldResult lt = Leave_Ledger__c.Leave_Type__c.getdescribe();
            list<Schema.picklistentry> TypeList = lt.getpicklistvalues();
            
            system.debug('check point');
            LeaveTypes.add(new selectOption('None','Select Leave'));
            for(Schema.picklistentry s : TypeList){
                if(s.getValue() == 'Earned Leave'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.Earned_Leave_Balance__c , EarnAvail));
                }
                else if(s.getValue() == 'Casual Leave'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.Casual_Leave_Balance__c , CasualAvail));
                }                     
                else if((s.getValue() == 'Consulting Leave' || s.getValue() == 'Researching Leave' ) && con.primary_contact_type__c =='Faculty'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(con.Gender__c == 'Male' && s.getValue() == 'Paternity Leave'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.Maternity_Paternity_Leave_Balance__c , Pat_MatAvail));
                }
                else if(con.Gender__c == 'Female' && s.getValue() == 'Maternity Leave'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.Maternity_Paternity_Leave_Balance__c , Pat_MatAvail));
                }
                else if(s.getValue() == 'CompOff Request'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(s.getValue() == 'CompOff Leave'){
                    LeaveTypes.add(new selectoption(s.getvalue(),s.getlabel()));
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.CompOff_Balance__c , CompAvail));
                }
                else if(s.getValue() == 'Faculty Consulting Researching Leave' && con.primary_contact_type__c =='Faculty'){
                    listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , con.Faculty_Researching_and_Consulting__c , FacultyAvail));
                }
                
                //--------new leave type code should come here-----------------//Start
                //
                //		else if(check API name with string && other condition if requered){
                //				add balances to show on page
                //				listBalanceData.add(new balanceData(s.getlabel().split('-')[0] , s.getlabel().split('-')[1] , *RESPECTIVE BALANCE FIELD* , *RESPECTIVE AVAILABLE BALANCE VARIABLE*));
                // 			
                // 				if it is also an leave type then add this
                // 				LeaveTypes.add(new selectOption( API_Name/Value , Label Name );
                // 		
                // 		}
                // 		
                //--------new leave type code should come here-----------------//End
                
                
            }
            //--------Get all values of pick list and prepare according to current user-----------------//End
            
            system.debug('listBalanceData::'+listBalanceData);
            findProfileImage(con.id);
            
        }
        catch(Exception e){
            system.debug(e.getmessage());
        }
        
        //picklistChangeMethod();
        
    }  
    
    //-- get profile image url  
    public void findProfileImage(String conId){
        System.debug('Profile method start : '+conId);
        Set<String> cdIDSet = new Set<String>();
        for(ContentDocumentLink cdl : [SELECT ContentDocumentId,Id,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: conId]){
            cdIDSet.add(cdl.ContentDocumentId);
        }
        
        contentVersionList = [SELECT id, Title ,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN: cdIDSet AND Title ='Profie Image'];
        
        if(contentVersionList.size()>0){
            contentDocumentList = [SELECT id FROM ContentDocument WHERE Id =: contentVersionList[0].ContentDocumentId];
        }
        if(contentVersionList.size()>0){
            String baseURL = System.URL.getSalesforceBaseURL().toExternalForm();                                
            publicURL = baseURL.replace('visual','content');
            publicURL+='/sfc/servlet.shepherd/version/download/'+contentVersionList[0].id;          
        }else{
            publicURL='';
        }
    }
    
    //--when picklist change
    public void picklistChangeMethod(){
        
        Boolean check = false;
        
        if(leavetype == 'Earned Leave'){
            if(leaveSettingObj.Sandwich_Earned__c){
                check = true;
            }
        }
        else if(leavetype == 'Casual Leave'){
            if(leaveSettingObj.Sandwich_Casual__c){
                check = true;
            }
        }
        else if(leavetype == 'Paternity Leave' || leavetype == 'Maternity Leave'){
            if(leaveSettingObj.Sandwich_Maternity_Paternity__c){
                check = true;
            }
        }
        else if(leavetype == 'Consulting Leave' || leavetype == 'Researching Leave'){
            if(leaveSettingObj.Sandwich_Faculty_Researching_and_Consult__c){
                check = true;
            }
        }
        else if(leavetype == 'CompOff Leave'){ 
            if(leaveSettingObj.Sandwich_CompOff__c){
                ledger.To_Date__c = ledger.From_Date__c;
                check = true;
            }
        }
        
        //--------new leave type code should come here-----------------//Start
        //		*CHECK NEW SANDWICH LEAVE WITH CUSTOM METADATA SETTING*
        //--------new leave type code should come here-----------------//END
        
        
        /* show message on the page that Sandwich Policy applied for this Leave type
if(check){
successBool=true;
errorBool = true;
//SuccessMsg = 'Sandwich Policy applied for this Leave type';
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Sandwich Policy applied for this Leave type'));
}*/
        
        if(leavetype == 'CompOff Request'){
            ledger.From_Date__c = System.today().addDays(-1);
            
            displayPanel2 = true;
            displayPanel1 = false;
        }
        else{
            displayPanel2 = false;
            displayPanel1 = true;
        }
    }
    
    //-- go to my info page
    public PageReference reDirect(){
        PageReference orderPage = new PageReference('/apex/Flame_EmpInfo');
        orderPage.setRedirect(true);
        return orderPage;
    }
    
    //-- toggle OK buttons
    public PageReference toogle(){
        successBool = false;
        errorBool = false;
        return null;
    }
    
    //--refresh the page
    public PageReference Cancel(){        
        PageReference orderPage = new PageReference('/apex/FlameLeaveApplication');
        orderPage.setRedirect(true);
        return orderPage; 
    }  
    
    //--Comp-Off request insertion as Leave Ledger.
    public PageReference SaveCR()
    {
        errorBool = true;
        successBool = true;
        //SuccessMsg = '';
        
        Id devRecordTypeId = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();         
        //system.debug('CR details :: '+ledger.From_Date__c +' & leave type is '+ leavetype);
        Date fromDate = ledger.From_Date__c;
        ledger.To_Date__c = ledger.From_Date__c;
        ledger.Leave_Type__c = leavetype;
        ledger.Leave_Action__c = 'Credit';
        ledger.Total_Days__c = 1;
        Decimal compOffDays = con.CompOff_Balance__c; 
        Integer daysDiffpast = fromDate.daysBetween(System.today());
        Date Today = System.today();
        //CompOff_Expiration_Days__c
        listLedger = [Select id, name, From_Date__c,Leave_Type__c, To_Date__c from Leave_Ledger__c where (From_Date__c  =: fromDate OR To_Date__c  =: fromDate OR (From_Date__c  >: fromDate AND To_Date__c  <: fromDate)) AND Leave_Type__c = 'CompOff Request' AND Status__c != 'Rejected' AND Status__c != 'Cancelled' AND Status__c != 'Roll-Back' AND Employee_Id__c =: ledger.Employee_Id__c];
        
        List<Employee_Calendar__c> Holiday = [SELECT Id, Name, In_Time__c, Out_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c, Employee_Code__c, IsPresent__c, RecordTypeId, RecordType.Name FROM Employee_Calendar__c Where RecordType.Name =: 'Holiday Punch' And Date__c =: fromDate limit 1];
        if(listLedger.size() > 0){
            //errorBool = true;
            string datestring = listLedger[0].From_Date__c.format();
            //SuccessMsg = 'You already have request for this date :  "'+ datestring+'"';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'You already have request for this date :  '+ datestring));
        }
        
        else if(Holiday.size() > 0){
            if(leaveSettingObj.CompOff_Past_maximum_Days__c >= daysDiffpast){
                if(leaveSettingObj.CompOff_Expiration_Days__c < daysDiffpast){
                    //errorBool = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'You cannot apply for this leave as it will get expired automatically.'));
                    return null;
                }
                errorBool = false;
                ledger.RecordTypeId = devRecordTypeId;
                ledger.CompOff_Expired__c = false;
                ledger.CompOff_Used__c = false;
                insert ledger;
                //SuccessMsg = 'Compoff Request submitted Successfully!';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Compoff request submitted successfully!'));
            }
            else{
                //errorBool = true;
                //SuccessMsg = 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.CompOff_Past_maximum_Days__c)+' days in the past from the current date.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.CompOff_Past_maximum_Days__c)+' days in the past from the current date.'));
            }   
        }
        else{
            //errorBool = true;
            //SuccessMsg = 'CompOff Request can be applied for holidays only.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'CompOff request can be applied for holidays only.'));
        }
        return null;
    }
    
    //--to check fromdate and toDate are in same year--//
    public boolean ValidateYearRange(Date startDate, Date endDate){
        boolean flag = false;
        Integer month = Integer.valueOf(leaveSettingObj.Year_Start_In_Month__c);
        Integer fromMonth = startDate.month();
        Integer toMonth = endDate.month();
        
        if(fromMonth < month){
            if(toMonth < month){
                flag = true;
            }
        }
        else if(endDate >= startDate){
            flag = true;
        }
        
        return flag;        
    }
    
    //--for all type of leave apply.
    public PageReference Save()
    {
        List<Date> dateList = new List<date>();
        ledger.Leave_Type__c = leavetype;
        Date fromDate = ledger.From_Date__c;
        Date toDate = ledger.To_Date__c;
        Decimal ttDays = 0;
        successBool = true;
        SuccessMsg = '';
        
        //--------Check applied leave from and to date-----------------//Start
        if(fromDate > toDate){
            errorBool = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'From date should be greater than To date'));
            return null;
        }    
        //--------Check applied leave from and to date-----------------//End
        
        //--------Get all the date range for applied leave-----------------//Start
        for(Date loopstartDate = fromDate; loopstartDate <= toDate; loopstartDate = loopstartDate.addDays(1)){
            dateList.add(loopstartDate);
        }
        //--------Get all the date range for applied leave-----------------//End
        
        //--------Get oldest comp-off request-----------------//Start
        if(ledger.Leave_Type__c == 'CompOff Leave'){
            //get all the comp off records which are not used in CompOff_Request_Reference__c of any record
            List<leave_ledger__c> lcR = [Select id,name, CompOff_Request_Reference__c FROM Leave_Ledger__c Where CompOff_Request_Reference__c != null and Employee_Id__c =: ledger.Employee_Id__c];
            List<id> lrIds = new List<id>();
            for(Leave_Ledger__c ll : lcR){
                //system.debug('ll.Name'+ll.name);
                lrIds.add(ll.CompOff_Request_Reference__c);
            }
            LeaveLedgerForCompOff = [select id , name , createdDate, CompOff_Used__c, Status__c, CompOff_Expired__c , leave_type__c from leave_ledger__c where leave_type__c = 'CompOff Request' AND RecordType.Name = 'Credit' AND (Status__c = 'Approved' OR Status__c = '' OR (From_date__c != null AND To_date__c = null)) AND CompOff_Used__c = false AND CompOff_Expired__c = false AND Employee_Id__c =: ledger.Employee_Id__c AND ID NOT IN: lrIds  Order by From_date__c ASC limit 1];
        }
        //--------Get oldest comp-off request-----------------//End
        
        //--------Check if leave already applied leave or applied future regularized-----------------//Start
        listLedger = [Select id, name, From_Date__c, To_Date__c from Leave_Ledger__c where ( (From_Date__c  IN : dateList OR To_Date__c  IN : dateList) OR ( (From_Date__c  < : dateList and To_Date__c  > : dateList) ) ) AND (Status__c != 'Rejected' AND Status__c != 'Cancelled' AND Status__c != 'Roll-Back' AND Leave_Type__c != 'CompOff Request') AND Employee_Id__c =: ledger.Employee_Id__c limit 1];
        
        if(listLedger.size() > 0){
            errorBool = true;
            for(Leave_Ledger__c ll : listLedger){
                if(dateList.contains(ll.From_Date__c)){
                    string datestring = ll.From_Date__c.format();
                    //SuccessMsg = 'You have already applied Leave for "'+datestring+'"';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have already applied leave for '+datestring));
                    return null;
                }
                else if(dateList.contains(ll.To_Date__c)){
                    string datestring = ll.To_Date__c.format();
                    //SuccessMsg = 'You have already applied Leave for "'+datestring+'"';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have already applied leave for '+datestring));
                    return null;
                }
                string fromd = ll.From_Date__c.format();
                string tod = ll.To_Date__c.format();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have already applied leave for the requested date(s). '+ll.name));
                return null;
            }
            
        }
        
        List<Employee_Calendar__c> listHolidays = [SELECT Id, Name, In_Time__c, Out_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c, Employee_Code__c, IsPresent__c, RecordTypeId, RecordType.Name , Status__c FROM Employee_Calendar__c Where (RecordType.Name =: 'Holiday Punch' And Date__c In : dateList) OR (Employee_Code__c =: String.valueOf(con.Employee_Id__c) AND Date__c In : dateList) ];
        Integer sandwichLeavesCount = 0;
        
        for(Employee_Calendar__c ec : listHolidays){
            if(ec.RecordType.Name == 'Holiday Punch'){
                if((ec.Date__c == fromDate || ec.Date__c == toDate )){
                    //SuccessMsg = 'Leave can not be Start or End on Holiday.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Leave can not be start or end on holiday.'));
                    errorBool = true;
                    
                    return null;
                }
                else{
                    sandwichLeavesCount += 1;
                }
            }
            else if(ec.RecordType.Name == 'Employee Punch'){
                if(ec.Date__c > todayDate || ec.Status__c == 'Pending' || ec.Date__c == fromDate || ec.Date__c == toDate){
                    string datestring = ec.Date__c.format();
                    //SuccessMsg = 'You have already applied regularization for '+datestring;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'You have already applied regularization for '+datestring));
                    errorBool = true;
                    return null;
                }
            }
        }
        //--------Check if leave already applied leave or applied future regularized-----------------//End
        
        //--------Check if Leave falls under Sandwich policy-----------------//Start
        Boolean sandwich = false;        
        if((ledger.Leave_Type__c == 'Earned Leave') && leaveSettingObj.Sandwich_Earned__c){
            sandwich = true;
        }
        else if((ledger.Leave_Type__c == 'Casual Leave') && leaveSettingObj.Sandwich_Casual__c){
            sandwich = true;
        }
        else if((ledger.Leave_Type__c == 'Paternity Leave' || ledger.Leave_Type__c == 'Maternity Leave') && leaveSettingObj.Sandwich_Maternity_Paternity__c){
            sandwich = true;
        }
        else if((ledger.Leave_Type__c == 'Consulting Leave' || ledger.Leave_Type__c == 'Researching Leave') && leaveSettingObj.Sandwich_Faculty_Researching_and_Consult__c){
            sandwich = true;
        }
        else if((ledger.Leave_Type__c == 'CompOff Leave') && leaveSettingObj.Sandwich_CompOff__c){
            sandwich = true;
        }
        //--------new leave type code should come here-----------------//Start
        //		*CHECK WITH RESPECTIVE CONDITIONS*
        //--------new leave type code should come here-----------------//End
        
        //--------Check if Leave falls under Sandwich policy-----------------//End
        
        //--------Calcuate Sandwich days-----------------//Start
        if(sandwich){
            ttDays = dateList.size();
        }
        else{
            ttDays = dateList.size() - listHolidays.size();
        }
        //--------Calculate Sandwich days-----------------//End
        
        //--------get Leave Balances-----------------//Start
        Decimal eldays = EarnAvail;
        Decimal cldays = CasualAvail;
        Decimal pldays = Pat_MatAvail;
        Decimal fldays = FacultyAvail;
        Decimal compOffDays = CompAvail;
        
        //--------new leave type code should come here-----------------//Start
        //		*ADD NEW LEAVE BALANCES*
        //--------new leave type code should come here-----------------//End
        //--------get Leave Balances-----------------//End
        
        //--------get date difference from current date-----------------//Start
        Date dt = ledger.From_Date__c;
        Date dt2 = ledger.To_Date__c;
        date today = System.today();
        Integer daysDiffuture = System.today().daysBetween(dt2);
        Integer daysDiffpast = dt.daysBetween(System.today());
        //--------get date difference from current date-----------------//End
        
        //--------get total days-----------------//Start
        if(Ledger.Half_day__c){
            ttDays = 0.5;
            dt2 = ledger.From_Date__c;
            ledger.To_Date__c = ledger.From_Date__c;
        }
        ledger.Total_Days__c = ttDays;
        //--------get total days-----------------//End
        
        //--------create leave record-----------------//Start
        
        if(ValidateYearRange(ledger.From_Date__c,ledger.To_Date__c)){
            if(leaveSettingObj.Future_Leave_Maximum_Days__c > daysDiffuture){
                if(leaveSettingObj.Past_Leave_Maximum_Days__c > daysDiffpast){
                    if(ledger.Leave_Type__c == 'Earned Leave'){
                        if(eldays >= ttDays){
                            insert ledger;
                            //SuccessMsg = 'Leave Applied Successfully!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Leave applied successfully!'));
                        }
                        else{
                            errorBool = true;
                            //SuccessMsg = 'You have insufficient Leave Balance!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have insufficient leave balance!'));
                        }
                    }
                    else if(ledger.Leave_Type__c == 'Casual Leave'){
                        if(cldays >= ttDays){
                            if(ttdays <= leaveSettingObj.Casual_Leave_Max_Days_Apply__c){
                                insert ledger;
                                //SuccessMsg = 'Leave Applied Successfully!';
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Leave applied successfully!'));
                            }
                            else{
                                errorBool = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Maximum days for casual leave cannot be greater than ' +leaveSettingObj.Casual_Leave_Max_Days_Apply__c +' days.'));
                            }
                        }      
                        else{
                            errorBool = true;
                            //SuccessMsg = 'You have insufficient Leave Balance!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have insufficient leave balance!'));
                        }
                    }
                    else if(ledger.Leave_Type__c == 'Paternity Leave' || ledger.Leave_Type__c == 'Maternity Leave'){
                        if(pldays >= ttDays){
                            insert ledger;
                            //SuccessMsg = 'Leave Applied Successfully!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Leave applied successfully!'));
                        }
                        else{
                            errorBool = true;
                            //SuccessMsg = 'You have insufficient Leave Balance!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have insufficient leave balance!'));
                        }
                    }
                    else if(ledger.Leave_Type__c == 'Consulting Leave' || ledger.Leave_Type__c == 'Researching Leave'){
                        if(fldays >= ttDays){
                            insert ledger;
                            //SuccessMsg = 'Leave Applied Successfully!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Leave applied successfully!'));
                        }
                        else{
                            errorBool = true;
                            //SuccessMsg = 'You have insufficient Leave Balance!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have insufficient leave balance!'));
                        }
                    }
                    else if(ledger.Leave_Type__c == 'CompOff Leave'){
                        if(compOffDays >= ttDays && LeaveLedgerForCompOff.size() >= ttDays){
                            
                            ledger.CompOff_Request_Reference__c = LeaveLedgerForCompOff[0].id;
                            insert ledger;
                            //SuccessMsg = 'Leave Applied Successfully!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Leave applied successfully!'));
                        }
                        else{
                            errorBool = true;
                            //SuccessMsg = 'You have insufficient Leave Balance!';
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You have insufficient leave balance!'));
                        }
                    }
                    //------new leave type code should come here-------//Start
                    //		*CHECK NEW LEAVE TYPE THEN TOTAL DAYS OF LEAVE WITH LEAVE BALANCE*
                    //------new leave type code should come here-------//End
                }
                else{
                    errorBool = true;
                    //SuccessMsg = 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.Past_Leave_Maximum_Days__c)+' days in the past from the current date.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.Past_Leave_Maximum_Days__c)+' days in the past from the current date.'));
                }
            }
            else{
                errorBool = true;
                //SuccessMsg = 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.Future_Leave_Maximum_Days__c)+' days in future from the current date.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Leave can be applied upto '+Integer.valueOf(leaveSettingObj.Future_Leave_Maximum_Days__c)+' days in future from the current date.'));
            }
        }
        else{
            errorBool = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Cross year leaves cannot be applied'));
        }   
        //--------create leave record-----------------//End
        return null;
    } 
    
    //WRAPPER CLASS to create list of leave balance and available balances
    public class balanceData{
        public String LeaveCode {get;set;}
        public String LeaveName {get;set;}
        public Decimal LeaveBalance {get;set;}
        public Decimal AvailableBalance {get;set;}
        
        public balanceData (String LC, String LN, Decimal LB,Decimal AB){
            LeaveCode = LC;
            LeaveName = LN;
            LeaveBalance = LB;
            AvailableBalance = AB;
        }
    }
}