({
	doInit : function(component, event, helper) {
        console.log('Call');
       
		 helper.LoadMapData(component, event, helper);
	},
    saveRecord : function(component, event, helper) {
        
       
		   const options = {
  enableHighAccuracy: true,
  maximumAge: 30000,
  timeout: 27000
};
  
    
    function showPosition(pos) {
        var latt  = pos.coords.latitude;
        var longt = pos.coords.longitude;
        alert('Latitude-->'+pos.coords.latitude);
        alert('Longitude-->'+pos.coords.longitude);
        
   /*     //put logs as shown to check whether populating correctly or not
        console.log("Latitude: " + pos.coords.latitude + "\nLongitude: " + pos.coords.longitude);
        // storing into long (id of hidden field in form tags)
        document.getElementById("{!$Component.fId.latField}").value = pos.coords.latitude;
        // storing into long (id of hidden field in form tags)  
        document.getElementById('{!$Component.fId.longField}').value = pos.coords.longitude;
          SaveDataAF(latt,longt);  */
    }
    
    function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}
         if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, error, options);
             
    } else {
        alert("Geolocation is not supported by this browser.");
    } console.log('country chnage call');
        
        /*var acc= component.get("v.countryOptions")[component.get("v.countryIso")];
         alert('country Name-->'+acc.name);*/
        
        var myValues= component.get("v.countryOptions"), 
            value = component.find("countryId").get("v.value"),
            index = myValues.findIndex(item => item.iso == value),
            selectedCountryName = index >= 0? myValues[index].name: null;
        // alert('selectedCountryName==>'+selectedCountryName);
        
        var myValues= component.get("v.stateOptions"), 
            value = component.find("statedId").get("v.value"),
            index = myValues.findIndex(item => item.iso == value),
            selectedStateName = index >= 0? myValues[index].name: null;
        
        var recordId = component.get("v.recordId");
        // alert('recordId-->'+recordId);
        var city = component.find("cityId").get("v.value");
        // alert('city-->'+city);
        
        var objectAPIName = component.get("v.objectName");
        var countryField = component.get("v.countryFieldAPIName");
        var stateField = component.get("v.stateFieldAPIName");
        var cityField = component.get("v.cityFieldAPIName");
        
        console.log('countryField-->'+countryField);
        console.log('stateField-->'+stateField);
        console.log('cityField-->'+cityField);
        
      /*  var geocoder = new google.maps.Geocoder(); //window.google.maps.Geocoder();
            geocoder.geocode({
  componentRestrictions: {
      city : cityField,
      state: stateField,
    country: countryField
  }
}, function(results, status) {
  if (status == 'OK') {
    var lat = results[0].geometry.location;
      system.debug('latitude-->'+lat);
  } else {
    alert('Geocode was not successful for the following reason: ' + status);
  }
});
        */     
        
        
        var action = component.get("c.SaveRecord");
        
        
        action.setParams({
            country       : selectedCountryName,
            state         : selectedStateName,
            city          : city,
            recordId      : recordId,
            objectAPIName : objectAPIName,
            countryField  : countryField,
            stateField    : stateField,
            cityField     : cityField
            
            //  malingCountry : selectedCountryName,
            //  mailingState  : selectedStateName,
            // mailingCity   : city,
            
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var mapResult = response.getReturnValue();
                console.log('mapResult-->'+mapResult)
                // alert('Save');
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Success!",
                    message: "The record has been updated successfully.",
                    type: "success"
                });
                toastEvent.fire();
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