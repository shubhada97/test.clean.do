/*
@author: Sharath
@description: In this Contoller Class fetching the Current Login User detail,
Based on Current User Login Id get Contact RecordType Name.
RecordTypeName = FU-Student>> Showing the Course Connection under that Contact
RecordTypeName = FU-Employee>> Showing the Course FeedBack Record under that Contact
@Date : 11 Feb 2019
*/

public class ShowCourseConnectionController {

    //Declare the variable
    public string strContId{get;set;}
    public List<hed__Course_Enrollment__c> lstofCC {get;set;}
    //public List<hed__Course_Enrollment__c> lstofCC1 {get;set;}
    public List<Course_feedback__c> lstofCFB {get;set;}
     public List<hed__Course_Offering__c> lstofCourseOffering {get;set;}
    
     public List<Course_feedback__c> lstofCFBuniqueCC {get;set;}
   // public id strCCid {get;set;}
    public User objUser {get;set;}
    public Contact objContact {get;set;}
    //public Boolean isFeedBack{get;set;}
    public set<string> setofCourseConIDandConIdandPFId;
    public set<string> setofCourseConIDandConIdandSFId;
    public set<string> setofCourseConIDandConIdandTFId;
    public set<string> setofCourseConIDandConIdandFFId;
   // public set<id> setofFacultyId;
    public set<ID> setofCCId;
    public Map<string,Boolean> mapofCourseConIDandConIdandPFIdToIsFeedBack{get;set;}
    public Map<id,Boolean>     mapofCourseConFacultyIDtoShowMessage{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandPFIdMidTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandPFIdEndTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandSFIdToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandTFIdToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandTFIdMidTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandTFIdEndTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandFFIdToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandFFIdMidTermToIsFeedBack{get;set;}
    public Map<string,Boolean> mapofCourseConIDandConIdandFFIdEndTermToIsFeedBack{get;set;}
    //public Ledger__c objLedger {get;set;}
   // public date strtodayDate{get;set;}
    public hed__Course_Offering__c objCF{get;set;}
    public set<id> setofCourseConnectionId;
     

    //Define the Constructor
    public ShowCourseConnectionController()
    {
        objCF = new hed__Course_Offering__c();
        objContact = new Contact();
        //strtodayDate = Date.valueof(System.today());
        //objLedger = new  Ledger__c();
        setofCourseConIDandConIdandPFId = new set<string>();
        setofCourseConIDandConIdandSFId = new set<string>();
        setofCourseConIDandConIdandTFId = new set<string>();
        setofCourseConIDandConIdandFFId = new set<string>();
       // setofFacultyId = new set<Id>();
        setofCCId = new set<Id>();
        mapofCourseConIDandConIdandPFIdToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConFacultyIDtoShowMessage  = new Map<id,Boolean>();
        mapofCourseConIDandConIdandSFIdToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandTFIdToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandFFIdToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandPFIdMidTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandPFIdEndTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandTFIdMidTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandTFIdEndTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandFFIdMidTermToIsFeedBack = new Map<string,Boolean>();
        mapofCourseConIDandConIdandFFIdEndTermToIsFeedBack = new Map<string,Boolean>();
        objUser = new User();
        lstofCC  = new List<hed__Course_Enrollment__c>();
        //lstofCC1  = new List<hed__Course_Enrollment__c>();
        lstofCFB = new List<Course_feedback__c>();
        lstofCourseOffering = new List<hed__Course_Offering__c>();
        lstofCFBuniqueCC = new List<Course_feedback__c>();
        setofCourseConnectionId = new Set<id>();
      
        // get Current Login User detail
        objUser = [SELECT ID,ContactID,Contact.Name FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
         system.debug('objUser@@@'+objUser.ContactID);    
        if(objUser.ContactID != null){
            objContact = [SELECT Id,Name,RecordTypeId,RecordType.Name FROM Contact WHERE Id=:objUser.ContactId];
            strContId = objContact.Id;
        }
        //system.debug('strContId@@@'+strContId);
        //system.debug('objContact.RecordType.Name@@@'+objContact.RecordType.Name);
       
        System.debug('strContId@@@@'+strContId);
    }
    public void Search()
    {
    
            
            
            
        if(strContId != null)
        {
            String academicYear = objCF.Academic_Year__c;
            //academicYear=academicYear.replaceAll('-', '/');
            String termCode = objCF.Term__c;
            System.debug('@@academicYear'+academicYear);
            System.debug('@@termCode'+termCode);
            String query = ' SELECT Id,Mid_Term_Enable__c,MidTerm_Due_Date_Passed__c,End_Term_Enable__c,End_Term_Due_Date_Passed__c,Name,Due_Date__c,Term_Code__c,hed__Contact__c,hed__Contact__r.Name,hed__Status__c,hed__Account__r.Name,hed__Course_Offering__c,hed__Course_Offering__r.Name,hed__Course_Offering__r.Secondary_Faculty__r.Name,hed__Course_Offering__r.Third_Faculty__r.Name,hed__Course_Offering__r.hed__Faculty__r.Name,hed__Course_Offering__r.Academic_Year__c,hed__Course_Offering__r.hed__Faculty__c,hed__Course_Offering__r.Secondary_Faculty__c,hed__Course_Offering__r.Third_Faculty__c,hed__Course_Offering__r.Fourth_Faculty__c,hed__Course_Offering__r.Fourth_Faculty__r.Name,hed__Course_Offering__r.Term__c,hed__Course_Offering__r.hed__Term__c,hed__Course_Offering__r.hed__Term__r.Name  FROM hed__Course_Enrollment__c WHERE';
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

                
                
            if(objContact.RecordType.Name == 'FU-Student') {
                for(Course_feedback__c objCF: [Select id,Name,End_Type__c,Course_Offering__c,Course__c,Primary_Faculty__c,Secondary_Faculty__c,Third_Faculty__c,Fourth_Faculty__c,Primary_Faculty__r.Name ,Secondary_Faculty__r.Name,Third_Faculty__r.Name,Fourth_Faculty__r.Name,Contact__c,Contact__r.Name,Course_Connection__c,Course_Connection__r.Name,Q1A__c,Q2A__c,Q3A__c,Q4A__c,Q5A__c,Q6A__c,Q7A__c,Q8A__c,Q9A__c,Q10A__c,Q11A__c,Q12A__c,Q31A__c,Q32A__c 
                                                    from Course_feedback__c
                                                    where Contact__c =: strContId]) {  
                                                    
                    if(objCF.Primary_Faculty__c != null) {
                       setofCourseConIDandConIdandPFId.add(objCF.Course_Connection__c+'_'+objCF.End_Type__c+'_'+objCF.Contact__c+'_'+objCF.Primary_Faculty__c); 
                       
                    }

                    if(objCF.Secondary_Faculty__c != null) {
                        setofCourseConIDandConIdandSFId.add(objCF.Course_Connection__c+'_'+objCF.End_Type__c+'_'+objCF.Contact__c+'_'+objCF.Secondary_Faculty__c);
                       
                    }
                    System.debug('setofCourseConIDandConIdandSFId@@@'+setofCourseConIDandConIdandSFId);
                   
                    if(objCF.Third_Faculty__c != null) {
                        setofCourseConIDandConIdandTFId.add(objCF.Course_Connection__c+'_'+objCF.End_Type__c+'_'+objCF.Contact__c+'_'+objCF.Third_Faculty__c); 
                      
                    }
                    if(objCF.Fourth_Faculty__c != null) {
                        setofCourseConIDandConIdandFFId.add(objCF.Course_Connection__c+'_'+objCF.End_Type__c+'_'+objCF.Contact__c+'_'+objCF.Fourth_Faculty__c); 
                       
                    }
                }
                System.debug('setofCourseConIDandConIdandPFId@@@@'+setofCourseConIDandConIdandPFId);
                lstofCC = Database.query(query); 
                System.debug('@@lstofCC'+lstofCC);

                if(lstofCC != null && lstofCC.size()>0) {
                    for(hed__Course_Enrollment__c objCC : lstofCC) {
                        
                   
  
                        // To Check for Primary Faculty feedback link disable/Enable
                          
                         if(objCC.hed__Course_Offering__r.hed__Faculty__c !=null) {
                            
                            
                            mapofCourseConIDandConIdandPFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c,false);
                            
                            mapofCourseConIDandConIdandPFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c,false);
                        }
                        else{
                            mapofCourseConIDandConIdandPFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                            mapofCourseConIDandConIdandPFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                            
                          
                        }
                        
                        if(objCC.hed__Course_Offering__r.hed__Faculty__c !=null && !setofCourseConIDandConIdandPFId.contains(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c)) {
                                
                            
                            
                            mapofCourseConIDandConIdandPFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c,true);
                        } 
                        
                        if(objCC.hed__Course_Offering__r.hed__Faculty__c !=null && !setofCourseConIDandConIdandPFId.contains(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c)) {
                                
                         
                          
                           mapofCourseConIDandConIdandPFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.hed__Faculty__c,true);
                            
                        }
                        
                         // To Check for Secondary Faculty feedback link  disable/Enable
                          System.debug('bjCC.hed__Course_Offering__r.Secondary_Faculty__c@@@@'+objCC.hed__Course_Offering__r.Secondary_Faculty__c);
                        if(objCC.hed__Course_Offering__r.Secondary_Faculty__c !=null){
                            
                            mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c,false);
                            
                            mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c,false);
                            
                            System.debug('mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack@@@@'+mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack);
                            System.debug('mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack@@@@'+mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack);
                        }
                        else{
                            mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                            mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                           
                            System.debug('mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack@@@@'+mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack);
                            
                            System.debug('mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack@@@@'+mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack);
                        }
                       
                         
                        if(objCC.hed__Course_Offering__r.Secondary_Faculty__c !=null && !setofCourseConIDandConIdandSFId.contains(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c)) {
                                
                          
                            
                            mapofCourseConIDandConIdandSFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c,true);
                        } 
                        
