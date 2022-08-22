/*
 *Controller for UploadIdCardVF Page
 */
public class UploadIdCardCtrl {
    public List<Contact> selConLst;
    public String recordIds{get; set;}
    public UploadIdCardCtrl(ApexPages.StandardSetController cntlr){
        selConLst = cntlr.getSelected(); //get selected records from contact list view
        recordIds = '';  
        for(Contact con : selConLst){
            recordIds += con.Id + ','; //build list of ids string concatenated with comma                         
        }
        recordIds = recordIds.removeEnd(','); 
        system.debug('recordIds:'+recordIds);
    } 
    
}