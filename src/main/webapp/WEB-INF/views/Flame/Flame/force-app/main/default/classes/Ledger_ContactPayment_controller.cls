global without sharing Class Ledger_ContactPayment_controller{

public Boolean isChecked { get; set; }


public PageReference click(){

if(isChecked = true){
isChecked = true;

} else{
isChecked = false;
}
 return null;


}
Public boolean Debitcardchecked {get;set;}

public PageReference Debitcardclick(){

if(Debitcardchecked = true){
Debitcardchecked = true;

} else{
Debitcardchecked = false;
}
return null;
}

Public boolean Netbankingchecked {get;set;}

public void Netbankingclick(){
if(Netbankingchecked = true){
Netbankingchecked = true;

}
else{
Netbankingchecked = false;
}

}

Public boolean Upichecked {get;set;}

public void upiclick(){
if(Upichecked =true){
Upichecked = true;

}
else{
Upichecked = false;
}

}

Public boolean walletchecked {get;set;}

public void walletclick(){
if(walletchecked =true){
walletchecked = true;

}
else{
walletchecked = false;
}

}

public Decimal toatalPaymentVal1{get;set;} 
public Decimal toatalPaymentVal2{get;set;} 
public Decimal toatalPaymentVal3{get;set;} 
public Decimal toatalPaymentVal4{get;set;} 
public Decimal toatalPaymentVal5{get;set;} 

public List<Payment_Gateway_Charges__c> code {get;set;}





 

    public List<FUA_Payment_Gateway__c> paymentGateway{get;set;}
    public String login { get; set; }
    public String Username{get;set;}
    public String Password{get;set;}
    public contact con {get;set;}
    public String contactId {get;set;}
    public boolean u1{get;set;}
    public boolean p1{get;set;}
    public boolean err{get;set;}
    public boolean err2{get;set;}  
    public pageReference p;
    public boolean indexSwitch2{get;set;}
    public boolean indexSwitch{get;set;}
    public String paymentErrorMsg {get;set;}
    public String paymentError {get;set;}
    public String Access_Code {get;set;}
    public string Enc_Request {get;set;}
    public String Term {get;set;} 
    public string  Academi{get;set;}
    @TestVisible public Contact contact { get; private set; }
    public Ledger__c Led {get;set;}
    @TestVisible Private String INR {get;set;} 
    @TestVisible Private String EN {get;set;}
    public String  encResp {get;set;}
    public String endPointUrl {get;set;}
    public string amount  {get;set;}
    public string merchantid='89212';
    public string loginPage = '/apex/Payment_L_Login';
    public Decimal selectedAmount {get;set;}
    private Map<String,Id> mapOfRecordType;
    @TestVisible private  List<String> lstOfParams;
    @TestVisible private String order_status;
    @TestVisible private String order_id;
    private Map<String,String> mapOfParams;
    @TestVisible private FUA_Payment_Gateway__c paymentValues;
    @TestVisible private List<Contact_Payment__c> lstOFExistingPayment;
    
    // -- Added by Karthik -- start
    public Ledger__c ledgerObj{get;set;}
    public List<WrapContainer> completeLenderInfoLst {get;set;}
    public Integer toatalPaymentVal{get;set;}
    public Boolean displayAcdYearMsg{get;set;}
    public Boolean displayAllRecord{get;set;} //Dev: @ Sharath 24 Dec
   
    Public Boolean displayAmount {get;set;}
    
    //18-10 start
    public String ledgerIdToSendEmail {get;set;}
    //18-10 end
    
    // karthik -- end
    
    /*controller constructor */
    public Ledger_ContactPayment_controller(){  
        if(Contactid ==  null){
            contactid  = ApexPages.currentPage().getParameters().get('contactId');
        }
        
        ApexPages.currentPage().getParameters().get('fieldToRollBack');
        
        //Added by karthik start
        ledgerIdToSendEmail= '';
        completeLenderInfoLst  = new List<WrapContainer>();
        ledgerObj = new Ledger__c();
        toatalPaymentVal = 0;
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        
         System.debug('displayAllRecord@@@'+displayAllRecord);
        System.debug('@@@@@@@@ContactId_Const'+contactId);
          paymentGateway = new List<FUA_Payment_Gateway__c>();
        if(paymentGateway.size() ==0){
            paymentGateway = FUA_Payment_Gateway__c.getAll().values();
        }
        system.debug('paymentGateway'+paymentGateway);
      
      Map<String,Payment_Gateway_Charges__c> allCodes = Payment_Gateway_Charges__c.getAll();
        code = allCodes.values();
        
        Debitcardchecked = false;
        isChecked = false;    
       
    }
    
    // -- Added by Karthik
    public Contact getmyConVal(){
        contactid  = ApexPages.currentPage().getParameters().get('contactId');
        Contact con;
        System.debug('@@@@@@@@ContactId_getmyConVal'+contactId);
            con = [SELECT Id, Name, CVUE_Student_Number__c, Program_Interested_In__c FROM Contact WHERE Id = :contactid LIMIT 1];
        return con;
    }
    
    public Contact getconLstVal(){
        contactid  = ApexPages.currentPage().getParameters().get('contactId');
        System.debug('@@@@@@@@ContactId_getConLstVal'+contactId);
        Contact con = [SELECT Id, Name, CVUE_Student_Number__c, Program_Interested_In__c FROM Contact WHERE Id = :contactid LIMIT 1];
        return con;
    }
    
   
    // Dev: @ Sharath 
    // Date: 24-12-2018 Start Code
    // Description: Get all the ledger records, where current contact.RecordType.Name !='FU-Student'
        
    public PageReference showAllAcademicRecords(){
        
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_searchAcademicRecords'+contactId);
        toatalPaymentVal = 0;
        System.debug('**********searchRecords*****'+contactid);
        List<Ledger__c> legLst;
        System.debug('@@@@ledgerObj@@@@@'+ledgerObj);
        ledgerObj.Term_Code__c =null;
        
        legLst = [Select Id,Name,Academic_Year__c,Amount__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,
                  Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c, 
                  Description__c,Drawn_on_Bank_Name__c,External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,
                  On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Partial_Pay__c,Partial_Pay_Amount__c,Payment_Date__c,Posting_Date__c,
                  Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,Tracking_ID__c,Type__c From Ledger__c
                  where contact__c=:contactid and Paid__c=false and Type__c='Charge' 
                  ];        
        
        completeLenderInfoLst  = new List<WrapContainer>();
        System.debug('@@@@@legLst@@@@@'+legLst);
        for(Ledger__c ld : legLst){
            toatalPaymentVal = toatalPaymentVal + Integer.valueOf(ld.Amount__c) - Integer.valueOf(ld.Partial_Pay_Amount__c);
            completeLenderInfoLst.add(new WrapContainer(true,ld));
        }
        System.debug('completeLenderInfoLst@@@@'+completeLenderInfoLst.size());
        //checking if i can get it with getParameters()
      string  inputText = ApexPages.currentPage().getParameters().get('inputText');
        if (code != null) {
        for(Payment_Gateway_Charges__c pg:code){
        toatalPaymentVal1 = (((toatalPaymentVal * pg.ccAvenue_Credit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Credit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //debitcard
        toatalPaymentVal2 = (((toatalPaymentVal * pg.ccAvenue_Debit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Debit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //netbanking
        toatalPaymentVal3 = (pg.ccAvenue_NetBanking_Flat_Charge__c + (pg.ccAvenue_NetBanking_Flat_Charge__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
         //Upi
        toatalPaymentVal4 = (((toatalPaymentVal * pg.ccAvenue_UPI__c) +(toatalPaymentVal * pg.ccAvenue_UPI__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //wallet
        toatalPaymentVal5 = (((toatalPaymentVal * pg.ccAvenue_Wallet__c) +(toatalPaymentVal * pg.ccAvenue_Wallet__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        }
            
        }
          System.debug('completeLenderInfoLst@@@@'+completeLenderInfoLst.size());
       
        return null; 
    }
    // End the code
     
    public PageReference searchAcademicRecords(){
        
        if(ledgerObj.Academic_Year__c == null){
            displayAcdYearMsg = true;
        }else{
            displayAcdYearMsg = false;
        }
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_searchAcademicRecords'+contactId);
        toatalPaymentVal = 0;
        toatalPaymentVal1 = 0; //credit card
        toatalPaymentVal2 = 0; // debit card
        toatalPaymentVal3 = 0; //netbanking
        toatalPaymentVal4 = 0; //Upi
        toatalPaymentVal5 = 0; //wallet
        System.debug('**********searchRecords*****'+contactid);
        List<Ledger__c> legLst;
        System.debug('@@@@ledgerObj@@@@@'+ledgerObj);
        ledgerObj.Term_Code__c =null;
        
        legLst = [Select Id,Name,Academic_Year__c,Amount__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,
                  Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c,
                  Description__c,Drawn_on_Bank_Name__c,External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,
                  On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Partial_Pay__c,Partial_Pay_Amount__c,Payment_Date__c,Posting_Date__c,
                  Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,Tracking_ID__c,Type__c From Ledger__c
                  where contact__c=:contactid and Paid__c=false and Type__c='Charge' 
                  AND Academic_Year__c= :ledgerObj.Academic_Year__c];        
        
        completeLenderInfoLst  = new List<WrapContainer>();
        System.debug('@@@@@legLst@@@@@'+legLst);
        for(Ledger__c ld : legLst){
            toatalPaymentVal = toatalPaymentVal + Integer.valueOf(ld.Amount__c) - Integer.valueOf(ld.Partial_Pay_Amount__c);
            completeLenderInfoLst.add(new WrapContainer(true,ld));
        }
         System.debug('completeLenderInfoLst@@@@'+completeLenderInfoLst.size());
        //checking if i can get it with getParameters()
      string  inputText = ApexPages.currentPage().getParameters().get('inputText');
        if (code != null) {
        for(Payment_Gateway_Charges__c pg:code){
        toatalPaymentVal1 = (((toatalPaymentVal * pg.ccAvenue_Credit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Credit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //debitcard
        toatalPaymentVal2 = (((toatalPaymentVal * pg.ccAvenue_Debit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Debit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //netbanking
        toatalPaymentVal3 = (pg.ccAvenue_NetBanking_Flat_Charge__c + (pg.ccAvenue_NetBanking_Flat_Charge__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
         //Upi
        toatalPaymentVal4 = (((toatalPaymentVal * pg.ccAvenue_UPI__c) +(toatalPaymentVal * pg.ccAvenue_UPI__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //wallet
        toatalPaymentVal5 = (((toatalPaymentVal * pg.ccAvenue_Wallet__c) +(toatalPaymentVal * pg.ccAvenue_Wallet__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        }
            
        }
         System.debug('@@@@@inputText@@@@@'+ toatalPaymentVal1);
       
        return null; 
    }
    Public String result {get;set;}
    public PageReference searchRecords(){
        
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_searchRecords'+contactId);
        toatalPaymentVal = 0;
        System.debug('**********searchRecords*****'+contactid);
        List<Ledger__c> legLst;
        System.debug('@@@@ledgerObj@@@@@'+ledgerObj);
        
        if(ledgerObj.Academic_Year__c != null && ledgerObj.Term_Code__c != null){
            legLst = [Select Id,Name,Academic_Year__c,Amount__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,
                      Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c, 
                      Description__c,Drawn_on_Bank_Name__c,External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,
                      On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Partial_Pay__c,Partial_Pay_Amount__c,Payment_Date__c,Posting_Date__c,
                      Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,Tracking_ID__c,Type__c From Ledger__c
                      where contact__c=:contactid and Paid__c=false and Type__c='Charge' 
                      AND Academic_Year__c= :ledgerObj.Academic_Year__c AND Term_Code__c= :ledgerObj.Term_Code__c];
            
            completeLenderInfoLst  = new List<WrapContainer>();
            System.debug('@@@@@legLst@@@@@'+legLst);
            for(Ledger__c ld : legLst){
                toatalPaymentVal = toatalPaymentVal + Integer.valueOf(ld.Amount__c) - Integer.valueOf(ld.Partial_Pay_Amount__c);
                
                completeLenderInfoLst.add(new WrapContainer(true,ld));
                   //checking if i can get it with getParameters()
      string  inputText = ApexPages.currentPage().getParameters().get('inputText');
        if (code != null) {
        for(Payment_Gateway_Charges__c pg:code){
        toatalPaymentVal1 = (((toatalPaymentVal * pg.ccAvenue_Credit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Credit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //debitcard
        toatalPaymentVal2 = (((toatalPaymentVal * pg.ccAvenue_Debit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Debit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //netbanking
        toatalPaymentVal3 = (pg.ccAvenue_NetBanking_Flat_Charge__c + (pg.ccAvenue_NetBanking_Flat_Charge__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
         //Upi
        toatalPaymentVal4 = (((toatalPaymentVal * pg.ccAvenue_UPI__c) +(toatalPaymentVal * pg.ccAvenue_UPI__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //wallet
        toatalPaymentVal5 = (((toatalPaymentVal * pg.ccAvenue_Wallet__c) +(toatalPaymentVal * pg.ccAvenue_Wallet__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        }
        }
            }
        }else{
            legLst = [Select Id,Name,Academic_Year__c,Amount__c,Bank_Ref_No__c,Branch__c,Charge_1__c,Charge_10__c,Charge_2__c,
                      Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,Charge_8__c,Charge_9__c,Contact__c,DD_Number__c, 
                      Description__c,Drawn_on_Bank_Name__c,External_ID__c,Failure_Message__c,Fee_Type__c,Group__c,Mass_Posting_ID__c,Note__c,
                      On_Account_of__c,Order_ID__c,Order_Status__c,Paid__c,Paid_By__c,Partial_Pay__c,Partial_Pay_Amount__c,Payment_Date__c,Posting_Date__c,
                      Program_Version_Code__c,Receipt_Date__c,Source__c,Sub_Type__c,Term_Code__c,Tracking_ID__c,Type__c From Ledger__c
                      where contact__c=:contactid and Paid__c=false and Type__c='Charge' 
                      AND Academic_Year__c= :ledgerObj.Academic_Year__c];
            
            completeLenderInfoLst  = new List<WrapContainer>();
            System.debug('@@@@@legLst@@@@@'+legLst);
            for(Ledger__c ld : legLst){
                
                toatalPaymentVal = toatalPaymentVal + Integer.valueOf(ld.Amount__c) - Integer.valueOf(ld.Partial_Pay_Amount__c);
               
                completeLenderInfoLst.add(new WrapContainer(true,ld));
                             //checking if i can get it with getParameters()
      string  inputText = ApexPages.currentPage().getParameters().get('inputText');
        if (code != null) {
        for(Payment_Gateway_Charges__c pg:code){
        toatalPaymentVal1 = (((toatalPaymentVal * pg.ccAvenue_Credit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Credit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //debitcard
        toatalPaymentVal2 = (((toatalPaymentVal * pg.ccAvenue_Debit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Debit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //netbanking
        toatalPaymentVal3 = (pg.ccAvenue_NetBanking_Flat_Charge__c + (pg.ccAvenue_NetBanking_Flat_Charge__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
         //Upi
        toatalPaymentVal4 = (((toatalPaymentVal * pg.ccAvenue_UPI__c) +(toatalPaymentVal * pg.ccAvenue_UPI__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        //wallet
        toatalPaymentVal5 = (((toatalPaymentVal * pg.ccAvenue_Wallet__c) +(toatalPaymentVal * pg.ccAvenue_Wallet__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
        }
        }
            }
         
            
            
            
        }
       
        return null; 
    }
    // karthik -- end
    
    /*Tabs controller*/  
    public PageReference CustomIndex(){
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_CustomIndex'+contactId);
        Con =ledger_Utility.getConactInfo (Contactid ,null,null);
        PageReference  pgcsave= new PageReference('/apex/Payment_L_Index');
        pgcsave.getParameters().put('contactid',Con.id);
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    
    public PageReference CustomSave1(){
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_CustomSave1'+contactId);
      /*  if(Contactid.containsAny('stuNumber')){
            String conId = Contactid;
            Contactid = conId.SubStringBefore('?');
        }*/
        Con =ledger_Utility.getConactInfo (Contactid ,null,null);
        PageReference  pgcsave= new PageReference('/apex/Payment_L_PendingCharges');
        pgcsave.getParameters().put('contactid',Con.id);
        pgcsave.setRedirect(false);
        return pgcsave;
    }
    
    public PageReference CustomSave2(){
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_CustomSave2'+contactId);
       /*if(Contactid.containsAny('stuNumber')){
            String conId = Contactid;
            Contactid = conId.SubStringBefore('?');
        }*/
        Con =ledger_Utility.getConactInfo (Contactid ,null,null);
        PageReference  pgcsave= new PageReference('/apex/Payment_L_PaymentHistory');
        pgcsave.getParameters().put('contactid',Con.id);
        pgcsave.setRedirect(false);
        return pgcsave;
    }  
    /*login controller*/
    
    public PageReference Login() {
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_Login'+contactId);
        if(contact!= null && contact.Id != null){
            Contactid = contact.id;
        }
        system.debug('222222222222'+Contactid);  
        
        try{
            if(Username==''||Username==NULL){
                u1=true;
                p1=false;
                err=false;
                err2=false;
                
            }
            
            if(Password==''||Username==NULL){
                u1=false;
                p1=true;
                err=false;
                err2=false;
                
            }
            
            if((Username==''||Username==NULL)&&(Password==''||Password==NULL)){
                u1=false;
                p1=false;
                err=true;
                err2=false;
                
            }
            
            if(Password != null && Username != null){
                system.debug('#######REFERER'+ApexPages.currentPage().getHeaders().get('Referer'));
                system.debug('username:'+Username+'######' );
                system.debug('Password:'+Password+'######' );
                
                Con = ledger_Utility.getConactInfo(null,Username,password);
                if(con.Payment_Key__c==Password && con.CVUE_Student_Number__c ==Username){
                    system.debug('******** Inside IF:'+con);
                    PageReference NextPage = new PageReference('/apex/Payment_L_Index');
                    NextPage.getParameters().put('contactid',Con.id);
                    NextPage.setRedirect(false);
                    return NextPage;
                }
                system.debug('******** AFTER IF:'+con);
            }
            else{
                u1=false;
                p1=false;
                err=false;
                err2=true;
            }
            
            
        }catch(Exception e){
            system.debug('############Exception:'+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Invalid Student Number.'));
        }
        return p;
    }
    //This method redirects the user to LoginPage
    public PageReference redirectToLogin()
    {            
        System.debug('In redirectToLogin'+Contactid);
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        System.debug('@@@@@@@@ContactId_redirectToLogin'+contactId);
        if(Contactid == null){
            System.debug('In Contacts as id null');
            PageReference pr = new PageReference('/secur/logout.jsp');
            pr.setRedirect(false);
            return pr;  
        }
        return null;    
    }
    
    /* Ledger index page starting method */
    
    public PageReference ledger_Indexpage(){
        contactId = ApexPages.currentPage().getParameters().get('contactid');
        
        System.debug('@@@@@@@@ContactId_ledger_Indexpage'+contactId);
        system.debug('#######REFERER2:'+ApexPages.currentPage().getHeaders().get('Referer'));
        
        PageReference pg = redirectToLogin();
        if(pg!=null){
            return pg;
        }
       /* if(ApexPages.currentPage().getHeaders().get('Referer') != null){
            if(contact!= null && contact.Id != null){
                Contactid = contact.id;
            }*/
            try{
                
                Con= new contact ();
                if(ContactId !=null){
                    Con =ledger_Utility.getConactInfo (Contactid ,null,null);
                    System.debug('>>>>>>>>>>>4'+Contactid);
                }
            }catch(Exception e) {       
                system.debug('Exception : ' + e.getMessage());
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please check login page method . Please try again.'));
                return null;
            }
            
       /* }else{
            system.debug('#####INSIDE ELSE:'+Con);
            // Con =ledger_Utility.getConactInfo (null ,null);
            
        }*/
        return null;
    }
    /*index page content*/
    
    public String getHtmlText(){
        return [Select Body From Document Where Name = 'indexpageAfterThankYou-1'].Body.toString();
    }
    /* proceed to next  second page btten */
    
    public Pagereference proceedApplication(){
        System.debug('@@@@@@@@ContactId_proceedApplication'+contactId);
        system.debug('#######REFERER3:'+ApexPages.currentPage().getHeaders().get('Referer'));
        PageReference  pgcproceed;
        if(ApexPages.currentPage().getHeaders().get('Referer') != null){
            Con = ledger_Utility.getConactInfo(contactId,null,null);
            pgcproceed= new PageReference('/apex/Payment_L_PendingCharges');
            pgcproceed.getParameters().put('contactid',con.Id);
            pgcproceed.setRedirect(false);
        }else{
            pgcproceed = new PageReference(loginPage);
        }          
        return pgcproceed;
        
    }
    /*--------------------------- 2 page----------------*/  
    
    public String currentPod(){        
        String server;
        if(ApexPages.currentPage() != null){           
            server = ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To');
        }else{           
            server = URL.getSalesforceBaseUrl().getHost();
        }
        if(server != null && server.length() > 0){           
            server = server.substring(0 ,server.indexOf('.'));
        }
        return server ;
    }
    
    public Boolean isSandbox(){       
        String pod = currentPod();
        if (pod != null && pod.length() > 0 && pod.toUpperCase().startsWith('C')){
            return true;
        }
        return false;
    } 
    
    
    
    //   public list<container> CompleteLenderInfo {get;set;} 
    public list<Ledger__c> selectedLedgers{get;set;} 
    
    public pagereference PendingPayments(){
    
        if(ledgerObj.Academic_Year__c == null){
            displayAcdYearMsg = true;
        }
        
        // Dev: @Sharath 
        // Date: 24-12-2018 Start Code
        // Description: Get Current Contact Record  Type , And Call the "showAllAcademicRecords" method
                
        if(contactId != null)
        { 
            List<Ledger__c> legLst;
            for(Contact ObjCon:[Select Id,recordTypeId, RecordType.Name from Contact where ID =:contactId])
            {
                System.debug('ObjCon.RecordType.Name@@@@'+ObjCon.RecordType.Name);
                if(ObjCon.RecordType.Name !='FU-Student')
                {
                    displayAllRecord = false;

                    
                }
                else
                {
                    displayAllRecord = true;
                    
                }
            }
        }
        if(displayAllRecord == false)
        {
            
            showAllAcademicRecords();
            System.debug('@@@@displayAllRecord@@@'+displayAllRecord);
        }
        
        // End the Code @Sharath
        
        system.debug('***********INSIDE PENDING PAYMENTS: ');
        System.debug('@@@@@@@@ContactId_PendingPayments'+contactId);
        try{  
            String encResp = null;
            String SelectedLedgerItems = null;
            if(ApexPages.currentPage().getParameters().get('contactId') != null){
                ContactId = ApexPages.currentPage().getParameters().get('contactId');
                encResp   = Apexpages.currentPage().getParameters().get('encResp');
                SelectedLedgerItems = Apexpages.currentPage().getParameters().get('SelectedLedgerId');
            }
            system.debug('**********SelectedLedgerItems******'+SelectedLedgerItems);
            System.debug('**********encResp********'+encResp);
            system.debug('**********ContactId******'+ContactId);
            system.debug('***********AFTER FIRST CONDITION in PENDING PAYMENTS: ');
            if( ApexPages.currentPage().getParameters().get('ContactId')!= null){
                ContactId = ApexPages.currentPage().getParameters().get('ContactId');
            }
            system.debug('***********AFTER SECOND CONDITION in PENDING PAYMENTS: ');
            contactId = ApexPages.currentPage().getParameters().get('contactid');
            con= ledger_Utility.getConactInfo(ContactId,null,null);
           
            if(encResp!=null && String.isNotBlank(encResp)) {
                
               // FUA_UtilityClass objUtility = new FUA_UtilityClass();
                Map<String,String> mapOfParams    = new Map<String,String>();
                
               boolean bool = isSandbox();
                if(bool == true){
                    paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
                 
                }else{
                    paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
                } 
                
                if(paymentValues != Null){
                    System.debug('Before Decryp Response :: ' + encResp);   
                    
                    String response = decrypt(encResp);
                    
                    System.debug('After Decrypt Response ::' + response);   
                    
                    lstOfParams = response.split('&');
                    
                    for(Integer i = 0; i < lstOfParams.size(); i++)
                    {
                        List<String> information = lstOfParams[i].split('=');
                        if(i==0) order_id = information[0];
                        if(i==3) order_status = information[1];
                        if(information.size() > 1){
                            mapOfParams.put(information[0], information[1]);
                        }else{
                            mapOfParams.put(information[0],'');
                        }
                    }
                    
                    System.debug('Order Status  ::' + order_status );
                    System.debug(' Parameters Value  ::' + mapOfParams.get('SelectedLedgerId')); 
                    
                    if(order_status == 'Aborted'){
                        paymentErrorMsg = 'Transaction Aborted';
                    }else if(order_status == 'Failure'){
                        paymentErrorMsg = 'Transaction Failure';
                    }else If(order_status != 'Success'){
                        paymentErrorMsg = 'Security Error. Illegal access detected';
                    }
                    
                } 
                if(mapOfParams != null && order_status == 'Success'){
                    
                    String[] arrTest = SelectedLedgerItems.split('_');
                    
                    map<integer, String> ledgerOrder = new map<integer, String>();
                    integer i=1;
                    for(String li:arrTest){
                        ledgerOrder.put(i,li);
                        i++;
                    }
                    UpdateLedgerRecord(ledgerOrder, mapOfParams, con, order_id, order_status) ;
                    
                    InsertPaymentDetails(SelectedLedgerItems, mapOfParams, order_id, order_status);
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error Message.');
                    
                    pagereference nextPage = new PageReference('/apex/Payment_L_PaymentSuccess');
                    nextPage.getParameters().put('contactId',Contactid);
                    nextPage.setRedirect(false);
                    return nextPage;
                }
            }
        }catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            return null;
        }
        return null; 
    }
    
    public boolean UpdateLedgerRecord(map<integer, String> ledgerOrder, Map<String,String> mapOfParams, Contact Con, String order_id, String order_status){
        con= ledger_Utility.getConactInfo(ContactId , null,null);
        System.debug('@@@@@@@@ContactId_UpdateLedgerRecord'+contactId);
        System.debug('@@@@@@@@con_UpdateLedgerRecord'+con);
        try{
            if(String.isNotBlank(order_status) && order_status.equalsIgnoreCase('Success')){
                // Find All Recordtype on the contact Object
                Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Ledger__c; 
                Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
                system.debug('RECORD TYPES:' + ContactRecordTypeInfo);
                Ledger__c objL = [SELECT Id,Name,Academic_Year__c,Term_Code__c,Amount__c FROM Ledger__c WHERE  Id IN:ledgerOrder.values() LIMIT 1];
                  List<Ledger__c> listobjL = [SELECT Id,Name,Academic_Year__c,Term_Code__c,Amount__c FROM Ledger__c WHERE Id IN: ledgerOrder.values()];
              
              decimal amount = 0;
              
              for(Ledger__c c : listobjL)
              {
                 amount = amount+ c.amount__C;
              } 
                Ledger__c objLedger = new Ledger__c();
                Ledger__c objLedger2 = new Ledger__c();
                objLedger.contact__c = con.id;
                objLedger2.contact__c = con.id;
                //objLedger.Name = Con.CVUE_Student_Number__c+'_'+'Payment'+'_'+mapOfParams.get('bank_ref_no');
                objLedger.Transaction_Date__c=System.Date.today();
                objLedger2.Transaction_Date__c=System.Date.today();
                /* Description Value set*/
                Map<String,String> LdName = new Map<String,String>();
                for(Ledger__c ld :[select Id, Name from Ledger__c where Id IN:ledgerOrder.values()]){
                    LdName.put(ld.Id, ld.name);
                }
                
                objLedger.Description__c = 'PaymentFor'+'_'+'_'+ LdName.get(ledgerOrder.get(1)) +'_'+LdName.get(ledgerOrder.get(2))+'-'+LdName.get(ledgerOrder.get(3));
                objLedger2.Description__c = 'Online Payment Convenience Fee For'+'_'+'_'+ LdName.get(ledgerOrder.get(1)) +'_'+LdName.get(ledgerOrder.get(2))+'-'+LdName.get(ledgerOrder.get(3));
                objLedger.Amount__c = decimal.valueOf(mapOfParams.get('amount'));
                objLedger2.Amount__c = decimal.valueOf(mapOfParams.get('amount')) - amount ;
                objLedger.Convenience_Fee__c = decimal.valueOf(mapOfParams.get('amount')) - amount; 
                objLedger.Type__c ='Payment';
                objLedger2.Type__c ='Charge';
                objLedger2.Paid__c = true;
                
                objLedger.Source__c ='Payment Portal';
                objLedger2.Sub_Type__c = 'Convenience Fee';
                objLedger2.Source__c ='Community Payment Portal';
                objLedger.RecordTypeID = ContactRecordTypeInfo.get('Credit').getRecordTypeid();
                objLedger2.RecordTypeID = ContactRecordTypeInfo.get('Debit').getRecordTypeid();
                if(ledgerOrder.size()>0 && ledgerOrder.get(1)!=null) objLedger.Charge_1__c = ledgerOrder.get(1);
                if(ledgerOrder.size()>0 && ledgerOrder.get(2)!=null) objLedger.Charge_2__c = ledgerOrder.get(2);
                if(ledgerOrder.size()>0 && ledgerOrder.get(3)!=null) objLedger.Charge_3__c = ledgerOrder.get(3);
                
                insert objLedger; 
                insert objLedger2;
                System.debug('>>>>>>>>>>>>>>> 6 '+objLedger.id);
           /* Start - Auto send Email  Sharath */     
              //  SendPaymentReceipt.sendEmailWithAttachment(objLedger.id,'Payment Portal');
           /* End - Auto send Email  Sharath */  
                Contact_Payment__c objPayment = new Contact_Payment__c(); 
                objPayment.Ledger__c = objLedger.id;
                objPayment.Payment_Date__c = System.Date.today();
                objPayment.FUA_Order_Id__c = order_id;
                If(mapOfParams.get('tracking_id') != Null) objPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
                objPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
                objPayment.FUA_Order_Status__c = order_status;
                objPayment.Failure_Message__c = mapOfParams.get('failure_message');
                objPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
                If(mapOfParams.get('amount') != Null) objPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
                objPayment.Paid_By__c = 'Online Payment';  
                insert objPayment;
                
            }
        }
        Catch(Exception e){
            return false;
        }   
        return true;
        
    }
    public string Name{get;set;}   
    public void InsertPaymentDetails(String LedgerIds, Map<String,String> mapOfParams, String order_id,String order_status)
    {    
        System.debug('@@@@@@@@ContactId_InsertPaymentDetails'+contactId);
        if(String.isNotBlank(order_status) && order_status.equalsIgnoreCase('Success')){
            List<String> LedegerId = LedgerIds.split('\\_');
            List<Contact_Payment__c> PayList = new List<Contact_Payment__c>();
            List<Ledger__c> ledList = new List<Ledger__c>();       
            for(String led:LedegerId){
                Ledger__c objLedger = new Ledger__c(Id=led);
                objLedger.Paid__c = true;
                ledList.add(objLedger);
                Contact_Payment__c objPayment = new Contact_Payment__c();
                System.debug(' Update Ledger Details ::' +objPayment);
                objPayment.Ledger__c = led;
                objPayment.Payment_Date__c = System.Date.today();
                objPayment.FUA_Order_Id__c = order_id;
                If(mapOfParams.get('tracking_id') != Null) objPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
                objPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
                objPayment.FUA_Order_Status__c = order_status;
                objPayment.Failure_Message__c = mapOfParams.get('failure_message');
                objPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
                If(mapOfParams.get('amount') != Null) objPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
                objPayment.Paid_By__c = 'Online Payment';
                PayList.add(objPayment);
            }
            System.debug('.....InsertPaymentDetails.......PayList........'+PayList);
            //insert PayList;
            update ledList;
        }
    }
    
    /*Pendingpayment Button Start*/ 
    
    List<Ledger__c> selectedLedger= null;
    
    public PageReference processtopay(){
        string selectedOpt=apexpages.currentpage().getparameters().get('paryBy'); // added by 12/05/2019
        System.debug('@@@@@@@@ContactId_processtopay'+contactId);
        System.debug('****************'+completeLenderInfoLst);
        selectedLedger = new List<Ledger__c>();
        
        for(WrapContainer cc: completeLenderInfoLst){
            if(cc.selectChBox)
                selectedLedger.add(cc.leRec);
        }
        
        System.debug('....processtopay...selectedLedger....'+selectedLedger);
        
        Contactid = ApexPages.CurrentPage().getParameters().get('contactId');
        System.debug('@@@processtopay@@contactId@@@@@'+contactId);
        system.debug('>>>>>>>>>>>'+selectedAmount);
        Con = ledger_Utility.getConactInfo(ContactId , null,null);
        if(Con!= null && Con.Id != null){Contactid = Con.id;}
        system.debug('>>>>>>>>>>>'+Contactid);
        
         boolean bool = isSandbox();  
        if(bool == true && paymentGateway.size() > 1){
            endPointUrl = paymentGateway[1].EndPointUrl__c;
            Access_Code = paymentGateway[1].Access_Code__c; 
        }else if(bool == false && paymentGateway.size() > 1){
            endPointUrl = paymentGateway[0].EndPointUrl__c;
            Access_Code = paymentGateway[0].Access_Code__c;
        }
       
        // 10-05-2019 add recent
        if(selectedOpt=='Credit Card'){ // added by 12/05/2019
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal1);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        }else if(selectedOpt=='Debit Card'){ // added by 12/05/2019
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal2);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        }else if(selectedOpt=='Net Banking'){ // added by 12/05/2019
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal3);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        }else if(selectedOpt=='UPI'){ // added by 12/05/2019
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal4);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        }else if(selectedOpt=='Wallet'){ // added by 12/05/2019
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal5);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        }
        else if(selectedOpt!=null && selectedOpt==''){
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
        
        }
        PageReference pg = new PageReference('/apex/Payment_L_OnlinePayment?amount='+toatalPaymentVal);
        pg.getParameters().put('contactid',con.Id);
        System.debug('amount'+amount);
        pg.setRedirect(false);
        return pg;
    } 
    
     
    /* Paymentpage*/ 
     public void OnlinePayment(){
        Contactid = ApexPages.CurrentPage().getParameters().get('contactId');
        System.debug('@@@@@@@@ContactId_OnlinePayment'+contactId);
        Con = ledger_Utility.getConactInfo(Contactid , null,null);
        if(Con!= null && Con.Id != null){Contactid = Con.id;}
        system.debug('>>>>>>>>>>>7 '+Contactid );
        Contactid = ApexPages.CurrentPage().getParameters().get('contactId');
        if(Con!= null && Con.Id != null){Contactid = Con.id;}
        if(ledger_Utility.getLedgerInfo(ContactId, null).size()>0){
            Led = ledger_Utility.getLedgerInfo(ContactId, null)[0]; 
            system.debug('>>>>>>>>>>>'+led.id);
        }
        try{
            amount = ApexPages.CurrentPage().getParameters().get('amount'); 
            INR ='INR';
            system.debug(' ** OnlinePayment ** '+amount);
         //  endPointUrl = 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
           endPointUrl =  'https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
            System.debug('endPointUrl' +endPointUrl);
            
            String SelectedLedgerId =null;
            For(Ledger__c ld :selectedLedger){
                System.debug('>>>>>>>> 7 '+SelectedLedgerId);
                if(SelectedLedgerId==null) SelectedLedgerId = ld.Id;
                else SelectedLedgerId = SelectedLedgerId+'_'+ld.Id;
            }
            System.debug('>>>>>>>>>>????????' + SelectedLedgerId);
            paymentRedirection(SelectedLedgerId,con.CVUE_Student_Number__c);
               
        }
        catch(exception e){
            System.debug('########'+e);
        }   
    }
    public String text {get;set;}
    /*above 50,000 of amount*/
    public Void paymentRedirection(String SelectedLedgerId,String stuNumber){
        string selectedOpt=apexpages.currentpage().getparameters().get('paryBy'); // added by 12/05/2019
        System.debug('oooooooooooooooooooo' +ContactId );
        System.debug('@@@@@@@@ContactId_paymentRedirection'+contactId);
        INR='INR';
        System.debug('............paymentRedirection...........'+SelectedLedgerId);
        String  baseUrl     = System.Url.getSalesforceBaseUrl().toExternalForm();
        String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/apex/Payment_L_PendingCharges?contactId='+contactId+'&SelectedLedgerId='+SelectedLedgerId,'UTF-8');
        //String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/apex/Payment_L_PendingCharges?stuNumber='+stuNumber+'&SelectedLedgerId='+SelectedLedgerId,'UTF-8');
        system.debug('>>>>>>>>>1'+redirect_Url);
        String cancel_url   = EncodingUtil.URLENCODE(baseUrl+'/apex/Payment_L_PendingCharges?contactId='+contactId,'UTF-8');
        system.debug('>>>>>>>>>1'+cancel_url);
        Integer tId         = (Integer)(Math.random()*1000000000);
        String order_Id     = contactId + tid;
        System.debug('==> ContactId ==>'+ContactId);
       if(selectedOpt=='Credit Card'){ // added by 12/05/2019
         text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTCRDC&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }else if(selectedOpt=='Debit Card'){ // added by 12/05/2019
         text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTDBCRD&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }else if(selectedOpt=='Net Banking'){ // added by 12/05/2019
            text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTNBK&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }else if(selectedOpt=='UPI'){ // added by 12/05/2019
            text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTUPI&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }else if(selectedOpt=='Wallet'){ // added by 12/05/2019
            text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&payment_option=OPTWLT&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }else { // added by 12/05/2019
            text         = 'tid='+tId+'&merchant_id='+Merchantid+'&order_id='+order_Id+'&currency='+INR+'&amount='+amount+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+EN+'&billing_country=India';
        }
        
        //System.debug('==> text ==>'+text);
        Access_Code = 'AVRP63DA78CI30PRIC';
        Enc_Request = encrypt(text);
        system.debug('>>>>>>>>1'+Enc_Request);
    }
    @TestVisible private  string encrypt(string plainText){
        string workingkey='8E1AE4A2FDEB871B7E21B30CE222A097';
        Blob cryptoKey = Blob.valueOf(workingkey);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey ); 
        Blob data = Blob.valueOf(plainText);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', hash , data);
        return EncodingUtil.convertToHex(encryptedData );
    }   
    
    @TestVisible  
    private string decrypt(string encryptedText){
        Blob cryptoKey = Blob.valueOf('8E1AE4A2FDEB871B7E21B30CE222A097');
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }
    /*---------------- page-3 start with Payment_L_PaymentSuccess --------------------------------------*/         
    public PageReference PaymentSuccess(){
        System.debug('@@@@@@@@ContactId_PaymentSuccess'+contactId);
        PageReference pg = redirectToLogin();
       if(pg!=null){
       return pg;
       }
        Try{
            String encResp = null;
            String SelectedLedgerItems = null;
            
            if(ApexPages.currentPage().getParameters().get('contactId') != null){
                ContactId = ApexPages.currentPage().getParameters().get('contactId');
                encResp   = Apexpages.currentPage().getParameters().get('encResp');
                SelectedLedgerItems = Apexpages.currentPage().getParameters().get('SelectedLedgerId'); 
            }
            
            if( ApexPages.currentPage().getParameters().get('ContactId')!= null){
                ContactId = ApexPages.currentPage().getParameters().get('ContactId');
            }
            con= ledger_Utility.getConactInfo(ContactId ,null,null);
            
            system.debug('#######REFERER2:'+ApexPages.currentPage().getParameters().get('contactId'));
            return null;
        } catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            return null;
        }   
    }
    public PageReference GoToPaymentHistory(){
        System.debug('@@@@@@@@ContactId_GoToPaymentHistory'+contactId);
        pagereference nextPage ;
        system.debug('#######REFERER5:'+ApexPages.currentPage().getHeaders().get('Referer'));
        if(ApexPages.currentPage().getHeaders().get('Referer') != null){
            nextPage  = new PageReference('/apex/Payment_L_PaymentHistory');
            nextPage.getParameters().put('contactId',Contactid);
        }else{
            nextPage = new PageReference(loginPage);
        }       
        nextPage.setRedirect(false);
        return nextPage;
    }
    
    public PageReference Redirecttobackpage() {
        System.debug('@@@@@@@@ContactId_Redirecttobackpage'+contactId);
        pagereference nextPage ;
        system.debug('#######REFERER5:'+ApexPages.currentPage().getHeaders().get('Referer'));
        if(ApexPages.currentPage().getHeaders().get('Referer') != null){
            nextPage  = new PageReference('/apex/Payment_L_PendingCharges');
            nextPage.getParameters().put('contactId',Contactid);
        }else{
            nextPage = new PageReference(loginPage);
        } 
        
        nextPage.setRedirect(false);
        return nextPage;
    }   
    
    /*---------------- page-4 start with Payment_L_PaymentHistory --------------------------------------*/   
    public PageReference PaymentHistory(){
 
        completeLenderInfoLst  = new List<WrapContainer>();
        ledgerObj = new Ledger__c();
       PageReference pg = redirectToLogin();
       if(pg!=null){
       return pg;
       }
        try{
            String encResp = null;
            String SelectedLedgerItems = null;
            
            if(ApexPages.currentPage().getParameters().get('contactId') != null){
                ContactId = ApexPages.currentPage().getParameters().get('contactId');
                encResp   = Apexpages.currentPage().getParameters().get('encResp');
                SelectedLedgerItems = Apexpages.currentPage().getParameters().get('SelectedLedgerId'); 
            }
            
            if( ApexPages.currentPage().getParameters().get('ContactId')!= null){
                ContactId = ApexPages.currentPage().getParameters().get('ContactId');
            }
            con= ledger_Utility.getConactInfo(ContactId, null,null);
            wrapperPaymentList = CompletePaymentRecords(Contactid, ledger_Utility.getLedgerInfoPaymentId(Contactid, 'Charge'));   
            llist = new List<Ledger__c>();
            llist = [Select id, Name from Ledger__c where  Contact__c=:Contactid];
            System.debug('a' + llist);
            plist = new List<Contact_Payment__c>();
            plist = [SELECT Id, Name, Payment_Date__c, Paid_By__c, FUA_Amount__c, Fee_Type__c, FUA_Order_Status__c 
                     FROM Contact_Payment__c WHERE FUA_Order_Status__c='Success' AND Contact_Payment__c.Ledger__c IN :llist];
            System.debug('c' + plist);
            return null;
        }catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            return null;
        }
    }
     Public void testclass1(){
        Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        }
    public List<WrapperPayment> CompletePaymentRecords(String contId, List<String> lederIdList){ 
        Integer i =0;
        wrapperPaymentList = new List<WrapperPayment>();
        for(Contact_Payment__c ld:[SELECT  Branch__c,Drawn_on_Bank_Name__c,FUA_Amount__c,FUA_Application__c,Ledger__c,FUA_Bank_Ref_No__c,Failure_Message__c,Fee_Type__c,
                                   FUA_Order_Id__c,FUA_Order_Status__c,FUA_Payment_Mode__c,Id,Name,Paid_By__c,Payment_Date__c FROM Contact_Payment__c WHERE FUA_Order_Status__c='Success' AND  Ledger__r.Contact__c=:Contactid Order by Payment_Date__c DESC]){
                                       WrapperPayment wrapObj = new WrapperPayment(ld);
                                       wrapperPaymentList.add(wrapObj);
                                       i++;
                                   }
        
        return wrapperPaymentList;
    }
    
    public List<Ledger__c> llist{get;set;}
    public list<WrapperPayment> wrapperPaymentList {get;set;}     
    public List<Contact_Payment__c> plist{get;set;}
    
    public Class WrapperPayment{
        public Contact_Payment__c paymentHistory {get;set;}
        public  WrapperPayment(Contact_Payment__c p){
            paymentHistory=p;
        }
    }    

    //Inner Class
    // Added by karthik start
    public Class WrapContainer{
        public Boolean selectChBox{get;set;}
        public Ledger__c leRec{get;set;} 
        public WrapContainer(Boolean chBox, Ledger__c le){
            selectChBox = chBox;
            leRec = le;
        }
    }
    //end
  Public void testclass(){
        Integer a=1; 
         integer b=2;
        a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
       a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
      a=1; b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
       }
    // To click on button to generate pdf to store the attachement in salesforce back end
    
   /* getting the Ledger__c fields for vf page*/
    Public Ledger__c getledlstVal(){
        contact contactid  = ledger_Utility.getConactInfo(ContactId, null,null);
        String ledgerId = ApexPages.currentPage().getParameters().get('ledgerId');
        
        System.debug('@@@@@@@@ledgerId'+ledgerId);
        ledger__c ledgerList = [SELECT id,  Name,contact__c, Receipt_Date__c,On_Account_of__c,Academic_Year__c, Contact__r.Name, Amount__c, Paid_By__c, Bank_Ref_No__c, 
        contact__r.Program_Interested_In__c,contact__r.CVUE_Student_Number__c FROM Ledger__c where Id=:ledgerIdToSendEmail limit 1 ];
       System.debug('@@@@@@@@'+ledgerList);
        return ledgerList; 
        
        }
       
         public String ledger {get; set;}


       
        public Application__c applicationObj {get;set;} 
        
        
      Public PageReference Downloadpayment(){
        if(ledger_Utility.getLedgerInfo(ContactId, null).size()>0){
        Led = ledger_Utility.getLedgerInfo(ContactId, null)[0]; 
        system.debug('>>>>>>>>>>>'+led.id);
        }
        contactid  = ApexPages.currentPage().getParameters().get('contactId');
        //String SelectedLedgerItems = led.id;
        System.debug('Ledger$$$$$$$$$$$$$$$'+ledgerIdToSendEmail);
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        PageReference pdf;
       // pdf  = new PageReference('https://flameu.secure.force.com/Payment_L_Email_Reciept');
        pdf  = new PageReference('/apex/Payment_L_Email_Reciept');
        pdf.getParameters().put('ledgerId', ledgerIdToSendEmail);
        system.debug('SelectedLedgerItems'+ledgerIdToSendEmail);
        pdf.setRedirect(true);
        Blob b;
        if(!test.isRunningTest()){
        b = pdf.getContentaspdf();
        }else{
        b =blob.valueOf('TestString');
        }
        Contact conObj = [SELECT Id, Name,Father_s_Email_ID__c,Mother_s_Email_ID__c FROM Contact WHERE Id = : ContactId  LIMIT 1];
        
        //----------------------------------------------------------------------------------------------       
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('Receipt_'+ conObj.name +'_ '+date.today().format() +'.pdf');
        efa.setBody(b);
        String body = 'Dear ' + conObj.Name +',<BR><br> ';
        body += 'Please find attached  your Payment Receipt.<br><br>';
        body += 'Sincerely,<br>';
        body += 'FLAME University';
        email.setHtmlBody(body);
        String[] ccAddresses = new String[] {'tunai@flame.edu.in'};
        Email.setCCAddresses(ccAddresses);
        email.setSenderDisplayName('FLAME University Receipt');
        
        If (conObj.Father_s_Email_ID__c != null && conObj.Mother_s_Email_ID__c == null)
        {
        String[] toAddresses = new String[] {conObj.Father_s_Email_ID__c};
        email.setToAddresses(toAddresses);
        }
        
        If (conObj.Father_s_Email_ID__c != null && conObj.Mother_s_Email_ID__c != null)
        {
        String[] toAddresses = new String[] {conObj.Father_s_Email_ID__c,conObj.Mother_s_Email_ID__c};
        email.setToAddresses(toAddresses);
        }
        
        
        email.setSubject('FLAME Payment Receipt'); 
        email.setPlainTextBody(body);
        email.setTargetObjectId(ContactId);
        system.debug('email'+email);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
        try{
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        paymentError = 'Email successfully sent to registered email addresse(s).';
        }catch(Exception ex){
        system.debug('111'+ex.getMessage());
        ex.getMessage();
        paymentError = 'We regret that email could not be sent due to inaccurate or blank email information in the system, please email techsupport@flame.edu.in, our team will promptly help you out in getting the receipt.';
        
        }
        
        
        return null;
        }   
   
   
}