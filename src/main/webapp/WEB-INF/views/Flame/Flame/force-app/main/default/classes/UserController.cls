public with sharing class UserController {
    //public String gName { get; set; } 
    public string uCount { get; set; }
    public String uName { get; set; }  // keep the friend user name
    public String uNameID{get;set;}// keep the friend user id 
    public string userinfoId {get;set;} // login user id
    public string feedinfoId {get;set;} // friend user id
    public string feedinfoName {get;set;} // friend username
    public string feedinfoPhoto{get;set;} // friend photo
    //public String searchName { get; set; }
    public String userListCount { get; set; }  // keep the friend user name
    public List<User> userSearchList {get;set;}
    public string groupName{get;set;}// holding the group name
    public List<CollaborationGroupMember> CollborationGroups {get;set;}
    public Boolean isFollowing{get;set;}
    //public string GroupPhoto{get;set;}
    set<Id> idset = new set<Id>();
    
    public void searchUsers(){
       
            userSearchList = new List<User>();
            string usName = Apexpages.currentPage().getparameters().get('usName');
            if(Test.isrunningTest()){
                usName = uName;
            }
            if(usName.trim() !='')
            { 
                usName = usName.trim();
                system.debug('search str:::: '+'%' + usName + '%');
                userSearchList = [SELECT Id, Name, SmallPhotoUrl FROM User where Name LIKE : '%' + usName + '%' AND Community_License_Name__c = 'Customer Community' AND isActive=true limit 10];
            }
    }
    public UserController()
    {
            userSearchList = new List<User>();
            system.debug('userController');
            uNameID = ApexPages.currentPage().getParameters().get('selectedUser');
            system.debug('userController');
            List<User> userList = [SELECT Id, Name,SmallPhotoUrl FROM User where id =: uNameID];
            if(userList.size()>0){
                feedinfoId = userList[0].id;
                feedinfoName = userList[0].name;
                feedinfoPhoto = userList[0].SmallPhotoUrl;
            }
            userinfoId = UserInfo.getUserId();
            followchange();
    }
    public PageReference doSearch() 
    {
        try{
            system.debug('userListCount::'+userListCount);
            string usName = Apexpages.currentPage().getparameters().get('usName');
            if(Test.isrunningTest()){
                usName = uName;
            }
            string usCount = Apexpages.currentPage().getparameters().get('usCount');
            if(Test.isrunningTest()){
                usCount = uCount;
            }
            system.debug('usName::::'+usName);
            system.debug('usCount::::'+usCount);
            usName = usName.trim();
            system.debug('userSearchList ID::: '+userSearchList[Integer.valueOf(usCount)]);
            List<User> userList = [SELECT Id, Name FROM User where Name =: usName AND id =:userSearchList[Integer.valueOf(usCount)].id];
            if(userList.size()>0){
                System.debug('userList[0]::'+userList[0]);
                feedinfoId = userList[0].id;
                feedinfoName = userList[0].name;
                system.debug('feedinfoId::'+feedinfoId);
            }
            CollborationGroups = [SELECT Id,CollaborationGroup.Name,CollaborationGroup.CollaborationType,memberId,CollaborationGroupId,CollaborationGroup.SmallPhotoUrl FROM CollaborationGroupMember where MemberID =:feedinfoId limit 5];
            //GroupPhoto = CollborationGroups[0].CollaborationGroup.SmallPhotoUrl;
            //System.debug('CollborationGroups::'+CollborationGroups);
            system.debug('CollborationGroups:::'+CollborationGroups);
            //uid=uName;            
            
            List<EntitySubscription> entitySb = [select id, subscriberid, subscriber.name, parent.name,parentid from EntitySubscription where subscriberid =:userinfoId and parentId =:feedinfoId limit 1];
            system.debug('entitySb:: '+entitySb);
            if(entitySb.size()>0){
                isFollowing = true;
            }
            else{
                isFollowing = false;
            }
            pagereference pg = new pagereference('/apex/flame_Users?selectedUser='+feedinfoId);
            pg.setRedirect(true);
            return pg;
        }  
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Something went wrong.'));
        }   
        return null;
    }
    
    public PageReference followchange() 
    {
        
            system.debug('uName:: '+uName);
            string usName = Apexpages.currentPage().getparameters().get('usName');
            system.debug('usName::::'+usName);
            if(Test.isrunningTest()){
                usName = uName;
            }
            List<User> userList = [SELECT Id, Name FROM User where Name =: usName];
            if(userList.size()>0){
                System.debug('userList[0]::'+userList[0]);
                feedinfoId = userList[0].id;
                feedinfoName = userList[0].name;
            }
            CollborationGroups = [SELECT Id,CollaborationGroup.Name,CollaborationGroup.CollaborationType,memberId,CollaborationGroupId,CollaborationGroup.SmallPhotoUrl FROM CollaborationGroupMember where MemberID =:feedinfoId limit 5];
            //GroupPhoto = CollborationGroups[0].CollaborationGroup.SmallPhotoUrl;
            //System.debug('CollborationGroups::'+CollborationGroups);
            system.debug('CollborationGroups:::'+CollborationGroups);
            //uid=uName;            
            
            List<EntitySubscription> entitySb = [select id, subscriberid, subscriber.name, parent.name,parentid from EntitySubscription where subscriberid =:userinfoId and parentId =:feedinfoId limit 1];
            system.debug('entitySb:: '+entitySb);
            if(entitySb.size()>0){
                isFollowing = true;
            }
            else{
                isFollowing = false;
            }
        return null;
    }  
    public pagereference goToGroup(){
        try{
            string grpName = Apexpages.currentPage().getparameters().get('grpsname');
            system.debug(groupName);
            List<CollaborationGroupMember> idz = [select id, CollaborationGroupId,CollaborationGroup.CollaborationType,MemberId from CollaborationGroupMember where CollaborationGroup.Name =: groupName AND MemberID =:feedinfoId];
            system.debug('idz::'+idz);
            //system.debug('UserInfo.getUserId()::'+UserInfo.getUserId());
            List<CollaborationGroupMember> idz2 = [select id, CollaborationGroupId,CollaborationGroup.CollaborationType,MemberId from CollaborationGroupMember where CollaborationGroupId=:idz[0].CollaborationGroupId AND MemberID =:userinfoId];
            //system.debug('idz2::'+idz2);
            if(idz2.size()>0){
                system.debug('idz2[0].CollaborationGroupId::'+idz2[0].CollaborationGroupId);
                system.debug('idz[0].CollaborationGroupId::'+idz[0].CollaborationGroupId);
                if(idz2[0].CollaborationGroupId == idz[0].CollaborationGroupId){
                    pagereference page = new pagereference('/Flame_Groups?selectedGroup='+idz[0].CollaborationGroupId);
                    page.setRedirect(true);
                    return page;
                }
            }
            system.debug('error message:::');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'You cannot access this group, contact system administrator.'));
        }
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
        }  
        return null;      
    }
    public PageReference Previous(){
        
            pagereference pg = new pagereference('/apex/flame_Chatter');
            pg.setRedirect(true);
            return pg;
    }
}