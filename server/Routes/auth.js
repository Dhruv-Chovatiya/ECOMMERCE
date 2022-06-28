//imports-----------------------------------------
const router = require("express").Router();
const User = require("../Model/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
//-------------------------------------------------

//--------------------------routes---------------------------
router.post("/register", async (req, res) => {
  const { username, password, email, mobile, confirmPassword } = req.body;
  if (!username || !email || !mobile || !password || !confirmPassword) {
    return res.status(400).json({ message: "All fields are required" });
  }

  if (password != confirmPassword) {
    return res.status(400).json({ message: "Password does not match" });
  }

  const existingUser = await User.findOne({ email });
  console.log(existingUser);
  if (existingUser) {
    return res.status(400).json({ message: "email already exist" });
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = await User.create({
    username: req.body.username,
    email: req.body.email,
    password: hashedPassword,
    mobile: req.body.mobile,
  });

  return res.status(200).json({ user: newUser });
});

router.post("/login", async (req, res) => {
  console.log(req.body);
  if (!req.body.email || !req.body.password) {
    return res.status(400).json({ message: "all fields are required" });
  }

  const existingUser = await User.findOne({ email: req.body.email });
  if (!existingUser) {
    return res.status(400).json({ message: "Invalid username and password" });
  }

  const isPasswordMatch = await bcrypt.compare(
    req.body.password,
    existingUser.password
  );
  if (!isPasswordMatch) {
    return res.status(400).json({ message: "Invalid Credential" });
  }

  const accessToken = await jwt.sign(
    { id: existingUser._id, isAdmin: existingUser.isAdmin },
    "rutvinShop",
    { expiresIn: "3d" }
  );
  const { password, ...others } = existingUser._doc;
  return res.status(200).json({ ...others, accessToken });
});

module.exports = router;
