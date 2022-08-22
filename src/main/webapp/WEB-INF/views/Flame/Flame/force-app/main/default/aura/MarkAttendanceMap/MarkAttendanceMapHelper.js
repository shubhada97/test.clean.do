({
    LoadMapData : function(component, event, helper){
        
        console.log('Call');
        component.set('v.loaded',true);
        component.set("v.toastMessage", '');
        var action = component.get("c.getLocation");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('response-->'+JSON.stringify(response.getReturnValue()));
            if (state === "SUCCESS") {
                console.log('success');
                console.log('state1-->'+state);
                var result = response.getReturnValue();
                console.log('result1-->'+response.getReturnValue());
                console.log('result length-->'+result.length);
                
                
                if(result.length > 0){
                    // alert('if');
                    component.set('v.isLogOutButtonActive',false);
                    component.set('v.isLogInButtonActive',true);
                    component.set('v.isRendered',true);
                    component.set('v.userName',result[0].User__r.Name);
                    
                    component.set('v.mapMarkers',[
                        {
                            location: {
                                Latitude: '18.5234',  //result[0].GeoLocation_Start__Latitude__s
                                Longitude: '73.7318'   //result[0].GeoLocation_Start__Longitude__s,
                                
                                
                            },
                            
                            title: 'User Name',
                            description: '<b>'+ result[0].User__r.Name +'</b>' //result[0].User__r.Nametes
                        }
                    ]);
                    
                }
                else{
                    //   alert('elseStop');
                    component.set('v.isLogInButtonActive',false);
                    component.set('v.isLogOutButtonActive',true);
                    component.set('v.isRendered',false);
                    component.set('v.mapMarkers',[
                        {
                            location: {
                                Latitude: '18.5234',      //'21.1236313',       //'18.5234', //result[0].GeoLocation_Stop__Latitude__s,
                                Longitude: '73.7318'      //'79.1238932',      //'73.7318' // result[0].GeoLocation_Stop__Longitude__s,
                                
                                // Country: "India"
                                
                            },
                            
                            title: 'User Name',
                            //  description: '<b>'+ result[0].User__r.Name +'</b>'
                            description: '<b>'+ 'Flame University' +'</b>'
                        }
                    ]);
                }
                
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
    },
    
    LoadDisplayTime : function(component, event, helper){
        
        console.log('Call');
        
        var action = component.get("c.getDisplayTime");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('responseDisplayTime-->'+JSON.stringify(response.getReturnValue()));
            if (state === "SUCCESS") {
                console.log('success');
                console.log('state1-->'+state);
                var result = response.getReturnValue();
                console.log('responseDisplayTimeResult-->'+response.getReturnValue());
                console.log('result length-->'+result.length);
                if(result.length > 0){
                    
                if(result[0].LogIn_Status__c === 'Start'){
                    console.log('Start');
                    console.log($A.localizationService.formatDate(result[0].Punch_In_DateTime__c, "DD-MM-YYYY, hh:mm:ss a"));
                    var punchInDateTime = $A.localizationService.formatDate(result[0].Punch_In_DateTime__c, "DD-MM-YYYY, hh:mm:ss a");
                    component.set('v.displayTime',punchInDateTime); //result[0].Date__c+' '+result[0].In_Time__c
                    }
                if(result[0].LogIn_Status__c === 'Stop'){
                    console.log('Stop');
                    if(result[0].Punch_Out_DateTime__c != null){
                     console.log($A.localizationService.formatDate(result[0].Punch_Out_DateTime__c, "DD-MM-YYYY, hh:mm:ss a"));
                    var punchOutDateTime = $A.localizationService.formatDate(result[0].Punch_Out_DateTime__c, "DD-MM-YYYY, hh:mm:ss a");
                    component.set('v.displayTime',punchOutDateTime); //result[0].Date__c+' '+result[0].Out_Time__c
                        }
                    else{
                        console.log($A.localizationService.formatDate(result[0].Punch_In_DateTime__c, "DD-MM-YYYY, hh:mm:ss a"));
                    var punchInDateTime = $A.localizationService.formatDate(result[0].Punch_In_DateTime__c, "DD-MM-YYYY, hh:mm:ss a");
                    component.set('v.displayTime',punchInDateTime); //result[0].Date__c+' '+result[0].Out_Time__c
                    }
                }
                    }
                else
                { 
                    console.log('Empty');
                    component.set('v.displayTime','');
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
    
    LoadMapDataAfterSave : function(component, event, helper){
        
        
        component.set('v.mapMarkers',[
            {
                location: {
                    Latitude: component.get("v.latitude"),
                    Longitude: component.get("v.longitude")
                    // Country: "India"
                    
                },
                
                title: 'User Name',
                description: '<b>'+ component.get("v.userName") +'</b>'
            }
        ]);
        
        component.set('v.mapCenter','India');
        
        $A.get('e.force:refreshView').fire();
        
        
        
    },
    
    getCurrentLocation: function(component,event,helper){
        console.log('in get current loc');
        
        if (navigator.geolocation) {
            
            navigator.geolocation.getCurrentPosition(callbackPosition,errorCallback);
            function callbackPosition(position) {
                var latitude = position.coords.latitude;
                component.set("v.latitude", latitude);
                var longitude = position.coords.longitude;
                component.set("v.longitude", longitude);
                console.log("latitude-->", latitude);
                console.log("longitude-->", longitude);
                // alert("latitude-->"+latitude);
                // alert("longitude-->"+longitude);
                
            }
            function errorCallback(error) {
                if (error.code == error.PERMISSION_DENIED) {
                    alert('Please enable GPS Location.');
                    
                }
                
                
            }
            
            window.setTimeout($A.getCallback(function(){helper.saveRecordEmployee(component, helper);}), 2000);
            
        } else {
            error('Geolocation is not supported');
        }
        
    },
    saveRecordEmployee: function(component, event, helper){
        console.log('in save rec metghod');
        
        console.log('save rec latitude-->'+component.get("v.latitude"));
        console.log('save rec longitude-->'+component.get("v.longitude"));
        component.set('v.displayTime','');
        var latt  = component.get("v.latitude");
        var longt = component.get("v.longitude");
        
        if(latt != undefined && longt != undefined)
        {
            
            // alert('Hi save');
            var action = component.get("c.saveRecord");
            // console.log('action-->'+action);
            
            action.setParams({
                latt       : latt,
                longt      : longt
                
                
            });
            console.log('latt-->'+latt);
            console.log('longt-->'+longt);
            // alert('Hi');
            action.setCallback(this, function(response) {
                console.log('longtInsideCalbak-->'+longt);
                var state = response.getState();
                console.log('state==>>'+response.getState());
                if(state === 'SUCCESS'){
                    var mapResult = response.getReturnValue();
                    console.log('mapResult-->'+mapResult);
                    
                    if(mapResult == '' || mapResult == null){
                        component.set('v.loaded',true);
                        component.set("v.toastMessage", 'Error: You are outside the campus.');
                        // alert('You are outside the campus.');d
                        
                    }
                    else{
                        if(mapResult == 'true'){
                            component.set('v.isLogInButtonActive',false);
                            component.set('v.isLogOutButtonActive',true);
                            component.set('v.isRendered',false);
                            component.set('v.loaded',true);
                           // component.set('displayTime',)
                            component.set("v.toastMessage", 'Punch OUT Successful.');
                        }
                        else{
                            component.set('v.isLogInButtonActive',true);
                            component.set('v.isLogOutButtonActive',false);
                            component.set('v.isRendered',true);
                            component.set('v.loaded',true);
                            component.set("v.toastMessage", 'Punch IN Successful.');
                        }
                        
                        // component.set()
                        
                        
                        
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
        else{
            // alert('Hi');
            component.set('v.loaded',true);
            component.set("v.locationMsg", 'Make sure your device Location service is ON.');
            return;
        }
    }
})