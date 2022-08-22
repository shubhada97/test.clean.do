public class testClassupload {
    public transient String base64;
  //  public Case c;
    public String getBase64()
    {
        return base64;
    }
    public void setbase64(String base64)
    {
        this.base64 = base64;
    }
    public String fileName {get; set;}
    public testClassupload()
    {
        
    }
    public void saveFile()
    {
        Attachment a = new Attachment(parentId = 'a2h0p0000004q4pAAA', Body =  EncodingUtil.base64Decode(base64), name = fileName);
        insert a;
    }
        
}