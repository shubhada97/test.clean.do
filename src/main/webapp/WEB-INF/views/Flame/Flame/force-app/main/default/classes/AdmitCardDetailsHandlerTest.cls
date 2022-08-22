@isTest(SeeAllData=true)
public class AdmitCardDetailsHandlerTest {
 
    public static testMethod void CreateAdmitCardtest() {
   
   Contact con =  new Contact();
    con.FirstName = 'Anil';
    con.LastName = 'Dutt';
    con.Email = 'anil@swiftsetup.com';
    insert con;
           
      System.currentPagereference().getParameters().put('id',con.id);
     
      ApexPages.currentPage().getParameters().put('StaticContactId', con.ID); 
     // System.assertEquals('abhi.0211@test.com', con.Email);
    Application__c app = new Application__c(); 
    Admit_Card__c a = new Admit_Card__c(FUA_Broadcast_Admit_Card__c = true,Contact__c=con.id,Application__c=app.id);
    ApexPages.StandardController sc  = new ApexPages.StandardController(con);
    AdmitCardDetailsHandler acd = new AdmitCardDetailsHandler();
    
        PageReference ref = Page.admitcard;
        ref.getParameters().put('StaticContactId', Con.Id);
        Test.setCurrentPage(ref);
       AdmitCardDetailsHandler.sendEmail(con.Id, 'abhi.0211@test.com', 'Admitcard',' Subject', 'Body'); 
         Blob content = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : ref.getContent();
         String Body='sderf'; 
        // System.assertEquals(null, acd.Body);  
         set<Id> setAccId = new Set<ID>();
         setAccId.add(a.id);
         Set<Admit_Card__c> admitCardDetails = new Set<Admit_Card__c>();
         admitCardDetails.add(a);
   Test.startTest();
    AdmitCardDetailsHandler.CreateAdmitCard(admitCardDetails);  
    test.stopTest();       

        }

    }