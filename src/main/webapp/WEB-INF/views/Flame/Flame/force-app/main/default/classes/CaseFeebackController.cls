public class CaseFeebackController {
    public string strCaseId;
    public Case objCase{get;set;}
    public boolean isChanged{get;set;}
    public Boolean displayPopUp {get;set;} //added 7 March 2020

    public CaseFeebackController(){
        objCase = new Case();
        strCaseId = ApexPages.currentPage().getParameters().get('id'); //case Id
        if(strCaseId !=null){
            objCase = [Select id,is_Feedback_Submit__c,How_quickly_did_we_address_your_concern__c,How_would_you_rate_your_Exp_with_us__c,Do_you_have_any_other_comments_questions__c from Case where Id =:strCaseId];
        } 
        }
    
     public PageReference SubmitFeedback(){ 
        SYSTEM.DEBUG('objCase.How_quickly_did_we_address_your_concern__c@@@'+objCase.How_quickly_did_we_address_your_concern__c);
        SYSTEM.DEBUG('objCase.How_would_you_rate_your_Exp_with_us__c@@@'+objCase.How_would_you_rate_your_Exp_with_us__c);
        try{
           if(objCase.How_quickly_did_we_address_your_concern__c == null){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, ' Please fill How quickly did we address your concern?.'));
             //return null;
           }
           
            if(objCase.How_would_you_rate_your_Exp_with_us__c == null){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, ' Please fill How would you rate your experience with us?.'));
             //return null;
           }
           else{
            objCase.Id = strCaseId;
            objCase.is_Feedback_Submit__c =true;
            update objCase;
            isChanged=true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank You for Submitting the feedback!!!'));
            displayPopUp = true;
           }
        }
        catch(dmlexception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Please try Again'));
        }
        return null; 
      
    } 
    
    public pagereference redirectToRequiredPage(){
        PageReference pageRef=new PageReference('/apex/Flame_Home');
        return pageRef;
    }
    
    public PageReference closePopup(){
        displayPopUp = false;
        PageReference pg = new PageReference('/apex/Flame_Home');
        pg.setRedirect(true);
        return pg;
    }
    
    public List<SelectOption> getChoice1() 
    {
    List<SelectOption> option = new List<SelectOption>();
    option.add(new SelectOption('5','Much shorter than expected'));
    option.add(new SelectOption('4','Shorter than expected'));
    option.add(new SelectOption('3','About what I expected'));
    option.add(new SelectOption('2','Longer than expected'));
    option.add(new SelectOption('1','Much longer than expected'));
    return option;
    }
    
    public List<SelectOption> getChoice2() 
    {
    List<SelectOption> option = new List<SelectOption>();
    option.add(new SelectOption('5','Very positive'));
    option.add(new SelectOption('4','Somewhat positive'));
    option.add(new SelectOption('3','Neutral'));
    option.add(new SelectOption('2','Somewhat negative'));
    option.add(new SelectOption('1','Very negative'));
    return option;
    }
   
}