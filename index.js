const express = require('express');
const mysql = require('mysql');
const cors = require('cors');
const moment = require('moment-timezone');
const jwt = require('jsonwebtoken');
const functions = require('./functions');
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
    db.query(`SELECT * FROM history`, (err, result) =>{
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
        }
    });
});

//test encoder_input post

var senddata = {id:{},office:{},hotel3:{},hotel4:{}};
var postdata;

app.post('/inputdetected', (req, res) => {
    const status = req.body.status;
    const dir = req.body.dir;
    const event  = req.body.event;
    const ip = req.body.ip;

    if (!status || !dir || !event || !ip) {
        // return res.status(400).json({ message: "Missing required parameters in the request body" });
        const userdata = {admin:0, office:0, hotel3:0, hotel4:0};
        const h3data = [];
        const h4data = [];
        const o1bdata = [];
        const o2data = [];
        const o3data = [];
        const o4data = [];
        db.query(`SELECT role FROM user`,(err, result) => {
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect user table" });
            }
            else{
                // console.log(result);
                for(let i=0 ; i<result.length ; i++){
                    // console.log(result[i].role);
                    if(result[i].role === 'admin'){
                        userdata.admin += 1;
                    }
                    else if(result[i].role === 'hotel_3'){
                        userdata.hotel3 += 1;
                    }
                    else if(result[i].role === 'hotel_4'){
                        userdata.hotel4 += 1;
                    }
                    else if(result[i].role === 'office'){
                        userdata.office += 1;
                    }
                }

                // console.log(userdata);
                db.query(`SELECT building.building, building.number, encoder_input.no,
                encoder_input.ip, encoder_input.status, encoder_input.dir
                FROM building JOIN encoder_input ON building.ip = encoder_input.ip`, 
                (err, result) => {
                    if(err){
                        console.log(err);
                        res.status(500).json({ message: "Cann't connect building table" });
                    }
                    else{
                        // console.log(result);
                        for( let i = 0 ; i<result.length ; i++ ){
                            if(result[i].building==="H3"){
                                // console.log(result[i]);
                                h3data.push(result[i]);
                            }
                            if(result[i].building==="H4"){
                                // console.log(result[i]);
                                h4data.push(result[i]);
                            }
                            if(result[i].building==="O1B"){
                                // console.log(result[i]);
                                o1bdata.push(result[i]);
                            }
                            if(result[i].building==="O2"){
                                // console.log(result[i]);
                                o2data.push(result[i]);
                            }
                            if(result[i].building==="O3"){
                                // console.log(result[i]);
                                o3data.push(result[i]);
                            }
                            if(result[i].building==="O4"){
                                // console.log(result[i]);
                                o4data.push(result[i]);
                            }
                        }
                        
                        const combineAndFilterData = (data) => {
                            const groupedData = data.reduce((acc, current) => {
                                const { ip, no , number , dir , status } = current;
                                if (!acc[ip] || acc[ip].no < no) {
                                    acc[ip] = { no, number, dir, status };
                                }
                                return acc;
                            }, {});
                        
                            return Object.values(groupedData);
                        };
                        
                        const filteredH3Data = combineAndFilterData(h3data);
                        const filteredH4Data = combineAndFilterData(h4data);
                        const filteredO1bData = combineAndFilterData(o1bdata);
                        const filteredO2Data = combineAndFilterData(o2data);
                        const filteredO3Data = combineAndFilterData(o3data);
                        const filteredO4Data = combineAndFilterData(o4data);
                        
                        senddata = { id: userdata , 
                            office:
                            { o1b: filteredO1bData,
                            o2: filteredO2Data,
                            o3: filteredO3Data,
                            o4: filteredO4Data },
                            hotel3: { h3:filteredH3Data },
                            hotel4: { h4:filteredH4Data } 
                        }
                        // console.log(senddata);
                        return res.status(200).json(senddata);
                    }
                });
            }
        });
        console.log(senddata);
        console.log(JSON.stringify(senddata, null, 4));
    }

    else{
        const currentdate = moment().tz('Your-Timezone').format('YYYY-MM-DD');
        const currenttime = new Date().toLocaleTimeString([], { hour12: false, hour: '2-digit', minute: '2-digit', second: '2-digit' }); 

        const lastChar = ip.charAt(ip.length - 1);
        const getbuildingvalue = {
            building: '',
            number: '',
            group: lastChar
        }
        if(event==='1'){
            if( status === 'COMM' ){
                db.query(`SELECT * FROM building WHERE ip=? `, [ip], (err, result) =>{
                    if(err){
                        console.log(err);
                        res.status(500).json({ message: "Cann't connect building table" });
                    }
                    else{
                        getbuildingvalue.building = result[0].building;
                        getbuildingvalue.number = result[0].number;
                        db.query(`INSERT INTO history (date, time, building, \`group\`, number, information) VALUE (?, ?, ?, ?, ?, ?)`, 
                            [currentdate, currenttime, getbuildingvalue.building, getbuildingvalue.group, getbuildingvalue.number, 'COMM'], 
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
            else if( status === 'ERR' ){
                db.query(`SELECT * FROM building WHERE ip=? `, [ip], (err, result) =>{
                    if(err){
                        console.log(err);
                        res.status(500).json({ message: "Cann't connect building table" });
                    }
                    else{
                        getbuildingvalue.building = result[0].building;
                        getbuildingvalue.number = result[0].number;
                        db.query(`INSERT INTO history (date, time, building, \`group\`, number, information) VALUE (?, ?, ?, ?, ?, ?)`, 
                            [currentdate, currenttime, getbuildingvalue.building, getbuildingvalue.group, getbuildingvalue.number, 'ERR'], 
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
            else{
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
        }
        db.query(`INSERT INTO encoder_input (status, dir, event, ip, datetime) 
        VALUE (?, ?, ?, ?, NOW())`,[status, dir, event, ip], (err,result) => {
            if(err){
                console.log(err);
                return res.status(500).json({message: "Encoder_input post in databased failed!"});
            }
            else{
                postdata = { 
                    no:result.insertId, status:status, dir:dir, 
                    event:event, ip:ip, date:currentdate ,time: currenttime};
                console.log(postdata);
                return res.status(200).json({message: "Encoder_input post Success!"});
            }
        });
    }
});

app.post('/getbuilding', (req, res) =>{
    const userrole = req.body.userrole;
    let condition;

    switch (userrole) {
        case "office":
            condition = "building IN ('O1B', 'O2', 'O3', 'O4')";
            break;
        case "hotel_3":
            condition = "building = 'H3'";
            break;
        case "hotel_4":
            condition = "building = 'H4'";
            break;
        default:
            condition = "1";
            break;
    }

    const query = `SELECT * FROM building WHERE ${condition} ORDER BY building`;

    db.query(query, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ message: "Can't connect building table" });
        } else {
            res.status(200).json({ result });
        }
    });
});

app.get('/getencoderInput', (req, res) => {
    db.query(`SELECT encoder_input.no, encoder_input.status,
    encoder_input.dir, encoder_input.event, encoder_input.ip, 
    encoder_input.datetime, building.building, building.floor, 
    building.number FROM encoder_input 
    JOIN building ON encoder_input.ip = building.ip`,
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

app.post('/check8secnoupdate', (req, res) => {
    const currentdate = moment().tz('Your-Timezone').format('YYYY-MM-DD');
    const currenttime = new Date().toLocaleTimeString([], { hour12: false, hour: '2-digit', minute: '2-digit', second: '2-digit' }); 
    // console.log(currentdate+' '+currenttime);
    const no = req.body.no;
    db.query('SELECT status,dir,ip,datetime FROM encoder_input WHERE no = ?', [no], (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't encoder_input user table" });
        }
        else{
            const dbDate = moment(result[0].datetime).format('YYYY-MM-DD');
            const dbTime = moment(result[0].datetime).format('HH:mm:ss');
            const ip = result[0].ip;
            const dir = result[0].dir;
            if(currentdate!==dbDate){
                db.query(`INSERT INTO encoder_input (status, dir, event, ip, datetime) 
                VALUE (?, ?, ?, ?, NOW())`,["COMM", dir, 0, ip], (err,result) => {
                    if(err){
                        console.log(err);
                        return res.status(500).json({message: "Encoder_input post in databased failed!"});
                    }
                    else{
                        return res.status(200).json({message: "Encoder_input post Success!"});
                    }
                });
            }
            else{
                const currentTimeMoment = moment(currenttime, 'HH:mm:ss');
                const dbTimeMoment = moment(dbTime, 'HH:mm:ss');
                const timeDifference = currentTimeMoment.diff(dbTimeMoment, 'seconds');

                if (timeDifference >= 8) {
                    if(result[0].status !== "COMM"){
                        db.query(`INSERT INTO encoder_input (status, dir, event, ip, datetime) 
                        VALUE (?, ?, ?, ?, NOW())`,["COMM", dir, 0, ip], (err,result) => {
                            if(err){
                                console.log(err);
                                return res.status(500).json({message: "Encoder_input post in databased failed!"});
                            }
                            else{
                                return res.status(200).json({message: "Encoder_input post Success!"});
                            }
                        });
                    }
                    else{
                        console.log("Communication Fail!");
                        return res.status(500).json({message: "Communication Fail!"});
                    }
                } 
                else {
                    console.log("Database date/time diffrence date/time < 8 second");
                    return res.status(500).json({message: "Database date/time diffrence date/time < 8 second"});
                }
                console.log(timeDifference+' second');
            }
        }
    });
});

var filterdata;
app.post('/filter', (req, res) => {
    const period = req.body.period;
    const infor = req.body.infor;
    const building = req.body.building;
    const group = req.body.group;
    const number = req.body.number;
    const userrole = req.body.userrole;
    const passvalue = { period:period, infor:infor, building:building,
                        group:group, number:number }

    functions.filter(passvalue, userrole, (err, result) => {
        if (err) {
            return res.status(err.status).json({ message: err.message });
        } 
        else {
            return res.status(result.status).json({ result: result.result });
        }
    });
    filterdata = { period:period, infor:infor, building:building,
        group:group, number:number }
    // console.log(filterdata);
});

app.get('/alarm', (req, res) => {
    const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
    
    if (!token) {
        return res.status(401).json({ message: 'Unauthorized: Missing token' });
    }
    else{
        jwt.verify(token, 'accessToken', (err, decoded) => {
            if (err) {
                console.log(err);
                return res.status(401).json({ message: 'Unauthorized: Invalid token' });
            }
    
            const username = decoded.username;
            // console.log(username);
            functions.getHistory_timeconfirm(username, (err, result) => {
                if (err) {
                    return res.status(err.status).json({ message: err.message });
                } else {
                    return res.status(result.status).json({ result: result.result });
                }
            });
        });
    }
});

app.listen('3001', () =>{
    console.log('Server is running on port 3001');
})