@isTest
public class GoogleAuthenticatorTest{
    public static testmethod void validateRegHandler(){
        Profile objProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User objUser = new User(Alias = 'nUserGa', Email='new1user@testorg.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = objProfile.Id, 
                                TimeZoneSidKey='America/Los_Angeles', UserName='new1user@testorg.com');        
        insert objUser;
        Id UserId  = objUser.Id;//UserInfo.getUserId();
        GoogleAuthenticator objGoogleAuthenticator= new GoogleAuthenticator();
        Auth.UserData sampleData = new Auth.UserData('UserId', 'testFirst', 'testLast', 'testFirst testLast', 'new1user@testorg.com', null, 'testuserlong', 'en_US', 'facebook', null, new Map<String, String>{'language' => 'en_US'});
        User objUserOne = objGoogleAuthenticator.createUser(null, sampleData);
        //insert(u);
        system.runAs(objUserOne){
            String uid = objUserOne.id;
            
            sampleData = new Auth.UserData('testNewId', 'testNewSecond', 'testNewLast', 'testNewFirst testNewLast', 'newuser2@testorg.com', null, 'testnewuserlong', 'en_US', 'facebook', null, new Map<String, String>{});
            objGoogleAuthenticator.updateUser(uid, null, sampleData);  
            User updatedUser = [SELECT userName, email, firstName, lastName, alias FROM user WHERE id=:uid];
        }
    }     
}