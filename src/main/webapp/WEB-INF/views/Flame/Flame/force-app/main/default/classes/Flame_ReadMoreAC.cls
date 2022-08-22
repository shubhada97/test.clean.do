/********************************************************************
* Author: Techila Global Services Pvt Ltd. (Deepak Chouhan)
* Class Name: Flame_ReadMoreAC
* Created Date: August 03 2018
* Description: detail page of customer community event,news etc.
*******************************************************************/
public class Flame_ReadMoreAC {
    public sObject objSObject {get;set;}
    public String objectName {get;set;}
    public String recordId {get;set;}
    public List<String> fieldName {get;set;}
    Public List<RecordType> lstAccountRecordTypes {get;set;}
    public Boolean inputMode{get;set;}
    public Flame_Event__c event {get;set;}
      
    public Flame_ReadMoreAC(){
        objectName = ApexPages.currentPage().getParameters().get('oname');
       
        system.debug('objectName'+objectName);
        recordId = ApexPages.currentPage().getParameters().get('rid');
        System.debug('Object Name --> '+objectName+' --> Record Id --> '+recordId);
        fieldName = new List<String>{'Heading__c','Image__c','StartDateTime__c','Venue__c','Event_Organiser_Name__c','Event_Organiser_Email_Id__c','Content__c'};
        System.debug('Field Name --> '+fieldName );    
        //-- default method
        init();
        inputMode=false;
    }
    
    //-- default initialization method
    public void init(){
        if(objectName!=null && recordId!=null){            
            String query='SELECT ';
            for(string field : Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().keySet()){
                query += field+',';                
            }
            query = query.removeEnd(',') + ' from '+objectName+' where Id = \''+recordId+'\'';
            System.debug('Query String --> '+query);
            List<sObject> tempSObjectList = Database.query(query);
            if(tempSObjectList.size()>0){
                objSObject = tempSObjectList[0];
                System.debug(objectName +'-->'+ objSObject);
               
            }
        }
      
     
    }
        Flame_Event__c Recordediting;
        Public Flame_Event__c GetRecordediting(){
        
        Recordediting = [Select id,Heading__c,Image__c,StartDateTime__c,Venue__c,Event_Organiser_Name__c,Event_Organiser_Email_Id__c,Content__c,RecordType.name From Flame_Event__c where Id=:recordId limit 1];
        System.debug('----Recordediting----'+Recordediting);
        return Recordediting;
        }
    
    
    
    
    
}