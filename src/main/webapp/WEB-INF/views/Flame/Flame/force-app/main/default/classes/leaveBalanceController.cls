public with sharing class leaveBalanceController {
    
    @AuraEnabled
    public static Map<String, Object> getContactCatalogue(String pageSize, String pageNumber, Boolean getProductsCount){
        system.debug('called getContactCatalogue');
        Map<String, Object> responseObj = new Map<String, Object>();
        Integer ps = Integer.valueOf(pageSize);
        Integer pn = Integer.valueOf(pageNumber)-1;
        
        List<Contact> productList = [SELECT Id,Gender__c,  Name,Department__c, Primary_Contact_Type__c,Employee_Id__c , Earned_Leave_Balance__c , Casual_Leave_Balance__c , Maternity_Paternity_Leave_Balance__c , Faculty_Researching_and_Consulting__c , CompOff_Balance__c                     
                                     FROM Contact Where ( Primary_Contact_Type__c = 'Staff' OR Primary_Contact_Type__c = 'Faculty') AND  Date_of_Joining__c!=null AND Date_of_Leaving__c = null AND RecordType.name = 'FU-Employee' and (Classfication_Faculty__c = true or Classfication_Staff__c = true)
                                     LIMIT :Integer.valueOf(ps) OFFSET :(ps*pn)];
        system.debug('This is productList size'+ productList.size());
        
        responseObj.put('products', productList);
        
        if(getProductsCount == true) {
            system.debug('This is totalCount ::'+ getTotalProductsCount('')); 
            system.debug('This is xxxxxxxxxxxx Count ::'+  Math.ceil(getTotalProductsCount('')/Decimal.valueOf(ps)));
            responseObj.put('productCount', Math.ceil(getTotalProductsCount('')/Decimal.valueOf(ps)));
            //  responseObj.put('productCount',productList.size()-1);
        }        
        
        return responseObj;
    }
    
    @AuraEnabled
    public static Map<String, Object> getProductCatalogueBySearch(String pageSize, String searchKey, 
                                                                  String pageNumber, Boolean getProductsCount) {
                                                                      system.debug('called getProductCatalogueBySearch');
                                                                      //  List<String> prodList= productInterest.split(';');
                                                                      //  system.debug('This is productInterest ::'+ productInterest.split(';'));                   
                                                                      Map<String, Object> responseObj = new Map<String, Object>();                                                              
                                                                      Integer ps = Integer.valueOf(pageSize);
                                                                      Integer pn = Integer.valueOf(pageNumber)-1;
                                                                      Integer searchEmployeeID = 0;
                                                                      if(searchKey.isNumeric()){
                                                                          searchEmployeeID = Integer.ValueOf(searchKey);
                                                                      }
                                                                      if(searchKey != null) {
                                                                          searchKey = '\'%' + searchKey + '%\'';
                                                                      }
                                                                      else {
                                                                          searchKey = '\'%\''; 
                                                                      } 
                                                                      // String query = 'SELECT Id, PriceBook__c, HSNCode__c, QuantityUnitOfMeasure__c,  ProductCode__c, Family__c, Description__c, Name, CurrencyIsoCode, Flange_Size__c,Box_Size__c,Unit_Price__c,List_Price__c, Type_Of_Filter__c, Class_Of_Filter__c, Capacity_in_CFM__c, Micron__c,gstPercentage__c,Casing__c, Media__c, Pressure_Drop__c,Seprators__c,Efficiency__c FROM Product__c WHERE Name LIKE ' + searchKey + ' LIMIT '+Integer.valueOf(pageSize) + ' OFFSET ' + (ps*pn);
                                                                      String query = 'SELECT Id,Gender__c, Department__c,Employee_Id__c, Name, Primary_Contact_Type__c , Earned_Leave_Balance__c , Casual_Leave_Balance__c , Maternity_Paternity_Leave_Balance__c , Faculty_Researching_and_Consulting__c , CompOff_Balance__c FROM Contact WHERE ( Name LIKE '  + searchKey + ' OR Employee_Id__c =: searchEmployeeID ) AND  Date_of_Joining__c!=null AND Date_of_Leaving__c = null AND  Primary_Contact_Type__c IN (\'Staff\', \'Faculty\') AND RecordType.name = \'FU-Employee\' and (Classfication_Faculty__c = true or Classfication_Staff__c = true) LIMIT '+Integer.valueOf(pageSize) + ' OFFSET ' + (ps*pn);
                                                                      
                                                                      
                                                                      List<Contact> productList = Database.query(query);
                                                                      system.debug('This is products ::'+ productList);                                                             
                                                                      responseObj.put('products', productList);                                                                                   
                                                                      if(getProductsCount == true) { 
                                                                          responseObj.put('productCount', Math.ceil(getTotalProductsCount(searchKey)/Decimal.valueOf(ps)));
                                                                          //  responseObj.put('productCount',productList.size());
                                                                      }
                                                                      return responseObj;
                                                                  }
    
    @AuraEnabled    
    public static Integer getTotalProductsCount(String optionalSearchKey) { 
        system.debug('search getTotalProductsCount');
        String query = 'SELECT count() FROM Contact  WHERE Date_of_Joining__c!=null AND Date_of_Leaving__c = null AND Primary_Contact_Type__c IN (\'Staff\', \'Faculty\') AND RecordType.name = \'FU-Employee\' and (Classfication_Faculty__c = true or Classfication_Staff__c = true)';
        if(optionalSearchKey != null && optionalSearchKey != '') {
            query += ' AND Name LIKE ' + optionalSearchKey ;
        }
        system.debug('query '+query);
        Integer productCount = Database.countQuery(query);
        return productCount;
    }
    
    
    @AuraEnabled
    public static Boolean createLeave(List<Object> leaveLedgerList)
    {       
            list<leave_ledger__c> listLeaveLedgerToInsert = new list<leave_ledger__c>();
            system.debug('leaveLedgerList::'+leaveLedgerList);
            
            system.debug('leaveLedgerList size::'+leaveLedgerList.size());
            for(Object ld : leaveLedgerList ){
                Map<Object, Object> newData = (Map<Object, Object>)ld;
                
                String Name = string.valueOf(newData.get('Name'));
                String Employee_Name = string.valueOf(newData.get('Employee_Name__c'));
                String Primary_Contact_Type = string.valueOf(newData.get('Primary_Contact_Type__c'));
                String Gender = string.valueOf(newData.get('Gender__c'));     
                Decimal Employee_Id = Decimal.valueOf(string.valueOf(newData.get('Employee_Id__c'))) ;
                string ELB = string.valueOf(newData.get('Earn_Leave__c'));
                string CLB = string.valueOf(newData.get('Casual_Leave__c'));
                string PLB = string.valueOf(newData.get('Paternity_Leave__c'));
                string FLB = string.valueOf(newData.get('Faculty_Leave__c'));  
                string CoLB = string.valueOf(newData.get('CompOff_Leave__c'));
                
                Decimal Earn_Leave = (ELB == '' ? 0.0 : Decimal.valueOf(ELB)); //Decimal.valueOf(string.valueOf(newData.get('Earn_Leave__c'))); 
                Decimal Casual_Leave = (CLB == '' ? 0.0 : Decimal.valueOf(CLB)); //Decimal.valueOf(string.valueOf(newData.get('Casual_Leave__c')));
                Decimal Paternity_Leave = (PLB == '' ? 0 : Decimal.valueOf(PLB)); //Decimal.valueOf(string.valueOf(newData.get('Paternity_Leave__c'))); 
                String Faculty_Leave =  (FLB == '' ? '0' : FLB); //String.valueOf(newData.get('Faculty_Leave__c'));  
                Decimal CompOff_Leave = (CoLB == '' ? 0.0 : Decimal.valueOf(CoLB)); //Decimal.valueOf(string.valueOf(newData.get('CompOff_Leave__c')));
                String reason = string.valueOf(newData.get('Reason__c'));
                Id creditRecordTypeId = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();
                Id debitRecordTypeId = Schema.SObjectType.Leave_Ledger__c.getRecordTypeInfosByName().get('Debit').getRecordTypeId(); 
                system.debug('This is JSON list NAME ::'+ newData.get('Name'));
                system.debug('This is JSON Earn_Leave ::'+ Earn_Leave);
                system.debug('This is JSON Casual_Leave ::'+ Casual_Leave);
                system.debug('This is JSON Paternity_Leave ::'+ Paternity_Leave);
                system.debug('This is JSON Faculty_Leave ::'+ Faculty_Leave);
                system.debug('This is JSON CompOff_Leave ::'+ CompOff_Leave);
                if(Earn_Leave == 0 || Earn_Leave == Null)
                {
                    system.debug('Do nothing'+Earn_Leave);
                    //do nothing   
                }
                else
                {
                    system.debug('Do Something');  
                    Leave_Ledger__c lld = new Leave_Ledger__c();
                    lld.Employee_Name__c = Employee_Name;
                    lld.Leave_Type__c = 'Earned Leave';
                    lld.Reason__c = reason;
                    lld.Total_Days__c = math.abs(Earn_Leave);
                    lld.Employee_Id__c = Employee_Id;
                    if(Earn_Leave < 0){
                        lld.Leave_Action__c = 'Debit';
                        lld.RecordTypeId = debitRecordTypeId;
                    }else{
                        lld.Leave_Action__c = 'Credit';  
                        lld.RecordTypeId = creditRecordTypeId;
                    }
                    listLeaveLedgerToInsert.add(lld); //insert lld;
                    //system.debug('Record Inserted successfully ::'+lld);  
                }
                if(Casual_Leave == 0 || Casual_Leave == Null)
                {
                    system.debug('Do nothing'+Casual_Leave);   
                }
                else
                {
                    Leave_Ledger__c lld1 = new Leave_Ledger__c();
                    lld1.Employee_Name__c = Employee_Name;
                    lld1.Leave_Type__c = 'Casual Leave';
                    lld1.Reason__c = reason;
                    lld1.Total_Days__c = math.abs(Casual_Leave);
                    lld1.Employee_Id__c = Employee_Id;
                    if(Casual_Leave < 0){
                        lld1.Leave_Action__c = 'Debit';
                        lld1.RecordTypeId = debitRecordTypeId;
                    }else{
                        lld1.Leave_Action__c = 'Credit';  
                        lld1.RecordTypeId = creditRecordTypeId;
                    }
                    listLeaveLedgerToInsert.add(lld1); //insert lld1;   
                }
                if(Paternity_Leave == 0 || Paternity_Leave == Null)
                {
                    system.debug('Do nothing'+Casual_Leave);   
                }
                else
                {
                    Leave_Ledger__c lld2 = new Leave_Ledger__c();
                    lld2.Employee_Name__c = Employee_Name;
                    if(Gender == 'Male')
                    {
                        lld2.Leave_Type__c = 'Paternity Leave';   
                    }
                    else if(Gender == 'Female')
                    {
                        lld2.Leave_Type__c = 'Maternity Leave';    
                    }
                    lld2.Reason__c = reason;
                    lld2.Total_Days__c = math.abs(Paternity_Leave);
                    lld2.Employee_Id__c = Employee_Id;
                    if(Paternity_Leave < 0){
                        lld2.Leave_Action__c = 'Debit';
                        lld2.RecordTypeId = debitRecordTypeId;
                    }else{
                        lld2.Leave_Action__c = 'Credit';  
                        lld2.RecordTypeId = creditRecordTypeId;
                    }
                    listLeaveLedgerToInsert.add(lld2); //insert lld2;   
                }
                if(Faculty_Leave == '0' || Faculty_Leave == Null || Faculty_Leave == 'NA')
                {
                    system.debug('Do nothing'+Casual_Leave);   
                }
                else
                {
                    Leave_Ledger__c lld3 = new Leave_Ledger__c();
                    lld3.Employee_Name__c = Employee_Name;
                    lld3.Leave_Type__c = 'Faculty Consulting Researching Leave';   
                    lld3.Reason__c = reason;
                    lld3.Total_Days__c = math.abs(Decimal.valueOf(Faculty_Leave));
                    lld3.Employee_Id__c = Employee_Id;
                    if(Integer.valueOf(Faculty_Leave) < 0){
                        lld3.Leave_Action__c = 'Debit';
                        lld3.RecordTypeId = debitRecordTypeId;
                    }else{
                        lld3.Leave_Action__c = 'Credit';  
                        lld3.RecordTypeId = creditRecordTypeId;
                    }
                    listLeaveLedgerToInsert.add(lld3); //insert lld3;   
                }
                if(CompOff_Leave == 0 || CompOff_Leave == Null )
                {
                    system.debug('Do nothing'+CompOff_Leave);   
                }
                else
                {
                    Leave_Ledger__c lld4 = new Leave_Ledger__c();
                    lld4.Employee_Name__c = Employee_Name;
                    lld4.Leave_Type__c = 'CompOff Request';   
                    lld4.Reason__c = reason;
                    lld4.Total_Days__c = math.abs(CompOff_Leave);
                    lld4.Employee_Id__c = Employee_Id;
                    lld4.From_Date__c = system.today();
                    if(math.abs(CompOff_Leave) != 1){
                        throw new AuraHandledException('Comp Off balance cannot be adjusted more than 1 at a time.');
                    }
                    if(CompOff_Leave < 0){
                        lld4.Leave_Action__c = 'Debit';
                        lld4.RecordTypeId = debitRecordTypeId;
                    }else{
                        lld4.Leave_Action__c = 'Credit';  
                        lld4.RecordTypeId = creditRecordTypeId;
                    }
                    listLeaveLedgerToInsert.add(lld4); //insert lld4;   
                }
            }   
            if(listLeaveLedgerToInsert.size() > 0 ){
                insert listLeaveLedgerToInsert;
            }
            else{
                throw new AuraHandledException('No records to create');
            }
            return true;
        
    }
    
    @AuraEnabled
    public static List<Contact> getAllContacts()
    {
        system.debug('called getAllContacts');
        List<Contact> conList = [SELECT Id,Gender__c, Name, Primary_Contact_Type__c , Department__c , Employee_Id__c, Earned_Leave_Balance__c , Casual_Leave_Balance__c , Maternity_Paternity_Leave_Balance__c , Faculty_Researching_and_Consulting__c , CompOff_Balance__c                           
                                 FROM Contact  Where ( Primary_Contact_Type__c = 'Staff' OR Primary_Contact_Type__c = 'Faculty') AND  Date_of_Joining__c!=null AND Date_of_Leaving__c = null and RecordType.name = 'FU-Employee' and (Classfication_Faculty__c = true or Classfication_Staff__c = true) ORDER BY Name ASC];
        return conList; 
    }
}