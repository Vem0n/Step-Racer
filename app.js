const express = require('express');
const bParser = require('body-parser');
const mongoose = require('mongoose');
const keys = require('./config');

const app = express();

app.use(bParser.json());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});

app.use((err, req, res, next) => {
    console.error(err);
    const status = err.statusCode || 500;
    const message = err.message;
    res.status(status).json({message: message});
  });

  mongoose.connect(keys.mdbKey).then(result => {
    app.listen(8080);
  }).catch(e => {
    console.log(e);
  })