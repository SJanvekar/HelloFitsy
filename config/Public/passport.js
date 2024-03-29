var JwtStrat = require('passport-jwt').Strategy
var ExtractJwt = require('passport-jwt').ExtractJwt

var User = require('../../api/models/User')
// var config = require('../Private/dbconfig')
const dotenv = require('dotenv');
dotenv.config();

module.exports = function(passport) {
    var opts = {
        jwtFromRequest: ExtractJwt.fromAuthHeaderWithScheme('jwt'),
        secretOrKey: process.env.DATABASE_SECRET,
    };
    
    passport.use(new JwtStrat(opts, function(jwt_payload, done) {
        User.findOne({id: jwt_payload.id}, function(err, user) {
            if (err) {
                return done(err, false);
            }
            if (user) {
                done(null, user);
            } else {
                done(null, false);
            
            }
        });
    }));
}