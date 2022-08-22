public class UserCreation{
    @future(callout=true)
    public static void insertUserWithRole(ID conID,String fn,string ln,string coun,string st,string ci,string mob, string prog) {
        
        Contact c = new Contact(ID=conID);
        c.FirstName=fn;
        c.LastName=ln;
        //c.MailingCountryCode =coun;
        //C.OtherCountryCode=coun;
        //c.MailingStateCode=st;
        //c.OtherStateCode=st;
        c.MailingCity=ci;
        c.OtherCity=ci;
        c.MobilePhone=mob;
        c.Program_Interested__c=prog;
        
        try{
            update c;
        }
        catch(Exception e){}
    }
}