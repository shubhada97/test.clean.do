public class LeaveLedgerUpdates 
{
    
    public static void UpdateRelatedContact(List<Leave_Ledger__c> LedgerList){
        
        Set<Id> idSet = new Set<Id>();
        for(Leave_Ledger__c Ledgers :LedgerList){
            if(Ledgers.Employee_Name__c != null){
                idSet.add(Ledgers.Employee_Name__c);
            }
        }
        
        //		*ADD NEW FIELDS IN THE SOQL*
        Map<Id,Contact> mapCon = new Map<Id,Contact>([SELECT Id, Earned_Leave_Balance__c,Employee_Id__c, Casual_Leave_Balance__c,Maternity_Paternity_Leave_Balance__c,Faculty_Researching_and_Consulting__c,CompOff_Balance__c FROM Contact WHERE id IN :idSet]);
        //		*ADD NEW FIELDS IN THE SOQL*
        Leave_Setting__mdt leaveSettingObj = [SELECT Id, Sandwich_Earned__c, Sandwich_Casual__c, Sandwich_CompOff__c, Sandwich_Maternity_Paternity__c,CompOff_Past_maximum_Days__c, Sandwich_Faculty_Researching_and_Consult__c, Future_Leave_Maximum_Days__c,Past_Leave_Maximum_Days__c,CompOff_Expiration_Days__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
        List<Employee_Calendar__c> eclist = new List<Employee_Calendar__c>();
        List<RecordType> recTypeId = [Select Id From RecordType  Where SobjectType = 'Employee_Calendar__c' and DeveloperName = 'Employee_Punch' limit 1];
        List<Employee_Calendar__c> lstecUpdate = new List<Employee_Calendar__c>();
        Set<id> updateCRLedgerListToAvailed = new Set<id>();
        Set<id> updateCRLedgerListToExpired = new Set<id>();
        List<Date> updatedateList = new List<date>();
        List<String> updateEmpIdList = new List<String>();
        boolean sandbool = false;
        List<Contact> conUpdateList = new List<Contact>();
        List<Approval.ProcessWorkitemRequest> reqlist = new List<Approval.ProcessWorkitemRequest>();
        Set<Id> targetIds = new Set<Id>();
        map<Id,Contact> mapEmployeeIdContact = new map<Id,Contact>();
        for(Leave_Ledger__c Ledger :LedgerList) {
            system.debug(Ledger);
            system.debug(Ledger.id);
            Contact ct = new Contact();
            
            if(mapEmployeeIdContact.get(Ledger.Employee_Name__c) != null){
                ct = mapEmployeeIdContact.get(Ledger.Employee_Name__c);
            }
            else{
                ct = mapCon.get(Ledger.Employee_Name__c);
            }
            //ct = mapCon.get(Ledger.Employee_Name__c);
            
            Date fromDate = Ledger.From_Date__c;
            Date toDate = Ledger.To_Date__c;
            
            //Decimal TotalDays = ledger.From_Date__c.daysBetween(ledger.To_Date__c);
            Decimal eldays = ct.Earned_Leave_Balance__c;
            
            Decimal cldays = ct.Casual_Leave_Balance__c;
            Decimal pldays = ct.Maternity_Paternity_Leave_Balance__c;
            Decimal fldays = ct.Faculty_Researching_and_Consulting__c;
            Decimal compOffDays = ct.CompOff_Balance__c;
            //--------new leave type code should come here-----------------//Start
            // 			*ADD NEW VARIABLES*
            //--------new leave type code should come here-----------------//End
            
            
            if(Ledger.Status__c == 'Approved'){
                
                //check if null then initialize with 0
                if(ct.Earned_Leave_Balance__c == null){ct.Earned_Leave_Balance__c = 0;}
                if(ct.Casual_Leave_Balance__c == null){ct.Casual_Leave_Balance__c = 0;}
                if(ct.CompOff_Balance__c == null){ct.CompOff_Balance__c = 0;}
                if(ct.Maternity_Paternity_Leave_Balance__c == null){ct.Maternity_Paternity_Leave_Balance__c = 0;}
                if(ct.Faculty_Researching_and_Consulting__c == null){ct.Faculty_Researching_and_Consulting__c = 0;}
                
                if(Ledger.Leave_Type__c == 'Earned Leave'){
                    ct.Earned_Leave_Balance__c = ct.Earned_Leave_Balance__c -ledger.Total_Days__c;
                    sandbool = leaveSettingObj.Sandwich_Earned__c;
                }
                else if(Ledger.Leave_Type__c == 'Casual Leave'){
                    ct.Casual_Leave_Balance__c = ct.Casual_Leave_Balance__c -ledger.Total_Days__c;
                    sandbool = leaveSettingObj.Sandwich_Casual__c;
                }
                
                else if(Ledger.Leave_Type__c == 'Paternity Leave' || Ledger.Leave_Type__c == 'Maternity Leave'){
                    ct.Maternity_Paternity_Leave_Balance__c = ct.Maternity_Paternity_Leave_Balance__c -ledger.Total_Days__c;
                    sandbool = leaveSettingObj.Sandwich_Maternity_Paternity__c;
                }
                
                else if(Ledger.Leave_Type__c == 'Consulting Leave' || Ledger.Leave_Type__c == 'Researching Leave'){
                    ct.Faculty_Researching_and_Consulting__c = ct.Faculty_Researching_and_Consulting__c - ledger.Total_Days__c;
                    sandbool = leaveSettingObj.Sandwich_Faculty_Researching_and_Consult__c;
                }
                else if(Ledger.Leave_Type__c == 'CompOff Leave'){
                    ct.CompOff_Balance__c = ct.CompOff_Balance__c - ledger.Total_Days__c;
                    sandbool = leaveSettingObj.Sandwich_CompOff__c;
                    updateCRLedgerListToAvailed.add(Ledger.CompOff_Request_Reference__c);
                }
                else if(Ledger.Leave_Type__c == 'CompOff Request' && Ledger.Leave_Action__c =='Credit'){
                    ct.CompOff_Balance__c = ct.CompOff_Balance__c + ledger.Total_Days__c;
                }
                //--------new leave type code should come here-----------------//Start
                // 			*CHECK LEAVE*
                //--------new leave type code should come here-----------------//End
                
                
                List<Date> dateList = new List<date>();
                List<Date> holidayList = new List<date>();
                
                for(Date loopstartDate = fromDate; loopstartDate <= toDate; loopstartDate = loopstartDate.addDays(1)){
                    dateList.add(loopstartDate);
                }
                
                List<Employee_Calendar__c> HolidaysList = [SELECT Id, Day__c, Date__c, In_Time__c, Out_Time__c,OnDuty_Leave__c, Employee_Code__c, Year__c, Status__c FROM Employee_Calendar__c where RecordType.Name =: 'Holiday Punch' AND Date__c In : dateList];
                for(Employee_Calendar__c ec : HolidaysList){
                    holidayList.add(ec.Date__c);
                }
                for(Date loopstartDate : dateList){//= fromDate; loopstartDate <= toDate; loopstartDate = loopstartDate.addDays(1)){
                    //dateList.add(loopstartDate);
                    if(sandbool){
                        Employee_Calendar__c ec = new Employee_Calendar__c();
                        ec.Employee_Code__c = string.valueof(ct.Employee_Id__c);
                        ec.Contact_Name__c = ec.id;
                        ec.Date__c = loopstartDate;
                        ec.RecordTypeId = recTypeId[0].id;
                        if(Ledger.Half_day__c){
                            ec.OnDuty_Leave__c = 'Half Day Leave';
                        }
                        else{
                            ec.OnDuty_Leave__c = 'Full Day Leave';
                        }
                        ec.In_Time__c = Time.newInstance(0, 0, 0, 00);
                        ec.Out_Time__c = Time.newInstance(0, 0, 0, 00);
                        eclist.add(ec);
                    }
                    else{
                        if(!holidayList.contains(loopstartDate)){
                            Employee_Calendar__c ec = new Employee_Calendar__c();
                            ec.Employee_Code__c = string.valueof(ct.Employee_Id__c);
                            ec.Contact_Name__c = ec.id;
                            ec.Date__c = loopstartDate;
                            ec.RecordTypeId = recTypeId[0].id;
                            if(Ledger.Half_day__c){
                                ec.OnDuty_Leave__c = 'Half Day Leave';
                            }
                            else{
                                ec.OnDuty_Leave__c = 'Full Day Leave';
                            }
                            ec.In_Time__c = Time.newInstance(0, 0, 0, 00);
                            ec.Out_Time__c = Time.newInstance(0, 0, 0, 00);
                            eclist.add(ec);
                        }
                    }
                    
                }
                /*
                List<Employee_Calendar__c> empCalendarList = [SELECT Id, Day__c, Date__c, In_Time__c, Out_Time__c,OnDuty_Leave__c, Employee_Code__c, Year__c, Status__c FROM Employee_Calendar__c where Employee_Code__c =: string.valueof(ct.Employee_Id__c) And Date__c In : dateList And (OnDuty_Leave__c = '' OR OnDuty_Leave__c = null ) AND IsPresent__c = 'Absent'];
                if(empCalendarList.size() > 0){
                    delete empCalendarList;
                }
                */
                //ec.Date__c = Ledger.
                
            }
            
            //added by kk------------
            else if(Ledger.Status__c =='Cancelled'){
                
                
                if(Ledger.Leave_Type__c == 'Casual Leave'){
                    ct.Casual_Leave_Balance__c += ledger.Total_Days__c;
                }
                else if(Ledger.Leave_Type__c == 'Earned Leave'){
                    ct.Earned_Leave_Balance__c += ledger.Total_Days__c;
                }
                else if(Ledger.Leave_Type__c == 'Paternity Leave' || Ledger.Leave_Type__c == 'Maternity Leave'){
                    ct.Maternity_Paternity_Leave_Balance__c += ledger.Total_Days__c;
                }
                else if(Ledger.Leave_Type__c == 'Consulting Leave' || Ledger.Leave_Type__c == 'Researching Leave'){
                    ct.Faculty_Researching_and_Consulting__c += ledger.Total_Days__c;
                }
                else if(Ledger.Leave_Type__c == 'CompOff Leave'){
                    ct.CompOff_Balance__c += ledger.Total_Days__c;
                    
                }
                //--------new leave type code should come here-----------------//Start
                //--------new leave type code should come here-----------------//End
                
                
                
                for(Date loopstartDate = fromDate; loopstartDate <= toDate; loopstartDate = loopstartDate.addDays(1)){
                    updatedateList.add(loopstartDate);
                    //updateEmpIdList.add(String.valueOf(ct.Employee_Id__c));
                }
                lstecUpdate = [Select id, Employee_Code__c, Date__c, OnDuty_Leave__c ,In_Time__c, Out_Time__c From Employee_Calendar__c Where Employee_Code__c = : String.valueOf(ct.Employee_Id__c) AND Date__c In : updatedateList AND (OnDuty_Leave__c = 'Full Day Leave' OR OnDuty_Leave__c = 'Half Day Leave')];
                /*for(Employee_Calendar__c ee : lstecUpdate){

ee.OnDuty_Leave__c = '';
}*/
                if(lstecUpdate.size() > 0 ){
                    delete lstecUpdate;
                }
                
            }
            
            //here expired compoff request will come
            else if(Ledger.Status__c == 'Expired'){// || Ledger.Status__c == 'Availed'){
                if(Ledger.Leave_Type__c == 'CompOff Request'){
                    ct.CompOff_Balance__c = ct.CompOff_Balance__c - ledger.Total_Days__c;
                }
                
            }
            
            else if(Ledger.Status__c == 'Roll-Back'){
                targetIds.add(Ledger.id);
                if(Ledger.Leave_Type__c == 'CompOff Leave'){
                    updateCRLedgerListToAvailed.add(Ledger.CompOff_Request_Reference__c);
                }
            }
            
            
            
            //added by kk-----------
            //conUpdateList.add(ct);
            mapEmployeeIdContact.put(ct.id,ct);
        }
        
        if(targetIds.size()>0){
            
            List<ProcessInstance> pi = [Select ID, Status, TargetObject.Name, (SELECT Id, ActorId, ProcessInstanceId FROM Workitems)  From ProcessInstance WHERE TargetObjectId in : targetIds];
            
            for(ProcessInstance p : pi){
                if(p.Workitems.size() > 0){
                    Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
                    req.setAction('Removed');
                    req.setWorkitemId(p.Workitems[0].id);
                    reqlist.add(req);
                }
                
            }
            
            
            if(reqlist.size()>0){
                
                List<Approval.ProcessResult> processResults = Approval.process(reqlist);
            } 
        }

        //update compoff requets status after compoff leave is approved
        if(updateCRLedgerListToAvailed.size() > 0){
            Flame_EmailForApproval.updateCompOffRequestStatusToAvailed(updateCRLedgerListToAvailed);
        }
        
        conUpdateList.addAll(mapEmployeeIdContact.values() );
        update conUpdateList;
        
        if(eclist.size() > 0 ){
            Insert eclist;
        }
        
        
    }
    
    
    
    public static void CheckCreditRecords(List<Leave_Ledger__c> LedgersList){
        system.debug('create method');
        Map<Id,List<Leave_Ledger__c>> mapOfContactIdLeaveLedgers = new Map<Id,List<Leave_Ledger__c>>();
        for(Leave_Ledger__c Ledgers :LedgersList){
            if(Ledgers.From_Date__c == null || Ledgers.To_Date__c == null){
                if (mapOfContactIdLeaveLedgers.containsKey(Ledgers.Employee_Name__c)){
                    mapOfContactIdLeaveLedgers.get(Ledgers.Employee_Name__c).add(Ledgers);
                }
                else{
                    mapOfContactIdLeaveLedgers.put(Ledgers.Employee_Name__c, new List<Leave_Ledger__c> { Ledgers });
                }
            }
        }
        
        List<Contact> conList1 = [SELECT Id, Earned_Leave_Balance__c, Casual_Leave_Balance__c, Maternity_Paternity_Leave_Balance__c, Faculty_Researching_and_Consulting__c, CompOff_Balance__c  FROM Contact WHERE Id =:mapOfContactIdLeaveLedgers.keySet()];
        if(!conList1.isEmpty()){
            for(Contact contactObj : conList1){
                if(mapOfContactIdLeaveLedgers.get(contactObj.Id) != null){
                    for(Leave_Ledger__c leaveLedgerObj : mapOfContactIdLeaveLedgers.get(contactObj.Id)){
                        
                        //check if null then initialize with 0
                        if(contactObj.Earned_Leave_Balance__c == null){contactObj.Earned_Leave_Balance__c = 0;}
                        if(contactObj.Casual_Leave_Balance__c == null){contactObj.Casual_Leave_Balance__c = 0;}
                        if(contactObj.CompOff_Balance__c == null){contactObj.CompOff_Balance__c = 0;}
                        if(contactObj.Maternity_Paternity_Leave_Balance__c == null){contactObj.Maternity_Paternity_Leave_Balance__c = 0;}
                        if(contactObj.Faculty_Researching_and_Consulting__c == null){contactObj.Faculty_Researching_and_Consulting__c = 0;}
                        
                        if(leaveLedgerObj.Leave_Type__c == 'Casual Leave' && leaveLedgerObj.Total_Days__c != null){
                            if(leaveLedgerObj.Leave_Action__c == 'Debit'){
                                contactObj.Casual_Leave_Balance__c = contactObj.Casual_Leave_Balance__c - leaveLedgerObj.Total_Days__c;
                            }
                            else{
                                contactObj.Casual_Leave_Balance__c = contactObj.Casual_Leave_Balance__c + leaveLedgerObj.Total_Days__c;
                            }
                        }
                        if(leaveLedgerObj.Leave_Type__c == 'Earned Leave' && leaveLedgerObj.Total_Days__c != null){
                            if(leaveLedgerObj.Leave_Action__c == 'Debit'){
                                contactObj.Earned_Leave_Balance__c = contactObj.Earned_Leave_Balance__c - leaveLedgerObj.Total_Days__c;
                            }
                            else{
                                contactObj.Earned_Leave_Balance__c = contactObj.Earned_Leave_Balance__c + leaveLedgerObj.Total_Days__c;
                            }
                        }
                        
                        if(( leaveLedgerObj.Leave_Type__c == 'Paternity Leave' || leaveLedgerObj.Leave_Type__c == 'Maternity Leave') && leaveLedgerObj.Total_Days__c != null){
                            if(leaveLedgerObj.Leave_Action__c == 'Debit'){
                                contactObj.Maternity_Paternity_Leave_Balance__c = contactObj.Maternity_Paternity_Leave_Balance__c - leaveLedgerObj.Total_Days__c;
                            }
                            
                            else{
                                contactObj.Maternity_Paternity_Leave_Balance__c = contactObj.Maternity_Paternity_Leave_Balance__c + leaveLedgerObj.Total_Days__c;
                            }
                        }
                        if(leaveLedgerObj.Leave_Type__c == 'Faculty Consulting Researching Leave' && leaveLedgerObj.Total_Days__c != null){
                            if(leaveLedgerObj.Leave_Action__c == 'Debit'){
                                contactObj.Faculty_Researching_and_Consulting__c = contactObj.Faculty_Researching_and_Consulting__c - leaveLedgerObj.Total_Days__c;
                            }
                            
                            else{
                                contactObj.Faculty_Researching_and_Consulting__c = contactObj.Faculty_Researching_and_Consulting__c + leaveLedgerObj.Total_Days__c;
                            }
                        }
                        if(leaveLedgerObj.Leave_Type__c == 'CompOff Request' && leaveLedgerObj.Total_Days__c != null){
                            if(leaveLedgerObj.Leave_Action__c == 'Debit'){
                                contactObj.CompOff_Balance__c = contactObj.CompOff_Balance__c - leaveLedgerObj.Total_Days__c;
                            }
                            
                            else{
                                contactObj.CompOff_Balance__c = contactObj.CompOff_Balance__c + leaveLedgerObj.Total_Days__c;
                            }
                        } 
                        //--------new leave type code should come here-----------------//Start
                        //--------new leave type code should come here-----------------//End
                        
                    }
                }
            }
        }
        
        if(!conList1.isEmpty()){
            System.debug('=======Size======='+conList1.size());
            update conList1;  
        }
        
    }
    
}