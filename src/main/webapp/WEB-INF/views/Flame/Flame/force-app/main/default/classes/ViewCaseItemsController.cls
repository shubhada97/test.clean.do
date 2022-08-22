public without sharing class ViewCaseItemsController {
    
    public list<Item__c> lstofItems{get;set;}
    public list<Itemswrapper> ItemswrapperList{get;set;}    
    public string strCaseid;
    public string RecordId;
    public Boolean isEdit{get;set;}
    public Boolean isSave{get;set;}
    public list<Case> lstofcase{get;set;}
    public Integer counter{get;set;}
     
    public ViewCaseItemsController(){
        isEdit = true;
        isSave = true;
        lstofItems = new list<Item__c>(); 
        ItemswrapperList = new list<Itemswrapper>();
        strCaseid = ApexPages.currentPage().getParameters().get('caseid');
        if(strCaseid !=null || strCaseid !=''){
            lstofcase = [Select Id,Contactid,Contact.Name,Case_Approval_Status__c ,Contact.Faculty__c,Contact.Email,Contact.MobilePhone,BR_TYPE__c,BR_COURSE__c,BR_Number_of_Students__c,CreatedDate from    Case where ID =:strCaseid limit 1];
      
           for(Item__c objItem :[Select Id,S_No__c,BR_Title__c,BR_Author__c,BR_Availability__c,BR_Publisher__c,BR_Year_Ed__c,BR_ISBN__c,Quantity__c,
                                  BR_Final_Qty__c , BR_Required_Copies__c,BR_Total_Value__c,BR_In_Flame__c,Total_Value__c,Unit_Price__c,BR_Price_Per_Copy__c,Case__c from Item__c where Case__c =:strCaseid] ){
               Itemswrapper itemsWrap = new Itemswrapper(objItem); 
               ItemswrapperList.add(itemsWrap); 
               
           }
        }  
       
    }
    public void isEditRecords(){
        isEdit = false;
        isSave = false;
    }
    
    
    
    public PageReference saveRecords(){
        
        list<Item__c> updatelstofItems;
        updatelstofItems = new list<Item__c>();
        system.debug('ItemswrapperList@@@@'+ItemswrapperList);
        if(!ItemswrapperList.isEmpty()){
            for(Itemswrapper Itemswrapper:ItemswrapperList){
                updatelstofItems.add(Itemswrapper.item);
            }
        }
         system.debug('updatelstofItems@@@@'+updatelstofItems);
        if(!updatelstofItems.isEmpty()){
            upsert updatelstofItems;
            isEdit =true;
            isSave =true;
        }
        
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Info,'Record Saved Successfully.');
       ApexPages.addMessage(myMsg); 
        return null;
    }
    
    public class Itemswrapper{
        public Item__c item{get;set;}
        public Integer counterWrap{get;set;}
        
        public Itemswrapper(Item__c item){
            this.item = item;  
             
        }
    }
    
    public PageReference removingRow(){
    
        Integer param = Integer.valueOf(Apexpages.currentpage().getParameters().get('index'));
        
        for(Integer i=0;i<ItemswrapperList.size();i++){
            if(ItemswrapperList[i].counterWrap == param ){
                ItemswrapperList.remove(i);     
            }
        }
        
        
        counter--;
        return null;    
    }
    
    public PageReference sumbitForApproval(){
  
     Case objCase = new Case(Id = strCaseid);
        objCase.Case_Approval_Status__c = 'Pending';
        update objCase;
        return null;
   }

public PageReference redirect()
{
   PageReference pr = new PageReference('/apex/FacultyCaseItem');
   return pr;
}

}