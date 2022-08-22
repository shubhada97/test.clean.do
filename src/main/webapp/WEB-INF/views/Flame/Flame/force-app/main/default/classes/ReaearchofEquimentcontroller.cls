Public class ReaearchofEquimentcontroller{
List<Research__c> Researchs;
List<Research__c> ResearchTravel;
Public Research__c Research1 {get;set;}
Public Boolean  showContent {get;set;} 
Public Boolean  showContent1 {get;set;}
Public Boolean  showContent2 {get;set;} 
public Map<String,String> recordTypeNameMap {get;set;} 
public User userDetails {get;set;}
public Contact userContact {get;set;}    
Public Boolean displayPopUp {get;set;}
Public String downloadId {get;set;} 
List<Research__c> Researchgrantpdf;    
 //constructer.   
Public ReaearchofEquimentcontroller(){
Research1 = new Research__c();
recordTypeNameMap = new Map<String,String>();
Researchs = new List<Research__c>();
ResearchTravel = new List<Research__c>();
Researchgrantpdf = new List<Research__c>();      
init();
displayPopUp = false;
showContent1 =false;
showContent2 = false;    
}


//-- default initalization method
    public void init(){                        
        
       
        //-- get user details
        if(Flame_CommunityUserInfo.profileName=='System Administrator'){
            userDetails = [Select id,Community_Contact_ID__c from User where id =: UserInfo.getUserId()];    
        }else{
            userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];             
        }
        System.debug('User Info :'+userDetails);        
        
       userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
               
            }
   
     
    }


//Add the rows
    public Void addNewItemList() {
    showContent1 = true;
    showContent2 = false; 
    }
     public Void addNewItemList1() {
     showContent1 = true;
     showContent2 = true;
    }

//Delete the rows
  
 public Void  removeNewItemList1() {
 List< Research__c> CS =  [Select id,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c From Research__c where Author_Name__c=:userDetails.ContactId  order by createdDate DESC LIMIT 1 ];
        
        for( Research__c rech : CS){
        if(rech.Item_Description2__c != NULL){
        rech.Item_Description2__c = '';
        rech.Quantity2__c='';
        rech.Units_Of_Measurement2__c =NULL;
        rech.Units_Of_Measurement2__c ='';
        }
        }
        update CS;
     showContent1 = false;
     showContent2 = false;
    }
   public Void  removeNewItemList2() {
     List< Research__c> CS =  [Select id,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c From Research__c where Author_Name__c=:userDetails.ContactId  order by createdDate DESC LIMIT 1 ];
        
        for( Research__c rech : CS){
        if(rech.Item_Description3__c != NULL){
        rech.Item_Description3__c = '';
        rech.Quantity3__c='';
        rech.Units_Of_Measurement3__c =NULL;
        rech.Units_Of_Measurement3__c ='';
        }
        }
        update CS;
     showContent1 = true;
     showContent2 = false;
    }
  
// save the record 

  public PageReference saveCase() {
    Research__c rech = new Research__c();
    RecordType rt = [SELECT Id, Name from RecordType where name = 'Research Requisition' AND SObjectType = 'Research__c'];
    rech.Author_Name__c      = userDetails.ContactId;
    rech.RecordTypeId      = rt.Id;
    rech.Author_Name__c      = userDetails.ContactId;
    system.debug('userDetails.ContactId'+userDetails.ContactId);
    rech.Requisition_Type__c      = Research1.Requisition_Type__c;
    
    rech.Requesting_On_Behalf_Of__c      = Research1.Requesting_On_Behalf_Of__c;
    rech.Requisition_Purpose__c      = Research1.Requisition_Purpose__c;
    rech.S_No__c      = Research1.S_No__c;
    rech.Item_Description__c      = Research1.Item_Description__c;
    rech.Quantity__c      = Research1.Quantity__c;
    rech.Units_Of_Measurement__c      = Research1.Units_Of_Measurement__c;
    rech.Item_Description2__c      = Research1.Item_Description2__c;
    rech.Quantity2__c      = Research1.Quantity2__c;
    rech.Units_Of_Measurement2__c      = Research1.Units_Of_Measurement2__c;
    rech.Item_Description3__c      = Research1.Item_Description3__c;
    rech.Quantity3__c      = Research1.Quantity3__c;
    rech.Units_Of_Measurement3__c      = Research1.Units_Of_Measurement3__c;
     
    try{
       insert rech;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank you Your Request has been submitted.'));
     displayPopUp = true;
        
        }catch(dmlexception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Please try Again'));
        }
        return null;
    }

