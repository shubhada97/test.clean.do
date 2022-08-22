@isTest(SeeAllData=true)
private class Flame_Careerservicesprofiletest{
static private user objuser;
static private Account objAcc;
static private Contact objCon;
static private Contact_Education__c conedu ;
static private ContentDocumentLink doclink;
static private ContentVersion docversion;
static private case case1;
static private CareerServicesProfile__c careerprofile;

static testMethod void test_Careerservice(){
    Createuser();
    CreateAccount();
    CreateContact();
    CreateContactEducation();
    CreateContentDocumentLink();
    CreateContentVersion();
    Createcase();
    CreateCareerServicesProfile();
}

  @isTest
    public Static void profile(){
    Contact con = [select Id, Name from Contact limit 1];
        
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'System Administrator'];
            User portUser = new User();   
            portUser.ProfileId = studPro.Id;
            portUser.Community_Contact_ID__c = con.Id;
            portUser.Username = 'flame@test.com';
            portUser.Alias = 'ftest';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            }
        Static void Createuser(){
        objuser = new user();
        
        }
    Static void CreateAccount(){
    objAcc = new Account();
    objAcc.Name = 'TestAcc';
    insert objAcc;
    }
    Static void CreateContact(){
    
    objCon = new Contact();
    objCon.LastName = 'Test';
    objCon.Email = 'Test@gmail.com';
    objCon.AccountID = objAcc.Id;
  //  insert objCon;
    }
    Static void CreateContactEducation(){
    conedu = new Contact_Education__c();
    conedu.Name ='test';
    conedu.Contact__c =objCon.Id;
   // insert conedu;
    }
    Static void CreateContentVersion(){
    docversion = New ContentVersion();
    docversion.PathOnClient = 'test';
    docversion.Title = 'Profie Image';
    docversion.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
  //  insert doclink;
    ContentVersion tempContentVersion= [SELECT Id, ContentDocumentId FROM ContentVersion  limit 1];
    ContentDocumentLink objCDL = new ContentDocumentLink(); 
    objCDL.ContentDocumentId = tempContentVersion.ContentDocumentId;
    objCDL.LinkedEntityId = objCon.Id;
    objCDL.ShareType = 'I';
  //  insert objCDL;
    }
Static void CreateContentDocumentLink(){}
Static void Createcase(){}
Static void CreateCareerServicesProfile(){}
}