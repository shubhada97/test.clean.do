global class syncEmployeeCalendarFromWifiCron implements Schedulable {
	global void execute(SchedulableContext sc) {
		syncEmployeeCalendarFromWifi getRecords = new syncEmployeeCalendarFromWifi();
		getRecords.getWifiTodayData();
        //getRecords.deleteDateData();
	}
}