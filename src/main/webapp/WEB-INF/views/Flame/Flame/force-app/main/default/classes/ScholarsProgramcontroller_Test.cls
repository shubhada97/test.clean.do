@isTest
private class ScholarsProgramcontroller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    User user_Obj = new User(Username = 'TestUser1415320200213150509@codecoverage.com', LastName = 'LastName144', Email = 'Email22@test.com', EmailPreferencesAutoBcc = false, EmailPreferencesAutoBccStayInTouch = false, EmailPreferencesStayInTouchReminder = false, Alias = 'Alias876', CommunityNickname = 'cNickName30680', TimeZoneSidKey = 'Pacific/Kiritimati', LocaleSidKey = 'sq_AL', ReceivesInfoEmails = false, ReceivesAdminInfoEmails = false, EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', UserPermissionsMarketingUser = false, UserPermissionsOfflineUser = false, UserPermissionsAvantgoUser = false, UserPermissionsCallCenterAutoLogin = false, UserPermissionsMobileUser = false, UserPermissionsSFContentUser = false, UserPermissionsKnowledgeUser = false, UserPermissionsInteractionUser = false, UserPermissionsSupportUser = false, UserPermissionsChatterAnswersUser = false, ForecastEnabled = false, UserPreferencesActivityRemindersPopup = false, UserPreferencesEventRemindersCheckboxDefault = false, UserPreferencesTaskRemindersCheckboxDefault = false, UserPreferencesReminderSoundOff = false, UserPreferencesDisableAllFeedsEmail = false, UserPreferencesDisableFollowersEmail = false, UserPreferencesDisableProfilePostEmail = false, UserPreferencesDisableChangeCommentEmail = false, UserPreferencesDisableLaterCommentEmail = false, UserPreferencesDisProfPostCommentEmail = false, UserPreferencesApexPagesDeveloperMode = false, UserPreferencesHideCSNGetChatterMobileTask = false, UserPreferencesDisableMentionsPostEmail = false, UserPreferencesDisMentionsCommentEmail = false, UserPreferencesHideCSNDesktopTask = false, UserPreferencesHideChatterOnboardingSplash = false, UserPreferencesHideSecondChatterOnboardingSplash = false, UserPreferencesDisCommentAfterLikeEmail = false, UserPreferencesDisableLikeEmail = false, UserPreferencesSortFeedByComment = false, UserPreferencesDisableMessageEmail = false, UserPreferencesDisableBookmarkEmail = false, UserPreferencesDisableSharePostEmail = false, UserPreferencesEnableAutoSubForFeeds = false, UserPreferencesDisableFileShareNotificationsForApi = false, UserPreferencesShowTitleToExternalUsers = false, UserPreferencesShowManagerToExternalUsers = false, UserPreferencesShowEmailToExternalUsers = false, UserPreferencesShowWorkPhoneToExternalUsers = false, UserPreferencesShowMobilePhoneToExternalUsers = false, UserPreferencesShowFaxToExternalUsers = false, UserPreferencesShowStreetAddressToExternalUsers = false, UserPreferencesShowCityToExternalUsers = false, UserPreferencesShowStateToExternalUsers = false, UserPreferencesShowPostalCodeToExternalUsers = false, UserPreferencesShowCountryToExternalUsers = false, UserPreferencesShowProfilePicToGuestUsers = false, UserPreferencesShowTitleToGuestUsers = false, UserPreferencesShowCityToGuestUsers = false, UserPreferencesShowStateToGuestUsers = false, UserPreferencesShowPostalCodeToGuestUsers = false, UserPreferencesShowCountryToGuestUsers = false, UserPreferencesHideS1BrowserUI = false, UserPreferencesDisableEndorsementEmail = false, UserPreferencesPathAssistantCollapsed = false, UserPreferencesCacheDiagnostics = false, UserPreferencesShowEmailToGuestUsers = false, UserPreferencesShowManagerToGuestUsers = false, UserPreferencesShowWorkPhoneToGuestUsers = false, UserPreferencesShowMobilePhoneToGuestUsers = false, UserPreferencesShowFaxToGuestUsers = false, UserPreferencesShowStreetAddressToGuestUsers = false, UserPreferencesLightningExperiencePreferred = false, UserPreferencesPreviewLightning = false, UserPreferencesHideEndUserOnboardingAssistantModal = false, UserPreferencesHideLightningMigrationModal = false, UserPreferencesHideSfxWelcomeMat = false, UserPreferencesHideBiggerPhotoCallout = false, UserPreferencesGlobalNavBarWTShown = false, UserPreferencesGlobalNavGridMenuWTShown = false, UserPreferencesCreateLEXAppsWTShown = false, UserPreferencesFavoritesWTShown = false, DigestFrequency = 'D', DefaultGroupNotificationFrequency = 'P');
   // Insert user_Obj; 
    Application__c application_Obj = new Application__c(Admitted__c = false, FLAME_Entrance_Aptitude_Test_FEAT__c = false, FUA_All_Documents_Verified__c = false, FUA_Broadcast_Admission__c = false, FUA_SOP_Submitted__c = false, Median__c = false, SAT_Score__c = false, Enrollment_Deposit_Amount_Paid__c = false, FLM_Accepetoffer__c = false, FLM_Declineoffer__c = false, Housing_Preference_Submitted__c = false, Preference_Housing_Payment_Recived__c = false, Semester_1Fee_Paid__c = false, Semester_2Fee_Paid__c = false, ACT_score__c = false);
   // Insert application_Obj; 
    test.stopTest();
  }
  static testMethod void test_ScholarsProgramcontroller_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,UserPreferencesHideSecondChatterOnboardingSplash from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Application__c> application_Obj  =  [SELECT Name from Application__c];
    System.assertEquals(false,application_Obj.size()>0);
    ScholarsProgramcontroller obj01 = new ScholarsProgramcontroller();
    obj01.userDetails = user_Obj[0];
    obj01.userContact = new Contact();
    //obj01.app = application_Obj[0];
    obj01.contactId = 'test data';
   // obj01.ScholarsProgramcontroller();
  }
  static testMethod void test_applylink_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,UserPreferencesHideSecondChatterOnboardingSplash from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Application__c> application_Obj  =  [SELECT Name from Application__c];
    System.assertEquals(false,application_Obj.size()>0);
    ScholarsProgramcontroller obj01 = new ScholarsProgramcontroller();
    obj01.userDetails = user_Obj[0];
    obj01.userContact = new Contact();
   // obj01.app = application_Obj[0];
    obj01.contactId = 'test data';
   // obj01.applylink();
  }
  static testMethod void test_downloadpdf_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,UserPreferencesHideSecondChatterOnboardingSplash from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Application__c> application_Obj  =  [SELECT Name from Application__c];
    System.assertEquals(false,application_Obj.size()>0);
    ScholarsProgramcontroller obj01 = new ScholarsProgramcontroller();
    obj01.userDetails = user_Obj[0];
    obj01.userContact = new Contact();
  //  obj01.app = application_Obj[0];
    obj01.contactId = 'test data';
    obj01.downloadpdf();
  }
}