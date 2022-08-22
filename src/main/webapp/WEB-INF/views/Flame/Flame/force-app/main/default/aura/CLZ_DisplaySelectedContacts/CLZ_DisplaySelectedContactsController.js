({
    doInit : function(component, event, helper) {
        var quoteLine = component.get("v.quoteLine"); 
        //console.log('These are selected quote line items'+ JSON.stringify(quoteLine));
        
        if(quoteLine.Primary_Contact_Type__c == "Faculty")
        {
            component.set("v.isFaculty", false);
        }
        else{
            component.set("v.isFaculty",true);
            component.set("v.facultyConsultingLeave", "NA");
        }
        
    },
    updatePricing : function(component, event, helper) {
        var isFirstExecution = component.get("v.isFirstExecution");
        var quoteLine = component.get("v.quoteLine");
        if(isFirstExecution == true && quoteLine.TotalPrice__c != 0) {
            component.set("v.isFirstExecution", false);
        }
        else {  
           //do nothing 
        } 
    },
    //for mass updating
    updateChange : function(component, event, helper){  
        helper.updateQuoteLine(component, event, helper); 
    },
    //for earn mass updating
    updateEarnChange : function(component, event, helper){  
        helper.updateEarnLine(component, event, helper); 
    },
    //for casual mass updating
    updateCasualChange : function(component, event, helper){  
        helper.updateCasualLine(component, event, helper); 
    },
    //for patmat mass updating
    updatePatMatChange : function(component, event, helper){  
        helper.updatePatMatLine(component, event, helper); 
    },
    //for faculty mass updating
    updateFacultyChange : function(component, event, helper){  
        helper.updateFacultyLine(component, event, helper); 
    },
    //for compoff mass updating
    updateCompOffChange : function(component, event, helper){  
        helper.updateCompOffLine(component, event, helper); 
    },
    //for reason mass updating
    updateReasonChange : function(component, event, helper){  
        helper.updateReasonLine(component, event, helper); 
    },
    
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true);
    },
    
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    }
})