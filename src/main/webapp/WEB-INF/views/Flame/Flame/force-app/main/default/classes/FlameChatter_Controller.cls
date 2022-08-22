public class FlameChatter_Controller {
    public User currentUser{get;set;} 
    //public string GroupName{get;set;}
    public String uName{get;set;}
    public String uid  {get;set;}
    List<EntitySubscription> followers {get;set;}
    public Integer noOfFollowers {get;set;}
    
    public PageReference Groups(){
        return null;       
    }
    public Set<CollaborationGroup>acc { get; set; }
    public List<CollaborationGroup> grpList{get;set;}
    public List<CollaborationGroupMember> collGroupMemberList{get;set;}
    Set<User> UserSet = new Set<User>();
    Set<CollaborationGroup> accSET = new Set<CollaborationGroup>(); 
    public String GroupPhoto{get;set;}
    
    public FlameChatter_Controller(){
        try{
        acc = new Set<CollaborationGroup>();
        followers=[select id, subscriberid, subscriber.name from EntitySubscription where parentid =:uid];
        System.debug('followers:: '+followers);
        uName = userinfo.getuserId();
        noOfFollowers= followers.size();
        uid=uName;
        currentUser=new User();
        currentUser=[Select Id,Name,Email from User where Id=:userinfo.getuserId()];
        system.debug('currentUser:: '+currentUser);
        }  
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
        } 
    }
    
    public List<EntitySubscription> getFollowers() 
    {
        try{
        followers=  [select id, subscriberid, subscriber.name from EntitySubscription where parentid =:uid limit 2];    
        system.debug('followers:: '+followers);
        return followers;
        }
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
            return null;
        } 
    }
    
    public List<selectOption> getUsers() 
    {
        try{
            List<selectOption> options = new List<selectOption>(); 
            options.add(new selectOption('', 'Current User')); 
            for (User users : [SELECT Id, Name FROM User ]) 
            { 
                options.add(new selectOption(users.Id, users.Name)); 
            }
            system.debug('options:: '+options);
            return options; 
        }    
        
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
            return null;
        }  
    } 
    public pagereference Search(){
        try{
        collGroupMemberList = [SELECT Id,CollaborationGroupId,CollaborationGroup.Name,CollaborationGroup.SmallPhotoUrl FROM CollaborationGroupMember Where MemberId= :UserInfo.getUserId()];
        if(!collGroupMemberList.isEmpty() && collGroupMemberList.size() > 0){
            GroupPhoto = collGroupMemberList[0].CollaborationGroup.SmallPhotoUrl;
        }
        grpList  =[SELECT Id, Name,CollaborationType,SmallPhotoUrl,Description FROM CollaborationGroup];
        system.debug('grpList:: '+grpList);
        if(!grpList.isEmpty() && grpList.size() > 0){
            for(CollaborationGroup gp : grpList){
                acc.add(gp);
            }  
        }
        return null;
    }
        catch(Exception e){
            system.debug('e.message' +e.getMessage());
            return null;
        } 
    }
}