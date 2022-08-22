public class FUA_OnlineHousingpaymentController 
{
    public String Access_Code {get;set;}
    public string Enc_Request {get;set;}
    private FUA_Payment_Gateway__c paymentValues;
    public String endPointUrl {get;set;}
    public user userID{get;set;}
    public Contact Con{get;set;}
    public Application__c app{get;set;}
    public FUA_OnlineHousingpaymentController(){
    
     userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
        Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
        app = [Select ID,Name,Contact__c,Completed_Stages__c,Preference_Housing_Amount__c,Program__r.name,Program__c,SAT_Score__c
               From Application__c Where Contact__c =: userID.ContactId Limit 1];
        system.debug('app>>>>>>>>>>>>>>>>>>>>>'+app);            
        
        FUA_UtilityClass objUtility = new FUA_UtilityClass();
        If(objUtility.isSandbox() == true){
            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For SandBox');
        
        }else{
            
            paymentValues = FUA_Payment_Gateway__c.getValues('Payment Details For Prod');
        }
        endPointUrl = paymentValues.EndPointUrl__c;
        paymentRedirection();
    }
    public void paymentRedirection(){
        
        String baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
       // String redirect_Url = baseUrl + '/applications/apex/HousingPayment_1';
      //  String cancel_url = baseUrl + '/applications/apex/HousingPayment_1';
        String redirect_Url = baseUrl + '/application/apex/HousingPayment_1';
        String cancel_url = baseUrl + '/application/apex/HousingPayment_1';
        Integer tId = (Integer)(Math.random()*1000000000);
        String order_Id = UserInfo.getUserId() + tid;
        String text = 'tid='+tId+'&merchant_id='+paymentValues.Merchant_Id__c+'&order_id='+order_Id+'&amount='+app.Preference_Housing_Amount__c+'&currency='+paymentValues.FUA_Currency__c+'&redirect_url='+redirect_Url+'&cancel_url='+cancel_url+'&language='+paymentValues.FUA_Language__c+'&billing_country=India';
        System.debug('order_Id==>'+order_Id);
        System.debug('text==>'+text);
        Access_Code = paymentValues.Access_Code__c;
        Enc_Request = encrypt(text);
    }
    private string encrypt(string plainText){
        
        Blob cryptoKey = Blob.valueOf(paymentValues.Working_Key__c);
        Blob hash = Crypto.generateDigest('MD5', cryptoKey ); 
        Blob data = Blob.valueOf(plainText);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', hash , data);
        return EncodingUtil.convertToHex(encryptedData );
    }
}