public without sharing class Flame_Careerservicesprofilecontroller {
 
 Public Boolean  showContent {get;set;}
 Public Boolean  showContent1 {get;set;}
 Public Boolean  showContent2 {get;set;} 

 public String contactId {get;set;}
 Public List<wrappercontact> reserList {get;set;}
 public List<Contact> contList {get;set;}
 public List<Contact_Education__c> eduList {get;set;}
 public List<wrapperContactEducation>educationList{get;set;}
 public String rId{get;set;}
 Public String urlId {get;set;}
 Public String profileurl {get;set;}
 public Case caseObject {get;set;}
 Public CareerServicesProfile__c Wrkdetls {get;set;}
 public Attachment attachment { get; set; }
 public List<Contact_Education__c> eduListonlyrid {get;set;}
 public List<wrapperContactEducation>educationListonlyrid {get;set;}
 Public Boolean  IsCreated {get;set;} 
 public Boolean IsTicketDetials {get;set;}
 public String fileName {get;set;}
 
 //constructer 
 Public  Flame_Careerservicesprofilecontroller(){
    IsCreated = false;
    User objUser = new User();
    if(Flame_CommunityUserInfo.profileName=='System Administrator'){
    objUser = [Select id,Community_Contact_ID__c from User where id =: UserInfo.getUserId()]; 
    contactId = objUser.Community_Contact_ID__c;
    }else{
    objUser = [Select id,contactid from User where id =: UserInfo.getUserId()];             
    contactId = objUser.ContactId;
    
    }
  
   urlId = ApexPages.currentPage().getParameters().get('contactId') ;   
   system.debug('urlId'+urlId); 
   //to fetch the contact details 
    reserList = new List<wrappercontact>();
    contList = new List<Contact>();
    contList =[Select Id,FirstName,LastName,Gender__c,CVUE_Student_Number__c,Program_Interested_In__c,Father_s_First_Name__c,Permanent_Address_Line_1__c,Minor__c,Major__c,CGPA__c,
                Father_s_Last_Name__c,Father_s_Current_Company__c,Father_s_Email_ID__c,Father_s_Occupation__c,Father_s_Last_Company__c,Father_s_Designation__c,MobilePhone,Permanent_Address_Line_2__c,
                Email,DOB__c,First_year_CGPA__c,Mother_s_First_Name__c,Mother_s_Last_Name__c,Mother_s_Email_ID__c,Mother_s_Occupation__c,Permanent_Postal_Code__c,LinkedIn_profile_URL__c,
                Mother_s_Current_Company__c,Mother_s_Designation__c,Portal_password__c,Date_of_Birth__c,Contact_Photo__c,Contact_Photo_Url__c
                From contact where Id=:contactId  Limit 1];
                
    for(Contact c : contList){
    
    reserList.add(new wrappercontact(c));      
    }
    //to fetch the education details 
    eduList = new List<Contact_Education__c>();
   educationList = new List<wrapperContactEducation>();
    eduList =[select Id,Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,
             Institution_Name__c,Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c where Contact__c=:contactId order BY Year_Class__c  ];
    for(Contact_Education__c e : eduList){
    educationList.add(new wrapperContactEducation(e));      
    } 
    
    rId= ApexPages.currentPage().getParameters().get('rid') ; 
    
    if(rId != null)
    {
    eduListonlyrid = new List<Contact_Education__c>();
   educationListonlyrid = new List<wrapperContactEducation>();
    eduListonlyrid =[select Id,Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,
             Institution_Name__c,Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c where Contact__c=:contactId and id=: rId ];
    for(Contact_Education__c e : eduListonlyrid ){
    educationListonlyrid.add(new wrapperContactEducation(e));      
    } 
    
    
    }
   
    showContent = false;
    showContent1 = true;
    showContent2 = true; 
    Wrkdetls = new CareerServicesProfile__c();
    CareerServicesProfile__c workdetails = new CareerServicesProfile__c();
     attachment = new Attachment();
    // once call the constructer to save all values to display in vfpage.
     fetchapplicationvalues(); 
    // to fetch the profile image to display the pdf.
     list<ContentDocumentLink> fethimage = new list<ContentDocumentLink>();
      fethimage = [SELECT ContentDocument.Title,LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =: contactId  and ContentDocument.Title='Profie Image' limit 1];
     
     list<ContentVersion> fethimagecontentversion = new list<ContentVersion>();
     
     if(fethimage.size()> 0 )
     {
     fethimagecontentversion =[Select id from ContentVersion where ContentDocumentId = : fethimage[0].ContentDocumentId   limit 1];
     }  
     if(fethimagecontentversion.size()> 0 )
     {
     profileurl ='/sfc/servlet.shepherd/version/download/' + fethimagecontentversion[0].id ;
     } 
     
     system.debug('profileurl ' + profileurl );   
 }
 
  
    //write wrapperclass to fetch the contact details 
    Public class wrappercontact{
    Public contact conn {get;set;}
    Public Boolean Selected {get;set;}
    Public Boolean Selected1 {get;set;}
    Public Boolean Selected2 {get;set;}
    Public Boolean Selected3 {get;set;}
    Public Boolean Selected4 {get;set;}
    Public Boolean Selected5 {get;set;}
    Public Boolean Selected6 {get;set;}
    Public Boolean Selected7 {get;set;}
    Public Boolean Selected8 {get;set;}
    Public Boolean Selected9 {get;set;}
    Public Boolean Selected0 {get;set;}
    Public Boolean Selected11 {get;set;}
    Public Boolean Selected12 {get;set;}
    Public Boolean Selected13 {get;set;}
    Public Boolean Selected14 {get;set;}
    Public Boolean Selected15 {get;set;}
    Public Boolean Selected16 {get;set;}
    Public Boolean Selected17 {get;set;}
    Public Boolean Selected18 {get;set;}
    Public Boolean Selected19 {get;set;}
    Public Boolean Selected20 {get;set;}
    Public Boolean Selected21 {get;set;}
     Public Boolean Selected22 {get;set;}
    
    Public wrappercontact(contact c){
    this.conn = c;
     
    }
    }
   // Request to edit button
    Public PageReference RequestEdit(){
    System.debug('###'+rid);
    String rid = System.currentPageReference().getParameters().get('rid');
    pagereference ApplyPage = new PageReference('/apex/Flame_Careerprofile_editcontact?id='+rid); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage;         
    }
    
    //popup contactmethod
  Public PageReference Requesttosend(){
  IsCreated = true;
   searchError = 'Thank you, request has been submited.';
  popupsubmit();
  return null;
  
  }
  //cancle button.
  Public PageReference canclerequesttosend(){ 
 pagereference pr = new PageReference('/apex/Flame_Career_Profilepage'); 
   pr.setRedirect(true);     
    return  pr; 
  }
    
   //Request to send contact details  (to create a case to modified back end)
   Public PageReference popupsubmit(){
    contList = new List<Contact>();
    List<String> editcontactvalueandlabel= new List<String>();
    
    //editcontactvalueandlabel.add('Changes are required for - ');
    
    Id ContactId;
    
    for(wrappercontact wrapcontactObj :reserList) {
   
    ContactId = wrapcontactObj.conn.Id;
    
    if(wrapcontactObj.Selected == true ){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('First Name' + ': ' +wrapcontactObj.conn.FirstName );
   
    }
    if(wrapcontactObj.Selected1 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Gender' + ': ' +wrapcontactObj.conn.Gender__c );
    }
    
    if(wrapcontactObj.Selected2 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Student Number' + ': ' +wrapcontactObj.conn.CVUE_Student_Number__c );
    }
    
    if(wrapcontactObj.Selected3 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Program' + ': ' +wrapcontactObj.conn.Program_Interested_In__c);
    }
    
    if(wrapcontactObj.Selected4 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Specialization Interest Area' + ': ' +wrapcontactObj.conn.Program_Interested_In__c);
    }
    
    if(wrapcontactObj.Selected5 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Father First Name' + ': ' +wrapcontactObj.conn.Father_s_First_Name__c);
    }
    
    if(wrapcontactObj.Selected6 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Father Last Name' + ': ' +wrapcontactObj.conn.Father_s_Last_Name__c);
    }
    
    if(wrapcontactObj.Selected7 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Father Email' + ': ' +wrapcontactObj.conn.Father_s_Email_ID__c);
    }
    
    if(wrapcontactObj.Selected8 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Fathers Occupation' + ': ' +wrapcontactObj.conn.Father_s_Occupation__c);
    }
    
    if(wrapcontactObj.Selected9 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Fathers Company' + ': ' +wrapcontactObj.conn.Father_s_Current_Company__c);
    }
    
    
    if(wrapcontactObj.Selected0 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Fathers Designation' + ': ' +wrapcontactObj.conn.Father_s_Designation__c);
    }
    
    if(wrapcontactObj.Selected11 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Last Name' + ': ' +wrapcontactObj.conn.LastName);
    }
    
    if(wrapcontactObj.Selected12 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mobile Number' + ': ' +wrapcontactObj.conn.MobilePhone);
    }
    
    if(wrapcontactObj.Selected13 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Email ID' + ': ' +wrapcontactObj.conn.Email);
    }
    
    if(wrapcontactObj.Selected14 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Date of Birth' + ': ' +wrapcontactObj.conn.Date_of_Birth__c);
    }
    
    if(wrapcontactObj.Selected15 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('CGPA (1st Yr.)' + ': ' +wrapcontactObj.conn.First_year_CGPA__c);
    }
    
    if(wrapcontactObj.Selected16 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mother First Name' + ': ' +wrapcontactObj.conn.Mother_s_First_Name__c);
    }
    
    if(wrapcontactObj.Selected17 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mother Last Name' + ': ' +wrapcontactObj.conn.Mother_s_Last_Name__c);
    }
    
    if(wrapcontactObj.Selected18 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mothers Email' + ': ' +wrapcontactObj.conn.Mother_s_Email_ID__c);
    }
    
   
    
    if(wrapcontactObj.Selected19 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add(' Mothers Occupation' + ': ' +wrapcontactObj.conn.Mother_s_Occupation__c);
    }
    
    if(wrapcontactObj.Selected20 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mothers Company ' + ': ' +wrapcontactObj.conn.Mother_s_Current_Company__c);
    }
    
    if(wrapcontactObj.Selected21 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('Mothers Designation' + ': ' +wrapcontactObj.conn.Mother_s_Designation__c);
    }
    
    if(wrapcontactObj.Selected22 == true){
    contList.add(wrapcontactObj.conn);
    editcontactvalueandlabel.add('LinkedIn profile URL' + ': ' +wrapcontactObj.conn.LinkedIn_profile_URL__c);
    }
    
    
    }
    
    System.debug('editcontactvalueandlabel' + editcontactvalueandlabel);
    
    insertcase(editcontactvalueandlabel,ContactId );
   
    System.debug('editcontactvalueandlabel' + editcontactvalueandlabel);
    
    
    pagereference ApplyPage = new PageReference('/apex/Flame_Career_Profilepage?id='+this.urlId); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage; 
    
    
   } 
   
   @future
   public static void insertcase(list<String> Description,Id ContactId )
   {
       
  // String StudentCvvNumber= [Select CVUE_Student_Number__c  from Contact where id=:  ContactId ].CVUE_Student_Number__c  ;
   
    Id recordtypecase= Schema.SObjectType.Case.getRecordTypeInfosByName().get('Data Update Request').getRecordTypeId();
    Case studentcase= new Case();
    String CaseDescription= 'Change Values For - ';
    system.debug('Description' + Description);
    CaseDescription=String.join(Description, ',');
    CaseDescription.removeEnd(',');
    studentcase.Description = CaseDescription;
    studentcase.ContactId= ContactId ;
    studentcase.Subject= 'Contact Edit Request ';//+StudentCvvNumber;  
    studentcase.RecordTypeId= recordtypecase;
    studentcase.HLP_Sub_Category__c ='Contact Update';
    studentcase.Origin= 'Web';
    studentcase.Status='New';
   // studentcase.OwnerId='00G28000001sDvb';
      
    
    System.debug('studentcase' + studentcase);
    insert studentcase;
    
    System.debug('studentcase' + studentcase);
  
   }
   
  public String searchError;
   public String getSearchError() {
        return searchError; //return searchError value
    }
   
    //popupeducationsubmit method.
  Public void requesttoedit(){
   
    IsCreated = true;
   // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Thank you, request has been submited.'));
    searchError = 'Thank you, request has been submited.';
   popupeducationsubmit();
    
    
   }
   public pagereference closePopup()
    {       
    IsCreated = false;
    pagereference ApplyPage = new PageReference('/apex/Flame_Career_Profilepage?id='+this.urlId); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage;    
    }    
   
 //cancle button  
 Public PageReference canclerequesttoedit(){ 
 pagereference pr = new PageReference('/apex/Flame_Career_Profilepage');
  pr.setRedirect(true);     
    return  pr; 
  }
  // edit the education detailes 
  Public PageReference popupeducationsubmit(){
 
   List<String> editeducationvalueandlabel= new List<String>();
    Id EducationId;
    eduList = new List<Contact_Education__c>();
    for(wrapperContactEducation wrapeducationObj :educationListonlyrid) {
     EducationId = wrapeducationObj.edu.Id;
     
    if(wrapeducationObj.isEdit == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Education record to be edited' + ' : ' +wrapeducationObj.edu.Year_Class__c  + ' Requested edit -'  );
    }
    if(wrapeducationObj.isEdit1 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Institution / School ' + ': ' +wrapeducationObj.edu.Institution_School__c +'' );
    }
    if(wrapeducationObj.isEdit2 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Degree / Certificate (Class XII, Diploma etc.)' + ' : ' +wrapeducationObj.edu.Degree_Certificate__c +'' );
    }
    if(wrapeducationObj.isEdit3 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Board / University Examination Body' + ' : ' +wrapeducationObj.edu.Board_University__c +'');
    }
    if(wrapeducationObj.isEdit4 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Year of Completion' + ' : ' +wrapeducationObj.edu.Year_of_Completion__c +'' );
    }
    if(wrapeducationObj.isEdit5 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('% or CGPA' + ' : ' +wrapeducationObj.edu.Percent_CGPA__c+'' );
    }
    if(wrapeducationObj.isEdit6 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('CGPA Out of' + ' : ' +wrapeducationObj.edu.Percent_CGPA_Out_of__c+'' );
    }
    if(wrapeducationObj.isEdit7 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Major Subjects' + ' : ' +wrapeducationObj.edu.Major_Subjects__c+'' );
    }
    
    if(wrapeducationObj.isEdit8 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('Country' + ' : ' +wrapeducationObj.edu.Degree_Certificate__c+'' );
    }
    if(wrapeducationObj.isEdit9 == true) {
    eduList.add(wrapeducationObj.edu);
    editeducationvalueandlabel.add('State' + ' : ' +wrapeducationObj.edu.Education_State__c +'');
    }
  
   }
   
   System.debug('editeducationvalueandlabel' + editeducationvalueandlabel);
    insertcase1(editeducationvalueandlabel,ContactId );
    pagereference ApplyPage = new PageReference('/apex/Flame_Career_Profilepage?id='+this.urlId); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage; 
   
  } 
  
  // to creat the case to fetch the values to display
   @future
   public static void insertcase1(list<String> Description,Id ContactId )
   {
    string StudentCvvNumber= [Select CVUE_Student_Number__c  from Contact where id=:  ContactId ].CVUE_Student_Number__c  ;
    Id recordtypecase= Schema.SObjectType.Case.getRecordTypeInfosByName().get('Data Update Request').getRecordTypeId();
    Case studentcase= new Case();
    String CaseDescription= 'Change Values For - ';
    system.debug('Description' + Description);
    CaseDescription=String.join(Description, ',');
    CaseDescription.removeEnd(',');
    studentcase.Description = CaseDescription;
    studentcase.ContactId= ContactId ;
    studentcase.Subject= 'Education Edit Request - ' + StudentCvvNumber;
    studentcase.RecordTypeId= recordtypecase;
    studentcase.HLP_Sub_Category__c ='Education Update';
    studentcase.Origin= 'Web';
    studentcase.Status='New';
   // studentcase.OwnerId='00G28000001sDvb';
       
       System.debug('studentcase' + studentcase);
    insert studentcase;
    
    System.debug('studentcase' + studentcase);
  
   }
   
  // education Detailes to display 
    
  public class wrapperContactEducation{
   
        public Boolean isEdit{get;set;}
        public Boolean isEdit1{get;set;}
        public Boolean isEdit2{get;set;}
        public Boolean isEdit3{get;set;}
        public Boolean isEdit4{get;set;}
        public Boolean isEdit5{get;set;}
        public Boolean isEdit6{get;set;}
        public Boolean isEdit7{get;set;}
        public Boolean isEdit8{get;set;}
        public Boolean isEdit9{get;set;}
        public Contact_Education__c edu {get;set;}
        public wrapperContactEducation(Contact_Education__c e){
            this.edu = e;
            this.isEdit = true;      
        }
        }
    // education records edit and save each row/record in a custom list-view ST_ItemsList(class name)  
    public PageReference enterInputMode() {
    System.debug('###'+rid);
    String rid = System.currentPageReference().getParameters().get('rid');
    pagereference ApplyPage = new PageReference('/apex/Flame_Careerprofile_Popup?rid='+rid); 
    ApplyPage.setRedirect(true);     
    return  ApplyPage;                     
    
    }
    
    //Want to hide and show the output panel on button click  <YourClassConstructorpage>
  public void toggleContent() {
   showContent = false;
   showContent1 = false;
   showContent2 = true;
   }  
 
   public void toggleContent1() {
    showContent = false;
    showContent2 = false; 
     
     } 
    // Removing company2 when user click on Remove buttom 
    Public Void RemoveSecondContent(){
    
        List<CareerServicesProfile__c> CS =  [Select id,Achievement__c,Company1__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,contact__c,
                Company2__c,C2From__c,C2projectDescription__c,C2ProjectTitle__c,C2To__c,Company3__c,C3From__c,C3projectDescription__c,
                C3ProjectTitle__c,C3To__c,Extra_Curricular__c From CareerServicesProfile__c where Contact__c=:contactId  order by createdDate DESC LIMIT 1 ];
        
        for(CareerServicesProfile__c careerservices : CS){
        if(careerservices.Company2__c != NULL){
        careerservices.Company2__c = '';
        careerservices.C2ProjectTitle__c='';
        careerservices.C2From__c= NULL;
        careerservices.C2To__c=NULL;
        careerservices.C2projectDescription__c =NULL;
        }
        }
        update CS;
        showContent = false;
        showContent1 = true;
    
    }
    
    // Removing company 3 when user click on Remove buttom
    Public Void RemovethirdContent(){
    
        List<CareerServicesProfile__c> CS =  [Select id,Achievement__c,Company1__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,contact__c,
                Company2__c,C2From__c,C2projectDescription__c,C2ProjectTitle__c,C2To__c,Company3__c,C3From__c,C3projectDescription__c,
                C3ProjectTitle__c,C3To__c,Extra_Curricular__c From CareerServicesProfile__c where Contact__c=:contactId  order by createdDate DESC LIMIT 1 ];
        
        for(CareerServicesProfile__c careerservices : CS){
        if(careerservices.Company3__c != NULL){
        careerservices.Company3__c = '';
        careerservices.C3ProjectTitle__c='';
        careerservices.C3From__c=NULL;
        careerservices.C3To__c=NULL;
        careerservices.C3projectDescription__c =NULL;
        }
        }
        update CS;
        showContent = false;
        showContent2 = true;        
    }
 
    
    //fetch the existing application records to display the vfpage (to assign in the vfpage values equal to field values).
    Public Void fetchapplicationvalues(){
        List<CareerServicesProfile__c> fetchapplist = new List<CareerServicesProfile__c>();
        fetchapplist =[Select id,Achievement__c,Company1__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,contact__c,
                           Company2__c,C2From__c,C2projectDescription__c,C2ProjectTitle__c,C2To__c,Company3__c,C3From__c,C3projectDescription__c,
                           C3ProjectTitle__c,C3To__c,Extra_Curricular__c,Languages_Known__c,Submit__c,LinkedIn_Profile_link__c From CareerServicesProfile__c where Contact__c=:contactId  order by createdDate DESC LIMIT 1 ];
        System.debug(' fetchapplist......'+ fetchapplist);
        if(fetchapplist.size() > 0){
        CareerServicesProfile__c work = fetchapplist[0];
        Wrkdetls.Company1__c = work.Company1__c;
        Wrkdetls.C1From__c = work.C1From__c;
        Wrkdetls.C1To__c = work.C1To__c;
        Wrkdetls.C1ProjectTitle__c = work.C1ProjectTitle__c;
        Wrkdetls.C1projectDescription__c = work.C1projectDescription__c;
        
        Wrkdetls.Company2__c = work.Company2__c;
        Wrkdetls.C2From__c = work.C2From__c;
        Wrkdetls.C2To__c = work.C2To__c;
        Wrkdetls.C2ProjectTitle__c = work.C2ProjectTitle__c;
        Wrkdetls.C2projectDescription__c = work.C2projectDescription__c;
        
        Wrkdetls.Company3__c = work.Company3__c;
        Wrkdetls.C3From__c = work.C3From__c;
        Wrkdetls.C3To__c = work.C3To__c;
        Wrkdetls.C3ProjectTitle__c = work.C3ProjectTitle__c;
        Wrkdetls.C3projectDescription__c = work.C3projectDescription__c;
        
        Wrkdetls.Achievement__c = work.Achievement__c;
        Wrkdetls.Extra_Curricular__c = work.Extra_Curricular__c;
        Wrkdetls.Languages_Known__c = work.Languages_Known__c;
        Wrkdetls.LinkedIn_Profile_link__c = work.LinkedIn_Profile_link__c;
        Wrkdetls.Submit__c = true;
        /*Logic to dynamically add Company1,Company2,Company3   */
        System.debug('work.Company2__c####'+work.Company2__c);
        System.debug('work.Company3__c###'+work.Company3__c);
         system.debug('reserList'+reserList);
        if(work.Company1__c == NULL ){
        showContent = true;
        }else{
        showContent = false;
        }
        if(work.Company2__c == NULL ){
        showContent1 = true;
        }else{
        showContent1 = false;
        }
        if(work.Company3__c == NULL){
        showContent2 = true;
        }else{
        showContent2 = false;
        }
        System.debug('showContent1###'+showContent1);
        System.debug('showContent2###'+showContent2);
        /*Logic to dynamically add Company1,Company2,Company3   */
       }
     
    }
  boolean blnflag; 
    ////Education detailes: upadtedata to assign the education obj to careerprofile obj.
    Public Void eduFieldupdate(){
    
    
    List<Contact_Education__c> fetcheducation = new List<Contact_Education__c>();
    fetcheducation =[select Id,Name,Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,
    Institution_Name__c,Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Career_Services_Profile__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c  where Contact__c=:contactId Limit 10];
    system.debug('fetcheducation'+fetcheducation);
    CareerServicesProfile__c CSprofile = new CareerServicesProfile__c();
    for(Contact_Education__c conedu :fetcheducation){
        if(conedu.Year_Class__c == '10/Xth'){
        
        CSprofile.contact__c = conedu.Contact__c ;
        CSprofile.X_Board__c = conedu.Board_University__c;
        CSprofile.Xth_CGPA__c = conedu.Percent_CGPA__c;
        CSprofile.Xth_CGPA_Out_of__c = conedu.Percent_CGPA_Out_of__c;
        CSprofile.Xth_School__c = conedu.Institution_School__c;
        CSprofile.Xth_Year_of_Passing__c = conedu.Year_of_Completion__c;
        system.debug('CSprofile'+CSprofile); 
        
        } else if(conedu.Year_Class__c == '12/XIIth'){
        CSprofile.contact__c = conedu.Contact__c ;
        CSprofile.Xll_Board__c = conedu.Board_University__c;
        CSprofile.Xll_CGPA__c = conedu.Percent_CGPA__c;
        CSprofile.Xll_CGPA_Out_of__c = conedu.Percent_CGPA_Out_of__c;
        CSprofile.Xll_College__c = conedu.Institution_School__c;
        CSprofile.Xll_Year_Of_Passing__c = conedu.Year_of_Completion__c;
        
        } else if(conedu.Year_Class__c == 'Bachelors / Undergraduate'){
        CSprofile.contact__c = conedu.Contact__c ;
        CSprofile.Gradation_University__c = conedu.Board_University__c;
        CSprofile.Gradation_CGPA__c = conedu.Percent_CGPA__c;
        CSprofile.Graduation_CGPA_Out_of__c = conedu.Percent_CGPA_Out_of__c;
        CSprofile.Graduation_College__c = conedu.Institution_School__c;
        CSprofile.Graduation_Year__c = conedu.Year_of_Completion__c;
        CSprofile.Graduation_Stream__c = conedu.Year_of_Completion__c;
        CSprofile.Graduation_Percentage__c = conedu.Year_of_Completion__c;
        
        } else if(conedu.Year_Class__c == 'Masters / Postgraduate'){
         CSprofile.contact__c = conedu.Contact__c ;
        CSprofile.PG_University__c = conedu.Board_University__c;
        CSprofile.PG_CGPA__c = conedu.Percent_CGPA__c;
        CSprofile.PG_CGPA_outof__c = conedu.Percent_CGPA_Out_of__c;
        CSprofile.PG_College__c = conedu.Institution_School__c;
        CSprofile.PG_Year_of_Passing__c = conedu.Year_of_Completion__c;
        CSprofile.PG_Stream__c = conedu.Year_of_Completion__c;
        CSprofile.PG_Percentage__c = conedu.Year_of_Completion__c;
        
        }else if(conedu.Year_Class__c == 'Other'){
        CSprofile.contact__c = conedu.Contact__c ;
        CSprofile.Other_University__c = conedu.Board_University__c;
        CSprofile.Other_CGPA__c = conedu.Percent_CGPA__c;
        CSprofile.Other_CGPA_outof__c = conedu.Percent_CGPA_Out_of__c;
        CSprofile.Other_College__c = conedu.Institution_School__c;
        CSprofile.Other_Year_of_Passing__c = conedu.Year_of_Completion__c;
        CSprofile.Other_Stream__c = conedu.Year_of_Completion__c;
        CSprofile.Other_Percentage__c = conedu.Year_of_Completion__c;
        }
        
        }
        upsert CSprofile;
    
    }
  Public boolean saveBtndisable {get;set;}
  
  public Blob document {get; set;}
  // --------------------------------- pending popup message
   
    // save all fields in one record in data base. 
    Public PageReference SaveAll(){
    
        if(Wrkdetls.C1projectDescription__c == null)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'you can not leave this field blank'));
            return null;
        }
            
    
        eduFieldupdate();
         IsCreated = true;
   // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Thank you, request has been submited.'));
       searchError = 'Thank you, request has been submited.';
       
       
        List<CareerServicesProfile__c> fetchapplist = new List<CareerServicesProfile__c>();
        fetchapplist =[Select id,Achievement__c,Company1__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,contact__c,
                       Company2__c,C2From__c,C2projectDescription__c,C2ProjectTitle__c,C2To__c,Company3__c,C3From__c,C3projectDescription__c,
                       C3ProjectTitle__c,C3To__c,Extra_Curricular__c,Submit__c,Languages_Known__c,LinkedIn_Profile_link__c From CareerServicesProfile__c where Contact__c=:contactId  order by createdDate DESC LIMIT 1 ];
        System.debug('fetchapplist'+fetchapplist.size());
        if(fetchapplist.size() > 0){
        System.debug('fetchapplist #### 1');
        CareerServicesProfile__c workdetails = new CareerServicesProfile__c();
        workdetails.contact__c= contactId;
        workdetails.id = fetchapplist[0].id;
        workdetails.Company1__c = Wrkdetls.Company1__c;
        workdetails.C1From__c = Wrkdetls.C1From__c;
        workdetails.C1To__c = Wrkdetls.C1To__c;
        workdetails.C1ProjectTitle__c = Wrkdetls.C1ProjectTitle__c;
        workdetails.C1projectDescription__c = Wrkdetls.C1projectDescription__c;
        
        workdetails.Company2__c = Wrkdetls.Company2__c;
        workdetails.C2From__c = Wrkdetls.C2From__c;
        workdetails.C2To__c = Wrkdetls.C2To__c;
        workdetails.C2ProjectTitle__c = Wrkdetls.C2ProjectTitle__c;
        workdetails.C2projectDescription__c = Wrkdetls.C2projectDescription__c;
        
        workdetails.Company3__c = Wrkdetls.Company3__c;
        workdetails.C3From__c = Wrkdetls.C3From__c;
        workdetails.C3To__c = Wrkdetls.C3To__c;
        workdetails.C3ProjectTitle__c = Wrkdetls.C3ProjectTitle__c;
        workdetails.C3projectDescription__c = Wrkdetls.C3projectDescription__c;
        workdetails.Achievement__c = Wrkdetls.Achievement__c;
        workdetails.Extra_Curricular__c = Wrkdetls.Extra_Curricular__c;
        workdetails.Languages_Known__c = Wrkdetls.Languages_Known__c;
        workdetails.LinkedIn_Profile_link__c = Wrkdetls.LinkedIn_Profile_link__c;
        workdetails.Submit__c = true;
        System.debug('workdetails?????'+workdetails);
        try{ 
        update workdetails;
       attachmentobj();
        }
        catch(DmlException ex){
        ApexPages.addMessages(ex);
        }
        }else{
        System.debug('fetchapplist #### 2');
        CareerServicesProfile__c workdetails = new CareerServicesProfile__c();
        workdetails.contact__c= contactId;
        //workdetails.id = appId;
        workdetails.Company1__c = Wrkdetls.Company1__c;
        workdetails.C1From__c = Wrkdetls.C1From__c;
        workdetails.C1To__c = Wrkdetls.C1To__c;
        workdetails.C1ProjectTitle__c = Wrkdetls.C1ProjectTitle__c;
        workdetails.C1projectDescription__c = Wrkdetls.C1projectDescription__c;
        
        workdetails.Company2__c = Wrkdetls.Company2__c;
        workdetails.C2From__c = Wrkdetls.C2From__c;
        workdetails.C2To__c = Wrkdetls.C2To__c;
        workdetails.C2ProjectTitle__c = Wrkdetls.C2ProjectTitle__c;
        workdetails.C2projectDescription__c = Wrkdetls.C2projectDescription__c;
        
        workdetails.Company3__c = Wrkdetls.Company3__c;
        workdetails.C3From__c = Wrkdetls.C3From__c;
        workdetails.C3To__c = Wrkdetls.C3To__c;
        workdetails.C3ProjectTitle__c = Wrkdetls.C3ProjectTitle__c;
        workdetails.C3projectDescription__c = Wrkdetls.C3projectDescription__c;
        workdetails.Achievement__c = Wrkdetls.Achievement__c;
        workdetails.Extra_Curricular__c = Wrkdetls.Extra_Curricular__c;
        workdetails.Languages_Known__c = Wrkdetls.Languages_Known__c;
        workdetails.LinkedIn_Profile_link__c = Wrkdetls.LinkedIn_Profile_link__c;
        workdetails.Submit__c = true;
        try{ 
        insert workdetails;
        attachmentobj();
        }
        catch(DmlException ex){
        ApexPages.addMessages(ex);
        }
     
        }
        
    return null;
    }
  
 
  //Button disabled 
  public Boolean getBtnDisabled() {
  List<CareerServicesProfile__c> workdetail = new List<CareerServicesProfile__c>();
  workdetail =[select id,Submit__c from CareerServicesProfile__c where Contact__c=:contactId limit 1];
    for(CareerServicesProfile__c w: workdetail) {
        if(w.Submit__c) {
            return true;
        }
    }
    return false;
}
  
    
     
