public class testFetchEmployeeCalender {
 @AuraEnabled
    public static list<Employee_Calendar__c> fetchEmployeeCalendarRecords(){
        List<Employee_Calendar__c> Emplist1 = [select Name,Employee_Code__c,In_Time__c,Punch_Out_Datetime__c,Punch_In_Datetime__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c  Order By createdDate DESC LIMIT 9000];
       // List<Employee_Calendar__c> Emplist2 = [select Name,Employee_Code__c,Out_Time__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where Out_Time__c!= :null AND In_Time__c!= :null Order By createdDate DESC LIMIT 500];
        List<Employee_Calendar__c> finalEmpList = new List<Employee_Calendar__c>();
        List<String> EmpListOfId = new List<String>();
        for(Employee_Calendar__c ec: Emplist1){
            if(ec.Punch_In_Datetime__c > ec.Punch_Out_DateTime__c || ec.Punch_Out_DateTime__c > ec.Punch_In_Datetime__c){
                
               EmpListOfId.add(ec.id);
            }
        }
		//finalEmpList.addAll(Emplist1);
		 List<Employee_Calendar__c> Emplist = [select Name,Employee_Code__c,In_Time__c,Punch_Out_Datetime__c,Punch_In_Datetime__c, Contact_Name__r.Email, Contact_Name__r.Phone, Contact_Name__r.CVUE_Student_Number__c,Last_Activity_Time__c  from Employee_Calendar__c where id in:EmpListOfId Order By createdDate DESC LIMIT 9000];
        system.debug('Emplist-->'+Emplist);
        return Emplist;        
    }   

}