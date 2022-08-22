public class StudentInOutDashboardController{
    
    @AuraEnabled
    public static List<Account>  getBatchOfFlameStudents() {
        
        List<Account> listOfAccount = [select Id,name from account where name LIKE : 'FLAME Students%'];
        system.debug('listOfAccount:'+listOfAccount);
        return listOfAccount;
    }
    
    
    
    @AuraEnabled
    public static List<Employee_Calendar__c>  fetchBatchFilterStudents(String searchKeyWord, String searchContactType,String mainGateEnteryInFilter, String mainGateEnteryOutFilter) {
        
        //getting lookup fields
        List<contact> contactRecords = new List<contact>();
       
        if(searchKeyWord!='all' && searchContactType=='all'){
        	contactRecords = [SELECT Id FROM contact where accountId =: searchKeyWord];
        }else if(searchKeyWord=='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where Primary_Contact_Type__c LIKE: searchContactType];
        }else if(searchKeyWord!='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
            contactRecords = [SELECT Id FROM contact where RecordType.Name Like 'FU-Employee' OR RecordType.Name Like 'FU-Student'];
        }
        system.debug('contactRecords::>'+contactRecords);
        
        Set<Id> contactIds = (new Map<Id,contact>(contactRecords)).keySet();
		
        system.debug('contactIds::>'+contactIds);
        
        //getting max createdDate for users
        List<AggregateResult> recordsPunchOut = [SELECT contact_Name__c, MAX(CreatedDate) maxRecord FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds GROUP BY contact_Name__c];
        //put dates in a list
        Set<Datetime> cDates = new Set<Datetime>();
        Set<Datetime> cDatesPunchIn = new Set<Datetime>();
        For(AggregateResult record : recordsPunchOut){
            cDates.add(Datetime.valueOf(record.get('maxRecord')));
        }
        system.debug('cDates::>'+cDates);
        
        List<Employee_Calendar__c> latestRecords = new List<Employee_Calendar__c>();
        Boolean checked = True;
        
        if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'False'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True AND Main_Gate_Out__c =: False]; 
        }else if(mainGateEnteryInFilter=='False' && mainGateEnteryOutFilter == 'True'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_Out__c =: True]; 
        }else if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'True'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True AND Main_Gate_Out__c =: True]; 
        }else{
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds AND createddate IN :cDates]; 
        }
        system.debug('latestRecords::>'+latestRecords);
        
        return latestRecords; 

    }
    
    
    
    @AuraEnabled
    public static List<String> getPrimaryContactType()
    {
        List<String> myContactType = new List<String>();
        myContactType.add('Student - LOA');
        myContactType.add('Student - Study Abroad');
        myContactType.add('Student');
        return myContactType;
    }
    
    @AuraEnabled
    public static List<String> loadMainGateEnteryRecord()
    {
        List<String> mainGateEntery = new List<String>();
        mainGateEntery.add('Yes');
        mainGateEntery.add('No');
        return mainGateEntery;
    }
    
    
    @AuraEnabled
    public static List<Employee_Calendar__c> fetchEmployeeCalendarRecords(){
        
         //getting lookup fields
        List<contact> contactRecords = new List<contact>();
        contactRecords = [SELECT Id FROM contact where RecordType.Name Like 'FU-Employee' OR RecordType.Name Like 'FU-Student'];
        system.debug('DefaultData-contactRecords-->'+contactRecords);
        
        Set<Id> contactIds = (new Map<Id,contact>(contactRecords)).keySet();
		system.debug('DefaultData-contactIds-->'+contactIds);
        //getting max createdDate for users
        List<AggregateResult> recordsPunchOut = [SELECT contact_Name__c, MAX(CreatedDate) maxRecord FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds GROUP BY contact_Name__c];
       // List<AggregateResult> recordsPunchIn = [SELECT contact_Name__c, MAX(Punch_In_DateTime__c) maxPunchIn FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds GROUP BY contact_Name__c];

        //put dates in a list
        Set<Datetime> cDates = new Set<Datetime>();
        Set<Datetime> cDatesPunchIn = new Set<Datetime>();
        For(AggregateResult record : recordsPunchOut){
            cDates.add(Datetime.valueOf(record.get('maxRecord')));
           // cDatesPunchIn.add(Datetime.valueOf(record.get('maxPunchIn')));
        }
        system.debug('DefaultData-cDates-->'+cDates);
       // system.debug('cDatesPunchIn-->'+cDatesPunchIn);
       /* Set<Datetime> cDatesPunchIn = new Set<Datetime>();
        For(AggregateResult record : recordsPunchIn){
            cDatesPunchIn.add(Datetime.valueOf(record.get('maxPunchIn')));
        }
        system.debug('cDates-->'+cDates);*/
        //finally get last record for each user (or lookup field)
        List<Employee_Calendar__c> latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds AND createddate IN :cDates];
        
        system.debug('DefaultData-latestRecords-->'+latestRecords);
        return latestRecords;
        /*
        List<Employee_Calendar__c> Emplist1 = New List<Employee_Calendar__c>();
         Emplist1 = [select Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c,Punch_Out_DateTime__c,Punch_In_Datetime__c  from Employee_Calendar__c order by createddate desc LIMIT 9999]; 
            Set<Id> EmpSetOfId = new Set<Id>();
        map<id,Employee_Calendar__c> mapEmpPunchInOutTime = new map<id,Employee_Calendar__c>();
        map<id,Employee_Calendar__c> mapEmpPunchInOutRecord = new map<id,Employee_Calendar__c>();
        map<id,Object> mapEmp = new map<id,Object>();
        for(contact c:[select id,name from contact]){
             for(Employee_Calendar__c ec: Emplist1){
                 if(c.id == ec.Contact_Name__c){
                     
                     if(ec.Punch_Out_DateTime__c !=null){
                         mapEmpPunchInOutTime.put(ec.id, ec);
                         system.debug('mapForPunchOut-->'+mapEmpPunchInOutTime);
                         if(mapEmpPunchInOutTime != null){
                             system.debug('mapnotnullforPunchOut-->'+mapEmpPunchInOutTime.get(ec.id).Punch_Out_DateTime__c);
                             system.debug('ec.PunchOutDate-->'+ec.Punch_Out_DateTime__c);
                             if(ec.Punch_Out_DateTime__c > mapEmpPunchInOutTime.get(ec.id).Punch_Out_DateTime__c){
                                 system.debug('ConditionTrueForPunchOut');
                                  mapEmpPunchInOutTime.put(ec.id, ec);
                                 system.debug('mapForPunchOutIfGreater-->'+mapEmpPunchInOutTime);
                                // mapEmpPunchInOutRecord.put(ec.id, ec);
                             }
                         }
                     }
                         else if(ec.Punch_In_DateTime__c !=null){
                             mapEmpPunchInOutTime.put(ec.id, ec);
                             system.debug('mapForPunchIn-->'+mapEmpPunchInOutTime);
                             if(mapEmpPunchInOutTime != null){
                                 system.debug('mapnotnullforPunchOut-->'+mapEmpPunchInOutTime.get(ec.id).Punch_In_DateTime__c);
                                 system.debug('ec.PunchInDate-->'+ec.Punch_In_DateTime__c);
                             if(ec.Punch_In_DateTime__c > mapEmpPunchInOutTime.get(ec.id).Punch_In_DateTime__c){
                                 system.debug('ConditionTrueForPunchOut');
                                  mapEmpPunchInOutTime.put(ec.id, ec);
                                 system.debug('mapForPunchOutIfGreater-->'+mapEmpPunchInOutTime);
                                // mapEmpPunchInOutRecord.put(ec.id, ec);
                             }
                         }
                         }
                         
                 }
            } 
            
        }
             //  system.debug('mapEmpPunchInOutRecord-->'+mapEmpPunchInOutRecord);
        system.debug('mapEmpPunchInOutTime-->'+mapEmpPunchInOutTime);
              
           
        List<Employee_Calendar__c> finalEmpList = new List<Employee_Calendar__c>();
        finalEmpList.addall(mapEmpPunchInOutTime.values());
        system.debug('finalEmpList-->'+finalEmpList);
		*/
                
    }
    
    @AuraEnabled
    public static list<Employee_Calendar__c> getStudentInData(String searchKeyWord, String searchContactType, String mainGateEnteryInFilter, String mainGateEnteryOutFilter){
        
        system.debug('searchKeyWord-->'+searchKeyWord);
        system.debug('searchContactType-->'+searchContactType);
        //getting lookup fields
        List<contact> contactRecords = new List<contact>();

       if(searchKeyWord!='all' && searchContactType=='all'){
        	contactRecords = [SELECT Id FROM contact where accountId =: searchKeyWord];
        }else if(searchKeyWord=='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where Primary_Contact_Type__c LIKE: searchContactType];
        }else if(searchKeyWord!='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
            contactRecords = [SELECT Id FROM contact where RecordType.Name Like 'FU-Employee' OR RecordType.Name Like 'FU-Student'];
        }
        
        system.debug('StudentInData-contactRecords::>'+contactRecords);
       
   		system.debug('contactRecords-->'+contactRecords);
        Set<Id> contactIds = (new Map<Id,contact>(contactRecords)).keySet();
		
        system.debug('StudentInData-contactIds::>'+contactIds);
        //getting max createdDate for users
        List<AggregateResult> recordsPunchOut = [SELECT contact_Name__c, MAX(CreatedDate) maxRecord FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds GROUP BY contact_Name__c];
       

        //put dates in a list
        Set<Datetime> cDates = new Set<Datetime>();
        Set<Datetime> cDatesPunchIn = new Set<Datetime>();
        For(AggregateResult record : recordsPunchOut){
            cDates.add(Datetime.valueOf(record.get('maxRecord')));
           // cDatesPunchIn.add(Datetime.valueOf(record.get('maxPunchIn')));
        }
        system.debug('cDates-->'+cDates);
       
        //finally get last record for each user (or lookup field)
        
        List<Employee_Calendar__c> latestRecords = new List<Employee_Calendar__c>();
        Boolean checked = True;
        
        if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'False'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_In_Datetime__c!= :null AND Punch_Out_DateTime__c =:null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True]; 
        }else if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'True'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_In_Datetime__c!= :null AND Punch_Out_DateTime__c =:null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True AND Main_Gate_Out__c =: True]; 
        }else if(mainGateEnteryInFilter=='False' && mainGateEnteryOutFilter == 'True'){  
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_In_Datetime__c!= :null AND Punch_Out_DateTime__c =:null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: False AND Main_Gate_Out__c =: True]; 
        }else{
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Name, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_In_Datetime__c!= :null AND Punch_Out_DateTime__c =:null AND contact_Name__c IN :contactIds AND createddate IN :cDates]; 
        }
        
        system.debug('StudentInData-latestRecords::>'+latestRecords);
        return latestRecords;
    }
    
    
    
    @AuraEnabled
    public static list<Employee_Calendar__c> getStudentOutData(String searchKeyWord, String searchContactType, String mainGateEnteryInFilter, String mainGateEnteryOutFilter){
        
        //getting lookup fields
       
        List<contact> contactRecords = new List<contact>();
        
        if(searchKeyWord!='all' && searchContactType=='all'){
        	contactRecords = [SELECT Id FROM contact where accountId =: searchKeyWord];
        }else if(searchKeyWord=='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where Primary_Contact_Type__c LIKE: searchContactType];
        }else if(searchKeyWord!='all' && searchContactType!='all'){
            contactRecords = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
            contactRecords = [SELECT Id FROM contact where RecordType.Name Like 'FU-Employee' OR RecordType.Name Like 'FU-Student'];
        }
        
        system.debug('contactOutDataRecords-->'+contactRecords);
        
        Set<Id> contactIds = (new Map<Id,contact>(contactRecords)).keySet();
		system.debug('StudentOutData-contactIds::>'+contactIds);
        //getting max createdDate for users
        List<AggregateResult> recordsPunchOut = [SELECT contact_Name__c, MAX(CreatedDate) maxRecord FROM Employee_Calendar__c WHERE contact_Name__c IN :contactIds GROUP BY contact_Name__c];
       

        //put dates in a list
        Set<Datetime> cDates = new Set<Datetime>();
      // Set<Datetime> cDatesPunchIn = new Set<Datetime>();
        For(AggregateResult record : recordsPunchOut){
            cDates.add(Datetime.valueOf(record.get('maxRecord')));
           // cDatesPunchIn.add(Datetime.valueOf(record.get('maxPunchIn')));
        }
        system.debug('StudentOutData-cDates::>'+cDates);
       
        //finally get last record for each user (or lookup field)
        
        List<Employee_Calendar__c> latestRecords = new List<Employee_Calendar__c>();
        Boolean checked = True;
        
        if(mainGateEnteryInFilter=='False' && mainGateEnteryOutFilter == 'True'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Email,Contact_Name__r.Name, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_Out_DateTime__c!= :null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_Out__c =: True]; 
        }else if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'True'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Email,Contact_Name__r.Name, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_Out_DateTime__c!= :null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True AND Main_Gate_Out__c =: True]; 
        }else if(mainGateEnteryInFilter=='True' && mainGateEnteryOutFilter == 'False'){
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Email,Contact_Name__r.Name, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_Out_DateTime__c!= :null AND contact_Name__c IN :contactIds AND createddate IN :cDates AND Main_Gate_In__c =: True AND Main_Gate_Out__c =: False]; 
        }else{
           latestRecords = [SELECT id,Name,Employee_Code__c,In_Time__c,Contact_Name__c, Contact_Name__r.Email,Contact_Name__r.Name, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Punch_Out_DateTime__c,Punch_In_Datetime__c,Main_Gate_In__c,Main_Gate_Out__c FROM Employee_Calendar__c WHERE Punch_Out_DateTime__c!= :null AND contact_Name__c IN :contactIds AND createddate IN :cDates]; 
        }
        system.debug('StudentOutData-latestRecords::>'+latestRecords);
        
        return latestRecords;
        
        
       // return [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where   Order By createdDate DESC LIMIT 500];     
    }
    
}