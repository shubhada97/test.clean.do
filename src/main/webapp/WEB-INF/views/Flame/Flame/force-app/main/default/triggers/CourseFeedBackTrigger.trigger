trigger CourseFeedBackTrigger on Course_feedback__c (after insert, after update, after delete, before delete, before insert, before update) 
{ 
     CourseFeedBackTriggerHandler triggerHandler = new CourseFeedBackTriggerHandler(Trigger.isExecuting,Trigger.size);
  
    if(Trigger.isAfter && Trigger.isInsert){
        triggerHandler.OnAfterInsert(trigger.new, trigger.NewMap);
    }
    
     if(Trigger.isAfter && Trigger.isDelete){
        triggerHandler.OnAfterInsert(trigger.old, trigger.OldMap);
    }
    if(Trigger.isBefore && Trigger.isUpdate){       
        triggerHandler.OnBeforeUpdate(trigger.new, trigger.NewMap, Trigger.oldMap);
    } 
 }