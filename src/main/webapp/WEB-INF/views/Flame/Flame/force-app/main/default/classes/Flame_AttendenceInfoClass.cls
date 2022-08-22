public class Flame_AttendenceInfoClass {
    
    public Boolean approvalLinkBool {get;set;}
    public String userId { get; set; } 

    public contact con {get;set;}
    public Flame_AttendenceInfoClass(){   
        try{
            con = new contact();
            userId = userinfo.getuserId();
            
            
            User currentUser = [Select Id,Name,Email,Account.Name,SmallPhotoUrl,contactId from User where Id =: userId];
            con = [SELECT Id,Name, MobilePhone, Email,Earned_Leave_Balance__c,Casual_Leave_Balance__c,Employee_Id__c, Designation_Name__c,Grade_Name__c, Department__c, Faculty__c, ReportsTo.Name FROM Contact where id =: currentUser.contactId];
            
            if([SELECT COUNT() FROM Contact WHERE ReportsToId =: currentUser.ContactId] > 0){
                approvalLinkBool = true;
            }
            else{
                approvalLinkBool = false;
            }
        }
        catch(exception e){
            system.debug('error ::'+e.getMessage());
        }
    }
    
}