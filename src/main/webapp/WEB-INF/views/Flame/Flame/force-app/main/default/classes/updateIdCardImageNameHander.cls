public class updateIdCardImageNameHander {
    
    public static void updateName(List<ContentVersion> newList){
        List<ContentVersion>  addedrecord  = new List<ContentVersion>();
    	for(ContentVersion cv: newList){
            system.debug('cv Id'+cv.Id);
            if(cv.Title != ''){
               //ContentVersion prop = new ContentVersion(Id = cv.Id);
               String newName = cv.Title;
               System.debug('newName'+cv.Title);
               Integer intIndex = newName.indexOf('.');
               Integer lasCharLen = newName.length()-intIndex;
               //System.debug('New length'+newName.substring(0,newName.length()-lasCharLen));
               cv.Title = newName.substring(0,newName.length()-lasCharLen);
               //addedrecord.add(cv);
               update newList;
               //System.debug('Addedrecord'+addedrecord);
             } 
          }
      //if(!addedrecord.isEmpty()){
         //update addedrecord;
     // }
	}
}