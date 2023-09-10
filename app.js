const express = require('express');
const bParser = require('body-parser');
const mongoose = require('mongoose');
const ws = require('ws');
const keys = require('./config');
const cron = require('node-cron');
const { deleteExpiredCompetitions, deleteExpiredGroupCompetitions } = require('./cronJobs');
const cronSchedule = '*/1 * * * *';

const authRoutes = require('./routes/auth');
const compRoutes = require('./routes/comps');
const gCompRoutes = require('./routes/groupComps');
const friendshipRoutes = require('./routes/friendships');
const healthRoutes = require('./routes/health');

const app = express();
const wsApp = new ws.Server({ noServer: true});


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
  app.use('/health', healthRoutes);


  const job = cron.schedule(cronSchedule, () => {
    deleteExpiredCompetitions();
  });
  const job2 = cron.schedule(cronSchedule, () => {
    deleteExpiredGroupCompetitions();
  });
  
  job.start();
  job2.start();

  mongoose.connect(keys.mdbKey).then(result => {

    wsApp.on('connection', (socket) => {
      socket.on('message', message => console.log(message));
    })

    const server = app.listen(8080);
    server.on('upgrade', (request, socket, head) => {
      wsApp.handleUpgrade(request, socket, head, socket => {
        wsApp.emit('connection', socket, request)
      })
    })

  }).catch(e => {
    console.log(e);
  })