trigger profilecareerfieldupdate on CareerServicesProfile__c (after insert, after update) {
    List<CareerServicesProfile__c> listcprofile = new List<CareerServicesProfile__c>();
    List<Contact_Education__c> listconedu =new List<Contact_Education__c>();
    if(Trigger.isInsert) {
    for (CareerServicesProfile__c co : Trigger.new){
     CareerServicesProfile__c profileList = [Select id,Achievement__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,C2From__c,C2ProjectDescription__c, 
                                            C2ProjectTitle__c,C2To__c,C3From__c,C3projectDescription__c,C3ProjectTitle__c,C3To__c,Company1__c,Company2__c, 
                                            Company3__c,contact__c,Course__c,Extra_Curricular__c,Gender__c,Gradation_University__c,Graduation_College__c,
                                            Graduation_Percentage__c,Graduation_Stream__c,Graduation_Year__c,Languages_Known__c,Percent_CGPA_c__c,Xth_Year_of_Passing__c, 
                                            Specialization_Interest_Area__c,Submit__c,X_Board__c,Xth_CGPA__c,Xll_Board__c,Xll_College__c,Xll_Year_Of_Passing__c,Xth_School__c
                                            From CareerServicesProfile__c where contact__c =:'0030k00000nh6tA'];
     listconedu =[Select id,
     Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,Institution_Name__c,
     Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c   where  Contact__c =:'0030k00000nh6tA' ];    
        
      for(Contact_Education__c EduList : listconedu){
       
          If (EduList.Year_Class__c == '10/Xth'){
              
              profileList.Xth_CGPA__c = EduList.Percent_CGPA__c;
              profileList.Xth_School__c = EduList.Institution_School__c;
              
             update profileList;
              
          }   
          
              
          }
              
       }
    }
    if(Trigger.isAfter) {
    if(Trigger.isUpdate){
        
    for (CareerServicesProfile__c co : Trigger.old){
     CareerServicesProfile__c profileList = [Select id,Achievement__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,C2From__c,C2ProjectDescription__c, 
                                            C2ProjectTitle__c,C2To__c,C3From__c,C3projectDescription__c,C3ProjectTitle__c,C3To__c,Company1__c,Company2__c, 
                                            Company3__c,contact__c,Course__c,Extra_Curricular__c,Gender__c,Gradation_University__c,Graduation_College__c,
                                            Graduation_Percentage__c,Graduation_Stream__c,Graduation_Year__c,Languages_Known__c,Percent_CGPA_c__c,Xth_Year_of_Passing__c, 
                                            Specialization_Interest_Area__c,Submit__c,X_Board__c,Xth_CGPA__c,Xll_Board__c,Xll_College__c,Xll_Year_Of_Passing__c,Xth_School__c
                                            From CareerServicesProfile__c where Education__c=:co.id];
     listconedu =[Select id,
     Board_University__c,Contact__c,Education_Country__c,Degree_Certificate__c,Education_State__c,Grade__c,Institution_School__c,Institution_Name__c,
     Major_Subjects__c,Percent_CGPA__c,Percent_CGPA_Out_of__c,Year_Class__c,Year_of_Completion__c From Contact_Education__c where  Contact__c =:profileList.Contact__r.id ];    
        
      for(Contact_Education__c EduList : listconedu){
       
          If (EduList.Year_Class__c == '10/Xth'){
              
              profileList.Xth_CGPA__c = EduList.Percent_CGPA__c;
              profileList.Xth_School__c = EduList.Institution_School__c;
              
             update profileList;
              
          }   
          
              
          }
              
       }    
        
        
        
        
        
    }
    /* List<CareerServicesProfile__c> profileList = [Select id,Achievement__c,C1From__c,C1projectDescription__c,C1ProjectTitle__c,C1To__c,C2From__c,C2ProjectDescription__c, 
                                            C2ProjectTitle__c,C2To__c,C3From__c,C3projectDescription__c,C3ProjectTitle__c,C3To__c,Company1__c,Company2__c, 
                                            Company3__c,contact__c,Course__c,Extra_Curricular__c,Gender__c,Gradation_University__c,Graduation_College__c,
                                            Graduation_Percentage__c,Graduation_Stream__c,Graduation_Year__c,Languages_Known__c,Percent_CGPA_c__c,Xth_Year_of_Passing__c, 
                                            Specialization_Interest_Area__c,Submit__c,X_Board__c,Xll_Board__c,Xll_College__c,Xll_Year_Of_Passing__c,Xth_School__c
                                            From CareerServicesProfile__c where Education__c=:contactedu.id];*/

 
    }
}