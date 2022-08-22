({
    /*
    updateQuoteLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var isMassUpdate = component.get("v.isMassUpdate");
        var isFaculty = component.get("v.isFaculty");
        var earnLeave = component.get("v.earnLeave");
        var casualLeave = component.get("v.casualLeave");
        var paternityLeave = component.get("v.paternityLeave");
        var facultyConsultingLeave = component.get("v.facultyConsultingLeave");
        var compOffLeave = component.get("v.compOffLeave");
        var reason = component.get("v.reason");
        
        var earnLeaveMass = component.get("v.earnLeaveMass");
        var casualLeaveMass = component.get("v.casualLeaveMass");
        var paternityLeaveMass = component.get("v.paternityLeaveMass");
        var facultyConsultingLeaveMass = component.get("v.facultyConsultingLeaveMass");
        var compOffLeaveMass = component.get("v.compOffLeaveMass");
        var reasonMass = component.get("v.reasonMass");
        
        var quoteLine = component.get("v.quoteLine");
        
        console.log('earnLeaveMass '+earnLeaveMass);
        console.log('casualLeaveMass '+casualLeaveMass);
        console.log('paternityLeaveMass '+paternityLeaveMass);
        console.log('facultyConsultingLeaveMass '+facultyConsultingLeaveMass);
        console.log('compOffLeaveMass '+compOffLeaveMass);
        console.log('reasonMass '+reasonMass);
        
        //----------------new code added by kk--------
        //----------------new code added by kk--------
        if(earnLeaveMass == 0 && casualLeaveMass == 0 && paternityLeaveMass == 0 && facultyConsultingLeaveMass == 0 && compOffLeaveMass == 0 && reasonMass == undefined){
            console.log('In Single records ::');
            component.set("v.isEdit", true);   
            quoteLine.Earn_Leave__c = earnLeave;
            quoteLine.Casual_Leave__c = casualLeave;
            quoteLine.Paternity_Leave__c = paternityLeave;
            quoteLine.Faculty_Leave__c = facultyConsultingLeave;
            quoteLine.CompOff_Leave__c = compOffLeave;
            quoteLine.Reason__c = reason;   
        }
        else
        {
            console.log('In multiple records ::');
            component.set("v.isEdit", true);   
            component.set("v.earnLeave",earnLeaveMass); 
            component.set("v.casualLeave",casualLeaveMass);
            component.set("v.paternityLeave",paternityLeaveMass);
            if(isFaculty == true )
            {
                component.set("v.facultyConsultingLeave", "NA");   
            }
            else
            {
                component.set("v.facultyConsultingLeave", facultyConsultingLeaveMass); 
                
            }
            
            //component.set("v.isEdit", false);       
            component.set("v.compOffLeave", compOffLeaveMass);
            component.set("v.reason", reasonMass); 
            
            quoteLine.Earn_Leave__c = earnLeaveMass;
            quoteLine.Casual_Leave__c = casualLeaveMass;
            quoteLine.Paternity_Leave__c = paternityLeaveMass;
            quoteLine.Faculty_Leave__c = facultyConsultingLeaveMass;
            quoteLine.CompOff_Leave__c = compOffLeaveMass;
            quoteLine.Reason__c = reasonMass;   
        }
        
        
        component.set("v.quoteLine", quoteLine);
        
    },
    */
    
    updateQuoteLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var isMassUpdate = component.get("v.isMassUpdate");
        var isFaculty = component.get("v.isFaculty");
        var earnLeave = component.get("v.earnLeave");
        var casualLeave = component.get("v.casualLeave");
        var paternityLeave = component.get("v.paternityLeave");
        var facultyConsultingLeave = component.get("v.facultyConsultingLeave");
        var compOffLeave = component.get("v.compOffLeave");
        var reason = component.get("v.reason");
        
        component.set("v.isEdit", true);   
        quoteLine.Earn_Leave__c = earnLeave;
        quoteLine.Casual_Leave__c = casualLeave;
        quoteLine.Paternity_Leave__c = paternityLeave;
        quoteLine.Faculty_Leave__c = facultyConsultingLeave;
        quoteLine.CompOff_Leave__c = compOffLeave;
        quoteLine.Reason__c = reason;   
        
        component.set("v.quoteLine", quoteLine);
    },
    
    validateFields : function(component, event, helper) {
        var quoteLine = component.get("v.quoteLine");   
        var quantity = parseInt(component.get("v.quantity"));	
        var discount = component.get("v.discount");
        var discountType = component.get("v.discountType");
        var sellingPrice = component.get("v.sellingPrice");
        var rate = component.get("v.rate"); 
        var listRate = component.get("v.listPrice");
        
        //console.log('This is save discount :::'+discount);
        if(quantity < 1 || quantity.toString().length > 10 ) {
            component.set("v.validQuantity",true);
        }
        else {
            component.set("v.validQuantity",false);
        }
        if(rate <= 0 || rate.toString().split(".")[0].length > 16 || rate < listRate) {
            component.set("v.invalidRate",true);
        }
        else {
            component.set("v.invalidRate",false);
        }
        if(discountType == 'Percentage') {
            if(discount < 0 || discount > 100) {
                component.set("v.invalidDiscount",true);
            }
            else {
                component.set("v.invalidDiscount",false); 
            }
        }
        else if(discountType == 'Amount') {
            if(discount < 0 || (parseFloat(discount) > parseFloat(rate))) {
                component.set("v.invalidDiscount",true); 
            }
            else {
                component.set("v.invalidDiscount",false); 
            }
        } 
    },
    
    
    updateEarnLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var earnLeaveMass = component.get("v.earnLeaveMass");
        
        component.set("v.isEdit", true);
        component.set("v.earnLeave",earnLeaveMass);
        quoteLine.Earn_Leave__c = earnLeaveMass;
        component.set("v.quoteLine", quoteLine);
    },
    
    updateCasualLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var casualLeaveMass = component.get("v.casualLeaveMass");
        
        component.set("v.isEdit", true);
        component.set("v.casualLeave",casualLeaveMass);
        quoteLine.Casual_Leave__c = casualLeaveMass;
        component.set("v.quoteLine", quoteLine);
    },
    
    updatePatMatLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var paternityLeaveMass = component.get("v.paternityLeaveMass");
        
        component.set("v.isEdit", true);
        component.set("v.paternityLeave",paternityLeaveMass);
        quoteLine.Paternity_Leave__c = paternityLeaveMass;
        component.set("v.quoteLine", quoteLine);
    },
    
    updateFacultyLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var facultyConsultingLeaveMass = component.get("v.facultyConsultingLeaveMass");
        var isFaculty = component.get("v.isFaculty");
        component.set("v.isEdit", true);  
        if(isFaculty == true )
        {
            component.set("v.facultyConsultingLeave", "NA");   
        }
        else
        {
            component.set("v.facultyConsultingLeave", facultyConsultingLeaveMass); 
        }
        quoteLine.Faculty_Leave__c = facultyConsultingLeaveMass;
        component.set("v.quoteLine", quoteLine);
    },
    
    updateCompOffLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var compOffLeaveMass = component.get("v.compOffLeaveMass");
        
        component.set("v.isEdit", true);   
        component.set("v.compOffLeave", compOffLeaveMass);
        quoteLine.CompOff_Leave__c = compOffLeaveMass;
        component.set("v.quoteLine", quoteLine);
    },
    
    updateReasonLine : function(component, event, helper) {  
        var quoteLine = component.get("v.quoteLine");
        var reasonMass = component.get("v.reasonMass");
        
        component.set("v.isEdit", true);   
        component.set("v.reason", reasonMass); 
        quoteLine.Reason__c = reasonMass;   
        component.set("v.quoteLine", quoteLine);
    }
})