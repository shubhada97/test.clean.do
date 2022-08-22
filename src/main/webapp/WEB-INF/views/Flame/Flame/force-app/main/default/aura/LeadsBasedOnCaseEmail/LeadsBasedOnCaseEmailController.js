({
	// Function called on initial page loading to get contact list from server
    getLeadList : function(component, event, helper) {
        // Helper function - fetchContacts called for interaction with server
     
	helper.fetchLeads(component, event, helper);
    },
    getSelectedName : function(component, event, helper) {
    var action = event.getParam('action');
       // alert('action-->'+action);
       var row = event.getParam('row');
   //     alert('row-->'+row);
     // navigate to sObject detail page     
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": row.Id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
    
    
})