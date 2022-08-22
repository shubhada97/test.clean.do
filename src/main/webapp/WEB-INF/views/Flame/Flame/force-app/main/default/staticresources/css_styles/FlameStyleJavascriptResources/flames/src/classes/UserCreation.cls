public class UserCreation
{
       

    @future(callout=true)
    public static void insertUserWithRole(ID conID) 
    {
  
    Contact c = [Select ID,FirstName,LastName,Email From Contact Where ID=:conID ];
    system.debug('Contact ID***************' + c.ID);
    Profile p = [SELECT Id FROM Profile WHERE Name='FLAME- Applicant Community'];
    //UserRole r = [SELECT Id FROM UserRole WHERE Name='COO'];
    // Create new user with a non-null user role ID 
        User u = new User();
        u.alias = 'test';
        u.email = c.Email;
        u.emailencodingkey = 'UTF-8';
        u.lastname = c.LastName;
        u.FirstName = c.FirstName; 
        u.languagelocalekey = 'en_US'; 
        u.localesidkey = 'en_US';
        u.profileid = p.Id;
        //u.userroleid = r.Id;
        u.timezonesidkey='America/Los_Angeles'; 
        u.username = c.Email;
        u.ContactID = c.ID;
        u.IsActive = true;
        insert u;
        system.debug('User ID***************' + u.ID);
    }
}