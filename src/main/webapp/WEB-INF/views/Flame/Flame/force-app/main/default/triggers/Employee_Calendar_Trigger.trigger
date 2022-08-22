trigger Employee_Calendar_Trigger on Employee_Calendar__c (before update, after insert,after update) {
    
    if (Trigger.isUpdate && Trigger.isBefore){
        
        Map<id,String> mangComments = new Map<id,String>();
        
        //-----------------
        List<ProcessInstance> instancesSteps = [select Id, TargetObjectId , (select StepStatus, Comments,ProcessInstanceId from steps order by createddate desc) from ProcessInstance where TargetObjectId In : Trigger.new];
        
        for(ProcessInstance pis : instancesSteps){
            System.Debug ('pis:::: '+pis);
            System.Debug ('pis::::: '+pis.steps);
            if(pis.steps.size() > 0){
                if(pis.steps[0].StepStatus == 'Approved' || pis.steps[0].StepStatus == 'Rejected'){
                    mangComments.put(pis.TargetObjectId,pis.steps[0].Comments);
                } 
            }
        }
        //-----------------
        
        For(Employee_Calendar__c empc : Trigger.new)
        {
            
            If(empc.Status__c == 'Approved')
            {
                empc.In_Time__c = empc.Expected_In_Time__c;
                empc.Out_Time__c = empc.Expected_Out_Time__c;
                empc.Manager_Comments__c = mangComments.get(empc.id);
            }
            else if(empc.Status__c == 'Rejected'){
                empc.Manager_Comments__c = mangComments.get(empc.id);
            }
        }
    }
    
    
    if (Trigger.isInsert && Trigger.isAfter){

        List<Employee_Calendar__c> oldEmpList = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> deletenewList = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> GetNewAbsentMainList = new List<Employee_Calendar__c>();
        
        Set<String> pastLeaveApplyEMPCODE = new Set<String>();
        Set<Date> pastLeaveDates = new Set<Date>();
        List<Employee_Calendar__c> allNewRecords = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> allOldRecords = new List<Employee_Calendar__c>();
        
        Set<String> setOfEmployeeCode = new Set<String>();
        Set<Date> datelist = new Set<Date>();
        
        for(Employee_Calendar__c empc : Trigger.new){
            if(empc.IsPresent__c == 'Absent' && empc.OnDuty_Leave__c != 'Full Day Leave' && empc.OnDuty_Leave__c != 'Half Day Leave' && empc.OnDuty_Leave__c != 'Official Regularized Visit'){
                setOfEmployeeCode.add(empc.Employee_Code__c);
                datelist.add(empc.Date__c);
                GetNewAbsentMainList.add(empc);
            }
            else if(empc.OnDuty_Leave__c == 'Full Day Leave' || empc.OnDuty_Leave__c == 'Half Day Leave'){
                allNewRecords.add(empc);
                pastLeaveDates.add(empc.Date__c);
                pastLeaveApplyEMPCODE.add(empc.Employee_Code__c);
            }
        }
        
        oldEmpList = [SELECT Id, Day__c, Date__c, In_Time__c, Out_Time__c,OnDuty_Leave__c, Employee_Code__c, Year__c, Status__c FROM Employee_Calendar__c where Employee_Code__c in :setOfEmployeeCode And Date__c In : datelist And (OnDuty_Leave__c = 'Full Day Leave' OR OnDuty_Leave__c = 'Official Regularized Visit')];
        
        if(GetNewAbsentMainList.size() > 0){
            for(Employee_Calendar__c ecmp : GetNewAbsentMainList){
                for(Employee_Calendar__c ecleave : oldEmpList){
                    if(ecmp.Employee_Code__c == ecleave.Employee_Code__c ){
                        deletenewList.add(ecmp);
                        break;
                    }
                }
            }

            if(deletenewList.size() > 0){
                List<Employee_Calendar__c> getlist = [Select id From Employee_Calendar__c Where Id In: deletenewList];
                delete getlist;
                //delete deletenewList;
            }
        }
        Flame_EmailForApproval.sendUpdateEmailForPunch(Trigger.new);
        
        //--------------past leave approved then delete old records-----------//
        
        allOldRecords = [SELECT Id, Day__c, Date__c, In_Time__c, Out_Time__c,OnDuty_Leave__c, Employee_Code__c, Year__c, Status__c FROM Employee_Calendar__c where Employee_Code__c in :pastLeaveApplyEMPCODE And Date__c In : pastLeaveDates And (OnDuty_Leave__c = '' OR OnDuty_Leave__c = null ) AND IsPresent__c = 'Absent'];
        List<Employee_Calendar__c> delOldRec = new List<Employee_Calendar__c>();
        for(Employee_Calendar__c ecmp : allOldRecords){
            //for(Employee_Calendar__c ecc : pastLeaveApply.Values())
            for(Employee_Calendar__c ecc : allNewRecords){
                if(ecmp.Date__c == ecc.Date__c && ecmp.Employee_Code__c == ecc.Employee_Code__c){
                    delOldRec.add(ecmp);
                    break;
                }
            }
        }
        if(delOldRec.size() > 0 ){
            delete delOldRec;
        }
        
        //--------------past leave approved then delete old records-----------//
    }
}