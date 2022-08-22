@isTest

public class LeaveLedgerUpdatesTest {
    @isTest
    public static void testMethod99(){    
        
        Account testAccount1 = new Account();
        testAccount1.Name='DCCLreeefwwkkdff';
        insert testAccount1;
        
        
        Contact testContact = new Contact();
        testContact.AccountId = testAccount1.id;
        testContact.LastName = 'dwqqddw';
        testContact.Earned_Leave_Balance__c = 10;
        testContact.Casual_Leave_Balance__c = 5;
        testContact.Maternity_Paternity_Leave_Balance__c = 20;
        testContact.Faculty_Researching_and_Consulting__c = 10;
        testContact.CompOff_Balance__c = 10;
        insert testContact;
        
        
        
        Leave_Ledger__c testLedger = new Leave_Ledger__c();
        testLedger.Employee_Name__c = testContact.id;
        testLedger.Status__c = 'Approved';
        testLedger.Leave_Type__c = 'Casual Leave';
        testLedger.From_Date__c = System.today().addDays(2);
        testLedger.To_Date__c = System.today().addDays(2);
        testLedger.Reason__c = 'tutt';
        testledger.Total_Days__c = 1;
        insert testLedger;
        /*
        Map<Id,Contact> mapCon = new Map<Id,Contact>([SELECT Id, Earned_Leave_Balance__c, Casual_Leave_Balance__c,Maternity_Paternity_Leave_Balance__c,Faculty_Researching_and_Consulting__c,CompOff_Balance__c FROM Contact WHERE id =:testContact.id]);
        Map<Id,Contact> mapCon2 = new Map<Id,Contact>();
        mapCon.put(testContact.id,testContact);
        */
        Leave_Ledger__c testLedger1 = new Leave_Ledger__c();
        testLedger1.Employee_Name__c = testContact.id;
        testLedger1.Status__c = 'Approved';
        testLedger1.Leave_Type__c = 'Earned Leave';
        testLedger1.From_Date__c = System.today().addDays(3);
        testLedger1.To_Date__c = System.today().addDays(3);
        testLedger1.Reason__c = 'ttt';
        testledger1.Total_Days__c = 1;
        insert testLedger1;
        
        Leave_Ledger__c testLedger2 = new Leave_Ledger__c();
        testLedger2.Employee_Name__c = testContact.id;
        testLedger2.Status__c = 'Approved';
        testLedger2.Leave_Type__c = 'Paternity Leave';
        testLedger2.From_Date__c = System.today().addDays(4);
        testLedger2.To_Date__c = System.today().addDays(4);
        testLedger2.Reason__c = 'ttt';
        testLedger2.Total_Days__c = 1;
        insert testLedger2;
        
        Leave_Ledger__c testLedger3 = new Leave_Ledger__c();
        testLedger3.Employee_Name__c = testContact.id;
        testLedger3.Status__c = 'Approved';
        testLedger3.Leave_Type__c = 'Maternity Leave';
        testLedger3.From_Date__c = System.today().addDays(5);
        testLedger3.To_Date__c = System.today().addDays(5);
        testLedger3.Reason__c = 'ttt';
        testLedger3.Total_Days__c = 1;
        insert testLedger3;
        
        Leave_Ledger__c testLedger4 = new Leave_Ledger__c();
        testLedger4.Employee_Name__c = testContact.id;
        testLedger4.Status__c = 'Approved';
        testLedger4.Leave_Type__c = 'Consulting Leave';
        testLedger4.From_Date__c = System.today().addDays(6);
        testLedger4.To_Date__c = System.today().addDays(6);
        testLedger4.Reason__c = 'ttt';
        testLedger4.Total_Days__c = 1;
        insert testLedger4;
        
        Leave_Ledger__c testLedger5 = new Leave_Ledger__c();
        testLedger5.Employee_Name__c = testContact.id;
        testLedger5.Status__c = 'Approved';
        testLedger5.Leave_Type__c = 'Researching Leave';
        testLedger5.From_Date__c = System.today().addDays(-2);
        testLedger5.To_Date__c = System.today().addDays(-2);
        testLedger5.Reason__c = 'ttt';
        testLedger5.Total_Days__c = 1;
        insert testLedger5;
        
        
        Leave_Ledger__c testLedger8 = new Leave_Ledger__c();
        testLedger8.Employee_Name__c = testContact.id;
        testLedger8.Status__c = 'Approved';
        testLedger8.Leave_Type__c = 'CompOff Request';
        testLedger8.From_Date__c = System.today().addDays(-4);
        testLedger8.To_Date__c = System.today().addDays(-4);
        testLedger8.Reason__c = 'ttt';
        testLedger8.Total_Days__c = 1;
        insert testLedger8;
        
        Leave_Ledger__c testLedger7 = new Leave_Ledger__c();
        testLedger7.Employee_Name__c = testContact.id;
        testLedger7.Status__c = 'Approved';
        testLedger7.Leave_Type__c = 'CompOff Leave';
        testLedger7.From_Date__c = System.today().addDays(-3);
        testLedger7.To_Date__c = System.today().addDays(-3);
        testLedger7.Reason__c = 'ttt';
        testLedger7.Total_Days__c = 1;
        testLedger7.CompOff_Request_Reference__c = testLedger8.id;
        insert testLedger7;
        
        
        Leave_Ledger__c testLedger11 = new Leave_Ledger__c();
        testLedger11.Employee_Name__c = testContact.id;
        testLedger11.Status__c = 'Cancelled';
        testLedger11.Leave_Type__c = 'Earned Leave';
        testLedger11.From_Date__c = System.today().addDays(3);
        testLedger11.To_Date__c = System.today().addDays(3);
        testLedger11.Reason__c = 'ttt';
        testledger11.Total_Days__c = 1;
        insert testLedger11;
        
        Leave_Ledger__c testLedger12 = new Leave_Ledger__c();
        testLedger12.Employee_Name__c = testContact.id;
        testLedger12.Status__c = 'Cancelled';
        testLedger12.Leave_Type__c = 'Paternity Leave';
        testLedger12.From_Date__c = System.today().addDays(4);
        testLedger12.To_Date__c = System.today().addDays(4);
        testLedger12.Reason__c = 'ttt';
        testLedger12.Total_Days__c = 1;
        insert testLedger12;
        
        Leave_Ledger__c testLedger13 = new Leave_Ledger__c();
        testLedger13.Employee_Name__c = testContact.id;
        testLedger13.Status__c = 'Cancelled';
        testLedger13.Leave_Type__c = 'Maternity Leave';
        testLedger13.From_Date__c = System.today().addDays(5);
        testLedger13.To_Date__c = System.today().addDays(5);
        testLedger13.Reason__c = 'ttt';
        testLedger13.Total_Days__c = 1;
        insert testLedger13;
        
        Leave_Ledger__c testLedger14 = new Leave_Ledger__c();
        testLedger14.Employee_Name__c = testContact.id;
        testLedger14.Status__c = 'Cancelled';
        testLedger14.Leave_Type__c = 'Consulting Leave';
        testLedger14.From_Date__c = System.today().addDays(6);
        testLedger14.To_Date__c = System.today().addDays(6);
        testLedger14.Reason__c = 'ttt';
        testLedger14.Total_Days__c = 1;
        insert testLedger14;
        
        Leave_Ledger__c testLedger15 = new Leave_Ledger__c();
        testLedger15.Employee_Name__c = testContact.id;
        testLedger15.Status__c = 'Cancelled';
        testLedger15.Leave_Type__c = 'Researching Leave';
        testLedger15.From_Date__c = System.today().addDays(-2);
        testLedger15.To_Date__c = System.today().addDays(-2);
        testLedger15.Reason__c = 'ttt';
        testLedger15.Total_Days__c = 1;
        insert testLedger15;
        
        Leave_Ledger__c testLedger18 = new Leave_Ledger__c();
        testLedger18.Employee_Name__c = testContact.id;
        testLedger18.Status__c = 'Cancelled';
        testLedger18.Leave_Type__c = 'CompOff Request';
        testLedger18.From_Date__c = System.today().addDays(-4);
        testLedger18.To_Date__c = System.today().addDays(-4);
        testLedger18.Reason__c = 'ttt';
        testLedger18.Total_Days__c = 1;
        insert testLedger18;
        
        
        Leave_Ledger__c testLedger17 = new Leave_Ledger__c();
        testLedger17.Employee_Name__c = testContact.id;
        testLedger17.Status__c = 'Cancelled';
        testLedger17.Leave_Type__c = 'CompOff Leave';
        testLedger17.From_Date__c = System.today().addDays(-3);
        testLedger17.To_Date__c = System.today().addDays(-3);
        testLedger17.Reason__c = 'ttt';
        testLedger17.Total_Days__c = 1;
        testLedger17.CompOff_Request_Reference__c = testLedger18.id;
        insert testLedger17;
        
        list<Leave_Ledger__c> ledList = [Select Employee_Name__c,Status__c,CompOff_Request_Reference__c,Reason__c,Total_Days__c,Half_Day__c,Leave_Type__c,Leave_Action__c,RecordTypeId,RecordType.Name,From_Date__c,To_Date__c from Leave_Ledger__c ];
        
        /*
        list<Leave_Ledger__c> ledList1 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger.id];
        list<Leave_Ledger__c> ledList2 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger2.id];
        list<Leave_Ledger__c> ledList3 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger3.id];
        
        list<Leave_Ledger__c> ledList4 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger4.id];
        list<Leave_Ledger__c> ledList5 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger5.id];
        list<Leave_Ledger__c> ledList7 = [Select Employee_Name__c,Status__c,Reason__c,Total_Days__c,Leave_Type__c from Leave_Ledger__c where id=:testLedger7.id];
        */
        Test.startTest();
        /*
        testContact.Earned_Leave_Balance__c = testContact.Earned_Leave_Balance__c -testLedger1.Total_Days__c;
        testContact.Casual_Leave_Balance__c = testContact.Casual_Leave_Balance__c -testLedger1.Total_Days__c;
        testContact.Maternity_Paternity_Leave_Balance__c = testContact.Maternity_Paternity_Leave_Balance__c -testLedger1.Total_Days__c;
        testContact.Faculty_Researching_and_Consulting__c = testContact.Faculty_Researching_and_Consulting__c -testLedger1.Total_Days__c;
        testContact.CompOff_Balance__c = testContact.CompOff_Balance__c -testLedger1.Total_Days__c;
        Update testContact;
        mapCon2.put(testContact.id,testContact);
        
        */
        
        LeaveLedgerUpdates.UpdateRelatedContact(ledList);
        
        /*
        LeaveLedgerUpdates.UpdateRelatedContact(ledList1);
        LeaveLedgerUpdates.UpdateRelatedContact(ledList2);
        LeaveLedgerUpdates.UpdateRelatedContact(ledList3);
        LeaveLedgerUpdates.UpdateRelatedContact(ledList4);
        LeaveLedgerUpdates.UpdateRelatedContact(ledList5);
        LeaveLedgerUpdates.UpdateRelatedContact(ledList7);
        
        
        list<Contact> ContctList = [Select Earned_Leave_Balance__c,Casual_Leave_Balance__c,Maternity_Paternity_Leave_Balance__c,Faculty_Researching_and_Consulting__c,CompOff_Balance__c from contact where id=:testContact.id];
        ContctList[0].Earned_Leave_Balance__c = testContact.Earned_Leave_Balance__c;
        ContctList[0].Casual_Leave_Balance__c = testContact.Casual_Leave_Balance__c;
        ContctList[0].Maternity_Paternity_Leave_Balance__c = testContact.Maternity_Paternity_Leave_Balance__c;
        ContctList[0].Faculty_Researching_and_Consulting__c = testContact.Faculty_Researching_and_Consulting__c;
        ContctList[0].CompOff_Balance__c = testContact.CompOff_Balance__c;
        Update ContctList;
        ContctList.add(testContact);
        */
        Test.stopTest();
        
        
        
        
        
    }
    
}