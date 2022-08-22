@isTest
public class PicklistControllerTest {
    
    public static Contact objCon;
    public static Account objAcc;
    
    
    public static void LoadData() 
    {
        
         CreateAccount();
        CreateContact();
        
        
    }
    
    public static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    
    public static void CreateContact()
    {

       // Id FuEmployeeRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId(); 

        objCon = new Contact();
        objCon.LastName = 'Test';
        objCon.FirstName = 'Test';
        objCon.Contact_Country__c ='India';
        objCon.Contact_State__c ='Maharashtra';
        objCon.Contact_City__c ='Nagpur';
        objCon.Email = 'Test@gmail.com';
        objCon.AccountID = objAcc.Id;
       // objcon.Id = '0030p00000NiE8zAAF';
        objCon.Department__c ='Adminstrator';
       // objCon.RecordTypeId = FuEmployeeRecordTypeId;
        insert objCon;
       system.debug('objcon.Id'+objcon.Id); 
    }
      @isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAllCountryResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        test.startTest();
        PicklistController.getCountry();
        PicklistController.getStateByCountry('IN');
        PicklistController.getCityByStateCountry('IN','MH');
        PicklistController.getCityByCountry('IN');
          LoadData();
          
        PicklistController.SaveRecord('India', 'Maharashtra', 'Nagpur', objcon.Id, 'Contact', 'Contact_Country__c', 'Contact_State__c', 'Contact_City__c');
        // Verify mock response is not null
        test.stopTest();
              
    }   

}