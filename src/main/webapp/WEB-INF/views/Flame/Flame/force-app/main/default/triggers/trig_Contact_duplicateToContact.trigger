trigger trig_Contact_duplicateToContact on Contact (before insert, before update) 
{
  final String errMsg = 'Registration was not successful';
  
  Set< String > emailSet = new Set< String >();
  
  for( Contact c : Trigger.new ) { 
   emailSet.add(c.Email);
  }
 
  Map< String, Id > duplicateContactMap = new Map<String, Id>();
  
  if(Trigger.isInsert)
  {
      for( Contact c : [select Id, Email from Contact where Email in:emailSet AND (RecordType.DeveloperName = 'FU_Applicant' )]){
      duplicateContactMap.put(c.Email, c.Id);  
      }
      
      for( Contact c : Trigger.new ){
        Id duplicateContactId = duplicateContactMap.get(c.Email);
        if(duplicateContactId != null )
          c.addError( errMsg );
        }
  }     
}