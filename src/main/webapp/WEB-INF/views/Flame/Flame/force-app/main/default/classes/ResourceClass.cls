public with sharing class ResourceClass {
    @AuraEnabled(Cacheable = true)
    public static list<String> searchKnowledge(String Knowbase) {
        list<String> titleList =new list<String>();
        Knowbase = '%' + Knowbase + '%';
        list<Knowledge__kav> kb = [Select id,Title from Knowledge__kav where Title LIKE :Knowbase];

        for(Knowledge__kav kv : kb){
            titleList.add(kv.Title);
        }

      return titleList;
    }
}