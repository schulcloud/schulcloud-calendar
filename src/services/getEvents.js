const getScopeIdsForToken = require('./getScopeIdsForToken');
const flatten = require('../utils/flatten');
const getAlarms = require('../queries/getAlarms');
const getExdates = require('../queries/getExdates');
const getRawEvents = require('../queries/getRawEvents');

function getEvents(filter, token) {
    return new Promise(function (resolve, reject) {
        if (filter.scopeId || filter.eventId) {
            completeEvents(filter)
                .then(resolve)
                .catch(reject);
        } else {
            getScopeIdsForToken(token)
                .then((scopeIds) => { return eventsPerScope(scopeIds, filter); })
                .then((events) => { resolve(flatten(events)); })
                .catch(reject);
        }
    });
}

function eventsPerScope(scopeIds, filter) {
    return new Promise((resolve, reject) => {
        Promise.all(scopeIds.map((scopeId) => {
            filter.scopeId = scopeId;
            return completeEvents(filter);
        })).then(resolve).catch(reject);
    });
}

function completeEvents(filter) {
    return new Promise((resolve, reject) => {
        getRawEvents(filter)
            .then(appendAlarms)
            .then(appendExdates)
            .then(resolve)
            .catch(reject);
    });
}

function appendAlarms(events) {
    return new Promise((resolve, reject) => {
        if (events.length === 0) resolve(events);
        events.forEach((event, index) => {
            getAlarms(event['id'])
                .then((alarms) => {
                    event.alarms = alarms;
                    if (index === events.length - 1) resolve(events);
                })
                .catch(reject);
        });
    });
}

function appendExdates(events) {
    return new Promise((resolve, reject) => {
        if (events.length === 0) resolve(events);
        events.forEach((event, index) => {
            getExdates(event['id'])
                .then((exdates) => {
                    event.exdates = exdates;
                    if (index === events.length - 1) resolve(events);
                })
                .catch(reject);
        });
    });
}

module.exports = getEvents;
