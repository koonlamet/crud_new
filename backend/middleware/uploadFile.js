const multer = require('multer');
const path = require('path');
const fs = require('fs');

const storage = multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,'uploads/');
    },
    filename:(req,file,cb)=>{
        cb(null,Date.now()+path.extname(file.originalname));
    }
});
const fileFilter = (req,file,cb)=>{
    const allowType = '/jpg|jpeg|png|pdf'
    const extname = allowType.test(extname(file.originalname).toLowerCase());
    const mimetype = allowType.test(file.mimetype);

    if(extname && mimetype){
        return cb(null,true);
    }else{
        cb(new err('รองรับเฉพาะไฟล์ JPG,JPEG,PNG,PDF'),false);
    }
}

const upload = multer({
    storage:storage
//    fileFilter:fileFilter
})

module.exports = upload;