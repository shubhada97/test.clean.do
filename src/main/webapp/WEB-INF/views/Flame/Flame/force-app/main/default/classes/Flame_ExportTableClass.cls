public class Flame_ExportTableClass {

    public List<Payroll_Advice__c> DataList {get;set;}
    
    public Flame_ExportTableClass() { 
        DataList = new List<Payroll_Advice__c>();
        getData();
    }
    
    public void getData(){
        String monthYearCode = apexpages.currentpage().getparameters().get('MonthYear');
        system.debug('monthYearCode:: '+monthYearCode);
        //monthYearCode = '32020';
        if(monthYearCode != null){
            DataList = [SELECT Employee_Name__c, Department__c, Date_Of_Joining__c, Total_Days__c, Leaves__c, Days_Worked__c, Holidays_Weekends__c, 
                        Paid_Leave__c, Unpaid_Leave__c, No_Of_Days_Salary_To_Be_Paid__c, Shortfall_Excess_For_Prev_Month__c, Final_No_Of_Days_To_Be_Paid__c, 
                        Leave_Taken_in_period_26th_31th__c, Remark__c, Month_Year_Flag__c, Id,Employee_Id__c 
                        FROM Payroll_Advice__c where Month_Year_Flag__c = :monthYearCode];
        }
        closeWindow();
    }
    public pagereference closeWindow(){
        return new PageReference('javascript:window.close()');
    }
}