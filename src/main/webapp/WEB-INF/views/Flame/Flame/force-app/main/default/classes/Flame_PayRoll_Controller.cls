public class Flame_PayRoll_Controller {
    
    public List<Payroll_Advice__c> PayRollList {get;set;}
    public List<Decimal> EmployeeIdList;
    public Integer month {get;set;}
    public String year {get;set;}
    public Integer rowIndex;
    
    List<contact> ConList = new List<contact>();
    List<Payroll_Advice__c> PayRollListUpdate = new List<Payroll_Advice__c>();   
    List<Leave_ledger__c> LL_List = new List<Leave_ledger__c>();
    List<Leave_ledger__c> LL_List2 = new List<Leave_ledger__c>();
    List<id> ConIds = new List<Id>();
    String MonthYear;
    Boolean NoExistingPayrollFlag = false;
    
    public Boolean SaveBool{get;set;}//disabled
    public Boolean ExportBool{get;set;}//disabled
    public Boolean TableBool{get;set;}//rendered
    public Boolean UpdateBool{get;set;}//rendered
    public Boolean UpdBool{get;set;}//disabled
    
    public Flame_PayRoll_Controller() { 
        year = String.valueOf(System.Today().year());
        month = Integer.valueOf(System.Today().month());
        SaveBool = true;//disabled
        ExportBool = true;//disabled
        TableBool = false;//rendered
        
        UpdateBool = false;
        if(Schema.sObjectType.Payroll_Advice__c.isDeletable())
        {
            //Unpaid_Leave__c, Shortfall_Excess_For_Prev_Month__c, Remark__c
            system.debug('yes');
            system.debug(Schema.sObjectType.Payroll_Advice__c.isDeletable());
            UpdateBool = true;
            UpdBool = true;
        }
    }
    
    public List<SelectOption> getYearsList() {
        
        List<SelectOption> options = new List<SelectOption>();
        
        for (Integer i = System.Today().year() - 1; i <= System.Today().year(); i++)
        {
            options.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
        return Options;
    }
    
    
    public void CalculateFieldValues()
    {
        for(integer i = 0; i < PayRollList.size(); i++)
        {
            //PayRollList[i].Days_Worked__c  = PayRollList[i].Total_Days__c -  PayRollList[i].Leaves__c;
            PayRollList[i].No_Of_Days_Salary_To_Be_Paid__c = PayRollList[i].Total_Days__c - PayRollList[i].Unpaid_Leave__c;
            PayRollList[i].Final_No_Of_Days_To_Be_Paid__c = (PayRollList[i].Total_Days__c - PayRollList[i].Unpaid_Leave__c) 
                + PayRollList[i].Shortfall_Excess_For_Prev_Month__c;
        }
    }
    
    public void Save()
    {
        try
        {
            system.debug('PayRollList: '+PayRollList.size());
            
            system.debug('NoExistingPayrollFlag: '+NoExistingPayrollFlag);
            
            CalculateFieldValues();
            
            insert PayRollList;
            system.debug('PayRollList done and size is: '+PayRollList.size());
            //PayRollList.clear();
            SaveBool = true;//disabled
            ExportBool = false;//disabled
            TableBool = true;//rendered
        }
        
        catch(Exception e)
        {
            system.debug(e.getmessage());
        }
    }
    
    public void callTOsave(){
        SaveBool = true;//disabled
        ExportBool = true;//disabled
        TableBool = true;//rendered
        UpdBool = false;//disabled
    }
    
    public void updateRecords(){
        try{
             CalculateFieldValues();
        update PayRollList;
        }
        catch(Exception e)
        {
            system.debug(e.getmessage());
        }
       
    }
    
    public Pagereference ExportToCSV(){
        //MonthYear
        PageReference orderPage = new PageReference('/apex/Flame_ExportTable');
        orderPage.getParameters().put('MonthYear',MonthYear);
        orderPage.setRedirect(true);
        system.debug('MonthYear:: '+MonthYear);
        return orderPage;
    }
    
    public void submitSingle(){
        
        try
        {
        MonthYear = String.valueOf(month) + year;
        List<Employee_Calendar__c> EC_List = new List<Employee_Calendar__c>();
        List<Employee_Calendar__c> Employee_CalenderList = new List<Employee_Calendar__c>();
        
        PayRollList = new list<Payroll_Advice__c>();
        
        PayRollList = [SELECT Employee_Name__c, Department__c,Employee_Id__c, Date_Of_Joining__c, Total_Days__c, Leaves__c, Days_Worked__c, Holidays_Weekends__c, 
                       Paid_Leave__c, Unpaid_Leave__c, No_Of_Days_Salary_To_Be_Paid__c, Shortfall_Excess_For_Prev_Month__c, Final_No_Of_Days_To_Be_Paid__c, 
                       Leave_Taken_in_period_26th_31th__c, Remark__c, Month_Year_Flag__c, Id 
                       FROM Payroll_Advice__c where Month_Year_Flag__c = :MonthYear];
        
        system.debug('PayRollList after submit: '+PayRollList.size());
        
        
        If(PayRollList.size() == 0)
        {
            SaveBool = false;//disabled
            ExportBool = true;//disabled
            TableBool = true;//rendered
            UpdBool = true;//disabled
            
            NoExistingPayrollFlag = true;
            Integer PreviousMonth;
            Integer PreviousYear;
            Integer TotalDaysInMonth = date.daysInMonth(Integer.valueOf(year), month);
            
            system.debug('Month: '+month);
            system.debug('Year: '+Integer.valueOf(year));
            
            If(month == 1)
            {
                PreviousMonth = 12;
                PreviousYear = Integer.valueOf(year) - 1;
            }
            else
            {
                PreviousMonth = month - 1;
                PreviousYear = Integer.valueOf(year);
            }
            
            Date FromDate = date.newinstance(PreviousYear, PreviousMonth, 26);
            
            system.debug('FromDate: '+FromDate);
            
            Date ToDate = date.newinstance(Integer.valueOf(year), month, 25);
            
            system.debug('ToDate: '+ToDate);
            
            Date Date26OfMonth = date.newinstance(Integer.valueOf(year), month, 26);
            
            Date StartDateOfMonth = date.newinstance(Integer.valueOf(year), month, 1);
            
            system.debug('StartDateOfMonth: '+StartDateOfMonth);
            
            Date LastDateOfMonth = date.newinstance(Integer.valueOf(year), PreviousMonth, TotalDaysInMonth);
            
            system.debug('LastDateOfMonth: '+LastDateOfMonth);
            
            EC_List = [select id from Employee_Calendar__c where date__c >= :StartDateOfMonth AND date__c <= :LastDateOfMonth];
            
            Integer HolidaysCount = EC_List.size();
            
            system.debug('HolidaysCount: '+HolidaysCount);
            
            ConList = [select id, Name,  Date_of_Joining__c, Department__c , Employee_Id__c
                       from contact where ( Primary_Contact_Type__c = 'Faculty' 
                       OR Primary_Contact_Type__c = 'Staff') AND Date_of_Joining__c != Null  AND RecordType.name = 'FU-Employee' AND (Classfication_Faculty__c = true or Classfication_Staff__c = true)];
            
            system.debug('ConList: '+ConList);
            system.debug('ConList Size: '+ConList.size());
            
            if(ConList.size() > 0)
            {
                for(Contact c : ConList)
                {
                    Payroll_Advice__c PayRoll = new Payroll_Advice__c();
                    PayRoll.Employee_Id__c = c.Employee_Id__c;
                    PayRoll.Date_Of_Joining__c = c.Date_of_Joining__c;
                    PayRoll.Employee_Name__c = c.Name;
                    PayRoll.Department__c = c.Department__c;
                    PayRoll.Contact_Name__c = c.id;
                    PayRoll.Holidays_Weekends__c = HolidaysCount;
                    PayRoll.Days_Worked__c = 0;
                    PayRoll.No_Of_Days_Salary_To_Be_Paid__c = 0;
                    PayRoll.Paid_Leave__c = 0;
                    PayRoll.Unpaid_Leave__c = 0;
                    PayRoll.Leaves__c = 0;
                    PayRoll.Leave_Taken_in_period_26th_31th__c = 0;
                    PayRoll.Shortfall_Excess_For_Prev_Month__c = 0;
                    PayRoll.Final_No_Of_Days_To_Be_Paid__c = 0;
                    PayRoll.Total_Days__c = TotalDaysInMonth;
                    payRoll.Month_Year_Flag__c = MonthYear;
                    PayRollList.add(PayRoll);
                    ConIds.add(c.id);
                }
                system.debug('ConIds: '+ConIds);
                system.debug('PayRollList: '+PayRollList);
                system.debug('PayRollList Size: '+PayRollList.size());
                
                Employee_CalenderList = [Select id, Employee_Code__c, IsPresent__c from Employee_Calendar__c where (Date__c >= :FromDate AND Date__c <= :ToDate) AND (IsPresent__c = 'Half Day Present' OR IsPresent__c = 'Present')];
                system.debug('Employee_CalenderList size: '+Employee_CalenderList.size());
                
                If(Employee_CalenderList.size() > 0)
                {
                    for(integer i = 0; i < PayRollList.size(); i++)
                    {
                        for(integer j = 0; j < Employee_CalenderList.size(); j++)
                        {
                            If(String.valueOf(PayRollList[i].Employee_Id__c) ==  Employee_CalenderList[j].Employee_Code__c)
                            {
                                If(Employee_CalenderList[j].IsPresent__c == 'Present')
                                {
                                    PayRollList[i].Days_Worked__c = PayRollList[i].Days_Worked__c + 1;
                                }
                                
                                If(Employee_CalenderList[j].IsPresent__c == 'Half Day Present')
                                {
                                    PayRollList[i].Days_Worked__c = PayRollList[i].Days_Worked__c + 0.5;
                                }
                           }
                        }
                    }
                }
                
                LL_List = [select id, From_Date__c, To_Date__c, Total_Days__c, Employee_Name__c from Leave_Ledger__c where (From_Date__c >= :FromDate AND To_Date__c <= :ToDate) AND (Status__c = 'Approved' AND Leave_Action__c = 'Debit') AND Employee_Name__c IN :ConIds];
                
                system.debug('LL_List: '+LL_List);
                system.debug('LL_List Size: '+LL_List.size());
                
                if(LL_List.size() > 0)
                {
                    
                    for(integer i = 0; i < PayRollList.size(); i++)
                    {
                        for(integer j = 0; j < LL_List.size(); j++)
                        {
                            If(PayRollList[i].Contact_Name__c == LL_List[j].Employee_Name__c)
                            {
                                PayRollList[i].Paid_Leave__c = PayRollList[i].Paid_Leave__c + LL_List[j].Total_Days__c;
                                PayRollList[i].Leaves__c = PayRollList[i].Leaves__c + LL_List[j].Total_Days__c;
                            }
                        }
                    }
                }
                
                LL_List2 = [select id, From_Date__c, To_Date__c, Total_Days__c, Employee_Name__c from Leave_Ledger__c where (From_Date__c >= :Date26OfMonth AND To_Date__c <= :LastDateOfMonth) AND (Status__c = 'Approved' AND Leave_Action__c = 'Debit') AND Employee_Name__c IN :ConIds];
                
                system.debug('LL_List2: '+LL_List2);
                system.debug('LL_List2 Size: '+LL_List2.size());
                
                if(LL_List2.size() > 0)
                {
                    
                    for(integer i = 0; i < PayRollList.size(); i++)
                    {
                        for(integer j = 0; j < LL_List2.size(); j++)
                        {
                            If(PayRollList[i].Contact_Name__c == LL_List2[j].Employee_Name__c)
                            {
                                PayRollList[i].Leave_Taken_in_period_26th_31th__c = PayRollList[i].Leave_Taken_in_period_26th_31th__c + LL_List2[j].Total_Days__c;
                            }
                        }
                    }
                }
            }
        }
        else{
            SaveBool = true;//disabled
            ExportBool = false;//disabled
            TableBool = true;//rendered
            UpdBool = false;
        }
    }
        catch(Exception e)
        {
            system.debug(e.getmessage());
        }
    }
}