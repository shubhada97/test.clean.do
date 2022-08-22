@isTest
private class FUA_ReviewApply_Controller_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    User user_Obj = new User(Username = 'TestUser6712420201017130501@codecoverage.com', LastName = 'LastName187', Email = 'Email22@test.com', EmailPreferencesAutoBcc = false, EmailPreferencesAutoBccStayInTouch = false, EmailPreferencesStayInTouchReminder = false, Alias = 'Alias626', CommunityNickname = 'cNickName30218', IsActive = true, TimeZoneSidKey = 'Pacific/Kiritimati', LocaleSidKey = 'sq_AL', ReceivesInfoEmails = false, ReceivesAdminInfoEmails = false, EmailEncodingKey = 'UTF-8', ProfileId = '00e280000015peNAAQ', LanguageLocaleKey = 'en_US', UserPermissionsMarketingUser = false, UserPermissionsOfflineUser = false, UserPermissionsAvantgoUser = false, UserPermissionsCallCenterAutoLogin = false, UserPermissionsMobileUser = false, UserPermissionsSFContentUser = false, UserPermissionsKnowledgeUser = false, UserPermissionsInteractionUser = false, UserPermissionsSupportUser = false, UserPermissionsChatterAnswersUser = false, ForecastEnabled = false, UserPreferencesActivityRemindersPopup = false, UserPreferencesEventRemindersCheckboxDefault = false, UserPreferencesTaskRemindersCheckboxDefault = false, UserPreferencesReminderSoundOff = false, UserPreferencesDisableAllFeedsEmail = false, UserPreferencesDisableFollowersEmail = false, UserPreferencesDisableProfilePostEmail = false, UserPreferencesDisableChangeCommentEmail = false, UserPreferencesDisableLaterCommentEmail = false, UserPreferencesDisProfPostCommentEmail = false, UserPreferencesApexPagesDeveloperMode = false, UserPreferencesHideCSNGetChatterMobileTask = false, UserPreferencesDisableMentionsPostEmail = false, UserPreferencesDisMentionsCommentEmail = false, UserPreferencesHideCSNDesktopTask = false, UserPreferencesHideChatterOnboardingSplash = false, UserPreferencesHideSecondChatterOnboardingSplash = false, UserPreferencesDisCommentAfterLikeEmail = false, UserPreferencesDisableLikeEmail = false, UserPreferencesSortFeedByComment = false, UserPreferencesDisableMessageEmail = false, UserPreferencesDisableBookmarkEmail = false, UserPreferencesDisableSharePostEmail = false, UserPreferencesEnableAutoSubForFeeds = false, UserPreferencesDisableFileShareNotificationsForApi = false, UserPreferencesShowTitleToExternalUsers = false, UserPreferencesShowManagerToExternalUsers = false, UserPreferencesShowEmailToExternalUsers = false, UserPreferencesShowWorkPhoneToExternalUsers = false, UserPreferencesShowMobilePhoneToExternalUsers = false, UserPreferencesShowFaxToExternalUsers = false, UserPreferencesShowStreetAddressToExternalUsers = false, UserPreferencesShowCityToExternalUsers = false, UserPreferencesShowStateToExternalUsers = false, UserPreferencesShowPostalCodeToExternalUsers = false, UserPreferencesShowCountryToExternalUsers = false, UserPreferencesShowProfilePicToGuestUsers = false, UserPreferencesShowTitleToGuestUsers = false, UserPreferencesShowCityToGuestUsers = false, UserPreferencesShowStateToGuestUsers = false, UserPreferencesShowPostalCodeToGuestUsers = false, UserPreferencesShowCountryToGuestUsers = false, UserPreferencesHideS1BrowserUI = false, UserPreferencesDisableEndorsementEmail = false, UserPreferencesPathAssistantCollapsed = false, UserPreferencesCacheDiagnostics = false, UserPreferencesShowEmailToGuestUsers = false, UserPreferencesShowManagerToGuestUsers = false, UserPreferencesShowWorkPhoneToGuestUsers = false, UserPreferencesShowMobilePhoneToGuestUsers = false, UserPreferencesShowFaxToGuestUsers = false, UserPreferencesShowStreetAddressToGuestUsers = false, UserPreferencesLightningExperiencePreferred = false, UserPreferencesPreviewLightning = false, UserPreferencesHideEndUserOnboardingAssistantModal = false, UserPreferencesHideLightningMigrationModal = false, UserPreferencesHideSfxWelcomeMat = false, UserPreferencesHideBiggerPhotoCallout = false, UserPreferencesGlobalNavBarWTShown = false, UserPreferencesGlobalNavGridMenuWTShown = false, UserPreferencesCreateLEXAppsWTShown = false, UserPreferencesFavoritesWTShown = false, DigestFrequency = 'D', DefaultGroupNotificationFrequency = 'P');
    Insert user_Obj; 
    Contact contact_Obj = new Contact(LastName = 'LastName420', HasOptedOutOfEmail = false, Classification_Applicant__c = false, Classification_Student__c = false, Classfication_Withdrawn__c = false, Classification_Alumni__c = false, Classfication_Guest__c = false, Classfication_VIP__c = false, Classfication_Staff__c = false, Classfication_ExStaff__c = false, Classfication_Faculty__c = false, Classfication_ExFaculty__c = false, Classfication_FIL__c = false, Classfication_Vendor__c = false, Save_Withdrawal_Application__c = false, Cheque_Dispatch_Status__c = false, Student_Withdrawal_Completion__c = false, PhD__c = false, Classification_Visiting_Faculty__c = false, Classfication_Adjunct_Faculty__c = false, Send_Mass_Email__c = false, Unsubscribe_from_Mailers__c = false, hed__Deceased__c = false, hed__Do_Not_Contact__c = false, hed__Exclude_from_Household_Formal_Greeting__c = false, hed__Exclude_from_Household_Informal_Greeting__c = false, hed__Exclude_from_Household_Name__c = false, hed__FERPA__c = false, hed__Financial_Aid_Applicant__c = false, hed__HIPAA__c = false, hed__Military_Service__c = false, hed__is_Address_Override__c = false, Classification_Parent__c = false);
    Insert contact_Obj; 
    test.stopTest();
  }
  static testMethod void test_saveAllData_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,Alias,CommunityNickname,IsActive,TimeZoneSidKey,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,LanguageLocaleKey,UserPermissionsMarketingUser,UserPermissionsOfflineUser,UserPermissionsAvantgoUser,UserPermissionsCallCenterAutoLogin,UserPermissionsMobileUser,UserPermissionsSFContentUser,UserPermissionsKnowledgeUser,UserPermissionsInteractionUser,UserPermissionsSupportUser,UserPermissionsChatterAnswersUser,ForecastEnabled,UserPreferencesActivityRemindersPopup,UserPreferencesEventRemindersCheckboxDefault,UserPreferencesTaskRemindersCheckboxDefault,UserPreferencesReminderSoundOff,UserPreferencesDisableAllFeedsEmail,UserPreferencesDisableFollowersEmail,UserPreferencesDisableProfilePostEmail,UserPreferencesDisableChangeCommentEmail,UserPreferencesDisableLaterCommentEmail,UserPreferencesDisProfPostCommentEmail,UserPreferencesApexPagesDeveloperMode,UserPreferencesHideCSNGetChatterMobileTask,UserPreferencesDisableMentionsPostEmail,UserPreferencesDisMentionsCommentEmail,UserPreferencesHideCSNDesktopTask,UserPreferencesHideChatterOnboardingSplash,UserPreferencesHideSecondChatterOnboardingSplash,UserPreferencesDisCommentAfterLikeEmail,UserPreferencesDisableLikeEmail,UserPreferencesSortFeedByComment,UserPreferencesDisableMessageEmail,UserPreferencesDisableBookmarkEmail,UserPreferencesDisableSharePostEmail,UserPreferencesEnableAutoSubForFeeds,UserPreferencesDisableFileShareNotificationsForApi,UserPreferencesShowTitleToExternalUsers,UserPreferencesShowManagerToExternalUsers,UserPreferencesShowEmailToExternalUsers,UserPreferencesShowWorkPhoneToExternalUsers,UserPreferencesShowMobilePhoneToExternalUsers,UserPreferencesShowFaxToExternalUsers,UserPreferencesShowStreetAddressToExternalUsers,UserPreferencesShowCityToExternalUsers,UserPreferencesShowStateToExternalUsers,UserPreferencesShowPostalCodeToExternalUsers,UserPreferencesShowCountryToExternalUsers,UserPreferencesShowProfilePicToGuestUsers,UserPreferencesShowTitleToGuestUsers,UserPreferencesShowCityToGuestUsers,UserPreferencesShowStateToGuestUsers,UserPreferencesShowPostalCodeToGuestUsers,UserPreferencesShowCountryToGuestUsers,UserPreferencesHideS1BrowserUI,UserPreferencesDisableEndorsementEmail,UserPreferencesPathAssistantCollapsed,UserPreferencesCacheDiagnostics,UserPreferencesShowEmailToGuestUsers,UserPreferencesShowManagerToGuestUsers,UserPreferencesShowWorkPhoneToGuestUsers,UserPreferencesShowMobilePhoneToGuestUsers,UserPreferencesShowFaxToGuestUsers,UserPreferencesShowStreetAddressToGuestUsers,UserPreferencesLightningExperiencePreferred,UserPreferencesPreviewLightning,UserPreferencesHideEndUserOnboardingAssistantModal,UserPreferencesHideLightningMigrationModal,UserPreferencesHideSfxWelcomeMat,UserPreferencesHideBiggerPhotoCallout,UserPreferencesGlobalNavBarWTShown,UserPreferencesGlobalNavGridMenuWTShown,UserPreferencesCreateLEXAppsWTShown,UserPreferencesFavoritesWTShown,DigestFrequency,DefaultGroupNotificationFrequency from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Contact> contact_Obj  =  [SELECT LastName,HasOptedOutOfEmail,Classification_Applicant__c,Classification_Student__c,Classfication_Withdrawn__c,Classification_Alumni__c,Classfication_Guest__c,Classfication_VIP__c,Classfication_Staff__c,Classfication_ExStaff__c,Classfication_Faculty__c,Classfication_ExFaculty__c,Classfication_FIL__c,Classfication_Vendor__c,Save_Withdrawal_Application__c,Cheque_Dispatch_Status__c,Student_Withdrawal_Completion__c,PhD__c,Classification_Visiting_Faculty__c,Classfication_Adjunct_Faculty__c,Send_Mass_Email__c,Unsubscribe_from_Mailers__c,hed__Deceased__c,hed__Do_Not_Contact__c,hed__Exclude_from_Household_Formal_Greeting__c,hed__Exclude_from_Household_Informal_Greeting__c,hed__Exclude_from_Household_Name__c,hed__FERPA__c,hed__Financial_Aid_Applicant__c,hed__HIPAA__c,hed__Military_Service__c,hed__is_Address_Override__c,Classification_Parent__c from Contact];
    System.assertEquals(true,contact_Obj.size()>0);
    PageReference pageRef = Page.PaymentGateway_1;
    pageRef.getParameters().put('Id','test');
    Test.setCurrentPage(pageRef);
    FUA_ReviewApply_Controller obj01 = new FUA_ReviewApply_Controller();
    obj01.UserID = user_Obj[0];
    obj01.apps = new Application__c();
    obj01.applicationList = new Application__c();
    obj01.contactList = contact_Obj[0];
    obj01.Con = contact_Obj[0];
    obj01.educationList = new List<FU_Education_Details__c>();
    obj01.SaveExit = 'test data';
    obj01.birthdateValue = 'test data';
    obj01.SubmissionDate = 'test data';
    obj01.workDetails = new list<FUA_Work_Details__c>();
    obj01.compExamDetails = new List<Competition_Exam_Details__c>();
    obj01.CED = new Competition_Exam_Details__c();
    obj01.CED1 = new Competition_Exam_Details__c();
    obj01.payment = new FUA_Payment__c();
    obj01.workDetailsPresent = false;
    obj01.EduDetailsPresent = false;
    obj01.compExamDetailsPresent = false;
    obj01.compExamDetailsPresent1 = false;
    obj01.compExamDetailsPresent2 = false;
    obj01.oldPassword = 'test data';
    obj01.newPassword = 'test data';
    obj01.verifyNewPassword = 'test data';
    obj01.ErrorMsg = 'test data';
    obj01.FatherCompany = 'test data';
    obj01.MotherCompany = 'test data';
    obj01.saveAllData();
  }
  static testMethod void test_FetchFields_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,Alias,CommunityNickname,IsActive,TimeZoneSidKey,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,LanguageLocaleKey,UserPermissionsMarketingUser,UserPermissionsOfflineUser,UserPermissionsAvantgoUser,UserPermissionsCallCenterAutoLogin,UserPermissionsMobileUser,UserPermissionsSFContentUser,UserPermissionsKnowledgeUser,UserPermissionsInteractionUser,UserPermissionsSupportUser,UserPermissionsChatterAnswersUser,ForecastEnabled,UserPreferencesActivityRemindersPopup,UserPreferencesEventRemindersCheckboxDefault,UserPreferencesTaskRemindersCheckboxDefault,UserPreferencesReminderSoundOff,UserPreferencesDisableAllFeedsEmail,UserPreferencesDisableFollowersEmail,UserPreferencesDisableProfilePostEmail,UserPreferencesDisableChangeCommentEmail,UserPreferencesDisableLaterCommentEmail,UserPreferencesDisProfPostCommentEmail,UserPreferencesApexPagesDeveloperMode,UserPreferencesHideCSNGetChatterMobileTask,UserPreferencesDisableMentionsPostEmail,UserPreferencesDisMentionsCommentEmail,UserPreferencesHideCSNDesktopTask,UserPreferencesHideChatterOnboardingSplash,UserPreferencesHideSecondChatterOnboardingSplash,UserPreferencesDisCommentAfterLikeEmail,UserPreferencesDisableLikeEmail,UserPreferencesSortFeedByComment,UserPreferencesDisableMessageEmail,UserPreferencesDisableBookmarkEmail,UserPreferencesDisableSharePostEmail,UserPreferencesEnableAutoSubForFeeds,UserPreferencesDisableFileShareNotificationsForApi,UserPreferencesShowTitleToExternalUsers,UserPreferencesShowManagerToExternalUsers,UserPreferencesShowEmailToExternalUsers,UserPreferencesShowWorkPhoneToExternalUsers,UserPreferencesShowMobilePhoneToExternalUsers,UserPreferencesShowFaxToExternalUsers,UserPreferencesShowStreetAddressToExternalUsers,UserPreferencesShowCityToExternalUsers,UserPreferencesShowStateToExternalUsers,UserPreferencesShowPostalCodeToExternalUsers,UserPreferencesShowCountryToExternalUsers,UserPreferencesShowProfilePicToGuestUsers,UserPreferencesShowTitleToGuestUsers,UserPreferencesShowCityToGuestUsers,UserPreferencesShowStateToGuestUsers,UserPreferencesShowPostalCodeToGuestUsers,UserPreferencesShowCountryToGuestUsers,UserPreferencesHideS1BrowserUI,UserPreferencesDisableEndorsementEmail,UserPreferencesPathAssistantCollapsed,UserPreferencesCacheDiagnostics,UserPreferencesShowEmailToGuestUsers,UserPreferencesShowManagerToGuestUsers,UserPreferencesShowWorkPhoneToGuestUsers,UserPreferencesShowMobilePhoneToGuestUsers,UserPreferencesShowFaxToGuestUsers,UserPreferencesShowStreetAddressToGuestUsers,UserPreferencesLightningExperiencePreferred,UserPreferencesPreviewLightning,UserPreferencesHideEndUserOnboardingAssistantModal,UserPreferencesHideLightningMigrationModal,UserPreferencesHideSfxWelcomeMat,UserPreferencesHideBiggerPhotoCallout,UserPreferencesGlobalNavBarWTShown,UserPreferencesGlobalNavGridMenuWTShown,UserPreferencesCreateLEXAppsWTShown,UserPreferencesFavoritesWTShown,DigestFrequency,DefaultGroupNotificationFrequency from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Contact> contact_Obj  =  [SELECT LastName,HasOptedOutOfEmail,Classification_Applicant__c,Classification_Student__c,Classfication_Withdrawn__c,Classification_Alumni__c,Classfication_Guest__c,Classfication_VIP__c,Classfication_Staff__c,Classfication_ExStaff__c,Classfication_Faculty__c,Classfication_ExFaculty__c,Classfication_FIL__c,Classfication_Vendor__c,Save_Withdrawal_Application__c,Cheque_Dispatch_Status__c,Student_Withdrawal_Completion__c,PhD__c,Classification_Visiting_Faculty__c,Classfication_Adjunct_Faculty__c,Send_Mass_Email__c,Unsubscribe_from_Mailers__c,hed__Deceased__c,hed__Do_Not_Contact__c,hed__Exclude_from_Household_Formal_Greeting__c,hed__Exclude_from_Household_Informal_Greeting__c,hed__Exclude_from_Household_Name__c,hed__FERPA__c,hed__Financial_Aid_Applicant__c,hed__HIPAA__c,hed__Military_Service__c,hed__is_Address_Override__c,Classification_Parent__c from Contact];
    System.assertEquals(true,contact_Obj.size()>0);
    PageReference pageRef = Page.PaymentGateway_1;
    pageRef.getParameters().put('Id','test');
    Test.setCurrentPage(pageRef);
    FUA_ReviewApply_Controller obj01 = new FUA_ReviewApply_Controller();
    obj01.UserID = user_Obj[0];
    obj01.apps = new Application__c();
    obj01.applicationList = new Application__c();
    obj01.contactList = contact_Obj[0];
    obj01.Con = contact_Obj[0];
    obj01.educationList = new List<FU_Education_Details__c>();
    obj01.SaveExit = 'test data';
    obj01.birthdateValue = 'test data';
    obj01.SubmissionDate = 'test data';
    obj01.workDetails = new list<FUA_Work_Details__c>();
    obj01.compExamDetails = new List<Competition_Exam_Details__c>();
    obj01.CED = new Competition_Exam_Details__c();
    obj01.CED1 = new Competition_Exam_Details__c();
    obj01.payment = new FUA_Payment__c();
    obj01.workDetailsPresent = false;
    obj01.EduDetailsPresent = false;
    obj01.compExamDetailsPresent = false;
    obj01.compExamDetailsPresent1 = false;
    obj01.compExamDetailsPresent2 = false;
    obj01.oldPassword = 'test data';
    obj01.newPassword = 'test data';
    obj01.verifyNewPassword = 'test data';
    obj01.ErrorMsg = 'test data';
    obj01.FatherCompany = 'test data';
    obj01.MotherCompany = 'test data';
    obj01.FetchFields();
  }
  static testMethod void test_saveData_UseCase1(){
    List<User> user_Obj  =  [SELECT Username,LastName,Email,EmailPreferencesAutoBcc,EmailPreferencesAutoBccStayInTouch,EmailPreferencesStayInTouchReminder,Alias,CommunityNickname,IsActive,TimeZoneSidKey,LocaleSidKey,ReceivesInfoEmails,ReceivesAdminInfoEmails,EmailEncodingKey,ProfileId,LanguageLocaleKey,UserPermissionsMarketingUser,UserPermissionsOfflineUser,UserPermissionsAvantgoUser,UserPermissionsCallCenterAutoLogin,UserPermissionsMobileUser,UserPermissionsSFContentUser,UserPermissionsKnowledgeUser,UserPermissionsInteractionUser,UserPermissionsSupportUser,UserPermissionsChatterAnswersUser,ForecastEnabled,UserPreferencesActivityRemindersPopup,UserPreferencesEventRemindersCheckboxDefault,UserPreferencesTaskRemindersCheckboxDefault,UserPreferencesReminderSoundOff,UserPreferencesDisableAllFeedsEmail,UserPreferencesDisableFollowersEmail,UserPreferencesDisableProfilePostEmail,UserPreferencesDisableChangeCommentEmail,UserPreferencesDisableLaterCommentEmail,UserPreferencesDisProfPostCommentEmail,UserPreferencesApexPagesDeveloperMode,UserPreferencesHideCSNGetChatterMobileTask,UserPreferencesDisableMentionsPostEmail,UserPreferencesDisMentionsCommentEmail,UserPreferencesHideCSNDesktopTask,UserPreferencesHideChatterOnboardingSplash,UserPreferencesHideSecondChatterOnboardingSplash,UserPreferencesDisCommentAfterLikeEmail,UserPreferencesDisableLikeEmail,UserPreferencesSortFeedByComment,UserPreferencesDisableMessageEmail,UserPreferencesDisableBookmarkEmail,UserPreferencesDisableSharePostEmail,UserPreferencesEnableAutoSubForFeeds,UserPreferencesDisableFileShareNotificationsForApi,UserPreferencesShowTitleToExternalUsers,UserPreferencesShowManagerToExternalUsers,UserPreferencesShowEmailToExternalUsers,UserPreferencesShowWorkPhoneToExternalUsers,UserPreferencesShowMobilePhoneToExternalUsers,UserPreferencesShowFaxToExternalUsers,UserPreferencesShowStreetAddressToExternalUsers,UserPreferencesShowCityToExternalUsers,UserPreferencesShowStateToExternalUsers,UserPreferencesShowPostalCodeToExternalUsers,UserPreferencesShowCountryToExternalUsers,UserPreferencesShowProfilePicToGuestUsers,UserPreferencesShowTitleToGuestUsers,UserPreferencesShowCityToGuestUsers,UserPreferencesShowStateToGuestUsers,UserPreferencesShowPostalCodeToGuestUsers,UserPreferencesShowCountryToGuestUsers,UserPreferencesHideS1BrowserUI,UserPreferencesDisableEndorsementEmail,UserPreferencesPathAssistantCollapsed,UserPreferencesCacheDiagnostics,UserPreferencesShowEmailToGuestUsers,UserPreferencesShowManagerToGuestUsers,UserPreferencesShowWorkPhoneToGuestUsers,UserPreferencesShowMobilePhoneToGuestUsers,UserPreferencesShowFaxToGuestUsers,UserPreferencesShowStreetAddressToGuestUsers,UserPreferencesLightningExperiencePreferred,UserPreferencesPreviewLightning,UserPreferencesHideEndUserOnboardingAssistantModal,UserPreferencesHideLightningMigrationModal,UserPreferencesHideSfxWelcomeMat,UserPreferencesHideBiggerPhotoCallout,UserPreferencesGlobalNavBarWTShown,UserPreferencesGlobalNavGridMenuWTShown,UserPreferencesCreateLEXAppsWTShown,UserPreferencesFavoritesWTShown,DigestFrequency,DefaultGroupNotificationFrequency from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Contact> contact_Obj  =  [SELECT LastName,HasOptedOutOfEmail,Classification_Applicant__c,Classification_Student__c,Classfication_Withdrawn__c,Classification_Alumni__c,Classfication_Guest__c,Classfication_VIP__c,Classfication_Staff__c,Classfication_ExStaff__c,Classfication_Faculty__c,Classfication_ExFaculty__c,Classfication_FIL__c,Classfication_Vendor__c,Save_Withdrawal_Application__c,Cheque_Dispatch_Status__c,Student_Withdrawal_Completion__c,PhD__c,Classification_Visiting_Faculty__c,Classfication_Adjunct_Faculty__c,Send_Mass_Email__c,Unsubscribe_from_Mailers__c,hed__Deceased__c,hed__Do_Not_Contact__c,hed__Exclude_from_Household_Formal_Greeting__c,hed__Exclude_from_Household_Informal_Greeting__c,hed__Exclude_from_Household_Name__c,hed__FERPA__c,hed__Financial_Aid_Applicant__c,hed__HIPAA__c,hed__Military_Service__c,hed__is_Address_Override__c,Classification_Parent__c from Contact];
    System.assertEquals(true,contact_Obj.size()>0);
    PageReference pageRef = Page.PaymentGateway_1;
    pageRef.getParameters().put('Id','test');
    Test.setCurrentPage(pageRef);
    FUA_ReviewApply_Controller obj01 = new FUA_ReviewApply_Controller();
    obj01.UserID = user_Obj[0];
    obj01.apps = new Application__c();
    obj01.applicationList = new Application__c();
    obj01.contactList = contact_Obj[0];
    obj01.Con = contact_Obj[0];
    obj01.educationList = new List<FU_Education_Details__c>();
    obj01.SaveExit = 'test data';
    obj01.birthdateValue = 'test data';
    obj01.SubmissionDate = 'test data';
    obj01.workDetails = new list<FUA_Work_Details__c>();
    obj01.compExamDetails = new List<Competition_Exam_Details__c>();
    obj01.CED = new Competition_Exam_Details__c();
    obj01.CED1 = new Competition_Exam_Details__c();
    obj01.payment = new FUA_Payment__c();
    obj01.workDetailsPresent = false;
    obj01.EduDetailsPresent = false;
    obj01.compExamDetailsPresent = false;
    obj01.compExamDetailsPresent1 = false;
    obj01.compExamDetailsPresent2 = false;
    obj01.oldPassword = 'test data';
    obj01.newPassword = 'test data';
    obj01.verifyNewPassword = 'test data';
    obj01.ErrorMsg = 'test data';
    obj01.FatherCompany = 'test data';
    obj01.MotherCompany = 'test data';
    obj01.saveData();
  }
}