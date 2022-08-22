@RestResource(urlmapping='/mobilemessage/V1')
Global with sharing Class MobileMessagecls
{   

  /*   @HttpPost
    global static string CraeteMobileMessagePOST()
    {

       RestRequest req=Restcontext.request;
        RestResponse res =RestContext.response;     
        String requestedbody = req.requestBody.tostring();
        System.debug(':: request body ::' +requestedbody);


        wraperjsonclass wrpinput=(wraperjsonclass)System.JSON.deserialize(requestedbody,wraperjsonclass.class);
        System.debug(' :: Name ::' +wrpinput.tittle);

        List<Mobile_Notification__c> mmlist =new List<Mobile_Notification__c>();
        Mobile_Notification__c mm =new Mobile_Notification__c();
        mm.Name = wrpinput.tittle;
        mm.Message__c= wrpinput.Message; 
        mm.Status__c=wrpinput.status;          
        mm.Sent_Time__c=Wrpinput.Senttime;          
        mmlist.add(mm);
        
        if(!mmlist.IsEmpty())
        {
         insert mmlist;
        }
        
        return null; 

    }
    Class wraperjsonclass
    {
        Public String tittle;
        Public String Message;      
        Public Datetime Senttime;
        Public String status;
        
    }*/  
         
     
 }