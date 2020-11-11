const db = require('../../infrastructure/databasePromise');
const { allColumns } = require('./constants');

async function deleteEvents(eventId, scopeIds) {
	const query = `DELETE FROM events WHERE event_id = $1 AND scope_id = ANY($2) RETURNING ${allColumns}`;
	const params = [eventId, scopeIds];

	return db.query(query, params);
}

module.exports = deleteEvents;
