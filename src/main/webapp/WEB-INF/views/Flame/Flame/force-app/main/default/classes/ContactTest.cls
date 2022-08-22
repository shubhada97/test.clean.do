@isTest(seeAllData=false)

private class ContactTest {
 public static List<Contact> contactsList;
 public static List<Case> casesList;
 public static String email1;
 static testMethod void testDupes() {
 Contact c   = new Contact();
       c.FirstName = 'Stephen';
       c.LastName  = 'Curry';
       c.Email     = 'stephcurry@gsw.com';
       insert c;
       }
}