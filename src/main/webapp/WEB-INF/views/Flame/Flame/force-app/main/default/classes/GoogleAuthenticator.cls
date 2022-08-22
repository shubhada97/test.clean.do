global class GoogleAuthenticator implements Auth.RegistrationHandler{
    global User createUser(Id portalId, Auth.UserData data) {
    User u = New User();
        try{
        u = [SELECT Id,UserName,Email FROM User WHERE Email =: data.email AND isActive = true LIMIT 1]; 
           return u;
        }catch(exception e){
           system.debug('exception--->'+ e.getmessage());
             return null;
        }
       
        //System.debug('data****'+data);
        // system.debug('u****'+u.Id);
        //system.debug('portalID****'+portalID);
        //system.debug('data.Email****'+data.Email);   
        //return u;
    }   
    global void updateUser(Id userId, Id portalId, Auth.UserData data) {
        //User u = [SELECT Id,UserName,Email FROM User WHERE Email =: data.email AND isActive = true AND Id =: userId LIMIT 1];  
        User u = new User(id=userId);
        system.debug('data****'+data);
        system.debug('portalID****'+portalID);
        system.debug('UserID'+userId);    
        update(u);
    }
}