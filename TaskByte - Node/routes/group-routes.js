const express = require("express");
const router = express.Router();
const groupController = require("../controllers/groups_controllers");
const upload = require("../middleware/upload");
const auth = require("../middleware/auth");

router
  .route("/")
  .get(groupController.getAllGroup)
  .post(groupController.createGroup)
  .delete(groupController.deleteAllGroups);
//   .put((req, res) => {
//     res.status(501).send({ msg: "Not Implemented" });
//   });
router
  .route("/delGroupByID")
  .delete( groupController.deleteGroupByID);

module.exports = router;
