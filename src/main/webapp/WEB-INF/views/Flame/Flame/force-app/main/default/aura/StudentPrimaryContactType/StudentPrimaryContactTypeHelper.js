({
	//get Primary Contact Picklist Value
    getContactPicklist: function(component, event) {
        var action = component.get("c.getPrimaryContactType");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("state::");
            console.log(state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var contactMap = [];
                for(var key in result){
                    contactMap.push({key: key, value: result[key]});
                    console.log(key);
                    console.log(result[key]);
                    console.log(contactMap);
                }
                component.set("v.PrimaryContact", contactMap);
            }
        });
        $A.enqueueAction(action);
    }
})