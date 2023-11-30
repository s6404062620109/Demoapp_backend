const moment = require('moment-timezone');
const mysql = require('mysql');

const db = mysql.createConnection({
    user: "root",
    host: "localhost",
    password: "password1234",
    database: "demo_project"
})

function getHistory_timeconfirm(username, callback) {
    db.query('SELECT time_confirm FROM user WHERE username = ?', [username], (err, result) => {
        if (err) {
            console.log(err);
            return callback({ status: 500, message: "Can't connect user table" });
        }

        if (result.length === 0) {
            return callback({ status: 404, message: "User not found" });
        }

        const time_confirm = result[0].time_confirm;
        const parsedTimeConfirm = moment(time_confirm);
        const dateconfirm = parsedTimeConfirm.format('YYYY-MM-DD');
        const timeconfirm = parsedTimeConfirm.format('HH:mm:ss');

        const currentdate = moment().tz('Your-Timezone').format('YYYY-MM-DD');
        const currenttime = new Date().toLocaleTimeString([], { hour12: false, hour: '2-digit', minute: '2-digit', second: '2-digit' });

        db.query(
            `SELECT * FROM history 
            WHERE (information = 'COMM' OR information = 'ERR')
            AND (date > ? OR (date = ? AND time >= ?))
            AND (date < ? OR (date = ? AND time <= ?))`,
            [dateconfirm, dateconfirm, timeconfirm, currentdate, currentdate, currenttime],
            (err, result) => {
                if (err) {
                    console.log(err);
                    return callback({ status: 500, message: "Can't connect history table" });
                } else {
                    return callback(null, { status: 200, result });
                }
            }
        );
    });
}

function filter( data, role, callback ){
    if( data.period === ' ' && data.infor === 'All' && data.building === 'All' && data.group === 'All' && data.number === 'All' ){
        let condition;
        
        switch (role) {
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
                condition = "1"; // True condition to get all buildings
                break;
        }

        const query = `SELECT * FROM history WHERE ${condition}`;

        db.query(query, (err, result) => {
            if (err) {
                console.log(err);
                return callback({ status:500, message: "Can't connect history table" });
            } else {
                return callback(null, { status:200, result });
            }
        });
    }
    else{
        let conditions = [];

        if(data.period !== ' ') {
            const [startDate, endDate] = data.period.split(' '); // Assuming period format is 'startdate enddate'
            conditions.push(`date BETWEEN '${startDate}' AND '${endDate}'`);
        }
        if(data.infor !== 'All') {
            conditions.push(`information = '${data.infor}'`);
        }
        if(data.building !== 'All') {
            conditions.push(`building = '${data.building}'`);
        }
        if(data.group !== 'All') {
            conditions.push(`\`group\` = '${data.group}'`);
        }
        if(data.number !== 'All') {
            conditions.push(`number = '${data.number}'`);
        }


        if(role === 'office') {
            conditions.push("building IN ('O1B', 'O2', 'O3', 'O4')");
        }
        else if(role === 'hotel_3') {
            conditions.push("building = 'H3'");
        } 
        else if(role === 'hotel_4') {
            conditions.push("building = 'H4'");
        }

        const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

        const query = `SELECT * FROM history ${whereClause}`;
        db.query(query, (err, result) => {
            if (err) {
                console.log(err);
                return callback({ status:500, message: "Can't connect history table" });
            } else {
                return callback(null, { status:200, result });
            }
        });
    }
}

module.exports = { getHistory_timeconfirm, 
                    filter};