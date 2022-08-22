trigger updateGeolocationsTrigger on Contact (after insert, after update) {
  
    Set<Id> listOfConIds=new Set<Id>();

if(Trigger.isAfter && Trigger.isUpdate){

        for(Contact con:Trigger.New){
        
            if(con.GoogleLatitude__c ==null || con.GoogleLongitude__c == null){
        
            listOfConIds.add(con.id);
        system.debug('listOfConIds-->'+listOfConIds);
            geolocationCallout.newAccmethod(listOfConIds);

}

}



}

}