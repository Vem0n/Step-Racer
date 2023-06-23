const { default: mongoose } = require('mongoose');
const competition = require('../models/competition');
const Competition = require('../models/competition');
const User = require('../models/user');

exports.getComps = async (req, res, next) => {
    try {
      const userId = req.userId;
      const results = await Competition.find({
        $or: [{ owner1: userId }, { owner2: userId }],
      });
  
      if (!results || results.length === 0) {
        const error = new Error('404 No items found');
        res.status(404);
        throw error;
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
        const error = new Error('404 No item found');
        res.status(404);
        throw error;
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
      const owner1 = req.body.email1;
      const owner2 = req.body.email2;
      const length = req.body.compLength;
      const intervals = req.body.refreshIntervals;
      const startedAt = req.body.startedAt;

      const user1 = await User.findOne({ email: owner1 });
      const user2 = await User.findOne({ email: owner2 });
  
        if (!user1 || !user2) {
          throw new Error('One or both users not found');
        }
  
        const competition = new Competition({
          owner1: user1._id,
          owner2: user2._id,
          length: length,
          refreshIntervals: intervals,
          startedAt: startedAt,
          expiresAt: new Date(Date.now() + 5 * 60 * 1000)
        });
  
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
  
      const comp = await Competition.findById(compId);
  
      if (!comp) {
        throw new Error('Competition not found');
      }
  
      if (acceptedAt > comp.startedAt) {
        comp.startedAt = acceptedAt;
      }
  
      const lengthHours = parseInt(comp.length, 10);
      const endsAt = new Date(comp.startedAt.getTime() + lengthHours * 60 * 60 * 1000);
  
      if (endsAt.getDate() !== comp.startedAt.getDate()) {
        throw new Error('Adding length exceeds current day');
      }
  
      comp.endsAt = endsAt;
      comp.status = 'accepted';
  
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
  
      const comp = await Competition.findById(compId);
  
      if (!comp) {
        throw new Error('Competition not found');
      }
  
      const owner1 = await User.findById(comp.owner1);
      const owner2 = await User.findById(comp.owner2);
  
      if (!owner1 || !owner2) {
        throw new Error('Competition owners not found');
      }
  
      owner1.competitions.pull(compId);
      await owner1.save();
  
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
        stepsOwner1,
        stepsOwner2,
        owner1Status,
        owner2Status
      } = req.body;
  
      const updatedFields = {};
  
      if (stepsOwner1 !== undefined) {
        updatedFields.stepsOwner1 = stepsOwner1;
      }
  
      if (stepsOwner2 !== undefined) {
        updatedFields.stepsOwner2 = stepsOwner2;
      }
  
      if (owner1Status !== undefined) {
        updatedFields.owner1Status = owner1Status;
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
        throw new Error('Competition not found');
      }
  
      res.status(200).json({ message: 'Competition updated successfully', competition: updatedComp });
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
        throw new Error('Competition not found');
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
          throw new Error('Competition not found');
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
          throw new Error('Competition not found');
        }
  
        res.status(200).json({ message: 'Competition updated successfully', competition: updatedComp });
      } else {
        throw new Error('User is not authorized to update this competition');
      }
    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  };
  