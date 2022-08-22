@isTest
public class FUL_HousingPaymentcontroller_Test {
      public static void createTestData(){
        Account account = new Account();
        account.Name = 'FLAME 2016-17 Admissions';
        insert account;
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Testing';
        contact.LastName = 'Extentia';
        
        contact.Email =  'rohit63419FLAMETEST@gmail.com';        
        insert contact;
        
        FlameUniversitSettings__c data = new FlameUniversitSettings__c();
        data.Name = 'Default';
        data.AccountName__c = 'FLAME 2016-17 Admissions';
        insert data;
        
        Contact contact1 = new Contact();
        contact1.AccountId = account.Id;
        contact1.FirstName = 'Testing';
        contact1.LastName = 'Extentia';
        contact1.Email =  'rmextentia111132322@gmail.com';
        insert contact1;
        
        Profile prof = [select id from profile WHERE Name='FLAME- Applicant Community'];
        
        User user = new User();
        user.firstName = 'test1';
        user.lastName = 'test2';
        user.profileId = prof.id;
        user.username = 'test@test.com';
        user.email = 'test@test.com';
        insert user;
        }
    
  public static testMethod void test() {
        System.Test.StartTest();
         Profile p = [SELECT Id FROM Profile WHERE Name='FLAME- Applicant Community'];
        User user = [select id,ContactId,profile.id from User where  profile.id =:p.id limit 1];
     
        System.Test.StopTest();
  }
  private static testMethod void testContructor1(){
        Profile p = [SELECT Id FROM Profile WHERE Name='FLAME- Applicant Community'];
        User user = [select id,ContactId,profile.id from User where  profile.id =:p.id limit 1];
        system.debug(user);
          
                System.Test.StartTest();
               
            
        
    }
Public static void Housingpayment(){
 List<User> user_Obj  =  [SELECT Username,LastName,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,Alias,CommunityNickname,IsActive,TimeZoneSidKey,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,LanguageLocaleKey,UserPermissionsMarketingUser,UserPermissionsOfflineUser,UserPermissionsAvantgoUser,UserPermissionsCallCenterAutoLogin,UserPermissionsMobileUser,UserPermissionsSFContentUser,UserPermissionsKnowledgeUser,UserPermissionsInteractionUser,UserPermissionsSupportUser,UserPermissionsChatterAnswersUser,ForecastEnabled,UserPreferencesActivityRemindersPopup,UserPreferencesEventRemindersCheckboxDefault,UserPreferencesTaskRemindersCheckboxDefault,UserPreferencesReminderSoundOff,UserPreferencesDisableAllFeedsEmail,UserPreferencesDisableFollowersEmail,UserPreferencesDisableProfilePostEmail,UserPreferencesDisableChangeCommentEmail,UserPreferencesDisableLaterCommentEmail,UserPreferencesDisProfPostCommentEmail,UserPreferencesApexPagesDeveloperMode,UserPreferencesHideCSNGetChatterMobileTask,UserPreferencesDisableMentionsPostEmail,UserPreferencesDisMentionsCommentEmail,UserPreferencesHideCSNDesktopTask,UserPreferencesHideChatterOnboardingSplash,UserPreferencesHideSecondChatterOnboardingSplash,UserPreferencesDisCommentAfterLikeEmail,UserPreferencesDisableLikeEmail,UserPreferencesSortFeedByComment,UserPreferencesDisableMessageEmail,UserPreferencesDisableBookmarkEmail,UserPreferencesDisableSharePostEmail,UserPreferencesEnableAutoSubForFeeds,UserPreferencesDisableFileShareNotificationsForApi,UserPreferencesShowTitleToExternalUsers,UserPreferencesShowManagerToExternalUsers,UserPreferencesShowEmailToExternalUsers,UserPreferencesShowWorkPhoneToExternalUsers,UserPreferencesShowMobilePhoneToExternalUsers,UserPreferencesShowFaxToExternalUsers,UserPreferencesShowStreetAddressToExternalUsers,UserPreferencesShowCityToExternalUsers,UserPreferencesShowStateToExternalUsers,UserPreferencesShowPostalCodeToExternalUsers,UserPreferencesShowCountryToExternalUsers,UserPreferencesShowProfilePicToGuestUsers,UserPreferencesShowTitleToGuestUsers,UserPreferencesShowCityToGuestUsers,UserPreferencesShowStateToGuestUsers,UserPreferencesShowPostalCodeToGuestUsers,UserPreferencesShowCountryToGuestUsers,UserPreferencesHideS1BrowserUI,UserPreferencesDisableEndorsementEmail,UserPreferencesPathAssistantCollapsed,UserPreferencesCacheDiagnostics,UserPreferencesShowEmailToGuestUsers,UserPreferencesShowManagerToGuestUsers,UserPreferencesShowWorkPhoneToGuestUsers,UserPreferencesShowMobilePhoneToGuestUsers,UserPreferencesShowFaxToGuestUsers,UserPreferencesShowStreetAddressToGuestUsers,UserPreferencesLightningExperiencePreferred,UserPreferencesPreviewLightning,UserPreferencesHideEndUserOnboardingAssistantModal,UserPreferencesHideLightningMigrationModal,UserPreferencesHideSfxWelcomeMat,UserPreferencesHideBiggerPhotoCallout,UserPreferencesGlobalNavBarWTShown,UserPreferencesGlobalNavGridMenuWTShown,UserPreferencesCreateLEXAppsWTShown,UserPreferencesFavoritesWTShown,DigestFrequency,DefaultGroupNotificationFrequency from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Contact> contact_Obj  =  [SELECT LastName,HasOptedOutOfEmail,Classification_Applicant__c,Classification_Student__c,Classfication_Withdrawn__c,Classification_Alumni__c,Classfication_Guest__c,Classfication_VIP__c,Classfication_Staff__c,Classfication_ExStaff__c,Classfication_Faculty__c,Classfication_ExFaculty__c,Classfication_FIL__c,Classfication_Vendor__c,Save_Withdrawal_Application__c,Cheque_Dispatch_Status__c,Student_Withdrawal_Completion__c,PhD__c,Classification_Visiting_Faculty__c,Classfication_Adjunct_Faculty__c,Send_Mass_Email__c,Unsubscribe_from_Mailers__c,hed__Deceased__c,hed__Do_Not_Contact__c,hed__Exclude_from_Household_Formal_Greeting__c,hed__Exclude_from_Household_Informal_Greeting__c,hed__Exclude_from_Household_Name__c,hed__FERPA__c,hed__Financial_Aid_Applicant__c,hed__HIPAA__c,hed__Military_Service__c,hed__is_Address_Override__c,Classification_Parent__c from Contact];
    System.assertEquals(true,contact_Obj.size()>0);
    PageReference pageRef = Page.UploadDocuments2_1;
    pageRef.getParameters().put('encResp','test');
    Test.setCurrentPage(pageRef);
    FUL_HousingPaymentcontroller obj01 = new FUL_HousingPaymentcontroller();
                obj01.paymentType = 'test data';
                obj01.scarchCardNo = 'test data';
                obj01.ddNumber = 'test data';
                obj01.ddDrwanBank = 'test data';
                obj01.bankBranch = 'test data';
                obj01.paidBy = 'test data';
                obj01.paymentErrorMsg = 'test data';
               
                obj01.oldPassword = 'test data';
                obj01.newPassword = 'test data';
                obj01.verifyNewPassword = 'test data';
                obj01.userApp = new Application__c();
                obj01.App = new Application__c();
                obj01.prog = new program__c();
                obj01.Enroll = new GD_and_PI_Round__c();
                obj01.IsPastDate = false;
                obj01.encResp = 'test data';
                obj01.HousingPayment();
                obj01.InsertHousingPaymentDetails('test data','test data','test data');
                obj01.HousingPaymento();
                obj01.SaveExitinhousingpay();
                System.Test.StopTest();
                
}
}