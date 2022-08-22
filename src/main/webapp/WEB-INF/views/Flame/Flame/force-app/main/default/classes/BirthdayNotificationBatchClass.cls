global class BirthdayNotificationBatchClass implements Database.Batchable<SObject>{
           Date todayDate = date.today();
           Integer todayDy = todayDate.day();
           Integer todayMon = todayDate.month(); 
global  Database.QueryLocator Start(Database.BatchableContext BC){
    
    String query='Select Id,FirstName, LastName, Email,DOB__c From Contact Where Email!=null AND ((DAY_IN_MONTH(DOB__c)=29 and CALENDAR_MONTH(DOB__c)=2) OR '; // (DAY_IN_MONTH(DOB__c)=:todayDy AND CALENDAR_MONTH(DOB__c)=:todayMon)';
     query+='(DAY_IN_MONTH(DOB__c)='+todayDy+' AND CALENDAR_MONTH(DOB__c)='+todayMon+'))';
     query+=' AND ( '; 
     query+='RecordType.Name=\'FU-Employee\''+' AND ';  
     query+='DOB__c!=null'+' )';  
    System.debug('The query is *****************' +query); 
    System.debug('The Query results are ****************' +Database.getQueryLocator(query));
    return Database.getQueryLocator(query); 
 }
 global void Execute(Database.BatchableContext BC,List<Contact> listCon){
     System.debug('The size of listCon is ******************' +listCon.size());
    List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
    EmailTemplate e = [Select id, DeveloperName from EmailTemplate where DeveloperName='BirthDay_Wishes_Template'];
    for(Contact conRec : listCon){
           Date myDt = date.today();
           Integer todayDy = myDt.day();
           Integer todayMon = myDt.month(); 
           if(todayDy == conRec.DOB__c.day() && todayMon == conRec.DOB__c.month()){
                 System.debug('Enetring into if loooppp ******************' +conRec.DOB__c);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'erphelpdesk@flame.edu.in'];  
               if ( owea.size() > 0 ) 
               { email.setOrgWideEmailAddressId(owea.get(0).Id);}
                 email.setToAddresses(new List<String>{conRec.Email}); 
                 email.setTargetObjectId(conRec.Id);
                 email.setTemplateId(e.id);
          //     email.setSubject('Many Many Happy Returns of the Day. Have a Blast!');
          //     string message='<html><body><font face="Lucida Handwriting" color="MidnightBlue" size="5">Dear &nbsp;'+conRec.FirstName+',</font><br/><br/> <font face="Monotype Corsiva" color="Red"size="5"><center>Wishing You a Very WARM BirthDay! May you get the best of everything in life.</center></font><br/><font face="Monotype Corsiva" color="black"size="5"><center>May all your dreams and wishes come true!</center></font><br/><font face="Monotype Corsiva" color="green" size="5"><center>FLAME Team wishing you Many More Happy Returns of the Day !!!!</center></font><br/><br/><font face="Monotype Corsiva" color="MidnightBlue" size="5">Cheers,<br/>Flame Fun Team </font></body></html>'; 
          //     email.setHtmlBody(message);
                 allMails.add(email); 
        }
    }
    System.debug('The email addressres are *******************' +allMails); 
   Messaging.sendEmail(allMails);  
 }
 global void finish(Database.BatchableContext BC){
  }
}