const { Router } = require("express");
const router = Router();
const Recipes = require("../models/recipes");

router.get("/api/recipes", async (req, res) => {
  const recipes = await Recipes.find();
  res.json({ recipes });
});

router.get("/api/recipes/create", (req, res) => {
  Recipes.create({
    name: "Chamwish",
    email: "daniel@jaja.com",
    description: "Chamwish normalito uwu",
    ingredientes: [
      { name: "Pan", quantity: 2, unit: "pz" },
      { name: "Lechuga", quantity: 1, unit: "hja" },
      { name: "Jamon", quantity: 1, unit: "pza" },
    ],
    steps: [{ step: "sacar cositas" }, { step: "armar Chamwish" }],
    dates: ["", ""],
  });

  res.json("1 Usuario creado");
});

router.get("/api/recipes/:id", async (req, res) => {
  const recipes = await Recipes.find({ email: req.params.id });
  res.json({ recipes });
});

module.exports = router;
