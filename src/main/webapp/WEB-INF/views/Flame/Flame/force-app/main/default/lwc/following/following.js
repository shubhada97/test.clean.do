import { LightningElement, api,wire } from 'lwc';
import getfollowing from '@salesforce/apex/ChatterController.getfollowing';
export default class Following extends LightningElement {

    
    followingList = [];
    size;
   

    @wire (getfollowing) wiredAccounts({data,error}){
        if (data) {
            this.followingList=data;
this.size=data.length
        console.log("Data:"+data); 
        console.log("List:"+this.followingList); 
        console.log('values-->'+data.length);
        console.log('size-->'+this.size);
        } else if (error) {
        console.log(error);
        }
   }


}