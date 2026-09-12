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