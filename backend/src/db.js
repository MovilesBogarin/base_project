const mongoose = require("mongoose");

function connect() {
  mongoose.connect(
    //""
    "mongodb+srv://FoodStructure:1234@cluster0.llczuuy.mongodb.net/Food_Structure",

    /*  mongodb+srv://FoodStructure:1234@cluster0.llczuuy.mongodb.net/?retryWrites=true&w=majority */
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
