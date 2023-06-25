const cron = require('node-cron');
const Competition = require('./models/competition');
const gCompetition = require('./models/groupCompetitions');

const deleteExpiredCompetitions = async () => {
  try {
    const expiredCompetitions = await Competition.find({
      status: 'pending',
      expiresAt: { $lte: new Date() }
    });

    await Competition.deleteMany({ _id: { $in: expiredCompetitions.map(c => c._id) } });

    console.log(`Deleted ${expiredCompetitions.length} expired competitions.`);
  } catch (error) {
    console.error('Error deleting expired competitions:', error);
  }
};

const deleteExpiredGroupCompetitions = async () => {
  try {
    const expiredGroupCompetitions = await gCompetition.find({
      status: 'pending',
      expiresAt: { $lte: new Date() }
    });

    await gCompetition.deleteMany({ _id: { $in: expiredGroupCompetitions.map(c => c._id) } });

    console.log(`Deleted ${expiredGroupCompetitions.length} expired competitions.`);
  } catch (error) {
    console.error('Error deleting expired competitions:', error);
  }
};

module.exports = { 
  deleteExpiredGroupCompetitions, 
  deleteExpiredCompetitions
};
