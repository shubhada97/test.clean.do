global class auditLogTrackerCron implements Schedulable {
	global void execute(SchedulableContext sc) {
		auditLogsTracker logScanner = new auditLogsTracker();
		logScanner.parseAuditLogs();
	}
}