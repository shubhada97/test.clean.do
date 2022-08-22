({        
     fetchEmployeeCalendars : function(component, event, helper) {
         component.set('v.mycolumn', [
             {label: 'Name', fieldName: 'Name', type: 'Text'},
             //{label: 'StudentNumber', fieldName: 'Employee_Code__c', type: 'Text'},
             {label: 'Student Name', fieldName: 'Contact_Name', type: 'Text'},
             {label: 'Email', fieldName: 'Contact_Name_Email', type: 'Text'},
             {label: 'Phone', fieldName: 'Contact_Name_Phone', type: 'Text'},
             {label: 'MainGate In', fieldName: '', cellAttributes:{ 
                 class: { fieldName: 'Active__c' },
                 iconName: { fieldName: 'displayIconName'}
             	}},
             {label: 'MainGate Out', fieldName: '', cellAttributes:{ 
                 class: { fieldName: 'Active__c' },
                 iconName: { fieldName: 'displayIconName1'}
             	}},
             {label: 'In Time', fieldName: 'Punch_In_DateTime__c', type: 'date',sortable: true,typeAttributes: {
                    day: 'numeric',
                    month: 'short',
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: true
                  }},
                             {label: 'Out Time', fieldName: 'Punch_Out_DateTime__c',sortable: true, type: 'date',typeAttributes: {
                    day: 'numeric',
                    month: 'short',
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                    hour12: true
                  }},
             {label: 'In/Out', fieldName: 'In_Time__c', type: 'Text',cellAttributes:{ 
                class: { fieldName: 'colortext' }}},
             {label: 'LastActivity', fieldName: 'PunchInOut', type: 'date',typeAttributes: {
                day: 'numeric',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: true
              }}            
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
    
    showSubmitData:function(component, event, helper){
		helper.getSubmitData(component);
    },
    showResetData:function(component, event, helper){
		helper.getResetData(component);
    },
    
    //Load Batch Account Name Picklist
    loadBatchAccount: function(component, event, helper) {
        helper.fetchBatchData(component);
    },
    //get Primary Contact Picklist Value
    loadPrimaryContact: function(component, event, helper) {
        // Request from server
        var action = component.get("c.getPrimaryContactType");
        action.setCallback(this, function(result){
            var contacts = result.getReturnValue();
            var contactType = [{"id":"Student - LOA","name":"Student - LOA"}, {"id":"Student - Study Abroad","name":"Student - Study Abroad"}, {"id":"Student","name":"Student"}];            
            console.log('loadPrimaryContact::'+contactType);
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
            var contactType = [{"id":"False","name":"No"},{"id":"True","name":"Yes"}];            
            console.log(contactType);
            component.set("v.maingates", contactType);
        });
        $A.enqueueAction(action);
    },
    
    updateSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },
    
    
    searchTable:function(component, event, helper){
		helper.searchAllData(component);
    },
 })