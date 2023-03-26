const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const getAllUser = async (req, res, next) => {
  let users;
  try {
    users = await User.find()
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
  if (!users) {
    return res.status(404).json({ msg: "No Users Found" });
  }
  return res.status(201).json({
    success: true,
    message: "List of All Users",
    data: users,
  });
};

const getFriends = async (req, res, next) => {
  let id = req.user.userId;
  let existingUser;
  try {
    existingUser = User.findById(id);
  } catch (error) {
    console.log("Unable to find this user by this ID");
  }
  let users;
  try {
    users = await User.find();
  } catch (err) {
    console.log(err);
  }
  if (!users) {
    return res.status(404).json({ msg: "No Users Found" });
  }
  let newListUsers = users.filter((item) => item.id != id);
  return res.status(201).json({
    success: true,
    message: "List of All Friends",
    data: newListUsers,
  });
};

const getUserByID = async (req, res, next) => {
  const id = req.user.userId;
  let user;
  try {
    user = await User.findById(id)
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
  if (!user) {
    return res.status(404).json({
      success: false,
      message: "No User Found",
    });
  }
  // console.log(user);
  return res.status(200).json({
    success: true,
    message: "User Details",
    data: user,
  });
};

// const signUp = async (req, res, next) => {
//     const {name, email, password} = req.body;
//     let existingUser;
//     try{
//         existingUser = await User.findOne({email});

//     } catch (err) {
//         console.log(err)
//     }
//     if(existingUser) {
//         return res.status(404).json({msg: "User Already Exists! Login Instead"})
//     }
//     const hashedPassword = bcrypt.hashSync(password);
//     const user = new User({
//         name,
//         email,
//         password: hashedPassword,
//         posts:[]
//     });

//     try {
//         await user.save();
//     } catch (err) {
//         console.log(err);
//     }
//     return res.status(201).json(user)
// }

const signUp = (req, res, next) => {
  User.findOne({ email: req.body.email })
    .then((user) => {
      if (user != null) {
        let err = new Error(`User with ${req.body.email} already exists.`);
        res.status(400);
        return next(err);
      }
      bcrypt.hash(req.body.password, 10, (err, hash) => {
        if (err) return next(err);
        let user = new User();

        if (req.body.firstName) {
          user.firstName = req.body.firstName;
        }
        if (req.body.lastName) {
          user.lastName = req.body.lastName;
        }
        if (req.body.dateOfBirth) {
          user.dateOfBirth = req.body.dateOfBirth;
        }
        if (req.body.phoneNumber) {
          user.phoneNumber = req.body.phoneNumber;
        }
        if (req.body.interests) {
          user.interests = req.body.interests;
        }

        const file = req.file;
        if (file) {
          user.image = req.file.filename;
        }
        // user.image = req.file.filename,
        // user.lastName = req.body.lastName,
        user.email = req.body.email;
        user.password = hash;
        user.posts = [];

        user
          .save()
          .then((user) => {
            res.status(201).json({
              status: "User registered sucessfully",
              userId: user._id,
              email: user.email,
            });
          })
          .catch(next);
      });
    })
    .catch(next);
};

// const login = async (req, res, next) => {
//     const {email , password} = req.body;
//     let existingUser;
//     try{
//         existingUser = await User.findOne({email});

//     } catch (err) {
//         console.log(err)
//     }
//     if(!existingUser) {
//         return res.status(404).json({msg: "Couldn't Find User by this Email"})
//     }
//     const isPasswordCorrect = bcrypt.compareSync(password, existingUser.password);
//     if(!isPasswordCorrect) {
//         return res.status(400).json({msg: "Incorrect Password"})
//     }
//     return res.status(200).json({msg: "Login Successful"});

// }

const login = (req, res, next) => {
  User.findOne({ email: req.body.email }).then((user) => {
    if (user == null) {
      let err = new Error(`User with ${req.body.email} has not registered`);
      console.log(err);
      res.status(404);
      return next(err);
    }
    bcrypt.compare(req.body.password, user.password, (err, status) => {
      if (err) return next(err);
      if (!status) {
        let err = new Error("Password does not match");
        console.log(err);
        res.status(401);
        return next(err);
      }
      let data = {
        userId: user._id,
        email: user.email,
      };
      jwt.sign(data, process.env.SECRET, { expiresIn: "1d" }, (err, token) => {
        if (err) return next(err);
        console.log(token);
        res.json({
          status: "Login Success",
          userId: user._id,
          token: token,
        });
      });
    });
  });
};

const profile = async (req, res, next) => {
  const { firstName, lastName, dateOfBirth, phoneNumber, interests } = req.body;
  const userID = req.user.userId;
  let user;
  try {
    user = await User.findByIdAndUpdate(
      userID,
      {
        firstName,
        lastName,
        phoneNumber,
        interests,
        dateOfBirth,
        // image,
        // image: req.file.filename,
      },
      { new: true }
    );
  } catch (err) {
    return console.log(err);
  }
  if (!user) {
    return res.status(500).json({
      success: false,
      msg: "Unable to update the profile",
    });
  }
  return res.status(201).json({
    success: true,
    message: "User Profile Updated",
    data: user,
  });
};

const updateProfilePicture = async (req, res, next) => {
  const userID = req.user.userId;
  let user;
  try {
    user = await User.findByIdAndUpdate(
      userID,
      {
        image: req.file.filename,
      },
      { new: true }
    );
  } catch (err) {
    return console.log(err);
  }
  if (!user) {
    return res
      .status(500)
      .json({
        success: false,
        msg: "Unable to update the profile picture",
      });
  }
  return res.status(201).json({
    success: true,
    message: "User Profile Updated",
    data: user,
  });
};

module.exports = {
  getAllUser,
  getFriends,
  signUp,
  login,
  profile,
  getUserByID,
  updateProfilePicture,
};
