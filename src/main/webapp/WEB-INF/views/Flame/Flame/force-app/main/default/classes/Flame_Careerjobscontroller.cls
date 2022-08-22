public class Flame_Careerjobscontroller {
  
    public String contactId {get;set;}
    public User userDetails {get;set;}
    public Contact userContact {get;set;} 
    public String rId{get;set;}
    Public FLAME_Job__c jobs {get;set;}
    Public FLAME_Job_Application__c app {get;set;}
    public Boolean payBool {get;set;}
     public String paymentErrorMsg {get;set;}
    /* setting the jobs to display*/
    private integer totalRecs = 0;     
    private integer index = 0;
    private integer blockSize = 500;
    public static final String fullName = UserInfo.getName();
    public static final String firstName = UserInfo.getFirstName();
    public static final String lastName = UserInfo.getLastName();    
    public static final String profileName =  [SELECT Name FROM Profile WHERE id =: UserInfo.getProfileId()].Name;
    public static final String userName = UserInfo.getUserName();
    public static final String userEmail = UserInfo.getUserEmail();
    Public List<FLAME_Job_Application__c>tempapplicationList  {get;set;}
    List<FLAME_Job__c>tempContactList = new   List<FLAME_Job__c>();
    Public FLAME_Job__c job {get;set;}
    Public FLAME_Job_Application__c jobapplication {get;set;}
    public string newApplicationId;
    public String message {get;set;}
    public boolean DisplayPopup {get; set;} 
   
    
    public  List<FLAME_Job__c> getSearchAcc() {
        
        Set<Id> recordTypeIdSet = new Set<Id>();
        List<Flameplacementjobs_Record_Ass__c> communityAssistList = [Select id,Name,Record_Type__c,Tab_Type__c from Flameplacementjobs_Record_Ass__c Where Tab_Type__c='Placements'  limit 1];
        if(communityAssistList.size()>0){
        String contactRecordType = communityAssistList[0].Record_Type__c;
         List<String> recordTypeName = new  List<String>();
         if(contactRecordType!=null){
            recordTypeName = contactRecordType.split(';');                  
         }
         List<RecordType> recordTypeList = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType='FLAME_Job__c' AND Name IN : recordTypeName];
            System.debug('PS RecordTypeList : '+recordTypeList);
            
            for(RecordType rType : recordTypeList){
                recordTypeIdSet.add(rType.Id);
            }
            System.debug('PS RecordType ID : '+recordTypeIdSet);
            
        }
        
      
        
        try {
        
          userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
          System.debug('User Info :'+userDetails);        
        
        if(userDetails.ContactId!=null){
            userContact = [Select id,Name,Email,Program_Version__c from Contact Where id=:userDetails.ContactId];                                    
            System.debug('User Contact Id  : '+ userDetails.ContactId);
        }
      String contProgVersion = userContact.Program_Version__c;   
      tempContactList = Database.Query('select name, Job_Title__c,Description_Summary__c,Account__c,Post_Job__c,Job_Description_Detail__c,Account__r.name,Job_Function__c,ProgramType__c,Start_Date__c,Date_Closed__c, (SELECT Id, Name FROM Attachments) FROM FLAME_Job__c where Post_Job__c=true AND ProgramType__c INCLUDES (:contProgVersion) AND  RecordTypeId IN : recordTypeIdSet   Order By Name LIMIT :blockSize OFFSET :index'   );
      system.debug('tempContactList'+tempContactList);
            
        }
        catch (Exception e) {
            return null;
        }
        
   
        return tempContactList;
    } 
     
   
    
    /*-----------------------constructer-----------------------------------*/      
    Public Flame_Careerjobscontroller(){
        
        payBool = false;
        newApplicationId = '';
        //objUser = new User();
        jobs = new FLAME_Job__c();
        app= new FLAME_Job_Application__c();
        
        userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email,Program_Version__c from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
            
         tempapplicationList = new   List<FLAME_Job_Application__c>();
         tempapplicationList =[select name,id,FLAME_Job_Title__c,Account__c,Account__r.name,App_Status__c,CreatedDate from FLAME_Job_Application__c where contact__c=:userDetails.ContactId ]; 
            System.debug('tempapplicationList '+tempapplicationList); 
        }
        
        
     Public void Careerjobscontroller(){
     
       
       }
     
   
    /*  All jobs referal link*/
    public void filter() {
        List<FLAME_Job__c> Controller = new List<FLAME_Job__c>([select  Job_Title__c, Job_Description_Detail__c,Job_Function__c,Post_Job__c,Description_Summary__c from FLAME_Job__c where RecordType.developername='Placements'AND Post_Job__c =: true]); 
        
    }
    
  
    public void save(){
    
        FLAME_Job__c flamejob = new FLAME_Job__c();
        userDetails = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        System.debug('User Info :'+userDetails);        
        
        if(userDetails.ContactId!=null){
        userContact = [SELECT Id,Name FROM Contact WHERE Id=:userDetails.ContactId];                                    
        System.debug('User Contact Id  : '+ userDetails.ContactId);
        }
        flamejob = [select Job_Title__c,Job_Description_Detail__c,Area__c,Account__c,Post_Job__c,Job_Description_Summary__c,Job_Function__c from FLAME_Job__c  where Id = :rid];
        System.debug('flamejob'+rid);
       try {
        Id recordTypeId = Schema.SObjectType.FLAME_Job_Application__c.getRecordTypeInfosByName().get('Placements').getRecordTypeId();
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+ recordTypeId);
        FLAME_Job_Application__c application = new FLAME_Job_Application__c();
        List<FLAME_Job_Application__c> jopApplicationlist = new List<FLAME_Job_Application__c>();
        application.contact__c = userDetails.ContactId;
        application.RecordTypeId = recordTypeId;
        application.FLAME_Job_Title__c = flamejob.Job_Title__c;
        application.FLAME_Job__c= flamejob.Id;
        jopApplicationlist.add(application);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>ContactId'+ userDetails.ContactId);  
        system.debug('>>>>>>>>>>>>>>>>>>>>>>flamejob.ID'+ flamejob.ID);
        //List<FLAME_Job_Application__c> oldJobAppList = [Select id,Contact__r.id,FLAME_Job_Title__c,Contact__r.Name,FLAME_Job__c    from FLAME_Job_Application__c where  Contact__c=:ContactId and FLAME_Job__c =: flamejob.ID];
         List<FLAME_Job_Application__c> oldJobAppList = [Select id,Contact__r.id,FLAME_Job_Title__c,Contact__r.Name,FLAME_Job__c   from FLAME_Job_Application__c where  contact__c=: userDetails.ContactId and flame_job__c=: flamejob.ID];
        system.debug('>>>>>>>>>>>>>>>>>>>>>>dd'+ oldJobAppList.size());
        system.debug('>>>>>>>>>>>>>>>>>>>>>>'+ userDetails.ContactId);
        if(oldJobAppList.size() == 0 ){
            insert jopApplicationlist;
     //   payBool = true;
        paymentErrorMsg = 'Your application has been successfully submitted.';
      //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your application has been successfully submitted.'));  
        }else{
    //    payBool = true;
        paymentErrorMsg = 'You have already applied for the job, please check applied jobs section for status.';
       // ApexPages.addmessage (new ApexPages.Message(ApexPages.Severity.ERROR,'You have already applied for the job, please check applied jobs section for status.'));
                
        }
        
        
         } catch (Exception e) {
        ApexPages.addMessages(e);
             
        }

    }
     //*Colum button*/
        public PageReference Apply(){ 
        save();
        displayPopup = true;
       
        return null;
        }
  //applylink
  Public PageReference applylink(){
  FLAME_Job__c flamejob = new FLAME_Job__c();
        userDetails = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        System.debug('User Info :'+userDetails);        
        
        if(userDetails.ContactId!=null){
        userContact = [SELECT Id,Name FROM Contact WHERE Id=:userDetails.ContactId];                                    
        System.debug('User Contact Id  : '+ userDetails.ContactId);
        }
        flamejob = [select Job_Title__c,Job_Description_Detail__c,Area__c,Account__c,Post_Job__c,Description_Summary__c,Job_Function__c from FLAME_Job__c  where Id = :rid];
        System.debug('flamejob'+rid);
       try {
        Id recordTypeId = Schema.SObjectType.FLAME_Job_Application__c.getRecordTypeInfosByName().get('Placements').getRecordTypeId();
        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+ recordTypeId);
        FLAME_Job_Application__c application = new FLAME_Job_Application__c();
        List<FLAME_Job_Application__c> jopApplicationlist = new List<FLAME_Job_Application__c>();
        application.contact__c = userDetails.ContactId;
        application.RecordTypeId = recordTypeId;
        application.FLAME_Job_Title__c = flamejob.Job_Title__c;
        application.FLAME_Job__c= flamejob.Id;
        jopApplicationlist.add(application);
        system.debug('>>>>>>>>>>>>>>>>>>>>>>ContactId'+ userDetails.ContactId);  
        system.debug('>>>>>>>>>>>>>>>>>>>>>>flamejob.ID'+ flamejob.ID);
        //List<FLAME_Job_Application__c> oldJobAppList = [Select id,Contact__r.id,FLAME_Job_Title__c,Contact__r.Name,FLAME_Job__c    from FLAME_Job_Application__c where  Contact__c=:ContactId and FLAME_Job__c =: flamejob.ID];
         List<FLAME_Job_Application__c> oldJobAppList = [Select id,Contact__r.id,FLAME_Job_Title__c,Contact__r.Name,FLAME_Job__c   from FLAME_Job_Application__c where  contact__c=: userDetails.ContactId and flame_job__c=: flamejob.ID];
        system.debug('>>>>>>>>>>>>>>>>>>>>>>dd'+ oldJobAppList.size());
        system.debug('>>>>>>>>>>>>>>>>>>>>>>'+ userDetails.ContactId);
        if(oldJobAppList.size() == 0 ){
            insert jopApplicationlist;
      //  payBool = true;
        paymentErrorMsg = 'Your application has been successfully submitted.';
    //    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Your application has been successfully submitted.'));  
        }else{
     //   payBool = true;
        paymentErrorMsg = 'You have already applied for the job, please check applied jobs section for status.';
      //  ApexPages.addmessage (new ApexPages.Message(ApexPages.Severity.ERROR,'You have already applied for the job, please check applied jobs section for status.'));
                
        }
        
        
         } catch (Exception e) {
        ApexPages.addMessages(e);
             
        }

  displayPopup = true;
  
  return null;
  }
    
  
    public void ClosePopup() { 
     DisplayPopup = false;
    
        
    }
    
   
    
    
    /*To click the title link to geting action button*/  
    public PageReference getDetailpage() {
    
        FLAME_Job__c flamejob = new FLAME_Job__c();
        flamejob = [select Job_Title__c,Job_Description_Detail__c,Account__c,Area__c,Post_Job__c,Description_Summary__c,Job_Function__c from FLAME_Job__c  where Id = :rid];
        System.debug('flamejob'+rid);
        pagereference ApplyPage = new PageReference('/apex/Flame_CareerjobslinkPage'); 
        ApplyPage.getParameters().put('jobId',flamejob.id);
        ApplyPage.setRedirect(true);          
        return ApplyPage;                    
        
    }
    /*carrerjobs link page action*/      
    public List<FLAME_Job__c> linkList {get;set;}    
    Public Void jobtitlelink(){
        linkList = new List<FLAME_Job__c>();
        linkList =[Select id,Job_Title__c,Post_Job__c,Account__c,Description_Summary__c,Job_Function__c from FLAME_Job__c where Post_Job__c=:true AND id=:apexpages.currentpage().getparameters().get('jobId') limit 1];
        
        
    }  
    /* Headers*/  
    public PageReference backtojobs() {
        pagereference backtojobs = new PageReference('/apex/Flame_CareerjobsPage'); 
        return backtojobs;           
    }   
 /*----------------------------------------------------------------------------------------------------------*/
   
   
    
}