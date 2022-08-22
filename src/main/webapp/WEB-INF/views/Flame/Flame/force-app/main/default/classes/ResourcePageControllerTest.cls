@isTest
public class ResourcePageControllerTest {
    static testMethod void resourceTest(){
        
        String roleStr = '';
        User objUser;
        Id pId;
        Id cId;
        String rdi ='';
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs ( thisUser ){    
            Contact con = new Contact();
            con.LastName = 'portLast';
            insert con;
            cId = con.Id;
            
            UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
            Profile studPro = [select id from profile where name = 'Student'];
            User portUser = new User();
            portUser.ProfileId = studPro.Id;
            portUser.Username = 'test4@test.com';
            portUser.Alias = 'test';
            portUser.Email = 't@test.com';
            portUser.FirstName = 'fname';
            portUser.LastName = 'lname';
            portUser.EmailEncodingKey = 'UTF-8';
            portUser.LocaleSidKey = 'en_US';
            portUser.LanguageLocaleKey = 'en_US';
            portUser.TimeZoneSidKey = 'America/Los_Angeles';
            portUser.ContactId = cId;
            portUser.CommunityNickname = 'tuser';
            insert portUser;
            pId = portUser.Id;   
        }
        
        
         Folder folder = [Select id from folder where name='Flame Static Content'];
        List<Document>document_Obj = new List<Document>();  
        Document d = new Document();
        d.Name ='sampletext';
        d.FolderId = folder.Id;
        d.Body = Blob.valueOf('UNIT.TEST');
        document_Obj.add(d);
        
        List<Resource__c> resource_Obj = new  List<Resource__c>(); 
        Resource__c resource= new Resource__c();
        resource.Name ='Marketing';
        resource.Document_Id__c = d.id;
        resource.Document_Name__c= 'text';
        resource.Text_Resources__c = true;
        resource.Category__c = 'Academic Resources';
        resource.Sub_Category__c = 'Forms';
        resource.Role__c = 'Student';
        resource.URL__c = 'www.google.com';
        resource.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Resources').getRecordTypeId();
        resource_Obj.add(resource);
        
       
        
        
        List<Resource__c> resList = new List<Resource__c>();
        Resource__c res1 = new Resource__c();
        res1.Category__c = 'Academic Resources';
        res1.Sub_Category__c = 'Forms';
        res1.Role__c = 'Student';
        res1.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Resources').getRecordTypeId();
        resList.add(res1);
        
        Resource__c res2 = new Resource__c();
        res2.Category__c = 'Academic Resources';
        res2.Sub_Category__c = 'Forms';
        res2.Role__c = 'Student';
        res2.URL__c = 'www.google.com';
        res2.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Resources').getRecordTypeId();
        resList.add(res2);
        
        Resource__c res3 = new Resource__c();
        res3.Category__c = 'Academic Resources';
        res3.Sub_Category__c = 'Forms';
        res3.URL__c = 'www.salesforce.com';
        res3.RecordTypeId = Schema.sObjectType.Resource__c.getRecordTypeInfosByName().get('Resources').getRecordTypeId();
        resList.add(res3);
        
        objUser = [SELECT ID, Profile.Name, profileId FROM User WHERE Id =: pId LIMIT 1];
        roleStr = objUser.Profile.Name;
        system.debug('roleStr-->'+roleStr);

        Apexpages.currentPage().getParameters().put('input1', 'Forms');
        Apexpages.currentPage().getParameters().put('input2', 'Academic Resources');
       
       
       ResourcePageController rpc1 = new ResourcePageController();
       apexPages.Currentpage().getParameters().put('rId',resource.id);
       String id = ApexPages.currentPage().getParameters().get('id');
      // System.assert('true',id==null);
       
       
        Test.startTest();
        insert resList;
        ResourcePageController rpc = new ResourcePageController();
        rpc.roleString = roleStr;
        //rpc.getHtmlText();
        rpc.rid = 'test data';
       // rpc.ResourceLink();
       
        
        PageReference pageref = rpc.ResourceCategory();
        PageReference pageref1 = rpc.proceedtoback();
       // PageReference pageref3 = rpc.ResourceLink();
        rpc.documentList = document_Obj;
        PageReference pageRef2 = Page.communityportalpage;
        pageRef2.getParameters().put('rId','test');
        pageRef2.getParameters().put('input2','test');
        pageRef2.getParameters().put('input1','test');
        pageRef2.getParameters().put('recordId','test');
        test.setCurrentPageReference(pageRef2);
       
        Test.stopTest();
        list<resource__c> check = rpc.resourceList;
        system.assertEquals(res2.Category__c, check[1].Category__c);  
        
       
    }
}