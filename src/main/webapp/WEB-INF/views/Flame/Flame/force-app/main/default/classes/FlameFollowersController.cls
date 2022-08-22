public class FlameFollowersController {
    public String uName { get; set; } 
    public String uid  {get;set;}  
    //List<EntitySubscription> followers {get;set;}
    //set<Id> idset = new set<Id>();
    public string userinfoId {get;set;} // login user id
    public string feedinfoId {get;set;}
    public string feedinfoName {get;set;}
    public string feedinfoPhoto{get;set;}
    public Boolean isFollowing{get;set;}
    
    public List<selectOption> getUsers() 
    {
        List<selectOption> options = new List<selectOption>(); 
        options.add(new selectOption('', 'Select User Feed'));
        List<EntitySubscription> enttySubList = [select id, subscriberid, subscriber.name,subscriber.SmallPhotoUrl from EntitySubscription where parentid =:uName AND subscriberid IN (SELECT Id FROM User where Community_License_Name__c = 'Customer Community' AND isActive=true)];
        //List<user> userfollowList = [SELECT Id, Name, SmallPhotoUrl FROM User where Community_License_Name__c = 'Customer Community' AND isActive=true ];
        for (EntitySubscription users : enttySubList) 
        { 
            options.add(new selectOption(users.subscriberid, users.subscriber.name));
            //idset.add(users.id);
            
        }
        return options; 
    }    
    
    public FlameFollowersController()
        
    {
        system.debug('contl');
        uName = userinfo.getuserId();
        userinfoId = UserInfo.getUserId();
        feedinfoId = uName;
    }
    
    public PageReference followchange() 
    {
        try{
            System.debug(uName);
            if(uName!=null){
                List<User> userList = [SELECT Id, Name,SmallPhotoUrl FROM  User where id =: uName];
                if(userList.size()>0){
                    feedinfoId = userList[0].id;
                    feedinfoName = userList[0].name;
                    feedinfoPhoto = userList[0].SmallPhotoUrl;
                }
                List<EntitySubscription> enttySubList = [select id, subscriberid, subscriber.name,subscriber.SmallPhotoUrl,parent.Name from EntitySubscription where parentid =:uName AND subscriberid =:userinfoId];
                if(enttySubList.size()>0){
                    isFollowing = true;
                }
                else{
                    isFollowing = false;
                }
                uid=uName;  
                pagereference pg = new pagereference('/apex/flame_Followers?selectedUser='+feedinfoId);
                pg.setRedirect(true);
                return null;
               
            }
            else
            {
                uName = userinfo.getuserId();
            }
            return null;
        }      
        catch(Exception e){
            System.debug('error msg:::'+ e.getMessage());
            pagereference pg = new pagereference('/apex/flame_Followers');
            pg.setRedirect(true);
            return pg;
        }
    }   
    
    public PageReference Previous(){
        pagereference pg = new pagereference('/apex/flame_Chatter');
        pg.setRedirect(true);
        return pg;
        
    } 
    
    
}