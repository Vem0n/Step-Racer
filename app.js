const express = require('express');
const bParser = require('body-parser');
const mongoose = require('mongoose');
const keys = require('./config');
const cron = require('node-cron');
const { deleteExpiredCompetitions, deleteExpiredGroupCompetitions } = require('./cronJobs');
const cronSchedule = '*/1 * * * *';

const authRoutes = require('./routes/auth');
const compRoutes = require('./routes/comps');
const gCompRoutes = require('./routes/groupComps');
const friendshipRoutes = require('./routes/friendships');

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

  app.use('/auth', authRoutes);
  app.use('/friendship', friendshipRoutes);
  app.use('/comps', compRoutes);
  app.use('/groupComps', gCompRoutes);

  const job = cron.schedule(cronSchedule, () => {
    deleteExpiredCompetitions();
  });
  const job2 = cron.schedule(cronSchedule, () => {
    deleteExpiredGroupCompetitions();
  });
  
  job.start();
  job2.start();

  mongoose.connect(keys.mdbKey).then(result => {
    app.listen(8080);
  }).catch(e => {
    console.log(e);
  })