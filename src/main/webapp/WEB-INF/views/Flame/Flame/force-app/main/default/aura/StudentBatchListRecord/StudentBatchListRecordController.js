({
	//Load Account Name Picklist
    doInit: function(component, event, helper) {
        // Request from server
        var action = component.get("c.getBatchOfFlameStudents");
        action.setCallback(this, function(result){
            var accounts = result.getReturnValue();
            console.log(accounts);
            component.set("v.accounts", accounts);
            // Let DOM state catch up.
            window.setTimeout(
                $A.getCallback( function() {
                    // Now set our preferred value
                    component.find("a_opt").set("v.value", accounts[4].Id);
                }));
        });
        $A.enqueueAction(action);
    },
    onChange: function (component, event, helper) {
        console.log('filter');
         var filter = component.find('a_opt').get('v.value');
           //var filter = component.find("select").get('v.value');
        	console.log(filter);
            var action = component.get("c.fetchBatchFilterStudents");
        	action.setParams({
            'searchKeyWord': filter	
        });
        
        action.setCallback(this, function(response) {
            console.log(response);
            var state = response.getState();
            if (state === "SUCCESS" ) {
                var resultData = response.getReturnValue();
                console.log(resultData); 
            }
        });
    }
})