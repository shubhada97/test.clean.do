@isTest
 private class AssociateCasesFromEmailToCaseTest {

 static void setupTestData(){
 Id devRecordTypeId = Schema.SObjectType.Application__c.getRecordTypeInfosByName().get('FU_Applicant').getRecordTypeId();     
    Test.startTest();
    Case cs = new Case();
    cs.ContactId = Null; 
    cs.SuppliedName = 'Sharath'; 
    cs.SuppliedEmail = 'abc.efg@abc.com'; 
    cs.SuppliedPhone = '9177229872'; 
    cs.SuppliedCompany = 'Flame'; 
    cs.Type = 'Other'; 
    cs.Status = 'New';  
    cs.Origin = 'Email'; 
    cs.Subject = 'Test Case'; 
    cs.Priority = 'High';  
    cs.Description = 'Test Case';  
    cs.IsEscalated = false;
    Insert cs; 
      
    Contact c = new Contact();
    c.firstname = 'Sharath';
    c.LastName = 'Kumar'; 
    c.Email = 'abc.efg@abc.com';
    c.Recordtypeid = devRecordTypeId;
   
    Insert c; 
    
    list<case> lstcase = [select id,suppliedemail,contactid from case  WHERE ContactId = :cs.Id AND SuppliedEmail = :c.Email];
  //  AssociateCasesFromEmailToCase ass = new AssociateCasesFromEmailToCase();
   //  insert ass;
   Test.stopTest();
  }

}