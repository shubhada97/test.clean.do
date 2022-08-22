public class AttendancePageTableClass{
    
    public List<Employee_Calendar__c> punches {get;set;}
    public Leave_Ledger__c ledger{get;set;}//to take from and to date for future regularization
    //public Employee_Calendar__c Futurepunches {get; set;}
    public Employee_Calendar__c punches2 {get; set;}
    public Employee_Calendar__c updatePunches {get; set;}
    public Leave_Setting__mdt leaveSettings {get; set;}
    public String userId { get; set; } 
    public contact con {get;set;}
    public User userapprover {get; set;}
    public user currentUser {get; set;}
    public String EmployeeId;
    public String month {get;set;}
    public String year {get;set;}
    public List<SelectOption> monthOptions {get;set;}
    public List<SelectOption> YearOptions {get;set;}
    public boolean displayPopup {get; set;}
    public boolean displayfuturePopup {get; set;}
    public Time expInTime { get; set; }
    public Time expOutTime { get; set; }
    public Time futureexpInTime { get; set; }
    public Time futureexpOutTime { get; set; }
    public String futurecomments {get; set;}
    public String comments {get; set;}
    public String indNo {get; set;}
    public Integer rowIndex;
    public Integer dateDiff;
    public boolean successBool {get; set;}      
    public boolean errorBool {get; set;}
    public string SuccessMsg {get;set;}
    
    //Controller Method
    public AttendancePageTableClass(){
        
        successBool = false;
        errorBool = false;
        try{
            indNo ='';
            con = new contact();
            userapprover = new User();
            monthOptions = new List<SelectOption>();
            YearOptions = new List<SelectOption>();
            //Futurepunches = new Employee_Calendar__c();
            punches = new List<Employee_Calendar__c>();
            punches2 = new Employee_Calendar__c();
            leaveSettings = new Leave_Setting__mdt();
            ledger = new Leave_Ledger__c();
            
            ledger.From_Date__c = System.today().addDays(+1);
            ledger.To_Date__c = System.today().addDays(+1);
            futurecomments = 'Official Regularized Visit';
            futureexpInTime = Time.newInstance(9, 0, 0, 0);
            futureexpOutTime = Time.newInstance(18, 0, 0, 0);
            expInTime = Time.newInstance(9, 0, 0, 0);
            expOutTime = Time.newInstance(18, 0, 0, 0);
            //Futurepunches.Date__c = System.today().addDays(+1);
            comments = '';
            
            displayfuturePopup = true;
            
            userId = userinfo.getuserId();
            if(test.isRunningTest()){
                //String TestId = ApexPages.currentPage().getParameters().get('testID');
                //userId = TestId;
            }
            currentUser=[Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id=: userId];
            con = [SELECT Id,Name, Email,Employee_Id__c, ReportsTo.Name,ReportsToId FROM Contact where id =: currentUser.contactId];
            userapprover = [SELECT Id, Name, ContactId FROM User WHERE ContactId =: con.ReportsToId];
            EmployeeId = String.valueOf(con.Employee_Id__c);
            
            Employee_Calendar__c ecYear = [SELECT year__c,date__c FROM Employee_Calendar__c  Where Employee_Code__c =: EmployeeId AND RecordType.Name ='Employee Punch' order by date__c asc limit 1];
            
            //Integer currYear =  0;//Integer.valueOf(System.today().year());
            
            //if(ecYear.size() > 0 ){
            Integer currYear = Integer.valueOf(ecYear.Year__c);
            //}
            
            datetime d1 = System.now();
            date d2 = system.today();
            month = String.Valueof(d2.month());//d1.format('MMMM');
            year = String.valueOf(d2.year());//d1.format('YYYY');
            
            while(system.today().year() >= currYear){
                YearOptions.add(new SelectOption( String.ValueOf(currYear), String.ValueOf(currYear)));
                currYear += 1;
            }
            
            for(Integer i = 12; i > 0; i--){
                
                String previousMonth = DateTime.now().addmonths(i).format('MMMM');
                monthOptions.add(new SelectOption(DateTime.now().addmonths(i).format('MM'), previousMonth));
            }
            submitSingle();
        }
        catch(exception e){
            system.debug('eee::'+e.getMessage());
        }
    }
    
    //Past regularization
    public void submitSingle(){
        try{
            displayfuturePopup = false;
            system.debug('month::'+month);
            system.debug('Year::'+year);
            Date FromDate = date.newinstance(Integer.valueOf(year) , Integer.valueOf(month) , 1);
            Date ToDate = date.newinstance(Integer.valueOf(year) , Integer.valueOf(month) , date.daysInMonth(Integer.valueOf(year), Integer.valueOf(month)));
            system.debug('FromDate::'+FromDate);
            system.debug('ToDate::'+ToDate);
            
            integer CurrentMonth =  (system.today()).month();
            If(Integer.valueof(month.trim()) == CurrentMonth)
            {
                ToDate = system.today();
            }
            system.debug('NewToDate::'+ToDate);
            
            
            punches = [SELECT Id, In_Time__c, Out_Time__c, Date__c,Total_Hours__c, Day__c,Year__c, Employee_Code__c, IsPresent__c, RecordTypeId,Status__c, Applied_For_Regularization__c
                       FROM Employee_Calendar__c Where (Employee_Code__c =: EmployeeId OR RecordType.Name = 'Holiday Punch') And (Date__c >=: FromDate And Date__c <=: ToDate) Order By Date__c Desc];
            system.debug('punches::'+punches);
            if(punches.size() == 0 ){
                successBool = true;
                
                errorBool = true;
                //SuccessMsg = 'No Records Found!.';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No records found!.'));
            }
            
        }
        catch(exception e){
            system.debug('eee::'+e.getmessage());
        }
    }
    
    //Close popup for past regularization
    public void closePopup(){        
        displayPopup = false;   
        displayfuturePopup=false;
        
    }
    
    //Show popup for past regularization
    public PageReference showPopup(){
        try{
            
            errorBool = true;
            //successBool = true;
            SuccessMsg='';
            //Integer idn2 = Integer.valueOf(apexpages.currentpage().getparameters().get('index'));
            //system.debug(idn2);
            system.debug(indNo);
            
            leaveSettings = [SELECT Id, Label, Max_Regularize_Past_Day_Limit__c	
                             FROM Leave_Setting__mdt 
                             WHERE Label = 'All Leave Configurations for Employee'];
            
            rowIndex = Integer.valueOf(indNo);
            punches2 = punches.get(rowIndex-1);
            dateDiff = punches2.Date__c.daysBetween(system.today());
            system.debug('dateDiff::'+dateDiff);
            if(punches2.Applied_For_Regularization__c == false){
                if(dateDiff > leaveSettings.Max_Regularize_Past_Day_Limit__c){
                    successBool = true;
                    errorBool = true;
                    //SuccessMsg = 'You can not regularize this day.';
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You can not regularize this date.'));
                }
                else{
                    displayPopup = true;
                }
                return null;
            }
            else{
                system.debug('inside else');
                successBool = true;
                errorBool = true;
                //SuccessMsg = 'This record has already been sent for regularization approval.';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'This record has already been sent for regularization.'));
            }
            return null;
        }
        catch(exception e){
            successBool = true;
            errorBool = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Something went wrong!'));
            system.debug(e.getmessage());
            return null;
        }
    }
    
    //Show future popup for regularization
    public void showPopupForFuture(){
        try{       
            displayfuturePopup = true;
            //return null;
        }
        catch(exception ex){
            system.debug('error msg:: '+ex.getMessage());
        }
    }
    
    //Submit past punch for approval
    public void updatePunches(){
        try{
            updatePunches = [SELECT Id, In_Time__c, Out_Time__c, Date__c, Day__c,Year__c, Employee_Code__c, IsPresent__c, RecordTypeId, Applied_For_Regularization__c,Status__c,Expected_In_Time__c,
                             Expected_Out_Time__c,Comments__c FROM Employee_Calendar__c WHERE Id =: punches2.Id];
            system.debug('updatePunches::'+updatePunches);
            updatePunches.Punch_Request_Submitter__c = currentUser.Id;
            updatePunches.Applied_To__c = userapprover.Id;
            updatePunches.Applied_For_Regularization__c = true;
            updatePunches.Status__c = 'Pending';
            updatePunches.Expected_In_Time__c = expInTime;
            updatePunches.Expected_Out_Time__c = expOutTime;
            updatePunches.Comments__c = comments;
            updatePunches.OwnerId = currentUser.id;
            update updatePunches;
            displayPopup = false;
            successBool = true;
            errorBool = false;                
            //SuccessMsg = 'Applied successfully!';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Applied successfully!'));
            
        }
        catch(exception ex){
            displayPopup = false;
            successBool = true;
            errorBool = false;                
            //SuccessMsg = 'Something went wrong!';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Something went wrong!'));
            system.debug(ex.getmessage());
        }
    }
    
    //Submit future punch for approval
    public Pagereference insertFuturePunches(){
        try{
            successBool = true;
            errorBool = true;
            SuccessMsg=''; 
            leaveSettings = [SELECT Id, Label, Max_Regularize_Future_Day_Limit__c	
                             FROM Leave_Setting__mdt 
                             WHERE Label = 'All Leave Configurations for Employee'];
            system.debug('leaveSettings.Max_Regularize_Future_Day_Limit__c'+leaveSettings.Max_Regularize_Future_Day_Limit__c);
            dateDiff=system.today().daysBetween(ledger.To_Date__c);
            system.debug('dateDiff::'+dateDiff);
            
            if(dateDiff > leaveSettings.Max_Regularize_Future_Day_Limit__c){
                system.debug('inside  limit reached if');
                
                //errorBool = true;
                //SuccessMsg = 'You can\'t apply for Regularize more than ' +leaveSettings.Max_Regularize_Future_Day_Limit__c+' days.';
                //You cant regularize for a future date greater than 10 days from today
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'You can\'t regularize for a future date greater than ' +leaveSettings.Max_Regularize_Future_Day_Limit__c+' days from today.'));
                //displayfuturePopup = false;
                return null;
            }
            system.debug('from '+ledger.From_Date__c+' to '+ledger.To_Date__c);
            list<Leave_Ledger__c> listLedger = [Select id, name, From_Date__c, To_Date__c from Leave_Ledger__c where ((From_Date__c  <=:ledger.From_Date__c AND To_Date__c  >=: ledger.To_Date__c )
                                                                                                                      OR (From_Date__c  >=:ledger.From_Date__c AND To_Date__c  <=: ledger.To_Date__c ))
                                                AND (Status__c ='Pending' OR Status__c  ='Approved')
                                                AND Employee_Id__c =: Decimal.valueOf(EmployeeId)];     
            system.debug('listLedger'+listLedger);
            
            if(listLedger.size() > 0)
            {
                system.debug('inside  leaveledger if');
                /*
                //errorBool = true;
                string leavefromdatestring = listLedger[0].From_Date__c.format();
                string leavetodatestring = listLedger[0].To_Date__c.format();
                string fromdatestring = ledger.From_Date__c.format();
                string todatestring = ledger.To_Date__c.format();*/
                //SuccessMsg = 'You have already applied leave From '+leavefromdatestring+' To '+leavetodatestring+' \n and You have selected Date From '+fromdatestring+' To '+todatestring;
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'You have already applied leave From '+leavefromdatestring+' To '+leavetodatestring+' \n and You have selected Date from '+fromdatestring+' to '+todatestring));
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'You have already applied leave for the selected date.'));
                //displayfuturePopup = false;
                return null;
            }
            
            List<Date> dateList = new List<date>();
            for(Date loopstartDate = ledger.From_Date__c; loopstartDate <= ledger.To_Date__c; loopstartDate = loopstartDate.addDays(1)){
                dateList.add(loopstartDate);
            }
            List<Employee_Calendar__c> listHolidays = [SELECT Id, Name,Status__c,Expected_In_Time__c, Date__c, Day__c, Year__c,Holiday_Name__c,Employee_Code__c,Applied_For_Regularization__c,
                                                       RecordTypeId, RecordType.Name FROM Employee_Calendar__c 
                                                       Where (RecordType.Name =:'Holiday Punch' OR (RecordType.Name =:'Employee Punch'  And Employee_Code__c =:EmployeeId AND Status__c !='Rejected')) 
                                                       And Date__c In: dateList LIMIT 1];
            if(listHolidays.size()>0)
            {  
                
                //errorBool = true;
                //displayfuturePopup = false;
                
                if(listHolidays[0].RecordType.Name =='Holiday Punch')
                {                    
                    //SuccessMsg = 'You can not apply regularization for Holidays.';
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You can not apply regularization for holidays.'));
                }
                else if(listHolidays[0].Applied_For_Regularization__c == true || listHolidays[0].Status__c == 'Pending')
                {
                    //SuccessMsg = 'This date has been already sent for regularization approval.';  
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'This date has already been sent for regularization.'));                  
                }
                else if(listHolidays[0].Status__c == 'Approved')
                {           
                    string datestring = listHolidays[0].Date__c.format();
                    //SuccessMsg = 'Regularization for '+ datestring + ' is already Approved.';  
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Regularization for '+ datestring + ' is already Approved.'));
                }     
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Punch is already present for this date.'));
                return null;
            }  
            
            Id devRecordTypeId = Schema.SObjectType.Employee_Calendar__c.getRecordTypeInfosByName().get('Employee Punch').getRecordTypeId(); 
            list<Employee_Calendar__c> listToInsertFutureReg = new list<Employee_Calendar__c>();
            
            for(Date dd : dateList){
                Employee_Calendar__c Futurepunches = new Employee_Calendar__c();
                Futurepunches.Date__c = dd;
                Futurepunches.Contact_Name__c = con.Id;
                Futurepunches.Punch_Request_Submitter__c = currentUser.Id;
                Futurepunches.Applied_To__c = userapprover.Id;
                Futurepunches.RecordTypeId = devRecordTypeId;
                Futurepunches.Employee_Code__c=EmployeeId;   
                Futurepunches.Applied_For_Regularization__c = true;
                Futurepunches.Status__c = 'Pending';
                Futurepunches.In_Time__c = futureexpInTime;
                Futurepunches.Out_Time__c = futureexpOutTime;
                Futurepunches.Expected_In_Time__c = futureexpInTime;
                Futurepunches.Expected_Out_Time__c = futureexpOutTime;
                Futurepunches.OnDuty_Leave__c = 'Official Regularized Visit';
                Futurepunches.Comments__c = futurecomments;
                system.debug('Futurepunches'+Futurepunches);
                listToInsertFutureReg.add(Futurepunches);
            }
            
            insert listToInsertFutureReg;
            
            //Flow.Interview.Regularization_Approval_Flow submitForApproval = new Flow.Interview.Regularization_Approval_Flow(new map<String,Object>{'RecordId' => Futurepunches.Id,'CurrentUserId' => currentUser.Id,'Approvar' => userapprover.Id});
            //submitForApproval.start();
            //displayfuturePopup = false;
            
            errorBool = false;                
            //SuccessMsg = 'Regularization Applied Successfully!';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Regularization applied successfully!'));
            return null;
            
            
        }
        catch(exception e){
            system.debug('error'+e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Something went wrong!'));
            return null;
        }
        
    }
    
    //Close error message
    public PageReference toogle(){
        successBool = false;
        errorBool = false;
        SuccessMsg = '';
        return null;
    }
    
    //Refresh the page
    public PageReference Cancel() {        
        PageReference orderPage = new PageReference('/apex/Flame_Regularization');
        orderPage.setRedirect(true);
        return orderPage; 
    }
}