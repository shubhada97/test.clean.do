Public class EventCalendarController{
  
  public list <CalendarEvent> events {get;set;}
// String dtFormat = 'yyyy-MM-dd HH:mm:ss'; 
   String dtFormat = 'EEE, d MMM yyyy HH:mm:ss ';
public String eventIdTemp   {get;set;}  //Selected event Id coming from vf page
    public String st    {get;set;}  //Selected event start date
    public String ed    {get;set;} //Selected event end date
    public List <Flame_Event__c> eventList = new List <Flame_Event__c> ();

    public EventCalendarController () {
    events = new list <CalendarEvent> ();
    eventList = new List <Flame_Event__c>();
    eventlists = new List<Flame_Event__c>();
    init();
    }

 //-- default initialization method 
    public void init(){        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
         eventList = [SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c  FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'Event' ORDER BY StartDateTime__c DESC limit 500];
        }else{
         eventList = [SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c FROM Flame_Event__c Where IsActive__c=true  AND RecordType.Name = 'Event' and Role__c includes ( : Flame_CommunityUserInfo.profileName) limit 500]; 
            system.debug('eventList-->'+eventList);
        }

  }
 public PageReference pageLoad() {
           events = new list <CalendarEvent> ();
            for(Flame_Event__c e : eventList){        
            DateTime DT = datetime.newInstance(e.StartDateTime__c.year(), e.StartDateTime__c.month(),e.StartDateTime__c.day(),e.StartDateTime__c.hour(),e.StartDateTime__c.minute(),e.StartDateTime__c.second ());
          
           CalendarEvent newEvent = new CalendarEvent();  
            newEvent.eventId = e.Id; 
            newEvent.eventTitle = e.Heading__c;
            newEvent.eventStart = Dt.format(dtFormat);
            newEvent.url = '/apex/Flame_Event_Detail_Page?eid=' + e.Id; 
            newEvent.className = 'event-personal';
            events.add(newEvent);
        }
        return null;
    }

   public class CalendarEvent {

    public String eventId       {get;set;}
    public String eventTitle    {get;set;}
    public String eventStart    {get;set;}
    public String url           {get;set;}
    public String className     {get;set;}
}
 Public List<Flame_Event__c> eventlists {get;set;}
Public pageReference eventDetails(){
eventlists = new List<Flame_Event__c>();
eventlists =[SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c,Event_Organiser_Email_Id__c,Event_Organiser_Name__c,
Suggested_for_Social_Media__c,Venue__c FROM Flame_Event__c WHERE Id = :ApexPages.currentPage().getParameters().get('eid') AND IsActive__c=true  AND RecordType.Name = 'Event' limit 500];
System.debug('------eventlists-----'+eventlists);
return null;
}

 Public PageReference subnewEvents(){
    PageReference pg = Page.Flame_New_Events;
    pg.setRedirect(true);
    return pg;
    //  }
    // return null;  
    }  
    
    Public PageReference viewallevents(){
    PageReference pg = Page.flame_eventpage;
    pg.setRedirect(true);
    return pg;
    //  }
    // return null;  
    }    

}