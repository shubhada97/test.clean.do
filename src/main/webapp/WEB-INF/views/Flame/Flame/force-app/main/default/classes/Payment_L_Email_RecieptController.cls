public class Payment_L_Email_RecieptController{
    public Ledger__c ledlstVal{get;set;}
    public Application__c applicationObj {get;set;} 
    public Payment_L_Email_RecieptController(){
        String ledgerId = ApexPages.currentPage().getParameters().get('ledgerId');
        system.debug('@@@ledgerId+++' + ledgerId);
        ledlstVal = [SELECT id,  Name,contact__c, Receipt_Date__c,On_Account_of__c,Academic_Year__c, Contact__r.Name, Amount__c, Paid_By__c, Bank_Ref_No__c, 
        contact__r.Program_Interested_In__c,contact__r.CVUE_Student_Number__c FROM Ledger__c where Id=:ledgerId limit 1 ];
    }
}