//After insert the careerprofilejobobject to store the date into the attachment.   
  Public void attachmentobj(){
  
  CareerServicesProfile__c csp = new CareerServicesProfile__c();
   csp =[select id from CareerServicesProfile__c where Contact__c=:contactId  limit 1 ];
   contact conObj = new contact();
   conObj=[Select id,FirstName,LastName,Name from contact where id=:contactId limit 1];
   
   
    PageReference pdf = Page.Flame_Career_profilepdf_page;

  
    Blob body;
     try {

        // returns the output of the page as a PDF
        body = pdf.getContent();

        // need to pass unit test -- current bug    
        } catch (VisualforceException e) {
             body = Blob.valueOf('Some Text');
        }
   
    Attachment attach = new Attachment(); 
    attach.parentId = csp.id;
    attach.Name =  'Resume_'+ conObj.name +'_ '+date.today().format() +'.pdf';
    attach.body = body;
    attach.IsPrivate = false;
    insert attach;
    
  }  
    
 
  Public PageReference downloadpdf(){
    CareerServicesProfile__c csp = new CareerServicesProfile__c();
    csp =[select id from CareerServicesProfile__c where Contact__c=:contactId  limit 1 ];
    PageReference pdf = new PageReference('/apex/Flame_Career_profilepdf_page?id='+csp.id);
    pdf.setRedirect(true);
    return pdf;
   }     
        
  
    }