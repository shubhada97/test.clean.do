@istest
    Public class Careerservicesprofilecontroller_Test{
    static private user objuser;
    static private Account objAcc;
    static private Contact objCon;
    static private Contact_Education__c objedu ;
    static private CareerServicesProfile__c objprofile;
    Static private Attachment attach;
    Static private ContentVersion contentVersion;
    
    static void LoadData(){
    Createuser();
    createaccount();
    Createcontact();
    Createeducation();
    Createprofile();
    CreateAttachment();
    Createcase();
    
    }
    
    static void Createuser(){
    objuser = new user();
    Profile prof1 = [SELECT Id, Name FROM Profile  WHERE Name = 'System Administrator']; 
    objuser.FirstName = 'Daniel';
    objuser.LastName = 'Mason';
    objuser.Email = 'daniel.mason@schroders.com';
    objuser.Username = 'daniel.mason@schroders.com';
    objuser.Alias = 'DMaso';
    objuser.CommunityNickname = 'DMaso';
    objuser.TimeZoneSidKey = 'America/Los_Angeles';
    objuser.LocaleSidKey = 'en_US';
    objuser.EmailEncodingKey = 'UTF-8';
    objuser.ProfileId = prof1.Id;
    objuser.LanguageLocaleKey = 'en_US';
   // insert objuser;
    }
    
    static void Createaccount(){
    objAcc = new Account();
    objAcc.Name = 'TestAcc';
    insert objAcc;
    }
    
    static void Createcontact(){
    objCon = new Contact();
    objCon =  new Contact(LastName = 'LastName148');
    objCon.Accountid = objAcc.id;
    objCon.CVUE_Student_Number__c='01234';
    Insert objCon; 
    
    }
 
    static void Createeducation(){
    objedu = new Contact_Education__c();
    objedu = new Contact_Education__c(Contact__c = objCon.id);
    Insert objedu;
    }
    static void Createprofile(){
    objprofile = new CareerServicesProfile__c();
    objprofile.Contact__c = objCon.id;
    objprofile = new CareerServicesProfile__c(Submit__c = false);
    
    Insert objprofile; 
    
    }
    
    static void CreateAttachment(){
   
    attach=new Attachment();     
    attach.Name='Unit Test Attachment';
    Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    attach.body=bodyBlob;
    attach.ParentId = objprofile.id;
    insert attach;
    }
    
     static void Createcase(){  
    
    Case case_Obj = new Case();
    case_Obj.IsEscalated = false;
    case_Obj.IsStopped = false;
    case_Obj.VisualAntidote__Fast_Forms_Auto_Assign__c = false;
    case_Obj.VisualAntidote__Fast_Forms_Autoresponse__c = false;
    case_Obj.TRL_Round_Trip__c = false;
    case_Obj.Origin= 'Web';
    case_Obj.Status='New';
    case_Obj.Description = 'CaseDescription';
    case_Obj.ContactId= objCon.id;
    Id stExam = Schema.SObjectType.case.getRecordTypeInfosByName().get('Admission Support').getRecordTypeId();
    case_Obj.RecordtypeId = stExam;
    case_Obj.Subject= 'Contact Edit Request ' + 'StudentCvvNumber';
    System.assertEquals('01234', objCon.CVUE_Student_Number__c);
    
    
    test.startTest();
    insert case_Obj;
    test.stopTest();
    
   
    }
    
    @testSetup
    static void setup(){
        LoadData();
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contact con = new Contact(lastName='Test Contact',AccountId=acc.id);
       // insert con;
        
        ContentVersion cv = New ContentVersion();
        cv.PathOnClient = 'test';
        cv.Title = 'Profie Image';
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        
        ContentVersion tempContentVersion= [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id];
        
        ContentDocumentLink objCDL = new ContentDocumentLink(); 
        objCDL.ContentDocumentId = tempContentVersion.ContentDocumentId;
        objCDL.LinkedEntityId = con.Id;
        objCDL.ShareType = 'I';
       // insert objCDL; 
        }   
      @istest
      public Static void profile(){ 
     Contact con = [select Id,CVUE_Student_Number__c, Name from Contact limit 1];
        
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
       List<Contact> conList = [Select id, Name from contact Where id =: con.id];
        System.assertEquals(conList.size(),1);
         
        ContentVersion cv = New ContentVersion();
        cv.PathOnClient = 'test';
        cv.Title = 'Profie Image';
        cv.VersionData = EncodingUtil.base64Decode('Unit Test Attachment Body');
        
        
         Account Acc= new Account();
        Acc.name='TestAccount';
        insert Acc;
        
        contact contact = new contact();
        contact.AccountId =acc.id;
        contact.LastName='Testcontact';
       // insert contact;
        
        Contact_Education__c educon = new Contact_Education__c();
        educon.contact__c = contact.id;
        educon.Name ='test education';
       // insert educon;
         CareerServicesProfile__c carlist =[Select id,name from CareerServicesProfile__c limit 1];
        system.debug('>>>>>>>>>>>>>>>>>>>'+carlist.id);
        CareerServicesProfile__c csp = new CareerServicesProfile__c(Name='test data');
        insert csp;
        contact conObj = new contact();
       // conObj=[Select id,FirstName,LastName,Name from contact where id=:contact.id  limit 1];
       // system.debug('>>>>>>>>>>>>>>'+conobj.name);
        PageReference pagepdf = page.Flame_Career_profilepdf_page;
         pagepdf.getParameters().put('csp','carlist.id');
        Test.setCurrentPage(pagepdf);
 
        Attachment attach=new Attachment();
        Id parentId = ApexPages.currentPage().getParameters().put('ParentId', carlist.id);     
        attach.Name =  'Resume_'+ conObj.name +'_ '+date.today().format() +'.pdf';
        attach.Body = Blob.valueOf('UNIT.TEST');
        attach.parentId= parentId;
        attach.IsPrivate = false;
       // insert(attach);
         
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:carlist.id];
        System.assertEquals(1, attachments.size());
        
        PageReference pageRef = Page.Flame_Career_Profilepage;
        pageRef.getParameters().put('contactId','con.id');
        pageRef.getParameters().put('rid','con.id');
        Test.setCurrentPage(pageRef);
        
     List<Case> case_Obj  =  [SELECT BusinessHoursId,IsEscalated,IsStopped,VisualAntidote__Fast_Forms_Auto_Assign__c,VisualAntidote__Fast_Forms_Autoresponse__c,TRL_Round_Trip__c from Case];
    System.assertEquals(true,case_Obj.size()>0);
        
         System.runAs(portUser){
            Test.startTest();
            Flame_Careerservicesprofilecontroller up = new Flame_Careerservicesprofilecontroller();
            up.Requesttosend();
            up.eduFieldupdate();
            up.requesttoedit();
            up.showContent = false;
            up.showContent1 = false;
            up.showContent2 = false;
            up.contactId = con.id;
            up.reserList = new List<Flame_Careerservicesprofilecontroller.wrappercontact>();
            up.eduList = new List<Contact_Education__c>();
            up.educationList = new List<Flame_Careerservicesprofilecontroller.wrapperContactEducation>();
            up.eduListonlyrid = new List<Contact_Education__c>();
            up.educationListonlyrid = new List<Flame_Careerservicesprofilecontroller.wrapperContactEducation>();
            up.IsCreated = false;
            up.IsTicketDetials = false;
            up.fetchapplicationvalues();
            up.toggleContent1();
            up.rId = 'test data';
            up.urlId = 'test data';
            up.profileurl = 'test data';
            up.caseObject = new Case();
            up.Wrkdetls = new CareerServicesProfile__c();
            up.attachment = new Attachment();
            up.enterInputMode();
            up.toggleContent();
            up.getBtnDisabled();
            up.SaveAll();
            up.RequestEdit();
            up.RemovethirdContent();
            up.RemoveSecondContent();
            up.canclerequesttosend();
            up.popupsubmit();
            up.canclerequesttoedit();
            up.popupeducationsubmit();
            up.eduFieldupdate();
           // PageReference ref = up.downloadpdf();
            //up.attachmentobj();
            
            Contact cont = [select Id,CVUE_Student_Number__c, Name from Contact limit 1];
            String StudentCvvNumber= [Select CVUE_Student_Number__c  from Contact where id=: cont.id ].CVUE_Student_Number__c  ; 
            system.debug('>>>>>>>>>>>>>>'+StudentCvvNumber);
            Test.stopTest();
            }   
            
    }
    static Testmethod void TestWExample()
{
  Account Acc= new Account();
  Acc.name='TestAccount';
  insert Acc;
  
  contact con = new contact();
  con.AccountId =acc.id;
  con.LastName='Testcontact';
 // insert con;
  
  Contact_Education__c educon = new Contact_Education__c();
  educon.contact__c = con.id;
  educon.Name ='test education';
 // insert educon;
    
  Test.StartTest();
   list<WrapaccountTest> wrapaccountList= new  list<WrapaccountTest>();
    list<contact> SelectedcontactTest = new  list<contact>();
   for(contact conTest : [Select Id,FirstName,LastName,Gender__c,CVUE_Student_Number__c,Program_Interested_In__c,Father_s_First_Name__c,Permanent_Address_Line_1__c,
                Father_s_Last_Name__c,Father_s_Current_Company__c,Father_s_Email_ID__c,Father_s_Occupation__c,Father_s_Last_Company__c,Father_s_Designation__c,MobilePhone,Permanent_Address_Line_2__c,
                Email,DOB__c,First_year_CGPA__c,Mother_s_First_Name__c,Mother_s_Last_Name__c,Mother_s_Email_ID__c,Mother_s_Occupation__c,Permanent_Postal_Code__c,
                Mother_s_Current_Company__c,Mother_s_Designation__c,Portal_password__c,Date_of_Birth__c,Contact_Photo__c,Contact_Photo_Url__c
                From contact where id =:con.id limit 1]){
    wrapaccountList.add(new WrapaccountTest(conTest ));
   }
  ApexPages.StandardController sc = new ApexPages.StandardController(con);
  //Flame_Careerservicesprofilecontroller WE= new Flame_Careerservicesprofilecontroller();
 
  for(WrapaccountTest WATest :wrapaccountList)
  {
    WATest.Selected=true;
    Id ContactId = WATest.conn.id;
    if(WATest.Selected==true){
    SelectedcontactTest.add(WATest.conn);
    SelectedcontactTest[0].FirstName ='test data';
    }
    if(WATest.Selected1==true){
    SelectedcontactTest.add(WATest.conn);
    SelectedcontactTest[0].Gender__c ='test data';
    }
     if(WATest.Selected2==true){
    SelectedcontactTest.add(WATest.conn);
    SelectedcontactTest[0].CVUE_Student_Number__c ='test data';
    }
  }
  Flame_Careerservicesprofilecontroller.wrappercontact obj241 = new Flame_Careerservicesprofilecontroller.wrappercontact(new Contact());
    obj241.conn = con;
    obj241.Selected = false;
    obj241.Selected1 = false;
    obj241.Selected2 = false;
    obj241.Selected3 = false;
    obj241.Selected4 = false;
    obj241.Selected5 = false;
    obj241.Selected6 = false;
    obj241.Selected7 = false;
    obj241.Selected8 = false;
    obj241.Selected9 = false;
    obj241.Selected0 = false;
    obj241.Selected11 = false;
    obj241.Selected12 = false;
    obj241.Selected13 = false;
    obj241.Selected14 = false;
    obj241.Selected15 = false;
    obj241.Selected16 = false;
    obj241.Selected17 = false;
    obj241.Selected18 = false;
    obj241.Selected19 = false;
    obj241.Selected20 = false;
    obj241.Selected21 = false;
   
    
   /*---2---  */  
    list<WrapaeducationTest> wrapeducationList= new  list<WrapaeducationTest>();
    list<Contact_Education__c> SelectededucationTest = new  list<Contact_Education__c>();
   for(Contact_Education__c coneducationTest : [select Id,Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,
     Institution_Name__c,Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c where Contact__c=:con.id limit 1]){
    wrapeducationList.add(new WrapaeducationTest(coneducationTest));
   }
   for(Contact_Education__c coneducationTest1 : [select Id,Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,
     Institution_Name__c,Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c where id=:educon.id limit 1]){
    wrapeducationList.add(new WrapaeducationTest(coneducationTest1));
   } 
    
  //Flame_Careerservicesprofilecontroller WE= new Flame_Careerservicesprofilecontroller();
  //  WE.popupsubmit();
  //  WE.popupeducationsubmit();
  for(WrapaeducationTest WAETest :wrapeducationList)
  {
    WAETest.isEdit=true;
   
  }
  Flame_Careerservicesprofilecontroller.wrapperContactEducation obj244 = new Flame_Careerservicesprofilecontroller.wrapperContactEducation(new Contact_Education__c()); 
  obj244.edu = educon;
  obj244.isEdit=false;
  obj244.isEdit1=false;
  obj244.isEdit2=false;
  obj244.isEdit3=false;
  obj244.isEdit4=false;
  obj244.isEdit5=false;
  obj244.isEdit6=false;
  obj244.isEdit7=false;
  obj244.isEdit8=false;  
  obj244.isEdit9=false;  
  
    
  Test.StopTest();
  
}
  /*---1---  */ 
   Public class WrapaccountTest{
        public contact conn {get;set;}
        Public Boolean Selected {get;set;}
        Public Boolean Selected1 {get;set;}
        Public Boolean Selected2 {get;set;}
        Public Boolean Selected3 {get;set;}
        Public Boolean Selected4 {get;set;}
        Public Boolean Selected5 {get;set;}
        Public Boolean Selected6 {get;set;}
        Public Boolean Selected7 {get;set;}
        Public Boolean Selected8 {get;set;}
        Public Boolean Selected9 {get;set;}
        Public Boolean Selected0 {get;set;}
        Public Boolean Selected11 {get;set;}
        Public Boolean Selected12 {get;set;}
        Public Boolean Selected13 {get;set;}
        Public Boolean Selected14 {get;set;}
        Public Boolean Selected15 {get;set;}
        Public Boolean Selected16 {get;set;}
        Public Boolean Selected17 {get;set;}
        Public Boolean Selected18 {get;set;}
        Public Boolean Selected19 {get;set;}
        Public Boolean Selected20 {get;set;}
        Public Boolean Selected21 {get;set;}
    
        public WrapaccountTest(contact a)
        {
            this.conn=a;
            this.Selected=false;
            
        }
    
    }
     /*---2---  */
      Public class WrapaeducationTest{
        public Contact_Education__c edu {get;set;}
         public Boolean isEdit{get;set;}
        public Boolean isEdit1{get;set;}
        public Boolean isEdit2{get;set;}
        public Boolean isEdit3{get;set;}
        public Boolean isEdit4{get;set;}
        public Boolean isEdit5{get;set;}
        public Boolean isEdit6{get;set;}
        public Boolean isEdit7{get;set;}
        public Boolean isEdit8{get;set;}
        public Boolean isEdit9{get;set;}
       
        public WrapaeducationTest(Contact_Education__c e)
        {
            this.edu=e;
            this.isEdit=false;
            
        } 
    
    }

  static void setupTestData(){
    Account testAccount = new Account();
    testAccount.Name='Test Account' ;
   // insert testAccount;
    
    Contact cont = new Contact();
    cont.FirstName='Test';
    cont.LastName='Test';
    cont.Accountid= testAccount.id;
    cont.CVUE_Student_Number__c='01234';
    
    Contact_Education__c educon = new Contact_Education__c();
     educon.contact__c = cont.id;
     educon.Name ='test education';
  
    
    Case case_Obj = new Case();
    case_Obj.IsEscalated = false;
    case_Obj.IsStopped = false;
    case_Obj.VisualAntidote__Fast_Forms_Auto_Assign__c = false;
    case_Obj.VisualAntidote__Fast_Forms_Autoresponse__c = false;
    case_Obj.TRL_Round_Trip__c = false;
    case_Obj.Origin= 'Web';
    case_Obj.Status='New';
    case_Obj.Description = 'CaseDescription';
    case_Obj.ContactId= cont.id;
    Id stExam = Schema.SObjectType.case.getRecordTypeInfosByName().get('Data Update Request').getRecordTypeId();
    case_Obj.RecordtypeId = stExam;
    case_Obj.Subject= 'Contact Edit Request ' + 'StudentCvvNumber';
    System.assertEquals('01234', cont.CVUE_Student_Number__c);
    String StudentCvvNumber= [Select CVUE_Student_Number__c  from Contact where id=:  cont.id ].CVUE_Student_Number__c  ;
    System.assertEquals('StudentCvvNumber', cont.CVUE_Student_Number__c);
    test.startTest();
     insert testAccount;
     insert cont;
     Insert case_Obj;
     insert educon;
    test.stopTest();
  }
  static testMethod void test_insertcase_UseCase1(){
    List<Contact> contact_Obj  =  [SELECT LastName,CVUE_Student_Number__c from Contact   limit 1];
    System.assertEquals(true,contact_Obj.size()>0);
    List<Case> case_Obj  =  [SELECT BusinessHoursId,IsEscalated,IsStopped,VisualAntidote__Fast_Forms_Auto_Assign__c,VisualAntidote__Fast_Forms_Autoresponse__c,TRL_Round_Trip__c from Case];
    System.assertEquals(true,case_Obj.size()>0);
    Flame_Careerservicesprofilecontroller.insertcase(new list<String>(), '0030K00001oKtbl');
   }
       
  }