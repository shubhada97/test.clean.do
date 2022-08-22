global class ScheduleExpireCompoffRequest implements Schedulable {
    global void execute(SchedulableContext SC) {
        ExpireCompoffRequestBatch ecr = new ExpireCompoffRequestBatch();
        database.executebatch(ecr);
    }
}