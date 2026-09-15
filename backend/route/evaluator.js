const express = require('express');
const router = express.Router();
const {getTopic,getEvaluatee} = require('../controllers/evaluator')
const verifyToken = require('../middleware/verifyToken')

router.get('/gettopic',verifyToken('evaluator'),getTopic)
router.get('/getevaluatee/:topic_id',verifyToken('evaluator'),getEvaluatee)

module.exports = router;