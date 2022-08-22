import { api, wire, LightningElement } from 'lwc';
import getContactRecords from '@salesforce/apex/uploadIdCardComponentCtrl.getContactRecords'
//import saveTheChunkFile from '@salesforce/apex/uploadIdCardComponentCtrl.saveTheChunkFile';

import getSFBaseURL from '@salesforce/apex/uploadIdCardComponentCtrl.getSFBaseURL';
import getAccessToken from '@salesforce/apex/uploadIdCardComponentCtrl.getAccessToken';
//import changeFileProps from '@salesforce/apex/uploadIdCardComponentCtrl.changeFileProps';
import changeFileProps2 from '@salesforce/apex/uploadIdCardComponentCtrl.changeFileProps2';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const MAX_FILE_SIZE = 9000000;
const CHUNK_SIZE = 1400000;

export default class UploadIdCardComponent extends LightningElement {
    @api recordIds;
    contactList;
    error;
    showLoadingSpinner = false;
    showUploadIcon = false;
    fileNames = '';
    filesUploaded = [];
    dataArray = [];
    dataVal = {};
    fileName = '';

    sfURL;
    access_token;
    base64result = '';
    contactId;
    uploadedFileId;
    fileType;
    totalIds;
    dataIndex;
    dataurl;

    conIdToCVIdObjArr = [];
    currentConIdToCVId = {};

    @wire(getContactRecords, {'ContactIds': '$recordIds'})
    wiredGetContactRecords({data, error}){
        
        console.log('error:'+JSON.stringify(error));
        if(data){
            this.contactList = data;
          
        }
        else if(error){
            this.error = error;
        }
    }

    connectedCallback(){
        this.getAccessToken();
        this.getBaseURL();    
    }

    backPage(){
        var preUrl = document.referrer;
        console.log('preUrl'+preUrl);
        window.history.go(-1); 
        return false;
    }

    getAccessToken(){
        getAccessToken()
        .then(data => {
            console.log('access token ', data); 
            this.access_token = data;   
        })
        .catch(error => {
            console.error('Error: ', error);
        });

    }

    getBaseURL(){
        var sfURL;
        getSFBaseURL()
        .then(data => {
            this.sfURL = data;
            // this.makeCallout();    
        })
        .catch(error => {
            console.error('Error: ', error);
        });
    }

    submitAll(){
      if(this.conIdToCVIdObjArr.length>0){
        this.showLoadingSpinner = true;
        changeFileProps2({
            arrayData: this.conIdToCVIdObjArr,
        })
        .then(data => {
           console.log('data'+data);
           this.showLoadingSpinner = false;
           alert('Record Saved successfully');
           window.location.reload();
       })
        .catch(error => {
           console.error('Error: ', error);
        });
      }else{
         alert('Please upload atleast one file in contact record');
         return false;
      }
        
    }

