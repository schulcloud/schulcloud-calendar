function regularDateFormat(date) {

    // YYYYMMDD'T'hhmmss'Z'

    const year = date.slice(0, 4);
    const month = date.slice(4, 6);
    const day = date.slice(6, 8);

    const hour = date.slice(9, 11);
    const minute = date.slice(11, 13);
    const second = date.slice(13, 15);

    let timezone = date.slice(15, date.size);
    if (timezone === 'Z') {
        timezone = 'UTC'
    }

    return new Date(`${year}/${month-1}/${day} ${hour}:${minute}:${minute} ${timezone}`);
}

module.exports = regularDateFormat;