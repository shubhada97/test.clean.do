/**
 * Auto Generated and Deployed by Fast Prefill - Fast Forms
 **/
trigger FFPrefill_Trigger2D590 on Contact
    (after insert)
{
 if  (trigger.isAfter  &&  trigger.isInsert) { 
List<Contact>  newlyInsertedItems =  [SELECT  Id ,  Website__c FROM  Contact WHERE  Id  IN :trigger.new] ; 
List<string> ids = new List<string>();
 for ( Contact e  : newlyInsertedItems) { 
ids.add(e.id); 
} 
 VisualAntidote.FastFormsUtilities.UpdateRecordsWithURL ( 'Contact' ,  'Website__c' ,  'a1M28000003Np8uEAC' ,  ids );  
 update newlyInsertedItems;}
}