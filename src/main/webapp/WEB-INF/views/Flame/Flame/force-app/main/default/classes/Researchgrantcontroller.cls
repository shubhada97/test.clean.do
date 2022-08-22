/*Date:21-08-2019
Description: Research grant page controller.
---------------------------------------*/
Public class Researchgrantcontroller{
Public String FinishCommand{get;set;} 
Public String disabledButton {get;set;}
Public Research__c Researchobj {get;set;}
List<Research__c> Researchs;
List<Research__c> Researchgrantpdf; 
public String contactId {get;set;}
public User userDetails {get;set;}
public Contact userContact {get;set;}
Public String editId {get;set;}
Public String downloadId {get;set;}
List<Research__c> Researchgrantedit = new List<Research__c>();
public boolean flag{get;set;}

public boolean DisplayPopup {get; set;} 
//constructer 
Public Researchgrantcontroller(){
disabledButton='disabled';
Researchobj = new Research__c();
Researchs = new List<Research__c>();
Researchgrantpdf = new List<Research__c>();
Researchgrantedit =  new List<Research__c>();
 userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email,Area__c,Department__c from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
 flag = false;  
      
}
/*public String disabled{get; set;}
public Boolean getIsDisabled() {
        return 'Approved'.equals(disabled);
    }*/


    public PageReference Next() {
     String input1=Apexpages.currentPage().getParameters().get('input1');
        system.debug('==Entered the Controller: '+ input1);
        return null;
    }


  /*  public void enableSubmitButton(){
        System.debug('====FinishCommand==='+FinishCommand);
        if(FinishCommand == 'enableFinish')
        {
            disabledButton = 'disabled';
        }
        else if(FinishCommand == 'disableFinish'){
            disabledButton = '';
        }
        system.debug('inside enableSubmitButton');
        
    }*/
   
 Public String paymentErrorMsg {get;set;}   
 Public PageReference Save(){
 
   RecordType rt = [SELECT Id, Name from RecordType where name = 'Research Grant' AND SObjectType = 'Research__c'];

  try{
            Research__c research = new Research__c(); 
            research.RecordTypeId = rt.id ;
            research.Author_Name__c  = userDetails.ContactId;
            research.Title_of_publication__c = Researchobj.Title_of_publication__c;
            research.Application_Date__c = Researchobj.Application_Date__c;
            research.Principal_Faculty__c = userContact.Name;
            research.Background_Scope__c = Researchobj.Background_Scope__c;
            research.Brief_Review__c = Researchobj.Brief_Review__c;
            research.Methodology__c = Researchobj.Methodology__c;
            research.Research_Questions__c = Researchobj.Research_Questions__c;
            research.Milestone_1_Description__c = Researchobj.Milestone_1_Description__c;
            research.Milestone_1_Exp_Comp_Date__c = Researchobj.Milestone_1_Exp_Comp_Date__c;
            research.Milestone_1_Outcome__c = Researchobj.Milestone_1_Outcome__c;
            research.Milestone_2_Description__c = Researchobj.Milestone_2_Description__c;
            research.Milestone_2_Exp_Comp_Date__c = Researchobj.Milestone_2_Exp_Comp_Date__c;
            research.Milestone_2_Outcome__c = Researchobj.Milestone_2_Outcome__c;
            research.Milestone_3_Description__c = Researchobj.Milestone_3_Description__c;
            research.Milestone_3_Exp_Comp_Date__c = Researchobj.Milestone_3_Exp_Comp_Date__c;
            research.Milestone_3_Outcome__c = Researchobj.Milestone_3_Outcome__c;
            research.Milestone_4_Description__c = Researchobj.Milestone_4_Description__c;
            research.Milestone_4_Exp_Comp_Date__c = Researchobj.Milestone_4_Exp_Comp_Date__c;
            research.Milestone_4_Outcome__c = Researchobj.Milestone_4_Outcome__c;
            research.Milestone_5_Description__c = Researchobj.Milestone_5_Description__c;
            research.Milestone_5_Exp_Comp_Date__c = Researchobj.Milestone_5_Exp_Comp_Date__c;
            research.Milestone_5_Outcome__c = Researchobj.Milestone_5_Outcome__c;
            research.Milestone_6_Description__c = Researchobj.Milestone_6_Description__c;
            research.Milestone_6_Exp_Comp_Date__c = Researchobj.Milestone_6_Exp_Comp_Date__c;
            research.Milestone_6_Outcome__c = Researchobj.Milestone_6_Outcome__c;
            research.Milestone_7_Description__c = Researchobj.Milestone_7_Description__c;
            research.Milestone_7_Exp_Comp_Date__c = Researchobj.Milestone_7_Exp_Comp_Date__c;
            research.Milestone_7_Outcome__c = Researchobj.Milestone_7_Outcome__c;
            research.Expected_Outcome__c = Researchobj.Expected_Outcome__c;
            research.Significance__c = Researchobj.Significance__c;
            research.Collaboration_Details__c = Researchobj.Collaboration_Details__c;
            research.Financial_Assistance_Item_1__c = Researchobj.Financial_Assistance_Item_1__c;
            research.Financial_Assistance_Item_2__c = Researchobj.Financial_Assistance_Item_2__c;
            research.Financial_Assistance_Item_3__c = Researchobj.Financial_Assistance_Item_3__c;
            research.Financial_Assistance_Item_4__c = Researchobj.Financial_Assistance_Item_4__c;
            research.Financial_Assistance_Item_5__c = Researchobj.Financial_Assistance_Item_5__c;
            research.Financial_Assistance_Item_6__c = Researchobj.Financial_Assistance_Item_6__c;
            research.Financial_Assistance_Item_7__c = Researchobj.Financial_Assistance_Item_7__c;
            research.FA_Item_1_Expenditure__c = Researchobj.FA_Item_1_Expenditure__c;
            research.FA_Item_1_Percentage_Expenditure__c = Researchobj.FA_Item_1_Percentage_Expenditure__c;
            research.FA_Item_2_Expenditure__c = Researchobj.FA_Item_2_Expenditure__c;
            research.FA_Item_2_Percentage_Expenditure__c = Researchobj.FA_Item_2_Percentage_Expenditure__c;
            research.FA_Item_3_Expenditure__c = Researchobj.FA_Item_3_Expenditure__c;
            research.FA_Item_3_Percentage_Expenditure__c = Researchobj.FA_Item_3_Percentage_Expenditure__c;
            research.FA_Item_4_Expenditure__c = Researchobj.FA_Item_4_Expenditure__c;
            research.FA_Item_4_Percentage_Expenditure__c = Researchobj.FA_Item_4_Percentage_Expenditure__c;
            research.FA_Item_5_Expenditure__c = Researchobj.FA_Item_5_Expenditure__c;
            research.FA_Item_5_Percentage_Expenditure__c = Researchobj.FA_Item_5_Percentage_Expenditure__c;
            research.FA_Item_6_Expenditure__c = Researchobj.FA_Item_6_Expenditure__c;
            research.FA_Item_6_Percentage_Expenditure__c = Researchobj.FA_Item_6_Percentage_Expenditure__c;
            research.FA_Item_7_Expenditure__c = Researchobj.FA_Item_7_Expenditure__c;
            research.FA_Item_7_Percentage_Expenditure__c = Researchobj.FA_Item_7_Percentage_Expenditure__c;
            research.Total_Cost__c = Researchobj.Total_Cost__c;
            research.Agency_Support__c = Researchobj.Agency_Support__c;
            research.Agency_Support_Details__c = Researchobj.Agency_Support_Details__c;
            research.Co_authors__c = Researchobj.Co_authors__c;
            research.Dean_Approval__c = Researchobj.Dean_Approval__c;
            research.Dean_Funding__c = Researchobj.Dean_Funding__c;
            research.Dean_HOD__c = Researchobj.Dean_HOD__c;
            research.Dean_Reason__c = Researchobj.Dean_Reason__c;
            research.Department__c = Researchobj.Department__c;
            
            if(research != null){
            insert research;
            paymentErrorMsg = 'Thank you, research grant request has been submitted successfully.';
            displayPopup = true;
            }else{
            paymentErrorMsg = 'Please Try Again';
             displayPopup = true;
            }  
           
            
             return null;
  }catch(Exception e) {
    System.debug('An exception occurred: ' + e.getMessage());
   }
          
    return null;
  } 
   
   
 
 Public PageReference ClosePopup(){
    DisplayPopup = false;
    pagereference ApplyPage = new PageReference('/apex/Research_Grant_Request_Page'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }  
   
 // use in Researchgrant to fetch and view the recordes  to call the method.
    public List<Research__c> getResearchs() {
    
    Researchs = [SELECT id,Title_of_publication__c,Application_Date__c,Principal_Faculty__c,Total_Cost__c,Dean_Approval__c,VC_Approval__c,Dean_Funding__c,
    Dean_Reason__c,VC_Funding__c,VC_Reason__c FROM Research__c  where Author_Name__c=:userDetails.ContactId AND RecordType.Name = 'Research Grant' LIMIT 500 ];
    return Researchs;
    }
    //button action
 Public PageReference Newresearchgrant(){
    pagereference ApplyPage = new PageReference('/apex/Flame_Research_Grant_Page'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }
 
    // call to action method in NewPublicationeditPage name in  vfpage 
 Public PageReference recordEdited(){
   System.debug('###'+editId);
   List<Research__c> acList=[SELECT id,Title_of_publication__c,Application_Date__c,Principal_Faculty__c,Area__c,Department__c,
   Background_Scope__c,Methodology__c,Brief_Review__c,Research_Questions__c,Milestone_1_Description__c,Milestone_1_Exp_Comp_Date__c,Milestone_1_Outcome__c,
   Milestone_2_Description__c,Milestone_2_Exp_Comp_Date__c,Milestone_2_Outcome__c,Milestone_3_Description__c,Milestone_3_Exp_Comp_Date__c,Milestone_3_Outcome__c,
   Milestone_4_Description__c,Milestone_4_Exp_Comp_Date__c,Milestone_4_Outcome__c,Milestone_5_Description__c,Milestone_5_Exp_Comp_Date__c,Milestone_5_Outcome__c,
   Milestone_6_Description__c,Milestone_6_Exp_Comp_Date__c,Milestone_6_Outcome__c,Milestone_7_Description__c,Milestone_7_Exp_Comp_Date__c,Milestone_7_Outcome__c,
   Expected_Outcome__c,Significance__c,Collaboration_Details__c,Financial_Assistance_Item_1__c,FA_Item_1_Expenditure__c,FA_Item_1_Percentage_Expenditure__c,
   Financial_Assistance_Item_2__c,FA_Item_2_Expenditure__c,FA_Item_2_Percentage_Expenditure__c,Financial_Assistance_Item_3__c,FA_Item_3_Expenditure__c,FA_Item_3_Percentage_Expenditure__c,
   Financial_Assistance_Item_4__c,FA_Item_4_Expenditure__c,FA_Item_4_Percentage_Expenditure__c,Financial_Assistance_Item_5__c,FA_Item_5_Expenditure__c,FA_Item_5_Percentage_Expenditure__c,
   Financial_Assistance_Item_6__c,FA_Item_6_Expenditure__c,FA_Item_6_Percentage_Expenditure__c,Financial_Assistance_Item_7__c,FA_Item_7_Expenditure__c,FA_Item_7_Percentage_Expenditure__c,
   Total_Cost__c,Dean_HOD__c,Co_authors__c,Author_Name__r.Name,Agency_Support__c,Agency_Support_Details__c FROM Research__c  where Id=:editId  limit 1]; 
   
   pagereference pr = new PageReference('/apex/Research_Grant_edit_page?editId='+ editId); 
   pr.setRedirect(true);          
   return pr;
 } 
 Research__c Recordediting;
 Public Research__c GetRecordediting(){
  Id id = ApexPages.currentPage().getParameters().get('editId');
  System.debug('---id---'+id);
   //if(Recordediting == null)
  
   Recordediting = [SELECT id,Title_of_publication__c,Application_Date__c,Principal_Faculty__c,Area__c,Department__c,
   Background_Scope__c,Methodology__c,Brief_Review__c,Research_Questions__c,Milestone_1_Description__c,Milestone_1_Exp_Comp_Date__c,Milestone_1_Outcome__c,
   Milestone_2_Description__c,Milestone_2_Exp_Comp_Date__c,Milestone_2_Outcome__c,Milestone_3_Description__c,Milestone_3_Exp_Comp_Date__c,Milestone_3_Outcome__c,
   Milestone_4_Description__c,Milestone_4_Exp_Comp_Date__c,Milestone_4_Outcome__c,Milestone_5_Description__c,Milestone_5_Exp_Comp_Date__c,Milestone_5_Outcome__c,
   Milestone_6_Description__c,Milestone_6_Exp_Comp_Date__c,Milestone_6_Outcome__c,Milestone_7_Description__c,Milestone_7_Exp_Comp_Date__c,Milestone_7_Outcome__c,
   Expected_Outcome__c,Significance__c,Collaboration_Details__c,Financial_Assistance_Item_1__c,FA_Item_1_Expenditure__c,FA_Item_1_Percentage_Expenditure__c,
   Financial_Assistance_Item_2__c,FA_Item_2_Expenditure__c,FA_Item_2_Percentage_Expenditure__c,Financial_Assistance_Item_3__c,FA_Item_3_Expenditure__c,FA_Item_3_Percentage_Expenditure__c,
   Financial_Assistance_Item_4__c,FA_Item_4_Expenditure__c,FA_Item_4_Percentage_Expenditure__c,Financial_Assistance_Item_5__c,FA_Item_5_Expenditure__c,FA_Item_5_Percentage_Expenditure__c,
   Financial_Assistance_Item_6__c,FA_Item_6_Expenditure__c,FA_Item_6_Percentage_Expenditure__c,Financial_Assistance_Item_7__c,FA_Item_7_Expenditure__c,FA_Item_7_Percentage_Expenditure__c,
   Total_Cost__c,Dean_HOD__c,Co_authors__c,Author_Name__r.Name,Agency_Support__c,Agency_Support_Details__c FROM Research__c  where Id=:id limit 1];
   System.debug('----Recordediting----'+Recordediting);
     
     
     return Recordediting;
  }
  
  Public String paymentErrorMsg1 {get;set;}
  //Research grant edit page button.
  Public Void Saveedit(){
      System.debug('----BackgroundScopeTemp after Edit----'+Recordediting.Background_Scope__c);
      if(Recordediting != null){
           update Recordediting;
            paymentErrorMsg1 = 'Thank you, research grant request has been submitted successfully.';
            displayPopup = true;
            }else{
            paymentErrorMsg1 = 'Please Try Again';
             displayPopup = true;
            }   
   
  // pagereference editPage = new PageReference('/apex/Research_Grant_Request_Page'); 
  //  editPage.setRedirect(true);          
  //  return editPage;
  }
  
  // call to action method in download button name in  vfpage 
 Public PageReference download(){
   System.debug('###'+downloadId);
   Researchgrantpdf =  new List<Research__c>();
   for(Research__c a :[SELECT id,Title_of_publication__c,Application_Date__c,Principal_Faculty__c,Area__c,Department__c,
   Background_Scope__c,Methodology__c,Brief_Review__c,Research_Questions__c,Milestone_1_Description__c,Milestone_1_Exp_Comp_Date__c,Milestone_1_Outcome__c,
   Milestone_2_Description__c,Milestone_2_Exp_Comp_Date__c,Milestone_2_Outcome__c,Milestone_3_Description__c,Milestone_3_Exp_Comp_Date__c,Milestone_3_Outcome__c,
   Milestone_4_Description__c,Milestone_4_Exp_Comp_Date__c,Milestone_4_Outcome__c,Milestone_5_Description__c,Milestone_5_Exp_Comp_Date__c,Milestone_5_Outcome__c,
   Milestone_6_Description__c,Milestone_6_Exp_Comp_Date__c,Milestone_6_Outcome__c,Milestone_7_Description__c,Milestone_7_Exp_Comp_Date__c,Milestone_7_Outcome__c,
   Expected_Outcome__c,Significance__c,Collaboration_Details__c,Financial_Assistance_Item_1__c,FA_Item_1_Expenditure__c,FA_Item_1_Percentage_Expenditure__c,
   Financial_Assistance_Item_2__c,FA_Item_2_Expenditure__c,FA_Item_2_Percentage_Expenditure__c,Financial_Assistance_Item_3__c,FA_Item_3_Expenditure__c,FA_Item_3_Percentage_Expenditure__c,
   Financial_Assistance_Item_4__c,FA_Item_4_Expenditure__c,FA_Item_4_Percentage_Expenditure__c,Financial_Assistance_Item_5__c,FA_Item_5_Expenditure__c,FA_Item_5_Percentage_Expenditure__c,
   Financial_Assistance_Item_6__c,FA_Item_6_Expenditure__c,FA_Item_6_Percentage_Expenditure__c,Financial_Assistance_Item_7__c,FA_Item_7_Expenditure__c,FA_Item_7_Percentage_Expenditure__c,
   Total_Cost__c,Dean_HOD__c,Co_authors__c,Author_Name__r.Name,Agency_Support__c,Agency_Support_Details__c FROM Research__c where  id=:downloadId limit 1]){
 
   }

   PageReference pdf = new PageReference('/apex/Researchgrantdownloadpdf?downloadId='+ downloadId);
   pdf.setRedirect(true);
   return pdf;
  } 
 // dowload fields to get the dispaly in frontend.
 Public List<Research__c> GetRecordFetching(){
 Id id = ApexPages.currentPage().getParameters().get('downloadId');
   Researchgrantpdf =  new List<Research__c>();
 
   List<Research__c> listitem = [SELECT id,Title_of_publication__c,Application_Date__c,Principal_Faculty__c,Area__c,Department__c,
   Background_Scope__c,Methodology__c,Brief_Review__c,Research_Questions__c,Milestone_1_Description__c,Milestone_1_Exp_Comp_Date__c,Milestone_1_Outcome__c,
   Milestone_2_Description__c,Milestone_2_Exp_Comp_Date__c,Milestone_2_Outcome__c,Milestone_3_Description__c,Milestone_3_Exp_Comp_Date__c,Milestone_3_Outcome__c,
   Milestone_4_Description__c,Milestone_4_Exp_Comp_Date__c,Milestone_4_Outcome__c,Milestone_5_Description__c,Milestone_5_Exp_Comp_Date__c,Milestone_5_Outcome__c,
   Milestone_6_Description__c,Milestone_6_Exp_Comp_Date__c,Milestone_6_Outcome__c,Milestone_7_Description__c,Milestone_7_Exp_Comp_Date__c,Milestone_7_Outcome__c,
   Expected_Outcome__c,Significance__c,Collaboration_Details__c,Financial_Assistance_Item_1__c,FA_Item_1_Expenditure__c,FA_Item_1_Percentage_Expenditure__c,
   Financial_Assistance_Item_2__c,FA_Item_2_Expenditure__c,FA_Item_2_Percentage_Expenditure__c,Financial_Assistance_Item_3__c,FA_Item_3_Expenditure__c,FA_Item_3_Percentage_Expenditure__c,
   Financial_Assistance_Item_4__c,FA_Item_4_Expenditure__c,FA_Item_4_Percentage_Expenditure__c,Financial_Assistance_Item_5__c,FA_Item_5_Expenditure__c,FA_Item_5_Percentage_Expenditure__c,
   Financial_Assistance_Item_6__c,FA_Item_6_Expenditure__c,FA_Item_6_Percentage_Expenditure__c,Financial_Assistance_Item_7__c,FA_Item_7_Expenditure__c,FA_Item_7_Percentage_Expenditure__c,
   Total_Cost__c,Dean_HOD__c,Co_authors__c,Author_Name__r.Name,Agency_Support__c,Agency_Support_Details__c FROM Research__c where  Id=:id limit 1];

if(listitem.size() > 0)
{
        Researchgrantpdf.addall(listitem);        
}    
          return Researchgrantpdf;
}

 
}