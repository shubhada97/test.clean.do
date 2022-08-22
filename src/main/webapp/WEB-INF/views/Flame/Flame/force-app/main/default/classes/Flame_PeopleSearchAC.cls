/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_PeopleSearchAC
* Created Date: 9/9/2018
* Description: to search people from contact object
*******************************************************************/
public   class Flame_PeopleSearchAC {        
  //Public String Primarycontacttype {get;set;}  
    //-- remote action method for people search auto complete
    @RemoteAction
    public static List<ContactWrapper> autocompletePeopleSearch(String searchString ) { 
         
            
        String nameParam = searchString + '%';
                
        List<ContactWrapper> contactWrapperList = new List<ContactWrapper>();
        List<Contact> tempContactList = new List<Contact>();        
        Set<Id> recordTypeIdSet = new Set<Id>();
        List<Community_Assist__c> communityAssistList = [Select id,Name,Record_Type__c,Tab_Type__c from Community_Assist__c Where Tab_Type__c='People Search'  limit 1];
        if(communityAssistList.size()>0){
            String contactRecordType = communityAssistList[0].Record_Type__c;              
            List<String> recordTypeName = new  List<String>();
            if(contactRecordType!=null){
                recordTypeName = contactRecordType.split(';');                  
            }
            List<RecordType> recordTypeList = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType='Contact' AND Name IN : recordTypeName];
            System.debug('PS RecordTypeList : '+recordTypeList);
            
            for(RecordType rType : recordTypeList){
                recordTypeIdSet.add(rType.Id);
            }
            System.debug('PS RecordType ID : '+recordTypeIdSet);
            System.debug('nameParam : '+nameParam);            
        }
          
        try {
        
         /*  tempContactList = [Select Id,name, firstName,LastName,Email,Phone, Designation_Name__c, Department__c, Faculty__c, Office_Building__r.Name, Office_Room__c ,Primary_Contact_Type__c ,AccountId,Program_Interested_In__c From Contact Where (Name like :nameParam OR FirstName like :nameParam OR LastName LIKE:nameParam OR Department__c LIKE :nameParam OR Designation_Name__c LIKE :nameParam OR Program_Interested_In__c LIKE:nameparam ) AND (Primary_Contact_Type__c= 'Faculty' OR Primary_Contact_Type__c='staff' OR Primary_Contact_Type__c='student') AND RecordTypeId IN : recordTypeIdSet Order By Name ];
            System.debug('tempContactList '+tempContactList); */
           
           string searchquery = 'SELECT Id,name, firstName,LastName,Email,Phone, Designation_Name__c, Department__c, Faculty__c, Office_Building__r.Name, Office_Room__c ,Primary_Contact_Type__c,Student_Batch__c,Program_Interested_In__c From Contact WHERE (Name like :nameParam OR LastName LIKE \'%'+nameParam+'%\' OR  firstName LIKE \'%'+nameParam+'%\' OR Department__c LIKE \'%'+nameParam+'%\' OR Designation_Name__c LIKE \'%'+nameParam+'%\' OR Program_Interested_In__c LIKE \'%'+nameParam+'%\' OR Student_Batch__c LIKE \'%'+nameParam+'%\' )  AND RecordTypeId IN : recordTypeIdSet Order By Name  LIMIT 50';
            tempContactList = Database.query(searchquery);
             System.debug('tempContactList '+tempContactList);
          
            if(tempContactList.size()>0){
                for(Contact tempCon : tempContactList){
                    ContactWrapper cw = new ContactWrapper(tempCon.Id,tempCon.Name,tempCon.firstName,tempCon.LastName,tempCon.Faculty__c,tempCon.Designation_Name__c,tempCon.Department__c,tempCon.Office_Building__r.Name,tempCon.Office_Room__c,tempCon.Email,tempCon.Phone,tempCon.Primary_Contact_Type__c, tempCon.Program_Interested_In__c,tempCon.Student_Batch__c);
                    contactWrapperList.add(cw);
                }   
            }
            
        }
        catch (Exception e) {
            return null;
        }
        System.debug('contactList : '+contactWrapperList);    
        return contactWrapperList;
    }
    
    public class ContactWrapper{
        public string conid {get;set;}
        public string name {get;set;}
        public string firstname {get;set;}
        Public String LastName {get;set;}
        public string faculty {get;set;}
        public string designation {get;set;}
        public string department {get;set;}
        public string building {get;set;}
        public string room {get;set;}
        Public String Email {get;set;}
        Public String Phone {get;set;}
        Public String Program {get;set;}
        Public String batch {get;set;}
       
        
        public ContactWrapper(string conid, string name,string firstname,string Lastname, string faculty, string designation, string department, string building, string room ,String Email,String Phone,String Primarycontacttype,String Program,string batch){
            this.conid = conid;
            this.name = name;
            this.firstname = firstname;
            this.faculty = faculty;
            this.designation = designation;
            this.department = department;
            this.building = building;
            this.room = room;
            this.email = Email;
            this.Phone = Phone;
            this.Program=Program;
            this.batch=batch;
           
        }
    }
}