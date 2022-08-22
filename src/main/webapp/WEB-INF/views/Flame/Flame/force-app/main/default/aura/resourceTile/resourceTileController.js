({
    handleClick : function(component, event, helper) {
        console.log('Inside handleClick');
        component.set("v.selectedResource", component.get("v.resource"));
        component.set("v.isMainScreen", false);
        console.log('Inside handleClick');
    }
})