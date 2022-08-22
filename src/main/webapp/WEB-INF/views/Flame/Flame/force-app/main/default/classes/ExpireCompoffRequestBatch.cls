global class ExpireCompoffRequestBatch implements Database.Batchable<sObject> {
    String query;
    Integer dateDiffFromDate;
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, Name, From_Date__c, Leave_Type__c, Status__c, CompOff_Expired__c, CompOff_Used__c,CreatedDate FROM Leave_Ledger__c WHERE ( status__c = \'Approved\' OR (From_Date__c = null AND To_Date__c = null) ) AND Leave_Type__c = \'CompOff Request\' AND RecordType.Name =\'Credit\' AND CompOff_Expired__c = false AND CompOff_Used__c = false');
    }
    global void execute(Database.BatchableContext BC, List<Leave_Ledger__c> scope){
        List<Leave_Ledger__c> levLedgToUpdate = new List<Leave_Ledger__c>();
        Leave_Setting__mdt lvSetObj = new Leave_Setting__mdt();
        lvSetObj = [SELECT Id, Label, CompOff_Expiration_Days__c FROM Leave_Setting__mdt WHERE Label = 'All Leave Configurations for Employee'];
        Try{
            if(scope.size() > 0){
                for(Leave_Ledger__c levledgObj : scope){
                    dateDiffFromDate = levledgObj.From_Date__c.daysBetween(system.today());
                    system.debug('dateDiffFromDate::'+dateDiffFromDate);
                    if(dateDiffFromDate > lvSetObj.CompOff_Expiration_Days__c){
                        levledgObj.CompOff_Expired__c = true;
                        levledgObj.Status__c = 'Expired';
                        levLedgToUpdate.add(levledgObj);
                    }
                }
                system.debug('levLedgToUpdate::'+levLedgToUpdate.size());
                update levLedgToUpdate;
            }
        }
        Catch(Exception e){
            system.debug('Exception is:'+e);
        }
    }
    global void finish(Database.BatchableContext BC){
        system.debug('In Finish');
    }
}