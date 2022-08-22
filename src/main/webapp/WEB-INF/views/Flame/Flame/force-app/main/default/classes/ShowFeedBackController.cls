public class ShowFeedBackController {

    public string strCCId{get;set;}
    public string strCFId{get;set;}
    public string strconId{get;set;}
    public string strpfId{get;set;}
    public string strsfId{get;set;}
    public string strtfId{get;set;}
    public string strffId{get;set;}
    public string strterm{get;set;}
    public string strcourseid{get;set;}
    public string strAccid{get;set;}
    public string strcourseofferingName{get;set;}
    public Course_feedback__c objCF {get;set;}
    public boolean isAcedmicM{get;set;}
    public boolean isAcedmicE{get;set;}
    public boolean isSports{get;set;} 
    public boolean isChanged{get;set;}
    public boolean display{get;set;}
    public string courseId;
    public string courseofferingId;
    public string courseofferingName{get;set;}
    public string TermId;
    public string coursedFeebackId;
    public Map<string, string> mapofDevNameToQue {get;set;}
    public string que1{get;set;}
    public string que2{get;set;}
    public string que3{get;set;}
    public string que4{get;set;}
    public string que5{get;set;}
    public string que6{get;set;} 
    public string que7{get;set;} 
    public string que8{get;set;} 
    public string que9{get;set;} 
    public string que10{get;set;} 
    public string que11{get;set;} 
    public string que12{get;set;} 
    public string que13{get;set;}
    public string que14{get;set;}
    public string que15{get;set;}
    public string que16{get;set;}
    public string que17{get;set;}
    public string que18{get;set;}
    public string que19{get;set;}
    public string que20{get;set;}
    public string que21{get;set;}
    public string que22{get;set;}
    public string que31{get;set;} 
    public string que32{get;set;}
    public string Mque1{get;set;}
    public string Mque2{get;set;}
    public string Mque3{get;set;}
    public string Mque4{get;set;}
    public string Mque5{get;set;}
    public string Mque35{get;set;}
    public string Mque36{get;set;}
 // Question set for sports starts 
    public string Sque1{get;set;}
    public string Sque2{get;set;}
    public string Sque3{get;set;}
    public string Sque4{get;set;}
    public string Sque5{get;set;}
    public string Sque6{get;set;}
    public string Sque7{get;set;}
    public string Sque8{get;set;}
    public string Sque9{get;set;}
    public string Sque10{get;set;}
    public string Sque31{get;set;}
    public string Mque31{get;set;}
    public string Mque32{get;set;}
    public string Mque33{get;set;}
    public string Mque34{get;set;}
    public string Mans31{get;set;}
    public string Mans32{get;set;}
 // Question set for sports Ends  
    public String ans1 {get;set;}
    public String ans2 {get;set;}
    public String ans3 {get;set;}
    public String ans4 {get;set;}
    public String ans5 {get;set;}
    public String ans6 {get;set;}
    public String ans7 {get;set;}
    public String ans8 {get;set;}
    public String ans9 {get;set;}
    public String ans10 {get;set;}
    public String ans11 {get;set;}
    public String ans12 {get;set;}
    public String ans13 {get;set;}
    public String ans14 {get;set;}
    public String ans15 {get;set;}
    public String ans16 {get;set;}
    public String ans17 {get;set;}
    public String ans18 {get;set;}
    public String ans19 {get;set;}
    public String ans20 {get;set;}
    public String ans21 {get;set;}
    public String ans22 {get;set;}
 // Answers set for sports start
    public String Sans1 {get;set;}
    public String Sans2 {get;set;}
    public String Sans3 {get;set;}
    public String Sans4 {get;set;}
    public String Sans5 {get;set;}
    public String Sans6 {get;set;}
    public String Sans7 {get;set;}
    public String Sans8 {get;set;}
    public String Sans9 {get;set;}
    public String Sans10 {get;set;}
    public String Sans11 {get;set;}
    public String Sans12 {get;set;}
 // Answers set for sports End       
    public Integer total {get; set;}
    public Id academiccourseRecordTypeId;
    public Id sportCourseRecordTypeId;
    public list<Course_feedback__c> lstofCourseFeedback{get;set;}
 //Added the code 16 April 2020
    //public DYN__mdt objDynMataData{get;set;}
    //public list<DYN__mdt> lstofDynMetaData{get;set;}
    public String ans37A {get;set;}
    public String ans38A {get;set;}
    public String ans39A {get;set;}
    public String ans40A {get;set;}
    public String ans41A {get;set;}
    public String ans42A {get;set;}
    public  map<string,Feedback_Questions__mdt> mapofDevloperNmaeToMD {get;set;}
 //End code 16 April 2020
          
    public void displaybutton(){
     display =true;
    }
    
    public ShowFeedBackController (){
        list<Feedback_Questions__mdt> lstofFQ = new list<Feedback_Questions__mdt>();
        mapofDevloperNmaeToMD = new map<string,Feedback_Questions__mdt>();
        showQuestion();
        lstofCourseFeedback = new list<Course_feedback__c>();
        mapofDevNameToQue  = new Map<string,string>();
        objCF = new Course_feedback__c();
        strCFId = ApexPages.currentPage().getParameters().get('cfid'); //Couse offering Id
        strCCId = ApexPages.currentPage().getParameters().get('Id'); //CouseconnectionId
        strconId = ApexPages.currentPage().getParameters().get('conid'); //Contactid
        strpfId = ApexPages.currentPage().getParameters().get('pf'); //PrimaryFacultyId
        strsfId = ApexPages.currentPage().getParameters().get('sf'); //SecondryfacultyId
        strtfId = ApexPages.currentPage().getParameters().get('tf'); //ThirdFacultyId
        strffId = ApexPages.currentPage().getParameters().get('ff'); //FourthFacultyId
        coursedFeebackId = ApexPages.currentPage().getParameters().get('cfid');//CouseFeedbackId
        strterm = ApexPages.currentPage().getParameters().get('term');//CouseFeedbackId
        strcourseofferingName = ApexPages.currentPage().getParameters().get('cfname');//Course offering Name
        strcourseid = ApexPages.currentPage().getParameters().get('courseid');//Course offering >> Course>> CourseId
        strAccid = ApexPages.currentPage().getParameters().get('Accid');
        //system.debug('strcourseofferingName@@'+strcourseofferingName); 
        isAcedmicE = false;
        isAcedmicM = false;
        isSports = false;
        display =false;
        academiccourseRecordTypeId = Schema.SObjectType.Course_feedback__c.getRecordTypeInfosByName().get('Academic Course').getRecordTypeId();
        sportCourseRecordTypeId = Schema.SObjectType.Course_feedback__c.getRecordTypeInfosByName().get('Sports Course').getRecordTypeId();

         //added code 8 June
         
        lstofFQ = [SELECT Id, DeveloperName, MasterLabel, Question__c,Language, Label, QualifiedApiName, Active__c FROM Feedback_Questions__mdt];
        if(lstofFQ !=null && lstofFQ.size()>0){
            System.debug('lstofFQ@@@'+lstofFQ);
            for(Feedback_Questions__mdt ObjFQ:lstofFQ){
                mapofDevloperNmaeToMD.put(ObjFQ.DeveloperName,ObjFQ);
            }
        }   
         
         
        if(strCCId != null)
        {
            for(hed__Course_Enrollment__c obj: [Select hed__Course_Offering__r.Name,Course_ID__c,Department__c,hed__Course_Offering__c, hed__Course_Offering__r.hed__Course__c,hed__Course_Offering__r.hed__Term__c from hed__Course_Enrollment__c where ID =:strCCId])
            {
                
                if(obj.hed__Course_Offering__c !=null)
                {        
                    courseofferingId = obj.hed__Course_Offering__c;
                    courseofferingName = obj.hed__Course_Offering__r.Name;
                }
                if(obj.hed__Course_Offering__r.hed__Course__c !=null)
                {
                    courseId = obj.hed__Course_Offering__r.hed__Course__c;
                }
                if(obj.hed__Course_Offering__r.hed__Term__c !=null)
                {
                    TermId = obj.hed__Course_Offering__r.hed__Term__c;
                }
                if(obj.Department__c!=null)
                {
                    StrAccid = obj.Department__c;
                }
                
                
                if(obj.Department__c != null && obj.Department__c.contains('Sports'))
                {
                    isSports = true;
                   
                }
                else
                {
                     isAcedmicM = true;
                     isAcedmicE = true;
                }
                
            }
        }
        
        if(strCFId != null){
            
               if(strAccid != null && strAccid.contains('Sports')){
                    isSports = true; 
                }
                else{
                 isAcedmicM = true;
                 isAcedmicE = true;
                }
        
        
            
               lstofCourseFeedback = [Select id,Name,TermId__c,Course_Offering__c,End_Type__c,Instructor_Average__c,Course_Average__c,
               Q1__c,Q2__c,Q3__c,Q4__c,Q5__c,Q6__c,Q7__c,Q8__c,Q9__c,Q10__c,Q11__c,Q12__c,Q13__c,Q14__c,Q15__c,Q16__c,Q17__c,Q18__c,Q19__c,Q20__c,Q21__c,Q22__c,Q31__c,Q32__c,Q33__c,Q34__c,
               Q1A__c,Q2A__c,Q3A__c,Q4A__c,Q5A__c,Q6A__c,Q7A__c,Q8A__c,Q9A__c,Q10A__c,Q11A__c,Q12A__c,Q13A__c,Q14A__c,Q15A__c,Q16A__c,Q17A__c,Q18A__c,Q19A__c,Q20A__c,Q21A__c,Q22A__c,Q31A__c,Q32A__c,Q33A__c,Q34A__c,Q35A__c,Q36A__c,
               Course_Connection__c,Primary_Faculty__c,Secondary_Faculty__c,Third_Faculty__c,Fourth_Faculty__c
                                                 from Course_feedback__c
                                                where 
                                                Course_Offering__c =:strCFId
                                                AND End_Type__c =:strterm
                                                And (Primary_Faculty__c =:strconId
                                                OR Secondary_Faculty__c =:strconId
                                                OR Third_Faculty__c =:strconId
                                                OR Fourth_Faculty__c =:strconId)];
             system.debug('lstofCourseFeedback@@@'+lstofCourseFeedback.size());    
        
        }
         
    }
 
    public void SaveFeedBack() {
       
        if(objCF != null)
        {
          
            objCF.Course_Connection__c = strCCId;
            objCF.Contact__c = strconId;
            objCF.Primary_Faculty__c = strpfId;
            objCF.Secondary_Faculty__c = strsfId;
            objCF.Third_Faculty__c= strtfId;
            objCF.Fourth_Faculty__c= strffId;
            objCF.Course__c = courseId;
            objCF.Course_Offering__c = courseofferingId;
            objCF.TermId__c = TermId;  
            objCF.End_Type__c = strterm;            
          
      // Sports  
            if(strCCId != null && isSports == true )
            {
                 objCF.RecordTypeID = sportCourseRecordTypeId;

            objCF.Q1__c = Sque1;
            objCF.Q1__c = Sque1;
            objCF.Q2__c = Sque2;
            objCF.Q3__c = Sque3;
            objCF.Q4__c = Sque4;
            objCF.Q5__c = Sque5;
            objCF.Q6__c = Sque6;
            objCF.Q7__c = Sque7;
            objCF.Q8__c = Sque8;
            objCF.Q9__c = Sque9;
            objCF.Q10__c = Sque10;
            objCF.Q31__c = Sque31;
            objCF.Q1A__c = Sans1;
            ObjCF.Q1A__c = Sans1;
            ObjCF.Q2A__c = Sans2;
            ObjCF.Q3A__c = Sans3;
            ObjCF.Q4A__c = Sans4;
            ObjCF.Q5A__c = Sans5;
            ObjCF.Q6A__c = Sans6;
            ObjCF.Q7A__c = Sans7;
            ObjCF.Q8A__c = Sans8;
            ObjCF.Q9A__c = Sans9;
            ObjCF.Q10A__c = Sans10;
            }
           
 // Acedmic M      
         if(strCCId != null && isAcedmicM == true && strterm.contains('MidTerm'))
            {
                objCF.RecordTypeID = academiccourseRecordTypeId;
            
            objCF.Q1__c = Mque1;
            objCF.Q2__c = Mque2;
            objCF.Q3__c = Mque3;
            objCF.Q4__c = Mque4;
            objCF.Q5__c = Mque5;
            ObjCF.Q31__c = Mque31;
            ObjCF.Q32__c = Mque32;
            ObjCF.Q33__c = Mque33;
            ObjCF.Q34__c = Mque34;
            ObjCF.Q35__c = Mque35;
            ObjCF.Q36__c = Mque36;
            objCF.Q1A__c = ans1;
            ObjCF.Q2A__c = ans2;
            ObjCF.Q3A__c = ans3;
            ObjCF.Q4A__c = ans4;
            ObjCF.Q5A__c = ans5;
/*
            objCF.Q1__c = Mque1;
            objCF.Q2__c = Mque2;
            ObjCF.Q31__c = Mque31;
            ObjCF.Q32__c = Mque32;
            objCF.Q1A__c = ans1;
            ObjCF.Q2A__c = ans2; 
*/            
               //Custom metadata  for midterm
               /**/
               if(mapofDevloperNmaeToMD.get('DYNQMT1').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT1')!=null)
               {
                 objCF.Q37__c = mapofDevloperNmaeToMD.get('DYNQMT1').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQMT2').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT2')!=null)
               {
                 objCF.Q38__c = mapofDevloperNmaeToMD.get('DYNQMT2').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQMT3').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT3')!=null)
               {
                 objCF.Q39__c = mapofDevloperNmaeToMD.get('DYNQMT3').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQMT4').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT4')!=null)
               {
                 objCF.Q40__c = mapofDevloperNmaeToMD.get('DYNQMT4').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQMT5').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT5')!=null)
               {
                 objCF.Q41__c = mapofDevloperNmaeToMD.get('DYNQMT5').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQMT6').Active__c == true && mapofDevloperNmaeToMD.get('DYNQMT6')!=null)
               {
                 objCF.Q42__c = mapofDevloperNmaeToMD.get('DYNQMT6').Question__c;
                }
               
               //
                }
         
      // Acedmic E 
            if(strCCId != null && isAcedmicE == true && strterm.contains('EndTerm') )
            {
                objCF.RecordTypeID = academiccourseRecordTypeId;
            
            objCF.Q1__c = que1;
            objCF.Q2__c = que2;
            objCF.Q3__c = que3;
            objCF.Q4__c = que4;
            objCF.Q5__c = que5;
            objCF.Q6__c = que6;
            objCF.Q7__c = que7;
            objCF.Q8__c = que8;
            objCF.Q9__c = que9;
            objCF.Q10__c = que10;
            objCF.Q11__c = que11;
            objCF.Q12__c = que12;
            objCF.Q13__c = que13;
            ObjCF.Q14__c = que14;
            ObjCF.Q15__c = que15;
            ObjCF.Q16__c = que16;
            ObjCF.Q17__c = que17;
            ObjCF.Q18__c = que18;
            ObjCF.Q19__c = que19;
            ObjCF.Q20__c = que20;
            ObjCF.Q21__c = que21;
            ObjCF.Q22__c = que22;
            ObjCF.Q31__c = que31;
            objCF.Q1A__c = ans1;
            ObjCF.Q2A__c = ans2;
            ObjCF.Q3A__c = ans3;
            ObjCF.Q4A__c = ans4;
            ObjCF.Q5A__c = ans5;
            ObjCF.Q6A__c = ans6;
            ObjCF.Q7A__c = ans7;
            ObjCF.Q8A__c = ans8;
            ObjCF.Q9A__c = ans9;
            ObjCF.Q10A__c = ans10;
            ObjCF.Q11A__c = ans11;
            ObjCF.Q12A__c = ans12;   
            ObjCF.Q13A__c = ans13;
            ObjCF.Q14A__c = ans14;
            ObjCF.Q15A__c = ans15;
            ObjCF.Q16A__c = ans16;
            ObjCF.Q17A__c = ans17;
            ObjCF.Q18A__c = ans18;
            ObjCF.Q19A__c = ans19;
            ObjCF.Q20A__c = ans20;
            ObjCF.Q21A__c = ans21;
            ObjCF.Q22A__c = ans22;
            //Custom metadata  for endterm
            /**/
              if(mapofDevloperNmaeToMD !=null && mapofDevloperNmaeToMD.size()>0){
               if(mapofDevloperNmaeToMD.get('DYNQET1').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET1')!=null)
               {
                 objCF.Q37__c = mapofDevloperNmaeToMD.get('DYNQET1').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQET2').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET2')!=null)
               {
                 objCF.Q38__c = mapofDevloperNmaeToMD.get('DYNQET2').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQET3').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET3')!=null)
               {
                 objCF.Q39__c = mapofDevloperNmaeToMD.get('DYNQET3').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQET4').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET4')!=null)
               {
                 objCF.Q40__c = mapofDevloperNmaeToMD.get('DYNQET4').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQET5').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET5')!=null)
               {
                 objCF.Q41__c = mapofDevloperNmaeToMD.get('DYNQET5').Question__c;
                }
               if(mapofDevloperNmaeToMD.get('DYNQET6').Active__c == true && mapofDevloperNmaeToMD.get('DYNQET6')!=null)
               {
                 objCF.Q42__c = mapofDevloperNmaeToMD.get('DYNQET6').Question__c;
                }
              }
               
               //
               }
         
            system.debug('ans1@@@'+ans1);
            if(ans1 == '')
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select all Answer'));
                //retrun null;
            }
            else
            {
                insert objCF;
                isChanged=true;
            }
            
        } 
         
    }
    
     // This method will call after saving the record. and redirect to specify id
    public pagereference redirectToRequiredPage(){
        pagereference pr = new pagereference('/apex/ShowCourseConnection');
        return pr;
    }
   
    public void showQuestion()
    {
     
     // Academic set of questions //
     
     // Describe the frequency of your instructor’s teaching procedures: 
      
        que1 = '1. Helped students to interpret subject matter from diverse perspective (e.g., different cultures, religions, political views).';
        que2 = '2. Demonstrated the importance and significance of the subject matter.';
        que3 = '3. Provided in-time and meaningful feedback on students’ academic performance.';
        que4 = '4. Stimulated students to intellectual effort beyond that required by most courses.';
        que5 = '5. Explained course material clearly and concisely.';
        que6 = '6. Introduced stimulating ideas about the subject.';
        que7 = '7. Involved students in hands-on projects such as research, case studies or real-life situations.';
        que8 = '8. Inspired students to set and achieve goals which challenged them.';
        que9 = '9. Gave projects, tests, or assignments that required original or creative thinking.';
        que10 = '10. Encouraged student-faculty interaction outside of class.';
        
     // Describe the degree your agreement with the following statements   
        que11 = '11. The amount of coursework was much more than other courses.';
        que12 = '12. The difficulty of subject matter was much higher than other courses.';
        que13 = '13. As a rule, I put forth more academic effort than other students.';
        que14 = '14. Overall, I rate this instructor as an excellent teacher.';
        que15 = '15. Overall, I rate this course as excellent.';
        
    // OPTIONAL: Separate Section
    // The next few questions concern course outcomes. Describe the degree to which you agree with the following statements. 
    // Answer only those which you think are relevant to this course
   
        que16 = '1. Learn to analyse and critically evaluate information, ideas, arguments, and points of view.';
        que17 = '2. Gain a basic understanding of the subject (e.g., factual knowledge, methods, principles, generalisations, theories).';
        que18 = '3. Develop oral and written communication skills.';
        que19 = '4. Learn to find, evaluate and use resources to explore a topic in depth.';
        que20 = '5. Learn to apply course material to solve problems and take decisions in real life situations.';
        que21 = '6. Develop creative capacities (inventing, designing, writing, performing in art, music, drama, etc.,).';
        que22 = '7. Develop specific skills, competencies, and points of view needed by professionals working in the field most closely related to this course.';
               
      //  Do you have any comments or suggestions to improve teaching effectiveness? 
        que31 = 'Do you have any comments or suggestions to improve teaching effectiveness?';
       Sque31 = 'What are your suggestions for improving the course?'; 
        
 // Sports Set of questions Start
        Sque1 = '1. Communication with players';
        Sque2 = '2. Organizational Skills';
        Sque3 = '3. Motivation of players/team';
        Sque4 = '4. Discipline of team/players';
        Sque5 = '5. Knowledge of the sport';
        Sque6 = '6. Prevention and care of injuries';
        Sque7 = '7. Attitude/conduct during games';
        Sque8 = '8. Attitude/conduct during practice';
        Sque9 = '9. Ability to teach skills';
        Sque10 = '10. Overall rating of coach'; 
 // Sports Set of questions End
 
 // Mid Term
       Mque1 = '1. How well does the faculty teach the course material? Are the faculty’s teaching methods and communication style helpful in understanding the concepts effectively?';
       Mque2 = '2. Is this faculty approachable and easy to communicate with? Is the faculty responsive to the learning difficulties of the student? Is he/she available during office hours or after class for additional help?'; 
       Mque3 = '3. Were descriptions and due dates for all assessment (except final submission/exam) available on Moodle within 2 weeks of the first class for this course?'; 
       Mque4 = '4. Was the course outline available on Moodle within 2 weeks of the first class for this course?';
       Mque5 = '5. So far this semester, is the course outline being followed?';
       Mque31 = '6. What in your opinion are the best aspects of the faculties teaching Style? Please explain.';
       Mque32 = '7. What in your opinion needs to be improved for effective learning in this course? Please explain.'; 
       Mque33 = '8. Describe 1-2 things that are already happening in class that you wish to continue. It can be something the faculty is doing, or something other students are doing.';
       Mque34 = '9. Describe 1-2 things you wish would stop in class. It can be something the faculty is doing, or something other students are doing.'; 
       Mque35 = '10. Describe 1-2 things you would like the Faculty to start doing in class or something you would like to do yourself in class. ';
       Mque36 = '11. Would you like to share any other feedback for the faculty?';
        
        }
    
    public list<SelectOption> getRadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','Hardly ever'));
        option.add(new SelectOption('2','Occasionally'));
        option.add(new SelectOption('3','Sometimes'));
        option.add(new SelectOption('4','Frequently'));
        option.add(new SelectOption('5','Almost always'));
        
        return option;
    }
    
     public list<SelectOption> getARadioOptions()
    {   
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','Strongly disagree'));
        option.add(new SelectOption('2','Disagree'));
        option.add(new SelectOption('3','Neutral'));
        option.add(new SelectOption('4','Agree'));
        option.add(new SelectOption('5','Strongly agree'));
    
        return option;
    }
  
    public list<SelectOption> getSRadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','1'));
        option.add(new SelectOption('2','2'));
        option.add(new SelectOption('3','3'));
        option.add(new SelectOption('4','4'));
        option.add(new SelectOption('5','5'));
        return option;
    }
    
    public list<SelectOption> getM1RadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('Yes','Yes'));
        option.add(new SelectOption('No','No'));
        return option;
    }
    
    public list<SelectOption> getM11RadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','1 Very unclear'));
        option.add(new SelectOption('2','2'));
        option.add(new SelectOption('3','3'));
        option.add(new SelectOption('4','4'));
        option.add(new SelectOption('5','5 Very clear'));
        return option;
    }
    
    public list<SelectOption> getM2RadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','1 Not helpful'));
        option.add(new SelectOption('2','2'));
        option.add(new SelectOption('3','3'));
        option.add(new SelectOption('4','4'));
        option.add(new SelectOption('5','5 Very helpful'));
        return option;
    }
    
    public list<SelectOption> getlabelRadioOptions()
    {
        list<SelectOption> option = new list<SelectOption>();
        option.add(new SelectOption('1','1'));
        option.add(new SelectOption('2','2'));
        option.add(new SelectOption('3','3'));
        option.add(new SelectOption('4','4'));
        option.add(new SelectOption('5','5'));
        return option;
    }
    
}