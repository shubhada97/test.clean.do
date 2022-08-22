@isTest(SeeAllData=true)
Public class MyResearchcontroller_Test{
 static private Account objAcc;
 static private Contact objCon;
 static private Research__c research_Obj ;
 static private Attachment myfile;
 
   static testMethod void validateController() 
    {   
    
     CreateAccount();
     CreateContact();
     CreateResearch(); 
     createAttachment();
   
    Test.StartTest();
    
    List<Research__c> research_Obj  =  [SELECT Id,Name,RecordTypeId,Year_of_Publication__c,Publication_Category__c,Author_Name__c,Co_authors__c,Title_of_publication__c,Department__c,Name_of_journal_publisher__c,Volume__c,Issue__c,PP__c,FLAME_Author__c,Article_Book_URL__c,Rating_Claimed__c,Category_Claimed__c,Rewarded__c,Other_journal_publisher__c,Approved__c,Does_the_paper_have_atleast_one_author_w__c from Research__c];
    System.assertEquals(true,research_Obj.size()>0);
    Id id = ApexPages.currentPage().getParameters().get('editId') ;
    string id1 = ApexPages.currentPage().getParameters().get('research_Obj') ;
    PageReference pageRef = Page.MyResearchpage;
    pageRef.getParameters().put('Id','research_Obj');
    pageRef.getParameters().put('Id','01I0w0000000Moc');
    pageRef.getParameters().put('Id1','research_Obj');
    Test.setCurrentPage(pageRef);
    String fieldValue ='Test';
    
     MyResearchcontroller obj01 = new MyResearchcontroller();  
     System.assertEquals(null, obj01.fieldValue);        
     obj01.getResearchs();
     obj01.NewPublication(); 
    // obj01.saveCase(); 
     obj01.NewPublicationedit(); 
     obj01.getmyfile();
     obj01.NewPublicationedit();
     obj01.NewPublicationeditcont();
     obj01.getResearchss();
     obj01.editsave();
     obj01.popupsubmit();
     obj01.getyourBooleanVariable();
     obj01.passValueToController(); 
    // obj01.addHealth();
     Test.StopTest();
     
     } 
   
    
    
    
    static void CreateAccount()
    {
       objAcc = new Account();
       objAcc.Name = 'TestAcc';
     //  insert objAcc;
    }
    static void CreateContact()
    {
       objCon = new Contact();
       objCon.LastName = 'Test';
       objCon.Email = 'Test@gmail.com';
       objCon.AccountID = objAcc.Id;
     // insert objCon;
    } 
    
    
     
     
     static void CreateResearch()
     {
     PageReference pageRef = Page.MyResearchpage;
        Test.setCurrentPage(pageRef); 
        
      
            research_Obj = new Research__c();
            
            research_Obj.Author_Name__c = objCon.id;
            research_Obj.Article_Book_URL__c = 'www.google.com';
            research_Obj.Author_Name__c      = objCon.id;
            research_Obj.Co_authors__c       =  'test';
            research_Obj.Issue__c            = 'test';
            research_Obj.PP__c               = 'pages';
            research_Obj.Rating_Claimed__c   = 'R';
            research_Obj.Title_of_publication__c = 'project';
            research_Obj.Volume__c           = 'volume';
            research_Obj.Other_journal_publisher__c = 'test';
            research_Obj.Other_journal_publisher__c= 'test';
           // research_Obj.RecordTypeId ='0120K0000011Oau';   
 
   
   // insert research_Obj;
    List<Research__c> rech = new List<Research__c>();
    Research__c r = new Research__c();
     }
    
      
    static void createAttachment()
    {
   myfile = new Attachment();
   myfile.parentId =research_Obj.id;
   myfile.body =Blob.valueOf('UNIT.TEST');
   myfile.name ='file';
 //  insert  myfile; 
    }
    static testMethod void test_getResearchs_UseCase1(){
    List<Research__c> research_Obj  =  [SELECT Id,Name,RecordTypeId,Year_of_Publication__c,Publication_Category__c,Author_Name__c,Co_authors__c,Title_of_publication__c,Department__c,Name_of_journal_publisher__c,Volume__c,Issue__c,PP__c,FLAME_Author__c,Article_Book_URL__c,Rating_Claimed__c,Category_Claimed__c,Rewarded__c,Other_journal_publisher__c,Approved__c,Does_the_paper_have_atleast_one_author_w__c from Research__c];
    System.assertEquals(true,research_Obj.size()>0);
    PageReference pageRef = Page.MyResearchpage;
    list<Research__c> ctcList = new list<Research__c>();
        for(Research__c ctc: [select Id, RecordType.Name
                            from Research__c where
                            RecordType.Name= 'chapter']){
            ctcList.add(new Research__c(Id = ctc.Id));                  
        }
    pageRef.getParameters().put('editId','research_Obj');
    pageRef.getParameters().put('Id','research_Obj');
    pageRef.getParameters().put('fieldValue','01I0w0000000Moc');
    Test.setCurrentPage(pageRef);
    MyResearchcontroller obj01 = new MyResearchcontroller();
    obj01.contactId = 'test data';
    obj01.userDetails = new User();
    obj01.userContact = new Contact();
    obj01.IsCreated = false;
    obj01.IsTicketDetials = false;
    obj01.myfile = new Attachment();
    obj01.con = new contact();
    obj01.editId = 'test data';
    obj01.researchlist = research_Obj;
    obj01.selectedRT = 'test data';
    obj01.fieldValue = 'test data';
    //obj01.recordTypeId ='0120K0000011Oau';  
   }
                     
                            
}