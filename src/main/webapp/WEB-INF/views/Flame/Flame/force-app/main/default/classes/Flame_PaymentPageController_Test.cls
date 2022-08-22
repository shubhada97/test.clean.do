@isTest
public class Flame_PaymentPageController_Test {
    
    public static testmethod void ValidatePaymentMethod(){
        
        User objUser;
        Id pId;
        Id cId;       
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'Student'];
            User portUser = new User();
            portUser.ProfileId = studPro.Id;
            portUser.Username = 'test1test@test.com';
            portUser.Alias = 'test';
            portUser.Email = 't1@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
        }       
        objUser = [SELECT ID, Profile.Name, profileId FROM User WHERE Id =: pId LIMIT 1];
        Ledger__c ledger_Obj = new Ledger__c(Academic_Year__c = '2018-19', Amount__c = 16, Bank_Ref_No__c = '17', Branch__c = 'Branc140',  Description__c = '21',
                                             Fee_Type__c = 'SemesterFee', On_Account_of__c = '28', Order_ID__c = 'Order650', Order_Status__c = 'Order678', Paid_By__c = 'Demand Draft',
                                             Paid__c = false, Partial_Pay__c = false, Payment_Date__c = Date.today(), Receipt_Date__c = Date.today(),
                                             Source__c = 'Mass Import', Sub_Type__c = 'Application Fee', Term_Code__c ='2018/19S1', Tracking_ID__c = 42, Type__c = 'Charge',Contact__c=cId, Transaction_Date__c = Date.today());
        Insert ledger_Obj; 
        List<FUA_Payment_Gateway__c> paymentList = new List<FUA_Payment_Gateway__c>();
        FUA_Payment_Gateway__c objPayment = new FUA_Payment_Gateway__c();
        objPayment.Name = 'Payment Details For SandBox';
        objPayment.Access_Code__c = 'AVRP63DA78CI30PRIC';
        objPayment.FUA_Amount__c = 1500.00;
        objPayment.FUA_Currency__c = 'INR';
        objPayment.EndPointUrl__c = 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
        objPayment.FUA_Language__c = 'EN';
        objPayment.Working_Key__c = '8E1AE4A2FDEB871B7E21B30CE222A097';
        Insert objPayment;
        paymentList.add(objPayment);   
        
        List<Payment_Gateway_Charges__c> paymentchargeslist = new List<Payment_Gateway_Charges__c>();
        Payment_Gateway_Charges__c chargepayment = new Payment_Gateway_Charges__c();
        chargepayment.Name = 'Payment Charges';
        chargepayment.ccAvenue_Credit_Card__c =1.10;
        chargepayment.ccAvenue_Debit_Card__c = 0.900;
        chargepayment.ccAvenue_GST__c = 0.18;
        chargepayment.ccAvenue_NetBanking_Flat_Charge__c = 20.00;
        chargepayment.ccAvenue_UPI__c = 0.75;
        chargepayment.ccAvenue_Wallet__c = 0.5;
        chargepayment.ccAvenue_RuPayDebit_Card__c = 0;
        Insert chargepayment;
        paymentchargeslist.add(chargepayment);   
        
        Apexpages.currentPage().getParameters().put('encResp','Success');
        ApexPages.currentPage().getHeaders().put('X-Salesforce-Forwarded-To','com.');
        Apexpages.currentPage().getParameters().put('SelectedLedgerId',ledger_Obj.Id);
        Apexpages.currentPage().getParameters().get('inputText');
        Flame_PaymentPageController objFlamePaymentPageController = new Flame_PaymentPageController();
        objFlamePaymentPageController.PendingPayments();
        objFlamePaymentPageController.contactId = cId;
        objFlamePaymentPageController.objUser = objUser;
        objFlamePaymentPageController.objLedger = ledger_Obj;
        objFlamePaymentPageController.paymentValues = objPayment;
        objFlamePaymentPageController.paymentGateway = paymentList;
        objFlamePaymentPageController.order_status = 'Success';
        objFlamePaymentPageController.totalPaymentValue1 = 'test data';
        objFlamePaymentPageController.totalPaymentValue2 = 'test data';
        objFlamePaymentPageController.totalPaymentValue3 = 'test data';
        objFlamePaymentPageController.totalPaymentValue4 = 'test data';
        objFlamePaymentPageController.totalPaymentValue5 = 'test data';
        objFlamePaymentPageController.toatalPaymentVal1 = 10;
        objFlamePaymentPageController.toatalPaymentVal2 = 10;
        objFlamePaymentPageController.toatalPaymentVal3 = 10;
        objFlamePaymentPageController.toatalPaymentVal4 = 10;
        objFlamePaymentPageController.toatalPaymentVal5 = 10;
        objFlamePaymentPageController.currentPod();
        objFlamePaymentPageController.isSandbox();
        objFlamePaymentPageController.getFullName();
        objFlamePaymentPageController.processtopay();
        objFlamePaymentPageController.OnlinePayment();
        objFlamePaymentPageController.PendingPayments();
        objFlamePaymentPageController.PaymentHistory();
        objFlamePaymentPageController.myLedgers();
        objFlamePaymentPageController.BacktoPaymentHistory();
        objFlamePaymentPageController.rId = ledger_Obj.id;
        objFlamePaymentPageController.DownloadTemplate();
        
        objFlamePaymentPageController.click();
        objFlamePaymentPageController.Debitcardclick();
        objFlamePaymentPageController.Netbankingclick();
        objFlamePaymentPageController.upiclick();
        objFlamePaymentPageController.walletclick();
        Contact con = new Contact();
        objFlamePaymentPageController.InsertPaymentDetails(new LIst<string>(), new Map<String,String>(),con, 'test data','test data');
        PageReference pageRef = Page.Flame_OnlinePayment;
        pageRef.getParameters().put('inputText','test');
        Test.setCurrentPage(pageRef);
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Ledger__c;
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        Id rtId = AccountRecordTypeInfo .get('Credit').getRecordTypeId();
        Ledger__c Acc = new Ledger__c(recordtypeid=AccountRecordTypeInfo .get('Credit').getRecordTypeId());
        RecordType rt = [select id,Name from RecordType where SobjectType='Ledger__c' and Name='Credit' Limit 1];
       
        Flame_PaymentPageController.LedgerWrapper obj = new Flame_PaymentPageController.LedgerWrapper(false,new Ledger__c());
        objFlamePaymentPageController.RuPayDebitcardclick();
        objFlamePaymentPageController.Search();
        
        
    }                                          
}