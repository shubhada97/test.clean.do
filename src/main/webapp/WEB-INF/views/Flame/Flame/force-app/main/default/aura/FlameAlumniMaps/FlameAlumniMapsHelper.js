({
    LoadMapData : function(component, pageNumber, pageSize){
        var action = component.get("c.getLocation");
        component.set('v.isSending',true);
     action.setParams({
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resultData = response.getReturnValue();

           console.log('resultData length== '+resultData.length);
             component.set('v.btn',"true");
            if (state === "SUCCESS") {
                console.log('value is' +JSON.stringify(resultData));
                component.set('v.ContactData',resultData);
                // set mapMarkersData attribute values with 'accountLocationWrapper' data 
               // console.log('resultData[');
                component.set('v.mapMarkersData',resultData);
               // console.log('resultData[..');
               // console.log('resultData[0].location.Country...'+JSON.stringify(resultData[0])); 
               // console.log('resultData[0].location.Country...'+JSON.parse(resultData[0]));
               component.set('v.center', component.get('v.mapMarkersData')[0]);
               //component.set('v.selectedMarkerValue',resultData[0]);
                component.set('v.PageNumber', resultData[0].pageNumber);
                component.set("v.TotalRecords", resultData[0].totalRecords);
                component.set("v.RecordStart", resultData[0].recordStart);
                component.set("v.RecordEnd",resultData[0].recordEnd);
                component.set("v.TotalPages",Math.ceil(resultData[0].totalRecords / pageSize));
                component.set('v.isSending',false); 
               // component.set("v.serchcomp","True");
               //  component.set("v.totalcount",resultData[0].totalRecords);
           }
            else if (state === "INCOMPLETE") {
                component.set('v.isSending',false);
                // do something
            }
            else if (state === "ERROR") {
                    component.set('v.isSending',false);
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
    next : function(component, event){
        
        var sObjectList = component.get("v.ContactData");
        // console.log('next value' +JSON.stringify(sObjectList));

        var end = component.get("v.RecordEnd");
        var start = component.get("v.RecordStart");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(sObjectList.length > i){
                Paginationlist.push(sObjectList[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.RecordStart",start);
        component.set("v.RecordEnd",end);
        component.set('v.mapMarkersData', Paginationlist);
    },
    LoadMapDataOnChange : function(component, pageNumber, pageSize){
        component.set('v.isSending',true);
        var btn1 =component.get("v.btn");
        var searchString = component.get('v.searchString');
        
        if(btn1=="true"){
            pageNumber =1;
            pageSize =10; 
        }
        
      //  console.log('searchString-->'+searchString);
        var action = component.get("c.getLocationOnchange");
         action.setParams({
            "searchString" : searchString,
             "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
           // console.log('state' +state);
            var no =1;
             var resultData = response.getReturnValue();
            if (state === "SUCCESS") {
                component.set('v.isSending',false);
                // set mapMarkersData attribute values with 'accountLocationWrapper' data 
               
                if(resultData == ''){
                  //  console.log('value is' +JSON.stringify(resultData));
                    component.set('v.ErrorMessage', 'No Alumni Found');
                    component.set('v.mapMarkersData', [
                        {
                            location: {
                                City: 'Washington',
                                State: 'DC'
                            },
                            
                            title: 'The White House',
                            description: 'Landmark, historic home & office of the United States president, with tours for visitors.'
                        }
                    ]);
                    //component.set('v.mapCenter','India');
                    component.set('v.PageNumber',no);
                    component.set('v.TotalPages',no);
                    
                }
                else{
                    component.set('v.btn',"false");
                    component.set('v.ContactData',resultData);
                  //  console.log('serching value is' +JSON.stringify(resultData));  
                    component.set('v.ErrorMessage', '');
                    component.set('v.mapMarkersData',resultData);
                    component.set('v.center', component.get('v.mapMarkersData')[0]);
                    component.set('v.PageNumber', resultData[0].pageNumber);
                    component.set("v.TotalRecords", resultData[0].totalRecords);
                    component.set("v.RecordStart", resultData[0].recordStart);
                    component.set("v.RecordEnd",resultData[0].recordEnd);
                    component.set("v.TotalPages",Math.ceil(resultData[0].totalRecords / pageSize));
                    component.set("v.serchcomp","True");
                    component.set("v.totalcount",resultData[0].totalRecords);

                }
         
            }
            else if (state === "INCOMPLETE") {
                // do something
                component.set('v.isSending',false);
            }
                else if (state === "ERROR") {
                    component.set('v.isSending',false);
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error  null value");
                    }
                }
        });
        $A.enqueueAction(action); 
    }, 
   next : function(component, event){
        
        var sObjectList = component.get("v.ContactData");
        // console.log('next value' +JSON.stringify(sObjectList));

        var end = component.get("v.RecordEnd");
        var start = component.get("v.RecordStart");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(sObjectList.length > i){
                Paginationlist.push(sObjectList[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.RecordStart",start);
        component.set("v.RecordEnd",end);
        component.set('v.mapMarkersData', Paginationlist);
        //component.set('v.mapCenter',Paginationlist[0]);
        component.set('v.center', Paginationlist[0]);
    },
         
})