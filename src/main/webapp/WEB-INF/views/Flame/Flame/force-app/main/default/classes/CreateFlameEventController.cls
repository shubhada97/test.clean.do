public class CreateFlameEventController {
    
    public Flame_Event__c objFE {get;set;}
    public string strconId;
    public list<Contact> lstofCon{get;set;}
    public Id meetingRecordTypeId;
    public List<Attachment> allFileList {get; set;}
    public List<SelectOption> options { get; set; }
    public string selectedRole{get;set;}
    public string parentId{get;set;}
    public String startDate{get;set;}
  
    
    public CreateFlameEventController(){
        
        options = new List<SelectOption>();
        options.add(new SelectOption('None', 'None'));
        allFileList = new List<Attachment>() ;
        objFE = new Flame_Event__c();
        lstofCon= new list<contact>();
        meetingRecordTypeId = Schema.SObjectType.Flame_Event__c.getRecordTypeInfosByName().get('Meeting minutes').getRecordTypeId();
        strconId  = ApexPages.currentPage().getParameters().get('conid'); //Contact Id
        if(strconId !=null){
            lstofCon = [Select id,Name, Department__c,Institutional_Role__c  from Contact Where ID =:strconId limit 1];
            
            
            for(hed__Affiliation__c obj:[Select hed__Account__c,hed__Status__c,hed__Affiliation_Type__c,hed__Account__r.Name,hed__Contact__c from hed__Affiliation__c where hed__Contact__c =:strconId and hed__Status__c != 'Former']){
                if(obj.hed__Status__c!= 'Former' && obj.hed__Affiliation_Type__c == 'University Committee' || obj.hed__Affiliation_Type__c == 'University Body' || obj.hed__Affiliation_Type__c == 'University Center'){
                    options.add(new SelectOption(obj.hed__Account__r.Name, obj.hed__Account__r.Name));
                }
            }
        }
        
    }
    
    public transient String base64;
    
    public String getBase64()
    {
        return base64;
    }
    public void setbase64(String base64)
    {
        this.base64 = base64;
    }
    
    public String fileName {get; set;}
    public String fileCount {get; set;}
    
    
    public PageReference SaveData()
    {
        
        DateTime testDate;
        if(!string.isBlank(startDate)){
            testDate = DateTime.parse(startDate);
        }
        
        string strBaseUrl = System.Label.FILE_BASE_URL+'/apex/MyMeetingMinutes';
        objFE.Contact__c = strconId;
        objFE.RecordTypeID = meetingRecordTypeId;
        if(testDate!=null){
            objFE.StartDateTime__c =  testDate;//System.today();
        }
        System.debug('selectedRole@@@'+selectedRole);
        if(selectedRole !='' && selectedRole !='None'){
            objFE.Contact_Department__c = selectedRole;
        }
        else{
            objFE.Contact_Department__c = lstofCon[0].Department__c;
        }
          try{
      upsert objFE;
        parentId = objFE.Id;
        System.debug('parentId-->'+parentId);
 
      }catch(Exception e) {
        System.debug('An exception occurred: ' + e.getMessage());
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'you can not leave this field blank.'));
      }
        
        return null;
        
        
    }
    public void saveFile(){
        
        List<Flame_Event__c> flameEventList = new List<Flame_Event__c>();
        flameEventList =[select id,Contact_Department__c,Heading__c,StartDateTime__c from Flame_Event__c where id =: parentId];
        System.debug('flameEventList--'+flameEventList);
        
        if(fileName != ''  && fileName != ''){
            TimeZone tz=UserInfo.getTimeZone();
            integer extensionIndex = fileName.lastIndexOf('.');
            System.debug('extensionIndex--'+extensionIndex);
            string extensionString = fileName.substring(extensionIndex + 1, fileName.length()); 
            System.debug('extensionString--'+extensionString);
            string attachmentName= 'MeetingMinutes_'+lstofCon[0].name+'_'+flameEventList[0].Contact_Department__c+'_'+flameEventList[0].Heading__c +'_'+flameEventList[0].StartDateTime__c.format('dd/MM/yyyy','GMT+05:30')+ '_'+flameEventList[0].StartDateTime__c.format('h:mm a',tz.getId())+'-'+fileCount+'.'+extensionString;
            System.debug('attachmentName--'+attachmentName);
            
            List<Attachment> listToInsert = new List<Attachment>() ;
            
            listToInsert.add(new Attachment(parentId = parentId, Body =  EncodingUtil.base64Decode(base64), name = attachmentName,IsPrivate = false)); //
            
            System.debug('listToInsert--'+listToInsert);
            
            if(listToInsert.size() > 0)
            {
                insert listToInsert ;
            }
            
            
        }
    }
   
    
}