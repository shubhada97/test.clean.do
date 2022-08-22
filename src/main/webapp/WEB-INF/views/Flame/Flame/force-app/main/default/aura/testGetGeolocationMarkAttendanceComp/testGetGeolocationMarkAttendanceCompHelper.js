({
	LoadMapData : function(component, event, helper){
         var latitude =component.get("v.latitude");
        alert('Comp latitude-->'+latitude);
       // console.log('Comp latitude-->'+latitude);
        var longitude =component.get("v.longitude");
        alert('Comp longitude-->'+longitude);
       // console.log('Comp longitude-->'+longitude);
        console.log('Call');
      
       
        var action = component.get("c.getLocation");
       
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('response-->'+JSON.stringify(response.getReturnValue()));
            if (state === "SUCCESS") {
                console.log('success');
                console.log('state-->'+state);
                var result = response.getReturnValue();
                console.log('user Name-->'+JSON.stringify(result[0].User__r.Name));
                // set mapMarkersData attribute values with 'accountLocationWrapper' data 
              
                 component.set('v.mapMarkers',[
            {
                location: {
                    Latitude: latitude,
                    Longitude: longitude,
                    
                },

                title: 'User Name',
                description: '<b>'+ result[0].User__r.Name +'</b>'
            }
        ]);
                component.set('v.mapCenter','India');
                
             
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
    }
})