Public PageReference closePopup(){
 displayPopUp = false;
  PageReference pdf = new PageReference('/apex/Requirementstatuspage');
    pdf.setRedirect(true);
    return pdf;
}
// use in Researchgrant to fetch and view the recordes  to call the method.
    public List<Research__c> getResearchs() {
    
    Researchs = [Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c From Research__c where Author_Name__c=:userDetails.ContactId AND RecordType.Name = 'Research Requisition' LIMIT 500 ];
    return Researchs;
    }
    
 // use in Researchtravel to fetch and view the recordes  to call the method.
    public List<Research__c> getResearchtravel() {
    
    Researchtravel = [Select id,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where Author_Name__c=:userDetails.ContactId AND RecordType.Name = 'Research Travel' LIMIT 500 ];
    return Researchtravel;
    }   
    
    
     //button action
 Public PageReference Newrequisition(){
    pagereference ApplyPage = new PageReference('/apex/ReaearchofEquiment'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }  
/* test class coad coverage try and catch 
http://www.infallibletechie.com/2015/11/how-to-cover-catch-block-in-test-class.html
If(Test.isRunningTest())
{
   Integer x = 1/0; //Controller will reach here only when code is runninging test mode and will throw exception e.
} */
Public String editId {get;set;}
   // call to action method in NewPublicationeditPage name in  vfpage 
 Public PageReference recordEdited(){
   System.debug('###'+editId);
   List<Research__c> acList=[Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where Id=:editId  limit 1]; 
   
   pagereference pr = new PageReference('/apex/Requisitioneditpage?editId='+ editId); 
   pr.setRedirect(true);          
   return pr;
 } 
 
 // travel requesest.
 Public PageReference recordEdited1(){
   System.debug('###'+editId);
   List<Research__c> acList=[Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where Id=:editId  limit 1]; 
   
   pagereference pr = new PageReference('/apex/Travel_Requesteditpage?editId='+ editId); 
   pr.setRedirect(true);          
   return pr;
 } 
 Research__c Recordediting;
 Public Research__c GetRecordediting(){
  Id id = ApexPages.currentPage().getParameters().get('editId');
  System.debug('---id---'+id);
   //if(Recordediting == null)
  
   Recordediting = [Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c  From Research__c where Id=:id limit 1];
   System.debug('----Recordediting----'+Recordediting);
  
     return Recordediting;
  }
  //Research grant edit page button.
  Public Void Saveedit(){
    try{
       update Recordediting;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank you Your Request has been submitted.'));
     displayPopUp = true;
        
        }catch(dmlexception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Please try Again'));
        }
  }



  // call to action method in download button name in  vfpage 
 Public PageReference download(){
   System.debug('###'+downloadId);
   Researchgrantpdf =  new List<Research__c>();
   for(Research__c a :[Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where  id=:downloadId limit 1]){
 
   }

   PageReference pdf = new PageReference('/apex/Reruisitionpdfpage?downloadId='+ downloadId);
   pdf.setRedirect(true);
   return pdf;
  } 
 // dowload fields to get the dispaly in frontend.
 Public List<Research__c> GetRecordFetching(){
 Id id = ApexPages.currentPage().getParameters().get('downloadId');
   Researchgrantpdf =  new List<Research__c>();
 
   List<Research__c> listitem = [Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
     Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where  Id=:id limit 1];

if(listitem.size() > 0)
{
        Researchgrantpdf.addall(listitem);        
}    
          return Researchgrantpdf;
}
//travel request 

  //button action
 Public PageReference Newtravelrequest(){
    pagereference ApplyPage = new PageReference('/apex/Reaearchtravelrequest'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }  

Public PageReference savetravelrequest(){
 Research__c rechs = new Research__c();
 RecordType rt = [SELECT Id, Name from RecordType where name = 'Research Travel' AND SObjectType = 'Research__c']; 
    rechs.Author_Name__c      = userDetails.ContactId;
    rechs.RecordTypeId      = rt.Id;
    rechs.TRS_Requisition_For__c      = Research1.TRS_Requisition_For__c;
    rechs.Subject__c      = Research1.Subject__c;
    rechs.TRS_Purpose_Of_The_Visit__c      = Research1.TRS_Purpose_Of_The_Visit__c;
    rechs.TRS_Message__c      = Research1.TRS_Message__c;
    rechs.TRS_Mode_Of_Travel__c      = Research1.TRS_Mode_Of_Travel__c;
    rechs.Round_Trip__c      = Research1.Round_Trip__c;
    rechs.Travel_From__c      = Research1.Travel_From__c;
    rechs.Travel_To__c      = Research1.Travel_To__c;
    rechs.Departure_Date__c      = Research1.Departure_Date__c;
    rechs.Departure_Pickup_Time__c      = Research1.Departure_Pickup_Time__c;
    rechs.Departure_Pickup_Location__c      = Research1.Departure_Pickup_Location__c;
    rechs.Return_Date__c      = Research1.Return_Date__c;
    rechs.Return_Pickup_Location__c      = Research1.Return_Pickup_Location__c;
    rechs.Return_Pickup_Time__c      = Research1.Return_Pickup_Time__c; 
    rechs.TRS_Traveler_Name__c      = Research1.TRS_Traveler_Name__c;
    rechs.TRS_Traveler_Mobile__c      = Research1.TRS_Traveler_Mobile__c;
    rechs.TRS_Traveler_Email__c     = Research1.TRS_Traveler_Email__c; 
 try{
       insert rechs;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Thank you Your Request has been submitted.'));
     displayPopUp = true;
        
        }catch(dmlexception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Please try Again'));
        }
return null;
}

Public PageReference closePopup1(){
 displayPopUp = false;
  PageReference pdf = new PageReference('/apex/ResearchTravelRequest');
    pdf.setRedirect(true);
    return pdf;
}

 // call to action method in download button name in  vfpage 
 Public PageReference download1(){
   System.debug('###'+downloadId);
   Researchgrantpdf =  new List<Research__c>();
   for(Research__c a :[Select id,Requisition_Type__c,Units_Of_Measurement2__c,Units_of_Measurement3__c,Units_Of_Measurement__c,S_No__c,
     Quantity3__c,Quantity2__c,Quantity__c,Item_Description3__c,Item_Description2__c,Item_Description__c,Dean_Approval__c,Dean_Reason__c,VC_Approval__c,VC_Reason__c,TRS_Traveler_Name__c,TRS_Traveler_Mobile__c,TRS_Traveler_Email__c,
     Requesting_On_Behalf_Of__c,Requisition_Purpose__c,TRS_Requisition_For__c,Subject__c,TRS_Purpose_Of_The_Visit__c,TRS_Message__c,TRS_Mode_Of_Travel__c,Round_Trip__c,Travel_From__c,Travel_To__c,Departure_Date__c,
    Departure_Pickup_Time__c,Departure_Pickup_Location__c,Return_Date__c,Return_Pickup_Location__c,Return_Pickup_Time__c From Research__c where  id=:downloadId limit 1]){
 
   }

   PageReference pdf = new PageReference('/apex/Researchtravelpdfpage?downloadId='+ downloadId);
   pdf.setRedirect(true);
   return pdf;
  } 

}