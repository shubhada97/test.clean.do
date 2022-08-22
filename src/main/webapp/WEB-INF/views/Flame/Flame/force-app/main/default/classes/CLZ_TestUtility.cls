@isTest
public class CLZ_TestUtility {
        public static User createUser(string fname,string lname,string email,id profileId){
            User usrObj = new user();
            usrObj.LastName = lname;
            usrObj.firstname = fname;
            usrObj.Email = email;
            usrObj.Alias = 'Tcode';
            //usrObj.Username = ;
            //usrObj.ContactId = Cid;
            usrObj.Username = email;
            usrObj.LocaleSidKey = 'en_US';
            usrObj.TimeZoneSidKey = 'GMT';
            usrObj.ProfileID = profileId;
            usrObj.LanguageLocaleKey = 'en_US';
            usrObj.EmailEncodingKey = 'UTF-8';
            return usrObj;
        }
   
    public static CollaborationGroup createCollaborationGroup(string fname,string lname,String CollaborationType){
        CollaborationGroup collaborationGroupObj = new CollaborationGroup();
        collaborationGroupObj.Name='';
        return collaborationGroupObj;
    }
   
    public static CollaborationGroupMember createCollaborationGroupMember(string fname,string lname,string email,string CollaborationGroupId,string MemberId){
        CollaborationGroupMember collaborationGrpMemberObj = new CollaborationGroupMember();
        collaborationGrpMemberObj.CollaborationGroupId='';
        collaborationGrpMemberObj.MemberId='';
        return collaborationGrpMemberObj;
    }
}