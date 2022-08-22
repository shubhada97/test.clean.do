@isTest
private class ViewCaseItemsControllerTest{

    static private Case objCase;
    static private Item__c objItem;
    
    static void LoadData() 
    {
        CreateCase();
        CreateItem();
    }
    static testMethod void validateRecords() 
    {   
        LoadData();
        ViewCaseItemsController objVIC = new ViewCaseItemsController();
        objVIC.strCaseid = objCase.Id;
        list<ViewCaseItemsController.Itemswrapper> lstofwrp = new list<ViewCaseItemsController.Itemswrapper>();
        ViewCaseItemsController.Itemswrapper objIW = new ViewCaseItemsController.Itemswrapper(objItem);
        objVIC.counter = 0;
        lstofwrp.add(objIW);
        ApexPages.currentPage().getParameters().put('index', '0');
            objVIC.saveRecords();
            objVIC.isEditRecords();
             objVIC.removingRow();
            objVIC.sumbitForApproval();
        
  
    }
    
    static void CreateCase()
    {
       objCase = new Case();
       objCase.Subject = 'Test';
       insert objCase;
    }
    static void CreateItem()
    {
         objItem = new Item__c();
         objItem.Case__c = objCase.Id;
         objItem.Quantity__c = 1; 
         objItem.Item_Description__c = 'Test';
         insert objItem;
    }
    
   
}