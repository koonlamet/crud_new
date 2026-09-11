const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const db = require('../db');


exports.getRoleUser = async (req,res)=>{
    try {
        const role = req.params.role;
        const [row] = await db.query(`select id,username,fname,role,status from user where role = ?`,[role]);
        if(row.length==0){
            return res.status(200).json({
                status:true,
                message:'ไม่พบข้อมูลผู้ใช้'
            })
        }
        res.status(200).json({
            status:true,
            data:row
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.getAllUser = async (req,res)=>{
    try {
        const [row] = await db.query(`select id,username,fname,role,status from user`);
        if(row.length==0){
            return res.status(400).json({
                status:true,
                message:'ไม่พบข้อมูลผู้ใช้'
            })
        }
        res.status(200).json({
            status:true,
            data:row
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.addNewUser = async (req,res)=>{
    try {
        const {username,fname,role,password,status='newbie'} = req.body;
        const passHash = await bcrypt.hash(password,10);
        const [row] = await db.query(`INSERT INTO user (username,password,fname,role,status) values (?,?,?,?,?)`,[username,passHash,fname,role,status]);
        res.status(201).json({
            status:true,
            message:'เพิ่มข้อมูลผู้ใช้สำเร็จ'
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}
exports.deleteUser = async (req,res)=>{
    try {
        const id = req.params.id;
        console.log(id);
        const [row] = await db.query(`DELETE FROM user where id = ?`,[id])
        if(row.affectedRows==0){
            return res.status(404).json({
                status:false,
                message:'เกิดข้อผิดพลาดไม่พบข้อมูล'
            })
        }
        res.status(200).json({
            status:true,
            message:'ลบข้อมูลเรียบร้อยแล้ว'
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}
exports.resetPass = async (req,res)=>{
    try {
        const id = req.params.id;
        const {password} = req.body;
        const passHash = await bcrypt.hash(password,10);
        const [row] = await db.query(`UPDATE user set password=? where id = ?`,[passHash,id])
        res.status(200).json({
            status:true,
            message:'รีเซตรหัสผ่านเรียบร้อย'
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.editUser = async (req,res)=>{
    try {
        const id = req.params.id;
        const {fname,role,status} = req.body;
        const [row] = await db.query(`UPDATE user set ? where id = ?`,[req.body,id])
        res.status(200).json({
            status:true,
            message:'รีเซตรหัสผ่านเรียบร้อย'
        })
    } catch (error) {
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.getUser = async (req,res) =>{
    try {
        const {id} = req.params;
        const [row] = await db.query(`select id,username,fname from user where id = ?`,[id])
        console.log(row)
        res.status(200).json({
            status:true,
            message:'ดึงข้อมูลสำเร็จ',
            data:row[0]
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.changePassword = async (req,res)=>{
    try {
        const {id} = req.params
        const {oldpassword,newpassword,cnewpassword} = req.body
        if(newpassword!=cnewpassword){
            return  res.status(400).json({
                status:false,
                message:'ยืนยันรหัสผ่านไม่ถูกต้อง'
            })
        }
        const [row] = await db.query(`select password from user where id =?`,[id])
        if(row.length==0){
            return  res.status(400).json({
                status:false,
                message:'ไม่พบผู้ใช้งาน'
            })
        }
        const isMatch = await bcrypt.compare(oldpassword,row[0].password)
        if(!isMatch){
            return  res.status(400).json({
                status:false,
                message:'รหัสเดิมไม่ถูกต้อง'
            })
        }
        const passHash = await bcrypt.hash(newpassword,10)
        const [result] = await db.query(`UPDATE user SET password = ? where id = ?`,[passHash,id])
        res.status(200).json({
            status:true,
            message:'เปลี่ยนรหัสผ่านเรียบร้อยแล้ว'
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.editProfile = async (req,res)=>{
    try {
        const {id} = req.params;
        const {fname} = req.body;
        console.log(req.body)
        const [result] = await db.query(`UPDATE user SET fname=? where id = ?`,[fname,id])
        if(result.affectedRows==0){
            return  res.status(400).json({
                status:false,
                message:'ไม่พบผู้ใช้งาน'
            })
        }
        res.status(200).json({
            status:true,
            message:'แก้ไขข้อมูลสำเร็จ'
        })

    } catch (error) {
        console.log(error)
        res.status(400).json({
                status:false,
                message:'เกิดข้อผิดพลาด'
        })
    }
}