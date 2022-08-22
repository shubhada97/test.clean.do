/*
    Author         : Kartheek Varma
    Name           : ContactEducationDetails
    Description    : This is a controller class to display information of Contact's education and work details.
*/
public class ContactEducationDetailsDupController{
    
    //varible declarations
    public string selAdmStatus{get;set;}
    public string selAppRefId{get;set;}
    public Date fromDate{get;set;}
    public Date toDate{get;set;}
    public List<ContactDetailsWrapper> ContactDetails{get;set;}
    
    //Constructor
    public ContactEducationDetailsDupController(ApexPages.StandardController controller) {
        ContactDetails = new  List<ContactDetailsWrapper>();
        selAdmStatus = 'None';
        searchClick();
    }
    
    //Get Application Reffernce Ids
    public List<SelectOption> appRefIdList{
        get{
            appRefIdList = new List<SelectOption>();
            
            appRefIdList.add(new SelectOption('','Select'));
            appRefIdList.add(new SelectOption('UGLE','UGLE'));
            appRefIdList.add(new SelectOption('PGC','PGC'));
            appRefIdList.add(new SelectOption('PGB','PGB'));
            return appRefIdList;
        }
        set;
    }
    
    //Get Admission status list
    public List<SelectOption> admStatusList{
        get{
            admStatusList = new List<SelectOption>();
            
            //Fetching picklist values from object
            Schema.DescribeFieldResult fieldResult = Application__c.Admission_Status__c.getDescribe();
            List<Schema.PicklistEntry> pleList = fieldResult.getPicklistValues();
                
            for( Schema.PicklistEntry ple : pleList){
                admStatusList.add(new SelectOption(ple.getLabel(), ple.getValue()));
            }       
            return admStatusList;
        }
        set;
    }
    
    //This method executes from on click of Search button from UI
    public void searchClick(){
        //Dynamic query on Applicaitonobject
        string appQuery = 'Select id,contact__c,contact__r.firstName,contact__r.lastName,contact__r.email,contact__r.App_Reference_ID__c, contact__r.FUA_Mobile__c,'
                       +'contact__r.Gender__c,contact__r.Religion__c,contact__r.Mother_Tongue__c,contact__r.Total_Family_Income__c,'
                       +'(SELECT id, FU_Year_Class__c, Score__c,FUA_CGPA_Actual__c,FUA_CGPA_Out_Of__c, Total_Score_Out_Of_100__c,'
                       +'FUA_Education_State__c,FUA_Institution_School__c,FUA_Education_City__c,FUA_Board_University__c '
                       +'FROM Education_Details__r WHERE FU_Year_Class__c != NULL AND Score__c > 0),' 
                       +'(SELECT id,Name,FUA_Designation__c,FromDate__c,FUA_From_Date__c,FUA_Function__c,FUA_Work_City__c,'
                       +'FUA_Company__c,FUA_Work_Country__c,FUA_CTC_INR__c,FUA_Other_City1__c,FUA_Reporting_Person_Details__c,'
                       +'FUA_Work_State__c,Todate__c,FUA_To_Date__c,FUA_Type__c,FUA_Your_Responsibilities__c '
                       +'From Work_Details__r) '
                       +'FROM Application__c Where contact__c != null and contact__r.name != null ';
        
        system.debug('## adm '+selAdmStatus);
        system.debug('## Ref '+selAppRefId);
        system.debug('## From '+fromDate );
        system.debug('## To '+toDate );
        //Admission status filter
        if(string.isNotEmpty(selAdmStatus)){
            appQuery = appQuery +'AND Admission_Status__c = :selAdmStatus ';
        }
        
        //Application reference Id filter
        if(string.isNotEmpty(selAppRefId)){
            string strLike = selAppRefId+'%';
            appQuery = appQuery +'AND App_Reference_ID__c like :strLike ';
        }
        
        //From date filter
        if(fromDate != null){
            appQuery = appQuery +'AND createddate >= :fromDate ';
        }
        
        //To data Filter
        if(toDate != null){
            appQuery = appQuery +'AND createddate <= :toDate ';
        }
        
        //Order by clasue
        appQuery = appQuery +'ORDER BY Contact__r.Name ASC LIMIT 10000';
        
        //Executing query
        List<Application__c> appList = Database.query(appQuery);   
        ContactDetails = getContactDetails(appList); //preparing wrapper class to display on UI
    }
    
