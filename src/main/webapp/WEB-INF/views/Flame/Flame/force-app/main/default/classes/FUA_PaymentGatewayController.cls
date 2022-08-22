public with sharing class FUA_PaymentGatewayController {
    
    public String paymentType {get;set;}
    public String scarchCardNo {get;set;}
    public String ddNumber {get;set;}
    public String ddDrwanBank {get;set;}
    public String bankBranch {get;set;}
    public String paidBy {get;set;}
    public String encResp;
    public String paymentErrorMsg {get;set;}
    public Contact Con{get;set;}
    public user userID{get;set;}
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
    
    private Application__c userApp;
    private Map<String,Id> mapOfRecordType;
    private FUA_Scratch_Card_Details__c objScratchCard;
    private  List<String> lstOfParams;
    private String order_status;
    private String order_id;
    private Map<String,String> mapOfParams;
    private FUA_Payment_Gateway__c paymentValues;
    private List<FUA_Payment__c> lstOFExistingPayment;
    
    public FUA_PaymentGatewayController() {
        
        userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
        paymentType = 'olpayment';
        ddNumber = '';
        lstOFExistingPayment = new List<FUA_Payment__c>();
        lstOfParams = new List<String>();
        mapOfParams = new Map<String,String>();
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        
        userApp = objUtility.getApplicationId(UserInfo.getUserId());
        
        If(objUtility.isSandbox() == true){
            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        System.debug('encResp====>'+encResp);
        
        if(String.isNotBlank(encResp) && paymentValues != Null){
            
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            System.debug('lstOfParams===>'+lstOfParams);
            for(Integer i = 0; i < lstOfParams.size(); i++){
                
                List<String> information = lstOfParams[i].split('=');
                if(i==0) order_id = information[0];
                if(i==3) order_status = information[1];
            }
            if(order_status == 'Aborted'){
                
                paymentErrorMsg = 'Transaction Aborted';
                
            }else if(order_status == 'Failure'){
                
                paymentErrorMsg = 'Transaction Failure';
                
            }else{
                
                paymentErrorMsg = 'Security Error. Illegal access detected';
            }
            for(Integer i = 1; i < lstOfParams.size(); i++){
                
                List<String> information = lstOfParams[i].split('=');
                if(i==3) order_status = information[1];
                if(information.size() > 1){
                    
                    mapOfParams.put(information[0], information[1]);
                    
                }else{
                    mapOfParams.put(information[0],'');
                }
            }
        }
    }
    
    public pagereference payNowMethod(){
        
        try{
            
            lstOFExistingPayment = [Select Id From FUA_Payment__c 
                                    Where (RecordTypeId = :mapOfRecordType.get('Scratch Card Payment') OR 
                                           RecordTypeId = :mapOfRecordType.get('Demand Draft Payment') OR 
                                           (RecordTypeId =:mapOfRecordType.get('Online Payment') AND 
                                            FUA_Order_Status__c = 'Success')) AND FUA_Application__c = :userApp.Id];
            
        }catch(Exception ex){
            
            System.debug('Error at ===>'+ex.getCause()+ex.getStackTraceString());
        }
        
        pagereference pageproceed = null;
        
        if(lstOFExistingPayment.isEmpty()){
            
            if(paymentType == 'olpayment'){
                
                pageproceed = new pagereference('/apex/OnlinePayment_1');
                pageproceed.setRedirect(True);
                
            }else if(paymentType == 'scratchCard'){
                
                try{
                    
                    objScratchCard = [Select Id, Scratch_Card_Number__c,Scratch_Card_Usage_Status__c
                                      From FUA_Scratch_Card_Details__c
                                      Where Scratch_Card_Number__c =: scarchCardNo limit 1];
                    
                    If(String.valueOf(objScratchCard) != Null && objScratchCard.Scratch_Card_Usage_Status__c == 'Available'){
                        
                        FUA_Payment__c objPayment = new FUA_Payment__c();
                        insertPayment(objPayment,paymentType);
                        
                        objScratchCard.Scratch_Card_Usage_Status__c = 'Used';
                        List<FUA_Scratch_Card_Details__c> lstOfScartchCardToUpdate = new List<FUA_Scratch_Card_Details__c>();
                        lstOfScartchCardToUpdate.add(objScratchCard);
                        if(lstOfScartchCardToUpdate.size() > 0){
                            
                            Update lstOfScartchCardToUpdate;
                            updateApplicationStage(userApp);
                        }
                        pageproceed = new pagereference('/apex/ThankyouPage_1');
                        pageproceed.setRedirect(True);
                        
                    }else{
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Scratch Card Is Already Used'));
                    }
                    
                }catch(Exception ex){
                    
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Scratch Card Is Invalid'));
                }
                
            }else if(paymentType == 'demandDraft'){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                
                try{
                    insertPayment(objPayment,paymentType);
                    updateApplicationStage(userApp);
                    
                }catch(Exception ex){
                    
                    Apexpages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Failed to add demand draft'));
                }
                pageproceed = new pagereference('/apex/ThankyouPage_1');
                pageproceed.setRedirect(True);
            }
            
        }else{
            
            paymentErrorMsg = 'You Already Paid For This Application';
        }
        return pageproceed;
    }
    
    public pagereference checkPaymentIsDone(){
        System.debug('UserAppp=======>'+userApp);
        if(userApp.Id != null){
            Boolean isPaymentDone = isPaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                
                nextPage = new PageReference('/apex/ThankyouPage_1');
                nextPage.setRedirect(true);
                
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Online Payment')){
                    
                    try{
                        insertPayment(objPayment,paymentType);
                        updateApplicationStage(userApp);
                        paymentErrorMsg = '';
                        
                    }catch(Exception ex){
                        
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/ThankyouPage_1');
                nextPage.setRedirect(true);
                
            }else if(order_status == 'Failure'){
                
                FUA_Payment__c objPayment = new FUA_Payment__c();
                insertPayment(objPayment,paymentType);
                paymentErrorMsg = paymentErrorMsg;
                
            }else{
                
                paymentErrorMsg = paymentErrorMsg;
            }
            return nextPage;
        }
        else{
             return new PageReference('/apex/Index');
        }
    }
    
    private boolean isPaymentDone(){
        
        Boolean returnValue;
        if(userApp.Id != Null){
            
            String completedStages = userApp.Completed_Stages__c;
            String currentPageName = 'Payment;Thankyou';
            if(completedStages != null && completedStages.contains(currentPageName)){
                
                returnValue = true;
                
            }else{
                
                returnValue = false;
            }
        }
        return returnValue;
    }
    
    private string decrypt(string encryptedText){
        
        Blob cryptoKey = Blob.valueOf(paymentValues.Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }
    
    private void updateApplicationStage(Application__c updateApplication){
        
        String completedStages = updateApplication.Completed_Stages__c;
        String currentPageName = 'Payment;Thankyou';
        
        if(completedStages != null){
            
            if(!completedStages.contains(currentPageName)){
                
                completedStages += ';' + currentPageName;
                updateApplication.Completed_Stages__c = completedStages;
                updateApplication.Application_Submission_Status__c = 'Submitted & Paid';
                updateApplication.Admission_Status__c = 'Submitted Paid';
            }
            
        }else{
            
            updateApplication.Completed_Stages__c = currentPageName;
        }
        update updateApplication;
    }
    
    private void insertPayment(FUA_Payment__c objPayment,String paymentType){
        
        List<FUA_Payment__c> lstOfPayment = new List<FUA_Payment__c>();
        
        if(paymentType == 'olpayment'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Online Payment');
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Payment_Date__c = System.Date.today();
            objPayment.FUA_Order_Id__c = order_id;
            If(mapOfParams.get('tracking_id') != Null) objPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
            objPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
            objPayment.FUA_Order_Status__c = order_status;
            objPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
            objPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
            If(mapOfParams.get('amount') != Null) objPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
            objPayment.Paid_By__c = 'Online Payment';
            
        }else if(paymentType == 'scratchCard'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Scratch Card Payment');
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Scratch_Card_Number__c = objScratchCard.Scratch_Card_Number__c;
            objPayment.Payment_Date__c = System.Date.today();
            objPayment.Paid_By__c = 'Scratch Card';
            
        }else if(paymentType == 'demandDraft'){
            //objPayment.RecordTypeId = mapOfRecordType.get('Demand Draft Payment');
            objPayment.DD_Number__c = ddNumber;
            objPayment.Drawn_on_Bank_Name__c = ddDrwanBank;
            objPayment.Branch__c = bankBranch;
            objPayment.FUA_Application__c = userApp.Id;
            objPayment.Paid_By__c = paidBy;
            objPayment.Payment_Date__c = System.Date.today();
            
        }
        lstOfPayment.add(objPayment);
        System.debug('lstOfPayment==>' +lstOfPayment);
        if(lstOfPayment.size() > 0)
        {
            insert lstOfPayment;
        }
    }
}