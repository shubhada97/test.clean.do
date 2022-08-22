public with sharing class FileUploadPOCController {
     
    @AuraEnabled
    public static Id SaveFile(Id parentId, String fileName, String base64Data, String contentType) {
        System.debug('parentId::'+parentId);
        System.debug('fileName::'+fileName);
        System.debug('contentType::'+contentType);
        System.debug('base64Data::'+base64Data);
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment attach = new Attachment();
        attach.parentId = parentId;
        attach.Body = EncodingUtil.base64Decode(base64Data);
        attach.Name = fileName;
        attach.ContentType = contentType;
        insert attach;
        return '1';
    }
}