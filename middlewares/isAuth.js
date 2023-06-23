const token = require('jsonwebtoken');
const keys = require('../config');

const isAuth = async (req, res, next) => {
    try {
      const authHeader = req.get('Authorization');
      if (!authHeader) {
        return res.status(401).json({ message: 'Authorization failed' });
      }
  
      const secret = keys.secret;
      const userToken = authHeader.split(' ')[1];
      let decodedToken;
      try {
        decodedToken = token.verify(userToken, secret);
      } catch (err) {
        return res.status(500).json({ message: 'Authorization failed' });
      }
  
      if (!decodedToken) {
        return res.status(401).json({ message: 'Authorization failed' });
      }
  
      // @ts-ignore
      req.userId = decodedToken.userId;
      next();
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: 'Authorization failed' });
    }
  };