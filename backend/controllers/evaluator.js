const db = require('../db')


exports.getTopic = async (req,res)=>{
    try {
        const id = req.user.id
        const [row] = await db.query(`select 
                                        t.*,
                                        COUNT(DISTINCT a.evaluatee_id) as total_assign
                                        FROM topic t
                                        INNER JOIN assignment a ON a.topic_id = t.id AND evaluator_id = ?
                                        GROUP BY t.id
                                    `,[id])
        const today = new Date().toLocaleDateString('en-CA');
        if(row && row.length>0){
            row.forEach(item => {
                item.sdate = item.sdate.toISOString().split('T')[0]
                item.edate = item.edate.toISOString().split('T')[0]

                if(today < item.sdate && today < item.edate){
                    item.status = 'ยังไม่เริ่ม'
                    item.chip = 'warning'
                }else if(today > item.sdate && today < item.edate){
                    item.status = 'กำลังดำเนินการ'
                    item.chip = 'success'
                }else if(today > item.sdate && today > item.edate){
                    item.status = 'หมดเวลา'
                    item.chip = 'grey'
                }else{
                    item.status = '-'
                    item.chip = '-'
                }
            });
        }
        res.status(200).json({
            status:true,
            data:row
        })
    } catch (error) {
        res.status(500).json({
            status:false,
            message:'ไม่สามารถดึงข้อมูลได้'
        })
    }
}


exports.getEvaluatee = async (req,res)=>{
    try {
        const {topic_id} = req.params;
        const id = req.user.id 

        const [row] = await db.query(`select
                                        u.*
                                        from user u 
                                        inner join assignment a ON a.evaluatee_id = u.id
                                        where a.evaluator_id = ? AND a.topic_id = ?`
                                        ,[id,topic_id])
        console.log(row)
        res.status(200).json({
            status:true,
            data:row
        })
    } catch (error) {
        res.status(500).json({
            status:false,
            message:'ไม่สามารถดึงข้อมูลได้'
        })
    }

}


/*SELECT	
	i.id as indicator_id,
 	i.type,
    i.weight,
    i.description as indicator_desc,
    e.id as evidence_id,
    e.self_score as evidence_score,
    e.detail as evidence_detail,
    r.score,
	COALESCE(
    	(SELECT JSON_ARRAYAGG(
        	JSON_OBJECT('id',ef.id,'filename',ef.file_name,'filepath',ef.file_path)
        )
         FROM evidence_file ef WHERE ef.evidence_id = e.id),
    	JSON_ARRAY()
    ) AS files
FROM assignment a
INNER JOIN indicator i ON i.topic_id = a.topic_id
LEFT JOIN evidence e ON e.indicator_id = i.id AND e.evaluatee_id = a.evaluatee_id
LEFT JOIN review r ON r.indicator_id = i.id AND r.assignment_id = a.id
WHERE a.id = 2 AND a.evaluator_id = 3;*/
