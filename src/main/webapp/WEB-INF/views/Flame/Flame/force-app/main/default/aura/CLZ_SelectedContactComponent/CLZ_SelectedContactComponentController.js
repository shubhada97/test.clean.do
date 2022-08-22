({
    previous : function(component, event, helper) {
        helper.maintainQuoteLineState(component, event, helper);
        var toggleText = component.find("Configurator");
        $A.util.toggleClass(toggleText, "previous");
        component.set("v.truth1",true);
    },
    
    selectAction : function(component, event, helper) {
        var d = new Date();
        var n = d.toLocaleTimeString();
        console.log('selectAction '+n);
      helper.createQuoteLineData(component, event ,helper);    
    },
    
   save : function(component, event, helper) {
    //  var allCorrect = helper.validateRequired(component, event, helper);
      var quoteLineList = component.get("v.quoteLineList");
      //console.log('This is QuoteLineList To Save ::'+ JSON.stringify(quoteLineList));
       if(true){
       var createQuoteLineAction = component.get("c.createLeave");
       createQuoteLineAction.setParams({
                'leaveLedgerList' : quoteLineList
            });
          createQuoteLineAction.setCallback(this, function(response) {
              //console.log('response :: '+response);
                var state = response.getState();
                var error = response.getError();
                if(state === "SUCCESS"){ 
                    var isSuccess = response.getReturnValue();
                    if(isSuccess){
                        $A.get('e.force:refreshView').fire(); 
                        //helper.fireworks(component,helper,event);
                        helper.displayToast("Success!","success","Leave Adjusted Successfully","dismissible");
                    }else{ 
                        component.set("v.saveDisabled",false);
                        $A.get("e.force:closeQuickAction").fire();
                        console.log('This is error given ::'+ JSON.stringify(error));
                        helper.displayToast("Error!","error","There was an error while inserting the record(s)","dismissible");
                    }    
                }else{
                    $A.get("e.force:closeQuickAction").fire();
                     console.log('This is error exception::'+error[0].message);
                    helper.displayToast("Error!","error",error[0].message,"dismissible"); 
                }
            });
            $A.enqueueAction(createQuoteLineAction); 
           }
       else
       {
        helper.displayToast("Error!","warning","Please validate all the fields","dismissible");   
       }
    },
    
    cancelAction : function(component, event, helper) {
        console.log('cancel');
        var evt = $A.get("e.force:navigateToComponent");
		evt.setParams({
			componentDef : "c:CLZ_Leave_balance_adjustment"
			//componentAttributes: {}
		});
		evt.fire();
        //$A.get("e.force:closeQuickAction").fire();
    },
    
    sellingPriceAction : function(component, event, helper) {
        var selectProducts = component.get("c.getSelectedRecords_Apex");
        var quantity = component.get("v.Selling_Price_Rate__c");
        selectProducts.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var allProductList = response.getReturnValue();
                var spIncTax = allProductList[0].GST_Amount__c + quantity;
                component.set("v.SP_Include_Tax",spIncTax);
            }
        });
        $A.enqueueAction(selectProducts);	
    },
    
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true);
    },
    
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    
    massHandle : function(component,event,helper){
     /*var earnLeaveMass = component.get("v.earnLeaveMass"); 
     var casualLeaveMass = component.get("v.casualLeaveMass");
     var paternityLeaveMass = component.get("v.paternityLeaveMass");
     var facultyConsultingLeaveMass = component.get("v.facultyConsultingLeaveMass");
     var compOffLeaveMass = component.get("v.compOffLeaveMass");
     var reasonMass = component.get("v.reasonMass");  */
     //console.log("Mass Update :: earnLeaveMass :"+earnLeaveMass+"casualLeaveMass :"+casualLeaveMass+ "paternityLeaveMass"+ paternityLeaveMass+"facultyConsultingLeaveMass :"+facultyConsultingLeaveMass+ "compOffLeaveMass :"+compOffLeaveMass+"reasonMass :"+reasonMass);   
    }
    
   
})