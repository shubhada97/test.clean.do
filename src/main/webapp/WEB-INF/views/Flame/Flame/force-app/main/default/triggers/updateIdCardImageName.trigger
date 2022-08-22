trigger updateIdCardImageName on ContentVersion (before insert,after insert) {
    
    if(Trigger.isInsert) {
        if(Trigger.isAfter){
            //updateIdCardImageNameHander.updateName(Trigger.New);
        }
    }

}