    //This method is used to prepare wrapper class to display on UI. Parameter 1: Applicaiton data
    public List<ContactDetailsWrapper> getContactDetails(List<Application__c> appList){
        List<ContactDetailsWrapper> cdwList = new List<ContactDetailsWrapper>();
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        
        // Initialise score with Zero.
        Map<String, FU_Education_Details__c > tempYearScoreMap = new Map<String, FU_Education_Details__c>();
        for(String yearName: getYearClassList()){
            tempYearScoreMap.put(yearName, new FU_Education_Details__c());
        } 
        
        //Iteration on Application data
        for(Application__c app:appList){
            if(app.contact__c != null && app.contact__r.firstName != null && app.Education_Details__r != null 
                                                                                    && !app.Education_Details__r.isEmpty()){
                //Contact from app record
                Contact con = new Contact(id=app.contact__c,firstname=app.contact__r.firstName,
                                                            lastname=app.contact__r.lastname,
                                                            email=app.contact__r.email,
                                                            mobilephone=app.contact__r.FUA_Mobile__c,
                                                            Gender__c=app.contact__r.Gender__c,
                                                            Religion__c=app.contact__r.Religion__c,
                                                            App_Reference_ID__c=app.contact__r.App_Reference_ID__c
                                                                       );
                
                Map<String, FU_Education_Details__c > eduMap = new Map<String, FU_Education_Details__c>();
                eduMap = tempYearScoreMap.deepClone();
                
                Map<String, FUA_Work_Details__c> workMap = new Map<String, FUA_Work_Details__c>();
                
                //Preparing Education and work details
                if(!conMap.containsKey(con.id)){ 
                    conMap.put(con.id,con);
                    if(app.Education_Details__r != null){
                        for(FU_Education_Details__c edu:app.Education_Details__r){
                            if(eduMap.containsKey(edu.FU_Year_Class__c)){
                                eduMap.put(edu.FU_Year_Class__c, edu);
                            }
                        }
                    }
                    if(app.Work_Details__r != null){
                        for(FUA_Work_Details__c work:app.Work_Details__r){
                            if(!workMap.containsKey(work.FUA_Company__c)){
                                workMap.put(work.FUA_Company__c, work);
                            }
                        }
                    }
                }  
                
                //Wrapper class
                ContactDetailsWrapper cdw = new ContactDetailsWrapper();
                cdw.contact = con;
                cdw.eduDetails = eduMap;
                cdw.workDetails = workMap;
                
                cdwList.add(cdw);
            }   
        }
        
        return cdwList;
    }
    
    
    
    //Function to get Picklist value of Year/Class
    public List<String> getYearClassList(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult =
                        FU_Education_Details__c.FU_Year_Class__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple){
            options.add(f.getValue());
        }       
        return options;
    }
    public List<String> getYearofCompletion(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult =
                        FU_Education_Details__c.FUA_Year_of_Completion__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
        for( Schema.PicklistEntry f : ple){
            options.add(f.getValue());
        }       
        return options;
    }
    /*
        Name        : ContactModalClass
        Description : This is a wrapper class use to map between Contact and its education score.
    */
    public class ContactModalClass{
        Public Contact contact{get;set;}
        public String score{get;set;}
        public Map<string, FU_Education_Details__c > educationScore{get;set;}
    }
    
    //Wrapper class
    public class ContactDetailsWrapper{
        Public Contact contact{get;set;}
        public Map<string, FU_Education_Details__c > eduDetails{get;set;}
        public Map<string, FUA_Work_Details__c> workDetails{get;set;}
    }
    
}