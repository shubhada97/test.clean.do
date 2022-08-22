trigger ContentVersionTrigger on ContentVersion (after insert, after update, after delete, before delete, before insert, before update) 
{ 
     ContentVersionTriggerHandler triggerHandler = new ContentVersionTriggerHandler(Trigger.isExecuting,Trigger.size);
  
    if(Trigger.isAfter && Trigger.isInsert){
        triggerHandler.OnAfterInsert(trigger.new, trigger.NewMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){       
        triggerHandler.OnBeforeUpdate(trigger.new, trigger.NewMap, Trigger.oldMap);
    } 
}