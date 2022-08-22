public class generatePDFIDCardController {
	public String PDFData {get; set;} 
    
    public generatePDFIDCardController(){
        PDFData = '';
    }
    
    public PageReference downloadPDF(){
        System.PageReference pageRef = new System.PageReference('/apex/PDFGenerator');
    
        //ensure pdf downloads and is assigned with defined name
        pageRef.getHeaders().put('content-disposition', 'attachment; filename=TestPDF.pdf');
     
        return pageRef;
    }
}