const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/verifyToken')
const {getTopic,getIndicator,ansEvidence,getScore} = require('../controllers/evaluatee')
const upload = require('../middleware/uploadFile');

router.get('/evaluatee/topic',verifyToken('evaluatee'),getTopic)
router.get('/evaluatee/indicator/:id',verifyToken('evaluatee'),getIndicator)
router.post('/evaluatee/evidence',verifyToken('evaluatee'),upload.array('files'),ansEvidence)
router.get('/evaluatee/getscore/:topic_id',verifyToken('evaluatee'),getScore)

module.exports = router;