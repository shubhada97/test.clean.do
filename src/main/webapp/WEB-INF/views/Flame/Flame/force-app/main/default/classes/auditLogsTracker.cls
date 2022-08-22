public class auditLogsTracker {
	// lookback period
	private static integer lookbackHoursPeriod = -1;
	// List of Salesforce user ids to send the email to
	//private static List<String> sendEmailto = new List<String> {'deepak.parihar@techilaservices.com','prashik.lokhande@techilaservices.com'};
    private static List<String> sendEmailto = new List<String> {'mukesh.joshi@flame.edu.in'};
    // List of CC Email address
    private static List<String> sendEmailCC = new List<String> {'deepak.parihar@techilaservices.com','prashik.lokhande@techilaservices.com'};    
	// List of sections to ignore from the audit log events
	private static Set<String> ignoreSections = new Set<String> {'Manage Users','Custom Metadata Types','Custom Objects'};
	// List of users to monitor
	//private static List<String> usersToMonitor = new List<String> {'harshal@techilaservices.com.techila'};
    //private static List<String> usersToMonitor = new List<String> {'abhinav.kumar@flame.edu.in.techilapp','flame@techilaservices.com.techilapp','harshal@techilaservices.com.techila'};
	// Email subject
	private static String emailSubject = 'Details - Changes has occured in Production';	 
    
	/*
		Sends an email to the Salesforce users defined by sendEmailTo

		@param body
		List of Strings to create the body of the email
	*/
	public void sendEmailMessage(List<String> body) {
	
      List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>{};
      List<Audit_Logs_Tracker__mdt> queryRecords = [Select ID, Email_Subject__c,Sender_Display_Name__c, Reply_To__c, Receiver_Email__c from Audit_Logs_Tracker__mdt];
      //sendTo.add(sendEmailto);
      
      OrgWideEmailAddress orgWideEmailAddress = [SELECT Id FROM OrgWideEmailAddress WHERE Address =: 'admission@flame.edu.in' Limit 1];
      System.debug('orgWideEmailAddress:'+orgWideEmailAddress); 
      System.debug('orgWideEmailId:'+orgWideEmailAddress.Id); 
      for (Audit_Logs_Tracker__mdt query: queryRecords) {
          sendTo.add(query.Receiver_Email__c);
          mail.setToAddresses(sendTo);
          System.debug('sendTo:' + sendTo);
          mail.setReplyTo(query.Reply_To__c);
          //mail.setOrgWideEmailAddressId(orgWideEmailAddress.Id);
          mail.setSenderDisplayName(query.Sender_Display_Name__c);
          //List<String> ccTo = new List<String>();
          //ccTo.add('harshal@techilaservices.com');
          //mail.setCcAddresses(sendEmailCC);
          mail.setSubject(query.Email_Subject__c);
          //mail.setOrgWideEmailAddressId(orgWideEmailAddress.Id);
          allMails.add(mail);
          //Set Org Wide Email Address Id
	  	  
      }
		// Construct the Single Email Message
		
		String messageBody = String.join(body, '\n\n');
		mail.htmlbody = messageBody;
		try {
			// Do not check for errors as nothing to do in that case
			system.debug('try:'+messageBody);
            Messaging.sendEmail(allMails); 
			//Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
		} catch(System.CalloutException e) {
			System.debug('ERROR:' + e);
		}
	}

	/*
		Get the audit log events that occured in a lookback 
		period and were triggered by specific users
		
		The default lookback period (lookbackHoursPeriod) is one hour
		This method calls sendEmailMessage to send an email with the events
	*/
	public void parseAuditLogs() {
        DateTime dt;
        List<String> usersToMonitorList = new List<String>{};
        List<User> usersToMonitors = [Select Username from User Where Profile.Name =:'System Administrator' AND IsActive =: true];
        List<Audit_Logs_Tracker__mdt> queryRecords = [Select ID, User_To_Monitor__c,Hours_Period__c, Manage_Sections__c from Audit_Logs_Tracker__mdt];
        for (Audit_Logs_Tracker__mdt query: queryRecords) {
            dt = System.Now().addHours(Integer.valueof(query.Hours_Period__c));
            system.debug('Hours_Period:'+Integer.valueof(query.Hours_Period__c)); 
        }
        
        for (User user: usersToMonitors) {
            usersToMonitorList.add(user.Username);
        }
		
		system.debug('dt:'+dt);
        system.debug('usersToMonitorList:'+usersToMonitorList);
		// run SOQL on SetupAuditTrail filtering on UserName and CreatedDate
		//List<SetupAuditTrail> queryResults = [SELECT CreatedDate, CreatedBy.UserName,Action, Section, Display FROM SetupAuditTrail WHERE CreatedBy.UserName IN :usersToMonitor AND CreatedDate >=:dt ORDER BY CreatedDate DESC];
        List<SetupAuditTrail> queryResults = [SELECT CreatedDate, CreatedBy.UserName,Action, Section, Display FROM SetupAuditTrail WHERE CreatedBy.UserName IN :usersToMonitorList AND CreatedDate >=:dt ORDER BY CreatedDate DESC];
		system.debug('queryResults:'+queryResults);
        if (queryResults.isEmpty()) {
			return;
		}

		// parse the query to build the body for the email
		List<String> emailBodyList = new List<String>();
        String emailLine = '';
        String actionData ='';
        String customObject1 ='Applications';
        String customObject2 ='Education Details';
		for (SetupAuditTrail log: queryResults) {
		    actionData = log.Display;
            system.debug('Application Condition:'+actionData.contains(customObject1));
            system.debug('Education Condition:'+actionData.contains(customObject2));
            system.debug('Section Condition:'+ignoreSections.contains(log.section));
            //Get current date time in GMT format

			//Convert it into Indian Standard Time(dtIST).
			String istTime = log.CreatedDate.format('yyyy-MM-dd HH:mm:ss', 'IST');
            
			if (ignoreSections.contains(log.section) || (actionData.contains(customObject1) || actionData.contains(customObject2))) {
				emailLine = '<b>User: </b>' + log.CreatedBy.UserName + '<br/><b>Section: </b>' + log.Section + '<br/><b> Action: </b>' + log.Action + '<br/><b> Details: </b>' + log.Display+'<br/><b> Modified DateTime: </b>' + istTime+'<br/><br/>';
            	system.debug('emailLine:'+emailLine);
				emailBodyList.add(emailLine);
            	system.debug('emailBodyList:'+emailBodyList);
           }
		}
		if (!emailBodyList.isEmpty()) {
            system.debug('sendEmailMessage');
			sendEmailMessage(emailBodyList);
		}
	}
}