Public class flameeventcontroller{
 public Flame_Event__c emp {get;set;}
 public Flame_Event__c emp1 {get;set;}
 public Blob file{get;set;}
 public Attachment myfile {get;set;}
 public List<Flame_Event__c> eventList {get;set;}  
 public String startDate{get;set;}
 public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

 
 //constructer
 Public flameeventcontroller(){
emp = new Flame_Event__c();
emp1 = new Flame_Event__c();
myfile = new Attachment();
emp1=[SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c,Role__c FROM Flame_Event__c limit 1];
init();

 
}
    
    public void init(){        
    if(Flame_CommunityUserInfo.profileName=='System Administrator'){
    
    eventList = [SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c,Role__c,Event_Organiser_Email_Id__c, 
                 Suggested_for_Social_Media__c,Venue__c, Event_Organiser_Name__c FROM Flame_Event__c Where IsActive__c=true ORDER BY StartDateTime__c DESC limit 500];
    }else{
    
    eventList = [SELECT Id, Content__c, Heading__c, Image__c,Event_Date__c,StartDateTime__c,Role__c,Event_Organiser_Email_Id__c,
                 Event_Organiser_Name__c,Suggested_for_Social_Media__c,Venue__c FROM Flame_Event__c Where IsActive__c=true and Role__c includes ( : Flame_CommunityUserInfo.profileName) ORDER BY StartDateTime__c DESC limit 500];         
    }
    
    System.debug('eventList --> '+eventList); 
    }
    
    public void saveDate(){
      string passedParam1 = Apexpages.currentPage().getParameters().get('startDate');
      string passedParam2 = system.CurrentPageReference().getParameters().get('startDate');
     
    }

  //Event  
   public PageReference save() {
  
    
    DateTime testDate;
    
    if(!string.isBlank(startDate)){
        testDate = DateTime.parse(startDate);
    }
       
      

  if(emp.Content__c == null){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
    return null;
  }
  RecordType rt = [SELECT Id, Name from RecordType where name = 'Event' AND SObjectType = 'Flame_Event__c'];
  Attachment  attachment = new Attachment();
   attachment.Name = 'test';
   attachment.body = file;
   attachment.parentid = emp1.id; 
  insert  attachment;
  system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment);
  
        Flame_Event__c flameann1 = new Flame_Event__c(); 
        flameann1.RecordTypeId = rt.id ;
        flameann1.Heading__c  = emp.Heading__c;
        flameann1.Image__c    = '<img src="/servlet/servlet.FileDownload?file='+attachment.id+'" ></img>'; 
        flameann1.Content__c  = emp.Content__c;
        flameann1.Role__c     = emp.Role__c;
        flameann1.Venue__c     = emp.Venue__c;
        flameann1.Suggested_for_Social_Media__c = emp.Suggested_for_Social_Media__c;
        flameann1.Event_Organiser_Name__c = emp.Event_Organiser_Name__c;
        flameann1.Event_Organiser_Email_Id__c = emp.Event_Organiser_Email_Id__c;
        if(testDate!=null){
          flameann1.StartDateTime__c = testDate;
        }
        
       try{
      insert  flameann1;
 
      }catch(Exception e) {
        System.debug('An exception occurred: ' + e.getMessage());
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'you can not leave this field blank.'));
      }
        
        PageReference pageref = new PageReference('/apex/Flame_successful_message?id='+flameann1.id);
        pageref.setredirect(true);
        return pageref;  
        

  } 
  
  
  // Announcement
  
  
  public PageReference save1() {
  RecordType rt = [SELECT Id, Name from RecordType where name = 'Announcement' AND SObjectType = 'Flame_Event__c'];
  Attachment  attachment = new Attachment();
   attachment.Name = 'test';
   attachment.body = file;
   attachment.parentid = emp1.id; 
  insert  attachment;
  system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment);
  
  Flame_Event__c flameann2 = new Flame_Event__c(); 
  flameann2.RecordTypeId = rt.id ;
  flameann2.Heading__c  = emp.Heading__c;
  flameann2.Image__c    = '<img src="/servlet/servlet.FileDownload?file='+attachment.id+'" ></img>'; 
  flameann2.Content__c  = emp.Content__c;
  flameann2.Role__c     = emp.Role__c;
 
  try{
  insert  flameann2;
   
  }catch(Exception e) {
    System.debug('An exception occurred: ' + e.getMessage());
   }
  PageReference pageref = new PageReference('/apex/Flame_successful_message?id='+flameann2.id);
  pageref.setredirect(true);
  return pageref;
  } 
  
 
  // News
  
  public PageReference save2() {
  RecordType rt = [SELECT Id, Name from RecordType where name = 'News' AND SObjectType = 'Flame_Event__c'];
  Attachment  attachment = new Attachment();
   attachment.Name = 'test';
   attachment.body = file;
   attachment.parentid = emp1.id; 
  insert  attachment;
  system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment);
  
  Flame_Event__c flameann3 = new Flame_Event__c(); 
  flameann3.RecordTypeId = rt.id ;
  flameann3.Heading__c  = emp.Heading__c;
  flameann3.Image__c    = '<img src="/servlet/servlet.FileDownload?file='+attachment.id+'" ></img>'; 
  flameann3.Content__c  = emp.Content__c;
  flameann3.Role__c     = emp.Role__c;
  flameann3.StartDateTime__c = emp.StartDateTime__c;
  try{
  insert  flameann3;
 
  }catch(Exception e) {
    System.debug('An exception occurred: ' + e.getMessage());
   }
  PageReference pageref = new PageReference('/apex/Flame_successful_message?id='+flameann3.id);
  pageref.setredirect(true);
  return pageref;
  } 
   
   public pagereference closePopup()
    {       
   
    pagereference ApplyPage = new PageReference('/apex/Flame_Home'); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage;    
    }     
     
 
   
       
}