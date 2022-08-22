public with sharing class FUA_ApplicationStatusController 
{
    public Application__c userApp {get;set;}
    public String applicationText{get;set;}
    public Program__c program {get;set;}
    Public Boolean switchindex {get;set;}
    public FUA_ApplicationStatusController(){
        switchindex= false;
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        userApp = objUtility.getApplicationId(UserInfo.getUserId());
        system.debug('Application>>>>>>>>>>>>>>' + userApp );
        program = [Select ID,Name From Program__c Where ID =: userApp.Program__c];
        Map<String,Blob> mapOfText = getTest();
        
        if(userApp.FUA_Broadcast_Admission__c == true)
        {
            
            if(userApp.Admission_Status__c == 'Shortlisted' || userApp.Admission_Status__c == 'Deposit Paid' || userApp.Admission_Status__c == 'Deposit Withdrawn' || userApp.Admission_Status__c == 'Test Absent' || userApp.Admission_Status__c == 'Interview-Absent' || userApp.Admission_Status__c == 'Enrolled' || userApp.Admission_Status__c == 'Admission Withdrawn' || userApp.Admission_Status__c == 'Shortlisted with Scholarship')
            {
                
                if(mapofText.containsKey('ApplicationStatusShortlisted'))
                {
                    applicationText = mapOfText.get('ApplicationStatusShortlisted').toString(); 
                     switchindex= true;    
                }
                
                if(userApp.Admission_Status__c == 'Shortlisted with Scholarship' && mapOfText.containsKey('ApplicationStatusShortlisted&ScholarshipGranted'))
                {
                    applicationText = mapOfText.get('ApplicationStatusShortlisted&ScholarshipGranted').toString();
                }
                
            }
            
            else if(userApp.Admission_Status__c == 'Rejected' && mapOfText.containsKey('ApplicationStatusRejected'))
            {
                applicationText = mapOfText.get('ApplicationStatusRejected').toString();
            }
            else if(userApp.Admission_Status__c == 'Document Awaited' && mapOfText.containsKey('ApplicationStatusDocumentsAwaited'))
            {
                applicationText = mapOfText.get('ApplicationStatusDocumentsAwaited').toString();
            }
            else if(userApp.Admission_Status__c == 'Wait-Listed' && mapOfText.containsKey('ApplicationStatusWaitListed'))
            {
                applicationText = mapOfText.get('ApplicationStatusWaitListed').toString();
            }
            else
            {
                applicationText = mapOfText.get('ApplicationStatusNotGenerated').toString();
            }
        }
        else
        {
            applicationText = mapOfText.get('ApplicationStatusNotGenerated').toString();
        }
    }
    public Map<String,Blob> getTest(){
        Map<String, Blob> mapOfContent = new Map<String, Blob>();
        List<Document> lstOfDocument = [Select Name, Body From Document Where Name = 'ApplicationStatusShortlisted' OR 
                                       Name = 'ApplicationStatusRejected' OR Name = 'ApplicationStatusDocumentsAwaited' OR
                                       Name = 'ApplicationStatusWaitListed' OR Name = 'ApplicationStatusShortlisted&ScholarshipGranted' OR
                                       Name = 'ApplicationStatusNotGenerated'];

        if(lstOfDocument.size() > 0){
            for(Document currentDoc : lstOfDocument){
                mapOfContent.put(currentDoc.Name, currentDoc.Body);
            }
        }
        return mapOfContent;
    }
    
    Public PageReference Accepetoffer(){
       if(userApp.id != null)
        {
       
        String completedStages = userApp.Completed_Stages__c;
        String currentPageName = 'Admission Status';
        if(completedStages != null){
        if(!completedStages.contains(currentPageName)){
        completedStages += ';' + currentPageName;
        userApp.Completed_Stages__c = completedStages;
        }
        }
        }else {
        userApp.Completed_Stages__c = 'currentPageName';
        }
        update userApp; 
     PageReference nextPage =  new PageReference('/apex/Accepetoffer_1');
     nextPage.setRedirect(true);
     return nextPage;
    }
    
  Public PageReference saveAllData(){
  return null;
  }  
    
}