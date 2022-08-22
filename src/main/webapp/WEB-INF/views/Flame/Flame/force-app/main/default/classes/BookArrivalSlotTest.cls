@isTest
public class BookArrivalSlotTest {
   
    
   public string  OpenPageURL = 'https://my.flame.edu.in/apex/WR_BPM__DataEditLtng?formId=a4T0K00000WRX5BUAX';
   public static testMethod void BookArrivalSlotTest() {
       BookArrivalSlot objbAS = new BookArrivalSlot();
        objbAS.redirect();
      	objbAS.validateAndRedirect();
        objbAS.BookArrivalSlot();
    }
}