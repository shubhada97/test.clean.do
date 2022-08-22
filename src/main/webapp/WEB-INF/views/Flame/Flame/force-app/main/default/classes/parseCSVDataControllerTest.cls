@isTest
public class parseCSVDataControllerTest {
	 static String str = 'Timelog__c,Event_Type__c,Severity__c,Message__c,User_Name__c,Source__c,Status__c\n 2022-06-28 22:22:00,Firewall Authentication,Information,User aadhya.desai was logged out of firewall,abhi.skprasad1,172.16.155.96,Successful\n 2022-06-28 12:22:00,Firewall Authentication,Information,User aadhya.desai was logged out of firewall,k.vedanti666,172.16.155.96,Successful';       

    public static String[] csvFileLines;
    public static Blob csvFileBody;

    static testmethod void testfileupload(){
        Test.startTest();       
            csvFileBody = Blob.valueOf(str);
            String csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n'); 
    
            parseCSVDataController importData = new parseCSVDataController();
            importData.csvFileBody = csvFileBody;
            importData.importCSVFile();
        Test.stopTest();
    } 

    static testmethod void testfileuploadNegative(){
        Test.startTest();       
            csvFileBody = Blob.valueOf(str);
            String csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n'); 
    
            parseCSVDataController importData = new parseCSVDataController();
            importData.importCSVFile();
        Test.stopTest();
    }
}