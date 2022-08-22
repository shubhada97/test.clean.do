trigger InsertLedgerforEnrolledApp on Application__c (after update){
Set<Id> appIds=new Set<Id>();
List<Ledger__c> listLedgeInsert = new List<Ledger__c>();
List<Contact> listConInsert = new List<Contact>();
List<Contact> ListConUpdate= new List<Contact>();
List<hed__Relationship__c> listRelInsert=new List<hed__Relationship__c>();
for(Application__c appRec : Trigger.New){
    if(appRec.Admission_Status__c =='Enrolled' && appRec.Admission_Status__c !=Trigger.OldMap.get(appRec.id).Admission_Status__c /*&& appRec.Admission_Status__c !=Trigger.OldMap.get(appRec.id).Total_Family_Income__c */){
        appIds.add(appRec.id);
    }
}

List<FUA_Payment__c> listPayment=[Select Id, FUA_Application__c,FUA_Amount__c,
                                  FUA_Order_Status__c,FUA_Application__r.Contact__c,FUA_Tracking_Id__c,
                                  FUA_Bank_Ref_No__c,DD_Number__c ,Branch__c,Drawn_on_Bank_Name__c,Fee_Type__c,
                                  FUA_Order_Id__c,Paid_By__c,Payment_Date__c,FUA_Payment_Mode__c,Reciept_Date__c,Scratch_Card_Number__c
from FUA_Payment__c where FUA_Application__c IN : appIds AND FUA_Order_Status__c='Success'];
List<Application__c> listApplication=[Select Id, Contact__c,Contact__r.Father_s_First_Name__c,Contact__r.Father_s_Last_Name__c, Contact__r.AccountId,
                                      Contact__r.Father_s_Email_ID__c,Contact__r.Father_s_Mobile_No__c,Contact__r.Father_s_Occupation__c,
                                      Contact__r.Father_s_Current_Company__c,Contact__r.Father_s_Designation__c,Contact__r.Father_s_Last_Company__c,
                                      Contact__r.Father_s_Mobile_No_Code__c,Contact__r.Mailing_Address__c,Contact__r.Mailing_Address_Line_1__c,
                                      Contact__r.Mailing_Address_Line_2__c,Contact__r.FU_Applicant_Mailing_City__c,Contact__r.Mailing_City__c,
                                      Contact__r.FU_Applicant_Mailing_Country__c,Contact__r.Mailing_Postal_Code__c,Contact__r.FU_Applicant_Mailing_State__c,
                                      Contact__r.Permanent_Address_Line_1__c,Contact__r.Permanent_Address_Line_2__c,Contact__r.FU_Applicant_Other_City__c,
                                      Contact__r.FU_Applicant_Other_Country__c,Contact__r.Permanent_Postal_Code__c,Contact__r.FU_Applicant_Other_State__c,
                                      Contact__r.Mother_s_First_Name__c,Contact__r.Mother_s_Last_Name__c, Contact__r.Mother_s_Email_ID__c,
                                      Contact__r.FUA_Mother_s_Mobile_No__c,Contact__r.FUA_Father_s_Mobile_No__c,Contact__r.Mother_s_Mobile_No__c,
                                      Contact__r.Contact_Admission_Status__c,Contact__r.Mother_s_Current_Company__c,Contact__r.Mother_s_Designation__c,
                                      Contact__r.Classification_Parent__c,Contact__r.Religion__c,Contact__r.Mother_s_Last_Company__c,
                                      Contact__r.Mother_s_Occupation__c,Contact__r.Total_Family_Income__c,Contact__r.Other_City__c,
                                      Contact__r.Mother_Tongue__c
from Application__c where Id IN : appIds AND Contact__r.AccountId!=null AND Contact__r.Father_s_Last_Name__c!=null AND Contact__r.Mother_s_Last_Name__c!=null];                                    
System.debug('The success payment list are *********************' +listPayment.size());

/* Ledger Creation When Order Status='Success' */
    if(listPayment!=null && listPayment.size()>0){
        for(FUA_Payment__c lisyPayScccess : listPayment){
              Ledger__c ledRec = new Ledger__c();
              ledRec.RecordTypeId=Schema.SObjectType.Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();  
              ledRec.Contact__c= lisyPayScccess.FUA_Application__r.Contact__c;
              ledRec.Payment__c=lisyPayScccess.id;
              ledRec.Tracking_ID__c=lisyPayScccess.FUA_Tracking_Id__c;
              ledRec.Bank_Ref_No__c=lisyPayScccess.FUA_Bank_Ref_No__c;
              ledRec.DD_Number__c =lisyPayScccess.DD_Number__c ;
              ledRec.Branch__c=lisyPayScccess.Branch__c;
              ledRec.Drawn_on_Bank_Name__c=lisyPayScccess.Drawn_on_Bank_Name__c;
              ledRec.Fee_Type__c=lisyPayScccess.Fee_Type__c;
              ledRec.Order_Id__c=lisyPayScccess.FUA_Order_Id__c;
              ledRec.Paid_By__c=lisyPayScccess.Paid_By__c;
              ledRec.Payment_Date__c=lisyPayScccess.Payment_Date__c;
              ledRec.Receipt_Date__c=lisyPayScccess.Reciept_Date__c;
              ledRec.Scratch_Card_Number__c=lisyPayScccess.Scratch_Card_Number__c;
              ledRec.Order_Status__c=lisypayscccess.FUA_Order_Status__c;
              ledRec.Source__c='Application Portal';
              ledRec.Type__c='Payment';
              ledRec.Sub_Type__c='Payment';
              ledRec.Amount__c=lisypayscccess.FUA_Amount__c;
              ledRec.Tracking_ID__c=lisypayscccess.FUA_Tracking_Id__c;
              ledRec.Payment_Mode__c=lisypayscccess.FUA_Payment_Mode__c;
            //  ledRec.=lisyPayScccess.;
              listLedgeInsert.add(ledRec);    
           }
        if(listLedgeInsert!=null && listLedgeInsert.size()>0){
            insert listLedgeInsert;        
        }   
    }    
/* Father&Mother Contact Creation When Enrolled */ 
    
 if(listApplication!=null && listApplication.size()>0){
      for(Application__c appRec : listApplication){
          appRec.COntact__r.Contact_Admission_Status__c='Enrolled';
          ListConUpdate.add(appRec.COntact__r);
          Contact conRec1=new Contact();
              conRec1.FirstName=appRec.Contact__r.Father_s_First_Name__c;
              conRec1.LastName=appRec.Contact__r.Father_s_Last_Name__c;
              conRec1.Gender__c='Male';
            conRec1.Permanent_Address_Line_1__c=appRec.Contact__r.Permanent_Address_Line_1__c;
            conRec1.Permanent_Address_Line_2__c=appRec.Contact__r.Permanent_Address_Line_2__c;
            conRec1.FU_Applicant_Other_City__c=appRec.Contact__r.FU_Applicant_Other_City__c;
           conRec1.FU_Applicant_Other_Country__c=appRec.Contact__r.FU_Applicant_Other_Country__c;
           conRec1.Permanent_Postal_Code__c=appRec.Contact__r.Permanent_Postal_Code__c;
            conRec1.FU_Applicant_Other_State__c=appRec.Contact__r.FU_Applicant_Other_State__c;
            conRec1.Mailing_Address__c=appRec.Contact__r.Mailing_Address__c;
            conRec1.Mailing_Address_Line_1__c=appRec.Contact__r.Mailing_Address_Line_1__c;
            conRec1.Mailing_Address_Line_2__c=appRec.Contact__r.Mailing_Address_Line_2__c;
            conRec1.FU_Applicant_Mailing_City__c=appRec.Contact__r.FU_Applicant_Mailing_City__c;
            conRec1.Mailing_City__c=appRec.Contact__r.Mailing_City__c;
            conRec1.FU_Applicant_Mailing_Country__c=appRec.Contact__r.FU_Applicant_Mailing_Country__c;
            conRec1.Mailing_Postal_Code__c=appRec.Contact__r.Mailing_Postal_Code__c;
            conRec1.FU_Applicant_Mailing_State__c=appRec.Contact__r.FU_Applicant_Mailing_State__c;
              conRec1.AccountId=Label.FU_Parent_Account_ID;
              conRec1.MobilePhone=appRec.Contact__r.FUA_Father_s_Mobile_No__c;
              conRec1.FU_Mobile_Phone_Code__c=appRec.Contact__r.Father_s_Mobile_No_Code__c;
              conRec1.Father_s_Current_Company__c=appRec.Contact__r.Father_s_Current_Company__c;
          conRec1.Other_City__c=appRec.Contact__r.Other_City__c;
          conRec1.Mother_Tongue__c=appRec.Contact__r.Mother_Tongue__c;
              conRec1.Father_s_Designation__c=appRec.Contact__r.Father_s_Designation__c;
              conRec1.Father_s_Last_Company__c=appRec.Contact__r.Father_s_Last_Company__c;
              conRec1.Total_Family_Income__c=appRec.Contact__r.Total_Family_Income__c;    
              conRec1.Father_s_Occupation__c=appRec.Contact__r.Father_s_Occupation__c;
              conRec1.Email=appRec.Contact__r.Father_s_Email_ID__c;
              conRec1.Father_s_Email_ID__c=appRec.Contact__r.Father_s_Email_ID__c;
              conRec1.Father_s_First_Name__c=appRec.Contact__r.Father_s_First_Name__c;
              conRec1.Father_s_Last_Name__c=appRec.Contact__r.Father_s_Last_Name__c;
              conRec1.FUA_Father_s_Mobile_No__c=appRec.Contact__r.FUA_Father_s_Mobile_No__c;
          	conRec1.Religion__c=appRec.Contact__r.Religion__c;
          conRec1.Classification_Parent__c=True;
          conRec1.Total_Family_Income__c=appRec.Contact__r.Total_Family_Income__c;
              conRec1.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Parent').getRecordTypeId();  
              listConInsert.add(conRec1);
          Contact conRec2=new Contact();
              conRec2.FirstName=appRec.Contact__r.Mother_s_First_Name__c;
              conRec2.LastName=appRec.Contact__r.Mother_s_Last_Name__c;
              conRec2.Gender__c='Female';
              conRec2.Mother_s_Current_Company__c=appRec.Contact__r.Mother_s_Current_Company__c;
              conRec2.Mother_s_Designation__c=appRec.Contact__r.Mother_s_Designation__c;
              conRec2.Mother_s_Last_Company__c=appRec.Contact__r.Mother_s_Last_Company__c;
              conRec2.FU_Mobile_Phone_Code__c=appRec.Contact__r.Mother_s_Mobile_No_Code__c;
              conRec2.Mother_s_Occupation__c=appRec.Contact__r.Mother_s_Occupation__c;
              conRec2.AccountId=Label.FU_Parent_Account_ID;
              conRec2.MobilePhone=appRec.Contact__r.FUA_Mother_s_Mobile_No__c;
              conRec2.Email=appRec.Contact__r.Mother_s_Email_ID__c;
          	  conRec2.Mother_s_First_Name__c=appRec.Contact__r.Mother_s_First_Name__c;
              conRec2.Mother_s_Last_Name__c=appRec.Contact__r.Mother_s_Last_Name__c;
           conRec2.Permanent_Address_Line_1__c=appRec.Contact__r.Permanent_Address_Line_1__c;
            conRec2.Mother_Tongue__c=appRec.Contact__r.Mother_Tongue__c;
          conRec2.Permanent_Address_Line_2__c=appRec.Contact__r.Permanent_Address_Line_2__c;
            conRec2.FU_Applicant_Other_City__c=appRec.Contact__r.FU_Applicant_Other_City__c;
            conRec2.FU_Applicant_Other_Country__c=appRec.Contact__r.FU_Applicant_Other_Country__c;
            conRec2.Permanent_Postal_Code__c=appRec.Contact__r.Permanent_Postal_Code__c;
           conRec2.FU_Applicant_Other_State__c=appRec.Contact__r.FU_Applicant_Other_State__c;
          conRec2.Other_City__c=appRec.Contact__r.Other_City__c; 
          conRec2.Mailing_Address__c=appRec.Contact__r.Mailing_Address__c;
           conRec2.Mailing_Address_Line_1__c=appRec.Contact__r.Mailing_Address_Line_1__c;
            conRec2.Mailing_Address_Line_2__c=appRec.Contact__r.Mailing_Address_Line_2__c;
            conRec2.FU_Applicant_Mailing_City__c=appRec.Contact__r.FU_Applicant_Mailing_City__c;
           conRec2.Mailing_City__c=appRec.Contact__r.Mailing_City__c;
            conRec2.FU_Applicant_Mailing_Country__c=appRec.Contact__r.FU_Applicant_Mailing_Country__c;
            conRec2.Mailing_Postal_Code__c=appRec.Contact__r.Mailing_Postal_Code__c;
            conRec2.FU_Applicant_Mailing_State__c=appRec.Contact__r.FU_Applicant_Mailing_State__c;
              conRec2.FU_Mobile_Phone_Code__c=appRec.Contact__r.Mother_s_Mobile_No_Code__c;
          	conRec2.Religion__c=appRec.Contact__r.Religion__c;
          conRec2.Classification_Parent__c=True;
          conRec2.Total_Family_Income__c=appRec.Contact__r.Total_Family_Income__c;
              conRec2.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Parent').getRecordTypeId();  
               listConInsert.add(conRec2);
      }
}
/* F&M Contact on relationship object When Enrolled */
    
if(listConInsert!=null && listConInsert.size()>0){
          insert listConInsert;
           for(Application__c appRec : listApplication)
           {
             /* Father Relation */
              hed__Relationship__c relFRec=new hed__Relationship__c();
              relFRec.hed__Contact__c=appRec.Contact__c;
              relFRec.hed__RelatedContact__c=listConInsert[0].id;
              relFRec.hed__Type__c='Father';
              listRelInsert.add(relFRec);
            /* Mother Relation */  
          	  hed__Relationship__c relMRec=new hed__Relationship__c();
              relMRec.hed__Contact__c=appRec.Contact__c;
              relMRec.hed__RelatedContact__c=listConInsert[1].id;
              relMRec.hed__Type__c='Mother';
              listRelInsert.add(relMRec);           
           }         
      } 
//////////////////////////////////////////////////////
      if(listConInsert!=null && listConInsert.size()>0)
      {
          insert listRelInsert;
      } 
      if(ListConUpdate!=null && ListConUpdate.size()>0)
      {
          update ListConUpdate;
      }
/////////////////////////////////////////////////////
}