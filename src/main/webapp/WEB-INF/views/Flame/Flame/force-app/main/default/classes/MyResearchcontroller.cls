public class MyResearchcontroller {
    public String contactId {get;set;}
    public User userDetails {get;set;}
    public Contact userContact {get;set;}
    Public Boolean IsCreated {get;set;} 
    public Boolean IsTicketDetials {get;set;}
    List<Research__c> Researchs;
    List<Research__c> Researchss;
    public Research__c objResearch {get;set;}
    public List<SelectOption> recordTypeList {get;set;}
    public Attachment myfile {get;set;}
    @TestVisible Private Research__c ResearchId{get;set;} 
    Public contact con {get;set;}
    Public String editId {get;set;}
    Public List<Research__c> researchlist {get;set;}
    Public Attachment getmyfile()
    {
        myfile = new Attachment();
        return myfile;
    }
    
    
  //constructer  
    Public MyResearchcontroller(){
    objResearch = new Research__c();
    objResearch.Scopus__c =' No';
   
   
     myfile = new Attachment();
    userDetails = [Select id,contactid from User where id =: UserInfo.getUserId()];
        System.debug('User Info :'+userDetails);        
        
       if(userDetails.ContactId!=null){
                userContact = [Select id,Name,Email from Contact Where id=:userDetails.ContactId];                                    
                System.debug('User Contact Id  : '+ userDetails.ContactId);
            }
     IsCreated = false;
     IsTicketDetials = true;
    }
    
   // use in MyResearchpage to call the method.
    public List<Research__c> getResearchs() {
    if(Researchs == null)
    Researchs = [SELECT id,Article_Book_URL__c,Author_Name__c,Author_Name__r.Name,Category_Claimed__c,Co_authors__c,Rewarded__c,Approved__c,Does_the_paper_have_atleast_one_author_w__c,
    Department__c,FLAME_Author__c,Issue__c,Name_of_journal_publisher__c,PP__c,Publication_Category__c,Other_journal_publisher__c,Notes__c,Name_of_journal_publisher_txt__c,
    Rating_Claimed__c,Title_of_publication__c,Volume__c,Year_of_Publication__c,Scopus__c,SJR__c,WoS__c,ABDC__c FROM Research__c where Author_Name__c=:userDetails.ContactId  AND RecordType.Name != 'Research Grant' AND RecordType.Name != 'Research Requisition' AND RecordType.Name != 'Research Travel'  LIMIT 500];
    return Researchs;
    }
    //button action
 Public PageReference NewPublication(){
    pagereference ApplyPage = new PageReference('/apex/NewPublicationPage'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }
   public String selectedRT {get;set;}
   public String fieldValue {get; set;}
   
   Public PageReference saveCase(){
   
    RecordType rtList = [SELECT Id,Name FROM RecordType WHERE SObjectType='Research__c' AND Name=:fieldValue limit 1];
    List<RecordType> recordlist =new List<RecordType>();
    recordlist.add(rtList);
    selectedRT =recordlist[0].id;
    system.debug('selectedRT'+selectedRT);
    
    List<Research__c> Researchlist = new List<Research__c>();
    Research__c res = new Research__c();
    res.Article_Book_URL__c = objResearch.Article_Book_URL__c;
    res.Author_Name__c      = userDetails.ContactId;
    res.Category_Claimed__c = objResearch.Category_Claimed__c;
    res.Co_authors__c       = objResearch.Co_authors__c;
    res.Department__c       = objResearch.Department__c;
    res.FLAME_Author__c     = objResearch.Author_Name__r.Name;
    res.Issue__c            = objResearch.Issue__c;
    res.Name_of_journal_publisher__c = objResearch.Name_of_journal_publisher__c;
    res.PP__c               = objResearch.PP__c;
    res.Scopus__c           = objResearch.Scopus__c;
    res.SJR__c              = objResearch.SJR__c;
    res.WoS__c              = objResearch.WoS__c;
    res.ABDC__c             = objResearch.ABDC__c;
    res.Publication_Category__c = objResearch.Publication_Category__c;
    res.Rating_Claimed__c   = objResearch.Rating_Claimed__c;
    res.Title_of_publication__c = objResearch.Title_of_publication__c;
    res.Volume__c           = objResearch.Volume__c;
    res.Year_of_Publication__c  = objResearch.Year_of_Publication__c;
    res.Department__c       = objResearch.Department__c;
    res.Other_journal_publisher__c = objResearch.Other_journal_publisher__c;
    res.Does_the_paper_have_atleast_one_author_w__c = objResearch.Does_the_paper_have_atleast_one_author_w__c;
    res.Other_journal_publisher__c= objResearch.Other_journal_publisher__c;
    res.Notes__c = objResearch.Notes__c;
    res.Name_of_journal_publisher_txt__c = objResearch.Name_of_journal_publisher_txt__c;
    res.RecordTypeId        = selectedRT;
    Researchlist.add(res);
    insert Researchlist;
    if(myfile.name != null && myfile.body != null){
    ResearchId = Researchlist[0];
    system.debug('Researchlist'+Researchlist);
    Attachment a = new Attachment(parentId =ResearchId.id, name=myfile.name, body = myfile.body);
    insert a;
    }  
    pagereference ApplyPage = new PageReference('/apex/MyResearchpage'); 
    ApplyPage.setRedirect(true);          
    return ApplyPage;
   
                    
 
 }
  
 // click on the edit action method
 Public PageReference NewPublicationedit(){
    System.Debug('The value in accId id :'+ editId);
    List<Research__c> acList=[SELECT id,Article_Book_URL__c,Author_Name__c,Author_Name__r.Name,Category_Claimed__c,Co_authors__c,Rewarded__c,Approved__c,Does_the_paper_have_atleast_one_author_w__c,
    Department__c,FLAME_Author__c,Issue__c,Name_of_journal_publisher__c,PP__c,Publication_Category__c,Other_journal_publisher__c,Notes__c,Name_of_journal_publisher_txt__c,
    Rating_Claimed__c,Title_of_publication__c,Volume__c,Year_of_Publication__c,Scopus__c,SJR__c,WoS__c,ABDC__c FROM Research__c where Id=:editId AND RecordType.Name != 'Research Grant' AND RecordType.Name != 'Research Requisition' AND RecordType.Name != 'Research Travel'];
    pagereference ApplyPage = new PageReference('/apex/NewPublicationeditPage?id='+ editId);
    ApplyPage.setRedirect(true);          
    return ApplyPage;                    
 
 }
 
 // call to action method in NewPublicationeditPage name in  vfpage 
 Public Void NewPublicationeditcont(){
  Id id = ApexPages.currentPage().getParameters().get('editId') ; 
 }
  
  // use in MyResearchpage to call the method.
    public List<Research__c> getResearchss() {
    Id id = ApexPages.currentPage().getParameters().get('Id') ; 
    system.debug('id'+id);
    if(Researchss == null)
    Researchss = [SELECT id,Article_Book_URL__c,Author_Name__c,Author_Name__r.Name,Category_Claimed__c,Co_authors__c,Rewarded__c,Approved__c,Does_the_paper_have_atleast_one_author_w__c,
    Department__c,FLAME_Author__c,Issue__c,Name_of_journal_publisher__c,PP__c,Publication_Category__c,Other_journal_publisher__c,Notes__c,Name_of_journal_publisher_txt__c,
    Rating_Claimed__c,Title_of_publication__c,Volume__c,Year_of_Publication__c,Scopus__c,SJR__c,WoS__c,ABDC__c FROM Research__c where  id=:id AND RecordType.Name != 'Research Grant' AND RecordType.Name != 'Research Requisition' AND RecordType.Name != 'Research Travel'];
    return Researchss;
    }     
  // edit the record 
  Public PageReference editsave(){
   Id id = ApexPages.currentPage().getParameters().get('Id') ; 
   IsCreated = true;
   return null;
   }
  
  
 Public PageReference popupsubmit(){
    update Researchss;
    pagereference ApplyPage = new PageReference('/apex/MyResearchpage'); 
    IsCreated = true;
    ApplyPage.setRedirect(true);
    return  ApplyPage; 
    }
    
   //Button disabled 
  public Boolean getyourBooleanVariable() {
   Id id = ApexPages.currentPage().getParameters().get('editId') ;
  List<Research__c> workdetail = new List<Research__c>();
  workdetail =[select id,Approved__c from Research__c where id=:id limit 1];
    for(Research__c w: workdetail) {
        if(w.Approved__c == true) {
            return true;
        }
    }
    return false;
}  
    
 public void passValueToController()   
    {        
       fieldValue = objResearch.Publication_Category__c; //this will assign the selected value to Controller variable.
      system.debug('fieldValue'+fieldValue);
    }
  
    
       }