    makeCallout(contactId){
        console.log('Inside makeCallout', contactId); 
        let badgeClass = this.template.querySelectorAll('h5');
        let spinner = this.template.querySelectorAll('lightning-spinner');
        let headBlock = this.template.querySelectorAll('h4');
        let errorBlock = this.template.querySelectorAll('h3');
          
        var endpoint = this.sfURL + '/services/data/v54.0/sobjects/ContentVersion';

        console.log({endpoint});
        console.log('Callout Data::'+this.base64result);
        //this.dataVal.id = this.contactId;
        
        fetch(endpoint, {
            method: "POST",
            headers: {
                "Authorization": 'Bearer ' + this.access_token,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                "Title":this.fileType,
                "ContentLocation":"S",
                "PathOnClient" : '/' + this.fileType,
                "VersionData": this.base64result
            })
        })
        .then((response) => response.json())
        .then((data) => {
            console.log('file id ', data.id);
            console.log("contact id", contactId);
            this.currentConIdToCVId.cvId = data.id;

            this.conIdToCVIdObjArr.push({"contactId": contactId, "cvId": data.id});
            console.log('conIdToCVIdObjArr ', this.conIdToCVIdObjArr);
            this.dataArray.push(contactId);
            console.log('dataArray ', this.dataArray);
            this.currentConIdToCVId = {};

            for (let i = 0; i < this.conIdToCVIdObjArr.length; i++) {
                for (let j = 0; j < badgeClass.length; j++) {
                    console.log('spinner[j].dataset.id '+spinner[j].dataset.id);
                    console.log('this.dataArray[i] '+this.dataArray[i]);
                    if(spinner[j].dataset.id==this.dataArray[i]){
                        spinner[j].style.display = "none";
                        badgeClass[j].style.display = "block";
                        headBlock[j].style.display = "none";
                        errorBlock[j].style.display = "none";
                    }
                }
            }
            return;
            
        })
        .catch(error => {
            console.error('Error: ', error);
            for (let i = 0; i < badgeClass.length; i++) {
                console.log('check'+this.dataIndex+'=='+i);
                if(this.dataIndex==i){
                    badgeClass[i].style.display = "none";
                    spinner[i].style.display = "none";
                    headBlock[i].style.display = "none";
                    errorBlock[i].style.display = "block";
                }
            }
        });
    }

    handleFilesChange(event) {
        if(event.target.files.length > 0) {

            console.log('file ', event.target.files[0]);
            console.log('con id', event.target.name);
            
            var conId = event.target.name;
            this.currentConIdToCVId.contactId = event.target.name;
            console.log('current conId obj', this.currentConIdToCVId);

            let studentId = event.target.dataset.studentid;
            this.totalIds = event.target.dataset.totalids;
            let recName = event.target.dataset.id;
            this.contactId = event.target.name;
            
            var file = event.target.files[0];
            let extension = file.name.split('.').pop().toLowerCase();
            let customName = studentId+'_'+recName+'_Photograph'+'.'+extension;
            this.fileType = customName;
            var reader = new FileReader();
            let badgeClass = this.template.querySelectorAll('h5');
            let spinner = this.template.querySelectorAll('lightning-spinner');
            let headBlock = this.template.querySelectorAll('h4');
            let errorBlock = this.template.querySelectorAll('h3');
            this.dataIndex = event.target.dataset.index;
            if (file.size > MAX_FILE_SIZE) {
                for (let i = 0; i < headBlock.length; i++) {
                    if(this.dataIndex==i){
                        headBlock[i].style.display = "block";
                        spinner[i].style.display = "none";
                        badgeClass[i].style.display = "none";
                        errorBlock[i].style.display = "none";
                    }
                }
                return;
            }
            reader.readAsDataURL(file);
            //this.showLoadingSpinner = true;
            reader.onloadend = (e) => {
                var img = document.createElement("img");

                img.onload = function () {
                    var canvas = document.createElement("canvas");
                    var ctx = canvas.getContext("2d");
                    ctx.drawImage(img, 0, 0, 300, 300);
                    var dataurl1 = canvas.toDataURL(file.type);
                    console.log('dataurl1::' + dataurl1);
                    this.dataurl = dataurl1;
                    document.getElementsByClassName("imgToResize").src = dataurl1;
                    this.base64result = dataurl1.split(',')[1];
                    this.makeCallout(conId);
                }
                //
                
                img.src = e.target.result;
                console.log('e.target.result::'+e.target.result);
                console.log('reader.result::'+reader.result);
                console.log('dataurl::' + this.dataurl);
                
                console.log('base64result::' + this.base64result);
                
                
                for (let i = 0; i < badgeClass.length; i++) {
                    if(this.dataIndex==i){
                        spinner[i].style.display = "block";
                    }
                }
                //if(this.dataurl.length>0){
                    
               // }
                
            };
            return;
        }

    }

    saveFile(event){
        let recId = event.target.dataset.name;
        let recName = event.target.dataset.id;
        let studentId = event.target.dataset.studentid;
        let dataIndex = event.target.dataset.index;
        console.log('recId=>'+recId);
        console.log('recName'+recName);
        console.log('studentId'+studentId);
        var fileCon = this.filesUploaded[0];
        console.log('fileCon ', fileCon);
        let fileSize = this.formatBytes(fileCon.size, 2);
        console.log('fileConsize'+fileCon.size);
        console.log('dataIndex'+dataIndex);
        let badgeClass = this.template.querySelectorAll('h5');
        let spinner = this.template.querySelectorAll('lightning-spinner');
        let headBlock = this.template.querySelectorAll('h4');
        let errorBlock = this.template.querySelectorAll('h3');
        for (let i = 0; i < badgeClass.length; i++) {
            if(dataIndex==i){
                spinner[i].style.display = "block";
            }
        }

        console.log('MAX_FILE_SIZE'+MAX_FILE_SIZE);
        console.log('File size ', fileCon.size);
        if (fileCon.size > MAX_FILE_SIZE) {
            for (let i = 0; i < headBlock.length; i++) {
                if(dataIndex==i){
                    headBlock[i].style.display = "block";
                    spinner[i].style.display = "none";
                    badgeClass[i].style.display = "none";
                    errorBlock[i].style.display = "none";
                }
            }
            return;
        }
        console.log('fileSize'+fileSize);
 
        let extension = fileCon.name.split('.').pop().toLowerCase();
        let customName = studentId+'_'+recName+'_Photograph'+'.'+extension;
        console.log('customName'+customName);

        
            
        var self = this;
        var reader = new FileReader();
        reader.onload = function() {
            var fileContents = reader.result;
            var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
            fileContents = fileContents.substring(dataStart);
            //console.log('fileContents Code:'+fileContents);
            //self.upload(fileCon, fileContents, recId, customName,dataIndex,headBlock,errorBlock);
        };
        reader.readAsDataURL(fileCon);
    }

    upload(file, fileContents, recId, customName,dataIndex,headBlock,errorBlock){
        console.log('Reach upload method');
        console.log('upload ContactID'+recId);
        var fromPos = 0;
        var toPos = Math.min(fileContents.length, fromPos + CHUNK_SIZE);
        //this.uploadChunk(file, fileContents, fromPos, toPos, recId, customName, dataIndex,headBlock,errorBlock, ''); 
    }


    uploadChunk(file, fileContents, fromPos, toPos, recId, customName, dataIndex, headBlock, errorBlock, attachId){
        console.log('Reach uploadChunk method');
        console.log('uploadChunk ContactID'+recId);
        var chunk = fileContents.substring(fromPos, toPos);
        console.log('CHUNK_SIZE'+CHUNK_SIZE);
        console.log('type'+file.type);
        console.log('attachId::'+attachId);
        console.log('recId::'+recId);
        console.log('customName::'+customName);
        let badgeClass = this.template.querySelectorAll('h5');
        let spinner = this.template.querySelectorAll('lightning-spinner');
        saveTheChunkFile({ 
            parentId: recId,
            fileName: customName,
            base64Data: encodeURIComponent(chunk), 
            contentType: file.type,
            fileId: attachId
        })
        .then(data => {
            console.log('Call result'+data);
            attachId = data;
            fromPos = toPos;
            toPos = Math.min(fileContents.length, fromPos + CHUNK_SIZE); 
            console.log('Call then'); 
            if (fromPos < toPos) {
                console.log('Call uploadChunk method again');  
                this.uploadChunk(file, fileContents, fromPos, toPos, recId, customName, dataIndex, headBlock, errorBlock, attachId);  
            }else{
                for (let i = 0; i < badgeClass.length; i++) {
                    console.log('check'+dataIndex+'=='+i);
                    if(dataIndex==i){
                        badgeClass[i].style.display = "block";
                        spinner[i].style.display = "none";
                        headBlock[i].style.display = "none";
                        errorBlock[i].style.display = "none";
                    }
                }
            }
        })
        .catch(error => {
            console.error('Error: ', error);
            for (let i = 0; i < badgeClass.length; i++) {
                console.log('check'+dataIndex+'=='+i);
                if(dataIndex==i){
                    badgeClass[i].style.display = "none";
                    spinner[i].style.display = "none";
                    headBlock[i].style.display = "none";
                    errorBlock[i].style.display = "block";
                }
            }
        })
        .finally(()=>{
            
        })
    }
    

    formatBytes(bytes,decimals) {
        console.log('bytes' + bytes);
        console.log('decimals' +decimals);
        if(bytes == 0) return '0 Bytes';
        var k = 1024,
            dm = decimals || 2,
            sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
            i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }
}