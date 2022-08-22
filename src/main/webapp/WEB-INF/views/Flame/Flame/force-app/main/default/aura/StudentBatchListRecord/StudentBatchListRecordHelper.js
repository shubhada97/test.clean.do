({
	//get Account Picklist Value
    getBatchPicklist: function(component, event) {
        var action = component.get("c.getBatchOfFlameStudents");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("state::");
            console.log(state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var batchMap = [];
                for(var key in result){
                    batchMap.push({key: key, value: result[key]});
                    console.log(key);
                    console.log(result[key]);
                    console.log(batchMap);
                }
                component.set("v.Batch", batchMap);
            }
        });
        $A.enqueueAction(action);
    }
})