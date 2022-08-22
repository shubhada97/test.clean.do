({
    // invoked on initial Load and renders the Calendar view
	loadCalendar : function(component, event, helper, initialLoad) {
        
        var today = new Date();
        const monthNames = ["January", "February", "March", "April", "May", "June",
                                "July", "August", "September", "October", "November", "December"
                           ];
	 	component.set("v.currentDate", today.getDate() + " " + monthNames[today.getMonth()]);
		component.set("v.formattedDate", today.getDate() + " " + monthNames[today.getMonth()].substring(0, 3) + " " + today.getFullYear());
        
		if(initialLoad == true) {
			this.renderCalendar(component, event, helper);
        }
		this.renderClock(component, event, helper, today);
		this.fetchBookings(component, event, helper, today);
		this.renderCurrentTimeReference(component, event, helper, today);
	},
	
    // Invoked periodically for updating the current time red line
	renderCurrentTimeReference : function(component, event, helper, today) {
        var hourHeight = parseInt(component.get("v.hourHeight"));
        var realTimePad = (today.getHours())*hourHeight + (today.getMinutes()/60)*hourHeight;
        component.set("v.realTimePad", realTimePad);
        if(today.getHours() == 0 && today.getMinutes() == 0) {
            this.setFocus(component, event, helper);
        }
        this.realTimeScroll(component, event, helper);
	},
	
    // invoked periodically for updating time
	renderClock : function(component, event, helper, today) {
		var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        var mins;
        component.set("v.hour", helper.formatHours(event, helper, today));
        component.set("v.minute", helper.formatMinutes(event, helper, today));
        component.set("v.second", today.getSeconds());
    },
	
    // invoked on initial load to render Y-axis values of Calendar
	renderCalendar : function(component, event, helper) {	
		var hoursList = component.get("v.hoursList");
        var i;
        for(i = 0; i < 24; i++) {
            var formattedHours;
            if(String(i).length == 1) {
                formattedHours = "0" + i + ":00";
            }
            else{
                formattedHours = i + ":00";
            }
            hoursList.push(formattedHours);
        }
		component.set("v.hoursList", hoursList);	
	},
	
    // Invoked periodically to fetch updated bookings
	fetchBookings : function(component, event, helper, today) {
        var selectedResource = component.get("v.selectedResource");
        var bookingsAction = component.get("c.fetchBookings");
        bookingsAction.setParams({
            "selectedResourceId": selectedResource.Id
        });
        bookingsAction.setCallback(this, function(response) {
            var bookingList = [];
            if(response.getState() === 'SUCCESS') {
                bookingList = response.getReturnValue();
            }
			component.set("v.bookingList", bookingList);
            this.createBookingWrapperRecords(component, event, helper, today);
        });
        $A.enqueueAction(bookingsAction);
    },
	
    // Creates booking wrapper records from B25__Reservation__c records
    // Does the height and width calculations of reservation blocks
    // Checks if the current time overlaps with any booking and marks it as BOOKED
    // Fetches immediate previous and next reservations
	createBookingWrapperRecords : function(component, event, helper, today) {
        var bookingWrapperList = [];
        var currentBookingIndex = 0;
        var loopIndex = 0;
        var resourceBooked = false;
        var bookingList = component.get("v.bookingList");
        var currentTime = helper.formatHours(event, helper, today) + ":" + helper.formatMinutes(event, helper, today);
		var hourHeight = parseInt(component.get("v.hourHeight"));      
        
        bookingList.forEach(function(booking) {
            var minOffset;
            var bookingWrapper = {
                "duration": "",
                "name": "",
                "startTime": "",
                "startHour": "",
                "endHour": "",
                "endTime": "",
                "offset": ""
        	}
            // populate values here			
			bookingWrapper.name = booking.B25__Title__c;
            bookingWrapper.startTime = booking.B25__Local_Start_Time__c; 
            bookingWrapper.startHour = bookingWrapper.startTime.split(":")[0].concat(":00");
            
            var normalizedOffset = parseInt(bookingWrapper.startTime.split(":")[1]);
            
            if(loopIndex > 0 && bookingWrapperList[loopIndex-1].startHour == bookingWrapper.startHour) {
                var previousRecord = bookingWrapperList[loopIndex-1];
                normalizedOffset = normalizedOffset - ((previousRecord.duration + previousRecord.offset)*60)/hourHeight;
            }
            
            if(booking.B25__Local_End_Time__c == '00:00') {
                bookingWrapper.endTime = '23:59'; 
       		}
            else {
            	bookingWrapper.endTime = booking.B25__Local_End_Time__c;    
            }
            bookingWrapper.endHour = bookingWrapper.endTime.split(":")[0].concat(":00"); 
            //bookingWrapper.offset = (parseInt(bookingWrapper.startTime.split(":")[1])/60)*hourHeight;
            bookingWrapper.offset = (normalizedOffset/60)*hourHeight; 
            
            var hourDiff = bookingWrapper.endTime.split(":")[0] - bookingWrapper.startTime.split(":")[0]; 
            bookingWrapper.duration = parseInt(hourDiff)*hourHeight + ((parseInt(bookingWrapper.endTime.split(":")[1]) - parseInt(bookingWrapper.startTime.split(":")[1]))/60)*hourHeight;
            
            if(helper.isResourceBooked(helper, bookingWrapper.startTime, bookingWrapper.endTime, currentTime)) {
                resourceBooked = true;
             	component.set("v.resourceAvailableColor", "red");
            }
            
            if(booking.B25__Local_End_Time__c == '00:00') {
                bookingWrapper.endTime = '00:00'; 
       		}
            
            bookingWrapperList.push(bookingWrapper);
            loopIndex++;
        });
        
        if(resourceBooked == false) {
            component.set("v.resourceAvailableColor", "green");
        }
        component.set("v.bookingList", bookingWrapperList);
        helper.getImmediateBookings(component, event, helper, bookingWrapperList, currentTime);
    },
    
    // Checks if the current looping resource is booked
    isResourceBooked : function(helper, startTime, endTime, currentTime) {
        if(startTime <= currentTime && currentTime < endTime) {
            return true;
        }
        return false;
    },
    
    // Gets the immediate previous and next bookings relevant to current time
    getImmediateBookings : function(component, event, helper, bookingWrapperList, currentTime) {
        
        var currentBookingIndex = 0;
        var previousBooking;
        var nextBooking;
        var currentBooking;
        var i;
        var previousIndex = -1;
        for(i = 0; i < bookingWrapperList.length; i++) {
            if(helper.isResourceBooked(helper, bookingWrapperList[i].startTime, bookingWrapperList[i].endTime, currentTime)) { 
                if(previousIndex != -1) {
                	previousBooking = bookingWrapperList[previousIndex];    
                }
                if(i < bookingWrapperList.length - 1) {
                	nextBooking = bookingWrapperList[i + 1];
                }
                currentBooking = bookingWrapperList[i];
                break;
            }
            else {
                if(bookingWrapperList[i].startTime > currentTime){
                    nextBooking = bookingWrapperList[i];
                    if(previousIndex != -1) {
                        previousBooking = bookingWrapperList[previousIndex];    
                    }
                    break;
                }
                else if(bookingWrapperList[i].endTime < currentTime
                           && i == bookingWrapperList.length - 1) {
                    previousBooking = bookingWrapperList[i];
                    break;
                }  
            }
            
            previousIndex++;
        }
        component.set("v.previousBooking", previousBooking);
        component.set("v.nextBooking", nextBooking);
        component.set("v.currentBooking", currentBooking);
    },
    
    // Converts number of minutes in correct format
    formatMinutes : function(event, helper, today) {
        var mins = today.getMinutes();
        if(String(mins).length == 1) {
            var formattedMins = "0" + mins;
            return formattedMins;
        }
        else{
            return mins;
        }
    },
    
    // Converts number of hours in correct format
    formatHours : function(event, helper, today) {
        var hours = today.getHours();
        if(String(hours).length == 1) {
            var formattedHours = "0" + hours;
            return formattedHours;
        }
        else{
            return hours;
        }
    },
    
    // Scrolls down to the view with red line on the calendar
    // Invoked only at initial load
    setFocus : function(component, event, helper) {
        var currentDay = new Date();
        console.log("setFocus:: ");
        var timeIndicator = document.getElementById("timeIndicator");
        var realTimePad = component.get("v.realTimePad");
        var height = window.innerHeight
            || document.documentElement.clientHeight
            || document.body.clientHeight;
            console.log('height:: ' + height);
        var focusMargin;
        if(timeIndicator !== null) {
        	timeIndicator.scrollIntoView();  
        }
        if(parseInt(currentDay.getHours()) <= 12) {
        	focusMargin = parseInt(realTimePad) + height/2;
        }
        else if(parseInt(currentDay.getHours()) <= 16) {
        	focusMargin = parseInt(realTimePad) + height/3;
        }
        else if(parseInt(currentDay.getHours()) <= 18) {
        	focusMargin = parseInt(realTimePad) + height/4;
        }
        else if(parseInt(currentDay.getHours()) <= 19) {
        	focusMargin = parseInt(realTimePad); //+ height/5;
        }
        else if(parseInt(currentDay.getHours()) <= 23) {
        	focusMargin = parseInt(realTimePad) - height/6;
        }
		window.scrollBy(0, -focusMargin);
        component.set("v.programaticScroll", true);
    },
    
    // scrolling browser real time
    realTimeScroll : function(component, event, helper) {
        //var hourHeight = component.get("v.hourHeight")
        window.scrollBy(0, 2);
        component.set("v.programaticScroll", true);
    },
        
    addTouchEvent : function(component, event, helper) {
        console.log("adding Touch Event");
        var initialLoad = component.get("v.initialLoad");
        if(initialLoad == true) {
            // scroll event
            document.addEventListener('scroll', function(e){
                var programaticScroll = component.get("v.programaticScroll");
                if(programaticScroll == false) {
                    var timeoutHandle = component.get("v.timeoutHandle");   
                    if(timeoutHandle != null && timeoutHandle != '') {
                        console.log("clear timeout");
                        clearTimeout(timeoutHandle);
                	}
                    
                    //if(timeoutHandle != null && timeoutHandle != '') {
                    var newTimeoutHandle = setTimeout(function(){
                        helper.setFocus(component,event,helper);
                        component.set("v.timeoutHandle", '');
                    }, 300000); //300000
                    component.set("v.timeoutHandle", newTimeoutHandle);  
                    //}
                }
                else {
                    component.set("v.programaticScroll", false);
                }
            });
            
        }
     }
})