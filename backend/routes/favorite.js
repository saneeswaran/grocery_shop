const express = require("express");
const router = express.Router();

const favoriteController = require("../controllers/favorite");

router.post("/add-to-favorite", favoriteController.addTOFavorite)
router.get("/get-favorite/:userId", favoriteController.getFavorite);
router.delete("/delete-from-favorite", favoriteController.deleteFromFavorites);

module.exports = router;    