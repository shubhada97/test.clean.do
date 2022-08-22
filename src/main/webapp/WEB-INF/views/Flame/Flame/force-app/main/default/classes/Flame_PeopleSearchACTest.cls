@isTest
public class Flame_PeopleSearchACTest {
    
    public static testMethod void PropleSearch(){                
        
        
        Community_Assist__c ca = new Community_Assist__c();
        ca.Name = 'People Search';
        ca.Record_Type__c = 'FU-Employee';
        ca.Tab_Type__c = 'People Search';
        insert ca;
        
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contact con = new Contact();
        con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('FU-Employee').getRecordTypeId();
        con.AccountId = acc.id;
        con.FirstName = 'Test 1';
        con.LastName = 'Name';
        con.Designation_Name__c = 'Assistant Manager - ERP';
        con.Department__c ='IT';
        con.Faculty__c='Faculty of Liberal Education';
        con.Office_Room__c='R005';              
        insert con;
        
        Contact contact = [Select id,Name from contact Where id =: con.id ];
        System.debug('Contact : +'+contact);
        Flame_PeopleSearchAC.autocompletePeopleSearch(contact.Name);
        List<Contact> conList = [Select Id, Name, Designation_Name__c, Department__c, Faculty__c, Office_Building__r.Name, Office_Room__c,RecordTypeId From Contact ];
        System.debug('Contact List '+conList);
        Flame_PeopleSearchAC obj01 = new Flame_PeopleSearchAC();
       // Flame_PeopleSearchAC.ContactWrapper(); 
        Flame_PeopleSearchAC.ContactWrapper obj21 = new Flame_PeopleSearchAC.ContactWrapper('test data','test data','test data','test data','test data','test data','test data','test data','test data','test data','test data','test data','test data','test data');
        obj21.conid = 'test data';
        obj21.name = 'test data';
        obj21.firstname = 'test data';
        obj21.LastName = 'test data';
        obj21.faculty = 'test data';
        obj21.designation = 'test data';
        obj21.department = 'test data';
        obj21.building = 'test data';
        obj21.room = 'test data';
        obj21.Email = 'test data';
        obj21.Phone = 'test data';
        obj21.Program = 'test data';
        obj21.batch = 'test data';
    }
}