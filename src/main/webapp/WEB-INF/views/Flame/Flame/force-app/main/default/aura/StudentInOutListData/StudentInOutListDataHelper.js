({
    getData : function(component) {
        var action = component.get("c.fetchEmployeeCalendarRecords");
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                console.log('response-->'+JSON.stringify(response.getReturnValue()));
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                   // const found = rows.some(el => el.Name === rows[i].Name);
                    console.log('Main_Gate_In__c::'+rows[i].Main_Gate_In__c);
                    console.log('Main_Gate_Out__c::'+rows[i].Main_Gate_Out__c);
                  	if( rows[i].Main_Gate_In__c== true){
                        rows[i].displayIconName='utility:check';
                        rows[i].colortext='slds-text-color_success';
                    }else{
                        rows[i].displayIconName='utility:close';
                        rows[i].colortext='slds-text-color_error';
                    }
                    
                    if( rows[i].Main_Gate_Out__c==true ){
                        rows[i].displayIconName1='utility:check';
                        rows[i].colortext='slds-text-color_success';
                    }else{
                        rows[i].displayIconName1='utility:close';
                        rows[i].colortext='slds-text-color_error';
                    } 
                    
                        if (rows[i].Punch_In_DateTime__c > rows[i].Punch_Out_DateTime__c || rows[i].Punch_Out_DateTime__c == null) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                            rows[i].PunchInOut = rows[i].Punch_In_DateTime__c; 
                        }   
                        else if(rows[i].Punch_Out_DateTime__c > rows[i].Punch_In_DateTime__c) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                            rows[i].PunchInOut = rows[i].Punch_Out_DateTime__c;
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
        var mainGateEnteryInFilter = component.find('mainGateEnteryIn').get('v.value');
        var mainGateEnteryOutFilter = component.find('mainGateEnteryOut').get('v.value');
        
        component.find('SearchBox').set('v.value','');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        if(mainGateEnteryInFilter===''){
            mainGateEnteryInFilter = 'False';
        }
        if(mainGateEnteryOutFilter===''){
            mainGateEnteryOutFilter = 'False';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        console.log("mainGateEnteryInFilter:"+mainGateEnteryInFilter);
        console.log("mainGateEnteryOutFilter:"+mainGateEnteryOutFilter);
        
        var action = component.get("c.getStudentInData");
        action.setParams({
            "searchKeyWord": batchFilter,
            "searchContactType": primaryContactFilter,
            "mainGateEnteryInFilter": mainGateEnteryInFilter,
            "mainGateEnteryOutFilter": mainGateEnteryOutFilter
        });

        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                
                for ( var i = 0; i < rows.length; i++ ) {
                    console.log(rows[i].In_Time__c);
                    if (rows[i].Punch_In_DateTime__c!=null ) {
                        console.log(rows[i].In_Time__c);
                        rows[i].colortext='slds-text-color_success';
                        rows[i].In_Time__c = 'In';
                        rows[i].PunchInOut = rows[i].Punch_In_DateTime__c;
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
        var mainGateEnteryInFilter = component.find('mainGateEnteryIn').get('v.value');
        var mainGateEnteryOutFilter = component.find('mainGateEnteryOut').get('v.value');
        
        component.find('SearchBox').set('v.value','');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        if(mainGateEnteryInFilter===''){
            mainGateEnteryInFilter = 'False';
        }
        if(mainGateEnteryOutFilter===''){
            mainGateEnteryOutFilter = 'False';
        }
        
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        console.log("mainGateEnteryInFilter:"+mainGateEnteryInFilter);
        console.log("mainGateEnteryOutFilter:"+mainGateEnteryOutFilter);
        
        var action = component.get("c.getStudentOutData");
        
        action.setParams({
            "searchKeyWord": batchFilter,
            "searchContactType": primaryContactFilter,
            "mainGateEnteryInFilter": mainGateEnteryInFilter,
            "mainGateEnteryOutFilter": mainGateEnteryOutFilter
        });
        
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
					if(rows[i].Punch_Out_DateTime__c!=null) {
                        console.log(rows[i].Out_Time__c);
                        rows[i].colortext='slds-text-color_error';
                        rows[i].In_Time__c = 'Out';
                        rows[i].PunchInOut = rows[i].Punch_Out_DateTime__c;
                    }
                }
               component.set("v.empCalList", rows);
            }
        }));
        $A.enqueueAction(action);
    },
    
    getAllData : function(component) {
        var batchFilter = component.find('a_opt').get('v.value');
        var primaryContactFilter = component.find('primaryContact').get('v.value');
        var mainGateEnteryInFilter = component.find('mainGateEnteryIn').get('v.value');
        var mainGateEnteryOutFilter = component.find('mainGateEnteryOut').get('v.value');
        
        component.find('SearchBox').set('v.value','');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        if(mainGateEnteryInFilter===''){
            mainGateEnteryInFilter = 'False';
        }
        if(mainGateEnteryOutFilter===''){
            mainGateEnteryOutFilter = 'False';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        console.log("mainGateEnteryInFilter:"+mainGateEnteryInFilter);
        console.log("mainGateEnteryOutFilter:"+mainGateEnteryOutFilter);
        
        var action = component.get("c.fetchBatchFilterStudents");
        
        action.setParams({
            "searchKeyWord": batchFilter,
            "searchContactType": primaryContactFilter,
            "mainGateEnteryInFilter": mainGateEnteryInFilter,
            "mainGateEnteryOutFilter": mainGateEnteryOutFilter
        });
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                        if (rows[i].Punch_In_DateTime__c > rows[i].Punch_Out_DateTime__c || rows[i].Punch_Out_DateTime__c == null) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                            rows[i].PunchInOut = rows[i].Punch_In_DateTime__c; 
                        }   
                        else if(rows[i].Punch_Out_DateTime__c > rows[i].Punch_In_DateTime__c) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                            rows[i].PunchInOut = rows[i].Punch_Out_DateTime__c;
                        }
                 
                }
               component.set("v.empCalList", rows);
            }
         });
         $A.enqueueAction(action);
    },
    
    searchAllData: function (component) {
        var allRecords = component.get("v.empCalList");
        var searchFilter = component.find('SearchBox').get('v.value').toUpperCase();
        var tempArray =[];
        var i;
        for(i=0; i<allRecords.length; i++){
            if((allRecords[i].Name && allRecords[i].Name.toUpperCase().indexOf(searchFilter) != -1) || 
               (allRecords[i].Contact_Name_Email && allRecords[i].Contact_Name_Email.toUpperCase().indexOf(searchFilter) != -1) || 
               (allRecords[i].Contact_Name && allRecords[i].Contact_Name.toUpperCase().indexOf(searchFilter) != -1)){
                tempArray.push(allRecords[i]);
            }
        }
        component.set("v.empCalList",tempArray);
    },
    sortData: function (component, fieldName, sortDirection) {
        var fname = fieldName;
        var data = component.get("v.fetchEmployeeCalendarRecords");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        component.set("v.empCalList", data);
    },
     
    sortBy: function (field, reverse) {
        var key = function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    
    fetchBatchData : function(component) {

       var action = component.get("c.getBatchOfFlameStudents");
         action.setCallback(this, function(response){
            var state = response.getState();
             if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                console.log('fetchBatchData response-->'+JSON.stringify(response.getReturnValue()));
                console.log('fetchBatchData rows-->'+JSON.stringify(rows));
             }
             component.set("v.accounts", rows);
        });
        $A.enqueueAction(action);
    },
    
    // Get Submit Button Data
    getSubmitData : function(component) {
        var batchFilter = component.find('a_opt').get('v.value');
        var primaryContactFilter = component.find('primaryContact').get('v.value');
        var mainGateEnteryInFilter = component.find('mainGateEnteryIn').get('v.value');
        var mainGateEnteryOutFilter = component.find('mainGateEnteryOut').get('v.value');
        
        component.find('SearchBox').set('v.value','');
        if(primaryContactFilter===undefined){
            primaryContactFilter = 'all';
        }
        if(mainGateEnteryInFilter===''){
            mainGateEnteryInFilter = 'False';
        }
        if(mainGateEnteryOutFilter===''){
            mainGateEnteryOutFilter = 'False';
        }
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        console.log("mainGateEnteryInFilter:"+mainGateEnteryInFilter);
        console.log("mainGateEnteryOutFilter:"+mainGateEnteryOutFilter);
        
        var action = component.get("c.fetchBatchFilterStudents");
        
        action.setParams({
            "searchKeyWord": batchFilter,
            "searchContactType": primaryContactFilter,
            "mainGateEnteryInFilter": mainGateEnteryInFilter,
            "mainGateEnteryOutFilter": mainGateEnteryOutFilter
        });
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                        if (rows[i].Punch_In_DateTime__c > rows[i].Punch_Out_DateTime__c || rows[i].Punch_Out_DateTime__c == null) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                            rows[i].PunchInOut = rows[i].Punch_In_DateTime__c; 
                        }   
                        else if(rows[i].Punch_Out_DateTime__c > rows[i].Punch_In_DateTime__c) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                            rows[i].PunchInOut = rows[i].Punch_Out_DateTime__c;
                        }
                 
                }
               component.set("v.empCalList", rows);
            }
         });
         $A.enqueueAction(action);
    },
    
    
    // Get Reset Button Data
    getResetData : function(component) {
       
        component.find('a_opt').set('v.value','all');
        component.find('primaryContact').set('v.value','all');
        component.find('mainGateEnteryIn').set('v.value','False');
        component.find('mainGateEnteryOut').set('v.value','False');

        component.find('SearchBox').set('v.value','');
        
        var batchFilter = 'all';
        var primaryContactFilter = 'all';
        var mainGateEnteryInFilter = 'False';
        var mainGateEnteryOutFilter = 'False';
        
        console.log("batchFilter:"+batchFilter);
        console.log("primaryContactFilter:"+primaryContactFilter);
        console.log("mainGateEnteryInFilter:"+mainGateEnteryInFilter);
        console.log("mainGateEnteryOutFilter:"+mainGateEnteryOutFilter);
        
        var action = component.get("c.fetchBatchFilterStudents");
        
        action.setParams({
            "searchKeyWord": batchFilter,
            "searchContactType": primaryContactFilter,
            "mainGateEnteryInFilter": mainGateEnteryInFilter,
            "mainGateEnteryOutFilter": mainGateEnteryOutFilter
        });
         action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for ( var i = 0; i < rows.length; i++ ) {
                    var row = rows[i];
                    if ( row.Contact_Name__c ) {
                        row.Contact_Name_Email = row.Contact_Name__r.Email;
                        row.Contact_Name_Phone = row.Contact_Name__r.Phone;
                        row.Contact_Name = row.Contact_Name__r.Name;
                    }
                }
                for ( var i = 0; i < rows.length; i++ ) {
                    const { length } = rows;
                    const id = length + 1;
                        if (rows[i].Punch_In_DateTime__c > rows[i].Punch_Out_DateTime__c || rows[i].Punch_Out_DateTime__c == null) {
                            
                            rows[i].colortext='slds-text-color_success';
                            rows[i].In_Time__c = 'In';
                            rows[i].PunchInOut = rows[i].Punch_In_DateTime__c; 
                        }   
                        else if(rows[i].Punch_Out_DateTime__c > rows[i].Punch_In_DateTime__c) {
                            
                            rows[i].colortext='slds-text-color_error';
                            rows[i].In_Time__c = 'Out';
                            rows[i].PunchInOut = rows[i].Punch_Out_DateTime__c;
                        }
                 
                }
               component.set("v.empCalList", rows);
            }
         });
         $A.enqueueAction(action);
    },
})