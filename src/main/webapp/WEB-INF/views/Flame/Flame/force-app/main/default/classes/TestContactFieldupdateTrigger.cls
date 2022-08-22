@isTest
 Public class TestContactFieldupdateTrigger {
  Public static testMethod void testOneCon(){
        
        Account a = new Account(name='test acc',phone='9494146144');
        insert a;
        Account a2 = new Account(name='test acc 2',phone='9494146144');
        insert a2;
        Contact con = new Contact(accountid=a2.id,lastname='test con',email='lnarasimha823@gmail.com');
        insert con;
        Contact con2 = new Contact(accountid=a.id,lastname='test con2',email='lnarasimha823@gmail.com');
        Lead lead_Obj = new Lead(LastName = 'LastName900', Company = 'Company595', Status = 'Contacted', IsConverted = false, IsUnreadByOwner = false, VisualAntidote__Fast_Forms_Auto_Assign__c = false, VisualAntidote__Fast_Forms_Autoresponse__c = false);
        Insert lead_Obj; 
        Lead lead_Obj2 = new Lead(LastName = 'LastName900', Company = 'Company595', Status = 'Contacted', IsConverted = false);
    
        Test.startTest();
        try{
            insert con2;
            lead_Obj2.email = con.email;
            update lead_Obj2;
        }
        catch(Exception e){
           system.debug('Duplicate Account Id');
        }
        
        
        Test.stopTest();
        
    }
}