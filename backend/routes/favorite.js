const express = require("express");
const router = express.Router();

const favoriteController = require("../controllers/favorite");

router.post("/add-to-favorite/:id", favoriteController.addToFavorite)
router.get("/get-favorite/:userId", favoriteController.getFavorite);
router.delete("/delete-from-favorite/:id", favoriteController.deleteFromFavorites);

module.exports = router;    