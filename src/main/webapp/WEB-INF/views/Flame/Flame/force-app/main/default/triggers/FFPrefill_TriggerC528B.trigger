/**
 * Auto Generated and Deployed by Fast Prefill - Formstack
 **/
trigger FFPrefill_TriggerC528B on Survey__c
    (after insert)
{
 if  (trigger.isAfter  &&  trigger.isInsert) { 
List<Survey__c>  newlyInsertedItems =  [SELECT  Id ,  Survey_URL__c FROM  Survey__c WHERE  Id  IN :trigger.new] ; 
List<string> ids = new List<string>();
 for ( Survey__c e  : newlyInsertedItems) { 
ids.add(e.id); 
} 
 VisualAntidote.FastFormsUtilities.DoUpdateRecords( 'Survey__c' ,  'Survey_URL__c' ,  'a1M0K000004ORIVUA4' ,  ids,null );  
 update newlyInsertedItems;}
}