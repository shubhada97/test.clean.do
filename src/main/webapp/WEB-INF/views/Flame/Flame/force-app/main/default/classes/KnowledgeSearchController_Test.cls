@isTest
private class KnowledgeSearchController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Knowledge__kav knowledge_kav_Obj = new Knowledge__kav();
   // Insert knowledge_kav_Obj; 
    test.stopTest();
  }
  static testMethod void test_searchKnowledge_UseCase1(){
    List<Knowledge__kav> knowledge_kav_Obj  =  [SELECT id, ArticleNumber,Title,Summary,UrlName,Publisher_Name__c,Answer__c,Question__c from Knowledge__kav];
    System.assertEquals(false,knowledge_kav_Obj.size()>0);
    PageReference pageRef = Page.Knowledge_Search;
    pageRef.getParameters().put('Id','ka00T00000008VbQAI');
    pageRef.getParameters().put('id','ka00T00000008VbQAI');
    Test.setCurrentPage(pageRef);
    KnowledgeSearchController obj01 = new KnowledgeSearchController();
    obj01.articleList = new list<Knowledge__kav>();
    obj01.searchString = 'test data';
    obj01.showMessage = false;
    obj01.knowledgeTags = 'test data';
    obj01.KnowledgeArticle1 = new List<Knowledge__kav>();
    obj01.searchKnowledge();
  }
  static testMethod void test_NewKnowledgePage_UseCase1(){
    List<Knowledge__kav> knowledge_kav_Obj  =  [SELECT id, ArticleNumber,Title,Summary,UrlName,Publisher_Name__c,Answer__c,Question__c from Knowledge__kav];
    System.assertEquals(false,knowledge_kav_Obj.size()>0);
    PageReference pageRef = Page.Knowledge_Page;
    pageRef.getParameters().put('Id','ka00K000000VP4oQAG');
    pageRef.getParameters().put('id','ka00K000000VP4oQAG');
    Test.setCurrentPage(pageRef);
    KnowledgeSearchController obj01 = new KnowledgeSearchController();
    obj01.articleList = new list<Knowledge__kav>();
    obj01.searchString = 'test data';
    obj01.showMessage = false;
    obj01.knowledgeTags = 'test data';
    obj01.KnowledgeArticle1 = new List<Knowledge__kav>();
    obj01.NewKnowledgePage();
  }
  static testMethod void test_getKnowledgeArticle1_UseCase1(){
    List<Knowledge__kav> knowledge_kav_Obj  =  [SELECT id, ArticleNumber,Title,Summary,UrlName,Publisher_Name__c,Answer__c,Question__c from Knowledge__kav];
    System.assertEquals(false,knowledge_kav_Obj.size()>0);
    PageReference pageRef = Page.Knowledge_Search;
    pageRef.getParameters().put('Id','ka00K000000VP4oQAG');
    pageRef.getParameters().put('id','ka00K000000VP4oQAG');
    Test.setCurrentPage(pageRef);
    KnowledgeSearchController obj01 = new KnowledgeSearchController();
    obj01.articleList = new list<Knowledge__kav>();
    obj01.searchString = 'test data';
    obj01.showMessage = false;
    obj01.knowledgeTags = 'test data';
    obj01.KnowledgeArticle1 = new List<Knowledge__kav>();
    obj01.getKnowledgeArticle1();
  }
  static testMethod void test_getKnowledgeArticleVersion_UseCase1(){
    List<Knowledge__kav> knowledge_kav_Obj  =  [SELECT id, ArticleNumber,Title,Summary,UrlName,Publisher_Name__c,Answer__c,Question__c from Knowledge__kav];
    System.assertEquals(false,knowledge_kav_Obj.size()>0);
    PageReference pageRef = Page.Knowledge_Search;
    pageRef.getParameters().put('Id','ka00K000000VP4oQAG');
    pageRef.getParameters().put('id','ka00K000000VP4oQAG');
    Test.setCurrentPage(pageRef);
    KnowledgeSearchController obj01 = new KnowledgeSearchController();
    obj01.articleList = new list<Knowledge__kav>();
    obj01.searchString = 'test data';
    obj01.showMessage = false;
    obj01.knowledgeTags = 'test data';
    obj01.KnowledgeArticle1 = new List<Knowledge__kav>();
    obj01.getKnowledgeArticleVersion();
  }
}