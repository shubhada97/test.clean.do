({        
     fetchEmployeeCalendars : function(component, event, helper) {
         component.set('v.mycolumn', [
             {label: 'Name', fieldName: 'Name', type: 'Text'},
             {label: 'StudentNumber', fieldName: 'Employee_Code__c', type: 'Text'},
             {label: 'Email', fieldName: 'Contact_Name_Email', type: 'Text'},
             {label: 'Phone', fieldName: 'Contact_Name_Phone', type: 'Text'},
             {label: 'In/Out', fieldName: 'In_Time__c', type: 'Text',cellAttributes:{ 
                class: { fieldName: 'colortext' }}},
             
             {label: 'LastActivity', fieldName: 'Last_Activity_Time__c', type: 'Text'}            
         ]);
        helper.getData(component);
     },
    showInData:function(component, event, helper){
        helper.getInData(component);
    },
    showOutData:function(component, event, helper){
        helper.getOutData(component);
    },
    showAllData:function(component, event, helper){
		helper.getAllData(component);
    },
    
    //Load Batch Account Name Picklist
    loadBatchAccount: function(component, event, helper) {
        // Request from server
        var action = component.get("c.getBatchOfFlameStudents");
        action.setCallback(this, function(result){
            var accounts = result.getReturnValue();
            console.log(accounts);
            component.set("v.accounts", accounts);
        });
        $A.enqueueAction(action);
    },
    //get Primary Contact Picklist Value
    loadPrimaryContact: function(component, event, helper) {
        // Request from server
        var action = component.get("c.getPrimaryContactType");
        action.setCallback(this, function(result){
            var contacts = result.getReturnValue();
            var contactType = [{"id":"Student - LOA","name":"Student - LOA"}, {"id":"Student - Study Abroad","name":"Student - Study Abroad"}, {"id":"Student","name":"Student"}];
            console.log(contactType);
            component.set("v.contacts", contactType);
        });
        $A.enqueueAction(action);
    },
    //get Main Gate Entery In Picklist Value
    loadMainGateEntery: function(component, event, helper) {
        // Request from server
        var action = component.get("c.loadMainGateEnteryRecord");
        action.setCallback(this, function(result){
            var maingates = result.getReturnValue();
            var contactType = [{"id":"Yes","name":"Yes"}, {"id":"No","name":"No"}];            
            console.log(contactType);
            component.set("v.maingates", contactType);
        });
        $A.enqueueAction(action);
    },
    
    searchTable:function(component, event, helper){
		helper.searchAllData(component);
    },
 })