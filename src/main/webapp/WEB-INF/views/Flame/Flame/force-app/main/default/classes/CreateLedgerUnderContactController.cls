public class CreateLedgerUnderContactController {

    public Ledger__c objLe {get;set;}
    //public string strName {get;set;}
    public list<Ledger__c > lstofLd {get;set;}
    public string selectedAccountId {get;set;}
    public Boolean isshow{get;set;}     
   public string strMessage{get;set;}   
    public List<selectoption> lstSelectOption{get;set;}
    public List<Contact> lstContact {get;set;}
    public List<WrapperClass> lstofwrapperClas{get;set;}
    public string SuccessMessage{get;set;}
    public boolean isChanged{get;set;}

    public CreateLedgerUnderContactController(ApexPages.StandardController sc) {
    
        objLe =(Ledger__c)sc.getRecord();
        SuccessMessage = '';
        lstofLd  = new List<Ledger__c >();
        lstContact  = new List<Contact>();
        isshow =false;
        lstSelectOption = new List<selectoption>();
        lstofwrapperClas  = new List<WrapperClass>();
        ShowAccountRecord();

    }

   // This method will return list of selectoption and will be bind in VF page in select list
   /* public List<selectoption> getlstAccount(){        
        List<selectoption> lstSelectOption= new List<selectoption>();
        lstSelectOption.add(new selectOption('None','-None-'));        // adding first value in list as None
        for(Account acc : [select Id,Name from Account]){
            lstSelectOption.add(new selectoption(acc.Id,acc.name));
        }
        return lstSelectOption;                
    }*/
    
    public void ShowAccountRecord()
    {
        lstSelectOption.add(new selectOption('None','-None-')); 
        for(Account acc : [select Id,Name from Account where name like '%FLAME Students%']){
            
            lstSelectOption.add(new selectoption(acc.Id,acc.name));
        }
    }
    
    public void AllContact(){
        lstofwrapperClas  = new List<WrapperClass>();
        lstContact = new List<Contact>();
        system.debug('selectedAccountId3333******** '+selectedAccountId);
        lstContact  = [select Id,Name,email from Contact where AccountId=:selectedAccountId And Primary_Contact_Type__c='Student']; 
        if(lstContact.size()>0 && lstContact!=null)
        {
            
            for(Contact ObjContact: lstContact)
            {
                WrapperClass objWrap = new WrapperClass();
                objWrap.objCon = ObjContact;
                objWrap.isSelected = false;
                lstofwrapperClas.add(objWrap);    
            }
         
        }
      
    }  
  
  
   
   public void SaveData(){
       
        for(WrapperClass objwrap :lstofwrapperClas)
        {
            if(objwrap.isSelected){
                Ledger__c objL = new Ledger__c();
                for(Schema.FieldSetMember fld :SObjectType.Ledger__c.FieldSets.CreateLedgerUnderContact.getFields()) {
                  system.debug('objLe@@@====>'+objLe.get(fld.getFieldPath()));
                  objL.put(fld.getFieldPath(),objLe.get(fld.getFieldPath()));
                }
                objL.Contact__c= objwrap.objCon.Id;
                lstofLd.add(objL);
            }
        }
        if(lstofLd != null && lstofLd.size()>0)
        {
        
            isChanged=true;
            insert lstofLd;
        }
        
        
       /* if(lstofLd != null && lstofLd.size()>0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record has been successfully created.'));
            /*for(Schema.FieldSetMember fld :SObjectType.Ledger__c.FieldSets.CreateLedgerUnderContact.getFields()) {
              objLe.put(fld.getFieldPath(),null);
            }
            selectedAccountId = 'None';
            lstofwrapperClas.clear();*/
            //PageReference ReturnPage = new PageReference('/' + selectedAccountId );
            // ReturnPage.setRedirect(true);
              //return ReturnPage; 
            
            
            //return null;
             
       // }*/
        
        if(lstofLd.size() ==0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select atleast one contact'));
            //return null;
        }
        
        //return null;
       
        
        
    }
    
    public pagereference redirectAccount(){
        PageReference pageRef=new PageReference('https://flame--c.ap6.visual.force.com/apex/CreateLedgerUnderContactController?sfdc.tabName=01r0K0000019u1f');
        return pageRef;
    }
    
    
    
   
   
   // Create Wrapper Class
    public class WrapperClass{
        
        public Contact objCon{get;set;}
        public Boolean isSelected{get;set;}
        
        public WrapperClass(){
            objCon = new Contact();
            isSelected  = false;
        }
    }
 
}