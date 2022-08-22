/*
 *Controller for UploadIdCardVF Page
 */
public class printIdCardComponentCtrl {
    public List<Contact> selConLst;
    public String recordIds{get; set;}
    public printIdCardComponentCtrl(ApexPages.StandardSetController cntlr){
        selConLst = cntlr.getSelected(); //get selected records from contact list view
        system.debug('selConLst'+selConLst);
        recordIds = '';  
        for(Contact con : selConLst){
            recordIds += con.Id + ','; //build list of ids string concatenated with comma                         
        }
        
        system.debug('recordId::'+recordIds);
        recordIds = recordIds.removeEnd(','); 
        system.debug('recordIds:'+recordIds);
    } 
    
}