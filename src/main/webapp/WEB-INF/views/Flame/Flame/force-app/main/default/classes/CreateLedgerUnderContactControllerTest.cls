@isTest
private Class CreateLedgerUnderContactControllerTest
{
 static private Account objAcc;
 static private Contact objCon;
 static private Ledger__c objLed;
 
    static void LoadData() 
    {
     
      CreateAccount();
      CreateContact();
      CreateLedger();
    }
    
    static testMethod void validateController() 
    {   
        //list<WrapperClass> lstofWrap = new list<WrapperClass>();
        LoadData();
        Apexpages.StandardController sc = new Apexpages.StandardController(objLed);
       
        
        
        
        Test.StartTest();
             CreateLedgerUnderContactController objCLUC = new  CreateLedgerUnderContactController(sc); 
             CreateLedgerUnderContactController.WrapperClass objWrap = new CreateLedgerUnderContactController.WrapperClass();
             
                objCLUC.selectedAccountId = objAcc.id;
                objCon.AccountID = objCLUC.selectedAccountId;
                Update objCon;
                objWrap.objCon = objCon;
                objWrap.isSelected = false;
                objCLUC.lstofwrapperClas.add(objWrap);
                
                
            
            for(CreateLedgerUnderContactController.WrapperClass wrp : objCLUC.lstofwrapperClas )
            {
                wrp.isSelected = true;
            }
            
            objCLUC.ShowAccountRecord();
            objCLUC.AllContact();
            objCLUC.SaveData();
        Test.StopTest();
        
        
        
        //objWrap.isSelected = true;
        //objWrap.objCon = ObjCon;
        //lstofWrap.add(objWrap);
        
       
        
    }
 
    static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
       insert objAcc;
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
       insert objCon;
    }
    
    static void CreateLedger()
    {
       objLed = new Ledger__c();
       objLed.Contact__c = objCon.id;
       insert objLed;
    }
   
}