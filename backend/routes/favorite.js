const express = require("express");
const router = express.Router();

const favoriteController = require("../controllers/favorite");

router.post("/add-to-favorite/", favoriteController.addToFavorite);
router.get("/get-favorite/", favoriteController.getFavorite);
router.delete("/delete-from-favorite/", favoriteController.deleteFromFavorites);

module.exports = router;    