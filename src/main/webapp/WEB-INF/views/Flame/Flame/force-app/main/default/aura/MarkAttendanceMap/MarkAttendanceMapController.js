({
    doInit : function(component, event, helper) {
        console.log('Call');
       
        helper.LoadMapData(component, event, helper);
        helper.LoadDisplayTime(component, event, helper);
    },
    
    getlocAndSave : function(component, event, helper) { 
        component.set('v.loaded',false);
       console.log('init save record...');
       helper.getCurrentLocation(component, event, helper);
     
      //  window.setTimeout(helper.LoadMapDataAfterSave, 0, component, event, helper);
         
        window.setTimeout($A.getCallback(function(){helper.LoadMapDataAfterSave(component, helper);}), 2500);
      // setTimeout($A.getCallback(helper.LoadMapDataAfterSave.bind(this, component, event, helper)),0);
     
    },
      isRefreshed: function(component, event, helper) {
        //location.reload();
        window.setTimeout($A.getCallback(function(){location.reload()}), 4000);
       // window.setTimeout(function(){location.reload()}, 5000);
          
    },
      // function automatic called by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // remove slds-hide class from mySpinner
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // add slds-hide class from mySpinner    
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    }
    
})