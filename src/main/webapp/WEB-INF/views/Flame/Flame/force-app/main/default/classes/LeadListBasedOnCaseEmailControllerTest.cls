@IsTest
public class LeadListBasedOnCaseEmailControllerTest {
    
    static testMethod  void validateMethods1(){
        
       // contact c = new contact();
       // c.
        
        case c = new case();
        c.SuppliedEmail = 'manish.harne@techilaservices.com';
        database.insert(c);
        
        lead l = new lead();
        l.Email = c.SuppliedEmail;
        l.FirstName = 'Manish';
        l.LastName  = 'Harne'  ;
        l.Company   = 'TSG';
        database.insert(l);
        
     //   application__c a = new application__c();
     //   a.contact_email__C = c.SuppliedEmail;
        
        
        test.startTest();
       LeadListBasedOnCaseEmailController.fetchLeadList(c.id);
       LeadListBasedOnCaseEmailController.fetchApplicationList(c.Id) ;
        test.stopTest();
        
    }

}