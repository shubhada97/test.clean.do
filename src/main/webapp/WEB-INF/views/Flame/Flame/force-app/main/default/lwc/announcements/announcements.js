import { LightningElement,wire,track } from 'lwc';
import listOfAnnouncement from '@salesforce/apex/Get_FlameEvents_Records.listOfAnnouncement';
import {NavigationMixin} from 'lightning/navigation';

export default class Announcements extends NavigationMixin(LightningElement) {
    @track headings;
    @track listOfFlame=[];
    @wire(listOfAnnouncement) wiredEvents({ error, data }) {
   if(data){
    console.log(data);
    data.forEach((row)=>{
        this.listOfFlame.push({
            Id: row.Id,
            Heading: row.Heading__c,
            Content:row.Content__c,
            FirtsContent:row.Content__c.substring(0,100)
        })
    });
    console.log(JSON.stringify(this.listOfFlame));
   }
  }
  openFullPage(event){
    this[NavigationMixin.Navigate]({
        type: 'standard__webPage',
        attributes: {
            url: 'http://salesforcecasts.com'
        },
    });
  }
}