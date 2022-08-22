({
    getAllProducts : function(component, event,helper) {
      
        var getProductsCount = false;
        if(component.get("v.isProductSearched") == true) {
            getProductsCount = true;
            component.set("v.isProductSearched", false);
            component.set("v.pageNumber", 1);
        }
        //console.log('getProductsCount '+getProductsCount);
        var pageNumber = component.get("v.pageNumber");
        var pageSize = component.get("v.pageSize");
        //console.log('pageNumber '+pageNumber);
        //console.log('pageSize '+pageSize);
        var getRecordsAction = component.get('c.getContactCatalogue');
        
        getRecordsAction.setParams({'pageSize': pageSize,
                                    'pageNumber': pageNumber,
                                    'getProductsCount': getProductsCount
                                   });  
        getRecordsAction.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                var currentPageRecords = result.getReturnValue();
                //console.log('This is list of contacts'+ JSON.stringify(currentPageRecords));
                component.set("v.currentPageRecords", currentPageRecords.products);
                if(currentPageRecords.productCount != null) {
                    //console.log('--------------------'+ currentPageRecords.products);
                	component.set("v.totalPages", currentPageRecords.productCount);
                }
                this.prepareProductWrapper(component, event,helper);
                
                if(component.get("v.pageNumber") == component.get("v.totalPages")){
                    component.set("v.isLastPage", true);
                } else{
                    component.set("v.isLastPage", false);
                }    
            }
            else{
                alert('There has been an error' + state);
            }
        });	
        $A.enqueueAction(getRecordsAction);
    },
    
    performSearch : function(component, event, helper) {
        
        var getProductsCount = true;
		if(component.get("v.isProductSearched") == false) {
        	component.set('v.pageNumber', 1);
        }
        component.set("v.isProductSearched", true);
        //console.log('performSearch()');
        var pageSize = component.get('v.pageSize');
        var pageNumber = component.get("v.pageNumber");
        var action = component.get('c.getProductCatalogueBySearch');
        var searchKey = component.get('v.searchKey');
        //console.log('This is searchKey ::'+ searchKey);
        action.setParams({'searchKey': searchKey,
                          'pageSize': pageSize, 
                          'pageNumber': pageNumber, 
                          'getProductsCount': getProductsCount
                      
                         });  
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){}
            var currentPageRecords = result.getReturnValue();
            component.set("v.currentPageRecords", currentPageRecords.products);
           
            if(currentPageRecords.productCount != null) {
                component.set("v.totalPages", currentPageRecords.productCount);
            }
            //console.log("currentPageRecords.productCount::::: " + currentPageRecords.productCount);
            helper.prepareProductWrapper(component, event,helper);
            
            if(component.get("v.pageNumber") == component.get("v.totalPages")){
                component.set("v.isLastPage", true);
            } 
            else{
            	component.set("v.isLastPage", false);
            }
            //console.log("isLastPage::: " + component.get("v.isLastPage"));
        });	
        $A.enqueueAction(action);  
    },
        prepareProductWrapper : function(component, event, helper) {
        var currentPageRecords = component.get("v.currentPageRecords");
        var productWrapperList = [];
        var persistentMap = {};
        persistentMap = component.get('v.persistentMap');
        
        currentPageRecords.forEach(function(rec){
            
            var isSelected = false;
            if(persistentMap[rec.Id] != null){
                isSelected = persistentMap[rec.Id].isSelected;
            }
            
           var productWrapper = {
               'Id': rec.Id,
               'Gender__c': rec.Gender__c,
               'Employee_Id__c': rec.Employee_Id__c,
               'Name' : rec.Name,
               'Department__c' : rec.Department__c,
               'Primary_Contact_Type__c' : rec.Primary_Contact_Type__c,
               'Earned_Leave_Balance__c' : rec.Earned_Leave_Balance__c,
               'Casual_Leave_Balance__c' : rec.Casual_Leave_Balance__c,
               'Maternity_Paternity_Leave_Balance__c' : rec.Maternity_Paternity_Leave_Balance__c,
               'Faculty_Researching_and_Consulting__c' : rec.Faculty_Researching_and_Consulting__c,
               'CompOff_Balance__c' : rec.CompOff_Balance__c,
               'isSelected': isSelected
            }; 
            productWrapperList.push(productWrapper);
        });
        component.set('v.productWrapperList', productWrapperList);
        //console.log('productWrapperList:::' + JSON.stringify(productWrapperList));
    },

    showLockedRecordToast : function(component, event, helper) {
	
        var lockedRecordEvent = $A.get("e.force:showToast");
        lockedRecordEvent.setParams({
            "title": "Error!",
            "type": "error",
            "message": "The record is in locked state."
        });
        lockedRecordEvent.fire();
    }
})