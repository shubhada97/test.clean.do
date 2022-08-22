public with sharing class PaymentClass {
    @AuraEnabled(cacheable= true)
   public static list<Ledger__c> payment(){
    list<Ledger__c> cp =[Select Id,Academic_Year__c	, Contact__c, Amount__c,Fee_Type__c,Ledger_Account_Name__c, RecordTypeId, Type__c from  Ledger__c ];
    return cp;
}
}