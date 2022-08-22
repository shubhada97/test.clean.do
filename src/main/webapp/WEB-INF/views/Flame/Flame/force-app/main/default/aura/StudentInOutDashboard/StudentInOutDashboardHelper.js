({
	 GetBatchList : function(component, event, helper) {
        
        
        var action = component.get("c.getBatchOfFlameStudents");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state1-->'+state);
            console.log('response1-->'+JSON.stringify(response.getReturnValue()));
            if (state === "SUCCESS") {
                console.log('success1');
                
                var mapResult = response.getReturnValue();
                console.log('mapResult-->'+response.getReturnValue());
                
               
                var countryMap = [];
                if(mapResult){
                    console.log(mapResult);
                    for(var key in mapResult){
                        countryMap.push({
                            'Id' : key,
                            'Name' : mapResult[key]
                        });
                    }
                    
                    component.set("v.resources", countryMap);
                    
                    component.set('v.loaded',false);
                    
                    
                }else{
                    //error in calling country api
                    console.log('');
                }
                
                
                
                
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
		
	},
})