                        if(objCC.hed__Course_Offering__r.Secondary_Faculty__c !=null && !setofCourseConIDandConIdandSFId.contains(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c)) {
                                
                         
                          
                           mapofCourseConIDandConIdandSFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Secondary_Faculty__c,true);
                            
                        }



                        // To Check for Third Faculty feedback link disable/Enable
                        if(objCC.hed__Course_Offering__r.Third_Faculty__c !=null) {
                            
                        
                            mapofCourseConIDandConIdandTFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c,false);
                            
                            mapofCourseConIDandConIdandTFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c,false);
                        }
                        else {
                            mapofCourseConIDandConIdandTFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                            mapofCourseConIDandConIdandTFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                           
                        }
                        
                        
                        if(objCC.hed__Course_Offering__r.Third_Faculty__c !=null && !setofCourseConIDandConIdandTFId.contains(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c)) {
                                
                           
                           
                           mapofCourseConIDandConIdandTFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c,true);
                            
                            
                            
                        }
                        
                        if(objCC.hed__Course_Offering__r.Third_Faculty__c !=null && !setofCourseConIDandConIdandTFId.contains(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c)) {
                                
                         
                          
                           mapofCourseConIDandConIdandTFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Third_Faculty__c,true);
                            
                        }
                        
                        // To Check for Fourth Faculty feedback link disable/Enable
                        if(objCC.hed__Course_Offering__r.Fourth_Faculty__c !=null){
                            
                            
                            mapofCourseConIDandConIdandFFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c,false);
                            
                            mapofCourseConIDandConIdandFFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c,false);
                        }
                        else{
                            mapofCourseConIDandConIdandFFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                            mapofCourseConIDandConIdandFFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+'',false);
                        }
                        
                        
                        if(objCC.hed__Course_Offering__r.Fourth_Faculty__c !=null && !setofCourseConIDandConIdandFFId.contains(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c)) {
                                
                          
                           
                           mapofCourseConIDandConIdandFFIdMidTermToIsFeedBack.put(objCC.id+'_'+'MidTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c,true);
                            
                            
                            
                        }
                        
                        if(objCC.hed__Course_Offering__r.Fourth_Faculty__c !=null && !setofCourseConIDandConIdandFFId.contains(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c)) {
                                
                           
                          
                           mapofCourseConIDandConIdandFFIdEndTermToIsFeedBack.put(objCC.id+'_'+'EndTerm'+'_'+objCC.hed__Contact__c+'_'+objCC.hed__Course_Offering__r.Fourth_Faculty__c,true);
                            
                        }
                    }                 
                }              
           }
         
        
        }
       if(objContact.RecordType.Name == 'FU-Employee') {
           
              
             String query2 = ' Select id,Name,hed__Course__r.name,MidTerm_Faculty_Feedback_Visibility__c,EndTerm_Faculty_Feedback_Visibility__c,MidTerm_Faculty_Feedback_Visibility_Date__c,EndTerm_Faculty_Feedback_Visibility_Date__c,hed__Faculty__c,Secondary_Faculty__c,Third_Faculty__c,Fourth_Faculty__c,Term__c,Academic_Year__c,hed__Course__r.hed__Course_ID__c from hed__Course_Offering__c where';
             
                 System.debug('query2@@@'+query2);
                 
                 query2 += '( hed__Faculty__c =: strContId'; //OR Secondary_Faculty__c =:strContId ';
                 query2 += '  OR Secondary_Faculty__c =: strContId';
                 query2 += '  OR Third_Faculty__c =: strContId';
                 query2 += ' OR Fourth_Faculty__c =: strContId)';
                 System.debug('query2@@@'+query2);
                 
                  if(objCF.Academic_Year__c!= null &&  objCF.Academic_Year__c!= '' && objCF.Term__c== null){
                    query2 += 'AND ';
                    query2 += 'Academic_Year__c =: academicYear Order By CreatedDate DESC';
                }
                if(objCF.Term__c!=null &&  objCF.Term__c!= '' && objCF.Academic_Year__c == null){
                    query2 += ' AND '; 
                    query2 += 'Term__c =: termCode Order By CreatedDate DESC'; 
                } 
        
                if(objCF.Term__c!= '' && objCF.Term__c!= null && objCF.Academic_Year__c != '' && objCF.Academic_Year__c != null){
                    query2 += ' AND '; 
                    query2 += ' Academic_Year__c =: academicYear';
                    query2 += ' AND '; 
                    query2 += 'Term__c =: termCode Order By CreatedDate DESC'; 
                }
                lstofCourseOffering = Database.query(query2);
            
        } 
    }
}