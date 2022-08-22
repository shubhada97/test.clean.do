Public Class FUL_Semesterfeecontroller{
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
    Public String isScholarshipEligible {get;set;}
    public Decimal totalAmount {get;set;}
    public string semester1 {get;set;}
    public string semester2 {get;set;}
    /*constructer*/
    public FUL_Semesterfeecontroller() {
    userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
    FUA_UtilityClass objUtility = new FUA_UtilityClass(); 
    userApp = objUtility.getApplicationId(UserInfo.getUserId());    
    App = userApp;
    system.debug('App>>>>>>>>>>>>>>>>>'+App);
    isScholarshipEligible = userApp.FUA_Scholarship_Granted__c; 
    String receiptId = System.currentPageReference().getParameters().get('semester1');
    system.debug('receiptId>>>>>>>>>>>>>>>>>'+receiptId);
    }
   
    
   /*Action method*/ 
   Public  pagereference SemesterFee()
   {
   
     FUA_UtilityClass objUtility = new FUA_UtilityClass();
        mapOfRecordType = objUtility.getPaymentRecordType();
        mapOfParams     = new Map<String,String>();
        
        If(objUtility.isSandbox() == true){
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        }
        else{
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        
        encResp = Apexpages.currentPage().getParameters().get('encResp');
        
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
                app.Semester_1Fee_Paid__c =false;
                app.Semester_2Fee_Paid__c = false;             
                update app;
            }else if(order_status == 'Failure'){
                paymentErrorMsg = 'Transaction Failure';
                app.Semester_1Fee_Paid__c =false;
                app.Semester_2Fee_Paid__c = false;             
                update app;
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
            Boolean isPaymentDone = isSemesterFeePaymentDone();
            pagereference nextPage = null;
            
            if(isPaymentDone == true){
                  
                nextPage = new PageReference('/apex/HousingPreference_1');
               // nextPage.setRedirect(false);
            }else if(String.isNotEmpty(order_status) && order_status == 'Success' && isPaymentDone == false){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                if(mapOfRecordType.containsKey('Semester Fee')){
                    try{
                        InsertSemesterFeePaymentDetails(App, order_id,order_status);
                        checkPaymentCompleted(prog, App,'Semesterfee', 'Semesterfee'); 
                        paymentErrorMsg = '';
                        
                        
                     }catch(Exception ex){
                        System.debug('Error at '+ex.getCause() + ex.getMessage() + ex.getStackTraceString());
                    }
                   
                }
                nextPage = new PageReference('/apex/HousingPreference_1');
               
            }else if(order_status == 'Failure'){
                FUA_Payment__c objPayment = new FUA_Payment__c();
                InsertSemesterFeePaymentDetails(App,order_id,order_status);
                paymentErrorMsg = paymentErrorMsg;
            }else{
                paymentErrorMsg = paymentErrorMsg;
            }
             return nextPage;
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
    // --2---
     @TestVisible
    private boolean isSemesterFeePaymentDone(){
   
        Boolean returnValue;
        if(App.Id != Null){
            String completedStages = App.Completed_Stages__c;
            String currentPageName = 'Semesterfee_1';
            if(completedStages != null && completedStages.contains(currentPageName)){
                returnValue = true;
            }else{
                returnValue = false;
            }
        }
        return returnValue;
    }   
  /*InsertSemesterFeePaymentDetails*/ 
   public void InsertSemesterFeePaymentDetails(Application__c App, String order_id, String order_status){ 
        
        FUA_Payment__c semesterPayment = new FUA_Payment__c();
        semesterPayment.FUA_Application__c = App.Id;
        semesterPayment.Payment_Date__c = System.Date.today();
        semesterPayment.FUA_Order_Id__c = order_id;
        semesterPayment.Fee_Type__c='Semesterfee';
        If(mapOfParams.get('tracking_id') != Null) semesterPayment.FUA_Tracking_Id__c = decimal.valueOf(mapOfParams.get('tracking_id'));
        semesterPayment.FUA_Bank_Ref_No__c = mapOfParams.get('bank_ref_no');
        semesterPayment.FUA_Order_Status__c = order_status;
        semesterPayment.FUA_Failure_Message__c = mapOfParams.get('failure_message');
        semesterPayment.FUA_Payment_Mode__c = mapOfParams.get('payment_mode');
        If(mapOfParams.get('amount') != Null) semesterPayment.FUA_Amount__c = decimal.valueOf(mapOfParams.get('amount'));
        semesterPayment.Paid_By__c = 'Online Payment';
        insert semesterPayment;
        
     
    }
  
 /* Public void applicationupdate(){
   try{
             
       lstOFExistingPayment = [Select Id From FUA_Payment__c 
                              Where (RecordTypeId =:mapOfRecordType.get('Semester Fee') AND 
                              FUA_Order_Status__c = 'Success') AND FUA_Application__c = :userApp.Id];
        if(userApp.id != NULL ){
        app.Semester_1Fee_Paid__c = Boolean.valueof(semester1);
        app.Semester_2Fee_Paid__c = Boolean.valueof(semester2);             
        update app;
        system.debug('app>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>1'+app);
        }    
        }catch(Exception ex){
            
            System.debug('Error at ===>'+ex.getCause()+ex.getStackTraceString());
        }
        } */ 
  
  /*checkPaymentCompleted*/ 
  @TestVisible 
  private void checkPaymentCompleted(Program__c Prog, Application__c updateApplication, String PageName, String FeeType){
   boolean  isSemesterFeeid = true; 
   List<FUA_Payment__c> SemesterFeePayment =new List<FUA_Payment__c>([select Id FROM FUA_Payment__c where FUA_Application__c = :updateApplication.ID and Fee_Type__c=:FeeType and FUA_Order_Status__c='Success']);
  
   if(SemesterFeePayment.size()>0)
   {
   if( updateApplication.id != NULL)
   {
       String completedStages = updateApplication.Completed_Stages__c; 
       if(completedStages != null)
    {
       if(!completedStages.contains(PageName))
       {
           completedStages += ';' + PageName;
           updateApplication.Completed_Stages__c = completedStages;
           updateApplication.Admission_Status__c ='Fees Paid';
       }    
            
    }else{
       updateApplication.Completed_Stages__c = PageName;
       updateApplication.Admission_Status__c ='Fees Paid';
         }  
        if(FeeType=='Semesterfee') 
         update updateApplication;
  }
  }
  
    }  
  
    
  /*Button click function*/  
  public PageReference Pay() 
  {
    lstOFExistingPayment = [Select Id From FUA_Payment__c 
                              Where (RecordTypeId =:mapOfRecordType.get('Semester Fee') AND 
                              FUA_Order_Status__c = 'Success') AND FUA_Application__c = :App.Id];
                              system.debug('>>>>>>>>>>>>>>>>>>>>>>>'+App.Id);
//applicationupdate();
    pagereference rd = null;
   if(lstOFExistingPayment.isEmpty()){
   rd =new pageReference('/apex/OnlinePayment3_1?amount='+totalAmount);
   rd.setRedirect(True);
   
   }else{
   paymentErrorMsg = 'You Already Paid For This Application';
    }
    
   return rd; 
  }
    
  /*2.Button click function */  
  public PageReference SaveExitinsemesterfee() {
   PageReference SaveExit= new PageReference('/secur/logout.jsp'); 
   return SaveExit;    
   }      
     
    
    
 

    }