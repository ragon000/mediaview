const crypto = require('crypto');
const sqlite3 = require('sqlite3').verbose();
var db;

// Crpto Stuff
/**
 * generates random string of characters i.e salt
 * @function
 * @param {number} length - Length of the random string.
 */
var genRandomString = function(length){
    return crypto.randomBytes(Math.ceil(length/2))
            .toString('hex') /** convert to hexadecimal format */
            .slice(0,length);   /** return required number of characters */
};

/**
 * hash password with sha512.
 * @function
 * @param {string} password - List of required fields.
 * @param {string} salt - Data to be validated.
 */
var sha512 = function(password, salt){
    var hash = crypto.createHmac('sha512', salt); /** Hashing algorithm sha512 */
    hash.update(password);
    var value = hash.digest('hex');
    return {
        salt:salt,
        passwordHash:value
    };
};
function sha(password, salt, cb){
cb(sha512(password,salt));
}
function saltHashPassword(userpassword, cb) {
    var salt = genRandomString(16); /** Gives us salt of length 16 */
    var passwordData = sha512(userpassword, salt);
cb(passwordData);
}

// End Crypto Stuff
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

exports.addUser = (name, email, password, type, err) => {
saltHashPassword(password, (cb) => {

db.run('INSERT INTO user VALUES (\''+name+'\',\''+email+'\',\''+type+'\',\''+cb.passwordHash+'\', id, \''+cb.salt+'\')', (error) => {
err(error);
});
});

};

exports.checkUser = (name, password, cb, err) => {
db.get('SELECT hash, salt FROM user WHERE name=\''+name+'\'', [], (error,row) => {
if(error) err(error);
if(sha(password, row.salt) === salt){
cb(true);
}

});
};


