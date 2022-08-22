@isTest
private class CaseFeebackControllerTest{

    static private Case objCase;
 
    static void LoadData() 
    {
        CreateCase();
    }
    static testMethod void validateRecords() 
    {   
        LoadData();
       CaseFeebackController  objCFC = new CaseFeebackController ();
       objCFC.strCaseId = objcase.id;
       objCFC.SubmitFeedback();
       objCFC.closePopup();
    }
    
    static void CreateCase()
    {
       objCase = new Case();
       objCase.Subject = 'Test';
       insert objCase;
    }
  
}