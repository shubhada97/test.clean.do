@isTest
private Class WebToCaseControllerTest
{
 static private case objCase;
 
     static void LoadData() 
    {
     
      CreateCase();
    }
    
    static testMethod void validateWebToCase() 
    {   
        ApexPages.currentPage().getParameters().put('webtoEmail','test@gmail.com');
        LoadData();
        WebToCaseController objWebC  = new WebToCaseController();
        
    }
 
    static void CreateCase()
    {
       objCase = new Case();
       objCase.Origin= 'Email';
       objCase.SuppliedEmail = 'test@gmail.com';
       objCase.SuppliedName = 'Test Name';
       objCase.SuppliedCompany = 'Test Company';
       insert objCase;
    }
   
}