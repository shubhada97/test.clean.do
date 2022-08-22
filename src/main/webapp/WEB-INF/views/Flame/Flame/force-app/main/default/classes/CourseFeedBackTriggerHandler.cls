public class CourseFeedBackTriggerHandler {
    
    private boolean Image = True;
    private integer BatchSize = 0;
  
    public CourseFeedBackTriggerHandler(boolean isExecuting, integer size)
    {
        Image = isExecuting;
        BatchSize = size;
    }
    
    public void OnBeforeUpdate(list<Course_feedback__c> triggerNew, map<id,Course_feedback__c> triggerNewMap, map<id,Course_feedback__c> triggerOldMap)
    {
       // call Before update Method
       updateCourseOfferingCAIA(triggerNew,triggerNewMap); 
       
    }
    
    public void OnAfterInsert(list<Course_feedback__c> triggerNew, map<id,Course_feedback__c> triggerNewMap)
    {
        // call After Insert Method
         updateCourseOfferingCAIA(triggerNew,triggerNewMap);
    }
    
    public void OnAfterDelete(list<Course_feedback__c> triggerOld, map<id,Course_feedback__c> triggerOldMap)
    {
        // call After Insert Method
         updateCourseOfferingCAIA(triggerOld,triggerOldMap);
    }
    
    private void updateCourseOfferingCAIA(list<Course_feedback__c> lstofCourseFeedback ,map<id,Course_feedback__c> mapofIdToCoursefeedback)
    {
        map < Id, hed__Course_Offering__c > mapofIdToCourseOff = new map < id, hed__Course_Offering__c > ();
        set < Id > setofCourseOfferingId = new set < id > ();
        list < hed__Course_Offering__c > lstofCourseoffering = new list < hed__Course_Offering__c > ();
        list < hed__Course_Offering__c > updatelstofCourseoffering = new list < hed__Course_Offering__c > ();
        set < id > setofCouseofferingId = new set < id > ();

        //Primary Faculty 
         Decimal PFCFMIDIA = 0.0;
         Decimal PFCFMIDCA = 0.0;
        Decimal PFCFEIDIA = 0.0;
        Decimal PFCFEIDCA = 0.0;
        Integer countPFCFMIDIA = 0;
        Integer countPFCFMIDCA = 0;
        Integer countPFCFEIDIA = 0;
        Integer countPFCFEIDCA = 0;
        Integer PFMidTermResponseCount = 0;
        Integer PFEndTermResponseCount = 0;

        //Secondary Faculty 
        Decimal SFCFMIDIA = 0.0;
        Decimal SFCFMIDCA = 0.0;
        Decimal SFCFEIDIA = 0.0;
        Decimal SFCFEIDCA = 0.0;
        Integer countSFCFMIDIA = 0;
        Integer countSFCFMIDCA = 0;
        Integer countSFCFEIDIA = 0;
        Integer countSFCFEIDCA = 0;
        Integer SFMidTermResponseCount = 0;
        Integer SFEndTermResponseCount = 0;


        //Third Faculty 
        Decimal TFCFMIDIA = 0.0;
        Decimal TFCFMIDCA = 0.0;
        Decimal TFCFEIDIA = 0.0;
        Decimal TFCFEIDCA = 0.0;
        Integer countTFCFMIDIA = 0;
        Integer countTFCFMIDCA = 0;
        Integer countTFCFEIDIA = 0;
        Integer countTFCFEIDCA = 0;

        Integer TFMidTermResponseCount = 0;
        Integer TFEndTermResponseCount = 0;

        //Fourth Faculty 
        Decimal FFCFMIDIA = 0.0;
        Decimal FFCFMIDCA = 0.0;
        Decimal FFCFEIDIA = 0.0;
        Decimal FFCFEIDCA = 0.0;
        Integer countFFCFMIDIA = 0;
        Integer countFFCFMIDCA = 0;
        Integer countFFCFEIDIA = 0;
        Integer countFFCFEIDCA = 0;

        Integer FFMidTermResponseCount = 0;
        Integer FFEndTermResponseCount = 0;
    
   
        for (Course_feedback__c objCF: lstofCourseFeedback) {
            if (objCF.Course_Offering__c != null) {
                setofCourseOfferingId.add(objCF.Course_Offering__c);
            }

        }
        System.debug('setofCourseOfferingId@@' + setofCourseOfferingId);

        if (setofCourseOfferingId != null && setofCourseOfferingId.size() > 0) {

            for (hed__Course_Offering__c objCourseoffering: [Select Id, PFCF_EndTerm_IA__c, PFCF_EndTerm_CA__c,
                    PFCF_MidTerm_IA__c, PFCF_MidTerm_CA__c, SFCF_EndTerm_IA__c, SFCF_EndTerm_CA__c, SFCF_MidTerm_IA__c,
                    SFCF_MidTerm_CA__c,PF_MidTerm_Response_Count__c,PF_EndTerm_Response_Count__c,SF_MidTerm_Response_Count__c,SF_EndTerm_Response_Count__c,TF_MidTerm_Response_Count__c,TF_EndTerm_Response_Count__c,FF_MidTerm_Response_Count__c,FF_EndTerm_Response_Count__c from hed__Course_Offering__c where ID IN: setofCourseOfferingId
                ]) {
                mapofIdToCourseOff.put(objCourseoffering.ID, objCourseoffering);
            }
        }
        System.debug('mapofIdToCourseOff@@' + mapofIdToCourseOff);
   

        if (mapofIdToCourseOff != null && mapofIdToCourseOff.size() > 0) {
            for (Course_feedback__c objCF: [Select Id, Primary_Faculty__c, Secondary_Faculty__c, Third_Faculty__c,
                    Fourth_Faculty__c, Course_Offering__c, MidTerm_Instructor_Average__c, MidTerm_Course_Average__c,
                    EndTerm_Instructor_Average__c, EndTerm_Course_Average__c, End_Type__c from Course_feedback__c
                    where Course_Offering__c IN: mapofIdToCourseOff.keyset()
                ]) {
                hed__Course_Offering__c objCourseOff = mapofIdToCourseOff.get(objCF.Course_Offering__c);

                /* >>>>>>>>>>Primary Faculty Calculation >>>>>>>>>>>>*/
                
                // Primary Faculty MidTerm IA/CA

                if (objCF.End_Type__c == 'MidTerm' && objCF.Primary_Faculty__c != null) {
                    
                    objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                    
                    if(objCF.MidTerm_Instructor_Average__c != null){
                        
                         countPFCFMIDIA ++;
                        PFCFMIDIA = PFCFMIDIA + objCF.MidTerm_Instructor_Average__c;
                        objCourseOff.PFCF_MidTerm_IA__c = PFCFMIDIA/countPFCFMIDIA;
                    }
                    
                    if(objCF.MidTerm_Course_Average__c != null){
                        
                          countPFCFMIDCA++;
                        PFCFMIDCA = PFCFMIDCA + objCF.MidTerm_Course_Average__c;
                        objCourseOff.PFCF_MidTerm_CA__c = PFCFMIDCA/countPFCFMIDCA;
                    }
                    
                    
                    PFMidTermResponseCount++;
                    objCourseOff.PF_MidTerm_Response_Count__c = PFMidTermResponseCount;
                       
                
                }
                // Primary Faculty EndTerm IA
                if (objCF.End_Type__c == 'EndTerm' && objCF.Primary_Faculty__c != null ) {
                    
                    objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                    
                    if(objCF.EndTerm_Instructor_Average__c != null){
                        
                        countPFCFEIDIA ++;
                        PFCFEIDIA = PFCFEIDIA + objCF.EndTerm_Instructor_Average__c;
                        objCourseOff.PFCF_EndTerm_IA__c = PFCFEIDIA/countPFCFEIDIA;
                    }
                    
                    if(objCF.EndTerm_Course_Average__c != null){
                        
                        countPFCFEIDCA ++;
                         PFCFEIDCA = PFCFEIDCA + objCF.EndTerm_Course_Average__c;
                        objCourseOff.PFCF_EndTerm_CA__c = PFCFEIDCA/countPFCFEIDCA;
                    }
                    
                    PFEndTermResponseCount++;
                    objCourseOff.PF_EndTerm_Response_Count__c = PFEndTermResponseCount;
                       

                }
                
               
                
                /* >>>>>>>>>>Second Faculty Calculation >>>>>>>>>>>>*/
                
                  // Second Faculty MidTerm IA/CA
                  
                if (objCF.End_Type__c == 'MidTerm' && objCF.Secondary_Faculty__c != null) {
                    
                    objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                    
                    if(objCF.MidTerm_Instructor_Average__c != null){
                        countSFCFMIDIA ++;
                        SFCFMIDIA = SFCFMIDIA + objCF.MidTerm_Instructor_Average__c;
                        objCourseOff.SFCF_MidTerm_IA__c = SFCFMIDIA/countSFCFMIDIA;

                        
                    }
                    
                    if(objCF.MidTerm_Course_Average__c != null){
                        countSFCFMIDCA ++;
                        SFCFMIDCA = SFCFMIDCA + objCF.MidTerm_Course_Average__c;
                        objCourseOff.SFCF_MidTerm_CA__c = SFCFMIDCA/countSFCFMIDCA;

                        
                    }
                    
                     SFMidTermResponseCount++;
                    objCourseOff.SF_MidTerm_Response_Count__c = SFMidTermResponseCount;
                       
                }
                
                
                // Second Faculty EndTerm IA/CA
                
                if (objCF.End_Type__c == 'EndTerm' && objCF.Secondary_Faculty__c != null) {
                    
                    objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                    
                    if(objCF.EndTerm_Instructor_Average__c != null){
                        countSFCFEIDIA ++;
                        SFCFEIDIA = SFCFEIDIA + objCF.EndTerm_Instructor_Average__c;
                        objCourseOff.SFCF_EndTerm_IA__c = SFCFEIDIA/countSFCFEIDIA;
                    }
                    
                    if(objCF.EndTerm_Course_Average__c != null){
                        countSFCFEIDCA ++;
                        SFCFEIDCA = SFCFEIDCA + objCF.EndTerm_Course_Average__c;
                        objCourseOff.SFCF_EndTerm_CA__c = SFCFEIDCA/countSFCFEIDCA;
                    }
                    
                    SFEndTermResponseCount++;
                    objCourseOff.SF_EndTerm_Response_Count__c = SFEndTermResponseCount;
                       

                }
                
               
                /* >>>>>>>>>>Third Faculty Calculation >>>>>>>>>>>>*/
                
                // Third Faculty MidTerm IA/CA
                if (objCF.End_Type__c == 'MidTerm' && objCF.Third_Faculty__c != null ) {
                    
                    objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                    
                    if(objCF.MidTerm_Instructor_Average__c != null){
                        
                        countTFCFMIDIA ++;
                        
                        TFCFMIDIA = TFCFMIDIA + objCF.MidTerm_Instructor_Average__c;
                        objCourseOff.TFCF_MidTerm_IA__c = TFCFMIDIA/countTFCFMIDIA;
                        
                    }
                    
                    if(objCF.MidTerm_Course_Average__c != null){
                        
                        countTFCFMIDCA ++;
                        
                         TFCFMIDCA = TFCFMIDCA + objCF.MidTerm_Course_Average__c;
                        objCourseOff.TFCF_MidTerm_CA__c = TFCFMIDCA/countTFCFMIDCA;
                        
                    }
                    
                    TFMidTermResponseCount++;
                    objCourseOff.TF_MidTerm_Response_Count__c = TFMidTermResponseCount;
                       

                }
                
                
                // Third Faculty EndTerm IA/CA
                if (objCF.End_Type__c == 'EndTerm' && objCF.Third_Faculty__c != null ) {
                    
                     objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                     
                     if(objCF.EndTerm_Instructor_Average__c != null){
                        countTFCFEIDIA ++;
                        TFCFEIDIA = TFCFEIDIA + objCF.EndTerm_Instructor_Average__c;
                        objCourseOff.TFCF_EndTerm_IA__c = TFCFEIDIA/countTFCFEIDIA;
                     }
                     
                     if(objCF.EndTerm_Course_Average__c != null){
                        countTFCFEIDCA ++;
                        TFCFEIDCA = TFCFEIDCA + objCF.EndTerm_Course_Average__c;
                        objCourseOff.TFCF_EndTerm_CA__c = TFCFEIDCA/countTFCFEIDCA;
                     }
                     
                     TFEndTermResponseCount++;
                    objCourseOff.TF_EndTerm_Response_Count__c = TFEndTermResponseCount; 
                    
                   
                }
                
              
                /* >>>>>>>>>>Fourth Faculty Calculation >>>>>>>>>>>>*/
                
                // Fourth Faculty MidTerm IA/CA
                if (objCF.End_Type__c == 'MidTerm' && objCF.Fourth_Faculty__c != null && objCF.MidTerm_Instructor_Average__c != null) {
                      objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                      
                    if(objCF.MidTerm_Instructor_Average__c != null){
                        
                        countFFCFMIDIA ++;
                        FFCFMIDIA = FFCFMIDIA + objCF.MidTerm_Instructor_Average__c;
                        objCourseOff.FFCF_MidTerm_IA__c = FFCFMIDIA/countFFCFMIDIA;
                        
                    }
                    
                    if(objCF.MidTerm_Course_Average__c != null){
                        
                        countFFCFMIDCA ++;
                         FFCFMIDCA = FFCFMIDCA + objCF.MidTerm_Course_Average__c;
                        objCourseOff.FFCF_MidTerm_CA__c = FFCFMIDCA/countFFCFMIDCA;
                        
                    }
                    
                    FFMidTermResponseCount++;
                    objCourseOff.FF_MidTerm_Response_Count__c = FFMidTermResponseCount;
                       

                }
                
                
                
                // Fourth Faculty EndTerm IA/CA
                if (objCF.End_Type__c == 'EndTerm' && objCF.Fourth_Faculty__c != null) {
                    
                       objCourseOff.Id = mapofIdToCourseOff.get(objCF.Course_Offering__c).id;
                       
                    if(objCF.EndTerm_Instructor_Average__c != null){
                        countFFCFEIDIA ++;
                        FFCFEIDIA = FFCFEIDIA + objCF.EndTerm_Instructor_Average__c;
                        objCourseOff.FFCF_EndTerm_IA__c = FFCFEIDIA/countFFCFEIDIA;
                    }
                    
                    if(objCF.EndTerm_Course_Average__c != null){
                        countFFCFEIDCA ++;
                         FFCFEIDCA = FFCFEIDCA + objCF.EndTerm_Course_Average__c;
                        objCourseOff.FFCF_EndTerm_CA__c = FFCFEIDCA/countFFCFEIDCA;
                    }
                    
                    FFEndTermResponseCount++;
                    objCourseOff.FF_EndTerm_Response_Count__c = FFEndTermResponseCount;

                }
                
                
                lstofCourseoffering.add(objCourseOff);
                
            }
        }

        System.debug('lstofCourseoffering@@' + lstofCourseoffering);
        if(lstofCourseoffering != null && lstofCourseoffering.size()>0){
            for(hed__Course_Offering__c objCourseOff : lstofCourseoffering){
                
                if(!setofCouseofferingId.contains(objCourseOff.ID)){
                    setofCouseofferingId.add(objCourseOff.ID);
                    updatelstofCourseoffering.add(objCourseOff);
                }
                
            }
        }
        if(updatelstofCourseoffering != null && updatelstofCourseoffering.size()>0){
             update updatelstofCourseoffering;
        }   
    }
 
}