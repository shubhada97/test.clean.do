trigger DisableApplicantProtalAccess on Application__c (after update){
    List<ID> ContactLst = new List<ID>();
    List<User> userLst = new List<User>();
    for(Application__c app : Trigger.new){
        if(app.Admission_Status__c == 'Enrolled'){
            ContactLst.add(app.Contact__c);
        }
    }
    
    List<User> PortalUserLst = [Select ID,ContactID,IsActive From User Where ContactID IN : ContactLst];
    for(User u : PortalUserLst){
        u.IsActive = FALSE;
        u.IsPortalEnabled = FALSE;
        userLst.add(u);
    }
    try{
        update userLst;
    }
    catch(Exception e){}
}