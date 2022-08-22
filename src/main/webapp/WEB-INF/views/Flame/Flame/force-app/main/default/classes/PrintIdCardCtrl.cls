/*
 *Controller for PrintIdCardVF Page
 */
public class PrintIdCardCtrl {
    public List<Contact> selConLst;
    public String recordIds{get; set;}
    public String tagLine{get;set;}
    public List<String> selectIDs = new List<String>{};
    public List<Contact> contactList{get; set;}
    public List<String> contactProgramCode{get;set;}
    public List<String> contactValidity{get;set;}
    public List<Account__mdt> queryRecords;
    String publicURL;
    
    public PrintIdCardCtrl(ApexPages.StandardSetController cntlr){
        
        selConLst = cntlr.getSelected(); 
        system.debug('selConLst'+selConLst);
        recordIds = '';  
        for(Contact con : selConLst){
            recordIds += con.Id + ',';
            selectIDs.add(con.Id);
        }
        system.debug('selectIDs Size'+ selectIDs.size());
        system.debug('recordId::'+recordIds);
        recordIds = recordIds.removeEnd(','); 
        
        contactList = [SELECT Id, Name,Blood_Group__c,Date_of_Birth__c,Student_Batch__c,CVUE_Student_Number__c,Account.Name,AccountId,Contact_Photo__c FROM CONTACT where Id IN :selectIDs];
        List<ContentDocument> contentDocumentList = new List<ContentDocument>();
        List<ContentVersion> contentVersionList = new List<ContentVersion>();

        system.debug('Contact Size'+ contactList.size());
        
        List<String> programCodes = new List<String>{};
        List<String> validityCodes = new List<String>{};
        
		List<Contact> allContacts = [SELECT Id, Name,Blood_Group__c,Date_of_Birth__c,Student_Batch__c,CVUE_Student_Number__c,Account.Name,AccountId,Contact_Photo__c FROM CONTACT where Id IN :selectIDs]; 
        
        if(allContacts.size()>0){
            For(Contact contRec :allContacts){
              List<Account__mdt> queryRecords = [Select ID,Account_Name__c,Program_Code__c,Validity_Name__c,Tagline__c from Account__mdt where Account_Name__c =:contRec.AccountId];
                if(queryRecords.size()>0){
                    programCodes.add(queryRecords[0].Program_Code__c);
           	   		validityCodes.add(queryRecords[0].Validity_Name__c);
                    tagLine = queryRecords[0].Tagline__c;
                }else{
                    programCodes.add('N/A');
                    validityCodes.add('N/A');
                    tagLine = 'Igniting Minds.';
                }
              
        	}
        }
        
        contactProgramCode = programCodes;
        contactValidity = validityCodes;
        system.debug('contactProgramCode'+contactProgramCode);
        system.debug('contactValidity'+contactValidity);
    } 

}