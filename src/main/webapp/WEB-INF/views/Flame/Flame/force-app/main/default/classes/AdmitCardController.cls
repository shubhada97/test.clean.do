public with sharing class AdmitCardController {
   
    public Application__c App {get;set;}
    public Contact Cont {get;set;}
    public User UserID{get;set;}
    public string RepDate{get;set;}
    public AdmitCardController()
    
    
    {
        if(!String.IsEmpty(UserInfo.getUserId()))
        {     
            UserID=[Select Id,name,SmallPhotoUrl,ContactId from User where Id = :UserInfo.getUserId()];
        }
         App =   new Application__c();
         Cont = new Contact();
        try{
   /* String contactId = [select ContactId from User where id = :UserInfo.getUserId()].ContactId;*/
        App = [Select id ,Applicant_Image__c, FUA_Applicant_Name__c ,Contact__r.Name, Application_Reference_ID__c , GD_and_PI_Center__c ,   GD_and_PI_Round__c, Program__r.name, (Select Id,Reporting_Date__c,Reporting_Time__c,Test_Address_Line_1__c,Test_Address_Line_2__c,Test_Address_Line_3__c from Admit_Cards__r)from Application__c where contact__c =:UserID.ContactID];
       Cont = [Select id , Mailing_Address_Line_1__c, Mailing_Address_Line_2__c,Mailing_Postal_Code__c,FU_Applicant_Mailing_Country__c,FU_Applicant_Mailing_State__c,FU_Applicant_Mailing_City__c from  Contact where id =:UserID.ContactID];
        system.debug('@@@@@@@@'+ Cont.id );
     }
     catch(exception e){
     
     }
      
}

  
}