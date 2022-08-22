global class BirthdayNotificationSchedullingClass implements schedulable
{
global void execute(schedulableContext CTX)
{
    BirthdayNotificationBatchClass renewalOppBatch = new BirthdayNotificationBatchClass();
    Database.executeBatch(renewalOppBatch,200);
   
    }
    }