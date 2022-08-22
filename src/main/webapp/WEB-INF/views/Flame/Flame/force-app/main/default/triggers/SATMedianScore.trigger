trigger SATMedianScore on Competition_Exam_Details__c(after insert,after update,after delete) 
{
    /*if(!MedianCalculator.isRecursiveCall()) {
       MedianCalculator.updateMedian();
    }*/
}