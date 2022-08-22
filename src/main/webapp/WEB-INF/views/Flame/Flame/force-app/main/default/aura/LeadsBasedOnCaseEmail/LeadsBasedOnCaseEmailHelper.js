({
	 // Function to fetch data from server called in initial loading of page
    fetchLeads : function(component, event, helper) {
        var actions = [{ label: 'Show details', name: 'show_details' }];
        var leadId = component.get("v.recordId");
        // Assign server method to action variable
        component.set('v.columns', [
            { type: 'action', typeAttributes: { rowActions: actions } },
            
            {
    label: 'Lead',
    fieldName: 'Lead_Hyperlink',
    type: "url",
    typeAttributes: {
        label: {
            fieldName: 'Name'
        },
        target: '_blank'
    }
},
            
            {label: 'Executive Assigned', fieldName: 'Executive_Assigned__c', type: 'text'},
           
           // {label: 'Email', fieldName: 'Email', type: 'email'},
            
        ]);
        var action = component.get("c.fetchLeadList");
        // Getting the account id from page
        var leadId = component.get("v.recordId");
        // Setting parameters for server method
        action.setParams({
            leadId: leadId
        });
        // Callback function to get the response
        action.setCallback(this, function(response) {
            // Getting the response state
            var state = response.getState();
            // Check if response state is success
            if(state === 'SUCCESS') {
                // Getting the list of contacts from response and storing in js variable
                var leadList = response.getReturnValue();
                var redirectLinkCustomLabel = $A.get("$Label.c.detail_Record_Link");
               // alert('redirectLinkCustomLabel-->'+redirectLinkCustomLabel);
            leadList.forEach(function(leadList) {
             leadList.Id= leadList.Id;
    leadList.Name = leadList.Name;
    leadList.Lead_Hyperlink = ''+ redirectLinkCustomLabel +'/'+leadList.Id+'/view'; //Define here hyperlink as per formula field
    //For Image you can add icons dynamically like this.
   
 
});
            
                // Set the list attribute in component with the value returned by function
                component.set("v.leadList",leadList);
            }
            else {
                // Show an alert if the state is incomplete or error
                alert('Error in getting data');
            }
        });
        // Adding the action variable to the global action queue
        $A.enqueueAction(action);
    }    
})