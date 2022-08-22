global class Flame_WeekEndsHolidayBatch implements Database.Batchable<sObject>,database.stateful{
    global set<id> allIds = new set<id>();
    global set<id> allFailedId = new set<id>();
    global set<id> allSuccessId = new set<id>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String customMetadata = 'All Leave Configurations for Employee';
        
        return Database.getQueryLocator('SELECT Id,Weekly_Saturday_Holiday__c FROM Leave_Setting__mdt where Label=\''+ customMetadata + '\'');
        
    }
    
    global void execute(Database.BatchableContext BC, List<Leave_Setting__mdt> listOfLeaveSetting){
        try{
            List<Date> sundays = new List<Date>();
            RecordType recTypeId = [Select Id From RecordType  Where SobjectType = 'Employee_Calendar__c' and DeveloperName = 'Holiday_Punch'];
            Map<Integer,Date> mapOfMonthPlusFirstSaturday = new Map<Integer,Date>();
            List<Employee_Calendar__c> listOfEmployeeCalendar = new List<Employee_Calendar__c>();
            List<String> listOfholidaysSaturday;
            
            Integer Year = 0;
            
            Integer currentYear =  Date.today().year();
            Integer nextYear =  Date.today().year()+1;
            Integer recordsCountCurrentYear = [Select Count() From Employee_Calendar__c Where RecordType.Name =: 'Holiday Punch' And Year__c =: currentYear];
            Integer recordsCountNextYear = [Select Count() From Employee_Calendar__c Where RecordType.Name =: 'Holiday Punch' And Year__c =: nextYear];
            
            if(recordsCountCurrentYear == 0){
                Year = currentYear;
            }
            else if(recordsCountNextYear == 0){
                Year = nextYear;
            }
            if(Year != 0){
                for(Integer i=1;i<=12;i++){
                    Date firstDayOfMonth = Date.newInstance(Year, i, 1);
                    Date firstSunday = firstDayOfMonth.toStartOfMonth().toStartOfWeek();  
                    if(firstSunday < firstDayOfMonth.toStartOfmonth())
                        firstSunday = firstSunday.addDays(7);
                    Datetime pointer = Datetime.newInstance(firstSunday, Time.newInstance(0,0,0,0));
                    while (pointer.month() == i)
                    {
                        sundays.add(pointer.date());
                        pointer = pointer.addDays(7);
                    }		
                    
                    Date firstSaturday = Date.newInstance(firstSunday.year(), firstSunday.month(), (firstSunday.day()-1));
                    if(firstSaturday < firstDayOfMonth.toStartOfmonth())
                        firstSaturday = firstSaturday.addDays(7);
                    listOfholidaysSaturday = (listOfLeaveSetting[0].Weekly_Saturday_Holiday__c).split(',');
                    for(String saturdayObj : listOfholidaysSaturday){
                        Employee_Calendar__c employeeCalendarObj = new Employee_Calendar__c();
                        employeeCalendarObj.Holiday_Name__c = 'Saturday OFF';
                        employeeCalendarObj.RecordTypeId = recTypeId.Id;
                        Date varCurrentMonthFirstSaturday = firstSaturday;
                        if(Integer.valueOf(saturdayObj) == 1){
                            varCurrentMonthFirstSaturday.addDays(0);
                        }else if(Integer.valueOf(saturdayObj) == 2){
                            varCurrentMonthFirstSaturday = varCurrentMonthFirstSaturday.addDays(7);
                        }else if(Integer.valueOf(saturdayObj) == 3){
                            varCurrentMonthFirstSaturday = varCurrentMonthFirstSaturday.addDays(14);
                        }else if(Integer.valueOf(saturdayObj) == 4){
                            varCurrentMonthFirstSaturday = varCurrentMonthFirstSaturday.addDays(21);
                        }else if(Integer.valueOf(saturdayObj) == 5){
                            varCurrentMonthFirstSaturday = varCurrentMonthFirstSaturday.addDays(28);
                        }
                        employeeCalendarObj.Date__c = varCurrentMonthFirstSaturday;
                        if(i == varCurrentMonthFirstSaturday.month()){
                            listOfEmployeeCalendar.add(employeeCalendarObj);
                        }
                    }
}
                
                for(Date sundayDateObj : sundays){
                    Employee_Calendar__c employeeCalendarObj = new Employee_Calendar__c();
                    employeeCalendarObj.Holiday_Name__c = 'Sunday';
                    employeeCalendarObj.RecordTypeId = recTypeId.Id;
                    employeeCalendarObj.Date__c = sundayDateObj;
                    listOfEmployeeCalendar.add(employeeCalendarObj);
}
                
                System.debug('=======List Size======='+listOfEmployeeCalendar.size());
                if (!listOfEmployeeCalendar.isEmpty()) {
                    database.SaveResult[] myResult = database.insert(listOfEmployeeCalendar,false);
                    for(database.SaveResult s : myResult){
                        if(!s.isSuccess()){
                            database.Error[] er = s.getErrors();
                            for(database.Error e : er){
                                for(id i : allIds){
                                    if(!allSuccessId.contains(i)){
                                        allFailedId.add(i);
                                        system.debug('failed Ids----' +allFailedId);
                                    }
                                    system.debug('Failes message----' +e.getMessage());
                                }
                            }
                        }
                    }
}
            }
        }catch(Exception ex){
            System.debug('========'+ex.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}