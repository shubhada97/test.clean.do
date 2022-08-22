global class Flame_WeekEndsHolidayBatchSchedule implements Schedulable {
    global void execute(SchedulableContext SC) {
        Flame_WeekEndsHolidayBatch ecr = new Flame_WeekEndsHolidayBatch();
        database.executebatch(ecr);
    }
}