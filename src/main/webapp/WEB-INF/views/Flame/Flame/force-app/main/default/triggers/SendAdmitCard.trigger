trigger SendAdmitCard on Admit_Card__c (after update) {
    
    Set<Admit_Card__c> admitCardDetails = new Set<Admit_Card__c>();
    
    for(Admit_Card__c admitCard : trigger.new){
        if(admitCard.FUA_Broadcast_Admit_Card__c){
            admitCardDetails.add(admitCard);
        }
    }
    
    if(admitCardDetails.size()>0) AdmitCardDetailsHandler.CreateAdmitCard(admitCardDetails);
    
    
    
    
    }