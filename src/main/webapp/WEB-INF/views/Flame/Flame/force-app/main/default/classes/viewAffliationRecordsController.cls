public with sharing class viewAffliationRecordsController {
  
    private list<account> lstofAccount;
    public set<string> setofRecordTypeid;
    public List<hed__Affiliation__c> lstofAfflication {get;set;}
    public List<hed__Affiliation__c> lstofAfflication1 {get;set;}
    public List<hed__Affiliation__c> lstofAfflicationofOrgType {get;set;}
    public map<string,List<hed__Affiliation__c>> mapofAccRecordTypeNametoLstoAff{get;set;}
    public map<string,List<hed__Affiliation__c>> mapofOrgTypeNametoLstoAff{get;set;}
    public set<string> setofAffType;
    public viewAffliationRecordsController(){
        setofAffType = new set<string>();
        setofRecordTypeid =  new set<string>();
        mapofAccRecordTypeNametoLstoAff  =  new map<string,List<hed__Affiliation__c>>();
        mapofOrgTypeNametoLstoAff  =  new map<string,List<hed__Affiliation__c>>();
        lstofAccount = new List<Account>();
        lstofAfflication  = new list<hed__Affiliation__c>();
        lstofAfflication1  = new list<hed__Affiliation__c>();
        for(Account objAcc:[select id,name,recordtypeId,RecordType.name,industry,billingcountry,createdbyid from account]){
        
            setofRecordTypeid.add(objAcc.RecordType.name);
            lstofAccount.add(objAcc);
        }
        if(!setofRecordTypeid.isEmpty()){
            
                lstofAfflication = [Select ID,Name, hed__Affiliation_Type__c,hed__Account__c,hed__Description__c,hed__Contact__c,hed__Contact__r.name,
                                            CTC_Per_Annum__c,hed__EndDate__c,hed__Account__r.name,hed__Role__c,hed__StartDate__c,
                                            hed__Status__c From hed__Affiliation__c where hed__Status__c ='Current' order by hed__Affiliation_Type__c Asc];//hed__Affiliation_Type__c IN:setofRecordTypeid and 

        }
        
        for(hed__Affiliation__c  objAff: lstofAfflication ){
           
if(objAff.hed__Status__c == 'Current' && objAff.hed__Affiliation_Type__c == 'University Committee' || objAff.hed__Affiliation_Type__c == 'University Body' || objAff.hed__Affiliation_Type__c == 'University Centre'){
                            
            if(!setofAffType.contains(objAff.hed__Affiliation_Type__c)){
            setofAffType.add(objAff.hed__Affiliation_Type__c);
                lstofAfflication1.add(objAff);
            }
          }  
          }
        
        
        set<string> setofOrgName = new set<string>();
        for(hed__Affiliation__c  objAff: lstofAfflication){
            if(!setofOrgName.contains(objAff.hed__Account__r.Name)){
            setofOrgName.add(objAff.hed__Account__r.name);
            if(mapofAccRecordTypeNametoLstoAff.get(objAff.hed__Affiliation_Type__c)==null){
            
                mapofAccRecordTypeNametoLstoAff.put(objAff.hed__Affiliation_Type__c,new List<hed__Affiliation__c>());
            }
              mapofAccRecordTypeNametoLstoAff.get(objAff.hed__Affiliation_Type__c).add(objAff);
            }
        }
    
        for(hed__Affiliation__c  objAff: lstofAfflication){
            if(mapofOrgTypeNametoLstoAff.get(objAff.hed__Account__r.name)==null){
            
                mapofOrgTypeNametoLstoAff.put(objAff.hed__Account__r.name,new List<hed__Affiliation__c>());
            }
              mapofOrgTypeNametoLstoAff.get(objAff.hed__Account__r.name).add(objAff);
       
        }
    
       
    }
  
    
  

}