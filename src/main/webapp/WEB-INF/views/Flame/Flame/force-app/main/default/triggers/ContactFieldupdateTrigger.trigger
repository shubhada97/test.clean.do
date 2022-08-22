trigger ContactFieldupdateTrigger on Contact ( after update) 
{
    Set<Id> sectionIds = new Set<Id>();
    map<string,Id> recordTypeMap = new map<string,Id>();
  try{
   if (Trigger.IsAfter && Trigger.IsUpdate){
   
   
     list<RecordType> recTypes = [Select Id, Name From RecordType Where sObjectType = 'contact' and isActive = true ];
     for(RecordType rt : recTypes){
         recordTypeMap.put(rt.Name, rt.Id);
     }
   
   
   for(Contact con : Trigger.new)
        {
        if (con.Contact_Admission_Status__c .equals ('Completed') || con.Contact_Admission_Status__c .equals ('Registered')  || con.Contact_Admission_Status__c.equals ('Submitted Paid') || con.RecordTypeId == recordTypeMap.get('FU_Applicant')) {
            sectionIds.add(con.Id);
            }
        
        
         }
         
    if(sectionIds.size() > 0 )
        { 
            List<Contact> contlist =[Select Id,Email,Contact_Admission_Status__c from Contact where id =:sectionIds  And RecordType.developername='FU_Applicant'   Limit 1];
            system.debug('cont>>>>>>>>'+contlist);
            
            Lead  mylead = [Select id,Application_Status__c,Email from Lead Where Email=:contlist[0].Email Limit 500]; 
            System.debug('mylead>>>>>>>>'+mylead);  
             
            for(Contact mycon:contlist){
            if(mycon.Contact_Admission_Status__c.equals ('Completed')  || mycon.Contact_Admission_Status__c .equals ('Registered')  || mycon.Contact_Admission_Status__c.equals ('Submitted Paid') ){
             mylead.Application_Status__c = mycon.Contact_Admission_Status__c;
            }
           
            }
            
            update mylead;  
            system.debug('mylead>>>>>'+mylead);
      
        
      
     }
     
      
  }
   } catch (Exception e) {
    System.debug(e);

    }
}