const express = require('express');
const route = express.Router();
const verifyToken = require('../middleware/verifyToken')
const {addTopic,getTopic,deleteTopic,editTopic,getIndicator,addIndicator, editIndicator,delIndicator } = require('../controllers/topic');
const upload = require('../middleware/uploadFile')


route.post('/topic',verifyToken('admin'),addTopic)
route.get('/topic',verifyToken('admin'),getTopic)
route.delete('/topic/:id',verifyToken('admin'),deleteTopic)
route.put('/topic/:id',verifyToken('admin'),editTopic)
route.get('/indicator/:id',verifyToken('admin'),getIndicator)
route.post('/indicator',verifyToken('admin'),upload.array('files',10),addIndicator)
route.put('/indicator/:id',verifyToken('admin'),upload.array('files',10),editIndicator)
route.delete('/indicator/:id',verifyToken('admin'),delIndicator)


module.exports = route;