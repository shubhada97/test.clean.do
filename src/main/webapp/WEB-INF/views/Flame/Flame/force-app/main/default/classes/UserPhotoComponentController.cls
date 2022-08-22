public with sharing class UserPhotoComponentController
{
public User UserID{get;set;}
public String  AppId {get;set;}
 public Application__c  apps{get;set;}

public String SOPSubmitted {get;set;}
  public String getSOPSubmitted(){    
        if(SOPSubmitted == null || SOPSubmitted == '' ) {
            user userID ;
            Contact Con ;
            Application__c apps ;      
            userID=[Select Id,ContactId from User where Id = : UserInfo.getUserId()];
            Con = [Select ID,Email From Contact Where ID =: userID.ContactId];
            
            System.debug('Data==>' +  [select id,Application_Reference_ID__c,ApplicationPDFLink__c,Completed_Stages__c,FUA_SOP_Submitted__c,Statement_of_Purpose__c,contact__c from Application__c WHERE contact__c =: userID.ContactID].Statement_of_Purpose__c);
            return [select id,Application_Reference_ID__c,ApplicationPDFLink__c,Completed_Stages__c,FUA_SOP_Submitted__c,Statement_of_Purpose__c,contact__c from Application__c WHERE contact__c =: userID.ContactID].Statement_of_Purpose__c; 
      
        
        }else {
            return SOPSubmitted;
        }
    }








Public UserPhotoComponentController(){
    Application__c  apps =new Application__c();
    UserID=[Select Id,name,ContactId from User where Id = :UserInfo.getUserId()];
    apps =[Select id,name,Contact__r.Name,Completed_Stages__c,Application_Reference_ID__c,Program__r.name,contact__c,GD_and_PI_Round__c,GD_and_PI_Center__c,Statement_of_Purpose__c,Achievments__c,Other_Details__c,FUA_Submission_Date__c,  FUA_Submission_Place__c,FUA_Applicant_Name__c,FLAME_Entrance_Aptitude_Test_FEAT__c,SAT_Score__c,ACT_Score__c from Application__c WHERE Contact__c =: UserID.ContactID LIMIT 1]; 
    system.debug('applicationList.Id>>>>>>>>>>>>>>>>>>>>>>>>'+apps.Id);
   Appid =apps.id;
    system.debug('>>>>>>>>>>>>>>>>>>>>Appid>>>>>'+Appid);

    }

  
public string photourl{get
    {
           if(photourl != null || photourl !='')
           photourl = [select id, FUA_Applicant_Image_URL__c from Application__c  where id =: Appid limit 1].FUA_Applicant_Image_URL__c;
           return photourl; 
    }set;
    
    }
    
    
        public blob Photo{get;set;}
        public transient  String imageBase64{get;set;}
   
   public String actionPhotoLabel 
    {
        get {
            try{
                 return (photourl== null || photourl== '') ? 'Add' : 'Update';
            }
            catch(Exception e){return null;}
            }
        set;
    }   
   
   
    public pagereference UploadPhotoAtt()
    {
   
        try
        {
            //imageBase64  = imageBase64.split(',')[1];
            if(imageBase64!=null && imageBase64!=''){
            System.debug('>>>' +Appid);
            Attachment objA=new Attachment();
            objA.body = EncodingUtil.base64Decode(imageBase64 );
            objA.name = 'Photo_'+Appid;
            objA.parentid= Appid;
            objA.ContentType = 'image/png';
            insert objA;
            
            System.debug('vcr---attachment done -objA id--'+objA);
            string Attid= objA.id;
            string attachmentid=Attid.substring(0,15);
            Application__c app = new Application__c();
            app.id=Appid;
            app.FUA_Applicant_Image_URL__c = '/servlet/servlet.FileDownload?file='+attachmentid;
            update app;            
            System.debug('vcr---attachment done -APP updated--'+app);
           
            photourl = app.FUA_Applicant_Image_URL__c; 
            }else{
           
            }
            PageReference nextPage = new PageReference('/apex/PhotographUpload_1');
            imageBase64 = null;
            nextPage.setRedirect(true);
           
            return nextPage;       
        }catch(Exception e)
        {
             system.debug('Exception message'+e);
             return null;
        }
        
        return null; 
 } 
 

 }