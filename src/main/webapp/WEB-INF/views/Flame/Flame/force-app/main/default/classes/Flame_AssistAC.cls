/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_AssistAC
* Created Date: 17/8/2018
* Description: to create ticket , check ticket status and dining menu
*******************************************************************/
public class Flame_AssistAC{    
    
    public User userDetails {get;set;}
    public Contact userContact {get;set;}    
    public Case objCase {get;set;}
    public Item__c objItem {get;set;}
    public Attachment objAttach {get;set;}
    public Map<String,List<Schema.FieldSetMember>> caseFieldSetMember {get;set;}
    public Map<String,String> recordTypeNameMap {get;set;}             
    public Map<String,String> commuintyAssistCSIdMap {get;set;} 
    public Map<String,String> commuintyAssistRTMap {get;set;}
    public Map<String,String> commuintyAssistCSFieldSetMap {get;set;}
    public Map<String,List<Dining_Menu__c>> diningMap {get;set;}
    public Map<String, Integer> moduleCountMap{get;set;}    
    public Contact objContact {get;set;}
    
    
    public List<Community_Assist__c> commuintyAssistCSList {get;set;}
    public List<String> weekList {get;set;}
    public List<Dining_Menu__c> diningmenuList {get;set;}
    public List<Item__c> itemList {get;set;}
    public List<Item__c> itemDetailsList {get;set;}
    public List<Case> caseList {get;set;} 
     public List<Contact> contactList {get; set;}
            
    
    public String selectedAssist {get;set;}
    public String caseRecordId;
    public String requestType {get;set;}
    public String fromDate {get;set;}
    public String toDate {get;set;}
    public String departureDate {get;set;}
    public String returnDate {get;set;}
    public String CaseNumber {get;set;}
    public String message {get;set;}
    public String messageType {get;set;}
    
    public Boolean bool {get;set;}
    public Boolean IsAssist {get;set;}
    public Boolean IsTicket {get;set;}
    public Boolean IsTicketDetials {get;set;}
    public Boolean IsGuest {get;set;}
    public Boolean IsCreated {get;set;}
    public Boolean IsDining {get;set;}
    public Boolean isMsgShow {get;set;}
    public Boolean isFirst {get;set;}
    Public Boolean casedesiable {get;set;}
    
    Public string  comments {get;set;}
    
    public Flame_AssistAC(){        
        
        userDetails = new User();
        userContact = new Contact();
        objCase = new Case();      
        objItem = new Item__c();
        objCase.Type = 'Problem';
        objAttach = new Attachment();
                
        recordTypeNameMap = new Map<String,String>();
        moduleCountMap = new Map<String, Integer>();   
        commuintyAssistRTMap = new Map<String,String>();
        commuintyAssistCSIdMap = new Map<String,String>();
        commuintyAssistCSFieldSetMap = new Map<String,String>();
        caseFieldSetMember = new Map<String,List<Schema.FieldSetMember>>();
        diningMap = new Map<String,List<Dining_Menu__c>>();
        
        caseList = new List<Case>();
        contactList = new List<contact>();
        weekList = new List<String>(); 
        itemList = new List<Item__c>();
        //Sharath
       
      
        //Sharath
        
        itemDetailsList = new List<Item__c>();
        diningmenuList = new List<Dining_Menu__c>();        
        commuintyAssistCSList = new List<Community_Assist__c>();        
        
        IsAssist = true;
        fromDate = '';
        toDate = '';
        departureDate ='';          
        returnDate = '';
        bool = false;
        isFirst = true;
        //-- default method call        
        System.debug('lable name'+System.Label.Academic_Services);
        init();
       
    }
    
