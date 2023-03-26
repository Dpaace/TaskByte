const express = require("express");
const router = express.Router();
const postController = require("../controllers/post_controllers");
const commentController = require("../controllers/comment_controllers");
const upload = require("../middleware/upload");
const auth = require("../middleware/auth");

router
  .route("/")
  .get(postController.getAllPosts)
  .post(upload.single("image"), auth.verifyUser, postController.createPost)
  .delete(auth.verifyUser, postController.deleteAllPosts)
  .put((req, res) => {
    res.status(501).send({ msg: "Not Implemented" });
  });

router
  .route("/:id")
  .get(postController.getPostByID)
  .post((req, res) => {
    res.status(501).send({ reply: "Not Implemented" });
  })
  .put(postController.updatePostByID)
  // .delete(auth.verifyUser, postController.deletePostByID);

router
  .route("/delPostByID")
  .delete(auth.verifyUser, postController.deletePostByID);

router.get("/user/:id", postController.getPostsByUserID);

router
  .route("/comment/:id")
  // .get(auth.verifyUser, commentController.getAllComments)
  // .post(auth.verifyUser, commentController.createComment)
  .put((req, res) => res.status(501).json({ reply: "Not Implemented" }))
  .delete((req, res) => {
    res.send("Delete Comments");
  });

router.route("/comment/get/")
  .get(auth.verifyUser, commentController.getAllComments);

router.route("/comment/add/")
  .post(auth.verifyUser, commentController.createComment);

module.exports = router;
