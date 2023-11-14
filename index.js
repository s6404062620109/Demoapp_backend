const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    user: "root",
    host: "localhost",
    password: "password1234",
    database: "demo_project"
})

app.get('/gethistory', (req, res) =>{
    db.query("SELECT * FROM history", (err, result) =>{
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect history table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
        }
    });
});

app.post('/posthistory', (req, res) => {
    const date = req.body.date;
    const time = req.body.time;
    const building = req.body.building;
    const group = req.body.group;
    const number = req.body.number;
    const information = req.body.information;
    db.query(`INSERT INTO history (date, time, building, \`group\`, number, information)
    VALUE (?, ?, ?, ?, ?, ?)`, [date, time, building, group, number, information], 
    (err, result) => {
        if(err){
            console.log(err);
            return res.status(500).json({message: "History post in databased failed!"});
        }
        else{
            return res.status(200).json({message: "History post Success!"});
            //console.log(res)
        }
    });
});

//test encoder_input post

app.post('/inputdetected', (req, res) => {
    const status = req.body.status;
    const dir = req.body.dir;
    const event  = req.body.event;
    const ip = req.body.ip;

    db.query(`INSERT INTO encoder_input (status, dir, event, ip) 
    VALUE (?, ?, ?, ?)`,[status, dir, event, ip], (err,result) => {
        if(err){
            console.log(err);
            return res.status(500).json({message: "Encoder_input post in databased failed!"});
        }
        else{
            return res.status(200).json({message: "Encoder_input post Success!"});
            //console.log(res)
        }
    });
});

app.get('/getbuilding', (req, res) =>{
    db.query("SELECT * FROM building ORDER BY building", (err, result) =>{
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect building table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
        }
    });
});

app.get('/getencoderInput', (req, res) => {
    db.query(`SELECT encoder_input.no, encoder_input.status,
    encoder_input.dir, encoder_input.event, encoder_input.ip, 
    building.building, building.floor, building.number
    FROM encoder_input JOIN building ON encoder_input.ip = building.ip`,
    (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect encoder_input table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
        }
    });
});

app.listen('3001', () =>{
    console.log('Server is running on port 3001');
})