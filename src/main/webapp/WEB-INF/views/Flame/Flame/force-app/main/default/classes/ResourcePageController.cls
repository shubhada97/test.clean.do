public class ResourcePageController {
 
    public List<String> categoryList {get;set;}
    public List<Resource__c> resourceList {get;set;}
    public List<Community_Assist__c> customSettingCategoryList {get;set;}
    public List<Community_Assist__c> customSettingSubCategoryList {get;set;}
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
    public ResourcePageController(){
      
         string jobId = apexpages.currentpage().getparameters().get('rId');
         system.debug('jobId'+jobId);
        Resource__c resource= new Resource__c();
        documentList = New List<Document>();
        categoryList = new List<String>();
        rString = '';
        resourceList = new List<Resource__c>();
        getSubCategory = '';
        Header = '';
        Header2 = '';
        rid='';
        bool = false;
        roleString = '';
        objUser = [SELECT ID,ContactID,Contact.Name,Profile.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        roleString = objUser.Profile.Name;
        List<Community_Assist__c> customSettingCategoryList1 = new List<Community_Assist__c>();
        List<Community_Assist__c> customSettingSubCategoryList2 = new List<Community_Assist__c>();
        customSettingCategoryList = new List<Community_Assist__c>();
        customSettingSubCategoryList = new List<Community_Assist__c>();
        customSettingCategoryList1 = [Select id,Name,Record_Type__c,Category__c,Tab_Type__c,Profile_Name__c from Community_Assist__c WHERE Tab_Type__c  = 'Resources' AND Category__c = null AND Profile_Name__c!= null order by name limit 100];  
      
        for(Community_Assist__c objCA : customSettingCategoryList1 ){
        system.debug('objCA.Profile_Name__c'+objCA.Profile_Name__c);
         system.debug('Flame_CommunityUserInfo.profileName'+Flame_CommunityUserInfo.profileName);
            if(objCA.Profile_Name__c.contains(Flame_CommunityUserInfo.profileName))
            customSettingCategoryList.add(objCA);
        }       
        customSettingSubCategoryList2 = [Select id,Name,Record_Type__c,Category__c,Tab_Type__c,Profile_Name__c from Community_Assist__c WHERE Tab_Type__c  = 'Resources' AND Category__c != null AND Profile_Name__c != null order by name limit 100];  
        for(Community_Assist__c objCA : customSettingSubCategoryList2){
        system.debug('objCA.Profile_Name__c'+objCA.Profile_Name__c);
         system.debug('Flame_CommunityUserInfo.profileName'+Flame_CommunityUserInfo.profileName);
            if(objCA.Profile_Name__c.contains(Flame_CommunityUserInfo.profileName))
            customSettingSubCategoryList.add(objCA);
        }
        
    }
  
    public pageReference ResourceCategory(){
         bool = true;
         subCategoryList = new List<String>();
         List<Resource__c> resourceList1 = new List<Resource__c>();
         resourceList = new List<Resource__c>();
         system.debug('input2'+Apexpages.currentPage().getParameters().get('input2'));
         if(Apexpages.currentPage().getParameters().get('input2') != null)
         Header2 = Apexpages.currentPage().getParameters().get('input2');
         
         if(Apexpages.currentPage().getParameters().get('input1') != null)
         Header  = Apexpages.currentPage().getParameters().get('input1');
         system.debug('Header '+Header);
  
         if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            resourceList1 = [SELECT Id,Name,Category__c,Sub_Category__c,Text_Resources__c,Description__c,Document_Name__c,Document_Id__c,URL__c,File_Type__c,Role__c  FROM Resource__c WHERE Category__c =: Header2 AND Sub_Category__c =: Header AND RecordType.Name = 'Resources' ORDER By CreatedDate limit 999];
         }else{
            resourceList1 = [SELECT Id,Name,Category__c,Sub_Category__c,Text_Resources__c,Description__c,URL__c,Document_Name__c,Document_Id__c,File_Type__c,Role__c  FROM Resource__c WHERE Role__c includes (: Flame_CommunityUserInfo.profileName ) AND Sub_Category__c =: Header AND RecordType.Name = 'Resources' AND Category__c =: Header2 ORDER By CreatedDate limit 999];
         }
         system.debug('resourceList1'+resourceList1 );   
        for(Resource__c obj : resourceList1){            
            resourceList.add(obj);
        }
        System.debug('resourceList'+resourceList);
        return null;
    }
    
 
  
   
    Public PageReference ResourceLink(){
    Resource__c resource= new Resource__c();
    resource=[select id,name from Resource__c where id=:rid ];
    PageReference pg = new PageReference('/apex/communityportalpage');
    system.debug('.............'+rid);
    pg.getParameters().put('recordId',resource.id);
    pg.setRedirect(true);
        return pg;
       
    
    }
    
    
    
  public String getHtmlText() {
 
  system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>'+ApexPages.currentPage().getParameters().get('recordId'));
  resource=[SELECT Id,Name,Category__c,Sub_Category__c,Text_Resources__c,Document_Name__c,Document_Id__c,Description__c,URL__c,File_Type__c,Role__c  FROM Resource__c where Id = :ApexPages.currentPage().getParameters().get('recordId')   Limit 1];
  System.debug('>>>>>>>>>>>>>>1'+ resource);
  String name = resource.Document_Name__c;
  System.debug('>>>>>>>>>2'+name);
  string  Id = resource.Document_Id__c;
  System.debug('>>>>>>>>>3'+Id);
  If(resource.Text_Resources__c == true){
    return [Select Body From Document Where Name=:name OR Id=:resource.id].Body.toString();
  //System.debug('>>>>>>>>>3'+ ID);
    }else{
    
   return null;
    
    }
   
  
  
  } 

    Public PageReference proceedtoback(){
     PageReference pg = new PageReference('/apex/Flame_ResourcePage');
        pg.setRedirect(true);
        return pg;
    
    }
}