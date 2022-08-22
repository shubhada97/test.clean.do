/*
@author: Sharath
@description: In this Contoller Class fetching the Current Login User detail,
Based on Current User Login Id get Contact RecordType Name.
RecordTypeName = FU-Student>> Showing the Course Connection under that Contact
RecordTypeName = FU-Employee>> Showing the Course FeedBack Record under that Contact
@Date : 11 Feb 2019
*/

public class ShowStudentLetterGradeController  {

    //Declare the variable
    public string strContId{get;set;}
    
    public List<hed__Course_Enrollment__c> lstofCC {get;set;}
   
    public List<hed__Course_Offering__c> lstofCourseOffering {get;set;}
    
   // public id strCCid {get;set;}
    public User objUser {get;set;}
    public Contact objContact {get;set;}
    
    public set<ID> setofCCId;
   
    public hed__Course_Offering__c objCF{get;set;}
    public set<id> setofCourseConnectionId;
     

    //Define the Constructor
    public ShowStudentLetterGradeController()
    {
        objCF = new hed__Course_Offering__c();
        objContact = new Contact();
        
        setofCCId = new set<Id>();
        
        objUser = new User();
        lstofCC  = new List<hed__Course_Enrollment__c>();
      
        lstofCourseOffering = new List<hed__Course_Offering__c>();
       
        setofCourseConnectionId = new Set<id>();
        
        //Get Custom Label Student ID. If Custom label contains Student ID(Contact ID)
        // then when page load it will consider otherwise it will get current user(Student Record Id) . Student(Contact Id) will start with 003
        string strStugradId = System.Label.StudentLetterGradeId;
        if(strStugradId.startswith('003'))
        {
            strContId  = strStugradId;  
            System.debug('IfConditon!!!!strStugradId@@@'+strContId);
        }
        else
        {
      
            // get Current Login User detail
            objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
             system.debug('objUser@@@'+objUser.ContactID);    
            if(objUser.ContactID != null){
                objContact = [SELECT Id,Name,RecordTypeId,RecordType.Name FROM Contact WHERE Id=:objUser.ContactId];
                strContId = objContact.Id;
                System.debug('ElseConditon!!!!strStugradId@@@'+strContId);
            }
        }
        
    }
    public void Search()
    {
         System.debug('@@@strContId@@@@');
           
          //&& objContact.RecordType.Name == 'FU-Student'
        if(strContId != null )
        {
            String academicYear = objCF.Academic_Year__c;
            //academicYear=academicYear.replaceAll('-', '/');
            String termCode = objCF.Term__c;
            System.debug('@@academicYear'+academicYear);
            System.debug('@@termCode'+termCode);
            String query = ' SELECT Id,Letter_Grade__c,Mid_Term_Enable__c,MidTerm_Due_Date_Passed__c,End_Term_Enable__c,End_Term_Due_Date_Passed__c,Name,Due_Date__c,Term_Code__c,hed__Contact__c,hed__Contact__r.Name,hed__Status__c,hed__Account__r.Name,hed__Course_Offering__c,hed__Course_Offering__r.Name,hed__Course_Offering__r.Secondary_Faculty__r.Name,hed__Course_Offering__r.Third_Faculty__r.Name,hed__Course_Offering__r.hed__Faculty__r.Name,hed__Course_Offering__r.Academic_Year__c,hed__Course_Offering__r.hed__Faculty__c,hed__Course_Offering__r.Secondary_Faculty__c,hed__Course_Offering__r.Third_Faculty__c,hed__Course_Offering__r.Fourth_Faculty__c,hed__Course_Offering__r.Fourth_Faculty__r.Name,hed__Course_Offering__r.Term__c,hed__Course_Offering__r.hed__Term__c,hed__Course_Offering__r.hed__Term__r.Name  FROM hed__Course_Enrollment__c WHERE';
                query += ' hed__Contact__c =: strContId';

                System.debug('@@query'+query);
                
                if(objCF.Academic_Year__c!= null &&  objCF.Academic_Year__c!= '' && objCF.Term__c== null){
                    query += ' AND';
                    query += ' hed__Course_Offering__r.Academic_Year__c =: academicYear Order By CreatedDate DESC';
                }
                if(objCF.Term__c!=null &&  objCF.Term__c!= '' && objCF.Academic_Year__c == null){
                    query += ' AND'; 
                    query += ' hed__Course_Offering__r.Term__c =: termCode Order By CreatedDate DESC'; 
                } 
        
                if(objCF.Term__c!= '' && objCF.Term__c!= null && objCF.Academic_Year__c != '' && objCF.Academic_Year__c != null){
                    query += ' AND'; 
                    query += ' hed__Course_Offering__r.Academic_Year__c =: academicYear';
                    query += ' AND'; 
                    query += ' hed__Course_Offering__r.Term__c =: termCode Order By CreatedDate DESC'; 
                }

                 lstofCC = Database.query(query);
      
        }
         
        
       
    }
}