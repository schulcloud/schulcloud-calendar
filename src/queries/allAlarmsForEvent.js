const client = require('../infrastructure/database');
const errorMessage = require('./utils/errorMessage');

function allAlarmsForEvent(eventId) {
    return new Promise(function(resolve, reject) {
        const query = 'SELECT trigger, repeat, duration, action, attach, description, attendee, summary FROM alarms WHERE event_id = $1 ORDER BY id ASC;';
        client.query(query,[eventId], function (error, result) {
            if (error) {
                errorMessage(query, error);
                reject(error);
            } else {
                resolve(result.rows);
            }
        });
    });
}

module.exports = allAlarmsForEvent;
