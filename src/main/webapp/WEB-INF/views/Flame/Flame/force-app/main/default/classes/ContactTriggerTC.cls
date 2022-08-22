@isTest
public class ContactTriggerTC{
    public static testmethod void validateContactTrigger(){
        Contact objContact = new Contact(FirstName = 'Test First', LastName = 'Test Last');
        insert objContact;
    }
}