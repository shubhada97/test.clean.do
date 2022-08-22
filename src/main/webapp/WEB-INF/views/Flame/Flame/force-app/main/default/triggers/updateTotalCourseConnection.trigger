trigger updateTotalCourseConnection on hed__Course_Enrollment__c (after insert,after delete) {
 set<Id> setofCourseOfferds = new set<Id>();
 list<hed__Course_Offering__c> updatecoueseoffering = new list<hed__Course_Offering__c>();
 if(Trigger.isUpdate ||Trigger.isInsert)
 {
  for(hed__Course_Enrollment__c c : trigger.new)
  {
   setofCourseOfferds.add(c.hed__Course_Offering__c);
  }
 }
 if(Trigger.isDelete)
 {
  
  for(hed__Course_Enrollment__c c : trigger.old)
  {
   setofCourseOfferds.add(c.hed__Course_Offering__c);
  }
 }

 //run the query to sum the data
 AggregateResult[] totalCourseEnrollment = [select COUNT(id), hed__Course_Offering__c  From hed__Course_Enrollment__c where hed__Course_Offering__c IN:setofCourseOfferds group by hed__Course_Offering__c];
 
 System.debug('totalAges@@@'+totalCourseEnrollment);
 for(AggregateResult ar: totalCourseEnrollment)
 {
  /*Id thiscourseofferingId = string.valueOf(ar.get('hed__Course_Offering__c'));
  hed__Course_Offering__c thisAccount = new hed__Course_Offering__c(Id = thiscourseofferingId);    
  thisAccount.Total_Course_Connection__c =double.valueof(ar.get('numApps'));*/
  
  Id thiscourseofferingId = (ID)ar.get('hed__Course_Offering__c');
  Integer count = (INTEGER)ar.get('expr0');
  hed__Course_Offering__c thisCF = new hed__Course_Offering__c(Id = thiscourseofferingId);  
  thisCF.Total_Enrolled__c = count-1;
  updatecoueseoffering.add(thisCF);
 }
 update updatecoueseoffering;

}