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
        const {topic_id,evidence_id=null,indicator_id,self_score,deleteFile,detail=null} = req.body;
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

        console.log(req.files)
        res.status(201).json({
            status:true,
            message:'การทำรายการสำเร็จ'
        })


        
    } catch (error) {
        res.status(500).json({
            status:false,
            message:'เกิดข้อผิดพลาด'
        })
    }
}

exports.getScore = async (req,res)=>{
    try {
        const {topic_id} = req.params;
        const id = req.user.id
        const [getEndDate] = await db.query(`SELECT sdate,edate from topic where id = ?`,[topic_id])
        const today = new Date().toLocaleDateString('en-CA');
        const edate = getEndDate[0].edate.toISOString().split('T')[0];

        if(today<=edate){
            return res.status(403).json({
                status:false,
                message:'ยังไม่สิ้นสุดระยะเวลาประเมิน'
            })
        }

        const [evaluatee] = await db.query(`select fname from user where id = ?`,[id]);

        const [evaluator] = await db.query(`select
                                            a.id as assignment_id,
                                            a.evaluator_id,
                                            u.fname as evaluator_name,
                                            a.committee_role,
                                            a.description as comment,
                                            a.signature_path,
                                            a.status
                                            from assignment a
                                            LEFT JOIN user u ON u.id = a.evaluator_id
                                            WHERE a.topic_id = ? AND a.evaluatee_id = ?
                                            ORDER BY FIELD(a.committee_role,'chair','member')`
                                            ,[topic_id,id])
        

        const [indicator] = await db.query(`select
                                            t.topic_name,
                                            t.description as topic_desc,
                                            i.id as indicator_id,
                                            i.type,
                                            i.weight,
                                            i.description as indicator_desc,
                                            e.self_score,
                                            ROUND(avg(r.score),1) AS avg_review
                                            from indicator i
                                            JOIN topic t ON t.id = i.topic_id
                                            LEFT JOIN evidence e ON e.indicator_id = i.id AND e.evaluatee_id = ?
                                            LEFT JOIN assignment a ON a.topic_id = t.id AND a.evaluatee_id =?
                                            LEFT JOIN review r ON r.assignment_id = a.id AND r.indicator_id = i.id
                                            WHERE i.topic_id = ?
                                            GROUP BY i.type,t.topic_name,t.description,i.id,i.weight,i.description,e.self_score`
                                            ,[id,id,topic_id])

        
        let totalWeight = 0;
        let totalReviewScore = 0;
        let totalSelfScore = 0;
        let totalIndicator = 0;

        evaluator.forEach(item => {
            item.committee_role = item.committee_role === 'chair'? 'ประธานกรรมการ':'กรรมการ';
        });
        indicator.forEach(item => {
            if(item.type==='yes_no'){
                if(item.self_score!=null){
                    item.self_score = item.self_score == 1 ? 'มี' : 'ไม่มี';
                    item.avg_review = item.avg_review == 1 ? 'มี' : 'ไม่มี';
                }else{
                    item.self_score = '-';
                    item.avg_review = '-';
                }
                item.weight = '-';
                item.weight_score = '0';
            }else{
                const weight = Number(item.weight || 0);
                const reviewScore = Number(item.avg_review || 0);
                const selfScore = Number(item.self_score) || 0;

                totalWeight += Number(weight);
                totalReviewScore += Number(reviewScore*weight);
                totalSelfScore += Number(selfScore*weight);
                totalIndicator += 1;
            }
        });
        const finalSelfScore = totalIndicator > 0 ? (totalSelfScore/totalWeight).toFixed(2):'0.00';
        const finalScore = totalWeight > 0 ? (totalReviewScore/totalWeight).toFixed(2):'0.00';
        res.status(200).json({
            status:true,
            message:'การดึงข้อมูล OK',
            data:{
                evaluator:evaluator,
                evaluatee:evaluatee,
                indicator:indicator,
                avgselfscore:finalSelfScore,
                finalscore:finalScore
            }
        })

    } catch (error) {
        res.status(500).json({
            status:false,
            error:error
        })
    }
}