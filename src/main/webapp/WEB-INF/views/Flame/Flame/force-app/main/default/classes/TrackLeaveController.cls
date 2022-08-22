public class TrackLeaveController {
   
    public User currentUser ;
    public Contact con ;
    public String userId, EmpId ;
    public Leave_Ledger__c ledger{get;set;}
    public Date FromDate{get;set;}
    public Date ToDate{get;set;}
    public string filterDate {get;set;}
    public string filterStatus {get;set;}
    public string filterLeaveType {get;set;}
    public list<SelectOption> filterDateOptions {get;set;}
    public List<SelectOption> filterStatusOptions {get;set;}
    public List<SelectOption> filterLeaveTypeOptions {get;set;}
    public list<Leave_Ledger__c> leaveTrackList{get;set;}
    public Integer indNo {get;set;}
    public List<ProcessInstanceWorkitem> allitems {get;set;}
    public Boolean approvalLinkBool {get;set;}
    
    public boolean successBool {get; set;}
    public boolean errorBool {get; set;}
    public string SuccessMsg {get;set;}
    
    //Controller Method
    public TrackLeaveController(){   
        currentUser = new User();
        con = new Contact();
        ledger = new Leave_Ledger__c();
        leaveTrackList = new list<Leave_Ledger__c>();
        filterDateOptions = new list<SelectOption> ();
        filterStatusOptions = new List<SelectOption> ();
        filterLeaveTypeOptions = new List<SelectOption> ();
        allitems = new List<ProcessInstanceWorkitem>();
        FromDate = system.today();
        ToDate = system.today();
        
        FromDate = FromDate.addDays(-FromDate.day()+1);
        ToDate = ToDate.addDays(+Date.daysInMonth(ToDate.year(), ToDate.month())-ToDate.day());
        
        ledger.From_Date__c = FromDate;
        ledger.To_Date__c = ToDate;
        
        userId = userinfo.getuserId();
        
        
        currentUser = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id =: userId ];
        
        con = [SELECT Id,Gender__c, Name,Email,Employee_Id__c,Primary_Contact_Type__c, ReportsTo.Name FROM Contact where id =: currentUser.contactId];
        EmpId = con.id ;
        
        filterDateOptions.add(new selectoption('From_Date__c','From Date'));
        filterDateOptions.add(new selectoption('To_Date__c','To Date'));
        filterDateOptions.add(new selectoption('CreatedDate','Submitted On'));
        
        if([SELECT COUNT() FROM Contact WHERE ReportsToId =: currentUser.ContactId] > 0){
            approvalLinkBool = true;
        }
        else{
            approvalLinkBool = false;
        }
        
        getdefList();
        
    }
    
    //Get all leave ledgers
    public void getdefList(){
        try{
            successBool = false;
            errorBool = false;
            SuccessMsg = '';
            FromDate = ledger.From_Date__c;
            ToDate = ledger.To_Date__c;

            filterDate = 'From_Date__c';
            String query = 'SELECT Id, Name,Status__c, CreatedDate,Applied_To__c, Apply_To__c, LastModifiedById, Approved__c, Employee_Name__c, From_Date__c, To_Date__c, Total_Days__c,Leave_Action__c, Leave_Type__c,  Half_day__c ,Manager_Comments__c,Reason__c FROM Leave_Ledger__c where Employee_Name__c = \''+EmpId+'\' And ( ( '+filterDate +' >= :FromDate  And '+filterDate+' <=: ToDate ) OR ( CreatedDate  >= : FromDate AND CreatedDate <= :ToDate ) ) Order By CreatedDate Desc' ;
            
            leaveTrackList = Database.query(query);
            system.debug('leaveTrackList:: '+leaveTrackList);
            filterStatusOptions.add(new selectoption('None','Select Status'));
            filterLeaveTypeOptions.add(new selectoption('None','Select Leave Type'));
            Schema.DescribeFieldResult ls = Leave_Ledger__c.Status__c.getdescribe();
            list<Schema.picklistentry> StatusList = ls.getpicklistvalues();
            Schema.DescribeFieldResult lt = Leave_Ledger__c.Leave_Type__c.getdescribe();
            list<Schema.picklistentry> TypeList = lt.getpicklistvalues();
            for(Schema.picklistentry s : StatusList){
                filterStatusOptions.add(new selectoption(s.getvalue(),s.getlabel()));
            }
            
            //-----------Create leave type Pick list for filter----------//Start
            for(Schema.picklistentry s : TypeList){
                if((s.getValue() == 'Consulting Leave' || s.getValue() == 'Researching Leave' ) && con.primary_contact_type__c =='Faculty'){
                    filterLeaveTypeOptions.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(con.Gender__c == 'Male' && s.getValue() == 'Paternity Leave'){
                    filterLeaveTypeOptions.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(con.Gender__c == 'Female' && s.getValue() == 'Maternity Leave'){
                    filterLeaveTypeOptions.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(s.getValue() != 'Faculty Consulting Researching Leave' && s.getValue() != 'Consulting Leave' && s.getValue() != 'Researching Leave' && s.getValue() != 'Maternity Leave' && s.getValue() != 'Paternity Leave'){
                    filterLeaveTypeOptions.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                else if(s.getValue() == 'Faculty Consulting Researching Leave' && con.primary_contact_type__c =='Faculty'){
                    filterLeaveTypeOptions.add(new selectoption(s.getvalue(),s.getlabel()));
                }
                //--------new leave type code should come here-----------------//Start
                //--------new leave type code should come here-----------------//End
            }
            //-----------Create leave type Pick list for filter----------//End
            
            if(leaveTrackList.size() > 0){}
            else{
                successBool = true;
                errorBool = true;
                //SuccessMsg = 'No Leaves Found!';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No leaves found!'));
            }
        }
        catch(exception e){
            system.debug('error::'+e.getMessage());
            successBool = true;
            errorBool = true;
            //SuccessMsg = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
        }
        
    }
    
    //Filter records by filters
    public PageReference getfilterList(){
        try{
            FromDate = ledger.From_Date__c;
            ToDate = ledger.To_Date__c;
            
            String wherePart;
            String query;
            if(filterStatus != 'None'){
                wherePart = ' AND Status__c = \'' + filterStatus + '\'';
            }
            if(filterLeaveType != 'None'){
                if(wherePart != ''  && wherePart != null){
                    wherePart =  wherePart + ' AND Leave_Type__c = \'' +filterLeaveType+ '\'';
                }
                else{
                    wherePart = ' AND Leave_Type__c = \'' + filterLeaveType+ '\'';
                }
            }
            system.debug('wherePart::'+wherePart);
            
            if(wherePart != '' && wherePart != null){
                query = 'SELECT Id, Name,Status__c, CreatedDate,Applied_To__c,Apply_To__c, LastModifiedById,Approved__c, Employee_Name__c, From_Date__c, To_Date__c,Leave_Action__c, Leave_Type__c, Total_Days__c, Half_day__c,Reason__c,Manager_Comments__c FROM Leave_Ledger__c where Employee_Name__c = \''+EmpId+'\' AND ( ( '+filterDate +' >= :FromDate  And '+filterDate+' <=: ToDate '+wherePart+' ) OR ( CreatedDate  >= : FromDate AND CreatedDate <= :ToDate '+wherePart+')) Order By CreatedDate Desc' ;
            }
            else{
                query = 'SELECT Id, Name,Status__c, CreatedDate,Applied_To__c,Apply_To__c, LastModifiedById, Approved__c, Employee_Name__c, From_Date__c, To_Date__c,Leave_Action__c, Leave_Type__c, Total_Days__c, Half_day__c,Manager_Comments__c,Reason__c FROM Leave_Ledger__c where Employee_Name__c = \''+EmpId+'\' AND ( ( '+filterDate +' >= :FromDate  And '+filterDate+' <=: ToDate ) OR ( CreatedDate  >= : FromDate AND CreatedDate <= :ToDate )) Order By CreatedDate Desc' ;
            }
            //String query = 'SELECT Id, Name,Status__c, CreatedDate,Applied_To__c,Apply_To__c, LastModifiedById, LastViewedDate,Approved__c, Employee_Name__c, From_Date__c, To_Date__c,Leave_Action__c, Leave_Type__c, Total_Days__c, Half_day__c FROM Leave_Ledger__c where Employee_Name__c=\'003N000001i7Ha8IAE\' AND '+filterDate +' >= :FromDate  And '+filterDate+' <=: ToDate And Status__c != null Order By CreatedDate Desc' ;
            system.debug(query);
            leaveTrackList.clear();
            leaveTrackList = Database.query(query);
            system.debug('leaveTrackList::'+leaveTrackList);
            
            if(leaveTrackList.size() > 0){
                return null;
            }
            else{
                successBool = true;
                errorBool = true;
                //SuccessMsg = 'No Leaves Found!';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No leaves found!'));
                return  null;
            }
        }
        catch(exception e){
            successBool = true;
            errorBool = true;
            //SuccessMsg = e.getMessage();
            system.debug('error::'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            return null;
        }
        
    }
    
    //Withdra leaves
    public PageReference submit(){
        try{
            FromDate = ledger.From_Date__c;
            ToDate = ledger.To_Date__c;
            
            successBool = true;
            errorBool = false;
            SuccessMsg = '';
            Integer idn = Integer.valueOf(apexpages.currentpage().getparameters().get('indexnumber'));
            system.debug('indNo '+indNo );
            if(idn != null){
                system.debug('indexnumber :: '+idn);
                indNo = idn;
            }
            Integer rowNum = Integer.valueOf(indNo);
            
            rowNum = rowNum - 1;
            system.debug('index '+rowNum);
            Leave_Ledger__c leaveLedgerRecord = leaveTrackList.get(rowNum);
            Leave_Setting__mdt leaveSettingObj = [SELECT Id, Label,Leave_Rollback_Maximum_Days__c,CompOff_Expiration_Days__c,Leave_Cancellation_Maximum_Days__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
            //leaveTrackList.clear();
            //leaveTrackList.add(leaveLedgerRecord);
            Date dt = leaveLedgerRecord.CreatedDate.date();
            Integer daysDiff = dt.daysBetween(System.today());
            
            system.debug('daysDiff::'+daysDiff);
            system.debug('leaveSettingObj.Leave_Rollback_Maximum_Days__c::'+leaveSettingObj.Leave_Rollback_Maximum_Days__c);
            system.debug('leaveSettingObj.Leave_Cancellation_Maximum_Days__c::'+leaveSettingObj.Leave_Cancellation_Maximum_Days__c);
            
            /*if(ledger.CompOff_Request_Reference__c != null){
                List<Leave_Ledger__c> LeaveLedgerForCompOff = [select id , name , createdDate, CompOff_Used__c, Status__c, CompOff_Expired__c , leave_type__c from leave_ledger__c where Id =: ledger.CompOff_Request_Reference__c limit 1];
                LeaveLedgerForCompOff[0].CompOff_Used__c = false;
                LeaveLedgerForCompOff[0].Status__c = 'Approved';
                
                Integer dateDiff = ledger.From_Date__c.daysBetween(system.today());
                if(dateDiff > leaveSettingObj.CompOff_Expiration_Days__c){
                    LeaveLedgerForCompOff[0].CompOff_Expired__c = true;
                    LeaveLedgerForCompOff[0].Status__c = 'Expired';
                }
                update LeaveLedgerForCompOff;
            }*/
            if(leaveLedgerRecord.Status__c == 'Pending'){
                if(leaveSettingObj.Leave_Rollback_Maximum_Days__c >= daysDiff){
                    system.debug('Yes you can withdraw');
                    leaveLedgerRecord.Status__c = 'Roll-Back';
                    //SuccessMsg = 'Withdraw Successfull!';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Withdrawn successfully!'));
                }
                else if(leaveLedgerRecord.From_Date__c.addDays(-Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)) >= System.today()){
                    system.debug('Yes you can withdraw');
                    leaveLedgerRecord.Status__c = 'Roll-Back';
                    //SuccessMsg = 'Withdraw Successfull!';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Withdrawn sccessfully!'));
                }
                else{
                    errorBool = true;
                    //SuccessMsg = 'Leave can be withdrawn upto '+Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)+' days from the request date of leave.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Leave can be withdrawn upto '+Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)+' days from the request date of leave.'));
                }
            }
            else{
                if(leaveSettingObj.Leave_Rollback_Maximum_Days__c >= daysDiff){
                    system.debug('Yes you can withdraw');
                    leaveLedgerRecord.Status__c = 'Cancelled';
                    //SuccessMsg = 'Withdraw Successfull!';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Withdrawn successfully!'));
                }
                else if(leaveLedgerRecord.From_Date__c.addDays(-Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)) >= System.today()){
                    system.debug('Yes you can cancel');
                    leaveLedgerRecord.Status__c = 'Cancelled';
                    //SuccessMsg = 'Withdraw Successfull!';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Withdrawn successfully!'));
                }
                else{
                    errorBool = true;
                    //SuccessMsg = 'Leave can be cancelled upto '+Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)+' days before the start of the leave.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Leave can be cancelled upto '+Integer.valueOf(leaveSettingObj.Leave_Cancellation_Maximum_Days__c)+' days before the start of the leave.'));
                    
                }
            }
            update leaveLedgerRecord;
            return null;
        }
        
        catch(exception e){
            successBool = true;
            errorBool = true;
            //SuccessMsg = 'Something went wrong! '+e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Something went wrong!'));
            return null;
        }
    }
    
    //Hide error message
    public PageReference toogle(){
        successBool = false;
        errorBool = false;
        return null;
    }
    
    //Refresh Page
    public PageReference Cancel() {        
        PageReference orderPage = new PageReference('/apex/Flame_TrackLeaves');
        orderPage.setRedirect(true);
        return orderPage; 
    }    
    
}