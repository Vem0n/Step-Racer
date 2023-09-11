const User = require('../models/user');
const { validationResult } = require('express-validator');
const WebSocket = require('ws');
const bcrypt = require('bcrypt');
const token = require('jsonwebtoken');
const keys = require('../config');
const activeSockets = {};

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
    return res.status(500).json({ error: 'Signup failed' });
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
        return res.status(404).json({ error: 'No user with this email found'} );
      }
  
      loadedUser = user;
  
      // @ts-ignore
      const matched = await bcrypt.compare(password, user.password);
      if (!matched) {
        return res.status(400).json( {error: 'Wrong email or password'} );
      }
  
      const userToken = token.sign(
        { email: loadedUser?.email, userId: loadedUser?._id.toString() },
        secret,
        { expiresIn: '2h' }
      );
  
      res.status(200).json({ token: userToken, userId: loadedUser?._id.toString() });
    } catch (e) {
      if (!e.statusCode) {
        e.statusCode = 500;
        next(e);
        return res.status(500).json( {error: 'Something went wrong'} )
      }
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
      return res.status(500).json( {error: 'Something went wrong'} )
    }
  };

  exports.OAuth = async (req, res, next) => {
    try {
      const requestUrl = req.url;

      const urlObject = new URL(`https://page.co${requestUrl}`);

      const code = urlObject.searchParams.get('code');
      const state = urlObject.searchParams.get('state');

      console.log(`Code: ${code} State: ${state}`);

      const socket = activeSockets[state];

      if (socket) {
        if (code) {
          socket.send(code);
        } else {
          console.log('Code not obtained, try again')
        }

        socket.close();
      } else {
        console.log('No active socket found for the user');
      }

      return res.status(200).json( {message: 'Data obtained succesfully'} );

    } catch(err) {
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
      return res.status(500).json( {error: 'Something went wrong'} )
    }
  }

  exports.initOAuth = async (req, res, next) => {
    try {
      const userID = req.params.userId;

      const owner = await User.findById(userID);

      if (owner) {
        const socket = new WebSocket('wss://localhost:8080');

        socket.addEventListener('open', (event) => {
          console.log('Socket online, awaiting data')
          activeSockets[userID] = socket;
        });

        socket.addEventListener('message', (data) => {
          console.log(`Data received: ${data}`);
        });

        socket.addEventListener('close', (event) => {
          console.log('Connection closed, terminating')
        });
      } else {
        return res.status(422).json({ message: 'Validation failed'} )
      }


    } catch(err) {
      if (!err.statusCode) {
        err.statusCode = 500;
      }
      next(err);
      return res.status(500).json( {error: 'Something went wrong'} )
    }
  }