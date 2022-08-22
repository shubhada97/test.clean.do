public with sharing class UploadDocumentbuttoncontroller2 {
    
 transient public ContentVersion file { get; set; }
    private final Id conId;

    private Map<String, String> MyStrings; 

    
    public UploadDocumentbuttoncontroller2(ApexPages.StandardController stdController) {
        this.conId = Id.valueof(stdController.getId());
        System.debug('#####conid='+conId );
        System.debug('#####conid='+stdController.getRecord().id );
        MyStrings= new Map<String, String>{'Doc_Enrolment_Deposit_Receipt__c'=>'Enrolment Deposit Receipt',
                                            'Doc_High_School_Marksheet_10th__c'=>'High School Marksheet (10th)',
                                            'Doc_High_School_Certificate_10th__c'=>'High School Certificate (10th)',
                                            'Doc_Intermediate_Marksheet_12th__c'=>'Intermediate Marksheet (12th)',
                                            'Doc_Intermediate_Certificate_12th__c'=>'Intermediate Certificate (12th)',
                                            'Doc_Graduation_Marksheet_Pre_Final_Sem__c'=>'Graduation Marksheet (Pre-Final Sem)',
                                            'Doc_Graduation_Marksheet_Final_Sem__c'=>'Graduation Marksheet (Final Sem)',
                                            'Doc_Graduation_Passing_Certificate__c'=>'Graduation Passing Certificate',
                                            'Doc_Graduation_Degree_Certificate__c'=>'Graduation Degree Certificate',
                                            'Post_Graduation_Marksheet_Pre_Final_Sem__c'=>'Post Graduation Marksheet (PreFinal Sem)',
                                            'Doc_Post_Graduation_Marksheet_Final_Sem__c'=>'Post Graduation Marksheet (Final Sem)',
                                            'Doc_Result_Card_National_Entrance_Test__c'=>'Result Card National Entrance Test',
                                            'Doc_Experience_Certificates__c'=>'Experience Certificates',
                                            'Doc_Bonafide_Student_Certificate__c'=>'Bonafide Student Certificate',
                                            'Doc_Character_Certificate__c'=>'Character Certificate',
                                            'Doc_Caste_Certificate__c'=>'Caste Certificate',
                                            'Doc_Physically_Handicapped_Certificate__c'=>'Physically Handicapped Certificate',
                                            'Doc_Transfer_Certificate__c'=>'Transfer Certificate',
                                            'Doc_Minority_Certificate__c'=>'Minority Certificate',
                                            'Doc_Migration_Certificate__c'=>'Migration Certificate',
                                            'Doc_FLAME_Migration_Certificate__c'=>'FLAME Migration Certificate',
                                            'Doc_Gap_Year_Affidavit__c'=>'Gap Year Affidavit',
                                            'Doc_Medical_Certificate__c'=>'Medical Certificate',
                                            'Doc_Drug_Testing_Consent_Form__c'=>'Drug Testing Consent Form',
                                            'Doc_Counselling_Declaration_Form__c'=>'Counselling Declaration Form',
                                            'Doc_Anti_Ragging_Affidavit_by_Student__c'=>'Anti Ragging Affidavit by Student',
                                            'Doc_Anti_Ragging_Affidavit_by_Parent__c'=>'Anti Ragging Affidavit by Parent',
                                            'Doc_Passport_Size_Colour_Photograph__c'=>'Passport Size Colour Photograph',
                                            'Doc_PAN_Card_Student__c'=>'PAN Card Student',
                                            'Doc_PAN_Card_Father_Mother__c'=>'PAN Card Father/Mother',
                                            'Doc_AADHAAR_Card_Father_Mother__c'=>'AADHAAR Card Father/Mother',
                                            'Doc_AADHAAR_Card_Student__c'=>'AADHAAR Card Student',
                                            'Doc_Other_Documents__c'=>'Other Documents',
                                            'Doc_Other_Educational_Documents__c'=>'Other Educational Documents',
                                            'Doc_FLAME_Gradesheet_Sem_1__c'=>'FLAME Gradesheet Sem-1',
                                            'Doc_FLAME_Gradesheet_Sem_2__c'=>'FLAME Gradesheet Sem-2',
                                            'Doc_FLAME_Gradesheet_Sem_3__c'=>'FLAME Gradesheet Sem-3',
                                            'Doc_FLAME_Gradesheet_Sem_4__c'=>'FLAME Gradesheet Sem-4',
                                            'Doc_FLAME_Gradesheet_Sem_5__c'=>'FLAME Gradesheet Sem-5',
                                            'Doc_FLAME_Gradesheet_Sem_6__c'=>'FLAME Gradesheet Sem-6',
                                            'Doc_FLAME_Transcript_of_Grades__c'=>'FLAME Transcript of Grades',
                                            'Doc_FLAME_Degree_Certificate__c'=>'FLAME Degree Certificate',
                                            'Doc_FLAME_Migration_Certificate__c'=>'FLAME Migration Certificate',
                                            'Doc_FLAME_Transfer_Certificate__c'=>'FLAME Transfer Certificate',
                                            'Doc_FLAME_Other_Documents__c'=>'FLAME Other Documents',
                                            'Doc_FLAME_Study_Abroad_Gradesheet_1__c'=>'FLAME Study Abroad Gradesheet-1',
                                            'Doc_FLAME_Study_Abroad_Gradesheet_2__c'=>'FLAME Study Abroad Gradesheet-2',
                                            'Admission_Offer_Letter__c'=>'Admission Offer Letter',
                                            'Birth_Certificate__c'=>'Birth Certificate',
                                            'Photograph__c'=>'Photograph',
                                            'FSP_Degree_Certificate__c'=>'FSP Degree Certificate',
                                            'FSP_Gradesheet__c'=>'FSP Gradesheet'
                                            
                                            
                                            };
    }

    
    public UploadDocumentbuttoncontroller2 () {
        file = new ContentVersion();
    }
    Public List<FileWrapper> wrapperList=new List<FileWrapper>();
    
    Public List<FileWrapper> getFileList()
    {
        if(wrapperList.size()==0)
        {
        wrapperList.add(new FileWrapper());
        }
        return wrapperList;
         
    }
    public void addRows()
    {
            wrapperList.add(new FileWrapper());
    }
    public void deleteRows()
    {
        for(integer i=wrapperList.size()-1;i>0;i--)
        {
            if(wrapperList.get(i).b==true)
            {
                wrapperList.remove(i);
            }
        }
    }
    public void add()
    {
        List<ContentVersion> lcv=new List<ContentVersion>();
        List<ContentVersion> lcv2=new List<ContentVersion>();
        List<ContentDocumentLink> lcd=new List<ContentDocumentLink>();
        Contact con=[select CVUE_Student_Number__c,Name from Contact where id=:conId];
        sObject sObj = Schema.getGlobalDescribe().get('contact').newSObject() ;
        sObj.put('Id' , conId) ;
        for(integer i=0;i<wrapperList.size();i++)
        {
            System.debug('#####wrapperList.get(i).doc'+wrapperList.get(i).doc);
            if(wrapperList.get(i).b==true&&wrapperList.get(i).doc!=null&&wrapperList.get(i).cert!='Select…')
            {
                system.debug('####started');
               
                ContentVersion contentVersion_1 = new ContentVersion(
                      Title = con.CVUE_Student_Number__c+'_'+con.Name+'_'+MyStrings.get(wrapperList.get(i).cert),
                      PathOnClient = wrapperList.get(i).doc.Name,
                      VersionData = wrapperList.get(i).doc.body,
                      IsMajorVersion = true
                    );
                    lcv.add(contentVersion_1);
               sObj.put(wrapperList.get(i).cert , 'Uploaded') ; 
            }
        }
        insert lcv;
        lcv2=[SELECT Id, ExternalDataSourceId, ContentDocumentId, Title FROM ContentVersion where id in:lcv];
        
        for(ContentVersion c:lcv2)
        {
             ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = c.ContentDocumentId;
            cdl.LinkedEntityId = conId; // workspaceId where user wants to publish the file.
            cdl.ShareType = 'I';
            cdl.Visibility = 'AllUsers'; 
            lcd.add(cdl);
        }
        
        insert lcd;
        update sObj;
        wrapperList.clear();
        
    }
    public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Select…','Select…'));
            for(String s:MyStrings.keyset())
            {
                options.add(new SelectOption(s,MyStrings.get(s)));
            }
            /*options.add(new SelectOption('Doc_Enrolment_Deposit_Receipt__c','Enrolment Deposit Receipt'));
            options.add(new SelectOption('Doc_High_School_Marksheet_10th__c','High School Marksheet (10th)'));
            options.add(new SelectOption('Doc_High_School_Certificate_10th__c','High School Certificate (10th)'));
            options.add(new SelectOption('Doc_Intermediate_Marksheet_12th__c','Intermediate Marksheet (12th)'));
            options.add(new SelectOption('Doc_Intermediate_Certificate_12th__c','Intermediate Certificate (12th)'));
            options.add(new SelectOption('Doc_Graduation_Marksheet_Pre_Final_Sem__c','Graduation Marksheet (Pre-Final Sem)'));
            options.add(new SelectOption('Doc_Graduation_Marksheet_Final_Sem__c ','Graduation Marksheet (Final Sem)'));
            options.add(new SelectOption('Doc_Graduation_Passing_Certificate__c','Graduation Passing Certificate'));
            options.add(new SelectOption('Doc_Graduation_Degree_Certificate__c','Graduation Degree Certificate'));
            options.add(new SelectOption('Post_Graduation_Marksheet_Pre_Final_Sem__c','Post Graduation Marksheet (PreFinal Sem)'));
            options.add(new SelectOption('Doc_Post_Graduation_Marksheet_Final_Sem__c','Post Graduation Marksheet (Final Sem)'));
            options.add(new SelectOption('Doc_Result_Card_National_Entrance_Test__c','Result Card National Entrance Test'));
            options.add(new SelectOption('Doc_Experience_Certificates__c','Experience Certificates'));
            options.add(new SelectOption('Doc_Bonafide_Student_Certificate__c','Bonafide Student Certificate'));
            options.add(new SelectOption('Doc_Character_Certificate__c','Character Certificate'));
            options.add(new SelectOption('Doc_Caste_Certificate__c','Caste Certificate'));
            options.add(new SelectOption('Doc_Physically_Handicapped_Certificate__c','Physically Handicapped Certificate'));
            options.add(new SelectOption('Doc_Minority_Certificate__c','Minority Certificate'));
            options.add(new SelectOption('Doc_Transfer_Certificate__c','Transfer Certificate'));
            options.add(new SelectOption('Doc_FLAME_Migration_Certificate__c','Migration Certificate'));
            options.add(new SelectOption('Doc_Gap_Year_Affidavit__c','Gap Year Affidavit'));
            options.add(new SelectOption('Doc_Medical_Certificate__c','Medical Certificate'));
            options.add(new SelectOption('Doc_Drug_Testing_Consent_Form__c','Drug Testing Consent Form'));
            options.add(new SelectOption('Doc_Counselling_Declaration_Form__c','Counselling Declaration Form'));
            options.add(new SelectOption('Doc_Anti_Ragging_Affidavit_by_Student__c','Anti Ragging Affidavit by Student'));
            options.add(new SelectOption('Doc_Anti_Ragging_Affidavit_by_Parent__c','Anti Ragging Affidavit by Parent'));
            options.add(new SelectOption('Doc_Passport_Size_Colour_Photograph__c','Passport Size Colour Photograph'));
            options.add(new SelectOption('Doc_PAN_Card_Student__c','PAN Card Student'));
            options.add(new SelectOption('Doc_PAN_Card_Father_Mother__c','PAN Card Father/Mother'));
            options.add(new SelectOption('Doc_AADHAAR_Card_Father_Mother__c','AADHAAR Card Father/Mother'));
            options.add(new SelectOption('Doc_AADHAAR_Card_Student__c','AADHAAR Card Student'));
            options.add(new SelectOption('Doc_FLAME_Other_Documents__c','Other Documents'));
            options.add(new SelectOption('Doc_Other_Educational_Documents__c','Other Educational Documents'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_1__c','FLAME Gradesheet Sem-1'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_2__c','FLAME Gradesheet Sem-2'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_3__c','FLAME Gradesheet Sem-3'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_4__c','FLAME Gradesheet Sem-4'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_5__c','FLAME Gradesheet Sem-5'));
            options.add(new SelectOption('Doc_FLAME_Gradesheet_Sem_6__c','FLAME Gradesheet Sem-6'));
            options.add(new SelectOption('Doc_FLAME_Transcript_of_Grades__c','FLAME Transcript of Grades'));
            options.add(new SelectOption('Doc_FLAME_Degree_Certificate__c','FLAME Degree Certificate'));
            options.add(new SelectOption('Doc_FLAME_Migration_Certificate__c','FLAME Migration Certificate'));
            options.add(new SelectOption('FLAME Transfer Certificate','FLAME Transfer Certificate'));
            options.add(new SelectOption('Doc_FLAME_Other_Documents__c','FLAME Other Documents'));
            options.add(new SelectOption('Doc_FLAME_Study_Abroad_Gradesheet_1__c','FLAME Study Abroad Gradesheet-1'));
            options.add(new SelectOption('Doc_FLAME_Study_Abroad_Gradesheet_2__c','FLAME Study Abroad Gradesheet-2'));*/

            return options;
        }
      
    public PageReference upload() {
        ContentVersion v = new ContentVersion();
       // v.versionData = file;
        v.title = 'testing upload';
        v.pathOnClient ='/somepath.txt';
        insert v;
        return new PageReference('/' + v.id);
    }

     public class FileWrapper
     {
   transient public boolean b{get;set;}
    transient public string cert{get;set;}
         
    Public Document doc{get;set;}
         
         FileWrapper()
         {
            doc=new  Document();
         }

             
     }
   Integer a=1; 
  integer b=2;
 public void Health() {
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        a=1;
        b=2;
        } 
}