const { default: mongoose } = require("mongoose");
const Post = require("../models/Post");
const User = require("../models/User");
const upload = require("../middleware/upload");

const createPost = async (req, res, next) => {
  // Post.create(req.body)
  //   .then((post) => {
  //     res.status(201).json(post);
  //   })
  //   .catch(next);
  const { title, description, user = req.user.userId } = req.body;
  let existingUser;
  try {
    existingUser = await User.findById(user);
  } catch (err) {
    console.log(err);
  }
  if (!existingUser) {
    return res.status(400).json({ msg: "Unable to Find this user by this ID" });
  }
  const post = new Post({
    title,
    description,
    // image: req.file.filename,
    // postTime: new Date(),
    postTime: new Date().toLocaleDateString(),
    user: req.user.userId,
  });

  const file = req.file;
  if (file) {
    const fileName = req.file.filename;
    post.image = fileName;
  }
  try {
    await post.save();
    existingUser.posts.push(post);
    await existingUser.save();
  } catch (err) {
    console.log(err);
    return res.status(500).json({ msg: err });
  }
  return res.status(201).json(post);
};

const getAllPosts = (req, res, next) => {
  Post.find()
    .populate("user")
    .populate("comment")
    .populate({
      path: "comment",
      populate: {
        path: "user",
        model: "User",
      },
    })
    .populate({
      path: "comment",
      populate: {
        path: "post",
        model: "Post",
      },
    })
    .then((post) => {
      res.status(200).json({
        success: true,
        message: "List of All User Posts",
        data: post,
      });
    })
    .catch(next);
};

const deleteAllPosts = (req, res, next) => {
  Post.deleteMany()
    .then((reply) => {
      res.json(reply);
    })
    .catch(console.log);
};

const getPostByID = async (req, res, next) => {
  // Post.findById(req.params.id)
  // .then((post) => {
  //   res.json(post)
  // }).catch(next)
  const id = req.params.id;
  let post;
  try {
    post = await Post.findById(id);
  } catch (err) {
    console.log(err);
  }
  if (!post) {
    return res.status(404).json({ msg: "No Post Found" });
  }
  return res.status(200).json(post);
};

const updatePostByID = async (req, res, next) => {
  // Post.findByIdAndUpdate(req.params.id, {$set: req.body}, {new:true})
  // .then((post) => {
  //   res.json(post)
  // }).catch(next)
  const { title, description } = req.body;
  const postId = req.params.id;
  let post;
  try {
    post = await Post.findByIdAndUpdate(
      postId,
      {
        title,
        description,
      },
      { new: true }
    );
  } catch (err) {
    return console.log(err);
  }
  if (!post) {
    return res.status(500).json({ msg: "Unable to update the post" });
  }
  return res.status(200).json({ post });
};

const deletePostByID = async (req, res, next) => {
  // const id = req.params.id;
  const id = req.query.id;
  let post;
  try {
    post = await Post.findByIdAndDelete(id).populate("user");
    await post.user.posts.pull(post);
    await post.user.save();
  } catch (err) {
    console.log(err);
  }
  if (!post) {
    return res
      .status(500)
      .json({ success: false, message: "Unable to delete" });
  }
  return res.status(200).json({ success: true, message: "Successfully deleted" });
};

const getPostsByUserID = async (req, res, next) => {
  const userId = req.params.id;
  let userPosts;
  try {
    userPosts = await User.findById(userId)
      .populate("posts")
      .populate({
        path: "posts",
        populate: {
          path: "comment",
          model: "Comments",
        },
      });
  } catch (err) {
    console.log(err);
  }
  if (!userPosts) {
    return res.status(404).json({ msg: "No Posts Found" });
  }
  return res.status(200).json(userPosts);
};

module.exports = {
  createPost,
  getAllPosts,
  deleteAllPosts,
  getPostByID,
  updatePostByID,
  deletePostByID,
  getPostsByUserID,
};
