public class MedianCalculator {
    /*public static boolean isRecursive = false;
    @future
    public static void updateMedian() 
    {
        List<Competition_Exam_Details__c> MedianLst = new List<Competition_Exam_Details__c>();
        List<Competition_Exam_Details__c> CompetitionExamsLst = [Select ID,Total_SAT_Score__c From Competition_Exam_Details__c Where Total_SAT_Score__c >= 0 ORDER BY Total_SAT_Score__c ASC];
        
        Integer sizeOfList = CompetitionExamsLst.size();
        system.debug('size of list is '+ sizeOfList);
        Integer index = sizeOfList - 1;
        system.debug('index is '+ index);
        if (Math.mod(sizeOfList, 2) == 0) 
        {
        MedianLst.add(CompetitionExamsLst.get((index-1)/2));
        MedianLst.add(CompetitionExamsLst.get((index/2)+1));
        }
        else
        {
        MedianLst.add(CompetitionExamsLst.get((index+1)/2));
        }
        for(Competition_Exam_Details__c CED : MedianLst)
        {
            CED.FUA_Median__c = True;
        }
        isRecursive = true;
        update MedianLst;
        
        List<Competition_Exam_Details__c> LstOfMedianUnchecked = [Select ID,FUA_Median__c From Competition_Exam_Details__c
                                                                    Where ID NOT IN :MedianLst];
        for(Competition_Exam_Details__c SAT : LstOfMedianUnchecked )
        {
            SAT.FUA_Median__c = False;
        }
        update LstOfMedianUnchecked;
    }
    
    public static boolean isRecursiveCall()
    {
        system.debug('isRecursive ==>'+isRecursive);
        if(isRecursive == false) 
        {
            isRecursive = true;
            return false;
        }
        return true;
    } */
}