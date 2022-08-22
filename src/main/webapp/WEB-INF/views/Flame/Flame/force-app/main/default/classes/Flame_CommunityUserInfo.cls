/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_CommunityUserInfo
* Created Date: August 03 2018
* Description: show the current login user info
*******************************************************************/
public class Flame_CommunityUserInfo {
    //public static final String profileId = UserInfo.getProfileId();
    public static final String fullName = UserInfo.getName();
    public static final String firstName = UserInfo.getFirstName();
    public static final String lastName = UserInfo.getLastName();    
    public static final String profileName =  [SELECT Name FROM Profile WHERE id =: UserInfo.getProfileId()].Name;
    public static final String userName = UserInfo.getUserName();
    public static final String userEmail = UserInfo.getUserEmail();    
    public String getFullName(){        
        return fullName;
    }
}