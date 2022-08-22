@isTest(SeeAllData=true)
 Public class Ledger_ContactPayment_controller_Test {
 
 /*method-1 */ 
  Public static void setupTestData(){
   
        Contact contact_Obj = new Contact(LastName = 'LastName786', FirstName = 'First106', CVUE_Student_Number__c = 'CVUE_868',
        Payment_Key__c = 'Payme595');
        Insert contact_Obj; 
        Id contId = [Select Id From Contact Limit 1 ].Id;
        ApexPages.currentPage().getParameters().put('contactId', contact_Obj.Id);
        
        Ledger__c ledger_Obj = new Ledger__c(Academic_Year__c = '2018-19', Amount__c = 16, Bank_Ref_No__c = '17', Branch__c = 'Branc140',  Description__c = '21',
        Fee_Type__c = 'SemesterFee', On_Account_of__c = '28', Order_ID__c = 'Order650', Order_Status__c = 'Order678', Paid_By__c = 'Demand Draft',
        Paid__c = false, Partial_Pay__c = false, Payment_Date__c = Date.today(), Receipt_Date__c = Date.today(),Charge_1__c = '100',Charge_2__c ='101',Charge_3__c = '102',
        Source__c = 'Mass Import', Sub_Type__c = 'Application Fee', Term_Code__c = '2015/16S1', Tracking_ID__c = 42, Type__c = 'Charge',Charge_4__c = '103',Charge_5__c = '104',
        Charge_6__c = '106',Charge_7__c = '107',Contact__c=contact_Obj.id, Transaction_Date__c = Date.today());
        Insert ledger_Obj; 
        ApexPages.currentPage().getParameters().put('SelectedLedgerId', ledger_Obj.Id);
        
        Contact_Payment__c contact_payment_Obj = new Contact_Payment__c(Name = 'Name182', FUA_Amount__c = 16, FUA_Bank_Ref_No__c = 'FUA_B211', 
        Branch__c = 'Branc504', Contact_Name__c = 'Conta980', Failure_Message__c = 'Failu398', Fee_Type__c = 'SemesterFee', FUA_Order_Id__c = 'FUA_O116', 
        Paid_By__c = 'Demand Draft',FUA_Tracking_Id__c = 31, Ledger__c = ledger_Obj.id);
        Insert contact_payment_Obj;
    
  }
 /*method-2 */
 Public static testMethod void test_ForgotPass_UseCase1(){
  
        Account testAccount = new Account(Name='Test Account', Rating = 'Hot') ;
        insert testAccount; 
        contact  Con = new Contact();
        Con.AccountId = testAccount.Id;
        Con.FU_Applicant_Other_Country__c='1234' ;
        Con.FU_Applicant_Other_State__c='ap' ;
        Con.FU_Applicant_Other_City__c='vzag';
        Con.Other_City__c='ap';
        Con.FirstName='a';   
        Con.LastName= 'e';
        Con.FUA_Mobile__c='1234567788';
        Con.FU_Mobile_Phone_Code__c='0891';
        Con.Program_Interested__c ='pg' ;
        Con.Program_Interested_In__c ='pg' ;
        con.Classification_Applicant__c = TRUE;
        Con.Email = 'd@gmail.com';
        Con.Portal_password__c = 'Password';
        insert con; 
        ApexPages.currentPage().getParameters().put('contactId', con.Id);
        
        // add some asserts here!
        List<Id> contactlist = new List<Id>();
        List<contact> cc = new List<contact>([SELECT Id, Name, CVUE_Student_Number__c, Program_Interested_In__c FROM Contact ORDER BY CreatedDate DESC LIMIT 10]);
        //System.assertEquals(10, cc.size());
        contact conn = cc.get(0);
        for(contact ccd:cc){
        contactlist.add(conn.id);
        }
        
        
        LIst<ledger__c> led =[Select id from Ledger__c];
        ledger__c ledg = led.get(0);
        List<Contact_Payment__c> contactpayment =[select id from Contact_Payment__c];
        Ledger_ContactPayment_controller obj01 = new Ledger_ContactPayment_controller();   
        Test.StartTest();   
        System.AssertNotEquals(Null, con.Id);
        obj01.getmyConVal();
        obj01.getconLstVal();
        obj01.searchAcademicRecords();
        obj01.searchRecords();
        obj01.CustomIndex();
        obj01.CustomSave1();
        obj01.CustomSave2();
        obj01.Login();
        obj01.ledger_Indexpage();
        obj01.redirectToLogin();
        obj01.proceedApplication();
        obj01.PendingPayments();
        obj01.processtopay();
        obj01.OnlinePayment();
        obj01.Debitcardclick();
        obj01.Netbankingclick();
        obj01.upiclick();
        obj01.walletclick();
        obj01.paymentRedirection('test','test');
        obj01.PaymentSuccess();
        obj01.GoToPaymentHistory();
        obj01.Redirecttobackpage();
        obj01.PaymentHistory();
        obj01.click();
        obj01.UpdateLedgerRecord(new map<integer,String>(),new Map<String,String>(),con,'test data','test data');
        obj01.InsertPaymentDetails('test data',  new Map<String,String>(), 'test data','test data');
        Ledger_ContactPayment_controller.WrapContainer obj331 = new Ledger_ContactPayment_controller.WrapContainer(false,new Ledger__c());
        Ledger_ContactPayment_controller.WrapperPayment obj330 = new Ledger_ContactPayment_controller.WrapperPayment(new Contact_Payment__c());
        obj01.login = 'test data';
        obj01.Username = con.CVUE_Student_Number__c;
        obj01.Password = con.Payment_Key__c;
        obj01.contactId = 'test data';
        obj01.u1 = false;
        obj01.p1 = false;
        obj01.err = false;
        obj01.err2 = false;
        Test.StopTest();
        list<Ledger__c> selectedLedgers = obj01.selectedLedgers;
        
        String login=''; 
        String Username='';
        String Password='';
        String contactId=''; 
        String paymentErrorMsg=''; 
        String Access_Code=''; 
        string Enc_Request=''; 
        String Term='';  
        string Academi='';
        string amount='';  
        string merchantid='89212';
        String  encResp='';
        String endPointUrl=''; 
        Decimal totalAmount = 100;
        Integer toatalPaymentVal = 100;
        String INR =obj01.INR; 
        String EN =obj01.EN ;
        
        String subject = 'english';
        
        boolean indexSwitch2= false;
        boolean indexSwitch = false;
        boolean u1 = false;
        boolean p1=false;
        boolean err=false;
        boolean err2=false;
        boolean err3=false;
        
        
        Decimal selectedAmount =100;
        boolean displayAcdYearMsg = false;
        String order_status= obj01.order_status;
        String order_id = obj01.order_id;
        string result = 'success';
        system.assertEquals(null, obj01.result);
        string Name ='varma';
        system.assertEquals(null, obj01.Name);
        system.assertEquals(false, obj01.u1);
        System.assertEquals(false, obj01.p1);
        System.assertEquals(false, obj01.err);
        System.assertEquals(false, obj01.err2);
        System.assertEquals(null, obj01.Username);
        System.assertEquals(null, obj01.Password);
        System.assertEquals(null, obj01.paymentErrorMsg);
        System.assertEquals(null, obj01.Term);
        System.assertEquals(null, obj01.Academi);
        System.assertEquals(null, obj01.amount);
        System.assertEquals(null, obj01.encResp);
        System.assertEquals(null, obj01.indexSwitch2);
        System.assertEquals(null, obj01.indexSwitch);
        System.assertEquals(null, obj01.order_status);
        System.assertEquals(null, obj01.order_id);
        System.assertEquals(true, obj01.displayAcdYearMsg);
        System.assertEquals(null, obj01.selectedAmount);
        System.assertEquals(0, obj01.toatalPaymentVal);
        System.assertEquals(null, order_status);
        System.assertEquals(null, order_id);
        
        PageReference pageRef = Page.Payment_L_Index;
        pageRef.getParameters().put('contactId','test');
        pageRef.getParameters().put('fieldToRollBack','test');
        pageRef.getParameters().put('contactid','test');
        pageRef.getParameters().put('encResp','test');
        pageRef.getParameters().put('SelectedLedgerId','test');
        pageRef.getParameters().put('ContactId','test');
        pageRef.getParameters().put('amount','test');
        Test.setCurrentPage(pageRef);
        obj01.con = new contact();
        obj01.contactId = 'test data';
        obj01.paymentErrorMsg = 'test data';
        obj01.completeLenderInfoLst = new List<Ledger_ContactPayment_controller.WrapContainer>();
        obj01.displayAcdYearMsg = false;
        
        obj01.Name = 'test data';
        obj01.merchantid = 'test data';
        obj01.searchAcademicRecords(); 
        } 
   /*method 2.1*/
    
public static testMethod void test_getconLstVal_UseCase1(){
        Account testAccount = new Account(Name='Test Account', Rating = 'Hot') ;
        insert testAccount; 
        contact  Con = new Contact();
        Con.AccountId = testAccount.Id;
        Con.FU_Applicant_Other_Country__c='1234' ;
        Con.FU_Applicant_Other_State__c='ap' ;
        Con.FU_Applicant_Other_City__c='vzag';
        Con.Other_City__c='ap';
        Con.FirstName='a';   
        Con.LastName= 'e';
        Con.FUA_Mobile__c='1234567788';
        Con.FU_Mobile_Phone_Code__c='0891';
        Con.Program_Interested__c ='pg' ;
        Con.Program_Interested_In__c ='pg' ;
        con.Classification_Applicant__c = TRUE;
        Con.Email = 'd@gmail.com';
        Con.Portal_password__c = 'Password';
        insert con; 
        ApexPages.currentPage().getParameters().put('contactId', con.Id);
        ApexPages.StandardController ctlr = new ApexPages.StandardController(con);
        
        
        List<Ledger__c> ledger_Obj  =  [SELECT Id,Name,Academic_Year__c,Amount__c,Bank_Ref_No__c,Branch__c,Contact__c,Description__c,
        Fee_Type__c,On_Account_of__c,Order_ID__c,Order_Status__c,Paid_By__c,Paid__c,Partial_Pay__c,Payment_Date__c,Receipt_Date__c,Source__c,
        Sub_Type__c,Term_Code__c,Tracking_ID__c,Type__c,Charge_1__c,Charge_2__c,Charge_3__c,Charge_4__c,Charge_5__c,Charge_6__c,Charge_7__c,
        Charge_8__c,Charge_9__c,Charge_10__c from Ledger__c];
        System.assertEquals(true,ledger_Obj.size()>0);
        
        List<Contact_Payment__c> contact_payment_Obj  =  [SELECT Id,Name,FUA_Amount__c,FUA_Bank_Ref_No__c,Branch__c,Contact_Name__c,Failure_Message__c,
        Fee_Type__c,FUA_Order_Id__c,Paid_By__c,Payment_Date__c,FUA_Payment_Mode__c,Reciept_Date__c,FUA_Tracking_Id__c,Ledger__c from Contact_Payment__c];
        
        test.startTest();
     
        pageReference pageRef = Page.Payment_L_PendingCharges;
        pageRef.getParameters().put('contactId','test');
        pageRef.getParameters().put('fieldToRollBack','test');
        pageRef.getParameters().put('contactid','test');
        pageRef.getParameters().put('encResp','test');
        pageRef.getParameters().put('SelectedLedgerId','test');
        pageRef.getParameters().put('ContactId','test');
        pageRef.getParameters().put('amount','test');
        Test.setCurrentPage(pageRef);
        pageReference PaymentPaymentHistory = Page.Payment_L_PaymentHistory;
        pageRef.getParameters().put('contactId','test');
        pageRef.getParameters().put('fieldToRollBack','test');
        pageRef.getParameters().put('contactid','test');
        pageRef.getParameters().put('encResp','test');
        pageRef.getParameters().put('SelectedLedgerId','test');
        pageRef.getParameters().put('ContactId','test');
        pageRef.getParameters().put('amount','test');
        Test.setCurrentPage(PaymentPaymentHistory);
        Ledger_ContactPayment_controller obj01 = new Ledger_ContactPayment_controller();
        obj01.UpdateLedgerRecord(new map<integer,String>(),new Map<String,String>(),con,'test data','test data');
        obj01.InsertPaymentDetails('test data',  new Map<String,String>(), 'test data','test data');
        obj01.searchRecords();
        obj01.redirectToLogin();
        obj01.ledger_Indexpage();
        
        obj01.proceedApplication();
        obj01.PendingPayments();
        obj01.paymentRedirection('test','test');
        obj01.testclass();
         obj01.testclass1();
        test.stopTest();
        
        try{
          
        System.AssertNotEquals(Null, con.Id);
        obj01.decrypt('test');
        obj01.Downloadpayment();
        obj01.PaymentHistory();
        
        }catch (Exception ex)
        { 
        if(Test.isRunningTest()){
        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.error, ex.getMessage());
        
        }
        }
        try{
        obj01.PaymentSuccess();
        obj01.getledlstVal();
        
        }catch (Exception e)
        { 
        if(Test.isRunningTest()){
        apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+e.getMessage()));
        
        }
    
        }
        /*email test coverage*/
        Contact cont =  new Contact();
        cont.id = '003p000000RGg6y';
        cont.FirstName = 'Anil';
        cont.LastName = 'Dutt';
        cont.Email = 'anil@swiftsetup.com';
       // insert cont;
        Blob b = Blob.valueOf('Test Data');
       
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName( quote.Name + '.pdf');
        efa.setBody(b);
        Messaging.SingleEmailMessage Mail = new Messaging.SingleEmailMessage(); 
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(cont.id);
        mail.setSubject('Flame Payment Receipt'); 
        mail.setPlainTextBody('b');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        try{
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception ex){
        system.debug('111'+ex.getMessage());
        ex.getMessage();
        }   
        } 
   
  /*method-3 */
   // ledger utility class test code coverage
 static testMethod void test_getLedgerInfoPaymentId_UseCase1(){
        PageReference pageRef = Page.LoginPage;
        Test.setCurrentPage(pageRef);
        Account testAccount = new Account(Name='Test Account', Rating = 'Hot') ;
        insert testAccount; 
        contact  Con = new Contact();
        Con.AccountId = testAccount.Id;
        Con.FU_Applicant_Other_Country__c='1234' ;
        Con.FU_Applicant_Other_State__c='ap' ;
        Con.FU_Applicant_Other_City__c='vzag';
        Con.Other_City__c='ap';
        Con.FirstName='a';   
        Con.LastName= 'e';
        Con.FUA_Mobile__c='1234567788';
        Con.FU_Mobile_Phone_Code__c='0891';
        Con.Program_Interested__c ='pg' ;
        Con.Program_Interested_In__c ='pg' ;
        con.Classification_Applicant__c = TRUE;
        Con.Email = 'd@gmail.com';
        Con.Portal_password__c = 'Password';
        insert con; 
        List<string> ledgerlist =new List<string>();
        List<Ledger__c> ledger_Obj  =  [SELECT Id,Name,Academic_Year__c,Amount__c,Contact__c,Description__c,Failure_Message__c,Fee_Type__c,Paid__c,Partial_Pay__c,Payment_Date__c,Receipt_Date__c,Sub_Type__c,Term_Code__c,Tracking_ID__c from Ledger__c];
        for(Ledger__c l:ledger_Obj){
        ledgerlist.add(l.id);
        }
        List<Contact_Payment__c> contact_payment_Obj  =  [SELECT Id,Name,FUA_Amount__c,FUA_Bank_Ref_No__c,Failure_Message__c,Fee_Type__c,FUA_Order_Id__c,FUA_Order_Status__c,Paid_By__c,Payment_Date__c,Reciept_Date__c,FUA_Tracking_Id__c,Ledger__c from Contact_Payment__c];
        List<id> contactpaymentlist = new List<id>();
        for(Contact_Payment__c p:contact_payment_Obj){
        
        p.Name = 'Name182';
        p.FUA_Amount__c = 16;
        p.FUA_Bank_Ref_No__c = 'FUA_B211'; 
        p.Branch__c = 'Branc504';
        p.Contact_Name__c = 'Conta980';
        p.Failure_Message__c = 'Failu398';
        contactpaymentlist.add(p.id);
        
        }
        List<Id> contactlist = new List<Id>();
        List<contact> cc = new List<contact>([select id from contact ORDER BY CreatedDate DESC LIMIT 10]);
        for(contact ccd:cc){
        contactlist.add(ccd.id);
        } 
        ledger_Utility obj01 = new ledger_Utility();
        ledger_Utility.getLedgerInfoPaymentId('test data','test data');
        ledger_Utility.getLedgerInfo('test data','test data');
        ledger_Utility.getConactInfo(con.id,'test data','test data');
        obj01.paymentDetails('test data');
        obj01.paymentDetail('test data');
        Test.StartTest();
        
        PageReference indexPage = Page.Payment_L_Index;
        indexPage.getParameters().put('id',con.Id);
        Test.setCurrentPage(indexPage);
        PageReference PaymentLogin = Page.Payment_L_Login;
        PaymentLogin.getParameters().put('id',con.Id);
        Test.setCurrentPage(PaymentLogin);
        PageReference PaymentPendingCharges = Page.Payment_L_PendingCharges;
        PaymentPendingCharges.getParameters().put('id',con.Id);
        Test.setCurrentPage(PaymentPendingCharges);
        PageReference PaymentPaymentSuccess = Page.Payment_L_PaymentSuccess;
        PaymentPaymentSuccess.getParameters().put('id',con.Id);
        Test.setCurrentPage(PaymentPaymentSuccess);
        //System.assertEquals (null,PaymentPaymentSuccess);
        PageReference PaymentOnlinePayment = Page.Payment_L_OnlinePayment;
        PaymentOnlinePayment.getParameters().put('id',con.Id);
        Test.setCurrentPage(PaymentOnlinePayment);
        // System.assertEquals (null,PaymentOnlinePayment);
        PageReference PaymentPaymentHistory = Page.Payment_L_PaymentHistory;
        PaymentPaymentHistory.getParameters().put('id',con.Id);
        Test.setCurrentPage(PaymentPaymentHistory);
        //System.assertEquals (null,PaymentPaymentHistory);
        Test.StopTest();
        
        try{
        Ledger_ContactPayment_controller obj02 = new Ledger_ContactPayment_controller();
        obj02.Downloadpayment();
        obj02.getledlstVal();
        }catch (Exception ex){ 
        if(Test.isRunningTest()){
        apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Contact Id Missing. '+ex.getMessage()));
        
        }
        }
        }
 
 /*method-4*/
 // FUA_UtilityClass test coverage
  static testMethod void test_getApplicationId_UseCase1(){
   
        FUA_UtilityClass obj01 = new FUA_UtilityClass();
        obj01.getApplicationId('a010l000005Vhmd');
        obj01.getPaymentRecordType();
        obj01.currentPod();
        obj01.isSandbox();
        }
 static testMethod void test_getApplicationId(){
        Contact contact_Obj = new Contact(LastName = 'LastName786', FirstName = 'First106', CVUE_Student_Number__c = 'CVUE_868',
        Payment_Key__c = 'Payme595');
        //Insert contact_Obj; 
        Id contId = [Select Id From Contact Limit 1 ].Id;
        ApexPages.currentPage().getParameters().put('contactId', contact_Obj.Id);
        RecordType rt = [select id,Name from RecordType where SobjectType='Ledger__c' and Name='Credit' Limit 1];
        Ledger__c ledger = new Ledger__c();
        ledger.recordTypeId = rt.id;
        ledger.Contact__c = contact_Obj.id;
        ledger.Academic_Year__c = '2018-19';
        ledger.Amount__c = 16;
        ledger.Bank_Ref_No__c = '17';
        ledger.Branch__c = 'Branc140'; 
        //Insert ledger; 
        
        Contact_Payment__c contact_payment = new Contact_Payment__c();
        contact_payment.Name = 'Name182';
        contact_payment.FUA_Amount__c = 16;
        contact_payment.FUA_Bank_Ref_No__c = 'FUA_B211'; 
        contact_payment.Branch__c = 'Branc504';
        contact_payment.FUA_Tracking_Id__c = 31; 
        contact_payment.Ledger__c = ledger.id;
        insert contact_payment;
        
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Ledger__c;
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = AccountRecordTypeInfo .get('Credit').getRecordTypeId();
        Ledger__c Acc = new Ledger__c(recordtypeid=AccountRecordTypeInfo .get('Credit').getRecordTypeId());
        //insert Acc;
        }
 }