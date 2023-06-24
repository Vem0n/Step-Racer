// @ts-ignore
const { default: mongoose } = require('mongoose');
const Competition = require('../models/competition');
const User = require('../models/user');

exports.getComps = async (req, res, next) => {
    try {
      const userId = req.userId;
      const results = await Competition.find({
        $or: [{ owner1: userId }, { owner2: userId }],
      });
  
      if (!results || results.length === 0) {
        return res.status(404).json({message: 'No competition found'})
      }
  
      res.status(200).json({ message: 'Success', results: results });
    } catch (e) {
      if (!e.statusCode) {
        e.statusCode = 500;
      }
      next(e);
    }
  };

  exports.getComp = async (req, res, next) => {
    try {
      const compId = req.params.compId;
  
      const result = await Competition.findById(compId);
      
      if (!result) {
        return res.status(404).json({message: 'No competition found'})
      }
  
      res.status(200).json({ message: 'Success', result: result });
    } catch (e) {
      if (!e.statusCode) {
        e.statusCode = 500;
      }
      next(e);
    }
  };

  exports.createComp = async (req, res, next) => {
    try {
      const owner1 = req.userId;
      const owner2 = req.body.email2;
      const length = req.body.compLength;
      const intervals = req.body.refreshIntervals;
      const startedAt = req.body.startedAt;

      const user1 = await User.findById(owner1);
      const user2 = await User.findOne({ email: owner2 });
  
        if (!user1 || !user2) {
          return res.status(404).json({message: 'One or both users not found'})
        }
  
        const competition = new Competition({
          owner1: user1._id,
          owner2: user2._id,
          length: length,
          refreshIntervals: intervals,
          startedAt: startedAt,
          expiresAt: new Date(Date.now() + 5 * 60 * 1000),
          userAcceptedStatus: 'pending'
        });
  
        // @ts-ignore
        const result = competition.save();

      if (user1 && user2) {
        // @ts-ignore
        user1.competitions.push(competition)
        // @ts-ignore
        user2.competitions.push(competition)
      }
  
      res.status(200).json({ message: '👷‍♂️👍', competition: competition });
    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  };

  exports.acceptComp = async (req, res, next) => {
    try {
      const compId = req.params._id;
      const acceptedAt = req.body.acceptedAt;
      const userId = req.userId;
  
      const comp = await Competition.findById(compId);
  
      if (!comp) {
        return res.status(404).json({message: 'No competition found'})
      }
  
      if (userId.toString() !== comp.owner2.toString()) {
        return res.status(403).json({ message: 'User is not authorized to accept this competition' });
      }
  
      if (acceptedAt > comp.startedAt) {
        comp.startedAt = acceptedAt;
      }
  
      const lengthHours = parseInt(comp.tLength, 10);
      const endsAt = new Date(comp.startedAt.getTime() + lengthHours * 60 * 60 * 1000);
  
      if (endsAt.getDate() !== comp.startedAt.getDate()) {
        return res.status(400).json({message: 'Adding length exceeds current day'})
      }
  
      comp.endsAt = endsAt;
      comp.status = 'accepted';
      comp.userAcceptedStatus = 'accepted';
  
      const result = await comp.save();
  
      res.status(200).json({ message: '😎🤝👽', competition: result });
    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  };
  

  exports.denyComp = async (req, res, next) => {
    try {
      const compId = req.params._id;
      const userId = req.userId;
  
      const comp = await Competition.findById(compId);
  
      if (!comp) {
        return res.status(404).json({message: 'No competition found'})
      }

      if (userId.toString() !== comp.owner2.toString()) {
        return res.status(403).json({ message: 'User is not authorized to deny this competition' });
      }
  
      const owner1 = await User.findById(comp.owner1);
      const owner2 = await User.findById(comp.owner2);
  
      if (!owner1 || !owner2) {
        return res.status(404).json({message: 'One or both users ont found'})
      }
  
      // @ts-ignore
      owner1.competitions.pull(compId);
      await owner1.save();
  
      // @ts-ignore
      owner2.competitions.pull(compId);
      await owner2.save();
  
      await Competition.findByIdAndRemove(compId);
  
      res.status(200).json({ message: '🤖🫳🗑️' });
    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  };
  
  exports.updateComp = async (req, res, next) => {
    try {
      const compId = req.params._id;
      const {
        userId,
        stepsOwner1,
        stepsOwner2,
        owner1Status,
        owner2Status
      } = req.body;
  
      const comp = await Competition.findById(compId);
  
      if (!comp) {
        return res.status(404).json({message: 'No competition found'})
      }
  
      if (userId === comp.owner1) {
        const updatedFields = {};
  
        if (stepsOwner1 !== undefined) {
          updatedFields.stepsOwner1 = stepsOwner1;
        }
  
        if (owner1Status !== undefined) {
          updatedFields.owner1Status = owner1Status;
        }
  
        const updatedComp = await Competition.findByIdAndUpdate(
          compId,
          { $set: updatedFields },
          { new: true }
        );
  
        if (!updatedComp) {
          return res.status(404).json({message: 'No competition found'})
        }
  
        res.status(200).json({ message: 'Competition updated successfully', competition: updatedComp });
      }
      else if (userId === comp.owner2) {
        const updatedFields = {};
  
        if (stepsOwner2 !== undefined) {
          updatedFields.stepsOwner2 = stepsOwner2;
        }
  
        if (owner2Status !== undefined) {
          updatedFields.owner2Status = owner2Status;
        }
  
        const updatedComp = await Competition.findByIdAndUpdate(
          compId,
          { $set: updatedFields },
          { new: true }
        );
  
        if (!updatedComp) {
          return res.status(404).json({message: 'No competition found'})
        }
  
        res.status(200).json({ message: 'Competition updated successfully', competition: updatedComp });
      } else {
        return res.status(403).json({message: 'Not Authorized'})
      }
    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  };

  