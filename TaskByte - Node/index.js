require('dotenv').config()
const express = require("express");
const path = require("path");
const post_routes = require("./routes/post-routes");
const user_routes = require("./routes/user-routes");
const group_routes = require("./routes/group-routes");
const auth = require("./middleware/auth");
const comment_routes = require("./routes/comment-routes");

const mongoose = require("mongoose");
const logger = require("./logger")

const app = express();
const port = 3000;


// app.listen(port, () => {
//   console.log(`App is running in ${port}`);
// });

mongoose.set('strictQuery',true);
mongoose
  .connect("mongodb://127.0.0.1:27017/taskbyte")
  .then(() => {
    console.log("Connected to MongoDB server");
    app.listen(port, () => {
      console.log(`App is running in ${port}`);
    });
  })
  .catch((err) => next(err));

// Logger
app.use((req, res, next) => {
  console.log(`${req.method} ${req.path}`);
  logger.log(`${req.method} ${req.path}`);
  next();
})


app.use(express.json());

// app.get("/", (req, res) => {
//   res.send("Hello World it's me")
// });

app.use(
  "/uploads",
  express.static(path.join(__dirname, "/uploads"))
);


app.get("^/$|/index(.html)?", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "index.html"));
});

app.use("/user", user_routes);
// app.use("/post", auth.verifyUser, post_routes);
app.use("/post", post_routes);
// app.use("/post/comment/:id", auth.verifyUser, comment_routes);
// app.use("/post/comment/", auth.verifyUser, comment_routes);
app.use("/group", group_routes);

app.use((err, req, res, next) => {
  console.log(err.stack);
  if (res.statusCode == 200) res.status(500);
  res.json({ err: err.message });
});
