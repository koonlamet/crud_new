const express = require('express');
const router = express.Router();
const {getRoleUser,addNewUser,deleteUser,resetPass,editUser,getAllUser,getUser,changePassword,editProfile} = require('../controllers/users');
const verifyToken = require('../middleware/verifyToken');

router.get('/users',verifyToken('admin'),getAllUser)
router.get('/users/:id',verifyToken('admin','evaluator','evaluatee'),getUser)
router.get('/users/role/:role',verifyToken('admin'),getRoleUser)
router.post('/users',verifyToken('admin'),addNewUser)
router.delete('/users/:id',verifyToken('admin'),deleteUser)
router.put('/users/reset/:id',verifyToken('admin'),resetPass)
router.put('/users/:id',verifyToken('admin'),editUser)
router.put('/users/changepassword/:id',verifyToken('admin','evaluator','evaluatee'),changePassword)
router.put('/users/editprofile/:id',verifyToken('admin','evaluator','evaluatee'),editProfile)

module.exports = router;