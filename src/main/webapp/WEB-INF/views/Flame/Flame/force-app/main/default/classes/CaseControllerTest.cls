@isTest
public class CaseControllerTest {
 /*   public static testMethod void validateCaseController(){
        String dTime = String.valueOf(System.today());
        v1Location__c objLocation = new v1Location__c(Name = 'Test');
        insert objLocation;
        RecordType objRecord = [Select Id, Name from RecordType where Name = 'Requisition' limit 1];
        RecordType objRecordHelp = [Select Id, Name from RecordType where Name = 'Help Desk' limit 1];
        
        Case objCase = new Case(RQN_Message__c = 'Test',Status = 'New', Subject = 'Test', Message__c = 'Test', HLP_Category__c ='Request',
                                TRL_Departure_Pickup_Time__c = dTime,TRL_Department__c = 'Accounts', TRL_Return_Pickup_Time__c = dTime,
                                TRL_Departure_Date__c = System.today(), TRL_Departure_Pickup_Location__c = 'test', HLP_Floor__c = '2nd Floor', //HLP_Location__c = , 
                                HLP_Mobile_No__c = '41656456', TRL_Mode_Of_Travel__c = 'Train', RQN_Purpose__c = 'Test',
                                TRL_Purpose_Of_The_Visit__c = 'TEst',RQN_Requesting_On_Behalf_Of__c = 'TEst', RQN_Requisition_Date__c = System.today(),
                                TRL_Requisition_For__c = 'Self', RQN_Requisition_Type__c = 'Electrical',TRL_Return_Date__c = System.today(),
                                TRL_Return_Pickup_Location__c = 'Test', HLP_Room__c = '101', /*HLP_Sub_Category__c = 'Laundry',*//* TRL_Traveler_Email__c = 'test@demo.com',
                            /*    TRL_Traveler_Mobile__c = '4165456645', TRL_Traveler_Name__c = 'Test', TRL_Travel_From__c = 'Pune', TRL_Travel_To__c = 'Mumbai',
                                RQN_Your_Department__c = 'Accounts');
        insert objCase;
        
        Item__c objItem = new Item__c(Case__c = objCase.Id,Quantity__c = 1, Item_Description__c = 'Test');
        insert objItem;
        
        ApexPages.currentPage().getParameters().put('RecordType',objRecord.Id);
        //ApexPages.currentPage().getParameters().put('id',objCase.Id);
        
     /*   CaseController objCaseController = new CaseController(new ApexPages.StandardController(objCase));
        objCaseController.strSelected = objLocation.Name;
        objCaseController.addRow();
        objCaseController.saveItem();
        objCaseController.doCancel();
        objCaseController.backForm();
        objCaseController.selectAll();
        objCaseController.del();
        objCaseController.helpOn();
        objCaseController.travelOn();
        objCaseController.requisitionOn();
        objCaseController.getBannerTextLabel();
        CaseController.getHasTwitterFeed();
        CaseController.getTwitterDataWidgetId();
        CaseController.getTwitterHandle();
        objCaseController.getContactIDfromUser();
        
        ApexPages.currentPage().getParameters().put('RecordType',objRecordHelp.Id);
        //ApexPages.currentPage().getParameters().put('id',objCase.Id);
        
        CaseController objCaseController1 = new CaseController(new ApexPages.StandardController(objCase));
        objCaseController1.saveItem();
    }
    
    public static testMethod void validateCaseController1(){
        String dTime = String.valueOf(System.today());
        v1Location__c objLocation = new v1Location__c(Name = 'Test');
        insert objLocation;
        RecordType objRecord = [Select Id, Name from RecordType where Name = 'Requisition' limit 1];
        
        Case objCase = new Case(RQN_Message__c = 'Test',Status = 'New', Subject = 'Test', Message__c = 'Test', HLP_Category__c ='Request',
                                TRL_Departure_Pickup_Time__c = dTime,TRL_Department__c = 'Accounts', TRL_Return_Pickup_Time__c = dTime,
                                TRL_Departure_Date__c = System.today(), TRL_Departure_Pickup_Location__c = 'test', HLP_Floor__c = '2nd Floor', //HLP_Location__c = , 
                                HLP_Mobile_No__c = '41656456', TRL_Mode_Of_Travel__c = 'Train', RQN_Purpose__c = 'Test',
                                TRL_Purpose_Of_The_Visit__c = 'TEst',RQN_Requesting_On_Behalf_Of__c = 'TEst', RQN_Requisition_Date__c = System.today(),
                                TRL_Requisition_For__c = 'Self', RQN_Requisition_Type__c = 'Electrical',TRL_Return_Date__c = System.today(),
                                TRL_Return_Pickup_Location__c = 'Test', HLP_Room__c = '101', /*HLP_Sub_Category__c = 'Laundry',*//* TRL_Traveler_Email__c = 'test@demo.com',
                            /*    TRL_Traveler_Mobile__c = '4165456645', TRL_Traveler_Name__c = 'Test', TRL_Travel_From__c = 'Pune', TRL_Travel_To__c = 'Mumbai',
                                RQN_Your_Department__c = 'Accounts',RecordTypeId = objRecord.Id);
        insert objCase;
        
        Item__c objItem = new Item__c(Case__c = objCase.Id,Quantity__c = 1, Item_Description__c = 'Test');
        insert objItem;
        
        //ApexPages.currentPage().getParameters().put('RecordType',objRecord.Id);
        ApexPages.currentPage().getParameters().put('id',objCase.Id);
        
        CaseController objCaseController = new CaseController(new ApexPages.StandardController(objCase));
        objCaseController.strSelected = objLocation.Name;
        objCaseController.addRow();
        //objCaseController.saveItem();
        objCaseController.doCancel();
        objCaseController.backForm();
        objCaseController.selectAll();
        objCaseController.del();
        objCaseController.helpOn();
        objCaseController.travelOn();
        objCaseController.requisitionOn();
        objCaseController.getBannerTextLabel();
        CaseController.getHasTwitterFeed();
        CaseController.getTwitterDataWidgetId();
        CaseController.getTwitterHandle();
        objCaseController.getContactIDfromUser();
    }*/
}