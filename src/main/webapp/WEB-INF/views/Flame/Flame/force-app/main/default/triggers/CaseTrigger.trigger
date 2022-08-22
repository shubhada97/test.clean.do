trigger CaseTrigger on Case (before update,before insert) {

    Map<String,Application__c> applicationsMap = new Map<String,Application__c>();
    List<String> emails = new List<String>();
    for(Case record : trigger.new){
        if(record.SuppliedEmail != null){
            emails.add(record.SuppliedEmail);
        }
    }
    
    for(Application__c app : [select Id,Contact__c,Contact__r.Email from Application__c where Contact__r.Email IN :emails]){
            applicationsMap.put(app.Contact__r.Email,app);
    }
    
    for(Case record : trigger.new){
        if(record.SuppliedEmail != null){
            if(applicationsMap.get(record.SuppliedEmail) != null){
                record.ContactId = applicationsMap.get(record.SuppliedEmail).Contact__c;
                record.Application__c = applicationsMap.get(record.SuppliedEmail).Id;
            }
        }
    }
}