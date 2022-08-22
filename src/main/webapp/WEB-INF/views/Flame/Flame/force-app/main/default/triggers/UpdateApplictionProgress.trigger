trigger UpdateApplictionProgress on Application__c (before update) {
    if(!RecursiveCallHandler.getIsProgressBarCalled()){
        RecursiveCallHandler.setIsProgressBarCalled();
        for(Application__c app : trigger.new){
                if(app.Completed_Stages__c != null){
                    List<String> Completedstages = app.Completed_Stages__c.split(';');
                    Decimal totalCompletion = 0;
                    for(String stageName : Completedstages){
                        if(ProgressBar__c.getValues(stageName) != null && ProgressBar__c.getValues(stageName).Progress__c != null){
                            totalCompletion += ProgressBar__c.getValues(stageName).Progress__c;
                        }
                    }
                    app.Application_Progress__c = totalCompletion;
                }
                else{
                    app.Application_Progress__c = 0;
                }
        }
    }
}