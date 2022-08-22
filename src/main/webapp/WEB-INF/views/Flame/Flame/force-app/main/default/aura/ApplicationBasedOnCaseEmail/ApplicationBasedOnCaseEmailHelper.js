({
	 // Function to fetch data from server called in initial loading of page
    fetchApplication : function(component, event, helper) {
        var actions = [{ label: 'Show details', name: 'show_details' }];
        var leadId = component.get("v.recordId");
        // Assign server method to action variable
        component.set('v.columns', [
            { type: 'action', typeAttributes: { rowActions: actions } },
            
            {
    label: 'Application',
    fieldName: 'Application_Hyperlink',
    type: "url",
    typeAttributes: {
        label: {
            fieldName: 'Name'
        },
        target: '_blank'
    }
},
            {label: 'Application Owner', fieldName: 'Application_Owner__c', type: 'text'},
          
            
            
        ]);
        var action = component.get("c.fetchApplicationList");
        // Getting the account id from page
        var applicationId = component.get("v.recordId");
        // Setting parameters for server method
        action.setParams({
            applicationId: applicationId
        });
        // Callback function to get the response
        action.setCallback(this, function(response) {
            // Getting the response state
            var state = response.getState();
            // Check if response state is success
            if(state === 'SUCCESS') {
                // Getting the list of contacts from response and storing in js variable
                var applicationList = response.getReturnValue();
                var appredirectLinkCustomLabel = $A.get("$Label.c.Application_detail_Record_Link");
            
            applicationList.forEach(function(applicationList) {
             applicationList.Id= applicationList.Id;
    applicationList.Name = applicationList.Name;
    applicationList.Application_Hyperlink = ''+ appredirectLinkCustomLabel +'/'+applicationList.Id+'/view'; //Define here hyperlink as per formula field
    //For Image you can add icons dynamically like this.
   
 
});
            
                // Set the list attribute in component with the value returned by function
                component.set("v.applicationList",applicationList);
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