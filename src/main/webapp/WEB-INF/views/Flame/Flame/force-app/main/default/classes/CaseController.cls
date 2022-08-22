public class CaseController{
    
    public Case objCase{get;set;}
    public List<Item__c> itemList{get;set;}
    public List<Item__c> createItemList{get;set;}
    public List<WrapperClass> listWrapper{get;set;}
    public List<WrapperClass> objOSItemWrapperList{get;set;}
    //public Boolean allBool{get;set;}
    public String retUrl{get;set;}
    public RecordType objRecord{get;set;}
    public List<Case> caseList{get;set;}
    public Boolean helpCheck{get;set;}
    public Boolean travelCheck{get;set;}
    public Boolean reqCheck{get;set;}
    public Id recordId{get;set;}
    public Id idUser{get;set;}
    public Id CommunityPortalId{get;set;}
    public String strSelected  {get;set;}
    public List<SelectOption> options {get;set;}
    public Attachment objAttachment {get;set;}
    
    public CaseController(ApexPages.StandardController controller){
        try{
            objAttachment = new Attachment();
            listWrapper=new List<WrapperClass>();
            objOSItemWrapperList = new List<WrapperClass>();
            objCase = new Case();
            itemList = new List<Item__c>();
            createItemList = new List<Item__c>();
            caseList = new List<Case>();
            helpCheck = false;
            travelCheck = false;
            reqCheck = false;
            strSelected = '';
            
            // To show picklist from records of Location object
            options = new List<SelectOption>();
            for(v1Location__c obj :[SELECT Id, Name FROM v1Location__c] )//instead of BU_Project__c.Id pass actual id
            {
                options.add(new SelectOption(obj.Id,obj.Name));
            }
            Id recTypeId = ApexPages.currentPage().getParameters().get('RecordType');
            
            // Getting record id to show page in edit mode
            recordId = ApexPages.currentPage().getParameters().get('id');
            
            // To get contact of the current user logged in
            CommunityPortalId  = getContactIDfromUser();
            
            // To assign record type to the new case created or to display case in edit mode if record id exist
            if(recTypeId != null ){
                objCase.RecordTypeId = recTypeId;
                objRecord = [select id, name from RecordType where id =: recTypeId];
                
            }else if(recordId != null){                
                objCase = [select id,RQN_Message__c , CaseNumber, RecordType.Name, Status, Subject, Message__c, HLP_Category__c, TRL_Departure_Pickup_Time__c,
                           TRL_Department__c, TRL_Return_Pickup_Time__c, TRL_Departure_Date__c, TRL_Departure_Pickup_Location__c, HLP_Floor__c, 
                           HLP_Location__c, HLP_Mobile_No__c, TRL_Mode_Of_Travel__c, RQN_Purpose__c , TRL_Purpose_Of_The_Visit__c ,
                           RQN_Requesting_On_Behalf_Of__c , RQN_Requisition_Date__c , TRL_Requisition_For__c , RQN_Requisition_Type__c , 
                           TRL_Return_Date__c , TRL_Return_Pickup_Location__c , HLP_Room__c , HLP_Sub_Category__c , TRL_Traveler_Email__c ,
                           TRL_Traveler_Mobile__c , TRL_Traveler_Name__c , TRL_Travel_From__c , TRL_Travel_To__c ,
                           RQN_Your_Department__c from Case where Id =: recordId];
                itemList = [select id, S_No__c, Item_Description__c, Quantity__c, Units_Of_Measurement__c, Unit_Price__c, 
                            Value__c, In_Stock_Items__c, Items_Issued__c, Remarks__c from Item__c where case__c =: recordId];
                
                // To rendered case List according to record type
                if(objCase.RecordType.Name == 'Help Desk' ){
                    helpCheck = true;
                }else if(objCase.RecordType.Name == 'Travel'){
                    travelCheck = true;
                }else if(objCase.RecordType.Name == 'Requisition'){
                    reqCheck = true;
                }
                for(Item__c objItemOne : itemList){
                    objOSItemWrapperList.add(new WrapperClass(objItemOne));
                }
            }
            
            // To display case records according to record types associated with current logged in user 
            caseList = [select id, CaseNumber, RQN_Message__c, Status, Subject, Message__c, HLP_Category__c, TRL_Department__c, 
                        TRL_Departure_Date__c, TRL_Departure_Pickup_Time__c, TRL_Departure_Pickup_Location__c,
                        HLP_Floor__c, HLP_Location__c, TRL_Return_Pickup_Time__c, HLP_Mobile_No__c, TRL_Mode_Of_Travel__c,
                        RQN_Purpose__c , TRL_Purpose_Of_The_Visit__c , RQN_Requesting_On_Behalf_Of__c , RQN_Requisition_Date__c , 
                        TRL_Requisition_For__c , RQN_Requisition_Type__c , TRL_Return_Date__c , TRL_Return_Pickup_Location__c , 
                        HLP_Room__c , HLP_Sub_Category__c , TRL_Traveler_Email__c , TRL_Traveler_Mobile__c , TRL_Traveler_Name__c , 
                        TRL_Travel_From__c , TRL_Travel_To__c , RQN_Your_Department__c from Case where RecordTypeId =: recTypeId AND ContactId =:CommunityPortalId];
            System.debug('caseList-->> '+caseList);
            System.debug('objCase -->> '+objCase );
            System.debug('itemList -->> '+itemList );                        
            System.debug('Record Type ----->>>>>'+objCase.RecordTypeId);
            //System.debug('Record Type ----->>>>>'+objCase.RecordType.Name);
            retUrl = ApexPages.currentPage().getParameters().get('retURL');
            // To display single row for item insertion in requisition form
            for(integer i=0; i<1 ; i++){
                Item__c objItem = new Item__c();
                itemList.add(objItem);
                objOSItemWrapperList.add(new WrapperClass(objItem));
            }
        }catch(Exception e){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage() + e.getLineNumber()));
        }
    }
    
    // Method to add row for Item detail section in requisition form
    public void addRow(){
        Item__c objItem = new Item__c();
        itemList.add(objItem);
        objOSItemWrapperList.add(new WrapperClass(objItem));
        System.debug('objOSItemWrapperList=-->>'+objOSItemWrapperList);
    }
    
    // Method to save case record and its items details if associated
    public PageReference saveItem(){
    //  Integer a = Integer.valueof('A');
       try{
            if(CommunityPortalId!=NULL){
                objCase.ContactId = CommunityPortalId;           
            }
            
            // To assign loaction selected to the case record
            IF(strSelected !='' ){
                objCase.HLP_Location__c = strSelected ;
            }
            System.debug('Case object : ---->>>>'+objCase);
            insert objCase;
            /*if(objRecord.Name == 'Help Desk'){
                objAttachment.ParentId = objCase.id;
                insert objAttachment;
            }*/
                        
            Integer serialNo = 1;
            for(Item__c objItem : itemList){
                if(objItem.Item_Description__c != null && objItem.Quantity__c > 0){
                    objItem.S_No__c = String.valueOf(serialNo);
                    objItem.Case__c = objCase.Id;
                }
                serialNo++; 
            }
            System.debug('Items List---->'+itemList);
            insert itemList;
        }catch (Exception e) {
            ApexPages.addMessages(e);
        }
        
        // To redirect page according to portal site or org.
        String baseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(baseURL.contains('.salesforce.com/')){
            PageReference objPageRef = new PageReference('/'+objCase.Id);
            objPageRef.setRedirect(true);
            return objPageRef;
            //return null;
        }else{
            /*PageReference objPageRef = new PageReference('/CommunityHome');
            objPageRef.setRedirect(true);*/
            return null;
        }
    }
    
    // Method to cancel forms
    public PageReference doCancel(){
        PageReference objPageRef = new PageReference('/CommunityHome');
        objPageRef.setRedirect(true);
        return objPageRef;
    }
    
    // Method to go back on button click
    public PageReference backForm(){
        //PageReference objPageRef = new PageReference('/500/o');   
        //PageReference objPageRef = new PageReference('/setup/ui/recordtypeselect.jsp?ent=Case&retURL=%2F500%2Fo&save_new_url=%2F500%2Fe%3FretURL%3D%252F500%252Fo');
        PageReference objPageRef = new PageReference('/CommunityHome');
        objPageRef.setRedirect(true);
        return objPageRef;
    }
    
    public void selectAll(){}
    
    // Wrapper class to work on item details in requisition form
    public class WrapperClass {
        public Boolean Checked{get;set;}
        public Item__c rec{get;set;}
        
        public WrapperClass(Item__c rec) {
            this.Checked = false;
            this.rec=rec;
        }
    }
    
    // Method to delete items selected in item details section
    public void del(){
        List<Item__c> listRecForDel=new List<Item__c>();
        List<WrapperClass> temp=new List<WrapperClass>();
        for(WrapperClass item : objOSItemWrapperList)
        {
            System.debug('item-->>'+item);
            if(item.checked){
                listRecForDel.add(item.rec);
            }
            else{
                temp.add(item);
            }
        }
        if(listRecForDel.size()>0){
            //delete listRecForDel;
            objOSItemWrapperList.clear();
            objOSItemWrapperList = temp;
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Select atleast one record to delete'));
        }
    }
    
    // To rendered Help desk section
    public void helpOn(){
        helpCheck = true;
    }
    
    // To rendered Travel section
    public void travelOn(){
        travelCheck = true;
    }
    
    // To rendered Requisition section
    public void requisitionOn(){
        reqCheck = true;
    }
    
    public Community_Resource__c getBannerTextLabel() {
        return null;
    }
    
    public static Boolean getHasTwitterFeed() {
        Community_Settings__c cs = Community_Settings__c.getInstance();
        return String.isNotBlank(cs.Twitter_Handle__c) && String.isNotBlank(cs.Twitter_Data_Widget_ID__c);
    }
    
    public static String getTwitterHandle() {
        return null;
    }
    
    public static String getTwitterDataWidgetId() {
        return Community_Settings__c.getInstance().Twitter_Data_Widget_ID__c;
    }
    
    // Getting Contact of current user
    public Id getContactIDfromUser(){
        idUser = UserInfo.getUserId();
        List<User> lstUser = [Select u.Id,u.ContactId from User u where u.Id = :idUser];
        if( lstUser != null && lstUser.size() > 0 ){
            System.debug('lstUser[0].ContactId::' + lstUser[0].ContactId);
            return lstUser[0].ContactId;
        }else{
            return null;
        }
    }
    
   
    
}