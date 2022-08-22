public class parseCSVDataController {
	
    public Blob csvFileBody{get;set;}
	public string csvAsString{get;set;}
	public String[] csvFileLines{get;set;}
	public List<Raw_Employee_Punch__c> rawlist{get;set;}
    
  public parseCSVDataController(){
    csvFileLines = new String[]{};
    rawlist = New List<Raw_Employee_Punch__c>(); 
  }
  
  public void importCSVFile(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Raw_Employee_Punch__c rawObj = new Raw_Employee_Punch__c() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               rawObj.Timelog__c = csvRecordData[0] ;             
               rawObj.Event_Type__c = csvRecordData[1];
               rawObj.Severity__c = csvRecordData[2];
               rawObj.Message__c = csvRecordData[3];   
               rawObj.User_Name__c = csvRecordData[4]; 
               rawObj.Source__c = csvRecordData[5];
               rawObj.Status__c = csvRecordData[6];
               rawlist.add(rawObj);
               system.debug('rawlist::'+rawlist);
           }
        //insert rawlist;
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
  }
}