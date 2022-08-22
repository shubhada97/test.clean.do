public without sharing class FlameAlumniController {
   
    @AuraEnabled
    public static List<contactLocationWrapper> getLocation(integer pageNumber,integer pageSize){
          System.debug('pageNumber-->'+pageNumber);
          System.debug('pageSize-->'+pageSize);
         Integer offset = (pageNumber - 1) * pageSize;
        System.debug('offset-->'+offset);
        Integer totalRecords = [SELECT COUNT() FROM Contact Where Primary_Contact_Type__c='Alumni'];
        Integer recordEnd = pageSize * pageNumber;
        system.debug('pagenumber'+recordEnd);
        List<contactLocationWrapper> lstCLW = new List<contactLocationWrapper>();
        contactLocationWrapper lstCLW1 = new contactLocationWrapper();

        List<Contact> conList = new List<Contact>([SELECT Id, Name, Email,GoogleLatitude__c,GoogleLongitude__c, Phone, Contact_Address_Line_1__c, Contact_Address_Line_2__c, 
                   Contact_City__c, Contact_Country__c, Contact_Zip_Code__c, Contact_State__c,Current_Company__c,Current_Designation__c,
                   Contact_Photo__c,Contact_Photo_Url__c,Student_Batch__c,Department__c
                   FROM Contact Where Primary_Contact_Type__c='Alumni' AND GoogleLatitude__c !='0'
                                 AND GoogleLatitude__c !=null
                                 AND GoogleLongitude__c!='0'
                                 AND GoogleLongitude__c !=null    LIMIT :pageSize OFFSET :offset]);   
         system.debug('conList-->'+conList);
       for(contact con : conList){
            locationLatLong oLocationWrap = new locationLatLong();
           	oLocationWrap.Latitude = con.GoogleLatitude__c;
            oLocationWrap.Longitude =con.GoogleLongitude__c;
            //oLocationWrap.Street = con.Contact_Address_Line_1__c;
            //oLocationWrap.PostalCode = con.Contact_Zip_Code__c;
            //oLocationWrap.City = con.Contact_City__c;
           // oLocationWrap.State = con.Contact_State__c;
           // oLocationWrap.Country = con.Contact_Country__c != null ? con.Contact_Country__c : 'India';
           // oLocationWrap.currentCompony = con.Current_Company__c;
          //  oLocationWrap.currentDesignation = con.Current_Designation__c;
            system.debug('oLocationWrap--'+oLocationWrap);
            
            contactLocationWrapper oWrapper = new contactLocationWrapper();
            oWrapper.icon = 'utility:location';
            oWrapper.title = con.Name;  
          
            if(con.Email == null){
				con.Email = '';
			}
            if(con.Current_Company__c == null){
				con.Current_Company__c = '';
			}
            if(con.Current_Designation__c == null){
				con.Current_Designation__c = '';
			}
            if(con.Student_Batch__c == null){
				con.Student_Batch__c = '';
			}
            if(con.Department__c == null){
				con.Department__c = '';
			}
            
            
            oWrapper.description = '<br/><b>Company: '+con.Current_Company__c+''+'<br/><b>Designation: '+con.Current_Designation__c+''+'<br/></b>Batch: '+con.Student_Batch__c+''+'<br/>';
          // '+'<br/><b>Photo: '+con.Contact_Photo__c+',
            oWrapper.location = oLocationWrap;
            oWrapper.pageNumber = pageNumber;
            oWrapper.pageNumber = pageNumber;
           // oWrapper.recordStart = offset + 1;
          //  oWrapper.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
          //  oWrapper.totalRecords = totalRecords;
            
            lstCLW.add(oWrapper);
            
            
        }
        system.debug('lstCLW--'+lstCLW);
        return lstCLW;
    }
    
   
     @AuraEnabled
    public static list<contactLocationWrapper> getLocationOnchange(String searchString,integer pageNumber,integer pageSize){
         String newSearchText = '%'+searchString+'%';
        Integer offset = (pageNumber - 1) * pageSize;
        Integer totalRecords = [SELECT COUNT() FROM Contact where Primary_Contact_Type__c='Alumni' AND (Name Like:newSearchText OR Contact_City__c Like:newSearchText OR Contact_State__c Like:newSearchText OR Contact_Country__c Like:newSearchText)];
        system.debug('totalRecords-->'+totalRecords);
        Integer recordEnd = pageSize * pageNumber;
      
        List<contactLocationWrapper> lstCLW = new List<contactLocationWrapper>();
        List<Contact> conList = new List<Contact>([SELECT Id,GoogleLatitude__c,GoogleLongitude__c, Name, Email, Phone, Contact_Address_Line_1__c, Contact_Address_Line_2__c, 
                   Contact_City__c, Contact_Country__c, Contact_Zip_Code__c, Contact_State__c,Current_Company__c,Current_Designation__c,
                   Contact_Photo__c,Contact_Photo_Url__c,Student_Batch__c,Department__c
                   FROM Contact Where Primary_Contact_Type__c='Alumni' AND (Name Like:newSearchText OR Contact_City__c Like:newSearchText OR Contact_State__c Like:newSearchText OR Contact_Country__c Like:newSearchText) AND GoogleLatitude__c !='0'
                                 AND GoogleLatitude__c !=null
                                 AND GoogleLongitude__c!='0'
                                 AND GoogleLongitude__c !=null  LIMIT :pageSize OFFSET :offset ]);   
        system.debug('conList-->'+conList);
        system.debug('conList-->'+conList.size());
        for(contact con : conList){
           locationLatLong oLocationWrap = new locationLatLong();
           	oLocationWrap.Latitude = con.GoogleLatitude__c;
            oLocationWrap.Longitude =con.GoogleLongitude__c;
            //oLocationWrap.Street = con.Contact_Address_Line_1__c;
            //oLocationWrap.PostalCode = con.Contact_Zip_Code__c;
            //oLocationWrap.City = con.Contact_City__c;
           // oLocationWrap.State = con.Contact_State__c;
           // oLocationWrap.Country = con.Contact_Country__c != null ? con.Contact_Country__c : 'India';
           // oLocationWrap.currentCompony = con.Current_Company__c;
          //  oLocationWrap.currentDesignation = con.Current_Designation__c;
            system.debug('oLocationWrap--'+oLocationWrap);
            
            contactLocationWrapper oWrapper = new contactLocationWrapper();
            oWrapper.icon = 'utility:location';
            oWrapper.title = con.Name;  
            if(con.Email == null){
				con.Email = '';
			}
            if(con.Current_Company__c == null){
				con.Current_Company__c = '';
			}
            if(con.Current_Designation__c == null){
				con.Current_Designation__c = '';
			}
            if(con.Student_Batch__c == null){
				con.Student_Batch__c = '';
			}
            if(con.Department__c == null){
				con.Department__c = '';
			}
            
            
            oWrapper.description = '<br/><b>Company: '+con.Current_Company__c+''+'<br/><b>Designation: '+con.Current_Designation__c+''+'<br/></b>Batch: '+con.Student_Batch__c+''+'<br/>';
          // '+'<br/><b>Photo: '+con.Contact_Photo__c+',
            oWrapper.location = oLocationWrap;
             oWrapper.pageNumber = pageNumber;
            oWrapper.pageNumber = pageNumber;
           // oWrapper.recordStart = offset + 1;
           // oWrapper.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
            oWrapper.totalRecords = totalRecords;
            lstCLW.add(oWrapper);
        }
        system.debug('lstCLW--'+lstCLW);
        return lstCLW;
    }
    
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public without sharing class contactLocationWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Contact> contactList {get;set;}
        
        @AuraEnabled public locationLatLong location{get;set;} 
        
        
    }
    /* sub wrapper class to store location details for "contactLocationWrapper" location property.*/ 
    public without sharing class locationDetailWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
        @AuraEnabled public string City{get;set;}
        @AuraEnabled public string State{get;set;}
        @AuraEnabled public string Country{get;set;}
         @AuraEnabled public string currentDesignation{get;set;} 
        @AuraEnabled public string currentCompony{get;set;} 
    }
    
    public without sharing class locationLatLong{
        @AuraEnabled public string Latitude{get;set;}
        @AuraEnabled public string Longitude{get;set;}
    }
       
    
}