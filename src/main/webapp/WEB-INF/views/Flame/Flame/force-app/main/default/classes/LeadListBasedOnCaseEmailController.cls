public class LeadListBasedOnCaseEmailController {
    
   /*  @AuraEnabled
    public static List<Lead> fetchLeadList(Id leadId) {
        List<Lead> leadListBasedOnCaseEmail;
        set<String> caseEmails = new set<String>();
        // Getting the list of cases from where web mail !=null
        List<case> caseList =[select Id,SuppliedEmail from case where SuppliedEmail !=null OR SuppliedEmail !=''];
        system.debug('caseList-->'+caseList);
        
        List<Lead> leadList = [SELECT Id, Name,Email, Phone FROM Lead where Email!= null OR Email !=''];
        system.debug('leadList-->'+leadList);
        
        for(case c:caseList){
         
           // if(l.Email == caseList[0].SuppliedEmail){
                caseEmails.add(c.SuppliedEmail);
                
           // }
            
        }
        system.debug('caseEmails-->'+caseEmails);
       leadListBasedOnCaseEmail =[select Id, name,Email from lead where email in: caseEmails];
	   System.debug('leadListBasedOnCaseEmail-->'+leadListBasedOnCaseEmail);
	// Returning the contact list
        return leadListBasedOnCaseEmail;
    } */

    @AuraEnabled
    public static List<Lead> fetchLeadList(Id leadId) {
        List<Lead> leadListBasedOnCaseEmail;
        List<Lead> leadList = new List<Lead>();
        set<String> caseEmails = new set<String>();
        // Getting the list of cases from where web mail !=null
        List<case> caseList =[select Id,SuppliedEmail,ContactEmail from case where id=:leadId 
                              and ((SuppliedEmail!=null OR SuppliedEmail!='') OR (ContactEmail!=null OR ContactEmail!=''))];
        system.debug('caseList-->'+caseList);
        if(caseList.size()>0){
        leadList = [SELECT Id, Name,Email,LastName,FirstName, Phone,Executive_Assigned__c FROM 
                    Lead where (Email=:caseList[0].SuppliedEmail OR Email=:caseList[0].ContactEmail) AND Email!=null];
        system.debug('leadList-->'+leadList);
        }
     
	// Returning the contact list
        return leadList;
    }
    
     @AuraEnabled
    public static List<Application__C> fetchApplicationList(Id applicationId) {
        List<Lead> leadListBasedOnCaseEmail;
        List<Application__C> applicationList = new List<Application__C>();
        set<String> caseEmails = new set<String>();
        // Getting the list of cases from where web mail !=null
        List<case> caseList =[select Id,SuppliedEmail,ContactEmail from case where id=:applicationId 
                              and ((SuppliedEmail!=null OR SuppliedEmail!='') OR (ContactEmail!=null OR ContactEmail!=''))];
        system.debug('caseList-->'+caseList);
        if(caseList.size()>0){
        applicationList = [SELECT Id, Name,contact_email__C,Application_Owner__c FROM Application__C where (contact_email__C=:caseList[0].SuppliedEmail OR contact_email__C=:caseList[0].ContactEmail) AND contact_email__C!=null];
        system.debug('applicationList-->'+applicationList);
        }
     
	// Returning the contact list
        return applicationList;
        
    }
}