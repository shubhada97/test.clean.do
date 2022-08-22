({
    doInit : function(component, event, helper) {
        var apexAction = component.get("c.getResources");
        apexAction.setCallback(this, function(Response){
            var state = Response.getState();
            if(state == "SUCCESS"){
                console.log(Response.getReturnValue());
                component.set("v.resources", Response.getReturnValue());
            }else{
                console.log(Response);
                alert('Something went wrong!!!');
            }
        });
        $A.enqueueAction(apexAction);
    }
})