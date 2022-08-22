import { api, wire, LightningElement } from 'lwc';
import getContactRecords from '@salesforce/apex/printIdCardComponentCtrl.getContactRecords';
import downloadPDF from '@salesforce/apex/printIdCardComponentCtrl.getPDFprint';
import PDFLib from "@salesforce/resourceUrl/pdflib";
import { loadScript } from "lightning/platformResourceLoader";

export default class PrintIDCardComponent extends LightningElement {
    @api recordIds;
    contactList;
    error;
    strFile;
    pdfString;


     renderedCallback(){
         loadScript(this,PDFLib)
        .then(()=>console.log('Script loaded'))
        .catch(error => console.log(error));
       }


    generatePdf(){
        downloadPDF({}).then(response => {
            console.log('response==>'+response[0]);
            this.strFile = "data:application/pdf;base64,"+response[0];
            window.open(response[1]);
       }).catch(error => {
            console.log('Error:' +error.body.message);
       });
    }
}