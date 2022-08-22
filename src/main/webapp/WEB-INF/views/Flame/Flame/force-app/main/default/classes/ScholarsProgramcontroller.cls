Public class ScholarsProgramcontroller{
public User userDetails {get;set;}
public Contact userContact {get;set;} 
Public Application__c app {get;set;}
Public string contactId {get;set;}
Public  ScholarsProgramcontroller(){
 userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
}     

Public PageReference applylink(){

   return new PageReference('http://flameu.force.com/scholars?contactId='+userDetails.ContactId);
  
  }
  
  Public PageReference downloadpdf(){
  
  return null;
  }
 //Button disabled 
  public Boolean getbtnDisabled() {
  List<Application__c> appdetail = new List<Application__c>();
  appdetail =[select id,FUA_SOP_Submitted__c,Contact__r.id,Program__c from Application__c where Contact__r.id=:userDetails.ContactId AND Program__c=:System.Label.Scholarsprogram  limit 1];
    for(Application__c a: appdetail) {
        if(a.FUA_SOP_Submitted__c) {
            return true;
        }
    }
    return false;
} 
  
}