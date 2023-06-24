const User = require('../models/user');
const { validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
const token = require('jsonwebtoken');
const keys = require('../config');

exports.signup = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(422).json({ message: 'Validation failed', errors: errors.array() });
    }

    const email = req.body.email;
    const name = req.body.name;
    const password = req.body.password;

    const existingUser = await User.findOne({ email: email });
    if (existingUser) {
      return res.status(409).json({ message: 'Email already exists' });
    }

    const hashedPw = await bcrypt.hash(password, 12);

    const user = new User({
      email: email,
      password: hashedPw,
      name: name
    });

    const result = await user.save();

    res.status(200).json({
      message: '😁👍💀🤝👽',
      userId: result._id
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Signup failed' });
  }
};


  exports.login = async (req, res, next) => {
    try {
      const secret = keys.secret;
      const email = req.body.email;
      const password = req.body.password;
      let loadedUser;
  
      const user = await User.findOne({ email: email });
      if (!user) {
        console.log('No user with such email is found');
      }
  
      loadedUser = user;
  
      // @ts-ignore
      const matched = await bcrypt.compare(password, user.password);
      if (!matched) {
        throw new Error('Wrong email or password');
      }
  
      const userToken = token.sign(
        { email: loadedUser?.email, userId: loadedUser?._id.toString() },
        secret,
        { expiresIn: '2h' }
      );
  
      res.status(200).json({ token: userToken, userId: loadedUser?._id.toString() });
    } catch (e) {
      console.log(e);
    }
  };
  
  exports.deleteUser = async (req, res, next) => {
    try {
      const userId = req.params.userId;
  
      await User.findByIdAndRemove(userId);
  
      res.status(200).json({ message: 'User deleted.' });
    } catch (err) {
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
    }
  };