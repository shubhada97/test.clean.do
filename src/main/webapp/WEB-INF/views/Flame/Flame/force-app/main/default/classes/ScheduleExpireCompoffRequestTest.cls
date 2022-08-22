@isTest
public class ScheduleExpireCompoffRequestTest {
    static testMethod void method(){
        SchedulableContext sc = null;
        ScheduleExpireCompoffRequest secr = new ScheduleExpireCompoffRequest();
        secr.execute(sc);
    }
}