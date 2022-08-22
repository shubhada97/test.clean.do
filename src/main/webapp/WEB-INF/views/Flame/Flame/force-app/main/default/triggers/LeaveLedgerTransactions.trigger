trigger LeaveLedgerTransactions on Leave_Ledger__c (after insert,after Update, before update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){   
            LeaveLedgerUpdates.UpdateRelatedContact(Trigger.new);
        }
        if(Trigger.isInsert){
            system.debug('inserted leave');
            LeaveLedgerUpdates.CheckCreditRecords(Trigger.new);
        }
        Flame_EmailForApproval.sendUpdateEmailForLeave(Trigger.new);
    }
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            
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
            set<id> checkCRExpired = new set<id>();
            for(Leave_Ledger__c newll : Trigger.new){
                
                Leave_Ledger__c oldll = System.Trigger.oldMap.get(newll.Id);
                
                if((newll.status__c == 'Rejected' || newll.status__c == 'Approved') && newll.status__c != oldll.status__c){
                    System.Debug ('mangComments:::: '+mangComments.get(newll.id));
                    newll.Manager_Comments__c = mangComments.get(newll.id);
                }
                if((newll.Status__c == 'Rejected' || newll.Status__c == 'Roll-Back' || newll.Status__c == 'Cancelled' ) && newll.Leave_Type__c == 'CompOff Leave'){
                    checkCRExpired.add(newll.CompOff_Request_Reference__c);
                    newll.CompOff_Request_Reference__c = null;
                }
            }
            if(checkCRExpired.size() > 0){
                Flame_EmailForApproval.updateCompOffRequestStatusToExpire(checkCRExpired);
            }
            
        }
    }
}