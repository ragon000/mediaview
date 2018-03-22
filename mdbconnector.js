const MovieDB = require('moviedb')(process.env.MDBKEY);
const db = require('./dbconnector.js');
const ffmpeg = require('ffmpeg');
/*
 *  @param file: file that'll be analyzed
 *  @callback cb: information searched
 *  @callback err: error
 *  
 */

exports.getInfo = (file, cb, err) => {
ffmpeg.ffprobe(file, (error, metadata) => {
if(error) err(error);
let title = metadata.format.tags.title;
MovieDB.searchMovie({query: title}, (error, res) => {
if(error) err(error);
cb(res);
});
});

};
