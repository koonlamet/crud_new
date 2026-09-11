const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/verifyToken')
const {addTopic,getTopic,deleteTopic,editTopic,getIndicator,addIndicator,editIndicator,delIndicator,addAssignment, getAssignment,delAssignment,editAssignment} = require('../controllers/topic');
const upload = require('../middleware/uploadFile')


router.post('/topic',verifyToken('admin'),addTopic)
router.get('/topic',verifyToken('admin','evaluatee'),getTopic)
router.delete('/topic/:id',verifyToken('admin'),deleteTopic)
router.put('/topic/:id',verifyToken('admin'),editTopic)
router.get('/indicator/:id',verifyToken('admin'),getIndicator)
router.post('/indicator',verifyToken('admin'),upload.array('files',10),addIndicator)
router.put('/indicator/:id',verifyToken('admin'),upload.array('files',10),editIndicator)
router.delete('/indicator/:id',verifyToken('admin'),delIndicator)
router.post('/assignment',verifyToken('admin'),addAssignment)
router.get('/assignment/:id',verifyToken('admin'),getAssignment)
router.delete('/assignment/:id',verifyToken('admin'),delAssignment)
router.put('/assignment/:id',verifyToken('admin'),editAssignment)


module.exports = router;