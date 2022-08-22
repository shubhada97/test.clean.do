public class FacultyCaseItemController {
    public list<case> lstofcase{get;set;}
    public list<Item__c> lstofItems;
    public set<id> setofCaseId;
    public ID caseRecordTypeId;
    public FacultyCaseItemController(){
        setofCaseId =new set<id>();
         caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Book Requisition').getRecordTypeId();
        lstofItems = new list<Item__c>();
        lstofItems =[Select id,Case__c from Item__c];
        if(!lstofItems.isEmpty()){
            for(Item__c objItem:lstofItems){
                setofCaseId.add(objItem.Case__c);
            }
        }
        if(!setofCaseId.isEmpty()){
          lstofcase = [Select Id,ContactID,contact.Name,Case_Approval_Status__c,Status,CaseNumber from Case where ID IN:setofCaseId and RecordTypeID =:caseRecordTypeId and  ContactID !=null];
        }
    
    }
    
}