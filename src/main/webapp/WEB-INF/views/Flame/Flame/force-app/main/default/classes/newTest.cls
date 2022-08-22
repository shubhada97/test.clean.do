public class newTest {

    	public static void testMethodData() {
            Datetime systemDate = System.now()-1;
            String timeDate = systemDate.format('yyyy-MM-dd');
            Date todayDate = Date.Today();
			todayDate = todayDate-1;
            
            String rawTimelog1 = timeDate+' 01:00:00';
        	String rawTimelog2 = timeDate+' 23:59:50';
            System.debug('rawTimelog1:'+rawTimelog1);
            System.debug('rawTimelog2:'+rawTimelog2);
            
            Datetime punchOutTime = Datetime.valueOfGmt(rawTimelog1);
            Datetime punchInTime = Datetime.valueOfGmt(rawTimelog2);
			//punchOutTime = punchOutTime-1;
            //punchInTime = punchInTime-1;
            
            System.debug('punchOutTime:'+punchOutTime);
            System.debug('punchInTime:'+punchInTime);
          
        }
}