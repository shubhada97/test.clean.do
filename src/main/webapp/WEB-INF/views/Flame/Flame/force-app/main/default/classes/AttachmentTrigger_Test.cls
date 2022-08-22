@isTest
public class AttachmentTrigger_Test {	
    testMethod static void AttachmentTrigger(){        
		Resource__c res1 = new Resource__c();
        res1.Category__c = 'Academic Resources';
        res1.Sub_Category__c = 'Forms';
        res1.Role__c = 'Student';
        res1.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Resources').getRecordTypeId();
		insert res1;
		
		List<Resource__c> resList = [select id,name from Resource__c where id =: res1.id];
		System.assertEquals(1,resList.size());
		
		Attachment attach=new Attachment();     
		attach.Name='Unit Test Attachment';
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		attach.body=bodyBlob;
		attach.ParentId = resList[0].id;
		insert attach;
    }
}