const mongoose = require("mongoose");

function connect() {
  mongoose.connect(
    //""
    "mongodb+srv://FoodStructure:1234@cluster0.llczuuy.mongodb.net/NombreDeTuBaseDeDatos",
    {
      //useUnifiedTopology: true,
    }
  );

  const db = mongoose.connection;

  db.on("error", console.error.bind(console, "Connection error:"));
  db.once("open", () => {
    console.log("Database connected");
  });
}

module.exports = { connect };
