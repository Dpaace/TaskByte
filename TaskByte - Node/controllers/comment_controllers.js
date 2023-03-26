const Post = require("../models/Post");
const Comments = require("../models/Comment");
const User = require("../models/User");

const getAllComments = (req, res, next) => {
  const id = req.query.id
  Post.findById(req.query.id)
  .populate("comment")
  .populate({
    path: "comment",
    populate: {
      path: "post",
      model: "Post",
    },
  })
  .populate({
    path: "comment",
    populate: {
      path: "user",
      model: "User",
    },
  })
    .then((post) => {
      res.status(200).json({
        success: true, 
        message: "List of All Post Comments", 
        data: post.comment
      });
    })
    .catch(next);
};
// const getAllComments = (req, res, next) => {
//   Comments.find()
//   .populate("user")
//   // .populate("post")
//     .then((post) => {
//       res.status(200).json({
//         success: true, 
//         message: "List of All Comments", 
//         data: post
//       });
//     })
//     .catch(next);
// };

const createComment = async (req, res, next) => {
  const { content } = req.body;
  // const postID = req.query.id;
  let existingUser;
  try {
    existingUser = await User.findById(req.user.userId);
    // existingPost = await Post.findById(req.params.id)
    existingPost = await Post.findById(req.query.id)
  } catch (err) {
    console.log(err);
  }
  if (!existingUser) {
    res.status(400).json({ msg: "Unable to Find this user by this ID" });
  }
  if (!existingPost) {
    res.status(400).json({ msg: "Unable to Find this Post by this ID" });
  }
  
  const comments = new Comments({
    user:req.user.userId, 
    // post: req.params.id, 
    post: req.query.id, 
    content
  });
  try {
    await comments.save();
    // existingUser.posts.push(comments);
    // await existingUser.save();
    existingPost.comment.push(comments);
    await existingPost.save();
  } catch (err) {
    console.log(err);
    return res.status(500).json({ msg: err });
  }
  
  return res.status(201).json({
    success: true,
    data: comments,
  });
};
module.exports = {
  getAllComments,
  createComment,
};
