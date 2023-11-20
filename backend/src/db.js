const mongoose = require('mongoose')


function connect(){

    mongoose.connect(`mongodb+srv://FoodStructure:1234@cluster0.llczuuy.mongodb.net/?retryWrites=true&w=majority`, 
    {

            useNewUrlParser:true
   
    })
    console.log('Database: Connected')
}

module.exports = {connect}