public class Flame_ResourcesSchedulecontroller {

public B25__Reservation__c bcc{get;set;}
public List<B25__Reservation__c> reserList {get;set;}
public boolean showResult{get;set;}
// create a list of strings to hold the conditions
List<string> conditions = new List<string>();
private integer totalRecs = 0;
private integer OffsetSize = 0;
private integer LimitSize= 50;
//constructer
Public Flame_ResourcesSchedulecontroller(){
system.debug('==>Flame_Booker25==>');
bcc = new B25__Reservation__c();
showResult = false;

}
//action method  
public void resources(){
totalRecs = 0;
OffsetSize = 0;
if(reserList !=null && reserList.size()>0){
 reserList=null;
 showResult = true;
}
searchAccounts ();
conditions.clear();
}
//Public B25__Resource__c resource {get;set;}

//method
public Void searchAccounts(){

System.debug('Total Records is ==>'+totalRecs);
System.debug('OffsetSize is ==>'+OffsetSize);

if(reserList != null && !reserList.isEmpty()){
  reserList.clear();
 
  
}
 String strQuery ='SELECT B25__ABRCompositeKey__c,B25__ABRSerialNr__c,B25__ABRSerialPartNr__c,B25__Account__c,B25__AutomatedBookingRule__c,'
                                        +' B25__Base_Price__c,B25__Calculation_Method__c,B25__Contact__c,B25__EndLocal__c,B25__End_Date__c,B25__End_GMT__c,'
                                        +' B25__End_Local_DateTime__c,B25__End__c,B25__Event_Id__c,B25__Group__c,B25__Has_Conflicts__c,B25__Has_Resource_Conflicts__c,'
                                        +' B25__Has_Staff_Conflicts__c,B25__Hover__c,B25__Info__c,B25__IsUnassigned__c,B25__Local_End_Time__c,B25__Local_Start_Time__c,'
                                        +' B25__MaxCapacity__c,B25__Notes__c,B25__OpportunityLineItem__c,B25__Opportunity__c,B25__Price__c,B25__Quantity__c,'
                                        +' B25__Recurring_Reservation__c,B25__Reservation_Type__c,B25__ResourceName__c,B25__ResourceTimezone__c,B25__Resource__c,'
                                        +' B25__Sample_Custom_Field__c,B25__SelectedLayout__c,B25__SelectedTimeframe__c,B25__Service_Costs__c,'
                                        +' B25__Skip_Subtotal_Calculation__c,B25__Staff__c,B25__StartLocal__c,B25__Start_Date__c,B25__Start_GMT__c,'
                                        +' B25__Start_Local_DateTime__c,B25__Start__c,B25__Status__c,B25__Subtotal__c,B25__Title__c,B25__Total_Price__c,'
                                        +' B25__User__c,B25__Visit__c,Id,Name FROM B25__Reservation__c ';
 if(bcc.B25__StartLocal__c !=null){
  String fromDate = bcc.B25__StartLocal__c+'';
  fromDate = fromDate.split(' ',0)[0]+'T00:00:00.000Z';
   conditions.add('B25__StartLocal__c>='+fromDate);
 }

if(bcc.B25__EndLocal__c !=null){
 String toDate = bcc.B25__EndLocal__c+'';
  toDate = toDate.split(' ',0)[0]+'T23:59:59.000Z';
   conditions.add('B25__EndLocal__c<='+toDate);
 }

 if(bcc.Name !=null && bcc.Name !=''){
   conditions.add('Name Like \'%' +bcc.Name +'%\' ');
 }
 /* if(bcc.B25__Resource__r.name !=null && bcc.B25__Resource__r.name !=''){
   conditions.add('B25__Resource__r.name Like\'%' +bcc.B25__Resource__r.name +'%\' ');
 
 }*/
/* if(resource!=null){
 //strQuery = Database.query('select id,B25__Resource__r.name from B25__Reservation__c where B25__Resource__c like \'%'+resource+'%\'');  
 conditions.add('resource Like\'%' +bcc.B25__Resource__c +'%\' ');                  
        }*/
  if (conditions.size() > 0) {
   strQuery += '  WHERE ' + conditions[0];
   for (Integer i = 1; i < conditions.size(); i++)
            strQuery += '  AND ' + conditions[i];
  }
 if(totalRecs !=null && totalRecs ==0){
    List<B25__Reservation__c> accTemp = Database.query(strQuery);
    totalRecs = (accTemp !=null &&accTemp.size()>0)?accTemp.size():0;
 }

 system.debug('strQuery ==>'+strQuery );
 // add sort and limits at the end  
  strQuery += ' ORDER BY B25__StartLocal__c  ASC, CreatedDate DESC LIMIT :LimitSize OFFSET :OffsetSize';
  
  reserList  =Database.query(strQuery);
  
   

  //conditions.clear();
  //return accountList.size();
}

public void FirstPage()
{
OffsetSize = 0;
searchAccounts();
}
public void previous()
{
OffsetSize = (OffsetSize-LimitSize);
searchAccounts();
}
public void next()
{
OffsetSize = OffsetSize + LimitSize;
searchAccounts();
}
public void LastPage()
{
OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
searchAccounts();
}
public boolean getprev()
{

if(OffsetSize == 0){

return true;
}
else {

return false;
}
}
public boolean getnxt()
{
if((OffsetSize + LimitSize) > totalRecs){

return true;
}
else {

return false;
}
}


}