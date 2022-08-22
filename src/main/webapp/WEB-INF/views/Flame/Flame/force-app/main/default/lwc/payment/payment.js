import { LightningElement, wire,track } from 'lwc';
import payment from '@salesforce/apex/PaymentClass.payment';
// const columns = [
//     { label: 'Paid By', fieldName: 'Paid_By' },
//     { label: 'Payment Date', fieldName: 'Payment_Date' },
//     { label: 'FUA Amount', fieldName: 'FUA_Amount'},
//     { label: 'Fee Type', fieldName: 'Fee_Type'}
// ]   

export default class Payment extends LightningElement {
    // data = [];
    // columns = columns;
    // dataName;
    // @wire(payment)
    // wirePaymetData({error, data}){
    //     if(data){
    //         console.log('Data from wire ==> '+JSON.stringify(data));
    //         this.dataName = data[0].Paid_By__c
    //         console.log('Value of ===> '+this.dataName);
    //         this.data = data;
    //     }
    //     else if(error){
    //         console.log('Data from wire ==> '+JSON.stringify(error));
    //     }
    // }

    // dataPaymet =[
    //     {Paid_By: this.dataName}
    // ]

    @track columns = [{
        label: 'Academic Year',
        fieldName: 'Academic_Year__c',
       
    },
    {
        label: 'Amount',
        fieldName: 'Amount__c',
        
    },
    {
        label: ' Contact',
        fieldName: 'Contact__c',
        
    },
    {
        label: 'Fee Type',
        fieldName: 'Fee_Type__c',
        
    },
    {
        label: 'Record Type',
        fieldName: 'RecordTypeId',
        
        
    },
    {
        label: 'Type',
        fieldName: 'Type__c',
        
    }
    
];

@track error;
    @track payList ;
    pList
    @wire(payment)
    wirePaymetData({error, data}){
        if(data){
            console.log('Data from wire ==> '+JSON.stringify(data));
            console.log('Data from wire ==> '+data);
            this.pList = data.map(row=>{
              return{...row,RecordTypeId : row.RecordTypeId__r.Name}
                 })
           
            this.payList = data;
            console.log('accList from wire 111 ==> '+JSON.stringify(this.payList));
        }
        else if(error){
            console.log('error from wire ==> '+JSON.stringify(error));

            this.error = error;
        }
    }
    
}