const express = require('express');
const router = express.Router();
const {getTopic,getEvaluatee,getScore} = require('../controllers/evaluator')
const verifyToken = require('../middleware/verifyToken')

router.get('/gettopic',verifyToken('evaluator'),getTopic)
router.get('/getevaluatee/:topic_id',verifyToken('evaluator'),getEvaluatee)
router.get('/getscore/:assignment_id',verifyToken('evaluator'),getScore)

module.exports = router;