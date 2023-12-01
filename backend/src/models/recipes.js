const { Schema, model } = require("mongoose");

const recpieSchema = new Schema({
  name: String,
  email: String,
  description: String,
  ingredientes: [{ name: String, quantity: Number, unit: String }],
  steps: [{ step: String }],
  dates: [{ date: String }],
});

module.exports = model(`Recipe`, recpieSchema);
