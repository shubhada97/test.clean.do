trigger ContactTrigger on Contact (after insert, after update, after delete, before delete, before insert, before update) 
{ 
     ContactTriggerHandler triggerHandler = new ContactTriggerHandler(Trigger.isExecuting,Trigger.size);
  
    if(Trigger.isAfter && Trigger.isInsert){
        triggerHandler.OnAfterInsert(trigger.new, trigger.NewMap);
    }
   /* if(Trigger.isBefore && Trigger.isUpdate){       
        triggerHandler.OnBeforeUpdate(trigger.new, trigger.NewMap, Trigger.oldMap);
    } */
    if(Trigger.isAfter && Trigger.isUpdate){       
        triggerHandler.OnAfterUpdate(trigger.new, Trigger.oldMap);
    } 
}