/**
This test class provide code coverage for Apex class SendAdmitCard
*/
@isTest

private class SendAdmitCardTriggerTest{
    /*
        This method will invoke SendAdmitCard Trigger logic
    */
    static testMethod  void sendAdmitCardTest(){
        
        //Create Contact
        Contact cont = new Contact();
        cont.lastName = 'TestContact123';
        cont.email = 'test@test.com';
        insert cont;
        
        //Create program Name
        Program__c program =  new Program__c();
        program.Name = 'TestProgram';
        insert program;
        
        //Create Admission Cycle
        GD_and_PI_Round__c roundc = new GD_and_PI_Round__c();
        roundc.Name = 'TestGD';
        roundc.Program__c= program.id;
        insert roundc;
        
        //Create Application
        
        Application__c application = new Application__c();
        application.Program__c = program.id;
        application.FUI_GD_and_PI_Round__c = roundc.id;
        application.Contact__c = cont.id;
        insert application;
        
        //Create Admit Card entry/record
        Admit_Card__c admitCard =  new Admit_Card__c();
        admitCard.Name = 'AdmitCard123';
        admitCard.FUA_Broadcast_Admit_Card__c = true;
        admitCard.Application__C = application.id;
        admitCard.Contact__c = cont.id;
        insert admitCard;
        
        //Update Admit Card entry/record
        Admit_Card__c  admitCardDetails = [Select id,name from Admit_Card__c  where Name = 'AdmitCard123' limit 1];
        admitCardDetails.Name = 'AdmitCard1234';
        update admitCardDetails;
        
    }
}