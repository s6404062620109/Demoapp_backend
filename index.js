const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const moment = require('moment-timezone');
const jwt = require('jsonwebtoken');
const app = express();

app.use(cors({
    origin: ["http://localhost:3000"],
    methods: ["GET", "POST","PUT","DELETE"],
    credentials: true
}));
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

    const currentdate = moment().tz('Your-Timezone').format('YYYY-MM-DD');
    const currenttime = new Date().toLocaleTimeString([], { hour12: false, hour: '2-digit', minute: '2-digit', second: '2-digit' }); 

    const lastChar = ip.charAt(ip.length - 1);
    const getbuildingvalue = {
        building: '',
        number: '',
        group: lastChar
    }
    if(event==='1'){
        db.query(`SELECT * FROM building WHERE ip=? `, [ip], (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                getbuildingvalue.building = result[0].building;
                getbuildingvalue.number = result[0].number;
                db.query(`INSERT INTO history (date, time, building, \`group\`, number, information) VALUE (?, ?, ?, ?, ?, ?)`, 
                    [currentdate, currenttime, getbuildingvalue.building, getbuildingvalue.group, getbuildingvalue.number, 'Communication by '+ip], 
                    (err,result) => {
                        if(err){
                            console.log(err);
                            return res.status(500).json({message: "History post in databased failed!"});
                        }
                        else{
                            console.log( "History post Success!" );
                        }
                });
            }
        });
    }
    db.query(`INSERT INTO encoder_input (status, dir, event, ip) 
    VALUE (?, ?, ?, ?)`,[status, dir, event, ip], (err,result) => {
        if(err){
            console.log(err);
            return res.status(500).json({message: "Encoder_input post in databased failed!"});
        }
        else{
            return res.status(200).json({message: "Encoder_input post Success!"});
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

app.get('/getbuildingh3', (req, res) =>{
    db.query("SELECT * FROM building WHERE building = 'H3' ORDER BY building", (err, result) =>{
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
            res.status(500).json({ message: "Cann't connect encoder_input/building table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
        }
    });
});

app.post('/getbuildingsensor', (req, res) => {
    const building = req.body.building;
    db.query(`SELECT building.building, building.number, 
    encoder_input.no, encoder_input.status, encoder_input.dir FROM building 
    JOIN encoder_input ON building.ip = encoder_input.ip 
    WHERE building.building=? ORDER BY building.number `, [building], (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect encoder_input/building table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
        }
    });
});

app.post('/login', (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    db.query(`SELECT * FROM user WHERE username=? AND password=?`, 
    [username, password], (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect user table" });
        }
        else{
            // console.log(result);
            if(result.length>0){
                // res.status(200).json({ result });
                const token = jwt.sign({username}, "accessToken", {expiresIn: '1h'});
                const decoded = jwt.verify(token, "accessToken");
                const expired_date = new Date(decoded.exp * 1000);

                db.query(`UPDATE user SET token = ?, iat = NOW() ,exp = ? WHERE username = ?`,
                [ token, expired_date, username ], (err, result) => {
                    if(err){
                        console.log(err);
                        res.status(500).json({ message: "Cann't connect user table" });
                    }
                    else{
                        return res.json({message: "SignIn Successful!",token:token , exp:expired_date})
                    }
                });
            }
            else{res.status(200).json({ message: "Invalid password" });}
        }
    });
});

app.post('/getuserdata', (req, res) => {
    const token = req.body.token;
    db.query(`SELECT * FROM user WHERE token = ? AND exp > NOW()`,
    [token], (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect user table" });
        }
        else{
            res.status(200).json({ result });
        }
    });
});

app.listen('3001', () =>{
    console.log('Server is running on port 3001');
})