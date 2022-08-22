public class ContactsOnGoogleMapController{
    
    public String contactJson{get;set;}
    private Account acct;
    
    public ContactsOnGoogleMapController(ApexPages.StandardController controller){
        
        this.acct = (Account)controller.getRecord();
        List<Contact> conList = [select Id,Name,Email,Phone,GoogleLatitude__c,GoogleLongitude__c,Student_Batch__c,
                                 Current_Company__c,Current_Designation__c,Primary_Contact_Type__c,Contact_Photo__c,Contact_Photo_Url__c,
                                 PhotoUrl from Contact where Primary_Contact_Type__c='Alumni'
                                 AND GoogleLatitude__c !='0'
                                 AND GoogleLatitude__c !=null
                                 AND GoogleLongitude__c!='0'
                                 AND GoogleLongitude__c !=null  limit 5000];
        String baseURL = 'https://flame--kartheek.my.salesforce.com';
        String coma = '';
        
        if(conList.size() > 0){
            contactJson = '[';
            
            for(Contact con : conList){
                contactJson += coma + '{\"title\":\"' + con.Name + '\",'+
                    '\"photo\": \"' + con.Contact_Photo_Url__c + '\",'+
                    '\"lat\": \"' + con.GoogleLatitude__c + '\",'+
                    '\"lng": \"' + con.GoogleLongitude__c +'\",'+
                    '\"address\": \"' + con.Student_Batch__c +' '+   '\",'+
                    '\"contact\": \"' + con.Current_Company__c +'<br/>'+ con.Current_Designation__c + '\"}';
                
                coma = ',';
            }
            
            contactJson += ']';
            
        }
    }
    
    
    @AuraEnabled
    public static list<contactLocationWrapper> getLocation(){
        List<contactLocationWrapper> lstCLW = new List<contactLocationWrapper>();
        List<Contact> conList = new List<Contact>([SELECT Id, Name, Email, Phone, Contact_Address_Line_1__c, Contact_Address_Line_2__c, 
                   Contact_City__c, Contact_Country__c, Contact_Zip_Code__c, Contact_State__c
                   FROM Contact Where Primary_Contact_Type__c='Alumni']);   
        
        for(contact con : conList){
            locationDetailWrapper oLocationWrap = new locationDetailWrapper();
            oLocationWrap.Street = con.Contact_Address_Line_1__c;
            oLocationWrap.PostalCode = con.Contact_Zip_Code__c;
            oLocationWrap.City = con.Contact_City__c;
            oLocationWrap.State = con.Contact_State__c;
            oLocationWrap.Country = con.Contact_Country__c != null ? con.Contact_Country__c : 'India';
            
            contactLocationWrapper oWrapper = new contactLocationWrapper();
            oWrapper.icon = 'utility:location';
            oWrapper.title = con.Name;
            oWrapper.description = con.Email;
            oWrapper.location = oLocationWrap;
            
            lstCLW.add(oWrapper);
        }
        return lstCLW;
    }
    
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public class contactLocationWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled public locationDetailWrapper location{get;set;} 
    }
    
    /* sub wrapper class to store location details for "contactLocationWrapper" location property.*/ 
    public class locationDetailWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
        @AuraEnabled public string City{get;set;}
        @AuraEnabled public string State{get;set;}
        @AuraEnabled public string Country{get;set;}
    }
    
}