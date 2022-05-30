const mongoose = require('mongoose')
const dbconfig = require('../Private/dbconfig')


const connectDB = async() => {
    try{
        const con = await mongoose.connect(dbconfig.database,{
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