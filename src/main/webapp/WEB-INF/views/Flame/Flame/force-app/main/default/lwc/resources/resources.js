import { LightningElement } from 'lwc';
import searchKnowledge from '@salesforce/apex/ResourceClass.searchKnowledge';

export default class Resources extends LightningElement {
    
    showOnClickOfAcademic
    showOnClickOfCampus
    showOnClickOfERP
    showOnClickOfResearch
    showOnClickOfQuickLinks
    showOnClickOfKnowledgeBase

    handleAcedemic(){
        this.showOnClickOfAcademic = true
        this.showOnClickOfCampus = false
        this.showOnClickOfERP= false
        this.showOnClickOfResearch= false
        this.showOnClickOfQuickLinks= false
        this.showOnClickOfKnowledgeBase= false
    }
    
    handleCampus(){
        this.showOnClickOfAcademic = false
        this.showOnClickOfCampus = true
        this.showOnClickOfERP= false
        this.showOnClickOfResearch= false
        this.showOnClickOfQuickLinks= false
        this.showOnClickOfKnowledgeBase= false
    }
    handleERP(){
        this.showOnClickOfAcademic = false
        this.showOnClickOfCampus = false
        this.showOnClickOfERP= true
        this.showOnClickOfResearch= false
        this.showOnClickOfQuickLinks= false
        this.showOnClickOfKnowledgeBase= false
    }
    handleResearch(){
        this.showOnClickOfAcademic = false
        this.showOnClickOfCampus = false
        this.showOnClickOfERP= false
        this.showOnClickOfResearch= true
        this.showOnClickOfQuickLinks= false
        this.showOnClickOfKnowledgeBase= false
    }
    handleQuickLinks(){
        this.showOnClickOfAcademic = false
        this.showOnClickOfCampus = false
        this.showOnClickOfERP= false
        this.showOnClickOfResearch= false
        this.showOnClickOfQuickLinks= true
        this.showOnClickOfKnowledgeBase= false
    }
    handleKnowledgeBase(){
        this.showOnClickOfAcademic = false
        this.showOnClickOfCampus = false
        this.showOnClickOfERP= false
        this.showOnClickOfResearch= false
        this.showOnClickOfQuickLinks= false
        this.showOnClickOfKnowledgeBase= true
    }

    title
    storeTitle
    storeTitlenew
    handleKnowledgeBase1(event){
        this.title = event.target.value;
    }

    handleSearch(){
        searchKnowledge({Knowbase : this.title})
        .then(result=>{
            console.log('result of searchKnowledge'+JSON.stringify(result));
            this.storeTitle = result
            console.log('storeTitle of searchKnowledge'+JSON.stringify(this.storeTitle));
            console.log('storeTitle length'+JSON.stringify(this.storeTitle.length));
for(let index=0;index<=storeTitle.length;index++){
    this.storeTitlenew+=this.storeTitle[index];
}
        })
        .catch(error=>{
            console.log('error of searchKnowledge'+JSON.stringify(this.error));
        })
    }
}