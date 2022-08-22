({
	//get Primary Contact Picklist Value
    doInit: function(component, event, helper) {
        // Request from server
        var action = component.get("c.getPrimaryContactType");
        action.setCallback(this, function(result){
            var contacts = result.getReturnValue();
            var contactType = [{"id":"Student - LOA","name":"Student - LOA"}, {"id":"Student - Study Abroad","name":"Student - Study Abroad"}, {"id":"Student","name":"Student"}];
            
            console.log(contactType);
            component.set("v.contacts", contactType);
            // Let DOM state catch up.
            window.setTimeout(
                $A.getCallback( function() {
                    // Now set our preferred value
                    component.find("primaryContact").set("v.value", contacts[0].Name);
                }));
        });
        $A.enqueueAction(action);
    }
})