//Trigger to update parent record(Ledger__c) when any child record(Contact_Payment__c) is updated.


trigger fieldupdate on Contact_Payment__c (after insert,after update) {
    Set<Id> acctIds = new Set<Id>();
    List<Contact_Payment__c> listPayment = new List<Contact_Payment__c>();
    List<Ledger__c> listLedgeInsert =new List<Ledger__c>();
    if(Trigger.isInsert){
    try{

    for (Contact_Payment__c co : Trigger.new){
    Ledger__c led =[Select Id,Name,Academic_Year__c,Amount__c,Transaction_Date__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c,Description__c,Drawn_on_Bank_Name__c,
    External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Payment_Date__c,Posting_Date__c,Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,Payment_Mode__c,
    Tracking_ID__c,Type__c From Ledger__c where id=:co.Ledger__c   LIMIT 1 ];
    
    List<Contact_Payment__c> listPayment =[Select Id,FUA_Application__c,FUA_Order_Status__c,FUA_Application__r.Contact__c,FUA_Tracking_Id__c,FUA_Bank_Ref_No__c,DD_Number__c ,Branch__c,FUA_Payment_Mode__c,
    Drawn_on_Bank_Name__c,Fee_Type__c,FUA_Amount__c,FUA_Order_Id__c,Paid_By__c,Payment_Date__c from Contact_Payment__c where Ledger__c =:led.id];
    
    for(Contact_Payment__c cp:listPayment){
    
    led.Tracking_ID__c = cp.FUA_Tracking_Id__c;
    led.Order_ID__c = cp.FUA_Order_Id__c;
    led.Fee_Type__c = cp.Fee_Type__c;
    led.Order_Status__c = cp.FUA_Order_Status__c;
    led.Paid_By__c = cp.Paid_By__c;
    led.Payment_Date__c = cp.Payment_Date__c;
    led.Bank_Ref_No__c = cp.FUA_Bank_Ref_No__c;
    led.Payment_Mode__c = cp.FUA_Payment_Mode__c;
    }
    
    update led;
    }
    }catch (Exception e) {
    System.debug(e);

    }
    }

    if(Trigger.isAfter) {
    if(Trigger.isUpdate){
    try {
    for (Contact_Payment__c co : Trigger.old){
    Ledger__c led =[Select Id,Name,Academic_Year__c,Amount__c,Transaction_Date__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c,Description__c,Drawn_on_Bank_Name__c,
    External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Partial_Pay__c,Partial_Pay_Amount__c,Payment_Date__c,Posting_Date__c,Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,
    Tracking_ID__c,Type__c,Payment_Mode__c From Ledger__c where id=:co.Ledger__c   LIMIT 1 ];
    
    List<Contact_Payment__c> listPayment =[Select Id,FUA_Application__c,FUA_Order_Status__c,FUA_Application__r.Contact__c,FUA_Tracking_Id__c,FUA_Bank_Ref_No__c,DD_Number__c ,Branch__c,FUA_Payment_Mode__c,
    Drawn_on_Bank_Name__c,Fee_Type__c,FUA_Amount__c,FUA_Order_Id__c,Paid_By__c,Payment_Date__c from Contact_Payment__c where Ledger__c =:led.id];
    
    for(Contact_Payment__c cp:listPayment){
    
    led.Tracking_ID__c = cp.FUA_Tracking_Id__c;
    led.Order_ID__c = cp.FUA_Order_Id__c;
    led.Fee_Type__c = cp.Fee_Type__c;
    led.Order_Status__c = cp.FUA_Order_Status__c;
    led.Paid_By__c = cp.Paid_By__c;
    led.Payment_Date__c = cp.Payment_Date__c;
    led.Bank_Ref_No__c = cp.FUA_Bank_Ref_No__c;
    led.Payment_Mode__c = cp.FUA_Payment_Mode__c;
    }
    
    update led;
    }
    }catch (Exception e) {
    System.debug(e);
    }
    }
    }
    }