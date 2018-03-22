const sqlite3 = require('sqlite3').verbose();
var db;

exports.startdb = (dbpath, err) => {

db = new sqlite3.Database(dbpath, sqlite3.OPEN_READWRITE, (error) => {
if(error){
err(err);
}

fs.readFile('./layout.sql', (error, data) => {
  if (error) err(error);
db.run(data);
});


console.log('Connected to ' + dbpath);
});

};

exports.addUser = (name, password, type, err) => {

db.run('INSERT INTO user VALUES (1

};
