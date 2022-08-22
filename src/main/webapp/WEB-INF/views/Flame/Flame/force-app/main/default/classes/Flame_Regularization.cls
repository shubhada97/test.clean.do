public class Flame_Regularization {
    
    public Boolean approvalLinkBool {get;set;}
    public User currentUser ;
    public String userId;
    
    public Flame_Regularization(){
        try{
            userId = userinfo.getuserId();
            
            if(test.isRunningTest()){
                String TestId = ApexPages.currentPage().getParameters().get('testID');
                userId = TestId;
            }
            currentUser = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id=:userId];
            
            if([SELECT COUNT() FROM Contact WHERE ReportsToId =: currentUser.ContactId] > 0){
                approvalLinkBool = true;
            }
            else{
                approvalLinkBool = false;
            }
        }
        catch(exception e){
            system.debug('EEEE:'+e.getMessage());
        }
    }
}