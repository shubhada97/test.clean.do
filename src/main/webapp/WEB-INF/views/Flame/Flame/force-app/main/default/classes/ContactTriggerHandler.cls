/*
        CreatedDate:05-03-2020
        Author: Sharath
        Apex Class:ContactTriggerHandler
        Description: This class handle the Contact triggers and refer in ContactTrigger on Contact Object
        
*/
public class ContactTriggerHandler {
    
    private boolean Image = True;
    private integer BatchSize = 0;
  
    public ContactTriggerHandler(boolean isExecuting, integer size)
    {
        Image = isExecuting;
        BatchSize = size;
    }
    
    /*public void OnBeforeUpdate(list<Contact> triggerNew, map<id,Contact> triggerNewMap, map<id,Contact> triggerOldMap){
    }*/
   
    public void OnAfterInsert(list<Contact> triggerNew, map<id,Contact> triggerNewMap){
       //ContactAlumniProfileoldvalues(triggerNew ,null);
    }
    public void OnAfterUpdate(list<Contact> triggerNew, map<id,Contact> triggeroldMap)
    {
       ContactAlumniProfileoldvalues(triggerNew , triggeroldMap);
    }
    /*
        CreatedDate:05-03-2020
        Author: Sharath
        Method:ContactAlumniProfileoldvalues
        Description: This method is used for Creating Comment_History_c record when external user
        update the personal information. and storing the old values in comment history object
        Using fieldset on contact Fields set Name :"ChangeContactField" based on these fields changes we are creating the reords
        
    */
    private void ContactAlumniProfileoldvalues(list<Contact> triggerNew ,map<id,Contact> triggeroldMap)
    {
        set<id> setofConId = new set<id>();
        list<Comment_History__c> lstofCH = new list<Comment_History__c>();
        set<String> changedFieldSet  = new Set<String>();

        set<String> fieldSet = new Set<String>();
        //dynamically get the fields from the field set and then use the same for comparison in the trigger. 
        for(Schema.FieldSetMember fields :Schema.SObjectType.Contact.fieldSets.getMap().get('ChangeContactField').getFields()){
            fieldSet.add(fields.getFieldPath());
        }
        for(Contact con: triggerNew){
            if(con.RecordTypeId == Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Alumni').getRecordTypeId()){
               if(fieldSet!=null && fieldSet.size()>0){
                    for(string s: fieldSet){
                    if(con.get(s) !=null && (con.get(s) != triggeroldMap.get(con.Id).get(s)) ){
                            changedFieldSet.add(s);//adding fields whose value changed
                        }
                    }
                }   
            }
        
        }

        if(changedFieldSet.size()>0){
        
            for(Contact con: triggerNew){
                    Comment_History__c objCH = new  Comment_History__c();
                    objCH.Contact_Alumni_Email_New__c                   = con.Email;
                    objCH.Contact_Alumni_Phone_Number_New__c            = con.MobilePhone;
                    objCH.Contact_Alumni_LinkedIn_profile_URL_New__c    = con.LinkedIn_profile_URL__c;               
                    objCH.Contact_Alumni_Current_Company_New__c         = con.Current_Company__c; 
                    objCH.Contact_Alumni_Current_Designation_New__c     = con.Current_Designation__c;
                    objCH.Contact_Alumni_Address_Line_1_New__c          = con.Contact_Address_Line_1__c;
                    objCH.Contact_Alumni_Address_Line_2_New__c          = con.Contact_Address_Line_2__c;
                    objCH.Contact_Alumni_Industry_New__c                = con.Industry__c;
                    objCH.Contact_Alumni_Country_New__c                 = con.Contact_Country__c;
                    objCH.Contact_Alumni_State_New__c                   = con.Contact_State__c;
                    objCH.Contact_Alumni_City_New__c                    = con.Contact_City__c;
                    objCH.Contact_Alumni_Zip_Code_New__c                = con.Contact_Zip_Code__c;
                    objCH.Contact_Alumni_OtherCity_New__c               = con.Other_City__c;
                
                    //Old Values
                
                    objCH.Contact_Alumni_Email_Old__c                 = triggeroldMap.get(con.id).Email;
                    objCH.Contact_Alumni_Phone_Number_Old__c          = triggeroldMap.get(con.id).MobilePhone;
                    objCH.Contact_Alumni_LinkedIn_profile_URL_Old__c  = triggeroldMap.get(con.id).LinkedIn_profile_URL__c;
                    objCH.Contact_Alumni_Current_Company_Old__c       = triggeroldMap.get(con.id).Current_Company__c;
                    objCH.Contact_Alumni_Current_Designation_Old__c   = triggeroldMap.get(con.id).Current_Designation__c;
                    objCH.Contact_Alumni_Address_Line_1_Old__c        = triggeroldMap.get(con.id).Contact_Address_Line_1__c;
                    objCH.Contact_Alumni_Address_Line_2_Old__c        = triggeroldMap.get(con.id).Contact_Address_Line_2__c;
                    objCH.Contact_Alumni_Industry_old__c              = triggeroldMap.get(con.id).Industry__c;
                    objCH.Contact_Alumni_Country_Old__c               = triggeroldMap.get(con.id).Contact_Country__c;
                    objCH.Contact_Alumni_State_Old__c                 = triggeroldMap.get(con.id).Contact_State__c;
                    objCH.Contact_Alumni_City_Old__c                  = triggeroldMap.get(con.id).Contact_City__c;
                    objCH.Contact_Alumni_Zip_Code_Old__c              = triggeroldMap.get(con.id).Contact_Zip_Code__c;
                    objCH.Contact_Alumni_OtherCity_Old__c             = triggeroldMap.get(con.id).Other_City__c;
                    objCH.Contact__c = con.id; 
                    lstofCH.add(objCH);
            }
            
        }

        if(lstofCH !=null && lstofCH.size()>0){
            insert lstofCH;
        }
        
    }
 
}