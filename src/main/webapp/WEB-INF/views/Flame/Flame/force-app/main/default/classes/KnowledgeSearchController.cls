public with sharing class KnowledgeSearchController {
    
    public list<Knowledge__kav> articleList {get;set;}
    public string searchString{get;set;}
    public boolean showMessage{get;set;}
    public string knowledgeTags{get;set;}
    Public String editId {get;set;}
    Public List<Knowledge__kav> KnowledgeArticle1;
    public list<KnowledgeArticleVersion> KnowledgeArticleVersion ;
    public Knowledge__kav fieldName {get;set;}
    
    public KnowledgeSearchController() {
        articleList  = new list<Knowledge__kav>();
        showMessage = false;
        Id id = ApexPages.currentPage().getParameters().get('Id') ; 
        system.debug('id'+id);
        fieldName = new Knowledge__kav();
        
        
        
    }
    
    
   
    public void searchKnowledge(){
        
        Id profileId=userinfo.getProfileId();
        System.debug('profileId-->'+profileId);
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        System.debug('ProfileName'+profileName);
        
        final String PUBLISH_STATUS_ONLINE = 'Online';
        
        //  String Inputfield = Knowledge__kav.Answer__c;
        
        //  Inputfield = Inputfield.replaceAll('<[/a-zAZ0-9]*>','');
        articleList.clear();
        for(Knowledge__kav knowledge : [SELECT Id, title,Role__c, UrlName,ArticleNumber,LastPublishedDate,LastModifiedById,ArchivedDate,ArticleCreatedDate,CreatedById,Answer__c,Question__c FROM Knowledge__kav  WHERE PublishStatus = :PUBLISH_STATUS_ONLINE   AND Role__c includes ( : Flame_CommunityUserInfo.profileName )]) {
            
            if(knowledge.title != null && knowledge.title !='' && knowledge.Answer__c != null && knowledge.Answer__c !='' && knowledge.Question__c != null && knowledge.Question__c !=''){
                
                if(knowledge.title.containsIgnoreCase(searchString) || knowledge.Answer__c.containsIgnoreCase(searchString) || knowledge.Question__c.containsIgnoreCase(searchString)) {
                    articleList.add(knowledge);
                    
                }
            }
            
        }
        
        
        
        system.debug('articleList-->'+articleList);
        if(articleList.size()==0){
            showMessage = true;
        }
        else{
            showMessage  = false;
        }
        
    }
    // press  clik on the articel name to redirect to the next page.
    public  PageReference NewKnowledgePage() {
        pagereference ApplyPage = new PageReference('/apex/Knowledge_Page?id='+ editId);
        ApplyPage.setRedirect(true);          
        return ApplyPage;               
    }
    // this is child object for  Knowledge__kav details   
    public List<Knowledge__kav> getKnowledgeArticle1() {
        Id id = ApexPages.currentPage().getParameters().get('id') ; 
        system.debug('id'+id);
        if(KnowledgeArticle1 == null)
            KnowledgeArticle1 = [SELECT id, ArticleNumber,Title,Role__c,Summary,UrlName,Publisher_Name__c,Answer__c,Question__c FROM Knowledge__kav Where PublishStatus='Online' and Language = 'en_US'and Role__c includes ( : Flame_CommunityUserInfo.profileName ) and ID=:Id];
        system.debug('<<<<<<<<<<<<<<<<<'+KnowledgeArticle1);
        
        
        return KnowledgeArticle1;
    } 
    // this is object called  KnowledgeArticleVersion details      
    public List<KnowledgeArticleVersion> getKnowledgeArticleVersion() {
        Id id = ApexPages.currentPage().getParameters().get('id') ; 
        system.debug('id'+id);
        KnowledgeArticleVersion=[SELECT Id, title, UrlName,LastPublishedDate,LastModifiedById,ArchivedDate,ArticleCreatedDate,CreatedById FROM KnowledgeArticleVersion where id=:id];
        system.debug('id>>>>>>>>>>>>>>>>>>'+KnowledgeArticleVersion);
        return KnowledgeArticleVersion;
    }
    
    
}