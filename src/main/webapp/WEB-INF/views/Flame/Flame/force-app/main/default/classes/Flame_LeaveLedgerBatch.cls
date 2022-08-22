global class Flame_LeaveLedgerBatch implements Database.Batchable<sObject>,database.stateful{
    global set<id> allIds = new set<id>();
    global set<id> allFailedId = new set<id>();
    global set<id> allSuccessId = new set<id>();
    global Integer currentMonth = Integer.valueOf(Date.Today().Month());
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, Casual_Leave_Balance__c,Earned_Leave_Balance__c,Date_of_Joining__c,Primary_Contact_Type__c  FROM Contact where Date_of_Joining__c!=null and Date_of_Leaving__c = null and Primary_Contact_Type__c IN (\'Staff\', \'Faculty\')  AND RecordType.name = \'FU-Employee\' and (Classfication_Faculty__c = true or Classfication_Staff__c = true)');
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> listOfContacts){
        try{
            RecordType recTypeId = [Select Id From RecordType  Where SobjectType = 'Leave_Ledger__c' and DeveloperName = 'Credit'];
            Leave_Setting__mdt leaveSettingObj = [SELECT Id, Max_Earned_Leave__c, Max_Casual_Leave__c, Monthly_Earned_Leave_Credit__c, Max_Earned_Leave_Carry__c, Max_Casual_Leave_Carry__c, Monthly_Casual_Leave_Credit__c,Pro_Rata_Casual_Leave__c,Pro_Rata_Earn_Leave__c,Minimum_Days_for_Leave__c,Leave_Credit_Reason__c,Year_Start_In_Month__c FROM Leave_Setting__mdt where Label='All Leave Configurations for Employee' limit 1];
            //Leave_Creadit_Reason__c
            if(!listOfContacts.isEmpty()){
                if(leaveSettingObj != null){ 
                    if(currentMonth == leaveSettingObj.Year_Start_In_Month__c){
                        listOfContacts = Flame_UpdateYearlyLeaveLedger.updateLeaveLedger(listOfContacts,leaveSettingObj);
                    }
                    Decimal earnLeave = leaveSettingObj.Max_Earned_Leave__c - leaveSettingObj.Monthly_Earned_Leave_Credit__c;
                    List<Leave_Ledger__c> listOfLeaveLedger = new List<Leave_Ledger__c>();
                    for(Contact contactObj : listOfContacts){
                        system.Debug('currect contact '+contactObj);
                        Decimal ELeave;
                        Decimal CLeave;
                        Integer numberDaysEmployee = (contactObj.Date_of_Joining__c).daysBetween(Date.today());
                        Date LastMonth = date.today().addmonths(-1);
                        Integer numberOfDays = Date.daysInMonth(LastMonth.year(), LastMonth.month());
                        Leave_Ledger__c leaveLedgerObj = new Leave_Ledger__c();
                        if(numberDaysEmployee > leaveSettingObj.Minimum_Days_for_Leave__c && numberOfDays > numberDaysEmployee){
                            system.debug('numberDaysEmployee > leaveSettingObj.Minimum_Days_for_Leave__c && numberOfDays > numberDaysEmployee'+numberDaysEmployee +' > '+ leaveSettingObj.Minimum_Days_for_Leave__c+' && '+ numberOfDays+' > '+ numberDaysEmployee);
                            string ss = '(if(joining date - today) > 15 BUT days(last month) > (joining date - today)), then leave credit = pro-rata credit, else = 0';
                            ELeave = leaveSettingObj.Pro_Rata_Earn_Leave__c;
                            CLeave = leaveSettingObj.Pro_Rata_Casual_Leave__c;
                            listOfLeaveLedger.addAll(Flame_UpdateYearlyLeaveLedger.insertLeaveLedger(contactObj, ELeave, CLeave, leaveSettingObj,ss,recTypeId.id));
                        }
                        else if(numberDaysEmployee > numberOfDays) {
                            system.debug('numberDaysEmployee > numberOfDays'+numberDaysEmployee +' > '+ numberOfDays);
                            string ss = '(if(joining date - today) > days(last month) , then leave credit = monthly leave credit, else = pro rata credit';
                            if(contactObj.Earned_Leave_Balance__c == null){
                                system.debug('contactObj.Earned_Leave_Balance__c '+contactObj.Earned_Leave_Balance__c);
                                contactObj.Earned_Leave_Balance__c = 0;
                            }
                            if(contactObj.Casual_Leave_Balance__c == null ){
                                system.debug('contactObj.Casual_Leave_Balance__c '+contactObj.Casual_Leave_Balance__c);
                                contactObj.Casual_Leave_Balance__c = 0;
                            }
                            //Earned Leave Functionality
                            if(contactObj.Earned_Leave_Balance__c < earnLeave){
                                system.debug('contactObj.Earned_Leave_Balance__c < earnLeave '+contactObj.Earned_Leave_Balance__c +' < '+ earnLeave);
                                String ss1 = '(if(Earned Leave Balance(' +contactObj.Earned_Leave_Balance__c+ ') < earnLeave(' +earnLeave+ '))) , then leave credit = ' +leaveSettingObj.Monthly_Earned_Leave_Credit__c+ ', else = 0';
                                ELeave = leaveSettingObj.Monthly_Earned_Leave_Credit__c;
                                CLeave = null;
                                listOfLeaveLedger.addAll(Flame_UpdateYearlyLeaveLedger.insertLeaveLedger(contactObj, ELeave, CLeave, leaveSettingObj,ss1,recTypeId.id));
                            }
                            else if(contactObj.Earned_Leave_Balance__c <= leaveSettingObj.Max_Earned_Leave__c && contactObj.Earned_Leave_Balance__c >= earnLeave){
                                system.debug('contactObj.Earned_Leave_Balance__c <= leaveSettingObj.Max_Earned_Leave__c && contactObj.Earned_Leave_Balance__c >= earnLeave'+contactObj.Earned_Leave_Balance__c +'<='+ leaveSettingObj.Max_Earned_Leave__c+' && '+contactObj.Earned_Leave_Balance__c +'>='+ earnLeave);
                                string ss1 = '(if(Earned Leave Balance('+contactObj.Earned_Leave_Balance__c+') <= Max Earned Leave('+leaveSettingObj.Max_Earned_Leave__c+') AND Earned Leave Balance('+contactObj.Earned_Leave_Balance__c+') >= earnLeave('+earnLeave+'))), then leave credit = '+leaveSettingObj.Max_Earned_Leave__c+ - +contactObj.Earned_Leave_Balance__c+', else = 0';
                                ELeave = (leaveSettingObj.Max_Earned_Leave__c - contactObj.Earned_Leave_Balance__c);
                                CLeave = null;
                                if(ELeave != 0){
                                    listOfLeaveLedger.addAll(Flame_UpdateYearlyLeaveLedger.insertLeaveLedger(contactObj, ELeave, CLeave, leaveSettingObj,ss1,recTypeId.id));
                                }
                            }
                            
                            //Causal Leave Functionality3
                            Decimal CasualLeave = leaveSettingObj.Max_Casual_Leave__c-leaveSettingObj.Monthly_Casual_Leave_Credit__c;
                            if(contactObj.Casual_Leave_Balance__c < CasualLeave){
                                system.debug('contactObj.Casual_Leave_Balance__c < CasualLeave'+contactObj.Casual_Leave_Balance__c +'<'+ CasualLeave);
                                String ss1 = '(if(Casual Leave Balance('+contactObj.Casual_Leave_Balance__c+ ') < CasualLeave(' +CasualLeave+'))) , then leave credit = '+leaveSettingObj.Monthly_Casual_Leave_Credit__c+ ', else = 0';
                                ELeave = null;
                                CLeave = leaveSettingObj.Monthly_Casual_Leave_Credit__c;
                                listOfLeaveLedger.addAll(Flame_UpdateYearlyLeaveLedger.insertLeaveLedger(contactObj, ELeave, CLeave, leaveSettingObj,ss1,recTypeId.id));
                            }
                            else if(contactObj.Casual_Leave_Balance__c <= leaveSettingObj.Max_Casual_Leave__c && contactObj.Casual_Leave_Balance__c >= CasualLeave){
                                system.debug('contactObj.Casual_Leave_Balance__c <= leaveSettingObj.Max_Casual_Leave__c && contactObj.Casual_Leave_Balance__c >= CasualLeave'+contactObj.Casual_Leave_Balance__c+ '<= '+leaveSettingObj.Max_Casual_Leave__c +'&&'+ contactObj.Casual_Leave_Balance__c +'>='+ CasualLeave);
								String ss1 = '(if(Casual Leave Balance('+contactObj.Casual_Leave_Balance__c+') <= Max Casual Leave('+leaveSettingObj.Max_Casual_Leave__c+') AND Casual Leave Balance('+contactObj.Casual_Leave_Balance__c+') >= CasualLeave('+CasualLeave+'))) , then leave credit = '+leaveSettingObj.Max_Casual_Leave__c+ - +contactObj.Casual_Leave_Balance__c+', else = 0';
                                ELeave = null;
                                CLeave = leaveSettingObj.Max_Casual_Leave__c - contactObj.Casual_Leave_Balance__c;
                                if(CLeave != 0){
                                    listOfLeaveLedger.addAll(Flame_UpdateYearlyLeaveLedger.insertLeaveLedger(contactObj, ELeave, CLeave, leaveSettingObj,ss1,recTypeId.id));
                                }
                            }
                        }
                    }
                    
                    if (!listOfLeaveLedger.isEmpty()) {
                        database.SaveResult[] myResult = database.insert(listOfLeaveLedger,false);
                        for(database.SaveResult s : myResult){
                            if(!s.isSuccess()){
                                database.Error[] er = s.getErrors();
                                for(database.Error e : er){
                                    for(id i : allIds){
                                        if(!allSuccessId.contains(i)){
                                            allFailedId.add(i);
                                            system.debug('failed Ids----' +allFailedId);
                                        }
                                        system.debug('Failes message----' +e.getMessage());
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }catch(Exception ex){
            System.debug('========'+ex.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}