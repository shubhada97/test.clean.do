Public class flameNewscontroller{
 public Flame_News__c emp {get;set;}
 Public Boolean IsCreated {get;set;}
 public List<Flame_News__c> NewsList {get;set;}  
 public Flame_News__c emp1 {get;set;} 
 Attachment d = new Attachment();
 public Blob file{get;set;}
     
Public flameNewscontroller(){
emp = new Flame_News__c();
emp1 = new Flame_News__c();
emp1=[SELECT Id,CreatedDate, Content__c, Heading__c, Image__c,Role__c FROM Flame_News__c limit 1];
init();
d = new Attachment();
}


    public void init(){        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
          
           newsList = [SELECT Id,CreatedDate, Content__c, Heading__c, Image__c,Role__c FROM Flame_News__c Where IsActive__c=true ORDER BY CreatedDate DESC limit 500];
        }else{
           
          newsList = [SELECT Id,CreatedDate, Content__c, Heading__c, Image__c,Role__c FROM Flame_News__c Where IsActive__c=true and Role__c includes ( : Flame_CommunityUserInfo.profileName ) ORDER BY CreatedDate DESC limit 500];        
        }
       
        System.debug('NewsList --> '+NewsList); 
   }  
   
   
  public PageReference save() {
  Attachment  attachment = new Attachment();
   attachment.Name = 'test';
   attachment.body = file;
   attachment.parentid = emp1.id; 
  insert  attachment;
  system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+attachment);
  try{
  Flame_News__c flameann = new Flame_News__c(); 
  flameann.Heading__c  = emp.Heading__c;
  flameann.Image__c    = '<img src="/servlet/servlet.FileDownload?file='+attachment.id+'" ></img>'; 
  flameann.Content__c  = emp.Content__c;
  flameann.Role__c     = emp.Role__c;
  insert  flameann;
  
  system.debug('flameann'+flameann);
  PageReference pageref = new PageReference('/apex/Flame_Home?id='+flameann.id);
  pageref.setredirect(true);
  return pageref;
  }catch(Exception e) {
    System.debug('An exception occurred: ' + e.getMessage());
   }
   return null;
  } 
   
   public pagereference closePopup()
    {       
    IsCreated = false;
    pagereference ApplyPage = new PageReference('/apex/flame_new_events?id='+emp.id); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage;    
    }     
     
  Public PageReference Requesttosend(){
  IsCreated = true;
  searchError = 'Thank you, request has been submited.';
  
  return null;
  
  }  
    public String searchError;
    public String getSearchError() {
    return searchError; //return searchError value
    }     
       
}