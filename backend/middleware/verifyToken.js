const jwt = require('jsonwebtoken');

function verifyToken(...role){
    return (req,res,next)=>{
        const authHeader = req.headers['authorization'];
        const token = authHeader && authHeader.split(' ')[1];
        if(!token){
            return res.status(401).json({
                status:false,
                message:'กรุณาเข้าสู่ระบบ'
            })
        }
        try {
            const decode = jwt.verify(token,'KEY');
            req.user = decode;
            
                if(role.length > 0 && !role.includes(req.user.role)){
                    return res.status(401).json({
                    status:false,
                    message:'ไม่มีสิทธิ์เข้าถึงข้อมูล'
                })
            }
            next();
            
        } catch (error) {
            res.status(400).json({
                status:false,
                message:'การทำรายการผิดพลาดกรุณาลองอีกครั้ง'
            })
        }
    }
}
module.exports = verifyToken;