@isTest
public class FlameFollowersTest {

    public static  testmethod void FollowersTest(){
        
         Profile profile2 = [select id from profile where name = 'Standard User' limit 1];
        
        User UserforTest1 = new User();
        UserforTest1 = CLZ_TestUtility.createUser('Useresttt', 'DemoTest', 'test@clztest.com',profile2.id);
        UserforTest1.profileId = profile2.id;
        insert UserforTest1;
        
        CollaborationGroup cgg = new CollaborationGroup(Name='Tjtg',CollaborationType='private');
        //TestGroup = CLZ_TestUtility.createCollaborationGroup('Test', 'TestGroup','testgroup@gmail.com');
        insert cgg;
      
        CollaborationGroupMember TestMember1 = new CollaborationGroupMember(CollaborationGroupId=cgg.Id,MemberId=UserforTest1.id);
        //TestMember = CLZ_TestUtility.createCollaborationGroupMember('Test', 'TestMember', 'testmember@gmail.com',cg.Id,TestMember.MemberId);
        insert TestMember1;
        
        Test.startTest();
        FlameFollowersController fltest = new FlameFollowersController();
        fltest.followchange();
        fltest.Previous();
        fltest.getUsers();
        Test.stopTest();
        
        
        
    }
}