import { LightningElement, track, wire } from 'lwc';
import getCollaborationGroup from '@salesforce/apex/MyGroupController.getCollaborationGroup';

import listOfAnnouncement from '@salesforce/apex/Get_FlameEvents_Records.listOfAnnouncement';
import {NavigationMixin} from 'lightning/navigation';
import listOfNews from '@salesforce/apex/Get_FlameEvents_Records.listOfNews';
export default class VerticalNavBarCommunity extends LightningElement {

//news
  
// constructor() {
//     super();
//     const style = document.createElement('style');
//     // below you specify the CSS selector to be changed in the combobox
//     style.innerText = `
//     .slds-nav-vertical__action-text{
//         display: none !important;
//       }
//      `;
//     document.querySelector('head').appendChild(style);
// }


// constructor() {
//     super();
//     var sunDay =  $(".container span:contains('Sunday')");
//     sunDay.hide();
//     sunDay.parent('a').html(sunDay.parent('a').html()+'<span>Sun</span>');
    
     
// }


    //announcements
    @track headings;
    @track listOfFlame=[];

    //Main
    @track selectedItem = 'feed';
    @track currentContent = 'feed';
    @track updatedCount = 12;
    size;


    @track feedValue = false;  
    @track eventsValue = false;    
    @track announcementsValue = false;
    @track newsValue = false;
    @track savedValue = false;
 
    @track my_profileValue = false;



    handleSelect(event) {
        const selected = event.detail.name;
        this.currentContent = selected;

        if (selected == 'feed'){
            this.feedValue = true;
        }else{
            this.feedValue = false;
        }
 
        if (selected == 'events'){
            this.eventsValue = true;
        }else{
            this.eventsValue = false;
        }
 
        if (selected == 'announcements'){
            this.announcementsValue = true;
        }else{
            this.announcementsValue = false;
        }
 
        if (selected == 'news'){
            this.newsValue = true;
        }else{
            this.newsValue = false;
        }
 
        if (selected == 'my_profile'){
            this.my_profileValue = true;
        }else{
            this.my_profileValue = false;
        }
 
        if (selected == 'saved'){
            this.savedValue = true;
        }else{
            this.savedValue = false;
        }



    }


    groupList = [];
   

    @wire (getCollaborationGroup) wiredAccounts({data,error}){
        if (data) {
            this.groupList=data;
            this.size=data.length;
        console.log("Data:"+data); 
        console.log("List:"+this.groupList); 
        } else if (error) {
        console.log(error);
        }
   }



   //Get News

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

 //Get Announcements

 
    @wire(listOfAnnouncement) wiredAnnouncements({ error, data }) {
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