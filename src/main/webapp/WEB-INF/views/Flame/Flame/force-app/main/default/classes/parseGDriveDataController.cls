public class parseGDriveDataController {
	public static Http http = new Http();
    public static HTTPResponse response;
    public static HttpRequest request;
    public static Blob csvFileBody{get;set;}
	public static string csvAsString{get;set;}
	public static String[] csvFileLines{get;set;}
	public static List<Raw_Employee_Punch__c> rawlist{get;set;}

   /* public static void getFile() {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleConnection/drive/v3/files?includeTeamDriveItems=true&orderBy=createdTime&pageSize=1000&q=name%20contains%20%27Flame-Wifi%27&spaces=drive&supportsAllDrives=false&supportsTeamDrives=true&fields=nextPageToken,%20files(id,%20name)');
        //request.setEndpoint('callout:GoogleConnection/drive/v3/files/' + fileId);
        response = http.send(request); 
        
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        List<Object> dataList = (List<Object>)jsonMap.get('files');
        System.debug('dataList::'+dataList);
        Integer counter= 0;
        String sheetId='';
         for(Object data : dataList){
             Map<String, Object> newdata = (Map<String, Object>) data;
             sheetId = (String)newdata.get('id');   
         }
        System.debug('newdata::'+sheetId);
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleSheet/' + sheetId+'/values/A2:G1009');
        request.setHeader('Content-Type', 'application/json');
        response = http.send(request);
        System.debug(response.getBody());
    }  */
    
    
   /* public static void getExcelSheetData(String fileId) {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleSheet/' + fileId+'/values/A1:G109');
        response = http.send(request); 
        System.debug(response.getBody());
    }*/
    
    
    /* Get Sheet ID By Name from Google Drive */
    /* File name start should be "Flame-Wifi" */
     public static void getDriveSheetFiles() {
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleConnection/drive/v3/files?includeTeamDriveItems=true&orderBy=createdTime&pageSize=1000&q=name%20contains%20%27Flame-Wifi%27&spaces=drive&supportsAllDrives=false&supportsTeamDrives=true&fields=nextPageToken,%20files(id,%20name)');
        response = http.send(request); 
        System.debug('responseBody::'+response.getBody()); 
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        List<Object> dataList = (List<Object>)jsonMap.get('files');
        System.debug('dataList::'+dataList);
        Integer counter= 0;
        String sheetId='';
         for(Object data : dataList){
             Map<String, Object> newdata = (Map<String, Object>) data;
             sheetId = (String)newdata.get('id');  
             //System.debug('newdata::'+sheetId);
         }
        System.debug('newdata::'+sheetId); 
        request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleSheet/' + sheetId+'/values/A2:G1009');
        request.setHeader('Content-Type', 'application/json');
        HTTPResponse resp = http.send(request);
        
        System.debug(resp.getBody());
         
        if(resp.getStatusCode() == 200){
           
            Map<String, Object> jsonMap1 = (Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
            
            List<Object> dataList1 = (List<Object>)jsonMap1.get('values');
          
            List<Raw_Employee_Punch__c> googleSheetData = new List<Raw_Employee_Punch__c>{};  
            
            for(Object data : dataList1){
               
                csvAsString = data.toString();
                csvAsString = csvAsString.substring( 1, csvAsString.length() - 1 );
                system.debug('csvAsString:: '+csvAsString);
                string[] csvRecordData = csvAsString.split(',');
                system.debug('csvRecordData:: '+csvRecordData);
				Raw_Employee_Punch__c empCal = New Raw_Employee_Punch__c();
                empCal.Timelog__c = csvRecordData[0];
                empCal.Event_Type__c = csvRecordData[1];
                empCal.Severity__c = csvRecordData[2];
                empCal.Message__c = csvRecordData[3];
                empCal.User_Name__c = csvRecordData[4];
                empCal.Source__c = csvRecordData[5];
                empCal.Status__c = csvRecordData[6];
                googleSheetData.add(empCal); 
                            
            } 
            insert googleSheetData;
        }   

    }
    
    
    /* Import Google Sheet Data from Drive */
    /* Insert into Raw Employee Punch Object */
    /*public static void importCSVFile(String fileId){
       	request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:GoogleSheet/' + fileId+'/values/A2:G1009');
        request.setHeader('Content-Type', 'application/json');
        response = http.send(request);
    
        
        if(response.getStatusCode() == 200){
            //system.debug('jsonMap:: '+response.getBody());
            Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            //system.debug('jsonMap::'+jsonMap.get('values'));
            
            List<Object> dataList = (List<Object>)jsonMap.get('values');
            //system.debug('dataList object'+dataList);
            List<Raw_Employee_Punch__c> googleSheetData = new List<Raw_Employee_Punch__c>{};  
            
            for(Object data : dataList){
                //system.debug('dataList:'+data);
                csvAsString = data.toString();
                csvAsString = csvAsString.substring( 1, csvAsString.length() - 1 );
                string[] csvRecordData = csvAsString.split(',');
                //system.debug('csvRecordData:'+csvRecordData);
				Raw_Employee_Punch__c empCal = New Raw_Employee_Punch__c();
                empCal.Timelog__c = csvRecordData[0];
                empCal.Event_Type__c = csvRecordData[1];
                empCal.Severity__c = csvRecordData[2];
                empCal.Message__c = csvRecordData[3];
                empCal.User_Name__c = csvRecordData[4];
                empCal.Source__c = csvRecordData[5];
                empCal.Status__c = csvRecordData[6];
                googleSheetData.add(empCal); 
                //system.debug('csvRecordData[6]::'+csvRecordData[6]);   
                
            }
            insert googleSheetData;
        }        
  } */
    
    /* Create Google Sheet Data Into Drive */
    /* Insert Records into Google Drive Sheet from Salesforce */
    public static void createExcelSheetInDrive() {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:GoogleSheet');
        String sheetName = 'Flame-RawEmployee'+System.now().format('dd-MM-YYYY');
        request.setHeader('Content-Type', 'text/csv');
        String jsonString = '{'+'"properties":'+'{'+'"title":"'+sheetName+'"'+'}}';
        request.setBody(jsonString);
        response = http.send(request);
        
        if(response.getStatusCode() == 200){
            
            Map<String, Object> jsonMap1 = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        	Object dataList1 = (Object)jsonMap1.get('spreadsheetId');
        
        	system.debug('GoogleSheet Id::'+dataList1);
        	String lstCustomers ='';
            if(dataList1!= null){
                	lstCustomers = (String)dataList1;
            	}else{
                	lstCustomers = '1AH022RjGkLR1tjFXbW--wQf7CUtTTKw2Blr7H4Op8uc';
            }
            
            Datetime systemDate = System.now()-1;
            String timeDate = systemDate.format('yyyy-MM-dd');
            String currentStartDate = timeDate +' 00:05:00';
            Datetime startDate = Datetime.valueOfGmt(currentStartDate);
                
            String currentendDate = timeDate +' 23:59:59';
            DateTime endDate = Datetime.valueOfGmt(currentendDate);
        
        	/*String timeHour = System.now().format('HH');
        	integer strToDecH = 23-integer.valueOf(timeHour);
        	strToDecH = strToDecH + 5;
        	String dateFormat = 'yyyy-MM-dd\'T\'HH:mm:ss\'Z\'';
        	Date d = Date.today();
        	Datetime startDate = Datetime.newInstance(d.year(), d.month(), d.day(), 7, 0, 0);
			startDate.addHours(18);
            
        	DateTime endDate = System.Now().addHours(strToDecH);
        	endDate.addHours(24);
        	endDate.addMinutes(59); */
        	system.debug('GoogleSheet startDate::'+startDate);
            system.debug('GoogleSheet Response::'+endDate);
        
        	system.debug('GoogleSheet Response::'+response.getBody());
        	// Update Records into Created Sheet
        	
        
        	List<Raw_Employee_Punch__c> rawEmployees = [Select Status__c,Severity__c,Source__c,Event_Type__c,User_Name__c,Message__c,Timelog__c,CreatedDate from Raw_Employee_Punch__c Where CreatedDate >=:startDate AND CreatedDate <=:endDate AND Status__c =: 'Successful'];
        	String jsonRawHeading= '["Timelog__c","Event_Type__c","Severity__c","Message__c","User_Name__c","Source__c","Status__c"],';
        	String jsonRawData= '';
        	String startcode = '["';
        	String endcode = '"],';
        	for(Raw_Employee_Punch__c rowEmp : rawEmployees){
            	jsonRawData = jsonRawData + startcode+rowEmp.Timelog__c+'","'+rowEmp.Event_Type__c+'","'+rowEmp.Severity__c+'","'+rowEmp.Message__c+'","'+rowEmp.User_Name__c+'","'+rowEmp.Source__c+'","'+rowEmp.Status__c + endcode;
        	}
        	system.debug('GoogleSheet jsonRawData::'+jsonRawData);
        	String jsonString1 = '{'+'"majorDimension":"ROWS","range": "Sheet1!A1:G1009",'+'"values":['+jsonRawHeading+jsonRawData.removeEnd(',')+']'+'}';
        	system.debug('GoogleSheet jsonString1::'+jsonString1);
        	request = new HttpRequest();
        	request.setMethod('POST');
        	request.setHeader('Accept', 'application/json');
			request.setHeader('Content-Type', 'application/json');
        	request.setEndpoint('callout:GoogleSheet/' + lstCustomers+'/values/Sheet1!A1:G1009:append?valueInputOption=RAW');
        	request.setBody(jsonString1);
        	response = http.send(request);
        	System.debug('response::'+response.getBody()); 
        }
    }

}