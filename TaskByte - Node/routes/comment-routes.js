const express = require("express");
const router = express.Router();
const commentController = require("../controllers/comment_controllers");
const Post = require("../models/Post");

router
//   .route("/")
  .get(commentController.getAllComments)
  .post(commentController.createComment)
  .put((req, res) => res.status(501).json({ reply: "Not Implemented" }))
  .delete((req, res) => {
    res.send("Delete Comments");
  });

module.exports = router;
