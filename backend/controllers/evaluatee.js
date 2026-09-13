const { json } = require('express')
const db = require('../db')


exports.getTopic = async (req,res) =>{
    try {
        const id = req.user.id
        const [row] = await db.query(`select
                                        t.id,
                                        t.topic_name,
                                        t.description,
                                        t.sdate,
                                        t.edate,
                                        COUNT(DISTINCT e.id) as ans_count,
                                        COUNT(DISTINCT i.id) as indi_count
                                        FROM topic t
                                        LEFT JOIN evidence e ON e.topic_id = t.id AND e.evaluatee_id = ?
                                        LEFT JOIN indicator i ON i.topic_id = t.id
                                        GROUP BY t.id
                                        ORDER BY t.id`,[id])

        res.status(200).json({
            status:true,
            message:'ดึงข้อมูลสำเร็จ',
            data:row
        })
    } catch (error) {
        console.log(error)
        res.status(400).json({
            status:false,
            message:'เกิดข้อผิดพลาดไม่สามารถดึงข้อมูลได้'
        })
    }
}

exports.getIndicator = async (req,res)=>{
    try {
        const {id} = req.params;
        const evaluatee_id = req.user.id
        const sql = `select t.id as topic_id,
		                    t.topic_name as topic_name,
                            t.description as topic_desc,
                            i.id as indicator_id,
     	                    i.description as indicator_desc,
                            i.type,
                            i.weight,
                            e.id as evidence_id,
                            e.self_score,
                            e.detail as evidence_detail,
                            e.self_note,
                            e.url,
                            COALESCE(
                                (select json_arrayagg(
                                    json_object(
                                        'id',ef.id,
                                        'file_name',ef.file_name,
                                        'file_path',ef.file_path
                                    )
    	                        )
                            from evidence_file ef 
                            where ef.evidence_id = e.id
                            ),
                            JSON_ARRAY()
                            )as files
                            from topic t 
                            LEFT JOIN indicator i ON i.topic_id = t.id
                            LEFT JOIN evidence e ON e.indicator_id = i.id AND e.evaluatee_id = ?
                            where t.id = ?`
        const [row] = await db.query(sql,[evaluatee_id,id])
        res.status(200).json({
            status:true,
            data:row
        })
    } catch (error) {
        console.log(error)
        res.status(590).json({
            status:false,
            message:'เกิดข้อผิดพลาดไม่สามารถดึงข้อมูลได้'
        })
    }   
}


exports.ansEvidence = async (req,res) =>{
    try {
        const id = req.user.id
        const {topic_id,evidence_id=null,indicator_id,self_score,deleteFile,detail} = req.body;
        const deleteFileParse = deleteFile ? JSON.parse(deleteFile):[];
        let newEvidence_id = evidence_id;
        const [check] = await db.query(`select * from evidence where id = ? AND topic_id = ? AND indicator_id = ?`,[evidence_id,topic_id,indicator_id])
        if(check && check.length > 0){
            const [row] = await db.query(`UPDATE evidence SET topic_id=?,evaluatee_id=?,indicator_id=?,detail=?,self_score=? where id = ?`,[topic_id,id,indicator_id,detail,self_score,evidence_id]);
        }else{
            const [row] = await db.query(`INSERT INTO evidence (topic_id,evaluatee_id,indicator_id,detail,self_score) VALUES (?,?,?,?,?)`,[topic_id,id,indicator_id,detail,self_score])
            newEvidence_id = row.insertId
        }
        if(deleteFileParse && deleteFileParse.length>0){
            const [deleteExe] = await db.query(`DELETE FROM evidence_file where id IN (?)`,[deleteFileParse])
        }
        if(req.files && req.files.length>0){
            for(const file of req.files){
                await db.query(`INSERT INTO evidence_file (evidence_id,file_name,file_path,file_mime,file_size) VALUES (?,?,?,?,?)`,[newEvidence_id,file.filename,file.path,file.mimetype,file.size])
            }
        }
        res.status(201).json({
            status:true,
            message:'การทำรายการเรียบร้อย'
        })


        
    } catch (error) {
        res.status(500).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}