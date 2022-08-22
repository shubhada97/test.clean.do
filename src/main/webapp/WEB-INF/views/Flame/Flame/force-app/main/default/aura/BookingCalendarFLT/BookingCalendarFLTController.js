({
    // Invoked at page load and sets periodic calling of loadCalendar() method
    doInit : function(component, event, helper) {
        
        var initialLoad = component.get("v.initialLoad");
    	var selectedResource = component.get("v.selectedResource");
        //console.log(JSON.stringify(selectedResource));
        if(initialLoad == true) { 
			helper.loadCalendar(component, event, helper, initialLoad);
			initialLoad = false;
            //component.set("v.initialLoad", initialLoad);
		}
		setInterval(function(){helper.loadCalendar(component,event,helper, initialLoad);}, 60000);
        helper.addTouchEvent(component, event, helper);
    },
    
    // Invoked when server call is made at initial load
    waiting : function(component, event, helper) {
        var initialLoad = component.get("v.initialLoad");
        //console.log('waiting()');
        if(initialLoad == true) {
            component.set("v.spinner", true);
        }
    },
    
    // Invoked when intial load server call returns some response
    doneWaiting : function(component,event,helper){
        //console.log('doneWaiting()');
        component.set("v.initialLoad", false);
        component.set("v.spinner", false);
        var isFocused = component.get("v.isFocused");
        if(isFocused == false) {
            helper.setFocus(component, event, helper);
            component.set("v.isFocused", true);
        }
    },
    
    // Sets the isMainScreen to true when clicked on Resources button
    backToResources : function(component, event, helper) {
        component.set("v.isMainScreen", true);
    }
})