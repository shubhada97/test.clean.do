({ 
    createQuoteLineData : function(component, event, helper) {
        var productItemList = component.get("v.selectedProduct");
        //console.log('productItemList ::'+ JSON.stringify(productItemList));
        //console.log('This is  Unit Price  ::'+ productItemList[0].Unit_Price__c);
        if(productItemList.length > 0 ){
                    var quoteLineMap = {};
                    quoteLineMap = component.get("v.quoteLineMap"); 
            		//console.log('quoteLineMap '+quoteLineMap);
                    //console.log('This is quoteLineMap from selected ::'+ JSON.stringify(quoteLineMap));
                    var qliList = component.get("v.quoteLineList");
            		//console.log('qliList '+qliList);
                    //var recordId = component.get("v.recordId");
            		//var its = 1;
                    productItemList.forEach(function(productItem) { 
                        //console.log(its);
                        /*
                        var quantity = 1;
                        var discountType = 'Percentage';
                        var discount = 0;
                        console.log(productItem.totalprice +' '+productItem.propertySeatType);
                        var productRate = productItem.totalprice;
                        var offerprice = 1000; 
                        var description = productItem.propertySeatType;
                        var amount = 0;
                        var sellingPrice = 0;
                        var sellingPriceWithTax = 0;
                        var gstamount;
                        var listprice;
                        var earnLeave = 0;
                        var casualLeave = 0;
                        var ptmtLeave =  0;
                        var facultyLeave = 0;
                        var compOffLeave = 0;
                        var reason ;
                        

                        if(quoteLineMap[productItem.Id] != null)
                         { 
                             console.log('if '+its);
                            var existingQuoteLine = quoteLineMap[productItem.Id];
                            earnLeave = existingQuoteLine.Earn_Leave__c;
                            casualLeave = existingQuoteLine.Casual_Leave__c;
                            ptmtLeave =  existingQuoteLine.Paternity_Leave__c;
                            facultyLeave = existingQuoteLine.Faculty_Leave__c;
                            compOffLeave = existingQuoteLine.CompOff_Leave__c;
                            reason = existingQuoteLine.Reason__c;   
                        }*/
                        
                        var quoteLineItem = {
                            'Name' : productItem.Name,
                            'Employee_Name__c' : productItem.Id,
                            'Primary_Contact_Type__c' : productItem.Primary_Contact_Type__c,
                            'Gender__c' : productItem.Gender__c,
                            'Employee_Id__c' : productItem.Employee_Id__c,
                            'Earned_Leave_Balance__c' : productItem.Earned_Leave_Balance__c,
                            'Earn_Leave__c' : 0,//earnLeave,
                            'Casual_Leave_Balance__c' : productItem.Casual_Leave_Balance__c,
                            'Casual_Leave__c': 0,//casualLeave,
                            'Maternity_Paternity_Leave_Balance__c' : productItem.Maternity_Paternity_Leave_Balance__c,
                            'Paternity_Leave__c': 0,//ptmtLeave,
                            'Faculty_Researching_and_Consulting__c' : productItem.Faculty_Researching_and_Consulting__c,
                            'Faculty_Leave__c': 0,//facultyLeave,
                            'CompOff_Balance__c' : productItem.CompOff_Balance__c,
                            'CompOff_Leave__c': 0,//compOffLeave,
                            'Reason__c ': ''//reason
                        }; 
                        qliList.push(quoteLineItem);
                        //component.set("v.quoteLines", qliList);  
                        //var d = new Date();
                        //var n = d.toLocaleTimeString();
                        //console.log(its+' '+n); 
                        //its = its + 1;
                    });
                    component.set("v.quoteLines", qliList);  
        }else{
        }
    },
    
    validateRequired : function(component, event,helper) {
        var allValid = true;
        var quantitySum = 0;
        var allProductList = component.get("v.quoteLineList");
        var decimal= /^[-+]?[0-9]+\.[0-9]+$/;
         component.set("v.noSeatsValid",false);  
       
        //console.log('This is allProductList'+ JSON.stringify(allProductList));
        for (var indexVar = 0; indexVar < allProductList.length; indexVar++) {


            if(allProductList[indexVar].Earn_Leave__c == 0) {
                allValid = false;
                //console.log('2'+ allValid);
                return allValid;
            }
            if(allProductList[indexVar].Casual_Leave__c == 0) {
                allValid = false;
                //console.log('2'+ allValid);
                return allValid;
            }
            if(allProductList[indexVar].Paternity_Leave__c == 0) {
                allValid = false;
                //console.log('2'+ allValid);
                return allValid;
            }
            if(allProductList[indexVar].Faculty_Leave__c == 0) {
                allValid = false;
                //console.log('2'+ allValid);
                return allValid;
            }
            if(allProductList[indexVar].CompOff_Leave__c == 0) {
                allValid = false;
                //console.log('2'+ allValid);
                return allValid;
            }     
        }
        return allValid;    
    },
    
    displayToast : function(title,type,message,mode) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,"type" : type,"message": message,"mode":mode
        });
        toastEvent.fire();		
    },
    
    maintainQuoteLineState : function(component, event, helper) {
        var quoteLineMap = {};
        quoteLineMap = component.get("v.quoteLineMap");
        var quoteLineList = component.get("v.quoteLineList");
        quoteLineList.forEach(function(quoteLine){   
            quoteLineMap[quoteLine.Name] = quoteLine;    
        });
        component.set("v.quoteLineMap", quoteLineMap);
    },
    
    fireworks : function(component, event, helper){
        var end = Date.now() + (15 * 100);
        var interval = setInterval(function() {
        if (Date.now() > end) {
          return clearInterval(interval);
            }
       confetti({
        particleCount : 450,
        startVelocity: 30,
        spread: 360,
        ticks: 60,
        origin:{
          x: Math.random(),
          y: Math.random() 
           },    
          });
        }, 200);
    },
    
})