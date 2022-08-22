({
    /*GetRecordTypeName : function(component, event, helper, recordId, objectAPIName) {
       // alert('recordId-->'+recordId);
      //  Id conRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(‘FU-Applicant’).getRecordTypeId();
        var action = component.get("c.getRecordTypeId");
         action.setParams({
            recordId : recordId,
        objectAPIName:objectAPIName
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var Result = response.getReturnValue();
                alert('Result-->'+JSON.stringify(Result));
               component.set("v.recordTypeName", Result[0].RecordType__c);   
                component.set("v.mailingAddress", Result[0].Mailing_Address__c);   
                component.set("v.contactAddress", Result[0].Contact_Address__c);   
                console.log('recordTypeName-->'+component.get("v.recordTypeName"));
                console.log('mailingAddress-->'+component.get("v.mailingAddress"));
                console.log('contactAddress-->'+component.get("v.contactAddress"));
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
        
	},*/
    
    GetCityByCountry : function(component, event, helper, countryIso) {
        //  alert('countryIso-->'+countryIso);
        var action = component.get("c.getCityByCountry");
        
        action.setParams({
            countryIso : countryIso
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
        
    }
    
})