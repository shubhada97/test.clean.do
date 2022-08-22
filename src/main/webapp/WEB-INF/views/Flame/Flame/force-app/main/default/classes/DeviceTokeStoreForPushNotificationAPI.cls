@RestResource(urlMapping='/deviceToken')
global class DeviceTokeStoreForPushNotificationAPI {
    
    @HttpPost
    global static void doGetAndSaveDeviceToken(String deviceId, String deviceToken, String userName) {
        
        String Status;
        List<Device_Token__c> dtRecordList = [select id, name, deviceId__c, device_token__c, username__c 
                                              from device_token__c where userName__c =:userName and deviceId__c =:deviceId];
        system.debug('dtRecordList-->'+dtRecordList);
        system.debug('userName-->'+userName);
        user u = [select id,name,username from user where userName =:userName];
        system.debug('user-->'+u);
        System.debug('dtRecordList-->'+dtRecordList);
        System.debug('deviceId-->'+deviceId);
        System.debug('deviceToken-->'+deviceToken);
        try{
            if(dtRecordList.size() >0){
                system.debug('update');
                dtRecordList[0].deviceId__c = deviceId;
                dtRecordList[0].Device_Token__c = deviceToken;
                dtRecordList[0].UserName__c = userName;
                dtRecordList[0].user__c = u.Id;
                update dtRecordList;
                status = 'Update';
                system.debug('status-->'+status);
                
            }
            else{
                system.debug('insert');
                Device_Token__c dt  = new Device_Token__c();
                dt.DeviceId__c      = deviceId;
                dt.Device_Token__c  = deviceToken;
                dt.UserName__c      = userName;
                dt.User__c          = u.Id;
                // dt.Test__c          = test;
                insert dt;
                status = 'Insert';
                system.debug('status-->'+status);
            }
            
        }
        catch(DmlException de){
            System.Debug('Exception..'+de.getMessage());
            
        }
        RestResponse res = RestContext.response;
        res.addheader('Content-Type', 'application/json'); //application/json
        
        // RestContext.response = res;
        
        res.responseBody =  Blob.valueOf(JSON.serializePretty(status)); 
        // return res.responseBody;
    }
    
}