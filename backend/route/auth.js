const express = require('express');
const router = express.Router();
const {login,flogin} = require('../controllers/auth');
const verifyToken = require('../middleware/verifyToken');

router.post('/login',login);
router.put('/flogin',verifyToken(),flogin);

module.exports = router;