import { LightningElement,wire } from 'lwc';
import knowledge from '@salesforce/apex/KnowledgebaseClass.knowledge';

export default class KnowledgeBase extends LightningElement {

    DataValue
    @wire(knowledge)
    dataOfKnowledgebaseClass
    url
  handleURL(){
    debugger
    this.url = "https://www.google.com"; // get from processing apex response
    window.open(this.url, "_blank");
     
  }
   
}