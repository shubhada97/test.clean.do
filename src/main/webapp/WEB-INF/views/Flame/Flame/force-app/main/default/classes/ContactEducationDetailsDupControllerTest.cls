@isTest
public class ContactEducationDetailsDupControllerTest{
  @testSetup
  static void setupTestData(){
  Account testAccount = new Account();//Insert Account
        testAccount.Name='Test Account' ;
        insert testAccount;
        Contact cont = new Contact();
        cont.FirstName ='Test';
        cont.LastName ='Test';
        cont.accountid =testAccount.id;
        insert cont;
        Application__c application_Obj = new Application__c();
        application_Obj.Admission_Status__c = 'Admission Withdrawn';
        application_Obj.Admitted__c = false;
        application_Obj.FUA_SOP_Submitted__c = false;
        application_Obj.SAT_Score__c = false;
        //Insert application_Obj; 
    ApexPages.StandardController sc = new ApexPages.StandardController(application_Obj);
    ContactEducationDetailsDupController cd = new ContactEducationDetailsDupController(sc);
    cd.selAdmStatus = 'test data';
    cd.selAppRefId = 'test data';
    cd.fromDate = Date.today();
    cd.toDate = Date.today();
    cd.ContactDetails = new List<ContactEducationDetailsDupController.ContactDetailsWrapper>();
    cd.appRefIdList = new List<SelectOption>();
    cd.admStatusList = new List<SelectOption>();
    cd.getYearofCompletion();
    cd.getYearClassList();
    ContactEducationDetailsDupController.ContactModalClass obj131 = new ContactEducationDetailsDupController.ContactModalClass();
    obj131.contact = new Contact();
    obj131.score = 'test data';
    obj131.educationScore = new Map<string, FU_Education_Details__c >();
    ContactEducationDetailsDupController.ContactDetailsWrapper obj171 = new ContactEducationDetailsDupController.ContactDetailsWrapper();
    obj171.contact = new Contact();
    obj171.eduDetails = new Map<string, FU_Education_Details__c >();
    obj171.workDetails = new Map<string, FUA_Work_Details__c>();
   
  }
  /*method-2*/
  static testMethod void test_ContactDetailsWrapper(){
   Application__c application_Obj = new Application__c();
        application_Obj.Admission_Status__c = 'Admission Withdrawn';
        application_Obj.Admitted__c = false;
        application_Obj.FUA_SOP_Submitted__c = false;
        application_Obj.SAT_Score__c = false;
        //Insert application_Obj;
    List<Application__c> app  =  [SELECT Id,Name,Admission_Status__c,Admitted__c,Contact__c,FLAME_Entrance_Aptitude_Test_FEAT__c,FUA_All_Documents_Verified__c,FUA_Broadcast_Admission__c,FUA_SOP_Submitted__c,Median__c,SAT_Score__c,Enrollment_Deposit_Amount_Paid__c,FLM_Accepetoffer__c,
    Contact_City__c,Contact_Mother_Tongue__c,Contact_Mobile_Number__c,Contact_Family_Income__c,Contact_Email__c,Contact_Religion__c,Contact_State__c,Contact_Gender__c,Contact_Account__c from Application__c];
    System.assertEquals(false,app.size()>0); 
    
    ApexPages.StandardController sc = new ApexPages.StandardController(application_Obj);
    ContactEducationDetailsDupController ctrl = new ContactEducationDetailsDupController(sc);
    List<SelectOption> selOpts=ctrl.appRefIdList;
    List<SelectOption> selOpts1=ctrl.admStatusList;
   
    List<FU_Education_Details__c> fu_education_details_Obj  =  [SELECT Id,Name,CreatedDate,Application__c,FUA_Board_University__c,FUA_CGPA_Actual__c,FUA_CGPA_Out_Of__c,FUA_Degree_Certificate__c,FUA_Education_Country__c,FUA_Education_State__c,FUA_Institution_School__c,FUA_Major_Subjects__c,FUA_Other_City__c,FUA_Year_of_Completion__c,
    FU_Year_Class__c,Program__c,Score__c,Scores_Subset__c,FUA_Education_City__c from FU_Education_Details__c];
    System.assertEquals(false,fu_education_details_Obj.size()>0);
    
    Contact con = new Contact(id=application_Obj.contact__c,firstname=application_Obj.contact__r.firstName,
                                                            lastname=application_Obj.contact__r.lastname,
                                                            email=application_Obj.contact__r.email,
                                                            mobilephone=application_Obj.contact__r.FUA_Mobile__c,
                                                            Gender__c=application_Obj.contact__r.Gender__c,
                                                            Religion__c=application_Obj.contact__r.Religion__c );  
                                                            
    FUA_Work_Details__c FUA_Work_Details_obj = new FUA_Work_Details__c();
   
    
    Map<Id,string> conMap = new Map<Id,string>();
    for(Contact c:[Select id, name from contact where id=:con.id]){
    conmap.put('SuperAdmin', c.Id);
    }
    Map<Id,string> eduMap = new Map<Id,string>();
    for(FU_Education_Details__c ed: [SELECT Id,Name,CreatedDate,Application__c,FUA_Board_University__c,FUA_CGPA_Actual__c,FUA_CGPA_Out_Of__c,FUA_Degree_Certificate__c,FUA_Education_Country__c,FUA_Education_State__c,FUA_Institution_School__c,FUA_Major_Subjects__c,FUA_Other_City__c,FUA_Year_of_Completion__c,
    FU_Year_Class__c,Program__c,Score__c,Scores_Subset__c,FUA_Education_City__c from FU_Education_Details__c]){
    eduMap.put('Education', ed.id);
    
    }
    Map<Id,string> workMap = new Map<Id,string>();
    for(FUA_Work_Details__c w:[SELECT id,Name,FUA_Designation__c,FromDate__c,FUA_From_Date__c,FUA_Function__c,FUA_Work_City__c from FUA_Work_Details__c ]){
    workMap.put('work',w.id);
    if(!workMap.containsKey(FUA_Work_Details_obj.FUA_Company__c)){
     workMap.put(FUA_Work_Details_obj.FUA_Company__c, w.id);
    }
    }
   
                                                  
    }                                                        
   
       
  
   
   
 
}