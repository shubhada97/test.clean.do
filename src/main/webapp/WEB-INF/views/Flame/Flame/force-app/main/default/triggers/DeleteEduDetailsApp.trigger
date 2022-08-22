trigger DeleteEduDetailsApp on Application__c (after update) {
    List<FU_Education_Details__c> eduDetails = new List<FU_Education_Details__c>();
    Set<Id> applicationIds = Trigger.newMap.keyset();
    List<Application__c> apps = [select id,Completed_Stages__c,name,Program__r.Name,Program__r.Program_Type__c,(select id , name , FU_Year_Class__c from Education_Details__r) from Application__c where ID In :applicationIds];
    system.debug(apps.size() + ' --- ' + apps[0].Education_Details__r.size());
    for(Application__c app : apps){
        if(app.Education_Details__r.size() > 0){
            eduDetails.addAll(app.Education_Details__r);
        }
    }
    List<FU_Education_Details__c> listTodelete = new List<FU_Education_Details__c>();
        for(Application__c app : apps){
            if(Trigger.oldMap.get(app.Id).Program__c != Trigger.newMap.get(app.Id).Program__c){
                if(app.Program__r.Program_Type__c == 'Undergraduate (B.A.,BBA,B.Sc.)'){
                    for(FU_Education_Details__c edu : eduDetails){
                        if(edu.FU_Year_Class__c == 'Bachelors / Undergraduate' || edu.FU_Year_Class__c == 'Masters / Postgraduate' || edu.FU_Year_Class__c == 'Graduate Institution'){
                            listTodelete.add(edu);
                        }
                    }
                }
            }
        }
        
        if(listTodelete.size() > 0){
            delete listTodelete;
        }
}