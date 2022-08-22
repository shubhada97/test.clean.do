({
    getSearchedProduct : function(component, event, helper) {

        var searchKey = component.get("v.searchKey");
        if(searchKey != null && searchKey.trim() != '') {
            helper.performSearch(component, event, helper);
        }
        else {
          helper.getAllProducts(component, event,  helper); 
        } 
    },
    
    doInit : function(component, event, helper) {
       helper.getAllProducts(component, event,helper); 
    },
    
    next : function(component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        var searchKey = component.get("v.searchKey");
        component.set("v.pageNumber", pageNumber+1);
        if(searchKey != null && searchKey.trim() != '') {
            helper.performSearch(component, event, helper);
        }
        else { 
            helper.getAllProducts(component, event,  helper); 
        }
    },
    
    previous : function(component, event, helper) {
        var pageNumber = component.get("v.pageNumber");
        var searchKey = component.get("v.searchKey");
        component.set("v.pageNumber", pageNumber-1);
        if(searchKey != null && searchKey.trim() != '') {
            helper.performSearch(component, event, helper);
        }
        else {
              helper.getAllProducts(component, event,  helper); 
        }
    },
    
    onCheckBoxClick : function(component, event, helper) {
        
        var isConfigureDisabled = true;
        var persistentMap = {};
        var selectedId = event.getSource().get("v.name");
        var productWrapperList = component.get("v.productWrapperList");
        persistentMap = component.get('v.persistentMap');
        
        productWrapperList.forEach(function(product) { 
            if(product.Id === selectedId) {
                persistentMap[selectedId] = product;
            }
        });
        var len = 0;
        for (var count in persistentMap) {
            len++;
        } 
        if(len > 0)
        {
            component.set("v.isConfigureDisabled", false); 
        }
        else
        {
            component.set("v.isConfigureDisabled", true);
        }

        //console.log(event.getSource().get("v.name"));
        //console.log("This is persistentmap length::"+ persistentMap.length);
        //console.log('persistentMap::: ' + JSON.stringify(persistentMap));
    },
    
    cancel : function(component, event, helper) {
        //console.log('Main cancel');
        //$A.get("e.force:closeQuickAction").fire();
    },
    
    confirmSelection : function(component, event, helper) {
        component.set("v.disableConfig", true);
        component.set("v.hideComponent",true);
        var persistentMap = {};
        persistentMap = component.get('v.persistentMap');
        var allSelectedProducts = component.get("v.allSelectedProducts");
        //console.log('This is allSelectedProducts.length ::'+ JSON.stringify(persistentMap));
        Object.keys(persistentMap).forEach(function(key) {
            if(persistentMap[key].isSelected == true) {
                allSelectedProducts.push(persistentMap[key]);
            }
        });
         
        if(allSelectedProducts.length <= 0)
        {  
         component.set("v.hideComponent",true); 
        } 
        else {
            component.set("v.disableConfig",false);
            //console.log('Object.keys(persistentMap)::: ' + allSelectedProducts);
            var toggleText = component.find("ProductSelector");
            $A.util.toggleClass(toggleText, "confirmSelection");
            component.set("v.isSelectionConfirmed", true);
        }   
    },
    
    massupdate : function(component, event, helper) {
        var persistentMap = {};
         component.set("v.isMassUpdate",true);
         component.set("v.hideComponent",true);
        persistentMap = component.get('v.persistentMap');
        var allSelectedProducts = component.get("v.allSelectedProducts");
        
        var getRecordsAction = component.get("c.getAllContacts");
        getRecordsAction.setCallback(this, function(result) {
            var state = result.getState();
            if (state === "SUCCESS"){
                var currentPageRecords = result.getReturnValue();
                //console.log('This is list of contacts'+ JSON.stringify(currentPageRecords));
                component.set("v.currentPageRecords", currentPageRecords);
                component.set("v.persistentMap",currentPageRecords);
                var up = component.get('v.persistentMap');
                Object.keys(up).forEach(function(key) {    
                    allSelectedProducts.push(up[key]);
                });
                
                component.set("v.disableConfig",false);
                //console.log('Object.keys(persistentMap)::: ' + allSelectedProducts);
                var toggleText = component.find("ProductSelector");
                $A.util.toggleClass(toggleText, "confirmSelection");
                component.set("v.isSelectionConfirmed", true);
                
            }
            else{
                alert('There has been an error' + state);
            }
        });	
        $A.enqueueAction(getRecordsAction);
    }

})