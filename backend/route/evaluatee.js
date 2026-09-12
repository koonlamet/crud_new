const express = require('express');
const router = express.Router();
const verifyToken = require('../middleware/verifyToken')
const {getTopic} = require('../controllers/evaluatee')

router.get('/evaluatee/topic',verifyToken('evaluatee'),getTopic)

module.exports = router;