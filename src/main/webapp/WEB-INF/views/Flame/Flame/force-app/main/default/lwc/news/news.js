import { LightningElement,track,wire} from 'lwc';
import listOfNews from '@salesforce/apex/Get_FlameEvents_Records.listOfNews';

export default class News extends LightningElement {
    
    @track listOfFlameNews=[];

    @wire(listOfNews) wiredEvents({ error, data }) {
   if(data){
    console.log(data);
    data.forEach((row)=>{
        this.listOfFlameNews.push({
            Id: row.Id,
            Heading: row.Heading__c,
            Content:row.Content__c,
            FirtsContent:row.Content__c.substring(0,100)
        })
    });
    console.log(JSON.stringify(this.listOfFlameNews));
   }
  }
}