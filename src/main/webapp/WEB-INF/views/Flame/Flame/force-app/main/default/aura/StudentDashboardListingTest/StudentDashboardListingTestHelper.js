({
    getData : function(component) {
        var action = component.get("c.fetchEmployeeCalendarRecords");
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                   
                    var row = rows[i];
                   
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                    }
                     if ( row.Contact_Name__c ) {
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                    
                    const found = rows.some(el => el.Contact_Name_Email === rows[i].Contact_Name_Email);
                    if (found){
                 
                        if (rows[i].In_Time__c!=null ) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                        }   
                        else if(rows[i].Out_Time__c!=null) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                        }
                    }
                    //console.log(rows[i].In_Time__c);
                    //console.log(rows[i].Out_Time__c);
                    
                }
               component.set("v.empCalList", rows);
            }
         });
         $A.enqueueAction(action);
    },
    
    getAllData : function(component) {
        var batchFilter = component.find('a_opt').get('v.value');
        var primaryContactFilter = component.find('primaryContact').get('v.value');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        var action = component.get("c.fetchBatchFilterStudents");
        action.setParams({
            'searchKeyWord': batchFilter,
            'searchContactType': primaryContactFilter,
        });
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                    }
                     if ( row.Contact_Name__c ) {
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                    const found = rows.some(el => el.Contact_Name_Email === rows[i].Contact_Name__r.Email);
                    if (found){
                        
                        if (rows[i].In_Time__c!=null ) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                        }   
                        else if(rows[i].Out_Time__c!=null) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                        }
                    }
                }
               component.set("v.empCalList", rows);
            }
         });
         $A.enqueueAction(action);
    },

	getInData : function(component) {
        var batchFilter = component.find('a_opt').get('v.value');
        var primaryContactFilter = component.find('primaryContact').get('v.value');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        var action = component.get("c.getStudentInData");
        action.setParams({
            'searchKeyWord': batchFilter,
            'searchContactType': primaryContactFilter,
        });
        //var action = component.get('c.getStudentInData');
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    console.log(rows[i].In_Time__c);
                    if (rows[i].In_Time__c!=null ) {
                        console.log(rows[i].In_Time__c);
                        rows[i].colortext='slds-text-color_success';
                        rows[i].In_Time__c = 'In';
                    }   
                }
               component.set("v.empCalList", rows);
            }
        }));
        $A.enqueueAction(action);
    },
    
    getOutData : function(component) {
        var batchFilter = component.find('a_opt').get('v.value');
        var primaryContactFilter = component.find('primaryContact').get('v.value');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        var action = component.get("c.getStudentOutData");
        action.setParams({
            'searchKeyWord': batchFilter,
            'searchContactType': primaryContactFilter,
        });
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
					if(rows[i].Out_Time__c!=null) {
                        console.log(rows[i].Out_Time__c);
                        rows[i].displayIconName='utility:close';
                        rows[i].colortext='slds-text-color_error';
                        rows[i].In_Time__c = 'Out';
                    }
                }
               component.set("v.empCalList", rows);
            }
        }));
        $A.enqueueAction(action);
    },
    
    searchAllData: function (component) {
        var allRecords = component.get("v.empCalList");
        var searchFilter = component.find('SearchBox').get('v.value').toUpperCase();
        var tempArray =[];
        var i;
        for(i=0; i<allRecords.length; i++){
            if((allRecords[i].Name && allRecords[i].Name.toUpperCase().indexOf(searchFilter) != -1) || 
               (allRecords[i].Email && allRecords[i].Email.toUpperCase().indexOf(searchFilter) != -1)){
                tempArray.push(allRecords[i]);
            }
        }
        component.set("v.empCalList",tempArray);
    }
})