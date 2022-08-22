import { LightningElement,wire } from 'lwc';
import getfollowers from '@salesforce/apex/ChatterController.getfollowers';
export default class Followers extends LightningElement {

    getfollowers

    
    followingList = [];
    size;
   

    @wire (getfollowers) wiredFollowers({data,error}){
        if (data) {
            this.followingList=data;
this.size=data.length
        console.log("Data:"+data.Name); 
        console.log("List:"+this.followingList); 
        console.log('values-->'+data.length);
        console.log('size-->'+this.size);
        } else if (error) {
        console.log(error);
        }
   }


}