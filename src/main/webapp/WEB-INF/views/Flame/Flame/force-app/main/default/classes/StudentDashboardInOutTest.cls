public class StudentDashboardInOutTest {
    @AuraEnabled
        public static List<Account>  getBatchOfFlameStudents() {
            List<Account> listOfAccount = [select Id,name from account where name LIKE 'FLAME Students%'];
            if(listOfAccount.size() > 0){
                return listOfAccount;
            }
            else{
            return null;
                }
        }
    
    
    
    @AuraEnabled
    public static List<Employee_Calendar__c>  fetchBatchFilterStudents(String searchKeyWord, String searchContactType) {
        List<Contact> listOfContacts = new List<Contact>();
        Integer flag= 0;
        if(searchKeyWord!=null && searchKeyWord!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord];
        }else if(searchContactType!=null && searchContactType!='all'){
            listOfContacts = [select Id from contact where Primary_Contact_Type__c LIKE: searchContactType];
        }else if(searchKeyWord!='all' && searchContactType!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
            flag =1;
        }
        
        system.debug('listOfContact>>>>>' + listOfContacts);
        List<Employee_Calendar__c> Emplist1 = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> Emplist2 = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> finalEmpList = new List<Employee_Calendar__c>();
        if(flag==0){
           Emplist1 = [select Name,Employee_Code__c,In_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where In_Time__c!= :null AND Out_Time__c =: null AND Contact_Name__r.Id IN:listOfContacts];
           Emplist2 = [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null AND Contact_Name__r.Id IN:listOfContacts];
        }else{
           Emplist1 = [select Name,Employee_Code__c,In_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where In_Time__c!= :null AND Out_Time__c =: null];
           Emplist2 = [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null];
        }
        
        finalEmpList.addAll(Emplist1);
		finalEmpList.addAll(Emplist2);
        return finalEmpList;     
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
    public static list<Employee_Calendar__c> fetchEmployeeCalendarRecords(){
        List<Employee_Calendar__c> Emplist1 = [select Name,Employee_Code__c,In_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where In_Time__c!= :null AND Out_Time__c =: null Order By createdDate DESC LIMIT 100];
        List<Employee_Calendar__c> Emplist2 = [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null Order By createdDate DESC LIMIT 100];
        List<Employee_Calendar__c> finalEmpList = new List<Employee_Calendar__c>();
		finalEmpList.addAll(Emplist1);
		finalEmpList.addAll(Emplist2);
        return finalEmpList;        
    }
    
    @AuraEnabled
    public static list<Employee_Calendar__c> getStudentInData(String searchKeyWord, String searchContactType){
        List<Contact> listOfContacts = new List<Contact>();
        Integer flag= 0;
        if(searchKeyWord!=null && searchKeyWord!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord];
        }else if(searchKeyWord!=null && searchKeyWord!='all' && searchContactType!=null && searchContactType!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
           flag= 1;
        }
        
        if(flag==0){
            return [select Name,Employee_Code__c,In_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where In_Time__c!= :null AND Out_Time__c =: null AND Contact_Name__r.Id IN:listOfContacts];
        }else{
            return [select Name,Employee_Code__c,In_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where In_Time__c!= :null AND Out_Time__c =: null];
        }    
    }
    
    @AuraEnabled
    public static list<Employee_Calendar__c> getStudentOutData(String searchKeyWord, String searchContactType){
        List<Contact> listOfContacts = new List<Contact>();
        Integer flag= 0;
        if(searchKeyWord!=null && searchKeyWord!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord];
        }else if(searchKeyWord!=null && searchKeyWord!='all' && searchContactType!=null && searchContactType!='all'){
            listOfContacts = [select Id from contact where accountId =: searchKeyWord AND Primary_Contact_Type__c LIKE: searchContactType];
        }else{
           flag= 1;
        }
        if(flag==0){
            return [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null AND Contact_Name__r.Id IN:listOfContacts];
        }else{
            return [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null];
        }    
    }
}