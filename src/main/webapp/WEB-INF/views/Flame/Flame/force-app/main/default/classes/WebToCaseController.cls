public class WebToCaseController {

   public string strCaseEmail;
   public list<Case> lstoCase{get;set;}
   
   //ApexPages.currentPage().getParameters().get('id')

   
   public WebToCaseController (){
   
     lstoCase = new list<Case>();
     strCaseEmail = ApexPages.currentPage().getParameters().get('webtoEmail');
     if(strCaseEmail != null)
     {
       for(Case obj : [Select Id,CaseNumber,Contact.Name,Field_Executive_Assigned__c,CreatedDate,ClosedDate,Follow_Up_Status_MKTG__c,Contact.Email ,Status,SuppliedPhone ,SuppliedName,Subject,Description,Marketing_Team_Comments__c,
                        SuppliedCompany, SuppliedEmail from Case where SuppliedEmail =: strCaseEmail OR Contact.Email =: strCaseEmail
                          
                         order by CreatedDate Desc])
       {
         lstoCase.add(obj);
       }
     }
       
   }
}