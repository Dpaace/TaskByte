const Group = require("../models/Group");

const getAllGroup = (req, res, next) => {
  Group.find()
    // .populate("user")
    .then((group) => {
      res.status(200).json({
        success: true,
        message: "List of All Groups",
        data: group,
      });
    })
    .catch(next);
};

// const getAllGroup = async (req, res, next) => {
//     let groups;
//     try {
//         groups = await Group.find()
//         // .populate("users")
//     } catch (err) {
//       console.log(err);
//     }
//     if (!groups) {
//       return res.status(404).json({ msg: "No Groups Found" });
//     }
//     return res.status(201).json({
//       success: true,
//       message: "List of All Groups",
//       data: groups,
//     });
//   };

const createGroup = async (req, res, next) => {
  const { groupName } = req.body;
  const group = new Group({
    // image: req.file.filename,
    groupName,
  });
  // const file = req.file;
  // if (file) {
  //   group.image = req.file.filename;
  // }
  // if (req.body.user) {
  //   group.user = group.user.concat(req.body.user);
  //   //student.course = req.body.course.split(",");
  // }
  try {
    await group.save();
  } catch (err) {
    console.log(err);
    return res.status(500).json({ msg: err });
  }
  return res.status(201).json({
    success: true,
    message: "Group Successfully Created",
    data: group,
  });
};
const deleteAllGroups = (req, res, next) => {
  Group.deleteMany()
    .then((reply) => {
      res.json({
        success: true,
        message: reply,
      });
    })
    .catch(console.log);
};

const deleteGroupByID = async (req, res, next) => {
  // const id = req.params.id;
  const id = req.query.id;
  let group;
  try {
    group = await Group.findByIdAndDelete(id);
  } catch (err) {
    console.log(err);
  }
  if (!group) {
    return res
      .status(500)
      .json({ success: false, message: "Unable to delete" });
  }
  return res
    .status(200)
    .json({ success: true, message: "Successfully deleted" });
};

module.exports = {
  getAllGroup,
  createGroup,
  deleteAllGroups,
  deleteGroupByID,
};
