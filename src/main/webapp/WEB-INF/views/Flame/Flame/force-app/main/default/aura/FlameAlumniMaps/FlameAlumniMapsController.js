({ 
    doInit: function (component, event, helper) {
       var pageNumber = component.get("v.PageNumber");  
       var pageSize =  component.get("v.pageSize");
      
       helper.LoadMapData(component, pageNumber, pageSize);
    },
    handleNext: function (component, event, helper) {
        component.set('v.mapMarkersData',[]);
        var pageNumber = component.get("v.PageNumber");  
       var pageSize =  component.get("v.pageSize");
        var btn1 =component.get("v.btn");
        pageNumber++;
        if(btn1=="true"){
        helper.LoadMapData(component, pageNumber, pageSize);
        }else{
            helper.LoadMapDataOnChange(component, pageNumber, pageSize); 
        } 
       
       
    },
    handlePrev: function (component, event, helper) {
        component.set('v.mapMarkersData',[]);
        var pageNumber = component.get("v.PageNumber");  
       var pageSize =  component.get("v.pageSize");
        pageNumber--;
        var btn1 =component.get("v.btn");
        if(btn1=="true"){
        helper.LoadMapData(component, pageNumber, pageSize);
        }else{
            helper.LoadMapDataOnChange(component, pageNumber, pageSize); 
        } 
    },
  
  handleMarkerSelect: function (cmp, event, helper) {
       var marker = event.getParam("selectedMarkerValue");
        event.preventDefault();s
       return false;
        
   },
    
    onChangeText: function (component, event, helper) {
        component.set('v.mapMarkersData',[]);
         var pageNumber = component.get("v.PageNumber");  
       var pageSize =  component.get("v.pageSize");
       // helper.LoadMapDataOnChange(component, pageNumber, pageSize);
        var serch =component.get("v.searchString");
        if(serch==''){
             pageNumber =1;
            pageSize =10; 
             component.set('v.ErrorMessage', '');
             component.set("v.serchcomp","false");
        helper.LoadMapData(component, pageNumber, pageSize);
        }else{
            helper.LoadMapDataOnChange(component, pageNumber, pageSize); 
        } 
    },
})