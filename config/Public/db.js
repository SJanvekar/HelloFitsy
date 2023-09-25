const mongoose = require('mongoose')
// const dbconfig = require('../Private/dbconfig')
const dotenv = require('dotenv');
dotenv.config();


const connectDB = async() => {
    try {
        const con = await mongoose.connect(process.env.DATABASE_NAME,{
            useNewUrlParser: true,
        })
        console.log('MongoDB Connected:', con.connection.host)
    }
    catch(err){
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB
