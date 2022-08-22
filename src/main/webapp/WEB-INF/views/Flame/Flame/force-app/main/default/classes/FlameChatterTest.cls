@isTest
public class FlameChatterTest {

    public static testmethod void testMethod9(){
        Profile prof = [select id from profile where name = 'Standard User' limit 1];
        
        User UserforTest = new User();
        UserforTest = CLZ_TestUtility.createUser('Userest', 'DemoTest', 'test@clztest.com',prof.id);
        UserforTest.profileId = prof.id;
        insert UserforTest;
        
        CollaborationGroup cg = new CollaborationGroup(Name='Tj',CollaborationType='public');
        //TestGroup = CLZ_TestUtility.createCollaborationGroup('Test', 'TestGroup','testgroup@gmail.com');
        insert cg;
      
        CollaborationGroupMember TestMember = new CollaborationGroupMember(CollaborationGroupId=cg.Id,MemberId=UserforTest.id);
        //TestMember = CLZ_TestUtility.createCollaborationGroupMember('Test', 'TestMember', 'testmember@gmail.com',cg.Id,TestMember.MemberId);
        insert TestMember;
       
        Test.startTest();
        FlameChatter_Controller fltest = new FlameChatter_Controller();
        fltest.Search();
        fltest.Groups();
        fltest.getFollowers();
        fltest.getUsers();
        Test.stopTest();
        
    }
}