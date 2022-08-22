({
    doInit : function(component, event, helper) {
        var recordId = component.get("v.recordId");
        
        // helper.GetRecordTypeName(component, event, helper, recordId, objectAPIName);
        var action = component.get("c.getCountry");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var mapResult = response.getReturnValue();
                var countryMap = [];
                if(mapResult){
                    console.log(mapResult);
                    for(var key in mapResult){
                        countryMap.push({
                            'iso' : key,
                            'name' : mapResult[key]
                        });
                    }
                    
                    component.set("v.countryOptions", countryMap);
                    
                    
                    
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
    
    onCountryChange : function(component, event, helper){
        console.log('country chnage call');
        var countryIso = component.get("v.countryIso");   
        // alert('countryIso-->'+countryIso); 
        helper.GetCityByCountry(component, event, helper, countryIso);
        var action = component.get("c.getStateByCountry");
        
        
        action.setParams({
            countryIso : component.get("v.countryIso")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var mapResult = response.getReturnValue();
                var stateMap = [];
                if(mapResult){
                    console.log(mapResult);
                    for(var key in mapResult){
                        stateMap.push({
                            'iso' : key,
                            'name' : mapResult[key]
                        });
                    }
                    
                    component.set("v.stateOptions", stateMap);
                    
                }
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
    
    
    
    onStateChange : function(component, event, helper){
        
        console.log('country chnage call');
        var action = component.get("c.getCityByStateCountry");
        
        action.setParams({
            countryIso : component.get("v.countryIso"),
            stateIso : component.get("v.stateIso")
            
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var mapResult = response.getReturnValue();
                console.log('mapResult-->'+mapResult)
                var cityMap = [];
                if(mapResult){
                    console.log(mapResult);
                    for(var key in mapResult){
                        cityMap.push({
                            'id' : key,
                            'name' : mapResult[key]
                        });
                    }
                    
                    component.set("v.cityOptions", cityMap);  
                    
                }
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
    
    
    
    SaveRecordEvent : function(component, event, helper){
        
        console.log('country chnage call');
        
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
    },
    // common reusable function for toggle sections
    toggleSection : function(component, event, helper) {
        // dynamically get aura:id name from 'data-auraId' attribute
        var sectionAuraId = event.target.getAttribute("data-auraId");
        // get section Div element using aura:id
        var sectionDiv = component.find(sectionAuraId).getElement();
        /* The search() method searches for 'slds-is-open' class, and returns the position of the match.
         * This method returns -1 if no match is found.
        */
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open'); 
        
        // -1 if 'slds-is-open' class is missing...then set 'slds-is-open' class else set slds-is-close class to element
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open');
        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
        }
    }
    
})