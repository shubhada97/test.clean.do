trigger updateIdCardChangeNameTrigger on ContentDocumentLink (before insert,after insert) {
	
    /*if(Trigger.isInsert) {
        if(Trigger.isAfter){
            //updateIdCardImageNameHander.updateName(Trigger.New);
            List<ContentDocumentLink> newList = Trigger.New;
            system.debug('newList'+newList[0].LinkedEntityId);
            List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId, FileType FROM ContentVersion where ContentDocumentId =: newList[0].ContentDocumentId];
            system.debug('cvList Size'+cvList.size());
            String findString = '_comp';
            For(ContentVersion cv: cvList){
                if(cv.Title.contains(findString)){
                   String newName = cv.Title;
                   System.debug('newName'+cv.Title);
                   Integer intIndex = newName.indexOf('.');
                    if(intIndex>0){
                       Integer lasCharLen = newName.length()-intIndex;
                   	   cv.Title = newName.substring(0,newName.length()-lasCharLen);
                       update cv;
                    }
                }
            }
            
            Datetime systemDate = System.now();
            String newTimeDate = systemDate.format('dd-MM-yyyy-hh-mm-ss');
        	List<ContentDocumentLink> contentDocumentList = [SELECT Id,ContentDocumentId,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: newList[0].LinkedEntityId order by ContentDocument.CreatedDate desc limit 1 offset 1];
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
    } */

}