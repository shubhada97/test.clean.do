Global class ledger_Utility{


/*Contact*/

 public static contact getConactInfo(String ContactId,string Username,string Password ){
      List<Contact>  Con = new list<Contact>();

    if(ContactId!=null) {
       Con = new list<Contact>([select id,Name,Payment_Key__c,CVUE_Student_Number__c,Program_Interested_In__c from contact where Id=:ContactId Limit 1]);
        system.debug('contact:'+'con' );
        }
    else{
      Con = new list<Contact>([select id,Name,Payment_Key__c,CVUE_Student_Number__c,Program_Interested_In__c  from contact where CVUE_Student_Number__c=: Username  AND Payment_Key__c =:Password   Limit 1]);
      system.debug('username:'+Username+'######' );
    }
     return Con[0];
 }

/*ledger*/

   public static List<String> getLedgerInfoPaymentId(String ContactId, String Type){  
        List<String>  LedgerIds = new List<String>();  
        For(Ledger__c led :[Select Id From Ledger__c  WHERE Contact__c =: ContactId and Type__c=:Type]){
            LedgerIds.add(led.Id);
        }
        return LedgerIds;
    }
    public static List<Ledger__c> getLedgerInfo(String ContactId, String LedId){  
        List<Ledger__c>  Led = null; 
        if(ContactId!=null)
        Led =new List<Ledger__c>([Select Id,Name,Description__c,Amount__c,Type__c,Paid__c,Contact__c From Ledger__c  WHERE Contact__c =: ContactId and Paid__c=false LIMIT 1]);  
        else if(LedId!=null)
        Led =new List<Ledger__c>([Select Id,Name,Description__c,Amount__c,Type__c,Paid__c,Contact__c From Ledger__c WHERE Id =:LedId  LIMIT 1]);   
        System.debug('---------- getLedgerInfo --------' +Led);
        return Led;
 
}

/*Contact_Payment__c*/

      public List<Contact_Payment__c> paymentDetails(String LedgerId){
            List<Contact_Payment__c>  listOfPayments = new List<Contact_Payment__c>([SELECT Branch__c,DD_Number__c,Drawn_on_Bank_Name__c,FUA_Amount__c,Ledger__c,FUA_Bank_Ref_No__c,Failure_Message__c,
            FUA_Order_Id__c,FUA_Order_Status__c,FUA_Payment_Mode__c,FUA_Tracking_Id__c,Id,Paid_By__c,Payment_Date__c 
            FROM Contact_Payment__c where Ledger__c =:LedgerId limit 1]);
            return listOfPayments;
    }
        
    public List<Ledger__c> paymentDetail(String LedgerId){
            List<Ledger__c>  listOfPayments = new List<Ledger__c>([Select Id,Name,Description__c,Amount__c,Type__c,Paid__c From Ledger__c  limit 1]);
            return listOfPayments;
    }







}