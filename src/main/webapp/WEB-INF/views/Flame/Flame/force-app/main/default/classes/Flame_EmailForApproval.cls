global class Flame_EmailForApproval {
    
    public static void sendUpdateEmailForLeave(List<Leave_Ledger__c> listOfLedgers){
        
        list<Leave_Ledger__c> listOfLeaveLedger = [Select Id, Name, Employee_Name__c, From_Date__c,Leave_Type__c, To_Date__c, Total_Days__c, Reason__c, Manager_Comments__c ,CompOff_Request_Reference__c,CompOff_Request_Reference__r.From_Date__c,CompOff_Request_Reference__r.CreatedDate, CreatedDate, Employee_Name__r.Name , Employee_Name__r.Email, Employee_Name__r.ReportsTo.Name, Employee_Name__r.ReportsTo.Email, Status__c From Leave_Ledger__c where id In : listOfLedgers];
        
        System.debug('=============listOfLeaveLedger=========='+listOfLeaveLedger.size());
        try{
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
            if(!listOfLeaveLedger.isEmpty()){
                for(Leave_Ledger__c leaveLedgerObj : listOfLeaveLedger){
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setSenderDisplayName('Company Support');
                    message.setReplyTo('no-reply@company.com');
                    system.debug('send email to '+leaveLedgerObj.Employee_Name__r.Email);
                    if(leaveLedgerObj.Status__c == 'Pending'){
                        if(leaveLedgerObj.Employee_Name__r.ReportsTo.Email != null || Test.isRunningTest()){
                            System.debug('===11122=3333=2=');
                            message.setSubject('Leave Application');
                            String body = 'Hi ' + leaveLedgerObj.Employee_Name__r.ReportsTo.Name + ', <br/><br/>';
                            body += +leaveLedgerObj.Employee_Name__r.Name+' has requested a leave. Please review it.<br/>';
                            body += 'Leave Type : '+leaveLedgerObj.Leave_Type__c+'<br/>';
                            if(leaveLedgerObj.Leave_Type__c == 'CompOff Leave'){
                                //body += (leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c != null)?leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c:leaveLedgerObj.CompOff_Request_Reference__r.CreatedDate;
                                body += 'CompOff Request Reference : '+leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c.format() +'<br/>';
                            }
                            body += 'From Date: '+leaveLedgerObj.From_Date__c.format()+'.<br/>';                           
                            body += 'To Date: '+leaveLedgerObj.To_Date__c.format()+'.<br/>';
                            body += 'Total Days of leaves: '+leaveLedgerObj.Total_Days__c+'.<br/>';
                            body += 'Reason : '+leaveLedgerObj.Reason__c+'.<br/>';
                            body += 'Submitted On: '+leaveLedgerObj.CreatedDate+'.<br/><br/>';
                            body += 'Thanks,<br/>';//+leaveLedgerObj.CreatedBy.Name;
                            message.setHtmlBody(body);
                            system.debug('Pending');
                            message.toAddresses = new String[] { leaveLedgerObj.Employee_Name__r.ReportsTo.Email};
                                messages.add(message);
                            
                            //--------------for leave submitter-----------------------------
                            Messaging.SingleEmailMessage message1 = new Messaging.SingleEmailMessage();
                            message1.setSenderDisplayName('Company Support');
                            message1.setReplyTo('no-reply@company.com');
                            message1.setSubject('Leave Application');
                            String body2 = 'Hi ' + leaveLedgerObj.Employee_Name__r.Name + ', <br/><br/>';
                            body2 += 'Your leave request is submitted.<br/>';
                            body2 += 'Leave Type : '+leaveLedgerObj.Leave_Type__c+'<br/>';
                            if(leaveLedgerObj.Leave_Type__c == 'CompOff Leave'){
                                //body += (leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c != null)?leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c:leaveLedgerObj.CompOff_Request_Reference__r.CreatedDate;
                                body2 += 'CompOff Request Reference : '+leaveLedgerObj.CompOff_Request_Reference__r.From_Date__c.format() +'<br/>';
                            }
                            body2 += 'From Date: '+leaveLedgerObj.From_Date__c.format()+'.<br/>';                           
                            body2 += 'To Date: '+leaveLedgerObj.To_Date__c.format()+'.<br/>';
                            body2 += 'Total Days of leaves: '+leaveLedgerObj.Total_Days__c+'.<br/>';
                            body2 += 'Reason : '+leaveLedgerObj.Reason__c+'.<br/>';
                            body2 += 'Submitted On: '+leaveLedgerObj.CreatedDate+'.<br/><br/>';
                            body2 += 'Thanks,<br/>';//+leaveLedgerObj.CreatedBy.Name;
                            message1.setHtmlBody(body);
                            message1.toAddresses = new String[] { leaveLedgerObj.Employee_Name__r.Email};
                                messages.add(message1);
                            //-------------------------------------------------------------------
                            
                        }
                    }
                    else if(leaveLedgerObj.Status__c == 'Approved' ){
                        if(leaveLedgerObj.Employee_Name__r.Email != null || Test.isRunningTest()){
                            message.setSubject('Leave Approved');
                            String body1 = 'Hi ' + leaveLedgerObj.Employee_Name__r.Name + ', <br/><br/>';
                            body1 += 'As per your request for leave, your leave has been approved.<br/><br/>';//+leaveLedgerObj.Manager_Comments__c+'.<br/><br/>';
                            body1 += 'From Date: '+leaveLedgerObj.From_Date__c.format()+'.<br/>';
                            body1 += 'To Date: '+leaveLedgerObj.To_Date__c.format()+'.<br/>';
                            body1 += 'Total Days of leaves: '+leaveLedgerObj.Total_Days__c+'.<br/>';
                            body1 += 'Reason: '+leaveLedgerObj.Reason__c+'.<br/>';
                            body1 += 'Manager\'s Comment: '+leaveLedgerObj.Manager_Comments__c+'.<br/><br/>';
                            body1 += 'Thanks<br/>'+leaveLedgerObj.Employee_Name__r.ReportsTo.Name;
                            message.setHtmlBody(body1);
                            system.debug('Approved');
                            message.toAddresses = new String[] {leaveLedgerObj.Employee_Name__r.Email};
                                messages.add(message);
                        }
                    }
                    else if(leaveLedgerObj.Status__c == 'Rejected' ){
                        if(leaveLedgerObj.Employee_Name__r.Email != null || Test.isRunningTest()){
                            message.setSubject('Leave Rejected');
                            system.debug('Rejected');
                            String body2 = 'Hi ' + leaveLedgerObj.Employee_Name__r.Name +', <br/><br/>';
                            body2 += 'Your leave has been rejected.<br/><br/>';
                            body2 += 'From Date: '+leaveLedgerObj.From_Date__c.format()+'.<br/>';
                            body2 += 'To Date: '+leaveLedgerObj.To_Date__c.format()+'.<br/>';
                            body2 += 'Total Days of leaves: '+leaveLedgerObj.Total_Days__c+'.<br/>';
                            body2 += 'Reason: '+leaveLedgerObj.Reason__c+'.<br/>';
                            body2 += 'Manager\'s Comment: '+leaveLedgerObj.Manager_Comments__c+'.<br/><br/>';
                            body2 += 'Thanks<br/>'+leaveLedgerObj.Employee_Name__r.ReportsTo.Name;
                            message.setHtmlBody(body2);
                            message.toAddresses = new String[] {leaveLedgerObj.Employee_Name__r.Email};
                                messages.add(message);
                        }
                    }
                }
            }
           /* if(!messages.isEmpty()){
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                System.debug('----========'+results.size());
            }*/
        }catch(Exception ex){
            System.debug('========'+ex.getMessage());
        }
    }
    
    public static void sendUpdateEmailForPunch(List<Employee_Calendar__c> listOfEmployeePunches){
        
        list<Employee_Calendar__c> listOfPunches = [Select Id, Status__c,OnDuty_Leave__c ,Contact_Name__r.Email, Contact_Name__r.ReportsTo.Email, Contact_Name__r.ReportsTo.Name, Contact_Name__r.Name, Date__c, Expected_Out_Time__c , Out_Time__c , In_Time__c ,Expected_In_Time__c ,Comments__c ,  Manager_Comments__c, LastModifiedDate From Employee_Calendar__c where id In : listOfEmployeePunches];
        set<id> listToDelete = new set<id>();
        System.debug('=============listOfLeaveLedger=========='+listOfPunches.size());
        try{
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
            if(!listOfPunches.isEmpty()){
                for(Employee_Calendar__c EmpPunchObj : listOfPunches){
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setSenderDisplayName('Company Support');
                    message.setReplyTo('no-reply@company.com');
                    if(EmpPunchObj.Status__c == 'Pending'){
                        if(EmpPunchObj.Contact_Name__r.ReportsTo.Email != null || Test.isRunningTest()){
                            System.debug('pending punch');
                            message.setSubject('Attendance Regularization Application');
                            String body = 'Hi ' + EmpPunchObj.Contact_Name__r.ReportsTo.Name + ', <br/><br/>';
                            body += +EmpPunchObj.Contact_Name__r.Name+'has requested for attendance regularization. Please review it.<br/>';
                           // body += 'Please let me know whether you require any further information.<br/><br/>';
                            body += 'Date: '+EmpPunchObj.Date__c.format()+'.<br/>';                           
                            body += 'System In Time: '+EmpPunchObj.Expected_In_Time__c+'.<br/>';
                            body += 'System Out Time: '+EmpPunchObj.Expected_Out_Time__c+'.<br/>';
                            body += 'Reason : '+EmpPunchObj.Comments__c+'.<br/>';
                            body += 'Submitted On: '+EmpPunchObj.LastModifiedDate+'.<br/><br/>';
                            body += 'Thanks,<br/>';//+EmpPunchObj.CreatedBy.Name;
                            message.setHtmlBody(body);
                            system.debug('Pending');
                            message.toAddresses = new String[] { EmpPunchObj.Contact_Name__r.ReportsTo.Email};
                                messages.add(message);
                        }
                        if(EmpPunchObj.Contact_Name__r.Email != null || Test.isRunningTest()){
                            System.debug('sender pending punch');
                            Messaging.SingleEmailMessage message2 = new Messaging.SingleEmailMessage();
                            message2.setSenderDisplayName('Company Support');
                            message2.setReplyTo('no-reply@company.com');
                            message2.setSubject('Attendance Regularization Application');
                            String body = 'Hi ' + EmpPunchObj.Contact_Name__r.Name + ', <br/><br/>';
                            body += 'Your regularization request is as -<br/>';
                           // body += 'Please let me know whether you require any further information.<br/><br/>';
                            body += 'Date: '+EmpPunchObj.Date__c.format()+'.<br/>';                           
                            body += 'System In Time: '+EmpPunchObj.Expected_In_Time__c+'.<br/>';
                            body += 'System Out Time: '+EmpPunchObj.Expected_Out_Time__c+'.<br/>';
                            body += 'Reason : '+EmpPunchObj.Comments__c+'.<br/>';
                            body += 'Submitted On: '+EmpPunchObj.LastModifiedDate+'.<br/><br/>';
                            body += 'Thanks,<br/>';//+EmpPunchObj.CreatedBy.Name;
                            message2.setHtmlBody(body);
                            system.debug('Pending');
                            message2.toAddresses = new String[] { EmpPunchObj.Contact_Name__r.Email};
                                messages.add(message2);
                        }
                    }
                    else if(EmpPunchObj.Status__c == 'Approved' ){
                        if(EmpPunchObj.Contact_Name__r.Email != null || Test.isRunningTest()){
                            message.setSubject('Attendance Regularization Approved');
                            String body1 = 'Hi ' + EmpPunchObj.Contact_Name__r.Name + ', <br/><br/>';
                            body1 += 'As per your request for leave, your leave has been approved.<br/><br/>';//+EmpPunchObj.Manager_Comments__c+'.<br/><br/>';
                            body1 += 'Date: '+EmpPunchObj.Date__c.format()+'.<br/>';                           
                            body1 += 'System In Time: '+EmpPunchObj.Expected_In_Time__c+'.<br/>';
                            body1 += 'System Out Time: '+EmpPunchObj.Expected_Out_Time__c+'.<br/>';
                            body1 += 'Reason : '+EmpPunchObj.Comments__c+'.<br/>';
                            body1 += 'Manager\'s Comment: '+EmpPunchObj.Manager_Comments__c+'.<br/><br/>';
                            body1 += 'Thanks<br/>'+EmpPunchObj.Contact_Name__r.ReportsTo.Name;
                            message.setHtmlBody(body1);
                            system.debug('Approved');
                            message.toAddresses = new String[] {EmpPunchObj.Contact_Name__r.Email};
                                messages.add(message);
                        }
                    }
                    else if(EmpPunchObj.Status__c == 'Rejected' ){
                        if(EmpPunchObj.Contact_Name__r.Email != null || Test.isRunningTest()){
                            message.setSubject('Attendance Regularization Rejected');
                            system.debug('Rejected');
                            String body2 = 'Hi ' + EmpPunchObj.Contact_Name__r.Name +', <br/><br/>';
                            body2 += 'Your leave has been rejected.<br/><br/>';
                            body2 += 'Date: '+EmpPunchObj.Date__c.format()+'.<br/>';                           
                            //body2 += 'System In Time: '+EmpPunchObj.In_Time__c+'.<br/>';
                            //body2 += 'System Out Time: '+EmpPunchObj.Out_Time__c+'.<br/>';
                            //body2 += 'Reason : '+EmpPunchObj.Comments__c+'.<br/>';
                            body2 += 'Manager\'s Comment: '+EmpPunchObj.Manager_Comments__c+'.<br/><br/>';
                            body2 += 'Thanks<br/>'+EmpPunchObj.Contact_Name__r.ReportsTo.Name;
                            message.setHtmlBody(body2);
                            message.toAddresses = new String[] {EmpPunchObj.Contact_Name__r.Email};
                                messages.add(message);
                            if(EmpPunchObj.OnDuty_Leave__c == 'Official Regularized Visit' && EmpPunchObj.Status__c == 'Rejected'){
                                system.debug(' delete this record ');
                                listToDelete.add(EmpPunchObj.id);
                            }
                        }
                    }
                }
            }
            /*if(!messages.isEmpty()){
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                System.debug('----========'+results.size());
            }*/
            if(listToDelete.size() > 0){
                system.debug(' found dfor delete ');
                Flame_EmailForApproval.deleteRejectedPunches(listToDelete);
            }
        }catch(Exception ex){
            System.debug('========'+ex.getMessage());
        }
    }
    
    @future
    public static void deleteRejectedPunches(set<id> setId)
    {
        system.debug(' delete ');
        try{
            list<Employee_Calendar__c> getListToDelete = [Select id from Employee_Calendar__c where id in : setId];
            delete getListToDelete;
        }
        catch(exception ex){
            system.debug(' error ' + ex.getMessage());
        }
        
    }
    
    @future
    public static void updateCompOffRequestStatusToAvailed(set<id> setId)
    {
        system.debug(' update to avail ');
        try{
            
            List<Leave_Ledger__c> updateCompoffRequest = [Select id, status__c, CompOff_Used__c, CompOff_Expired__c From Leave_Ledger__c Where Id In : setId];
            if(updateCompoffRequest.size() > 0){
                for(Leave_Ledger__c ll : updateCompoffRequest){
                    ll.status__c = 'Availed';
                    ll.CompOff_Used__c = true;
                }
                update updateCompoffRequest;
            }
        }
        catch(exception ex){
            system.debug(' error ' + ex.getMessage());
        }
        
    }

    @future
    public static void updateCompOffRequestStatusToExpire(set<id> setId)
    {
        system.debug(' delete ');
        try{
            
            List<Leave_Ledger__c> updateCompoffRequest = [Select id,From_Date__c,To_Date__c,CreatedDate, status__c, CompOff_Used__c, CompOff_Expired__c From Leave_Ledger__c Where Id In : setId];
            
            
            if(updateCompoffRequest.size() > 0){
                Integer dateDiffFromDate;
                Leave_Setting__mdt lvSetObj = [SELECT Id, Label, CompOff_Expiration_Days__c FROM Leave_Setting__mdt WHERE Label = 'All Leave Configurations for Employee'];
                    
                for(Leave_Ledger__c ll : updateCompoffRequest){
                    
                    //if(ll.To_Date__c != null){
                        //ll.Status__c = 'Approved';
                    //}
                    //else{
                        ll.status__c = '';
                    //}
                    ll.CompOff_Used__c = false;
                    
                    dateDiffFromDate = ll.From_Date__c.daysBetween(system.today());
                    
                    
                    if(dateDiffFromDate > lvSetObj.CompOff_Expiration_Days__c){
                        ll.CompOff_Expired__c = true;
                        ll.Status__c = 'Expired';
                    }

                    
                }
                update updateCompoffRequest;
            }
        }
        catch(exception ex){
            system.debug(' error ' + ex.getMessage());
        }
        
    }

}