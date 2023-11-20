const {Schema,model}=require('mongoose')

const recpieSchema = new Schema({


email: String,
description: String,
ingredientes: [{name: String,quantity:Number,unit:String}],
steps: [{step: String}]

})

module.exports= model(`Recipe`,recpieSchema) 