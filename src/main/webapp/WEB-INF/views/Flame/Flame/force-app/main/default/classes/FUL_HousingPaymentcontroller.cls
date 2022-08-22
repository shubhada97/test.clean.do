Public Class FUL_HousingPaymentcontroller{

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
    public Application__c userApp{get;set;}
    public Application__c App{get;set;}
    Public program__c prog {get;set;}
    private Map<String,Id> mapOfRecordType;
    private FUA_Scratch_Card_Details__c objScratchCard;
    private  List<String> lstOfParams;
    private String order_status;
    private String order_id;
    private Map<String,String> mapOfParams;
    private FUA_Payment_Gateway__c paymentValues;
    private List<FUA_Payment__c> lstOFExistingPayment;
    Public GD_and_PI_Round__c Enroll {get;set;}
    Public boolean IsPastDate {get;set;}
    
    /*constructer*/
    public FUL_HousingPaymentcontroller() {
    userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
    FUA_UtilityClass objUtility = new FUA_UtilityClass();
    App = objUtility.getApplicationId(UserInfo.getUserId());    
    con =[Select Id,HousingBuilding__c,HousingBuilding__r.Name,Hsg_Housing_Room__c from contact where Id =:userID.ContactId limit 1];
    }
    
   /*Action method*/ 
   Public pagereference HousingPayment()
   {
   IsPastDate= false;
    lstOFExistingPayment = new List<FUA_Payment__c>();
    lstOfParams = new List<String>();
    mapOfParams = new Map<String,String>();
    
    FUA_UtilityClass objUtility = new FUA_UtilityClass();
    mapOfRecordType = objUtility.getPaymentRecordType();   
    userApp = objUtility.getApplicationId(UserInfo.getUserId());    
    App = userApp;
    
    If(objUtility.isSandbox() == true){
       paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
    }else{
       paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }   
        
     encResp = Apexpages.currentPage().getParameters().get('encResp');
        System.debug('encResp====>'+encResp);    
     if(String.isNotBlank(encResp) && paymentValues != Null){
           
            String response = decrypt(encResp);
            lstOfParams = response.split('&');
            
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
     if(App.Id != null){
            Boolean isPaymentDone = isHousingPaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                nextPage = new PageReference('/apex/UploadDocuments2_1');
                nextPage.setRedirect(true);
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Housing Payment')){
                    try{
                        InsertHousingPaymentDetails(App.Id,order_id,order_status);
                        checkPaymentCompleted(prog, App,'HousingPayment', 'HousingPayment'); 
                        paymentErrorMsg = '';
                    }catch(Exception ex){
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                }
                nextPage = new PageReference('/apex/UploadDocuments2_1');
                nextPage.setRedirect(true);
            }else if(order_status == 'Failure'){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                InsertHousingPaymentDetails(App.Id,order_id,order_status);
                paymentErrorMsg = paymentErrorMsg;
            }else{
                paymentErrorMsg = paymentErrorMsg;
            }
             return null;
       }else{
             return new PageReference('/apex/Index');
        }
    }
    
   /*decrypt */
    private string decrypt(string encryptedText){
        
        Blob cryptoKey = Blob.valueOf(paymentValues.Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey);
        Blob data = EncodingUtil.convertFromHex(encryptedText);
        Blob decryptedText = Crypto.decryptWithManagedIV('AES128', hash, data);
        String plainText = decryptedText.toString();
        return plainText;
    }    
   @TestVisible
    private boolean isHousingPaymentDone(){
        Boolean returnValue;
        if(App.Id != Null){
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'HousingPayment';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }
    /*--4--*/
    public void InsertHousingPaymentDetails(String AppId, String order_id, String order_status){ 
    FUA_Payment__c HousingPayment = new FUA_Payment__c();
        HousingPayment.FUA_Application__c = AppId;
        HousingPayment.Payment_Date__c = System.Date.today();
        HousingPayment.FUA_Order_Id__c = order_id;
        HousingPayment.Fee_Type__c='HousingPayment';
        If(mapOfParams.get('tracking_id') != Null) HousingPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
        HousingPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
        HousingPayment.FUA_Order_Status__c = order_status;
        HousingPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
        HousingPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
        If(mapOfParams.get('amount') != Null) HousingPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
        HousingPayment.Paid_By__c = 'Online Payment';
        insert HousingPayment;
    }
     /*--5--*/
    
 @TestVisible   
  private void checkPaymentCompleted(Program__c Prog, Application__c updateApplication, String PageName, String FeeType){
       boolean isHousingPaymentid = true; 
       List<FUA_Payment__c> HousingPayment =new List<FUA_Payment__c>([select Id FROM FUA_Payment__c where FUA_Application__c = :updateApplication.ID and Fee_Type__c=:FeeType and FUA_Order_Status__c='Success']);
       
       if(HousingPayment.size()>0){
            if( updateApplication.id != NULL){
             String completedStages = updateApplication.Completed_Stages__c; 
             if(completedStages != null){
                if(!completedStages.contains(PageName)){
                   completedStages += ';' + PageName;
                   updateApplication.Completed_Stages__c = completedStages;
                 }
              }else{
                 updateApplication.Completed_Stages__c = PageName;
              }  
             if(FeeType=='HousingPayment')
               updateApplication.Preference_Housing_Payment_Recived__c = true;   
                update updateApplication;
                
            }
       
    }  
    }
  
    
  /*Button click function*/  
  public PageReference HousingPaymento() 
  {
   try{
             
       lstOFExistingPayment = [Select Id From FUA_Payment__c 
                              Where (RecordTypeId =:mapOfRecordType.get('Housing Payment') AND 
                              FUA_Order_Status__c = 'Success') AND FUA_Application__c = :userApp.Id];
            
        }catch(Exception ex){
            
            System.debug('Error at ===>'+ex.getCause()+ex.getStackTraceString());
        }
    pagereference rd = null;
   if(lstOFExistingPayment.isEmpty()){
   rd =new pageReference('/apex/OnlinePayment4_1');
   rd.setRedirect(True);
   
   }else{
   paymentErrorMsg = 'You Already Paid For This Application';
    }
    
   return rd; 
  }
    
  /*2.Button click function */  
  public PageReference SaveExitinhousingpay() {
   PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
   return SaveExit;    
   }      
    
    
    }