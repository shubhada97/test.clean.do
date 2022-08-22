public without sharing class MeetingMinutesController {
    public User objUser {get;set;}
    public string strContId{get;set;}
    public List<Flame_Event__c> lstofFlameEvent{get;set;}
    public Map<Id,List<Attachment>> mapofFEventIdToAttachment{get;set;}
    public set<id> setofFEId;
    public Contact objContact;
    public set<id> setofConId;
    public set<id> setofLoginConId;
    public list<wrapperClass> lstofWrapperClass{get;set;}
    public list<wrapperClass> lstofWrapperClass1{get;set;}
    public list<wrapperClass> lstofWrapperTeamMettingClass{get;set;}
    public list<wrapperClass> lstofWrapperTeamMettingClass1{get;set;}
    public set<string> setofRole;
         
    public MeetingMinutesController(){

        lstofWrapperClass = new List<wrapperClass>();
        lstofWrapperClass1 = new List<wrapperClass>();
        lstofWrapperTeamMettingClass = new List<wrapperClass>();
        lstofWrapperTeamMettingClass1 = new List<wrapperClass>();
        setofConId = new set<Id>();
        setofLoginConId = new set<Id>();
        setofFEId = new Set<id>();
        objContact = new Contact();
        lstofFlameEvent = new List<Flame_Event__c>();
        mapofFEventIdToAttachment = new Map<id,List<Attachment>>();
        objUser = new User();
        setofRole = new set<string>();
        
        objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        system.debug('objUser@@@'+objUser.ContactID);
        
        if(objUser.ContactID != null){
            objContact = [SELECT Id,Name,Department__c,RecordTypeId,RecordType.Name FROM Contact WHERE Id=:objUser.ContactId];
            strContId = objContact.Id;
            setofLoginConId.add(objContact.Id);
            }
            
        showMyMinutes();
 
    }
         
    public void showMyMinutes()
    {
        set<string> setofAffType = new set<string>();
        
        if(strContId != null){
            for(hed__Affiliation__c objAff:[Select Id,hed__Affiliation_Type__c,hed__Account__r.Name,hed__Status__c,hed__Contact__c from hed__Affiliation__c where hed__Contact__c =:strContId and hed__Status__c != 'Former']){
            setofAffType.add(objAff.hed__Account__r.Name);
         }
        
            System.debug('strContId@@@'+strContId);
            //wrapperClass objWC = new wrapperClass();
            //and ID NOT IN:setofLoginConId
            for(Contact ObjCon:[Select Id,Department__c from Contact where Department__c =:objContact.Department__c ]){
                setofConId.add(ObjCon.id);
            }
            System.debug('setofConId@@@'+setofConId);
            if(setofConId != null && setofConId.size()>0){
                lstofFlameEvent = [Select Id,Contact__c,File_Name__c,Contact_Department__c,Meeting_Notes__c,Meeting_type__c from Flame_Event__c where Contact__c =:setofConId AND(Contact_Department__c=:objContact.Department__c OR Contact_Department__c IN:setofAffType)];//and Contact_Department__c=:objContact.Department__c  (Contact_Department__c=:objContact.Department__c OR
            }
            SYSTEM.DEBUG('lstofFlameEvent@@@'+lstofFlameEvent);
            if(lstofFlameEvent != null && lstofFlameEvent.size()>0){
                for(Flame_Event__c ObjFE:lstofFlameEvent){
                    setofFEId.add(ObjFE.Id);
                }
             
            }
            System.debug('setofFEId@@@'+setofFEId);
     
             
           if(setofFEId != null && setofFEId.size()>0){
              //  List<Attachment> objAtch = new List<Attachment>();
               List<Attachment> lstobjAtch = new List<Attachment>();
                for(Attachment objAtch:[Select Id, Name,ParentID from Attachment where ParentID IN:setofFEId order by createddate,name desc]){
                  //  objAtch = [Select Id, Name,ParentID from Attachment where ParentID IN:setofFEId order by createddate desc];
                    
                    
                    if(mapofFEventIdToAttachment.containsKey(objAtch.ParentID)){
                        
                        lstobjAtch = mapofFEventIdToAttachment.get(objAtch.ParentID);
                        lstobjAtch.add(objAtch);
                        mapofFEventIdToAttachment.put(objAtch.ParentID, lstobjAtch);
                        
                    }
                    else
                    {
                       mapofFEventIdToAttachment.put(objAtch.ParentID, new List<Attachment> {objAtch});
                    }
                }
                
            }
            if(mapofFEventIdToAttachment !=null && mapofFEventIdToAttachment.size()>0){
                  
                for(Flame_Event__c ObjFE:[Select ID,File_Name__c,Heading__c,StartDateTime__c,Content__c,Contact_Department__c,Meeting_Notes__c,Meeting_type__c from Flame_Event__c where ID IN:mapofFEventIdToAttachment.keyset() ORDER BY CREATEDDATE DESC]){
                    wrapperClass objWC = new wrapperClass();
                    objWC.strDepartment = ObjFE.Contact_Department__c;
                    objWC.strTypeofMeeting = ObjFE.Meeting_type__c;
                   // objWC.strNotes = ObjFE.Meeting_Notes__c;
                   objWC.strTitle = ObjFE.Heading__c;
                    objWC.strFlameEventId = ObjFE.id;
                    objWC.strFileName =ObjFE.File_Name__c;
                  // objWC.strFileName =mapofFEventIdToAttachment.get(ObjFE.id).name;
                    objWc.strdatetime=ObjFE.StartDateTime__c;
                    objWc.strcontent =ObjFE.Content__c;
                    lstofWrapperClass.add(objWC);
                    setofFEId.add(ObjFE.Id);
                  // system.debug('MapFieldValue--'+String.valueof(mapofFEventIdToAttachment.get(ObjFE.File_Name__c)));
                }
                  
            }
             
              SYSTEM.DEBUG('mapofFEventIdToAttachment@@@'+mapofFEventIdToAttachment.size());
              SYSTEM.DEBUG('lstofWrapperClass@@@'+lstofWrapperClass);
            if(mapofFEventIdToAttachment !=null && mapofFEventIdToAttachment.size()>0){
                if(lstofWrapperClass !=null && lstofWrapperClass.size()>0){
                    List<Attachment> attachList = new List<Attachment>();
                    for(WrapperClass objWrap:lstofWrapperClass){
                        
                        wrapperClass objW = new wrapperClass();
                        objW = objWrap;
                        if(mapofFEventIdToAttachment.containskey(objWrap.strFlameEventId) !=null){
                            
                            List<wrapper2> t2 = new List<wrapper2>();
            for(Attachment at:mapofFEventIdToAttachment.get(objWrap.strFlameEventId)){
                wrapper2 twrap2 = new wrapper2();
                twrap2.Att=at;
                t2.add(twrap2);
            }
            objW.Atts=t2;
           
                             
                        }
                    
                        lstofWrapperClass1.add(objW);
                    }
                 //   system.debug('attachList--'+attachList);
                }
            }
             
              SYSTEM.DEBUG('lstofWrapperClass1@@@'+lstofWrapperClass1);
             
             

        }
    }
         
    public class wrapperClass{
        public string strDepartment{get;set;}
        public string strTypeofMeeting{get;set;}
        public string strNotes{get;set;}
        public List<Attachment> strAttachName{get;set;}
       // public string strAttachName{get;set;}
        public string strFileName{get;set;}
        public string strAttachId{get;set;}
        public string strFlameEventId{get;set;}
        public string strTitle{get;set;}
        public datetime strdatetime{get;set;}
        public string strcontent{get;set;}
        public List<wrapper2> Atts {get; set;}
      //  public List<Attachment> strFileName{get;set;}
       // public List<string> strAttachId{get;set;}        
        public wrapperClass()
        {
        }

    }
         
     //wrapper 2 - the sub-wrapper
    class wrapper2{
        public Attachment Att {get; set;}
      
        public wrapper2(){
            
        }
    }
    
         public PageReference redirectToFlameEvent()
         {
            PageReference myVFPage = new PageReference('/apex/CreateFlameEvent?conid='+strContId);
            myVFPage.setRedirect(true);
            
            return myVFPage;
         }
         
          public Double offset{get
        {
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
        }
        }
    }