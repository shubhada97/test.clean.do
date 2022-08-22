public with sharing class KnowledgebaseClass {
    @AuraEnabled(cacheable=true)
    public static list<Knowledge__kav> knowledge() {
        list<Knowledge__kav> kn = [Select id,Title from Knowledge__kav Limit 8];
        return kn;
    }
}