    //-- default initalization method
    public void init(){                        
        
        //-- get map of record type for case object
        for(RecordType tempRT : [Select Id, Name, SObjectType from RecordType where SObjectType = 'Case']){            
            recordTypeNameMap.put(tempRT.Name,tempRT.Id);            
        }
        System.debug('recordTypeNameMap : '+recordTypeNameMap.size()+' : '+recordTypeNameMap);
        
        //-- get user details
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            userDetails = [Select id,Community_Contact_ID__c from User where id =: UserInfo.getUserId()];    
        }else{
            userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];             
        }
        System.debug('User Info :'+userDetails);        
        
        //-- get user contact details
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){            
            if(userDetails.Community_Contact_ID__c!=null){
                userContact = [Select id,Name,Email,Faculty__c,MobilePhone from Contact Where id=:userDetails.Community_Contact_ID__c];                                    
                System.debug('User Contact Id : '+userDetails.Community_Contact_ID__c);
            }
        }else{
            if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email,Faculty__c,MobilePhone from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
        }
        
         
        
        //-- get custom setting records for Assist type
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            commuintyAssistCSList = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c WHERE Tab_Type__c='Assist' order by name limit 100];        
        }else{
            String likeClause = '%' + Flame_CommunityUserInfo.profileName + '%';
            commuintyAssistCSList = [Select id,Name,Record_Type__c,Field_Set_API_Name__c from Community_Assist__c Where Tab_Type__c='Assist' AND Profile_Name__c like : likeClause order by name limit 100];        
        }
        System.debug('Community_Assist__c List : '+ commuintyAssistCSList);
        for(Community_Assist__c tempCA : commuintyAssistCSList){            
            commuintyAssistRTMap.put(tempCA.Id,tempCA.Record_Type__c);
            commuintyAssistCSIdMap.put(tempCA.Id,tempCA.Name);
            commuintyAssistCSFieldSetMap.put(tempCA.Id,tempCA.Field_Set_API_Name__c);           
        }
        System.debug('New Case : '+ objCase);  
        
        getCaseRecords(userContact.id);
        getSectionFieldMap();
        
        //-- Add default item into list for requisiton request
        itemList.add(new Item__c());
        
      
    }
    
    //-- mapping the field set to ticket status    
    public void getSectionFieldMap(){
        Map<String, Schema.FieldSet> fieldSetMap = SObjectType.Case.FieldSets.getMap();                
        Map<String, Schema.FieldSetMember> fieldSetMemberMap = new Map<String, Schema.FieldSetMember>();
        for(String str: fieldSetMap.keySet()){   
            List<Schema.FieldSetMember> lstFSMember = new List<Schema.FieldSetMember>();                                                 
            lstFSMember.addAll(fieldSetMap.get(str).getFields());
            caseFieldSetMember.put(fieldSetMap.get(str).getName().toLowerCase(),lstFSMember);                   
        }
        System.debug('Case Field Set : '+caseFieldSetMember.size() +caseFieldSetMember);        
    }
    
    
    
    //-- show selected case records command link method
    public void showCaseRecord(){
        IsCreated = false;
        caseRecordId = ApexPages.CurrentPage().getParameters().get('crcdId');
        System.debug('Case Record Id :'+caseRecordId);
        if(caseRecordId!=null){            
            System.debug('Case Record Id :'+caseRecordId);
            IsAssist = false;    
            IsTicketDetials = true;
            casedesiable = true;
            IsTicket = false;
            IsCreated = false;
            getCurrentCaseRecords(caseRecordId);
        }
    }
    
    //-- get current case records once ticket created
    public void getCurrentCaseRecords(String caseId){       
        caseList.clear();               
        IsTicket = false;  
        if(caseId!=null){
            IsAssist = false;
            fromDate = '';
            toDate = '';
            departureDate ='';          
            returnDate = '';
            IsTicketDetials = true;
            casedesiable = true;
            string caseQuery = 'select ';        
            for(string field : Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().keySet()){
                caseQuery += field+',';            
            }
            caseQuery = caseQuery.removeEnd(',') + ' , HLP_Location__r.Name,RecordType.Name from Case where Id = \''+ caseId +'\' LIMIT 1';    
            System.debug('Case Query : '+caseQuery);
            caseList = Database.query(caseQuery);
            System.debug('Case Records : '+caseList);  
            
            //-- get Item details for requisiton request
            itemDetailsList = [Select Id,S_No__c,Item_Description__c,Quantity__c,Units_Of_Measurement__c,BR_Title__c,BR_Author__c,BR_Publisher__c,BR_Year_Ed__c,BR_ISBN__c,BR_Required_Copies__c from Item__c Where Case__c =: caseId];
            
            for(Case c : caseList ){
                if(c.Attendance_Exemption_From_Date__c != null && c.Attendance_Exemption_To_Date__c != null){
                    fromDate = c.Attendance_Exemption_From_Date__c.format();
                    toDate = c.Attendance_Exemption_To_Date__c.format();
                }
                if(c.TRL_Departure_Date__c!=null){
                    departureDate = c.TRL_Departure_Date__c.format();
                }
                if(c.TRL_Return_Date__c!=null){
                    returnDate = c.TRL_Return_Date__c.format();
                }
            }      
        }
    }
    
    //-- Assist type select options   
    public List<SelectOption> getAssistType() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-- Select Assist Type --')); 
        
        for(Community_Assist__c tempCA : commuintyAssistCSList){
            options.add(new SelectOption(tempCA.Id,tempCA.Name));
        }       
        return options;
    }
    
    //-- onchagne action support method for services
    public void  actionSupportOCMethod(){      
        //-- hide assist service page and show ticket status
        isMsgShow = false;
        IsDining = false;
        IsAssist = true;    
        IsTicket = false;
        IsTicketDetials = false;
        casedesiable = false;
        IsCreated = false;
        //-- call case object set default method        
        System.debug(' Service Type : ' +selectedAssist+ ' : --> '+ commuintyAssistCSIdMap.get(selectedAssist)+' Record Type Id : ' + recordTypeNameMap.get(commuintyAssistRTMap.get(selectedAssist)));        
        if(selectedAssist!=null && recordTypeNameMap.get(commuintyAssistRTMap.get(selectedAssist))!=null ){
            defaultValuesOfAssistForm(selectedAssist,recordTypeNameMap.get(commuintyAssistRTMap.get(selectedAssist)));
        }
        System.debug('New Case : '+ objCase);
    }
    
    //-- show or hide Guest info section 
    public void guestInfoActionSupportMethod(){
        System.debug('Guest : '+IsGuest);
        IsGuest = true;
        System.debug('Guest : '+IsGuest);
    }
    
    //-- set default values for all assist form 
    public void defaultValuesOfAssistForm(String serviceType, String recordTypeId){
        objAttach = new Attachment();
        objCase = new Case();   
        objCase.Origin ='Community Portal'; 
        objCase.ContactId = userContact.id;
        
        if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Book_Requisition){
            System.debug('Book Requisition');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;   
            objCase.Type = 'Book Requisition';                
        }   
        
        else  if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Academic_Services){
            System.debug('Academic Services Page');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;
            objCase.HelpDesk_Team__c = 'Student Service';
            objCase.Type = 'Request';
            objCase.HLP_Assist_Type__c = 'Academic Services';
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Faculty_Services){
            System.debug('Faculty Services Page');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;
            objCase.HelpDesk_Team__c = 'Faculty Services';
            objCase.Type = 'Program Office - Faculty Services';
            objCase.HLP_Assist_Type__c = 'Faculty Services';
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Help_Desk_Services){
            System.debug('Help Desk Services Page');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;            
            objCase.Type = 'Help Desk';            
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Night_Out_Request){
            System.debug('Night Out Request Page');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;            
            objCase.Subject = 'Nightout Request';
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Request_Assistance){
            System.debug('Request & Assistance Page');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;   
            objCase.Type = 'Request';
            objCase.HLP_Assist_Type__c = 'Other';
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Requisition_Request){
            System.debug('Requisition Request');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;   
            objCase.Type = 'Requisition';            
        }
        else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Suggestions){
            System.debug('Suggestions');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.HLP_Assist_Type__c = 'Suggestions';
            objCase.RecordTypeId = recordTypeId;                        
        }else if(commuintyAssistCSIdMap.get(serviceType)==System.Label.Travel_Request){
            System.debug('Travel Request');
            objCase.Community_Assist_ID__c = serviceType;
            objCase.RecordTypeId = recordTypeId;                        
            objCase.Type = 'Travel'; 
            objCase.HelpDesk_Team__c='Travel';
        } 
        
    }
    
    //-- Add and remove Item from list methods
    public void addNewItemList(){       
        System.debug('item List--: '+itemList);
        itemList.add(new Item__c());
    }
    public void removeNewItemList(){
        Integer index = itemList.size();
        itemList.remove(index-1);
    }
    
    //-- check ticket status method    
    public pageReference checkTicketStatus(){
        //-- hide assist service page and show ticket status
        String newCaseId =  ApexPages.currentPage().getParameters().get('tid');
        System.debug('new Case Id : '+newCaseId);
        IsAssist = false;    
        IsCreated = false;
        IsDining = false;
        IsTicketDetials = false;
        casedesiable = false;
        IsTicket = true;
        selectedAssist = null;
        if(newCaseId!=null){            
            IsCreated = true;
            getCurrentCaseRecords(newCaseId);
        }else{
            getCaseRecords(userContact.id);
        }
      
        return null; 
        
    }
    Public boolean PayBool {get;set;}
