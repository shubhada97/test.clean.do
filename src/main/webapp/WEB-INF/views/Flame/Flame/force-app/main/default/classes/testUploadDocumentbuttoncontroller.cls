@isTest(SeeAllData=true)
Public Class testUploadDocumentbuttoncontroller {
 public static testMethod void testMyController_1() {

 Contact doccon =[Select id from contact limit 1];
 UploadDocumentbuttoncontroller2 upload = new UploadDocumentbuttoncontroller2();
 ContentVersion file = new ContentVersion();
  Contact con= new Contact();
  con.CVUE_Student_Number__c = 'f5343';
  con.FirstName = 'varma';
  //insert con;
 Test.startTest(); 
 //upload.add(); 
 upload.addRows(); 
 upload.getFileList();
 upload.deleteRows();

 
 List<Document> docs = new List<Document>();
 Folder folder = [Select id from folder where name='Flame Static Content'];
 Document doc = new Document();
 docs.add(doc);
 
 ContentVersion conten =[SELECT Id, ExternalDataSourceId, ContentDocumentId, Title FROM ContentVersion limit 1]; 
 List<ContentVersion> lcv=new List<ContentVersion>();
 ContentVersion v = new ContentVersion();
  v.title = 'testing';
  v.pathOnClient ='/somepath.txt';
  lcv.add(v);
  //insert lcv;  
 List<ContentDocumentLink> lcd=new List<ContentDocumentLink>();
 ContentDocumentLink c = new ContentDocumentLink();
    c.LinkedEntityId = con.Id; // workspaceId where user wants to publish the file.
    c.ShareType = 'I';
    c.Visibility = 'AllUsers'; 
    lcd.add(c);
 //insert lcd;
 contact conId = new contact();
ApexPages.StandardController hosvolcon= new ApexPages.standardController(doccon);
apexpages.currentpage().getparameters().put('id','doccon.id'); 

UploadDocumentbuttoncontroller2 hosvol = new UploadDocumentbuttoncontroller2(hosvolcon);
hosvol.add();
//hosvol.upload();
 

 test.stopTest();
  }
 public static testmethod void m1() {
 
UploadDocumentbuttoncontroller2 hot = new UploadDocumentbuttoncontroller2(); 
List<SelectOption> options = new List<SelectOption>();
PageReference pageref = Page.Upload_Document_Button2;
  Test.setCurrentPageReference(pageref); 
  hot.Health();
 }

}