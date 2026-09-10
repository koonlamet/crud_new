const express = require('express');
const router = express.Router();
const {getUser,addNewUser,deleteUser,resetPass,editUser,getAllUser} = require('../controllers/users');
const verifyToken = require('../middleware/verifyToken');

router.get('/users',verifyToken('admin'),getAllUser)
router.get('/users/:role',verifyToken('admin'),getUser)
router.post('/users',verifyToken('admin'),addNewUser)
router.delete('/users/:id',verifyToken('admin'),deleteUser)
router.put('/users/reset/:id',verifyToken('admin'),resetPass)
router.put('/users/:id',verifyToken('admin'),editUser)

module.exports = router;