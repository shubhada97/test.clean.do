@isTest
public class FlameChatterGroupTest {
    
    public static testmethod void testmethod10(){
         Profile profile = [select id from profile where name = 'Standard User' limit 1];
        
        User UserforTest = new User();
        UserforTest = CLZ_TestUtility.createUser('Userestt', 'DemoTestt', 'test@clztestt.com',profile.id);
        UserforTest.profileId = profile.id;
        insert UserforTest;
        
        CollaborationGroup cg = new CollaborationGroup(Name='Tjj',CollaborationType='public',Description='test');
        //TestGroup = CLZ_TestUtility.createCollaborationGroup('Test', 'TestGroup','testgroup@gmail.com');
        insert cg;
      
        CollaborationGroupMember TestMember = new CollaborationGroupMember(CollaborationGroupId=cg.Id,MemberId=UserforTest.id);
        //TestMember = CLZ_TestUtility.createCollaborationGroupMember('Test', 'TestMember', 'testmember@gmail.com',cg.Id,TestMember.MemberId);
        insert TestMember;
        
        Test.startTest();
        FlameChatterGroups_Controller fltest = new FlameChatterGroups_Controller();
        fltest.getGroups();
        fltest.Followchange();
        fltest.Goback();
        //fltest.ShowPhoto();
        Test.stopTest();
        
    }

}