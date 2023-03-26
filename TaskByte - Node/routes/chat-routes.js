const express = require("express");
const router = express.Router();
const chatController = require("../controllers/chat_controllers");
const upload = require("../middleware/upload");
const auth = require("../middleware/auth");


router.post('/chat/send/:friendId/', auth.verifyUser, chatController.sendMessageToFriend)
// router.get('/chat/get/:friendId/', auth.verifyUser, getFriendMessages)



module.exports = router;