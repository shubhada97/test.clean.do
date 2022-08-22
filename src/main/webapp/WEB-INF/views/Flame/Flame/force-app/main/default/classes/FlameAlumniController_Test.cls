@isTest
public class FlameAlumniController_Test {
    @testSetup
    static void setupTestData(){  
      Contact contact_Obj = new Contact(LastName = 'LastName664', FirstName = 'First610', HasOptedOutOfEmail = false, Classification_Applicant__c = false, Classification_Student__c = false, Classfication_Withdrawn__c = false, Classification_Alumni__c = false, Classfication_Guest__c = false, Classfication_VIP__c = false, Classfication_Staff__c = false, Classfication_ExStaff__c = false, Classfication_Faculty__c = false, Classfication_ExFaculty__c = false, Classfication_FIL__c = false, Classfication_Vendor__c = false, Save_Withdrawal_Application__c = false, Cheque_Dispatch_Status__c = false, Student_Withdrawal_Completion__c = false, PhD__c = false, Classification_Visiting_Faculty__c = false, Classfication_Adjunct_Faculty__c = false, Send_Mass_Email__c = false, Unsubscribe_from_Mailers__c = false, hed__Deceased__c = false, hed__Do_Not_Contact__c = false, hed__Exclude_from_Household_Formal_Greeting__c = false, hed__Exclude_from_Household_Informal_Greeting__c = false, hed__Exclude_from_Household_Name__c = false, hed__FERPA__c = false, hed__Financial_Aid_Applicant__c = false, hed__HIPAA__c = false, hed__Military_Service__c = false, hed__is_Address_Override__c = false, Classification_Parent__c = false, Contact_Country__c ='India' ,Contact_City__c='Pune',Contact_State__c='Maharashtra',Primary_Contact_Type__c='Alumni');
        Insert contact_Obj; 
    }
    @isTest static void test1(){
        integer pageno =1;
        integer pagesize =10;
        string navserch='india';
        test.startTest();
        FlameAlumniController.getLocation(pageno,pagesize);
         FlameAlumniController.getLocationOnchange(navserch,pageno,pagesize);
        FlameAlumniController.contactLocationWrapper conLoc = new FlameAlumniController.contactLocationWrapper();
        FlameAlumniController.locationDetailWrapper  locDetail = new FlameAlumniController.locationDetailWrapper();
        test.stopTest();
        
    }
    
}