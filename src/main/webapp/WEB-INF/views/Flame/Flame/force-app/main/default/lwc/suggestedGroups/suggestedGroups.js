import { LightningElement,wire } from 'lwc';
import getCollaborationGroup from '@salesforce/apex/MyGroupController.getCollaborationGroup';
export default class SuggestedGroups extends LightningElement {

    groupList = [];
   

    @wire (getCollaborationGroup) wiredAccounts({data,error}){
        if (data) {
            this.groupList=data;
        console.log("Data:"+data); 
        console.log("List:"+this.groupList); 
        } else if (error) {
        console.log(error);
        }
   }
}