@isTest
public class Flame_CommunityUserInfoTest {
    public static testMethod void UserInfoTest(){
        Flame_CommunityUserInfo info = new Flame_CommunityUserInfo();
        String fullname = info.getFullName();
        System.debug('fullName'+fullname);
    }
}