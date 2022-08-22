trigger FlameEventTrigger on Flame_Event__c (After insert) {

    if(trigger.isinsert && trigger.isafter){
     //   FlameEventTriggerController.ApexShareAccessFlameEvent(trigger.new);
    }
}