public with sharing class FlameChatterGroups_Controller 
{
    public String gName { get; set; } 
    public String gid  {get;set;} 
    public List<CollaborationGroupMember> groupMemberName {get;set;}
    public string GroupSmallPhoto{get;set;}
    public string GroupInfoName{get;set;}
    //public CollaborationGroup g {get;set;}
    //public Boolean isChecked{get;set;}
    set<Id> idset = new set<Id>();
    
    
    public List<selectOption> getGroups() 
    {
        List<selectOption> options = new List<selectOption>(); 
        //options.add(new selectOption('', 'Find Group'));
        for(CollaborationGroupMember groups : [SELECT Id,CollaborationGroup.Name,CollaborationGroupId,Member.Name,CollaborationGroup.SmallPhotoUrl FROM CollaborationGroupMember Where MemberId= :UserInfo.getUserId()]) 
        { 
            options.add(new selectOption(groups.CollaborationGroupId, groups.CollaborationGroup.Name));
            idset.add(groups.CollaborationGroupId);
            system.debug('idset::'+idset);
        }
        return options; 
    }
    public FlameChatterGroups_Controller(){
        gName = ApexPages.currentPage().getParameters().get('selectedGroup');
        List<CollaborationGroup> colgrpList= [SELECT Id, Name,SmallPhotoUrl FROM CollaborationGroup where id =:gName];
        if(colgrpList.size()>0){
            GroupSmallPhoto = colgrpList[0].SmallPhotoUrl;
            GroupInfoName = colgrpList[0].Name;
        }
        //System.debug('GroupName2::'+gName);
    } 
    public PageReference Followchange() 
    {
        //if(groupMemberName!=null && !groupMemberName.isEmpty()){
        groupMemberName = [Select Id,member.Name,collaborationGroup.Name,member.SmallPhotoUrl,collaborationGroup.Description from collaborationgroupmember where collaborationGroupID =:gName];
        //GroupSmallPhoto = groupMemberName[0].member.SmallPhotoUrl;
        List<CollaborationGroup> colgrpList= [SELECT Id, Name,SmallPhotoUrl FROM CollaborationGroup where id =:gName];
        if(colgrpList.size()>0){
            GroupSmallPhoto = colgrpList[0].SmallPhotoUrl;
            GroupInfoName = colgrpList[0].Name;
        }
        System.debug(gName);
        gid=gName;
        
        //}
        return null;
    }
    
    public Pagereference Goback()
    {
        pagereference pg = new pagereference('/apex/flame_chatter');
        pg.setRedirect(true);
        return pg;
    }
    
    /*public Pagereference ShowPhoto(){

collaborationGroup g = [SELECT Id, Name,FullPhotoUrl,Description FROM CollaborationGroup where id =:gName];
if(g.Id !=null){
GroupSmallPhoto = g.FullPhotoUrl;
// GroupName = g.Name;
System.debug('GroupSmallPhoto'+g.FullPhotoUrl);
}

return null;
}*/
    
    /*public void ShowPhoto(){
collaborationGroup g = [SELECT Id, Name,SmallPhotoUrl,Description FROM CollaborationGroup where id =:gName];
GroupSmallPhoto = g.SmallPhotoUrl;

}*/
}