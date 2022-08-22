public class Flame_ApprovalPageClass {
    
    public Contact con {get;set;}
    public User currentUser {get;set;}
    public list<Leave_Ledger__c> leaveTrackList{get;set;}
    public list<Employee_Calendar__c> reguTrackList{get;set;}
    public List<ProcessInstanceWorkitem> allitems {get;set;}
    public String userId, EmpId ;
    public string indNo {get;set;}
    //public string SuccessMsg {get;set;}
    public string ManagerComments {get;set;}
    public Leave_Setting__mdt leaveSettingObj {get;set;}
    public Boolean approvalLinkBool {get;set;}
    public Leave_Ledger__c actionledger {get;set;}
    public Employee_Calendar__c actionEmppunch {get;set;}
    public boolean displayPopup {get; set;}   
    public boolean displayMassPopup {get; set;}   
    public boolean successBool {get; set;}      
    public boolean errorBool {get; set;}
    public boolean successBoolMass {get; set;}      
    public boolean errorBoolMass {get; set;}
    public string SuccessMsgMass {get;set;}
    public boolean showLeave {get; set;}
    public string changeView {get;set;}
    public List<id> resultsEmpPunch = new List<id>();
    public List<id> resultsLeaLedg = new List<id>();
    
    //Controller Method
    public Flame_ApprovalPageClass(){
        try{
            successBool = false;
            errorBool = false;
            indNo = '';
            changeView = '';
            actionledger = new Leave_Ledger__c();
            actionEmppunch = new Employee_Calendar__c();
            con = new Contact();
            displayMassPopup = false;
            leaveSettingObj = new Leave_Setting__mdt();
            allitems = new List<ProcessInstanceWorkitem>();
            leaveTrackList = new list<Leave_Ledger__c>();
            reguTrackList = new list<Employee_Calendar__c>();
            userId = userinfo.getuserId();
            //*ADD NEW CUSTOM METADA SETTING TO THIS SOQL*
            leaveSettingObj = [SELECT Id,Year_Start_In_Month__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
            
           
            
            currentUser = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,ContactId from User where Id =: userId];
            system.debug('currentUser Approver====='+currentUser);
            system.debug('Approver\'s contact id='+currentUser.ContactId);
            con = [SELECT Id,Gender__c, Name,Email,Employee_Id__c, ReportsTo.Name FROM Contact where id =: currentUser.contactId];
            system.debug('con  '+con);
            EmpId = con.id ;
            
            
            if([SELECT COUNT() FROM Contact WHERE ReportsToId =: currentUser.ContactId] > 0){
                approvalLinkBool = true;
            }
            else{
                approvalLinkBool = false;
            }
            
            refreshlist();
        }
        catch(exception e){
            system.debug('error ::'+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
        }
    }
    
    //Leave/Punch picklist change for Approval 
    public void changeview(){
        toogle();
        system.debug('view changed');
        if(changeView == 'Leave'){
            showLeave = true;
           // system.debug('showLeave'+showLeave);
        }
        else{
            showLeave = false;
        }
        refreshlist();
    }
    
    //refresh the record list
    public void refreshlist(){
        resultsEmpPunch = new List<id>();
        resultsLeaLedg = new List<id>();
        system.debug('getting records');
       
        allitems = [SELECT ElapsedTimeInDays, originalActor.name, processInstance.targetObjectId,
                    ProcessInstance.TargetObject.name, processInstance.status, processinstance.ProcessDefinition.name,
                    ProcessInstance.CreatedDate, ActorId FROM ProcessInstanceWorkitem WHERE ActorId=: userId And processInstance.status =: 'Pending'];
        
        
        for(ProcessInstanceWorkitem thisitem : allitems)
        {
            id ss = thisitem.processInstance.targetObjectId;
            
            if(changeView == 'Leave'){
                system.debug('leave selected');
                if(ss.getSobjectType() == Schema.Leave_Ledger__c.SObjectType){
                    resultsLeaLedg.add(thisitem.processInstance.targetObjectId);
                    //system.debug('inside if');
                }
            }
            else if(changeView == 'Punch'){
                system.debug('punch selected');
                if(ss.getSobjectType() == Schema.Employee_Calendar__c.SObjectType){
                    resultsEmpPunch.add(thisitem.processInstance.targetObjectId);
                }
            }
            else{
                system.debug('nothing selected');
                if(ss.getSobjectType() == Schema.Employee_Calendar__c.SObjectType){
                    resultsEmpPunch.add(thisitem.processInstance.targetObjectId);
                }
                else if(ss.getSobjectType() == Schema.Leave_Ledger__c.SObjectType){
                   // system.debug('inside else if');
                    resultsLeaLedg.add(thisitem.processInstance.targetObjectId);
                    system.debug('Process instance '+thisitem.processInstance);
                    system.debug('leave ledger id '+thisitem.processInstance.targetObjectId);
                }
            }
        }
        if(resultsEmpPunch.size() > 0){
            String query = 'SELECT Id, In_Time__c, Out_Time__c,Lastmodifieddate, Date__c, Day__c,Year__c, Employee_Code__c,Contact_Name__c,Contact_Name__r.Name, IsPresent__c,Status__c,OnDuty_Leave__c,Expected_In_Time__c,Expected_Out_Time__c,Comments__c, RecordTypeId, Applied_For_Regularization__c FROM Employee_Calendar__c Where Id In : resultsEmpPunch AND Applied_For_Regularization__c = true  Order By CreatedDate Desc';
            reguTrackList = Database.query(query);
        }
        if(resultsLeaLedg.size() > 0){
            system.debug('resultsLeaLedg:: '+resultsLeaLedg);
            String query = 'SELECT Id, Name,Status__c, CreatedDate,Applied_To__c,Emp_Name__c, Apply_To__c, LastModifiedById, Approved__c, Employee_Name__c,Employee_Id__c, From_Date__c, To_Date__c, Total_Days__c,Leave_Action__c, Leave_Type__c,Reason__c,  Half_day__c, Employee_Name__r.Earned_Leave_Balance__c, Employee_Name__r.Casual_Leave_Balance__c, Employee_Name__r.Maternity_Paternity_Leave_Balance__c, Employee_Name__r.CompOff_Balance__c, Employee_Name__r.Faculty_Researching_and_Consulting__c FROM Leave_Ledger__c where Id IN: resultsLeaLedg   Order By CreatedDate Desc ' ;
            leaveTracklist = Database.query(query);
           // system.debug('query'+query);
            system.debug('leaveTrackList::'+leaveTrackList);
        }
        
        if(changeView == ''){
            system.debug('nothing selected');
            if(leaveTrackList.size() == 0){
                system.debug('no leaves');
                if(reguTrackList.size() == 0){
                    system.debug('no regularize');
                    showLeave = true;
                    successBool = true;
                    errorBool = true;
                    //SuccessMsg = 'No Leave Approval Request Found.';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No leave approval request found!'));
                }
                else{
                    system.debug('regularize found');
                    showLeave = false;
                    changeView = 'Punch';
                }
            }
            else{
                system.debug('leaves found');
                
                showLeave = true;
               
                changeView = 'Leave';
            }
        }
        else if(changeView == 'Leave'){
            system.debug('leave selected');
            showLeave = true;
            if(leaveTrackList.size() == 0){
                system.debug('no leave');
                successBool = true;
                errorBool = true;
                //SuccessMsg = 'No Leave Approval Request Found.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No leave approval request found!'));
            }
        }
        else{
            system.debug('regularize selected');
            showLeave = false;
            if(reguTrackList.size() == 0){
                system.debug('no regularize');
                successBool = true;
                errorBool = true;
                //SuccessMsg = 'No Regularization Approval Request Found.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No regularization approval request found!'));
            }
        }
    }
    
    //Show popup for Mass Action
    public PageReference MassAction(){
        if(changeView == 'Leave'){
            if(leaveTrackList.size() > 0){
                displayMassPopup = true;
            }
        }
        else{
            if(reguTrackList.size() > 0){
                displayMassPopup = true;
            }
        }
        return null;
    }
    
    //Show popup for single Action
    public void showPopup(){
        
        displayPopup = true;
        successBool = false;
        Integer rowIndex = Integer.valueOf(indNo);
        rowIndex = rowIndex - 1;
        if(changeView == 'Leave'){
            if(leaveTrackList.size() > 0){
                actionledger = leaveTrackList.get(rowIndex);
            }
        }
        if(changeView == 'Punch'){
            if(reguTrackList.size() > 0){
                actionEmppunch = reguTrackList.get(rowIndex);
                system.debug('actionEmppunch'+actionEmppunch);
            }
        }
        //actionledger = [SELECT Id, Name,Status__c, CreatedDate,Applied_To__c,Emp_Name__c, Apply_To__c, LastModifiedById, Approved__c, Employee_Name__c,Employee_Id__c, From_Date__c, To_Date__c, Total_Days__c,Leave_Action__c, Leave_Type__c,Reason__c,  Half_day__c, Employee_Name__r.Earned_Leave_Balance__c, Employee_Name__r.Casual_Leave_Balance__c, Employee_Name__r.Maternity_Paternity_Leave_Balance__c, Employee_Name__r.CompOff_Balance__c, Employee_Name__r.Faculty_Researching_and_Consulting__c FROM Leave_Ledger__c where Id =: leaveTrackList.get(rowIndex).id];
        
    }
    
    //Validate leave with current leave balance
    public boolean validate(Leave_Ledger__c actionledgerVar){ 
        Boolean valid = false;        
        system.debug('leave = '+actionledgerVar.Leave_Type__c);
        system.debug('Total_Days__c = '+actionledgerVar.Total_Days__c);
        system.debug('Earn = '+actionledgerVar.Employee_Name__r.Earned_Leave_Balance__c);
        system.debug('casual = '+actionledgerVar.Employee_Name__r.Casual_Leave_Balance__c);
        system.debug('patmat = '+actionledgerVar.Employee_Name__r.Maternity_Paternity_Leave_Balance__c);
        system.debug('fac = '+actionledgerVar.Employee_Name__r.Faculty_Researching_and_Consulting__c);
        system.debug('compoff = '+actionledgerVar.Employee_Name__r.CompOff_Balance__c);
        if(actionledgerVar.Leave_Type__c == 'Earned Leave' && actionledgerVar.Employee_Name__r.Earned_Leave_Balance__c >= actionledgerVar.Total_Days__c){
            valid = true;
        }
        else if(actionledgerVar.Leave_Type__c == 'Casual Leave' && actionledgerVar.Employee_Name__r.Casual_Leave_Balance__c >= actionledgerVar.Total_Days__c){
            valid = true;
        }
        
        else if((actionledgerVar.Leave_Type__c == 'Paternity Leave' || actionledgerVar.Leave_Type__c == 'Maternity Leave') && actionledgerVar.Employee_Name__r.Maternity_Paternity_Leave_Balance__c >= actionledgerVar.Total_Days__c){
            valid = true;
        }
        
        else if((actionledgerVar.Leave_Type__c == 'Consulting Leave' || actionledgerVar.Leave_Type__c == 'Researching Leave') && actionledgerVar.Employee_Name__r.Faculty_Researching_and_Consulting__c >= actionledgerVar.Total_Days__c){
            valid = true;
        }
        else if(actionledgerVar.Leave_Type__c == 'CompOff Leave' && actionledgerVar.Employee_Name__r.CompOff_Balance__c >= actionledgerVar.Total_Days__c){
            valid = true;
        }
        else if(actionledgerVar.Leave_Type__c == 'CompOff Request'){
            valid = true;
        }
        //--------new leave type code should come here-----------------//Start
        // 			*ADD ELSE IF FOR NEW LEAVE TYPE AND CHECK WITH RESPECTIVE LEAVE BALANCE*
        //--------new leave type code should come here-----------------//End
        
        return valid;
    }
    
    //Validate the active calendar year
    public boolean validateActiveCalendar(Leave_Ledger__c actionledgerVar){
        Boolean flag = false;
        
        Date fromDate = actionledgerVar.From_Date__c;//Date.newInstance(2020,3, 28);
        Date toDate = actionledgerVar.To_Date__c;//Date.newInstance(2020, 3, 31);
        integer currentMonth = System.today().month();//4
        integer Month = Integer.valueOf(leaveSettingObj.Year_Start_In_Month__c); //4
        Date Start_Year;
        Date End_Year;
        
        if(currentMonth >= Month){
            Start_Year = Date.newInstance(system.today().year(), 4, 1);
            End_Year = Date.newInstance(system.today().year() + 1, 3, date.daysInMonth(system.today().year() + 1, 3));
        }
        else{
            Start_Year = Date.newInstance(system.today().year() - 1, 4, 1);
            End_Year = Date.newInstance(system.today().year(), 3, date.daysInMonth(system.today().year(), 3));
        }        
        if(fromDate >= Start_Year && toDate <= End_Year){
            flag = true;
        }
        
        system.debug(flag);
        return flag;
    }
    
    //Mass approve
    public PageReference MassApprove(){ 

        try{
            Boolean approveleave = false;
            displayMassPopup = false;
            displayPopup = false;
            successBool = true;
            errorBool = false;                
            //SuccessMsgMass = 'Approved successfully!';
            Integer SuccessProcesses = 0;
            Integer FailedProcesses = 0;
            
            if(changeView == 'Leave'){
                approveleave = true;
                system.debug('approveleave'+approveleave);
            }
            List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
            List<ProcessInstance> pinstances = new List<ProcessInstance>();
            
            if(approveleave == false){
               system.debug('inside second if'+approveleave);
                pinstances = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId In: reguTrackList and Status='Pending'];
            }
            else if(approveleave){
                
                
                pinstances = [Select ID, Status,TargetObjectId, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId In: leaveTrackList and Status='Pending'];
            }
            
            for(ProcessInstance pi : pinstances){
                Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                system.debug('pi::'+pi);
                system.debug('pi::'+pi.workitems);
                req.setWorkitemId(pi.workitems[0].id);
                //Valid values are: Approve, Reject.
                req.setAction('Approve');
                req.setComments(ManagerComments);

                if(changeView == 'Leave'){
                    for(Leave_Ledger__c lledger : leaveTrackList){
                        if(lledger.id == pi.TargetObjectId){
                            if(!validateActiveCalendar(lledger)){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Leave is not within the active calendar year'));
                                return null;
                            }
                            if(validate(lledger)){
                                requests.add(req);
                                SuccessProcesses += 1;
                            }
                            else{
                                FailedProcesses += 1;
                                continue;
                            }
                        }
                    }
                }
                else{
                    requests.add(req);
                    SuccessProcesses = requests.size();
                }

            }
            
            
            List<Approval.ProcessResult> processResults = Approval.process(requests);

            for(Approval.ProcessResult ap : processResults){
                system.debug('approval result :: '+ ap);
                system.debug('approval is success :: '+ ap.isSuccess() );
                system.debug('approval error :: '+ ap.getErrors() );
                /*
                if(ap.isSuccess()){
                    SuccessProcesses += 1;
                }
                else{
                    FailedProcesses += 1;
                }*/
            }
            //SuccessMsgMass = 'Successfully Approved = '+SuccessProcesses+'\n Failed = '+FailedProcesses;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Successfully Approved = '+SuccessProcesses+'\n and Failed = '+FailedProcesses));
            return null;
        }
        catch(Exception e){
            system.debug('exception::: '+e.getMessage());
            errorBoolMass = true;
            //SuccessMsgMass = 'Something went wrong. '+e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            return null;
        }
    }
    
    //Mass Reject
    public PageReference MassReject(){ 

        try{
            Boolean approveleave = false;
            displayMassPopup = false;
            displayPopup = false;
            successBool = true;
            errorBool = false;                
            //SuccessMsgMass = 'Rejected successfully!';
            Integer SuccessProcesses = 0;
            Integer FailedProcesses = 0;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Rejected successfully!'));
            
            if(changeView == 'Leave'){
                approveleave = true;
                system.debug('approveleave'+approveleave);
            }
            List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
            List<ProcessInstance> pinstances = new List<ProcessInstance>();
            
            if(approveleave == false){
               system.debug('inside second if'+approveleave);
                pinstances = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId In: reguTrackList and Status='Pending'];
            }
            else if(approveleave){
                pinstances = [Select ID, Status,TargetObjectId, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId In: leaveTrackList and Status='Pending'];
            }
            
            for(ProcessInstance pi : pinstances){
                Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                system.debug('pi::'+pi);
                system.debug('pi::'+pi.workitems);
                req.setWorkitemId(pi.workitems[0].id);
                //Valid values are: Approve, Reject.
                req.setAction('Reject');
                req.setComments(ManagerComments);

                requests.add(req);

            }
            
            
            List<Approval.ProcessResult> processResults = Approval.process(requests);

            for(Approval.ProcessResult ap : processResults){
                system.debug('approval result :: '+ ap);
                system.debug('approval is success :: '+ ap.isSuccess() );
                system.debug('approval error :: '+ ap.getErrors() );
                if(ap.isSuccess()){
                    SuccessProcesses += 1;
                }
                else{
                    FailedProcesses += 1;
                }
                
            }
            //SuccessMsgMass = 'Successfully Rejected = '+SuccessProcesses+'\n Failed = '+FailedProcesses;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Successfully Rejected = '+SuccessProcesses+'\n and Failed = '+FailedProcesses));
            return null;
        }
        catch(Exception e){
            system.debug('exception::: '+e.getMessage());
            //SuccessMsgMass = 'Something went wrong. '+e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            return null;
        }
    }
    
    //Single Approve
    public PageReference ApproveRecord(){ 
        System.debug('-------222-------');
        try{
            Boolean approveleave = false;
            
            displayPopup = false;
            successBool = true;
            errorBool = false;                
            //SuccessMsg = 'Approved successfully!';
            
            
            
            if(changeView == 'Leave'){
                approveleave = true;
                system.debug('approveleave'+approveleave);
            }
            
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            ProcessInstance pi = new ProcessInstance();
            
            if(approveleave == false){
               system.debug('inside second if'+approveleave);
                pi = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId =: actionEmppunch.Id and Status='Pending' Limit 1];
                /*system.debug('pi::'+pi);
                system.debug('pi::'+pi.workitems);
                req.setWorkitemId(pi.workitems[0].id);
                //Valid values are: Approve, Reject.
                req.setAction('Approve');
                req.setComments(ManagerComments);
                
                Approval.ProcessResult processResults = Approval.process(req);
                
                PageReference orderPage = new PageReference('/apex/Flame_ApprovalPage');
                orderPage.setRedirect(true);
                return null;*/
            }
            else if(validate(actionledger) && approveleave){
                if(!validateActiveCalendar(actionledger)){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Leave is not within the active calendar year'));
                    return null;
                }
                
                pi = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId =: actionledger.Id and Status='Pending' Limit 1];
                /*system.debug('pi::'+pi);
                system.debug('pi::'+pi.workitems);
                req.setWorkitemId(pi.workitems[0].id);
                //Valid values are: Approve, Reject.
                req.setAction('Approve');
                req.setComments(ManagerComments);
                
                Approval.ProcessResult processResults = Approval.process(req);
                
                PageReference orderPage = new PageReference('/apex/Flame_ApprovalPage');
                orderPage.setRedirect(true);
                return null;*/
            }
            
            else{
                //SuccessMsg = '';
                errorBool = true;
                //SuccessMsg = actionledger.Emp_Name__c+'('+actionledger.Employee_Id__c+') have Insufficient Leave Balance for this leave.';
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, actionledger.Emp_Name__c+'('+actionledger.Employee_Id__c+') have insufficient leave balance for this leave.'));
                return null;
            }
            
            system.debug('pi::'+pi);
            system.debug('pi::'+pi.workitems);
            req.setWorkitemId(pi.workitems[0].id);
            //Valid values are: Approve, Reject.
            req.setAction('Approve');
            req.setComments(ManagerComments);
            
            Approval.ProcessResult processResults = Approval.process(req);
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Approved successfully!'));
            //PageReference orderPage = new PageReference('/apex/Flame_ApprovalPage');
            //orderPage.setRedirect(true);
            return null;
        }
        catch(Exception e){
            system.debug('exception::: '+e.getMessage());
            //SuccessMsg = 'Something went wrong! '+e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            return null;
        }
    }
    
    //Single Reject
    public PageReference RejectRecord(){ 
        
        Boolean approveleave = false;
        displayPopup = false;
        successBool = true;
        errorBool = true;                
        //SuccessMsg = 'Rejected successfully!';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Rejected successfully!'));
        
        
        if(changeView == 'Leave'){
            approveleave = true;
        }
        
        try{
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            ProcessInstance pi = new ProcessInstance();
            if(!approveleave){
                pi = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId =: actionEmppunch.Id  and Status='Pending' Limit 1];
                
            }
            
            else if(approveleave){
                pi = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId =: actionledger.Id  and Status='Pending' Limit 1];
                
            }
            
            system.debug('pi::'+pi);
            system.debug('pi::'+pi.workitems);
            req.setWorkitemId(pi.workitems[0].id);
            //Valid values are: Approve, Reject.
            req.setAction('Reject');
            req.setComments(ManagerComments);
            
            Approval.ProcessResult processResults = Approval.process(req);
            
            if(processResults.isSuccess() ){
                errorBool = false;                
                //SuccessMsg = 'Rejected successfully!';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Rejected successfully!'));
            }
            else{
                //errorBool = true;                
                //SuccessMsg = 'Something went wrong!' ;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            }
            //PageReference orderPage = new PageReference('/apex/Flame_ApprovalPage');
            //orderPage.setRedirect(true);
            //return orderPage;
            return null;
        }
        catch(Exception e){
            system.debug('exception::: '+e.getMessage());
            
            errorBool = true;                
            //SuccessMsg = '';         
            //SuccessMsg = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong!'));
            
            return null;
        }
    }
    
    //Close normal popup
    public PageReference toogle(){
        
        successBool = false;
        errorBool = false;
        //SuccessMsg = '';
        return null;
    }
    
    //Refresh the page
    public PageReference Cancel(){        
        PageReference orderPage = new PageReference('/apex/Flame_ApprovalPage');
        orderPage.setRedirect(true);
        return orderPage; 
    }
    
    //Close Mass popup
    public PageReference toogleMass(){
        
        successBool = false;
        errorBool = false;
        //SuccessMsgMass = '';
        return null;
    }
    
}