public class QueueUploadIdCardCtrl implements Queueable {
    Private String conId;
    Private String cvId;
    public QueueUploadIdCardCtrl(String conId, String cvId){
        this.conId = conId;
        this.cvId = cvId;
    }
    public void execute(QueueableContext context) {
        Id cdId;
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where id =: this.cvId];
        for(ContentVersion cv : cvList){
            cdId = cv.ContentDocumentId;
            String newName = cv.Title;
            System.debug('newName'+cv.Title);
            Integer intIndex = newName.indexOf('.');
            Integer lasCharLen = newName.length()-intIndex;
            //System.debug('New length'+newName.substring(0,newName.length()-lasCharLen));
            cv.Title = newName.substring(0,newName.length()-lasCharLen);
            Update cv;
        }
        
        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = cdId;
        cDe.LinkedEntityId = conId; 
        cDe.ShareType = 'V'; 
        cDe.Visibility = 'AllUsers';
        insert cDe;
        
        Datetime systemDate = System.now();
        String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        List<ContentDocumentLink> contentDocumentList = [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: conId order by ContentDocument.CreatedDate desc limit 1 offset 1];
        system.debug('contentDocumentList size:'+contentDocumentList.size());
		if(contentDocumentList.size()>0){
            For(ContentDocumentLink contd :contentDocumentList){
                ContentVersion contentVersionList1 = [SELECT ContentDocumentId,Title FROM ContentVersion WHERE ContentDocumentId =: contd.ContentDocumentId limit 1];
                system.debug('contentVersionList1:'+contentVersionList1);
                String newName = contentVersionList1.Title;
               	contentVersionList1.Title = newName+'_Old_'+newTimeDate;
                System.debug('Old File Name::'+newName+'_Old_'+newTimeDate);
                Update contentVersionList1;
                system.debug('Update contentVersionList1:'+contentVersionList1);
            }
        }
        
    }
}