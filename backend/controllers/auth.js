const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const db = require('../db');
exports.login = async (req,res) =>{
    try {
        const {username,password} = req.body;
        if(!username || !password){
            return res.status(401).json({
                status:false,
                message:"กรุณากรอก Username และ Password"
            })
        }
        const [row] = await db.query(`select * from user where username = ?`,[username]);
        if(row.length===0){
            return res.status(401).json({
                status:false,
                message:"Username or Password Invalid"
            })
        }
        const isLogin = await bcrypt.compare(password,row[0].password);
        if(!isLogin){
            return res.status(401).json({
                status:false,
                message:"Username or Password Invalid"
            })
        }
        const payload = {
            id : row[0].id,
            username : row[0].username,
            fname:row[0].fname,
            role : row[0].role,
            status : row[0].status
        }
        const token = jwt.sign(payload,'KEY',{expiresIn:'1d'});
        res.status(200).json({
            status:true,
            data:payload,
            token:token
        })
    } catch (error) {
        console.log(error)
    }
}

exports.flogin = async (req,res) =>{
    try {
        const {password} = req.body;
        if(!password){
            return res.status(401).json({
                status:false,
                message:"กรุณากรอก Password และ Confirm Password"
            })
        }
        const passHash = await bcrypt.hash(password,10);
        const [result] = await db.query(`UPDATE user set password = ?,status='active' where id = ?`,[passHash,req.user.id])
        const payload = {
            id:req.user.id,
            username:req.user.username,
            fname:req.user.fname,
            role:req.user.role,
            status:'active'
        }
        const token = jwt.sign(payload,'KEY',{expiresIn:'1D'})
        res.status(200).json({
            status:true,
            data:payload,
            token:token
        })
    } catch (error) {
        res.status(401).json({
            status:false,
            message:'เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง'
        })
    }
}