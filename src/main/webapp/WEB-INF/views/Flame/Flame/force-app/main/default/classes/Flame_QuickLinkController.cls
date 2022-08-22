public class Flame_QuickLinkController {
    
    public List<QuickLinkWrapper> QuickLinkWrapperList {get;set;}
    public String hostURL {get;set;}
    public List<String> stringList {get;set;}
    public user objUser {get;set;}
    public String roleString {get;set;}
    public List<Resource__c> resourceList;
    public String Header {get;set;}
    
    public Flame_QuickLinkController (){
        Header = '';
        roleString = '';
        objUser = [SELECT ID,ContactID,Contact.Name,Profile.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        roleString = objUser.Profile.Name;
        
        QuickLinkWrapperList = new List<QuickLinkWrapper>();
        stringList = new List<String>();        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            resourceList = [SELECT Id,Name,Description__c,Link_URL__c,Category__c,Role__c FROM Resource__c WHERE RecordType.Name = 'Links' AND  Category__c  != null AND Link_URL__c != null  order by Category__c limit 999 ];       
        }else{
            resourceList = [SELECT Id,Name,Description__c,Link_URL__c,Category__c,Role__c FROM Resource__c WHERE Role__c includes (: Flame_CommunityUserInfo.profileName ) AND RecordType.Name = 'Links' AND  Category__c  != null AND Link_URL__c != null  order by Category__c limit 999 ];       
        }
        //-- 
         for(Resource__c objRes : resourceList){
            if(!stringList.contains(objRes.Category__c))
                stringList.add(objRes.Category__c);
        }
    }
    
    public void quickLinkcategry(){
        Header  = Apexpages.currentPage().getParameters().get('input1');
        
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){        
            resourceList = [SELECT Id,Name,Description__c,Link_URL__c,Category__c,Role__c FROM Resource__c WHERE RecordType.Name = 'Links' AND Category__c =: Header AND  Category__c  != null AND Link_URL__c != null  order by Category__c ];       
        }else{
            resourceList = [SELECT Id,Name,Description__c,Link_URL__c,Category__c,Role__c FROM Resource__c WHERE Role__c includes (: Flame_CommunityUserInfo.profileName ) AND RecordType.Name = 'Links' AND Category__c =: Header AND  Category__c  != null AND Link_URL__c != null  order by Category__c ];       
        }
        QuickLinkWrapperList = new list<QuickLinkWrapper>();        
        for(Resource__c objR : resourceList){
            if(Header == objR.Category__c){            
                QuickLinkWrapperList.add(new QuickLinkWrapper(objR));
            }           
        }       
    }
    
    public class QuickLinkWrapper{        
        public Resource__c objRes {get;set;}
        public QuickLinkWrapper(Resource__c objRes){            
            this.objRes = objRes;
        }   
    }
}