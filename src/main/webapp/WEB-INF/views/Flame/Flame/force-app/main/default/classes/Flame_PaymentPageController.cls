public class Flame_PaymentPageController{
    
    Public string filename {get;set;}
    public List<FUA_Payment_Gateway__c> paymentGateway{get;set;}
    public FUA_Payment_Gateway__c paymentValues{get;set;}
    public List<LedgerWrapper> LedgerWrapperList {get;set;}
    public List<LedgerWrapper> LedgerWrapperListone {get;set;}
    public List<Ledger__c> ledgerList{get;set;}
    public List<Ledger__c> totalLedgerList{get;set;}
    public List<Ledger__c> paymentLedgerList{get;set;}
    public String contactId {get;set;}
    
    public Decimal toatalPaymentVal{get;set;}
    public Decimal toatalPaymentVal1{get;set;}
    public Decimal toatalPaymentVal2{get;set;}
    public Decimal toatalPaymentVal3{get;set;}
    public Decimal toatalPaymentVal4{get;set;}
    public Decimal toatalPaymentVal5{get;set;}
    public Decimal toatalPaymentVal6{get;set;}
    public List<Payment_Gateway_Charges__c> charges {get;set;}
    public String totalPaymentValue{get;set;}
    Public string totalPaymentValue1 {get;set;}
    Public string totalPaymentValue2 {get;set;}
    Public string totalPaymentValue3 {get;set;}
    Public string totalPaymentValue4 {get;set;}
    Public string totalPaymentValue5 {get;set;}
    Public string totalPaymentValue6 {get;set;}
    public String endPointUrl{get;set;}
    public User objUser {get;set;}
    public Ledger__c objLedger {get;set;}
    public Boolean payBool {get;set;}
    public Boolean ledgerBool {get;set;}
    public List<Contact_Payment__c> paymentList{get;set;}
    public Contact objContact {get;set;}
    public String Enc_Request {get;set;}
    public String Access_Code {get;set;}
    public String paymentErrorMsg {get;set;}
    public String order_id;
    public String order_status {get;set;}
    public List<String> lstOfParams;
    public String totalHistoryPayment {get;set;}
    public Boolean backToPayment {get;set;}
    public String rId{get;set;}
    public static final String fullName = UserInfo.getName();
    public static final String firstName = UserInfo.getFirstName();
    public static final String lastName = UserInfo.getLastName();    
    public static final String profileName =  [SELECT Name FROM Profile WHERE id =: UserInfo.getProfileId()].Name;
    public static final String userName = UserInfo.getUserName();
    public static final String userEmail = UserInfo.getUserEmail();
    //Sharath created Date 12/11/2019
    public Boolean isStudent{get;set;}
    public Boolean isMeetingMinute{get;set;}
    public  map<String, Meeting_Minute_Show_Users_List__c> mapOfUserId;
    //Sharath created Date 12/11/2019
    Public boolean UserRegistrationchecked {get;set;} // use in flame_side bar vf compenent.
    
    public String Page {get; set;}
    public String OpenPageURL {get; set;}
     
    //Sharath added 25/01/2020
    /*
    public Boolean isRequisition {get;set;}  
    public  map<String, Requisition_User_List_Detail__c> mapOfReqUserId; 
	*/
    //Sharath added 25/01/2020 
    
    Public Boolean Staff_n_Faculty {get;set;} // added by Saheel
    
    public Flame_PaymentPageController(){
        Page = '' ;
     	OpenPageURL = '' ;
        LedgerWrapperList = new List<LedgerWrapper>();
        paymentList = new List<Contact_Payment__c>();
        objLedger = new Ledger__c();
        objContact = new Contact();
        objUser = new User();
        totalLedgerList = new List<Ledger__c>();
        paymentLedgerList = new List<Ledger__c>();
        endPointUrl = '';
        Enc_Request = '';
        Access_Code = '';      
        totalHistoryPayment  = '';
        backToPayment = false;
        ledgerBool = false;
        payBool = false;
        totalPaymentValue = '';
        totalPaymentValue1 = '';
        totalPaymentValue2 = '';
        totalPaymentValue3 = '';
        totalPaymentValue4 = '';
        totalPaymentValue5 = '';
        totalPaymentValue6 = '';
        Staff_n_Faculty = false; //added by saheel
        system.debug('objUser'+objUser);
        objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        system.debug('objUser--->'+objUser);
        if(objUser.ContactID != null){
            objContact = [SELECT Id,Name,RecordType.Name,AccountId,Primary_Contact_Type__c,Account.Name FROM Contact WHERE Id=:objUser.ContactId];
            ContactId = objContact.Id;
        }
        //Sharath created Date 12/11/2019
        else
        {
            ContactId  = ApexPages.currentPage().getParameters().get('conid');
        }
        
        if(objContact.RecordType.Name == 'FU-Student'){
            isStudent = true;
        }
        else{
            isStudent = false;
        }
        
        //----added by saheel-----
        if(objContact.Primary_Contact_Type__c == 'Faculty' || objContact.Primary_Contact_Type__c == 'Staff'){
            Staff_n_Faculty = true;
        }
        //----added by saheel-----
        
        
        mapOfUserId =  Meeting_Minute_Show_Users_List__c.getAll(); // this custom setting is used for storing User ID
        
        // Check If Current Login User Id contains in Custom setting then marked isStudent value as false
        // and Use this boolen value in VF Page
        System.debug('mapOfUserId@@'+mapOfUserId);
        System.debug('UserInfo.getUserId@@'+UserInfo.getUserId()); 
        if(mapOfUserId != null && mapOfUserId.size()>0){
            
            if(mapOfUserId.containsKey(UserInfo.getUserId().substring(0, 15)))
            {
                isMeetingMinute = true;
                System.debug('isMeetingMinute@@'+isMeetingMinute);
            }
        }   
        
        //Sharath added 25/01/2020
        /*
        mapOfReqUserId =  Requisition_User_List_Detail__c.getAll(); // this custom setting is used for storing User ID
        // Check If Current Login User Id contains in Custom setting then marked isStudent value as false
        // and Use this boolen value in VF Page
        System.debug('mapOfUserId@@'+mapOfUserId);
        System.debug('UserInfo.getUserId@@'+UserInfo.getUserId()); 
        if(mapOfReqUserId != null && mapOfReqUserId.size()>0){
            
            if(mapOfReqUserId.containsKey(UserInfo.getUserId().substring(0, 15)))
            {
                isRequisition = true;
                System.debug('isRequisition@@'+isRequisition);
            }
        }
        */
        // End //Sharath added 25/01/2020
        
        //Sharath created Date 12/11/2019
        toatalPaymentVal = 0;
        toatalPaymentVal1 = 0;
        toatalPaymentVal2 = 0;
        toatalPaymentVal3 = 0;
        toatalPaymentVal4 = 0;
        toatalPaymentVal5 = 0;
        toatalPaymentVal6 = 0;
        paymentGateway = new List<FUA_Payment_Gateway__c>();
        if(paymentGateway.size() ==0){
            paymentGateway = FUA_Payment_Gateway__c.getAll().values();
        }
        system.debug('paymentGateway'+paymentGateway);
        DescribeSObjectResult describeResultLedger = Ledger__c.getSObjectType().getDescribe();
        List<String> ledgerFieldNames = new List<String>(describeResultLedger.fields.getMap().keySet());
        String query = ' SELECT ' + String.join( ledgerFieldNames, ',' ) + ' FROM Ledger__c WHERE';
        query += ' Contact__c =: contactId';
        query += ' AND';
        String type = 'Charge';
        query += ' Type__c =: type';
        query += ' AND';
        boolean b = false;      
        query += ' Paid__c =: b';        
        ledgerList = Database.query(query); 
        
        // to get the customsetting values
        charges = New List<Payment_Gateway_Charges__c>(); 
        if(charges.size() ==0){
            charges = Payment_Gateway_Charges__c.getAll().values();
        }
        system.debug('charges'+charges);
        
        // to get the Register_Users__c custom setting values to get particular users
        List<Register_Users__c> registeredUsers = Register_Users__c.getall().values();//using the code in flame_side bar v.f page compnent.
        UserRegistrationchecked = false;
        for( Register_Users__c regUser : registeredUsers){
            if (regUser.User_Name__c == UserInfo.getName()) {
                UserRegistrationchecked = true;      // render Registration tab to specific users only
            }
        }     
    }      
    
    public String getFullName(){        
        return fullName;
    }
    /* payment gateway charges methodes*/
    
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
    Public boolean RuPaychecked {get;set;}
    public void RuPayDebitcardclick(){
        if(RuPaychecked =true){
            RuPaychecked = true;
            
        }
        else{
            RuPaychecked = false;
        }
        
        
    }
    
    
    
    public void Search(){   
        paymentErrorMsg = '';
        toatalPaymentVal =0; 
        ledgerList = new List<Ledger__c>();   
        LedgerWrapperList = new List<LedgerWrapper>();
        LedgerWrapperListone = new List<LedgerWrapper>();
        DescribeSObjectResult describeResultLedger = Ledger__c.getSObjectType().getDescribe();
        List<String> ledgerFieldNames = new List<String>(describeResultLedger.fields.getMap().keySet());
        String query = ' SELECT ' + String.join( ledgerFieldNames, ',' ) + ' FROM Ledger__c WHERE';
        query += ' Contact__c =: contactId';
        query += ' AND';
        String type = 'Charge';
        query += ' Type__c =: type';
        query += ' AND';
        boolean b = false;      
        query += ' Paid__c =: b';
        
        
        String ledger = objLedger.Academic_Year__c;
        String term = objLedger.Term_Code__c;
        
        if(objLedger.Academic_Year__c!= null &&  objLedger.Academic_Year__c!= '' && objLedger.Term_Code__c == null){
            query += ' AND';
            query += ' Academic_Year__c =: ledger Order By CreatedDate Asc LIMIT 10';
        }
        if(objLedger.Term_Code__c !=null &&  objLedger.Term_Code__c != '' && objLedger.Academic_Year__c == null){
            query += ' AND'; 
            query += ' Term_Code__c =: term Order By CreatedDate Asc LIMIT 10'; 
        } 
        
        if(objLedger.Term_Code__c != '' && objLedger.Term_Code__c != null && objLedger.Academic_Year__c != '' && objLedger.Academic_Year__c != null){
            query += ' AND'; 
            query += ' Academic_Year__c =: ledger';
            query += ' AND'; 
            query += ' Term_Code__c =: term Order By CreatedDate Asc LIMIT 10'; 
        }       
        ledgerList = Database.query(query); 
        for(Ledger__c objledger : ledgerList){
            // toatalPaymentVal= toatalPaymentVal + objledger.Amount__c;
            toatalPaymentVal = toatalPaymentVal + Integer.valueOf(objledger.Amount__c) - Integer.valueOf(objledger.Partial_Pay_Amount__c);
            LedgerWrapperList.add(new LedgerWrapper(true,objledger));
            LedgerWrapperListone.add(new LedgerWrapper(true,objledger));            
        }
        
        system.Debug('success till now');
        string  inputText = ApexPages.currentPage().getParameters().get('inputText');
        if (charges != null) {
            for(Payment_Gateway_Charges__c pg:charges){
                system.debug(pg.ccAvenue_Wallet__c +', '+ pg.ccAvenue_Wallet__c);
                toatalPaymentVal1 = (((toatalPaymentVal * pg.ccAvenue_Credit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Credit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
                totalPaymentValue1 = String.valueOf(toatalPaymentVal1);
                //debitcard 
                toatalPaymentVal2 = (((toatalPaymentVal * pg.ccAvenue_Debit_Card__c) +(toatalPaymentVal * pg.ccAvenue_Debit_Card__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
                totalPaymentValue2 = String.valueOf(toatalPaymentVal2);
                //netbanking
                toatalPaymentVal3 = (pg.ccAvenue_NetBanking_Flat_Charge__c + (pg.ccAvenue_NetBanking_Flat_Charge__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
                totalPaymentValue3 = String.valueOf(toatalPaymentVal3);
                //Upi
                toatalPaymentVal4 = (((toatalPaymentVal * pg.ccAvenue_UPI__c) +(toatalPaymentVal * pg.ccAvenue_UPI__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
                totalPaymentValue4 = String.valueOf(toatalPaymentVal4);
                //wallet
                toatalPaymentVal5 = (((toatalPaymentVal * pg.ccAvenue_Wallet__c) +(toatalPaymentVal * pg.ccAvenue_Wallet__c) * pg.ccAvenue_GST__c) /100 + toatalPaymentVal).setScale(0);
                totalPaymentValue5 = String.valueOf(toatalPaymentVal5);
                //RuPay
                toatalPaymentVal6 = (pg.ccAvenue_RuPayDebit_Card__c + (pg.ccAvenue_RuPayDebit_Card__c*pg.ccAvenue_GST__c) + toatalPaymentVal).setScale(0);
                totalPaymentValue6 = String.valueOf(toatalPaymentVal6);
            }
        } 
        totalPaymentValue = toatalPaymentVal.format();
        totalPaymentValue1 = toatalPaymentVal1.format();
        totalPaymentValue2 = toatalPaymentVal2.format();
        totalPaymentValue3 = toatalPaymentVal3.format();
        totalPaymentValue4 = toatalPaymentVal4.format();
        totalPaymentValue5 = toatalPaymentVal5.format();
        totalPaymentValue6 = toatalPaymentVal6.format();
        if(objLedger.Term_Code__c == null && objLedger.Academic_Year__c == null){
            LedgerWrapperList = new List<LedgerWrapper>();
        }
        
    } 
    
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
    
    public pagereference PendingPayments(){
        try{      
            objContact = new Contact();
            String encResp = '';         
            List<String> SelectedLedgerItems1 = new List<String>();
            if(contactId != null){
                objContact = [SELECT Id, Name
                              FROM Contact WHERE Id=: contactId];
                encResp   = Apexpages.currentPage().getParameters().get('encResp');  
                system.debug('encResp'+encResp);                       
            } 
            system.debug('#######REFERER3:'+ApexPages.currentPage().getHeaders().get('Referer'));  
            SelectedLedgerItems1.add(Apexpages.currentPage().getParameters().get('SelectedLedgerId'));
            List<String> s1 = new List<String>();   
            for(String s : SelectedLedgerItems1){            
                if(s != null && s.contains('(')){
                    s = s.replace('(','');
                }
                if(s!= null && s.contains(')')){
                    s = s.replace(')','');
                }
                if(s != null && s.contains(' ')){                 
                    s = s.replace(' ','');  
                }
                if(s!= null)
                    s1= s.split(',');
            }   
            List<String> SelectedLedgerItems = new List<String>();
            SelectedLedgerItems.addAll(s1); 
            
            if(encResp !=null && String.isNotBlank(encResp)) {                           
                Map<String,String> mapOfParams  = new Map<String,String>();
                boolean bool = isSandbox();
                if(bool == true){
                    paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
                }else{
                    paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
                } 
                String response = '';
                if(paymentValues != null){  
                    if(!Test.isrunningTest()){
                        response = decrypt(encResp);  
                    }else{
                        response = 'Success';
                    }
                    lstOfParams = response.split('&');                    
                    for(Integer i = 0; i < lstOfParams.size(); i++){
                        List<String> information = lstOfParams[i].split('=');
                        if(i==0) order_id = information[0];
                        if(i==3) order_status = information[1];
                        if(information.size() > 1){
                            mapOfParams.put(information[0], information[1]);
                        }else{
                            mapOfParams.put(information[0],'');
                        }
                        system.debug('information '+information[0]);
                    }                                
                    if(order_status == 'Aborted'){
                        payBool = true;
                        paymentErrorMsg = 'Transaction Aborted';
                    }else if(order_status == 'Failure'){
                        payBool = true;
                        paymentErrorMsg = 'Transaction Failure';
                    }else if(order_status != 'Success'){
                        payBool = true;
                        paymentErrorMsg = 'Security Error. Illegal access detected';
                    }                  
                } 
                if(mapOfParams != null && order_status == 'Success'){  
                    UpdateLedger(SelectedLedgerItems, mapOfParams, order_id, order_status);             
                    InsertPaymentDetails(SelectedLedgerItems, mapOfParams, objContact, order_id, order_status) ;                                      
                    //backToPayment = true;
                    pagereference nextPage = new PageReference('/apex/Flame_PaymentSuccess');
                    nextPage.getParameters().put('contactId',Contactid);
                    nextPage.setRedirect(true);
                    return nextPage;                                          
                    // return null;
                }             
            }
        }catch(Exception e){
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
            system.debug('Line--->'+e.getLineNumber());
            system.debug('Line--->'+e.getmessage());
            return null;
        }
        return null; 
    }
    
    
    
    public void UpdateLedger(List<String>LedgerIds, Map<String,String> mapOfParams, String order_id,String order_status)
    {    
        if(String.isNotBlank(order_status) && order_status.equalsIgnoreCase('Success') && LedgerIds.size() >0){
            List<Ledger__c> ledList = new List<Ledger__c>();
            for(String led:LedgerIds){
                Ledger__c objLedger = new Ledger__c();
                objLedger.Id = led;
                objLedger.Paid__c = true;
                ledList.add(objLedger);             
            }
            if(!ledList.isEmpty()){
                update ledList;
            }             
        }
    }
    //created Date 12/18/2019 Kartheek
    
    public boolean InsertPaymentDetails(List<String> ledgerOrder, Map<String,String> mapOfParams, Contact Con, String order_id, String order_status){
        try{
            if(String.isNotBlank(order_status) && order_status.equalsIgnoreCase('Success') && ledgerOrder.size() >0){   
                
                Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Ledger__c; 
                Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();            
                Ledger__c objL = [SELECT Id,Name,Academic_Year__c,Term_Code__c,Amount__c FROM Ledger__c WHERE Id IN: ledgerOrder LIMIT 1];
                
                List<Ledger__c> listobjL = [SELECT Id,Name,Academic_Year__c,Term_Code__c,Amount__c FROM Ledger__c WHERE Id IN: ledgerOrder];
                
                decimal amount = 0;
                
                for(Ledger__c c : listobjL)
                {
                    amount = amount+ c.amount__C;
                } 
                
                Ledger__c objLedger = new Ledger__c();
                Ledger__c objLedger2 = new Ledger__c();
                objLedger.contact__c = con.id;     
                objLedger2.contact__c = con.id;   
                objLedger.Posting_Date__c=System.Date.today();
                objLedger2.Posting_Date__c=System.Date.today();
                objLedger.Payment_Date__c = System.Date.today();
                objLedger2.Payment_Date__c = System.Date.today();
                objLedger.Receipt_Date__c=System.Date.today();
                objLedger2.Receipt_Date__c=System.Date.today();
                objLedger.Paid_By__c = 'Online Payment';
                objLedger2.Paid_By__c = 'Online Payment';
                objLedger.Academic_Year__c = objL.Academic_Year__c;
                objLedger2.Academic_Year__c = objL.Academic_Year__c;
                objLedger.Term_Code__c = objL.Term_Code__c;
                objLedger2.Term_Code__c = objL.Term_Code__c;                
                objLedger.Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
                objLedger2.Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
                objLedger.Source__c = 'Community Payment Portal';
                objLedger2.Source__c = 'Community Payment Portal';
                /* Description Value set*/              
                Map<String,String> LdName = new Map<String,String>();
                for(Ledger__c ld :[select Id, Name from Ledger__c where Id IN : ledgerOrder]){                
                    LdName.put(ld.Id, ld.name);
                }                                    
                objLedger.Description__c = 'Payment for'+'_'+'_';
                objLedger2.Description__c = 'Online Payment Convenience Fee for'+'_'+'_';
                for(String s : ledgerOrder){                  
                    objLedger.Description__c += LdName.get(s)+'__'; 
                    objLedger2.Description__c += LdName.get(s)+'__'; 
                }
                objLedger.Description__c = objLedger.Description__c.removeEnd('__'); 
                objLedger2.Description__c = objLedger2.Description__c.removeEnd('__');
                
                if(!Test.isRunningTest()){
                    objLedger.Amount__c = decimal.valueOf(mapOfParams.get('amount'));
                    objLedger2.Amount__c = decimal.valueOf(mapOfParams.get('amount')) - amount ;
                    objLedger.Convenience_Fee__c = decimal.valueOf(mapOfParams.get('amount')) - amount;
                }
                else{
                    objLedger.Amount__c = 0.0;
                    objLedger2.Amount__c = 0.0;
                    objLedger.Convenience_Fee__c = 0.0;
                }
                objLedger.Type__c ='Payment';
                objLedger2.Type__c ='Charge';
                objLedger2.Paid__c = true;
                objLedger2.Source__c = 'Community Payment Portal';
                objLedger2.Sub_Type__c = 'Convenience Fee';
                objLedger.RecordTypeID = ContactRecordTypeInfo.get('Credit').getRecordTypeid();
                objLedger2.RecordTypeID = ContactRecordTypeInfo.get('Debit').getRecordTypeid();
                integer j = 0;
                for(integer i=0;i<ledgerOrder.size();i++){                          
                    j++;                    
                    String s = 'Charge_'+j+'__c';
                    objLedger.put(s,ledgerOrder[i]);
                    objLedger2.put(s,ledgerOrder[i]);                    
                }
                system.debug('objledger' + objledger);
                system.debug('objledger2' + objledger2);
                if(objLedger != null)
                {
                    insert objLedger;
                    insert objLedger2;
                    
                }
                
                
                Contact_Payment__c objPayment = new Contact_Payment__c(); 
                objPayment.Ledger__c = objLedger.id;
                objPayment.Payment_Date__c = System.Date.today();
                objPayment.FUA_Order_Id__c = order_id;
                if(mapOfParams.get('tracking_id') != null) objPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
                objPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
                objPayment.FUA_Order_Status__c = order_status;
                objPayment.Failure_Message__c = mapOfParams.get('failure_message');
                objPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
                if(mapOfParams.get('amount') != null) objPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
                objPayment.Paid_By__c = 'Online Payment';  
                if(objPayment != null){
                    insert objPayment;
                }                
            }
        }
        Catch(Exception e){           
            system.debug('Message--->'+e.getMessage());
            system.debug('Line Number--->'+e.getLineNumber());
            return false;
        }   
        return true;
        
    }   
    //created Date 12/18/2019 Kartheek - End 
    
    public PageReference processtopay(){
        string selectedOpt=apexpages.currentpage().getparameters().get('paryBy'); 
        boolean bool = isSandbox();  
        if(bool == true && paymentGateway.size() > 1){
            endPointUrl = paymentGateway[1].EndPointUrl__c;
            Access_Code = paymentGateway[1].Access_Code__c; 
        }else if(bool == false && paymentGateway.size() > 1){
            endPointUrl = paymentGateway[0].EndPointUrl__c;
            Access_Code = paymentGateway[0].Access_Code__c;
        }
        if(selectedOpt=='Credit Card'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal1);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
            return pg;
        }else if(selectedOpt=='Debit Card'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal2);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
        }else if(selectedOpt=='Net Banking'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal3);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
        }else if(selectedOpt=='UPI'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal4);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
        }else if(selectedOpt=='Wallet'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal5);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
        }else if(selectedOpt=='RuPayDebit Card'){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal6);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
            
        }else if(selectedOpt!=null && selectedOpt==''){
            PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal);
            pg.getParameters().put('contactid',ContactId);
            pg.getParameters().put('contactid',ContactId);
            pg.setRedirect(false);
        }
        PageReference pg = new PageReference('/apex/Flame_OnlinePayment?amount='+toatalPaymentVal);
        pg.getParameters().put('contactid',ContactId);
        pg.getParameters().put('contactid',ContactId);
        pg.setRedirect(false);
        return pg;
        
    } 
    
    public void OnlinePayment(){
        List<String> SelectedLedgerId = new List<String>();
        try{
            for(LedgerWrapper wrap: LedgerWrapperList){
                if(wrap.checkbox)               
                    SelectedLedgerId.add(wrap.objLedger.Id);
            }
            paymentRedirection(SelectedLedgerId);       
        }
        catch(exception e){
            System.debug('########'+e);
        }   
    }
    
    public Void PaymentRedirection(List<String> SelectedLedgerId){ 
        string selectedOpt=apexpages.currentpage().getparameters().get('paryBy');
        String body = '';
        String  baseUrl     = System.Url.getSalesforceBaseUrl().toExternalForm();
        String redirect_Url = EncodingUtil.URLENCODE(baseUrl+'/apex/Flame_PaymentPage?contactId='+contactId+'&SelectedLedgerId='+SelectedLedgerId,'UTF-8');       
        String cancel_url   = EncodingUtil.URLENCODE(baseUrl+'/apex/Flame_PaymentPage?contactId='+contactId,'UTF-8');      
        Integer tId         = (Integer)(Math.random()*1000000000);
        String order_Id     = contactId + tid; 
        if(selectedOpt=='Credit Card'){ 
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal1+'&redirect_url='+redirect_Url+'&payment_option=OPTCRDC&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }else if(selectedOpt=='Debit Card'){
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal2+'&redirect_url='+redirect_Url+'&payment_option=OPTDBCRD&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }else if(selectedOpt=='RuPayDebit Card'){
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal2+'&redirect_url='+redirect_Url+'&payment_option=OPTDBCRD&card_name=RuPay&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
            
        }else if(selectedOpt=='Net Banking'){ 
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal3+'&redirect_url='+redirect_Url+'&payment_option=OPTNBK&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }else if(selectedOpt=='UPI'){ 
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal4+'&redirect_url='+redirect_Url+'&payment_option=OPTUPI&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }else if(selectedOpt=='Wallet'){  
            body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal5+'&redirect_url='+redirect_Url+'&payment_option=OPTWLT&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }else { 
            body =  body = 'tid='+tId+'&merchant_id='+paymentGateway[0].Merchant_Id__c+'&order_id='+order_Id+'&currency='+paymentGateway[0].FUA_Currency__c+'&amount='+toatalPaymentVal+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+paymentGateway[0].FUA_Language__c+'&billing_country=India';
        }       
        Enc_Request = EncryptBody(body);
        
    }
    
    public String EncryptBody(String body){
        Blob cryptoKey = Blob.valueOf(paymentGateway[0].Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey ); 
        Blob data = Blob.valueOf(body);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', hash , data);
        return EncodingUtil.convertToHex(encryptedData);
    }
    
    public  string decrypt(string encryptedText){
        Blob cryptoKey = Blob.valueOf(paymentGateway[0].Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }
    
    public pageReference PaymentHistory(){   
        
        
        
        //List<String> sList = new List<String>();
        paymentList = new List<Contact_Payment__c>();
        
        DescribeSObjectResult describeResultPayment = Contact_Payment__c.getSObjectType().getDescribe();
        List<String> paymentFieldNames = new List<String>(describeResultPayment.fields.getMap().keySet());
        /*for(String s : paymentFieldNames){
system.debug('s---->'+s);
if(s != 'RecordtypeId'){
system.debug('s******>'+s);
sList.add(s);
}
}*/
        
        String query1 = ' SELECT ' + String.join( paymentFieldNames, ',' ) + ' FROM Contact_Payment__c WHERE';
        query1 += ' Ledger__r.Contact__c =: contactId';
        query1 += ' AND';
        String msg = 'Success';
        query1 += ' FUA_Order_Status__c =: msg ';
        query1 += ' Order by Payment_Date__c Desc';            
        paymentList = Database.query(query1); 
        return null;
        
    }
    
    public void myLedgers(){
        DescribeSObjectResult describeResultLedger = Ledger__c.getSObjectType().getDescribe();
        List<String> ledgerFieldNames = new List<String>(describeResultLedger.fields.getMap().keySet());
        String query = ' SELECT ' + String.join( ledgerFieldNames, ',' ) + ' FROM Ledger__c WHERE';
        query += ' Contact__c =: contactId';      
        query += ' AND';
        String type = 'Debit';
        query += ' RecordType.Name =: type Order By Posting_Date__c Desc';
        totalLedgerList = Database.query(query); 
        Decimal d = 0;
        for(Ledger__c obj : totalLedgerList){
            d += obj.Amount__c;
        }        
        
        DescribeSObjectResult describeResultLedger1 = Ledger__c.getSObjectType().getDescribe();
        List<String> ledgerFieldNames1 = new List<String>(describeResultLedger1.fields.getMap().keySet());
        String query1 = ' SELECT ' + String.join( ledgerFieldNames1, ',' ) + ' FROM Ledger__c WHERE';
        query1 += ' Contact__c =: contactId';      
        query1 += ' AND';
        String types = 'Credit';
        query1 += ' RecordType.Name =: types Order By Payment_Date__c Desc';                      
        paymentLedgerList = Database.query(query1);     
        
        Decimal d1 = 0;
        for(Ledger__c obj : paymentLedgerList){
            d1 += obj.Amount__c;
        } 
        Decimal d2 = d - d1;
        totalHistoryPayment = d2.format();            
    }
    
    public pageReference BacktoPaymentHistory(){
        backToPayment = false;
        PaymentHistory();
        return new PageReference('/apex/Flame_PaymentHistoryPage');                    
    }
    
    public pageReference DownloadTemplate(){
        
        objLedger = new Ledger__c();
        objLedger =  [SELECT Id, Name, Receipt_Date__c, Contact__c,On_Account_of__c,Academic_Year__c, Contact__r.Name, Amount__c, Paid_By__c, Bank_Ref_No__c,Ledger__c.Term_Code__c,
                      contact__r.Program_Interested_In__c,contact__r.CVUE_Student_Number__c,Convenience_Fee__c FROM Ledger__c where Id = :rid];
        /*Add the kartheek varma ticket NO:scp:110 */               
        String fileName = 'Receipt_' + objLedger.Contact__r.Name+' _' +objLedger.contact__r.CVUE_Student_Number__c + '.pdf';
        Apexpages.currentPage().getHeaders().put('content-disposition',  'attachment; filename=' + fileName);              
        pagereference templatePage = new PageReference('/apex/Flame_PaymentTemplate');      
        templatePage.setRedirect(false);
        return templatePage;                    
    }
    
    public class LedgerWrapper{
        public Boolean checkbox{get;set;}
        public Ledger__c objLedger{get;set;} 
        public LedgerWrapper(Boolean checkbox, Ledger__c objLedger){
            this.objLedger = objLedger;
            this.checkbox = checkbox;
        }
    }
    
     public void redirect()
    {
        if(Page == 'google')
        {
            OpenPageURL = 'https://my.flame.edu.in/apex/WR_BPM__DataEditLtng?formId=a4T0K00000WRX5BUAX';
              //  OpenPageURL = 'https://techila-flame.cs74.force.com/0030p00000OgM0F';
        }
    }

}