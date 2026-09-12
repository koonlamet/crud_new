const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/verifyToken')
const {getTopic,getIndicator} = require('../controllers/evaluatee')

router.get('/evaluatee/topic',verifyToken('evaluatee'),getTopic)
router.get('/evaluatee/indicator/:id',verifyToken('evaluatee'),getIndicator)

module.exports = router;