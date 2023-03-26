const express = require("express");
const userController = require("../controllers/user_controllers");
const upload = require("../middleware/upload");
const auth = require("../middleware/auth");
const router = express.Router();

router.get("/getAll", userController.getAllUser);
router.get("/getFriends",auth.verifyUser, userController.getFriends);
router.post("/signup", upload.single("profile-image"), userController.signUp);
router.post("/login", userController.login)
router.put("/profile", auth.verifyUser, userController.profile)
router.put("/profilePicture", auth.verifyUser, upload.single("image"), userController.updateProfilePicture)

router
    .route("/getUserData")
    .get(auth.verifyUser,userController.getUserByID)


module.exports = router;