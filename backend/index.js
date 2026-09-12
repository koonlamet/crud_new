const express = require('express');
const cors = require('cors');
const app = express();
const {readdirSync} = require('fs')

app.use(express.json());
app.use(cors());

app.use('/uploads',express.static('uploads'))

readdirSync('./route').map((c)=> app.use('/api',require('./route/'+c)))

app.get('/api',(req,res)=>{res.send('API OK')});

app.listen(3001,()=>{console.log("API LISTIN ON PORT 3001")});