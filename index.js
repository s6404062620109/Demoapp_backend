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

app.get('/gethistoryh3', (req, res) =>{
    db.query("SELECT * FROM history WHERE building = 'H3' ", (err, result) =>{
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't connect history table" });
        }
        else{
            // console.log("Get result success!");
            res.status(200).json({ result });
            // console.log(result);
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

    if (!status || !dir || !event || !ip) {
        // return res.status(400).json({ message: "Missing required parameters in the request body" });
        const userdata = {admin:0, office1b:0, office2:0, office3:0, office4:0 , hotel3:0, hotel4:0};
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
                    else if(result[i].role === 'office_1b'){
                        userdata.office1b += 1;
                    }
                    else if(result[i].role === 'office_2'){
                        userdata.office2 += 1;
                    }
                    else if(result[i].role === 'office_3'){
                        userdata.office3 += 1;
                    }
                    else if(result[i].role === 'office_4'){
                        userdata.office4 += 1;
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
                                    acc[ip] = { number, dir, status };
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
                        
                        return res.status(200).json({ id: userdata , 
                            office:
                            { o1b: filteredO1bData,
                            o2: filteredO2Data,
                            o3: filteredO3Data,
                            o4: filteredO4Data },
                            hotel3: { h3:filteredH3Data },
                            hotel4: { h4:filteredH4Data } 
                        });
                    }
                });
            }
        });
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
        db.query(`INSERT INTO encoder_input (status, dir, event, ip, datetime) 
        VALUE (?, ?, ?, ?, NOW())`,[status, dir, event, ip], (err,result) => {
            if(err){
                console.log(err);
                return res.status(500).json({message: "Encoder_input post in databased failed!"});
            }
            else{
                return res.status(200).json({message: "Encoder_input post Success!"});
            }
        });
    }

});

app.post('/getbuilding', (req, res) =>{
    const userrole = req.body.userrole;
    if( userrole === "office_1b" ){
        db.query(`SELECT * FROM building WHERE building = 'O1B' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else if( userrole === "office_2" ){
        db.query(`SELECT * FROM building WHERE building = 'O2' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else if( userrole === "office_3" ){
        db.query(`SELECT * FROM building WHERE building = 'O3' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else if( userrole === "office_4" ){
        db.query(`SELECT * FROM building WHERE building = 'O4' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else if( userrole === "hotel_3" ){
        db.query(`SELECT * FROM building WHERE building = 'H3' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else if( userrole === "hotel_4" ){
        db.query(`SELECT * FROM building WHERE building = 'H4' ORDER BY building`, (err, result) =>{
            if(err){
                console.log(err);
                res.status(500).json({ message: "Cann't connect building table" });
            }
            else{
                // console.log("Get result success!");
                res.status(200).json({ result });
            }
        });
    }
    else{
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
    }
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
    const no = req.body.no;
    db.query('SELECT status,ip FROM encoder_input WHERE no = ?', 
    [no], (err, result) => {
        if(err){
            console.log(err);
            res.status(500).json({ message: "Cann't encoder_input user table" });
        }
        else{
            // console.log(result[0].status);
            const ip = result[0].ip;
            if(result[0].status !== "COMM"){
                db.query(`INSERT INTO encoder_input (status, dir, event, ip, datetime) 
                VALUE (?, ?, ?, ?, NOW())`,["COMM", "err", 0, ip], (err,result) => {
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
                // console.log("Communication Fail!");
                res.status(500).json({message: "Communication Fail!"});
            }
        }
    });
});

app.listen('3001', () =>{
    console.log('Server is running on port 3001');
})