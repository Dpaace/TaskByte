const User = require("../models/User");
const Chat = require("../models/Chat");

const sendMessageToFriend = async (req, res) => {
  const { message } = req.body;

  if (!message) {
    return res
      .status(422)
      .json({ error: "Don`t send empty message type something" });
  }
  try {
    const friend = await User.findById(req.params.friendId);
    if (!friend) {
      return res.status(404).json({ error: "Friend Not Found" });
    }

    const chat = new Chat({
      sender: req.user.userId,
      receiver: req.params.friendId,
      message: message,
    });

    const saveChat = await chat.save();

    const getChat = await Chat.findById(saveChat.id)
      .populate("sender")
      .populate("receiver");

    const chatdata = {
      id: saveChat.id,
      sender: FilterUserData(getChat.sender),
      receiver: FilterUserData(getChat.receiver),
      body: getChat.body,
      createdAt: getChat.createdAt,
    };
    res.status(201).json({ data: chatdata });
    if (getChat.receiver.socketId) {
      req.io
        .to(getChat.receiver.socketId)
        .emit("new-message", { data: chatdata });
    }
  } catch (err) {
    console.log(err);
    return res.status(500).json({ error: "Something went wrong" });
  }
};

module.exports = {
  sendMessageToFriend,
};
