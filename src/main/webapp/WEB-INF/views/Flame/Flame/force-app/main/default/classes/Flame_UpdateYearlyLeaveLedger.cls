public class Flame_UpdateYearlyLeaveLedger {
    public static List<Contact> updateLeaveLedger(List<Contact> listOfContacts,Leave_Setting__mdt leaveSettingObj){
        try{
            if(!listOfContacts.isEmpty()){
                if(leaveSettingObj != null){
                    for(Contact contactObj : listOfContacts){
                        if(contactObj.Earned_Leave_Balance__c > leaveSettingObj.Max_Earned_Leave_Carry__c){
                            contactObj.Earned_Leave_Balance__c = leaveSettingObj.Max_Earned_Leave_Carry__c;
                        }
                        if(contactObj.Casual_Leave_Balance__c > leaveSettingObj.Max_Casual_Leave_Carry__c){
                            contactObj.Casual_Leave_Balance__c = leaveSettingObj.Max_Casual_Leave_Carry__c;
                        }
                    }
                }
            }
        }catch(Exception ex){
            System.debug('===2====='+ex.getMessage());
        }
        update listOfContacts;
        system.debug('updated contact');
        return listOfContacts;
    } 
    
    public static List<Leave_Ledger__c> insertLeaveLedger(Contact contactObj,Decimal earnLeave , Decimal casualLeave,Leave_Setting__mdt leaveSettingObj,String ss1, Id recTypeId){
        List<Leave_Ledger__c> listLeaveLedger = new List<Leave_Ledger__c>();

        try{
            if(contactObj != null){
                if(leaveSettingObj != null){
                    if(earnLeave != null){
                        Leave_Ledger__c leaveLedgerObj = new Leave_Ledger__c();
                        leaveLedgerObj.Reason__c = leaveSettingObj.Leave_Credit_Reason__c;
                        leaveLedgerObj.Employee_Name__c = contactObj.Id;
                        leaveLedgerObj.Leave_Type__c = 'Earned Leave';
                        leaveLedgerObj.Total_Days__c = earnLeave;
                        leaveLedgerObj.Leave_Action__c ='Credit';
                        leaveLedgerObj.RecordTypeId = recTypeId;
                        leaveLedgerObj.Credit_formula__c = ss1;
                        listLeaveLedger.add(leaveLedgerObj);
                    }
                    
                    if(casualLeave != null){
                        Leave_Ledger__c leaveLedgerObj = new Leave_Ledger__c();
                        leaveLedgerObj.Reason__c = leaveSettingObj.Leave_Credit_Reason__c;
                        leaveLedgerObj.Employee_Name__c = contactObj.Id;
                        leaveLedgerObj.Leave_Type__c = 'Casual Leave';
                        leaveLedgerObj.Total_Days__c = casualLeave;
                        leaveLedgerObj.Leave_Action__c ='Credit';
                        leaveLedgerObj.RecordTypeId = recTypeId;
                        leaveLedgerObj.Credit_formula__c = ss1;
                        listLeaveLedger.add(leaveLedgerObj);
                    }
                }
            }
        }
        catch(exception e){
            system.debug('eee::'+e.getMessage());
        }
        
        system.debug('formed leave ledger '+listLeaveLedger);
        return listLeaveLedger;
    }
}