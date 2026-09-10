const express = require('express');
const db = require('../db');


exports.addTopic = async (req,res) =>{
    try {
        const {topic,desc,sdate,edate} = req.body;
        const [result] = await db.query(`INSERT INTO topic (topic_name,description,sdate,edate,isActive) VALUES (?,?,?,?,?)`,[topic,desc,sdate,edate,1])
        res.status(201).json({
            status:true,
            message:'ข้อหัวข้อสำเร็จ'
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}


exports.getTopic = async (req,res) =>{
    try {
        const [row] = await db.query('SELECT * FROM topic')
        res.status(201).json({
            status:true,
            message:'ข้อหัวข้อสำเร็จ',
            data:row
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.deleteTopic = async (req,res) =>{
    try {
        const {id} = req.params;
        const [row] = await db.query('DELETE FROM topic where id = ?',[id])
        res.status(201).json({
            status:true,
            message:'ลบรายการประเมินเรียบร้อยแล้ว'
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.editTopic = async (req,res) =>{
    try {
        const {id} = req.params;
        const {topic_name , description , sdate , edate} = req.body
        const [row] = await db.query(`UPDATE topic set topic_name=?,description=?,sdate=?,edate=? where id = ?`,[topic_name,description,sdate,edate,id])
        if(row.affectedRows==0){
            return res.status(400).json({
            status:false,
            message:'ไม่มีรายการประเมินนี้อยู่ในระบบ'
        })
        }
        res.status(201).json({
            status:true,
            message:'แก้ไขรายการประเมินนี้เรียบร้อยแล้ว'
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.getIndicator = async (req,res)=>{
    try {
        const {id} = req.params;
        const [row] = await db.query('SELECT * from indicator where topic_id = ?',[id])
        const safeParse = (str)=>{
            try {
                return str ? JSON.parse(str) : [];
            } catch (error) {
                return [];
            }
        }
        const data = row.map(item =>({
            ...item,
            evidence_kind:safeParse(item.evidence_kind),
            evidence_name:safeParse(item.evidence_name),
            evidence_path:safeParse(item.evidence_path)
        }))
        
        if(!row){
            return res.status(400).json({
            status:false,
            message:'ไม่มีรายการประเมินนี้อยู่ในระบบ'
            })
        }
        res.status(200).json({
            status:true,
            message:'ดึงข้อมูลสำเร็จ',
            data:data
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.addIndicator = async (req,res)=>{
    try {
        const data = JSON.parse(req.body.data || '{}'); 
        const evidence_kind = data.evidence_kind && data.evidence_kind.length>0 ? JSON.stringify(data.evidence_kind):null;
        const evidence_name = req.files && req.files.length>0 ? JSON.stringify(req.files.map(f=>f.filename)) : null;
        const evidence_path = req.files && req.files.length>0 ? JSON.stringify(req.files.map(f=>f.path)) : null;
        const [result] = await db.query(`INSERT INTO indicator (topic_id,type,weight,description,evidence_kind,evidence_name,evidence_path,evidence_url)
                                        VALUES (?,?,?,?,?,?,?,?)`,[data.topic_id,data.type,data.weight,data.description,evidence_kind,evidence_name,evidence_path,data.evidence_url]);
        res.status(201).json({
            status:true,
            message:'เพิ่มตัวชี้วัดสำเร็จ',
            data:result
        })
    } catch (error) {
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.editIndicator = async (req,res)=>{
    try {
        const {id} = req.params
        const data = JSON.parse(req.body.data || '{}');
        if(req.files && req.files.length>0){
            const newNames = req.files.map(item => item.filename);
            const newPaths = req.files.map(item => item.path);
            data.evidence_name = [...data.evidence_name,...newNames];
            data.evidence_path = [...data.evidence_path,...newPaths];
        }
        const evidence_kind = data.evidence_kind && data.evidence_kind.length > 0 ? JSON.stringify(data.evidence_kind):null;
        const evidence_name = data.evidence_name && data.evidence_name.length > 0 ? JSON.stringify(data.evidence_name):null;
        const evidence_path = data.evidence_path && data.evidence_path.length > 0 ? JSON.stringify(data.evidence_path):null;
        data.evidence_kind = evidence_kind;
        data.evidence_name = evidence_name;
        data.evidence_path = evidence_path;
        const [result] = await db.query(`UPDATE indicator SET ? where id = ?`,[data,id])
        res.status(201).json({
            status:true,
            message:'แก้ไขสำเร็จ',
            data:result
        })
        } catch (error) {
            console.log(error)
            res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}


exports.delIndicator = async (req,res) =>{
    try {
        const {id} = req.params;
        const [row] = await db.query(`DELETE FROM indicator where id = ?`,[id]);
        res.status(201).json({
            status:true,
            message:'ลบตัวชี้วัดสำเร็จ',
            data:row
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}



exports.addAssignment = async (req,res) =>{
    try {
        const {id,evaluator,evaluatee,committee_role,status='pending'} = req.body;
        console.log(evaluator)
        if(committee_role==='chair'){
            const [row] = await db.query(`select * from assignment where (topic_id = ? AND evaluatee_id =?)`,[id,evaluatee])
            console.log(row)
            if(row.length>0){
                return res.status(400).json({
                    status:false,
                    message:'ไม่สามารถมอบหมายประธานกรรมการซ้ำได้'
                })
            }
        }
        const [result] = await db.query(`INSERT INTO assignment (topic_id,evaluator_id,evaluatee_id,committee_role,status) VALUES  (?,?,?,?,?)`,[id,evaluator,evaluatee,committee_role,status])
        res.status(201).json({
            status:true,
            message:'เพิ่มข้อมูลจับคู่กรรมการและผู้ถูกประเมินสำเร็จ'
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.getAssignment = async (req,res) =>{
    try {
        const {id} = req.params;
        const [row] = await db.query(`SELECT 
                                            a.id,
                                            a.evaluator_id,
                                            a.evaluatee_id,
                                            a.committee_role,
                                            u1.fname as evaluator,
                                            u2.fname as evaluatee
                                            
                                            from assignment a 
                                            left join user u1 ON u1.id = a.evaluator_id
                                            left join user u2 on u2.id = a.evaluatee_id
                                            where topic_id = ? ORDER BY a.evaluatee_id , a.committee_role`,[id])
        res.status(200).json({
            status:true,
            message:'ดึงข้อมูลสำเร็จ',
            data:row
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}