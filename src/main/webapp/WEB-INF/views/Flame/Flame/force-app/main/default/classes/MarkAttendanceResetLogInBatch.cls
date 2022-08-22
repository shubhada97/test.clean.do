global class MarkAttendanceResetLogInBatch implements Database.Batchable<sObject>,Database.Stateful,Schedulable {
    global MarkAttendanceResetLogInBatch(){
    }
    Set<id> successRecord = new Set<id>();
    Set<id> failRecord = new Set<id>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        String value = 'Start';
        String recordTypeName = 'FU-Student';
        String query = 'select ID,GeoLocation_Stop__Latitude__s,GeoLocation_Stop__Longitude__s,In_Time__c,Out_Time__c,User__c,LogIn_Status__c,Date__c,RecordTypeId from Employee_Calendar__c where contact_name__r.RecordType.Name !=:recordTypeName and LogIn_Status__c =:value  and Out_Time__c = null';
        system.debug('query-->'+Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext bc, List<Employee_Calendar__c> records){
        system.debug('records-->'+records);
        // process each batch of records
        List<Employee_Calendar__c> recordsToUpdate = new List<Employee_Calendar__c>();
        
        for(Employee_Calendar__c empCal : records)
        { 
            empCal.LogIn_Status__c ='Stop';
           
            recordsToUpdate.add(empCal); 
            
        }       
        Database.SaveResult[] srList = Database.update(recordsToUpdate, false);
        
        for (Database.SaveResult sr : srList) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                successRecord.add(sr.getId());
            }
            
            else {
                for(Database.Error err : sr.getErrors()) {
                }
                failRecord.add(sr.getId());
            }
        }
        
    }
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'SystemAdminEmail' LIMIT 1];
String body = sr.Body.toString();
     // String emailSysAdm = 'manish.harne@techilaservices.com';   
          //nikhalesh.mishra@flame.edu.in
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      
   String[] toAddresses = new String[] {body};
   mail.setToAddresses(toAddresses);
   mail.setSubject('Mark Attendance update' + a.Status);
   mail.setPlainTextBody
       
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.'+successRecord+'successRecordids: '+ 'failRecordids: '+ failRecord);
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
        global void execute(SchedulableContext sc)

     {

       MarkAttendanceResetLogInBatch b = new MarkAttendanceResetLogInBatch(); // Your batch class

       database.executeBatch(b);

     }
    
}