@isTest
public class Flame_WeekEndsHolidayBatchTest {
    @isTest
    static void deTest1(){
        Test.startTest();
        String customMetadata = 'All Leave Configurations for Employee';
        Leave_Setting__mdt leaveSettingObj = [SELECT Id,Weekly_Saturday_Holiday__c FROM Leave_Setting__mdt where Label =: customMetadata];
        Flame_WeekEndsHolidayBatch batch = new Flame_WeekEndsHolidayBatch();
        Database.executeBatch(batch);
        
        try{
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void deTest2(){
        Test.startTest();
        String customMetadata = 'All Leave Configurations for Employee';
        Leave_Setting__mdt leaveSettingObj = [SELECT Id,Weekly_Saturday_Holiday__c FROM Leave_Setting__mdt where Label =: customMetadata];
        Flame_WeekEndsHolidayBatch batch = new Flame_WeekEndsHolidayBatch();
        Database.executeBatch(batch);
        
        try{
        }catch(Exception ex){
            System.debug('exception'+ex.getMessage());
        }
        Test.stopTest();
    }
}