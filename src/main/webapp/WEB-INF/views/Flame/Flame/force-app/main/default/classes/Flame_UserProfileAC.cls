/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_UserProfileAC
* Created Date: 15/9/2018
* Description: to show current user information
*******************************************************************/
global with sharing class Flame_UserProfileAC {
    
    public String userName {get;set;}    
    public String profileName {get;set;}    
    public Contact objContact {get;set;}
    public String contactId {get;set;}
    public String peopleId {get;set;}
    public String peopleProfile {get;set;}
    public ContentVersion file{get; set;}
    public List<ContentVersion> contentVersionList {get;set;}
    public List<ContentDocument> contentDocumentList {get;set;}
    public List<Contact> updateContact {get;set;}
    public String publicURL {get;set;}
    public string value { get; set;}
    public Boolean inputMode{get;set;}
    public Boolean outputMode{get;set;}
    public boolean DisplayPopup {get; set;}
    public String disclaimer {get;set;}
    public String selectedVal{get;set;}
  
    // 
    public Flame_UserProfileAC(){        
        userName = Flame_CommunityUserInfo.userName;
        profileName = Flame_CommunityUserInfo.profileName;
        peopleId = ApexPages.currentPage().getParameters().get('pid');                
        System.debug('People Id :'+peopleId);
        contactId='';        
        file= new ContentVersion();
        contentVersionList = new List<ContentVersion>();
        contentDocumentList = new List<ContentDocument>();
        publicURL='';
        
         List<SelectOption> items = new List<SelectOption>(); 
          List<Schema.Picklistentry> fieldResult = Contact.Blood_Group__c.getDescribe().getPicklistValues();
          items.add(new SelectOption('', '-- None -- '));
          for(Schema.PicklistEntry f : fieldResult) {
              items.add(new SelectOption(f.getValue(), f.getLabel()));
          }
        //-- get user details
        User objUser = new User();
        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            objUser = [Select id,Community_Contact_ID__c from User where id =: UserInfo.getUserId()]; 
            contactId = objUser.Community_Contact_ID__c;
        }else{
            objUser = [Select id,contactid from User where id =: UserInfo.getUserId()];             
            contactId = objUser.ContactId;
        }
        System.debug('User Info :'+objUser + ' Contact id : '+contactId + ' People Id :'+peopleId);        
        
        //-- call default method
        init();
         inputMode = false;
         outputMode = true;
    }
    
    public List<Selectoption> getItemsList(){
          List<SelectOption> options = new List<SelectOption>(); 
          List<Schema.Picklistentry> fieldResult = Contact.Blood_Group__c.getDescribe().getPicklistValues();
          options.add(new SelectOption('', '-- None -- '));
          for(Schema.PicklistEntry f : fieldResult) {
              options.add(new SelectOption(f.getValue(), f.getLabel()));
          }
          return options;
        }
    
    //-- default initialization method
    public void init(){
        if(peopleId!=null){
            System.debug('People Contact Search ');
            objContact = [SELECT Id, Peer_Mentor__r.name, Blood_Group__c,Faculty_Advisor__r.name, House__c, LastName, FirstName, Name, MobilePhone,Phone, Email, Birthdate, Gender__c,Designation_Name__c, Department__c, Faculty__c, Office_Building__r.Name, Office_Room__c,CVUE_Student_Number__c,DOB__c,Primary_Contact_Type__c,Current_Company__c,Current_Designation__c,LinkedIn_profile_URL__c,Industry__c,Date_of_Birth__c FROM Contact WHERE Id =: peopleId];                        
            findProfileImage(peopleId);
        }else{
            System.debug('User Contact Search');
            objContact = [SELECT Id, Peer_Mentor__r.name,Blood_Group__c,Faculty_Advisor__r.name,House__c, LastName, FirstName, Name, MobilePhone,Phone, Email, Birthdate, Gender__c, Designation_Name__c, Department__c, Faculty__c, Office_Building__r.Name, Office_Room__c,CVUE_Student_Number__c,DOB__c,Contact_Address_Line_1__c,Contact_Address_Line_2__c,Contact_City__c,Contact_State__c,Contact_Country__c ,Contact_Zip_Code__c,Date_of_Joining__c,Employee_Id__c,Primary_Contact_Type__c,Current_Company__c,Current_Designation__c, LinkedIn_profile_URL__c,Industry__c,Date_of_Birth__c FROM Contact WHERE Id =: contactId]; 
            findProfileImage(contactId);
        }
        System.debug('Contact Details : '+objContact);
        selectedVal = objContact.Blood_Group__c;
        //-- get base URL for user photograph       
        if(contentVersionList.size()>0){
            String baseURL = System.URL.getSalesforceBaseURL().toExternalForm();                                
            publicURL = baseURL.replace('visual','content');
            publicURL+='/sfc/servlet.shepherd/version/download/'+contentVersionList[0].id;          
        }else{
            publicURL='';
        }
        
        Profile_Photo_Disclaimer__mdt disclaimerContent = [Select Disclaimer__c from Profile_Photo_Disclaimer__mdt];
        
        disclaimer = disclaimerContent.Disclaimer__c;
        
        System.debug('publicURL:'+publicURL);               
    }
    
    //-- get profile image url  
    public void findProfileImage(String conId){
        System.debug('Profile method start : '+conId);
        Set<String> cdIDSet = new Set<String>();
        for(ContentDocumentLink cdl : [SELECT ContentDocumentId,Id,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: conId]){
            cdIDSet.add(cdl.ContentDocumentId);
            System.debug('ContentDocumentLink : '+cdl);
        }
        System.debug('cdIDSet : '+cdIDSet);
        contentVersionList = [SELECT id, Title ,ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN: cdIDSet order by CreatedDate desc limit 1];
        System.debug('contentVersionList : '+contentVersionList);
        if(contentVersionList.size()>0){
            contentDocumentList = [SELECT id FROM ContentDocument WHERE Id =: contentVersionList[0].ContentDocumentId];
        }
        if(contentVersionList.size()>0){
            String baseURL = System.URL.getSalesforceBaseURL().toExternalForm();                                
            publicURL = baseURL.replace('visual','content');
            publicURL+='/sfc/servlet.shepherd/version/download/'+contentVersionList[0].id;          
        }else{
            publicURL='';
        }
        System.debug('publicURL:'+publicURL);
    }
    
    //-- save user profile image 
    
    public PageReference uploadProfileImage(){
        //try{
         System.debug('ContentVersion : '+file.versionData);
         System.debug('contactId : '+contactId);
         System.debug('contentDocumentSize : '+contentDocumentList.size());
            if(file.versionData!=null && contactId!=null ){
                
                if(contentDocumentList.size()>0){
                    delete contentDocumentList;
                }
                //-- delete old photograph                              
                file.Title = 'Profie Image ewrwerewe';
                insert file; 
                System.debug('ContentVersion File Id : '+file.id);
                List<ContentVersion> tempContentVersionList= [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: file.Id];                
                System.debug('ContentVersionList : '+tempContentVersionList);
                
                if(tempContentVersionList.size()>0)   {
                    ContentDocumentLink objCDL = new ContentDocumentLink(); 
                    objCDL.ContentDocumentId = tempContentVersionList[0].ContentDocumentId;
                    objCDL.LinkedEntityId = contactId;
                    objCDL.ShareType = 'I';
                    objCDL.Visibility = 'AllUsers';
                    insert objCDL;      
                    System.debug('ContentDocumentLink ID :'+objCDL);
                }
                Contact tempContact = [SELECT id,Photograph__c FROM Contact WHERE Id =:contactId];
                tempContact.Photograph__c ='Uploaded';
                update tempContact;
                file= new ContentVersion();
            }
            init();
            PageReference pg = new PageReference('/apex/Flame_UserProfile');
            return pg;
        //}catch(Exception ex){
            //file= new ContentVersion();
            //System.debug('Exception :'+ ex.getMessage());
        //}
        //return null;
    }
    
    
    //-- save user crop profile image 
     @RemoteAction
     public static Id saveImage(String name, String data, String contactId) {
        
        /*Datetime systemDate = System.now();
        String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        List<ContentDocumentLink> contentDocumentList = [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: contactId order by ContentDocument.CreatedDate desc limit 1];
        system.debug('contentDocumentList size:'+contentDocumentList.size());
		if(contentDocumentList.size()>0){
            For(ContentDocumentLink contd :contentDocumentList){
                ContentVersion contentVersionList1 = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE ContentDocumentId =: contd.ContentDocumentId limit 1];
                system.debug('contentVersionList1:'+contentVersionList1);
                String newName = contentVersionList1.Title;
               	contentVersionList1.Title = newName+'_Old_'+newTimeDate;
                System.debug('Old File Name::'+newName+'_Old_'+newTimeDate);
                Update contentVersionList1;
                system.debug('Update contentVersionList1:'+contentVersionList1);
            }
        } */
         
        System.debug('contactId : '+contactId);
       	ContentVersion objCntVersion = new ContentVersion();
       	objCntVersion.PathOnClient =  '/' + name;
       	objCntVersion.Title = name;
       	objCntVersion.VersionData = EncodingUtil.base64Decode(data);
       	Insert objCntVersion;
        Id cdId; 
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where id =: objCntVersion.Id];
        for(ContentVersion cv : cvList){
            //cdId = cv.ContentDocumentId;
            String newName = cv.Title;
            System.debug('newName'+cv.Title);
            Integer intIndex = newName.indexOf('.');
            Integer lasCharLen = newName.length()-intIndex;
            System.debug('New length'+newName.substring(0,newName.length()-lasCharLen));
            cv.Title = newName.substring(0,newName.length()-lasCharLen);
            Update cv;
        }
         
        System.debug('objCntVersion : '+objCntVersion);
        System.debug('objCntVersion : '+objCntVersion.Id);
        List<ContentVersion> contentVersionList = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE Id =: objCntVersion.Id];
        List<ContentDocumentLink> contentDocumentLinkToInsert = new  List<ContentDocumentLink>();
        system.debug('contentVersionList:'+contentVersionList);
        
        for(ContentVersion conv : contentVersionList)
        {
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = contactId;
            conDocLink.ContentDocumentId = conv.ContentDocumentId;
            conDocLink.shareType = 'V';
            conDocLink.Visibility='AllUsers';
            contentDocumentLinkToInsert.add(conDocLink);
        }
        system.debug('contentDocumentLinkToInsert:'+contentDocumentLinkToInsert);
        list<Database.saveResult> res1 = Database.insert(contentDocumentLinkToInsert);
        for (Database.SaveResult saveResult : res1) {
            if(saveResult.isSuccess()) {
               
            }
        } 
        system.debug('res1:'+res1);
        return objCntVersion.Id;
    }
    

    
    
    public PageReference enterInputMode() {
        inputMode = true;
        outputMode = false;
        return null;
    }

    public PageReference exitInputMode() {
        inputMode = false;
        outputMode = true;
        update objContact;
        return null;
    }
    
    public void ClosePopup() {       
        DisplayPopup = false;   
    }
 
    public void ShowPopup() {       
        DisplayPopup = true;   
    }
    
    //Update Blood Group Of Community User
    public void fillProjectTasks() {
        Contact tempContact = [SELECT id,Blood_Group__c FROM Contact WHERE Id =:contactId];
        tempContact.Blood_Group__c = selectedVal;
        update tempContact;
    }
  
}