trigger AssociateCasesFromEmailToCase on Contact (after insert) {
Map<string,Contact> conMap = new Map<string,Contact>();
 //Id devRecordTypeId = Schema.SObjectType.Application__c.getRecordTypeInfosByName().get('FU_Applicant').getRecordTypeId();  
     for(Contact c: Trigger.new){
        // Check if the contact has an email
        
        if(c.email != Null && c.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Applicant').getRecordTypeId()){
            conMap.put(c.email, c);
          
        }
            }
    System.debug('conMap-->'+conMap);
    // Fetch all the case Which have no Contact and there email is matching the email of
    // the newly created contact.
    List<Case> cases = [SELECT Id,Casenumber,SuppliedEmail,ContactId FROM Case WHERE ContactId = ''
                        AND SuppliedEmail IN :conMap.keySet()];
              System.debug('cases-->'+cases);           
    if(cases.size() > 0 && cases != Null){
    
        for(Case cs : cases){
    
            cs.ContactId = conMap.get(cs.SuppliedEmail).Id;
            
        }
        
    }
        update cases;
}