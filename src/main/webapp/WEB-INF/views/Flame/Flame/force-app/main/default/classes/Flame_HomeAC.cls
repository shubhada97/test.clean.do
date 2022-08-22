/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_HomeAC
* Created Date: August 02 2018
* Description: home page of customer community
*******************************************************************/
public class Flame_HomeAC {    
    public List<Flame_Event__c> announcementList {get;set;}
    public List<Flame_Event__c> newsList {get;set;}
    public List<Flame_Event__c> eventList {get;set;}
    public Map<String,String> contentMap {get;set;}
    public User userDetails {get;set;}
    public Contact userContact {get;set;}
     public List<Flame_Event__c> AlumniList {get;set;}
    public Flame_HomeAC(){
        announcementList = new List<Flame_Event__c>();
        newsList = new List<Flame_Event__c>();
        eventList = new List<Flame_Event__c>();
        contentMap = new Map<String,String>();
         AlumniList = new List<Flame_Event__c>();
        //-- default method
        init();
    }
    
    //-- default initialization method 
     public void init(){        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            announcementList = [SELECT Id, Content__c,StartDateTime__c, Heading__c,Venue__c, Image__c FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'Announcement' ORDER BY CreatedDate DESC limit 500];
            newsList = [SELECT Id,CreatedDate, Content__c,StartDateTime__c, Heading__c,Venue__c, Image__c FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'News' ORDER BY CreatedDate DESC limit 500];
            eventList = [SELECT Id, Content__c, Heading__c,StartDateTime__c, Image__c,Venue__c,Event_Date__c FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'Event'And StartDateTime__c >= TODAY ORDER BY StartDateTime__c  ASC limit 500];
            AlumniList =  [SELECT Id, Content__c, Heading__c, Image__c FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'Alumni Stories' and Role__c includes ( : Flame_CommunityUserInfo.profileName ) ORDER BY CreatedDate DESC limit 500];        
        }else{
            announcementList = [SELECT Id, Content__c,StartDateTime__c, Heading__c,Venue__c, Image__c FROM Flame_Event__c Where IsActive__c=true and RecordType.Name = 'Announcement' and Role__c includes (: Flame_CommunityUserInfo.profileName ) ORDER BY CreatedDate DESC limit 500];
            newsList = [SELECT Id,CreatedDate, Content__c,StartDateTime__c, Heading__c,Venue__c, Image__c FROM Flame_Event__c Where IsActive__c=true and RecordType.Name = 'News' and Role__c includes ( : Flame_CommunityUserInfo.profileName ) ORDER BY CreatedDate DESC limit 500];
            eventList = [SELECT Id, Content__c, Heading__c,StartDateTime__c,Venue__c, Image__c,Event_Date__c FROM Flame_Event__c Where IsActive__c=true and RecordType.Name = 'Event'  And StartDateTime__c >= TODAY and Role__c includes ( : Flame_CommunityUserInfo.profileName) ORDER BY StartDateTime__c  ASC limit 500]; 
            AlumniList =  [SELECT Id, Content__c, Heading__c, Image__c FROM Flame_Event__c Where IsActive__c=true AND RecordType.Name = 'Alumni Stories' and Role__c includes ( : Flame_CommunityUserInfo.profileName ) ORDER BY CreatedDate DESC limit 500];                
        }
        System.debug('announcementList --> '+announcementList); 
        System.debug('newsList --> '+newsList); 
        System.debug('eventList --> '+eventList); 
        
        for(Flame_Event__c tempObj : announcementList){
            String content = tempObj.Content__c;
            content = content.replaceAll('\\<.*?\\>', '');
			content = content.replaceAll('&amp;', '&');
           content = content.replaceAll('&gt;', '>');
           content = content.replaceAll('&lt;', '<');
           content = content.replaceAll('&quot;', '"');
           content = content.replaceAll('&#39;', '\'');            
            if(content.length()>200){
                content = content.substring(0,200);
                contentMap.put(tempObj.Id, content);    
            }else{
                contentMap.put(tempObj.Id, content);
            }
            
        }
        for(Flame_Event__c tempObj : newsList){
            String content = tempObj.Content__c;
            content = content.replaceAll('\\<.*?\\>', ''); 
            content = content.replaceAll('\\<.*?\\>', ''); 
            content = content.replaceAll('&amp;', '&');
           content = content.replaceAll('&gt;', '>');
           content = content.replaceAll('&lt;', '<');
           content = content.replaceAll('&quot;', '"');
           content = content.replaceAll('&#39;', '\'');
            if(content.length()>200){
                content = content.substring(0,200);
                contentMap.put(tempObj.Id, content);    
            }else{
                contentMap.put(tempObj.Id, content);
            }
        }
       for(Flame_Event__c tempObj : eventList){
            String content = tempObj.Content__c;
            content = content.replaceAll('\\<.*?\\>', '');
            content = content.replaceAll('&amp;', '&');
           content = content.replaceAll('&gt;', '>');
           content = content.replaceAll('&lt;', '<');
           content = content.replaceAll('&quot;', '"');
           content = content.replaceAll('&#39;', '\'');
            if(content.length()>200){
                content = content.substring(0,200);
                contentMap.put(tempObj.Id, content);    
            }else{
                contentMap.put(tempObj.Id, content);
            }
        }
         system.debug('contentMap-->'+contentMap);
        for(Flame_Event__c tempObj : AlumniList){
            String content = tempObj.Content__c;
            
            if(content.length()>200){
                content = content.substring(0,200);
                contentMap.put(tempObj.Id, content);    
            }else{
                contentMap.put(tempObj.Id, content);
            }
        }
      //Alumni  
        userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email,Primary_Contact_Type__c from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
           
    }
    
  
    
    
    
    
    //-- Method redirect to ReadMore page for record details
    public PageReference readMoreDetailPage(){
        String objectName = ApexPages.currentPage().getParameters().get('objectName');
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
     //  if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_ReadMore;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
      //  }
      //  return null;
    }
    
    
    
    Public PageReference Viewallevents(){
    String objectName = ApexPages.currentPage().getParameters().get('objectName');
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        // if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_EventCalender_Page;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
     //  }
     // return null;  
    }
     Public PageReference ViewallNews(){
    String objectName = ApexPages.currentPage().getParameters().get('objectName');
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        // if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_Newspage;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
     //  }
     // return null;  
    }
    
  Public PageReference subnewAnnouncement(){
    String objectName = ApexPages.currentPage().getParameters().get('objectName');
    String recordId = ApexPages.currentPage().getParameters().get('recordId');
        // if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_New_Announcement_Form;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
     //  }
     // return null;  
    }  
    
    
     Public PageReference subnewEvents(){
    String objectName = ApexPages.currentPage().getParameters().get('objectName');
    String recordId = ApexPages.currentPage().getParameters().get('recordId');
        // if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_New_Events;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
     //  }
     // return null;  
    }  
    
     Public PageReference subnewNews(){
    String objectName = ApexPages.currentPage().getParameters().get('objectName');
    String recordId = ApexPages.currentPage().getParameters().get('recordId');
        // if(objectName!=null && recordId!=null){
            PageReference pg = Page.Flame_New_News_Page;
            pg.setRedirect(true);
            pg.getParameters().put('oname',objectName);
            pg.getParameters().put('rid',recordId);
            return pg;
     //  }
     // return null;  
    }  
}