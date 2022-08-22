public class BookArrivalSlot {
    
       public String Page {get; set;}
    public String OpenPageURL {get; set;}
     public Boolean shouldRedirect {public get; private set;}
    
    public void BookArrivalSlot()
    {
        Page = '' ;
        OpenPageURL = '' ;
    }
    
    public void redirect()
    {
     //   if(Page == 'google')
     //   {
            String Work_Relay_Form = Label.Work_Relay_Forms;
            OpenPageURL = ''+ Work_Relay_Form +'/apex/WR_BPM__DataEditLtng?formId=a4T0K00000WRX5BUAX';
              //  OpenPageURL = 'https://techila-flame.cs74.force.com/0030p00000OgM0F';
     //   }
    }
    
    public PageReference validateAndRedirect(){
        shouldRedirect = true;
        String Work_Relay_Form = Label.Work_Relay_Forms;
   //     OpenPageURL = ''+ Work_Relay_Form +'/apex/WR_BPM__DataEditLtng?formId=a4T0K00000WRX5BUAX';
        OpenPageURL = ''+ Work_Relay_Form +'/apex/WR_BPM__DataEditLtng?formId=a4T0p000000NyMQEA0';
        return null;
      //Write your logic here and redirect
     // PageReference retURL = new PageReference(OpenPageURL);
     // retURL.setRedirect(true);
     // return retURL;

 }

}