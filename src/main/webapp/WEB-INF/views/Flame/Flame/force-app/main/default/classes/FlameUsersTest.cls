@isTest
public class FlameUsersTest {
    public static testmethod void testmethodsample(){
        
        Profile profile2 = [select id from profile where name = 'Standard User' limit 1];
        
        User UserforTest1 = new User();
        UserforTest1 = CLZ_TestUtility.createUser('Useresttt', 'DemoTest', 'test@clztest.com',profile2.id);
        UserforTest1.profileId = profile2.id;
        insert UserforTest1;
        
        User UserforTest21 = new User();
        UserforTest21 = CLZ_TestUtility.createUser('sahil','saheel','test@clztest21.com',profile2.id);
        UserforTest21.profileId = profile2.id;
        insert UserforTest21;
        
        CollaborationGroup cgg = new CollaborationGroup(Name='Tjtg',CollaborationType='private');
        insert cgg;
        
        CollaborationGroupMember TestMember1 = new CollaborationGroupMember(CollaborationGroupId=cgg.Id,MemberId=UserforTest1.id);
        insert TestMember1;
        
        Test.startTest();
        Test.setCurrentPageReference(new PageReference('Page.Flame_Users'));
        System.currentPageReference().getParameters().put('selectedUser', UserforTest21.id);
        System.currentPageReference().getParameters().put('usName', UserforTest21.Name);
        UserController fltest = new UserController();
        //fltest.getUsers();
        Test.setCurrentPageReference(new PageReference('Page.Flame_Users'));
        fltest.uName = 'Useres';
        fltest.searchUsers();
        System.currentPageReference().getParameters().put('usCount', '0');
        fltest.followchange();
        fltest.doSearch();
        fltest.goToGroup();
        fltest.Previous();
        Test.stopTest();
        
    }
    
}