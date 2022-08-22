/**
 * Auto Generated and Deployed by Fast Prefill - Formstack
 **/
trigger FFPrefill_TriggerFDE09 on Contact
    (after insert)
{
 if  (trigger.isAfter  &&  trigger.isInsert) { 
List<Contact>  newlyInsertedItems =  [SELECT  Id ,  Website__c FROM  Contact WHERE  Id  IN :trigger.new] ; 
List<string> ids = new List<string>();
 for ( Contact e  : newlyInsertedItems) { 
ids.add(e.id); 
} 
 VisualAntidote.FastFormsUtilities.DoUpdateRecords( 'Contact' ,  'Website__c' ,  'a1M0K000004OQopUAG' ,  ids,null );  
 update newlyInsertedItems;}
}