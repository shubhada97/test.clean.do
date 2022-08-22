@isTest
private class KnowledgeSearchControllerTest{
    static testMethod void validateSaveMethod() 
    {  
        KnowledgeSearchController objK = new KnowledgeSearchController();
        objK.searchString = 'test';
        String articleTitle = 'Test Article';
        String articleBody = 'Test Body';
        String articleUrlName = 'test';
        String language = 'en_US';

        Knowledge__kav article = new Knowledge__kav(
            Title = articleTitle,
            Summary = articleBody,
            UrlName = articleUrlName,
            Language = language
        );

        insert article;
        objK.searchKnowledge();
        
    }
    
}