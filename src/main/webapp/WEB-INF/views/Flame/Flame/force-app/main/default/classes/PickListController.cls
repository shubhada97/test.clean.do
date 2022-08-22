public class PickListController {
    @AuraEnabled
    public static Map<String, String>  getCountry() {
        
        Http h = new Http();    
        
        HttpRequest req = new HttpRequest();
        req.setHeader('X-CSCAPI-KEY', 'aDZEc2VEaEpiaHA2WUlhVXhOdndBejI2ZXVjdnFydUozWHJFWlBQcA==');
        req.setEndpoint('https://api.countrystatecity.in/v1/countries');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        Map<String, String> countryMap = new Map<String, String>();
        
        if(res.getStatusCode() == 200){
            try{
                List<Object> countryList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                
                for(Object obj : countryList){
                    Map<String, Object> mapOfCountry = (Map<String, Object>) obj;
                    countryMap.put((String)mapOfCountry.get('iso2'), (String)mapOfCountry.get('name'));
                }
            }
            catch(Exception e) {
                System.debug('An exception occurred: ' + e.getMessage());
                
            }
            return countryMap;
        }else{
            return null;
        }
        
        
        
        
    }
    
    @AuraEnabled
    public static Map<String, String> getStateByCountry(String countryIso) {
        
        Http h = new Http();    
        
        HttpRequest req = new HttpRequest();
        req.setHeader('X-CSCAPI-KEY', 'aDZEc2VEaEpiaHA2WUlhVXhOdndBejI2ZXVjdnFydUozWHJFWlBQcA==');
        req.setEndpoint('https://api.countrystatecity.in/v1/countries/'+countryIso+'/states');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        Map<String, String> StateMap = new Map<String, String>();
        
        if(res.getStatusCode() == 200){
            try{
                List<Object> StateList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                System.debug('StateList-->'+StateList);
                for(Object obj : StateList){
                    Map<String, Object> mapOfState = (Map<String, Object>) obj;
                    StateMap.put((String)mapOfState.get('iso2'), (String)mapOfState.get('name'));
                }
            }
            catch(Exception e) {
                System.debug('An exception occurred: ' + e.getMessage());
                
            }
            return StateMap;
        }else{
            return null;
        }
    }
    
    
    
    @AuraEnabled
    public static List<Object> getCityByStateCountry(String countryIso, String stateIso) {
        
        Http h = new Http();    
        system.debug('countryIso-->'+countryIso);
        system.debug('stateIso-->'+stateIso);
        HttpRequest req = new HttpRequest();
        req.setHeader('X-CSCAPI-KEY', 'aDZEc2VEaEpiaHA2WUlhVXhOdndBejI2ZXVjdnFydUozWHJFWlBQcA==');
        req.setEndpoint('https://api.countrystatecity.in/v1/countries/'+countryIso+'/states/'+stateIso+'/cities');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        List<String> ListOfCity = new List<String>();
        
        if(res.getStatusCode() == 200){
            try{
                List<Object> cityList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                System.debug('countryList1-->'+cityList);
                for(Object obj : cityList){
                    system.debug('obj-->'+obj);
                    Map<String, Object> mapOfCity = (Map<String, Object>) obj;
                    ListOfCity.add((String)mapOfCity.get('name'));
                    // countryMap.put(Integer.valueOf(mapOfCountry.get('id')), (String)mapOfCountry.get('name'));
                }
            }
            catch(Exception e) {
                System.debug('An exception occurred: ' + e.getMessage());
                
            }
            system.debug('ListOfCity-->'+ListOfCity);
            return ListOfCity;
        }else{
            return null;
        }
    }
    
    @AuraEnabled
    public static void SaveRecord(String country, String state, String city, String recordId, String objectAPIName, String countryField, String stateField, String cityField) // String malingCountry, String mailingState, String mailingCity
    {
        string queryString ='';
        //  string fieldNames = '';
        // fieldNames = ''+ countryField +', '+ stateField +', '+ cityField +'';
        queryString='select '+ countryField +', '+ stateField +', '+ cityField +' from '+ objectAPIName +' WHERE Id =:recordId LIMIT 1';
        
        
        // returnList=database.query(queryString);
        sObject queriedContact = database.query(queryString);
        
        queriedContact.put(countryField,country);
        queriedContact.put(stateField,state);
        queriedContact.put(cityField,city);
        system.debug('queriedContact-------->'+queriedContact);
        try{
            update queriedContact;
        }
        catch(Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
            
        }
        /* Contact queriedContact = [SELECT Contact_Country__c,Contact_State__c,Contact_City__c,FU_Applicant_Mailing_Country__c,
FU_Applicant_Mailing_State__c,FU_Applicant_Other_City__c
FROM Contact 
WHERE Id =: recordId
LIMIT 1];*/
        system.debug('country-->'+country);
        system.debug('state-->'+state);
        system.debug('city-->'+city);
        
        
    }
    
    /*@AuraEnabled
public static List<Contact_Setting__mdt> getRecordTypeId( String recordId, String objectAPIName) {

string queryStringForRecordTypeId ='';
queryStringForRecordTypeId='select RecordTypeId from '+ objectAPIName +' WHERE Id =:recordId LIMIT 1';
// String recordTypeName ;
sObject conRecordTypeId = database.query(queryStringForRecordTypeId); 


system.debug('conRecordTypeId-->'+conRecordTypeId);

RecordType recordTypeName = [select name from RecordType where id=:(String)conRecordTypeId.get(RecordType.Id)];
system.debug('recordTypeName-->'+recordTypeName);
//  String recordTypeName = (String)conRecordTypeId.get(RecordType.Name);
//  contact conRecordTypeId = [select id,name,RecordType.Name from contact where  id=:recordId Limit 1];

//                  system.debug('conRecordTypeId-->'+conRecordTypeId.RecordType.Name);
List<Contact_Setting__mdt> listOfContactCostomMetData = [SELECT RecordType__c,Mailing_Address__c,Contact_Address__c from Contact_Setting__mdt where RecordType__c=:recordTypeName.name Limit 1];
system.debug('listOfContactCostomMetData-->'+listOfContactCostomMetData);
return listOfContactCostomMetData;

}*/
    
    @AuraEnabled
    public static List<Object> getCityByCountry(String countryIso) {
        
        Http h = new Http();    
        
        HttpRequest req = new HttpRequest();
        req.setHeader('X-CSCAPI-KEY', 'aDZEc2VEaEpiaHA2WUlhVXhOdndBejI2ZXVjdnFydUozWHJFWlBQcA==');
        req.setEndpoint('https://api.countrystatecity.in/v1/countries/'+countryIso+'/cities');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        List<String> ListOfCity = new List<String>();
        if(res.getStatusCode() == 200){
            try{
                List<Object> cityList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                //cityList.sort();
                System.debug('countryList2-->'+cityList);
                for(Object obj : cityList){
                    system.debug('obj-->'+obj);
                    Map<String, Object> mapOfCity = (Map<String, Object>) obj;
                    ListOfCity.add((String)mapOfCity.get('name'));
                    // countryMap.put(Integer.valueOf(mapOfCountry.get('id')), (String)mapOfCountry.get('name'));
                }
            }
            catch(Exception e) {
                System.debug('An exception occurred: ' + e.getMessage());
                
            }
            system.debug('ListOfCity-->'+ListOfCity);
            return ListOfCity;
        }else{
            return null;
        }
    }
}