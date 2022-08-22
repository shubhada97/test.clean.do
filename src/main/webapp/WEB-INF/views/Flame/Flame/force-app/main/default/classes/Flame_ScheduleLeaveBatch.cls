global class Flame_ScheduleLeaveBatch implements System.Schedulable{
    
    global void execute(SchedulableContext SC) {
        Flame_LeaveLedgerBatch obj = new Flame_LeaveLedgerBatch();
        database.executebatch(obj);
    }
}