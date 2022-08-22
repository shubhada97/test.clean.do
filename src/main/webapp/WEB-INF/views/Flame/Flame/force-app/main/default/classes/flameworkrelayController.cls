public class flameworkrelayController {
 
    public List<String> categoryList {get;set;}
    public List<FLAMEWorkRelayFormsList__c> WorkRelayList {get;set;}
    public List<FLAMEWorkRelayFormsList__c> customSettingCategoryList {get;set;}
    public List<FLAMEWorkRelayFormsList__c> customSettingSubCategoryList {get;set;}
    public String rString {get;set;}
    public String getSubCategory {get;set;}
    public String Header {get;set;}
    public String Header2 {get;set;}
    public boolean bool {get;set;}
    public user objUser {get;set;}
    public List<String> subCategoryList {get;set;}    
    public String roleString {get;set;}
    Public List<Document>documentList {get;set;}
    Public Resource__c resource {get;set;}
    Public string rid {get;set;}
    public String OpenPageURL {get; set;}
     public Boolean shouldRedirect {public get; private set;}
    public flameworkrelayController(){
         OpenPageURL = '' ;
         string jobId = apexpages.currentpage().getparameters().get('rId');
         system.debug('jobId'+jobId);
        FLAMEWorkRelayFormsList__c resource= new FLAMEWorkRelayFormsList__c();
        documentList = New List<Document>();
        categoryList = new List<String>();
        rString = '';
        WorkRelayList = new List<FLAMEWorkRelayFormsList__c>();
        getSubCategory = '';
        Header = '';
        Header2 = '';
        rid='';
        bool = false;
        roleString = '';
        objUser = [SELECT ID,ContactID,Contact.Name,Profile.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        roleString = objUser.Profile.Name;
        List<FLAMEWorkRelayFormsList__c> customSettingCategoryList1 = new List<FLAMEWorkRelayFormsList__c>();
        List<FLAMEWorkRelayFormsList__c> customSettingSubCategoryList2 = new List<FLAMEWorkRelayFormsList__c>();
        customSettingCategoryList = new List<FLAMEWorkRelayFormsList__c>();
        customSettingSubCategoryList = new List<FLAMEWorkRelayFormsList__c>();
        customSettingCategoryList1 = [Select id,Name,RecordType__c,Category__c,TabType__c,ProfileName__c,WorkRelayFromID__c,FormDescription__c,FieldSetAPIName__c,Order__c from FLAMEWorkRelayFormsList__c  WHERE TabType__c  = 'WorkRelay' AND Category__c = null AND ProfileName__c!= null order by Order__c ASC limit 100];  
      
        for(FLAMEWorkRelayFormsList__c objCA : customSettingCategoryList1 ){
        system.debug('objCA.ProfileName__c'+objCA.ProfileName__c);
         system.debug('Flame_CommunityUserInfo.profileName'+Flame_CommunityUserInfo.profileName);
            if(objCA.ProfileName__c.contains(Flame_CommunityUserInfo.profileName))
            customSettingCategoryList.add(objCA);
        }       
        customSettingSubCategoryList2 = [Select id,Name,RecordType__c,Category__c,TabType__c,ProfileName__c,WorkRelayFromID__c,FormDescription__c,FieldSetAPIName__c,Order__c from FLAMEWorkRelayFormsList__c WHERE TabType__c  = 'WorkRelay' AND Category__c != null AND ProfileName__c != null order by Order__c ASC limit 100];  
        for(FLAMEWorkRelayFormsList__c objCA : customSettingSubCategoryList2){
        system.debug('objCA.ProfileName__c'+objCA.ProfileName__c);
         system.debug('Flame_CommunityUserInfo.profileName'+Flame_CommunityUserInfo.profileName);
            if(objCA.ProfileName__c.contains(Flame_CommunityUserInfo.profileName))
            customSettingSubCategoryList.add(objCA);
        }
        
    }
  
    public pageReference ResourceCategory(){
   /*      bool = true;
         subCategoryList = new List<String>();
         List<FLAMEWorkRelayFormsList__c> WorkRelayList1 = new List<FLAMEWorkRelayFormsList__c>();
         WorkRelayList = new List<FLAMEWorkRelayFormsList__c>();
         
         if(Apexpages.currentPage().getParameters().get('input2') != null)
         Header2 = Apexpages.currentPage().getParameters().get('input2');
         
       //  if(Apexpages.currentPage().getParameters().get('input1') != null)
       //  Header  = Apexpages.currentPage().getParameters().get('input1');
         system.debug('Header '+Header);
  
         if(Flame_CommunityUserInfo.profileName=='System Administrator' ){
            WorkRelayList1 = [Select id,Name,WorkRelayFromID__c,Category__c,Order__c from FLAMEWorkRelayFormsList__c  WHERE Category__c =: Header2  ORDER By Order__c limit 999];
         }
         system.debug('WorkRelayList1'+WorkRelayList1 );   
        for(FLAMEWorkRelayFormsList__c obj : WorkRelayList1){            
            WorkRelayList.add(obj);
        }
        System.debug('WorkRelayList'+WorkRelayList);*/
        return null;
    }
    
 
  
   
    Public void ResourceLink(){
         shouldRedirect = true;
    FLAMEWorkRelayFormsList__c resource= new FLAMEWorkRelayFormsList__c();
    resource=[select id,WorkRelayFromID__c from FLAMEWorkRelayFormsList__c where id=:rid ];
    system.debug('>>>>>>>>1'+resource.WorkRelayFromID__c);
    system.debug('>>>>>>>>1'+resource.ID);
    String  baseUrl     = System.Url.getSalesforceBaseUrl().toExternalForm();
   //   OpenPageURL = baseUrl+'/apex/WR_BPM__DataEditLtng?formId='+resource.WorkRelayFromID__c;
        OpenPageURL = baseUrl+'/apex/WR_BPM__DataEditLtng?formId=a4T0p000000NyMQEA0';
   // PageReference pg = new PageReference(baseUrl+'/apex/WR_BPM__DataEditLtng?formId='+resource.WorkRelayFromID__c);
     system.debug('OpenPageURL-->'+OpenPageURL);
    system.debug('.............'+rid);
   // pg.getParameters().put('formId',resource.WorkRelayFromID__c);
  //  pg.setRedirect(true);
   //     return pg;
       
    
    }
    
    
    
 
  
  
   

    Public PageReference proceedtoback(){
     PageReference pg = new PageReference('/apex/Flame_ResourcePage');
        pg.setRedirect(true);
        return pg;
    
    }
}