Public string  paymentErrorMsg {get;set;}
  
  public boolean DisplayPopup {get; set;} 
    //  case re-open ticket by varma02-08-2019
   Public PageReference casereopenticket(){
         IsCreated = false;
        caseRecordId = ApexPages.CurrentPage().getParameters().get('crcdId');
        System.debug('Case Record Id :'+caseRecordId);
        if(caseRecordId!=null){            
            System.debug('Case Record Id :'+caseRecordId);
            IsAssist = false;    
            IsTicketDetials = true;
            casedesiable =false;
            IsTicket = false;
            IsCreated = true;
            getCurrentCaseRecords(caseRecordId);
        }
    if(caselist!=null){ 
      
    case objCase = new Case();
    objCase.Id = caseList[0].id;
    objCase.Origin = 'Community Portal';
    objCase.Reopen_Comment__c = comments;
    objCase.Status = 'Re-Opened';
    upsert objCase;
    DisplayPopup = true;       
        }
        
   return null;
   }
  //ticket states page popup
  public PageReference ClosePopup() {       
        DisplayPopup = false;  
  PageReference pageref = new PageReference('/apex/Flame_TicketStatus');
  pageref.setredirect(true);
  return pageref;    
    }
    
   
     
//ticket states page popup error message
    public String searchError;
    public String getSearchError() {
    IsCreated = true;
    searchError = 'Thank you, request has been Re-Submited.';
    return searchError; //return searchError value
    } 
    
    //Book request states page popup
   public boolean DisplayPopup2 {get; set;}
  public PageReference ClosePopup2() {       
  DisplayPopup2 = false;  
  return null;    
    }
    
  
   
 //ticket states page button hide and desiable   
  public void displayButton(){
  if ( objCase.Status =='Resolved')
     casedesiable=True;
     else
    casedesiable=False;

  }  
    
    
      //-- fetch user case records
    public void getCaseRecords(String contactId){
        caseList.clear();               
        if(contactId!=null){
            string caseQuery = 'select ';        
            for(string field : Schema.getGlobalDescribe().get('Case').getDescribe().fields.getMap().keySet()){
                caseQuery += field+',';            
            }
            if(Flame_CommunityUserInfo.profileName=='System Administrator'){
                caseQuery = caseQuery.removeEnd(',') + ',HLP_Location__r.Name,RecordType.Name from Case where Community_Assist_ID__c!=null ORDER BY Casenumber desc ';    
            }else{
                caseQuery = caseQuery.removeEnd(',') + ',HLP_Location__r.Name,RecordType.Name from Case where ContactId = \''+ contactId +'\'  AND CreatedDate = LAST_N_DAYS : 180 AND Community_Assist_ID__c!=null AND CreatedById=\''+UserInfo.getUserID()+'\'  ORDER BY CreatedDate ASC  LIMIT 1000';    
            }            
            System.debug('Case Query : '+caseQuery);
            caseList = Database.query(caseQuery);
            System.debug('Case Records : '+caseList);            
        }
    }
    
    
    //-- show dining menu
    public pageReference diningMenuStatus(){        
        IsAssist = false;    
        IsCreated = false;
        IsDining = true;
        IsTicketDetials = false;
        casedesiable = false;
        selectedAssist = null;
        IsTicket = false;    
        diningMap = new Map<String,List<Dining_Menu__c>>();
        moduleCountMap = new Map<String, Integer>();
        List<Dining_Menu__c> menuList = new List<Dining_Menu__c>();
        Datetime dt = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek=dt.format('EEEE');
        System.debug('Day : ' + dayOfWeek);
        Date d;
        diningmenuList = [SELECT Id,Name,BreakFast__c,Date__c,Dinner__c,Evening_Snacks__c,Lunch__c,Comment__c FROM Dining_Menu__c WHERE Date__c = THIS_WEEK AND Name != 'Sunday' Order By Date__c];
        system.debug('diningmenuList '+diningmenuList );
        if(diningmenuList.size() > 0){
            bool = true;
            for(Dining_Menu__c  DM : diningmenuList){                   
                if(!weekList.contains(DM.Name)){
                    weekList.add(DM.Name);
                }
                if(DM.Name == 'Saturday'){
                    d = DM.Date__c;
                }
                if(diningMap.containskey(DM.Name)){       
                    menuList = diningMap.get(DM.Name);
                    menuList.add(DM);
                    diningMap.put(DM.Name,menuList);
                    modulecountMap.put(DM.Name, menuList.size());
                }else{                 
                    menuList = new List<Dining_Menu__c> ();         
                    menuList.add(DM);
                    diningMap.put(DM.Name,menuList);
                    modulecountMap.put(DM.Name, menuList.size());
                }          
            }
        }
        system.debug('d--> NFORE'+d);
        if(d != null){
            system.debug('d AFTER-->'+d);
            bool = true;
            List<Dining_Menu__c> diningmenuList1 = [SELECT Id,Name,BreakFast__c,Date__c,Dinner__c,Evening_Snacks__c,Lunch__c,Comment__c FROM Dining_Menu__c WHERE Name = 'Sunday' AND Date__c >:d AND Date__c <: d.addDays(2) Order By Date__c DESC];
            system.debug('diningmenuList1'+diningmenuList1);
            for(Dining_Menu__c  DM : diningmenuList1){  
                if(!weekList.contains(DM.Name)){
                    weekList.add(DM.Name);
                }       
                if(diningMap.containskey(DM.Name)){       
                    menuList = diningMap.get(DM.Name);
                    menuList.add(DM);
                    diningMap.put(DM.Name,menuList);
                    modulecountMap.put(DM.Name, menuList.size());
                }else{                 
                    menuList = new List<Dining_Menu__c> ();         
                    menuList.add(DM);
                    diningMap.put(DM.Name,menuList);
                    modulecountMap.put(DM.Name, menuList.size());
                }          
            }
        }
        system.debug('diningMap'+diningMap);
        return null;
    }
    
   Public case caseemail {get;set;} 
   Public string paymentError{get;set;}
    //-- create new case
    public pageReference saveCase(){
        System.debug('Save Mehtod start');        
        try{
            //-- create new case            
            if(selectedAssist!=null && commuintyAssistCSIdMap.get(selectedAssist)==System.Label.Travel_Request){
                System.debug('Travel request form');
                if(objCase.TRL_Requisition_For__c!='Guest'){
                    objCase.TRL_Traveler_Name__c=null;
                    objCase.TRL_Traveler_Mobile__c=null;
                    objCase.TRL_Traveler_Email__c=null;
                }
            } 
                   
            insert objCase;
             system.debug('objCase'+objCase);
             if(objCase.Type =='Book Requisition'){
             if(objCase != null){
            caseemail =[SELECT Id, contactId, contact.Name, CaseNumber,CreatedDate,Contact.Faculty__c,BR_TYPE__c,contact.MobilePhone,BR_COURSE__c,contact.Email,
            BR_Number_of_Students__c FROM Case where id=:objCase.id AND ContactId=:userDetails.ContactId limit 1];
            system.debug('caseemail'+caseemail);
             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        PageReference pdf;
       // pdf  = new PageReference('https://flameu.secure.force.com/Payment_L_Email_Reciept');
        pdf  = new PageReference('/apex/SendEmailCaseItems');
        pdf.getParameters().put('Id', objCase.id);
        system.debug('id'+objCase.id);
        pdf.setRedirect(true);
        Blob b;
        if(!test.isRunningTest()){
        b = pdf.getContentaspdf();
        }else{
        b =blob.valueOf('TestString');
        }
             
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName( caseemail.contact.name +'_ '+date.today().format() +'.pdf');
        efa.setBody(b);
        String body = 'Dear ' + caseemail.contact.Name +' ,<BR><br> ';
        body += 'Please find attached your Receipt.<br><br>';
        body += 'Sincerely,<br>';
        body += 'FLAME University '+ (caseemail.CaseNumber);
        email.setHtmlBody(body);
        String[] ccAddresses = new String[] {'kartheeka.varma@flame.edu.in'};
        Email.setCCAddresses(ccAddresses);
        email.setSenderDisplayName('FLAME University Receipt');
        
        If (caseemail.contact.Email != null )
        {
        String[] toAddresses = new String[] {caseemail.contact.Email};
        email.setToAddresses(toAddresses);
        }
        
        If ( caseemail.contact.Email != null)
        {
        String[] toAddresses = new String[] {caseemail.contact.Email};
        email.setToAddresses(toAddresses);
        }
        
        
        email.setSubject('FLAME Case Receipt'); 
        email.setPlainTextBody(body);
        email.setTargetObjectId(userDetails.ContactId);
        system.debug('email'+email);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); // Sends the email
        try{
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        paymentError = 'Email successfully sent to registered email addresse(s).';
        }catch(Exception ex){
        system.debug('111'+ex.getMessage());
        ex.getMessage();
        paymentError = 'We regret that email could not be sent due to inaccurate or blank email information in the system, please email techsupport@flame.edu.in, our team will promptly help you out in getting the receipt.';
        
        }
            
             }
             }
          //   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank you Your Request has been submitted.'));
            
            //-- create items records
            if(selectedAssist!=null && commuintyAssistCSIdMap.get(selectedAssist)==System.Label.Requisition_Request){
                if(itemList.size()>0){
                    for(Item__c item : itemList){
                        item.Case__c = objCase.Id;  
                    }
                    
                    insert itemList;
                  system.debug('itemList'+itemList);
                }                
            }
          //-- create items records
            if(selectedAssist!=null && commuintyAssistCSIdMap.get(selectedAssist)==System.Label.Book_Requisition){
                if(itemList.size()>0){
                    for(Item__c item : itemList){
                        item.Case__c = objCase.Id;  
                    }
                    
                    insert itemList;
                    system.debug('itemList'+itemList);
                    
                }                
            }
           // displayPopUp = true;
  //-------- for attachment upload ----------            
            System.debug('Attach body : '+objAttach.Body);
            if(objCase.Id!=null && objAttach.Body!=null){             
                objAttach.ParentId = objCase.Id;
                insert objAttach;
                objAttach = new Attachment();
            }
                
            
            CaseNumber = objCase.CaseNumber;
            System.debug('New Case : '+ objCase);
            IsCreated = true;
            IsTicketDetials = true;
            IsAssist = false;    
            IsDining = false;           
            IsTicket = false;
            selectedAssist = null;            
            
            //-- show case details
            if(objCase.Id!=null){                                
                PageReference pr = Page.Flame_TicketStatus;
                pr.getParameters().put('tid',objCase.Id);
                return pr;
            } 
            isMsgShow = false;
            objCase = new Case();
            objAttach = new Attachment();
            
        }catch(Exception ex){
            objAttach = new Attachment();
            isMsgShow = true;
            message = ex.getMessage();
            messageType = 'error';
            System.debug('Case Error : '+ ex.getMessage());
        }
        return null;
    }
}