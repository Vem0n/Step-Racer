const { default: mongoose } = require('mongoose');
const Competition = require('../models/groupCompetitions');
const User = require('../models/user');

exports.getComps = async (req, res, next) => {
    try {
      const userId = req.userId;
      const results = await Competition.find({
        $or: [
          { owner1: userId },
          { owner2: userId },
          { owner3: userId },
          { owner4: userId },
          { owner5: userId },
          { owner6: userId }
        ],
      });
  
      if (!results || results.length === 0) {
        return res.status(404).json({message: 'No items found'});
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
        return res.status(404).json({message: 'No item found'});
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
          return res.status(404).json({message: "One or both users not found"})
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
        user1.groupCompetitions.push(competition)
        // @ts-ignore
        user2.groupCompetitions.push(competition)
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
  
      let updatedFields = {};
  
      switch (userId) {
        case comp.owner2:
          updatedFields.user2AcceptedStatus = 'accepted';
          break;
        case comp.owner3:
          updatedFields.user3AcceptedStatus = 'accepted';
          break;
        case comp.owner4:
          updatedFields.user4AcceptedStatus = 'accepted';
          break;
        case comp.owner5:
          updatedFields.user5AcceptedStatus = 'accepted';
          break;
        case comp.owner6:
          updatedFields.user6AcceptedStatus = 'accepted';
          break;
        default:
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
  
      Object.assign(comp, updatedFields);
  
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
        return res.status(404).json({message: 'No competition found'})
      }
  
      const updatedFields = {};
  
      if (req.userId === comp.owner2) {
        updatedFields.user2AcceptedStatus = 'denied';
      } else if (req.userId === comp.owner3) {
        updatedFields.user3AcceptedStatus = 'denied';
      } else if (req.userId === comp.owner4) {
        updatedFields.user4AcceptedStatus = 'denied';
      } else if (req.userId === comp.owner5) {
        updatedFields.user5AcceptedStatus = 'denied';
      } else if (req.userId === comp.owner6) {
        updatedFields.user6AcceptedStatus = 'denied';
      } else {
        return res.status(403).json({message: 'Not authorized'})
      }
  
      Object.assign(comp, updatedFields);
      const result = await comp.save();
  
      const allDenied =
        comp.user2AcceptedStatus === 'denied' &&
        (comp.user3AcceptedStatus === 'denied' || comp.user3AcceptedStatus === null) &&
        (comp.user4AcceptedStatus === 'denied' || comp.user4AcceptedStatus === null) &&
        (comp.user5AcceptedStatus === 'denied' || comp.user5AcceptedStatus === null) &&
        (comp.user6AcceptedStatus === 'denied' || comp.user6AcceptedStatus === null);
  
      if (allDenied) {
        await Competition.findByIdAndRemove(compId);
      }
  
      res.status(200).json({ message: '🤖🫳🗑️', result: result });
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
      owner3,
      owner4,
      owner5,
      owner6,
      stepsOwner1,
      stepsOwner2,
      stepsOwner3,
      stepsOwner4,
      stepsOwner5,
      stepsOwner6,
      owner1Status,
      owner2Status,
      owner3Status,
      owner4Status,
      owner5Status,
      owner6Status
    } = req.body;

    const comp = await Competition.findById(compId);

    if (!comp) {
      return res.status(404).json({message: 'No competition found'})
    }

    let updatedFields = {};

    switch (userId) {
      case comp.owner1:
        if (stepsOwner1 !== undefined && comp.stepsOwner1 !== null && comp.stepsOwner1 !== '0') {
          updatedFields.stepsOwner1 = (parseInt(stepsOwner1) - parseInt(comp.stepsOwner1)).toString();
        } else if (comp.stepsOwner1 === null) {
          updatedFields.stepsOwner1 = '0';
          updatedFields.initialSteps1 = stepsOwner1.toString();
        } else if (comp.stepsOwner1 === '0') {
          updatedFields.stepsOwner1 = (parseInt(stepsOwner1) - parseInt(comp.stepsOwner1)).toString();
        }
        if (owner1Status !== undefined) {
          updatedFields.owner1Status = owner1Status;
        }
        break;
    
      case comp.owner2:
        if (stepsOwner2 !== undefined && comp.stepsOwner2 !== null && comp.stepsOwner2 !== '0') {
          updatedFields.stepsOwner2 = (parseInt(stepsOwner2) - parseInt(comp.stepsOwner2)).toString();
        } else if (comp.stepsOwner2 === null) {
          updatedFields.stepsOwner2 = '0';
          updatedFields.initialSteps2 = stepsOwner2.toString();
        } else if (comp.stepsOwner2 === '0') {
          updatedFields.stepsOwner2 = (parseInt(stepsOwner2) - parseInt(comp.stepsOwner2)).toString();
        }
        if (owner2Status !== undefined) {
          updatedFields.owner2Status = owner2Status;
        }
        break;
    
      case comp.owner3:
        if (stepsOwner3 !== undefined && comp.stepsOwner3 !== null && comp.stepsOwner3 !== '0') {
          updatedFields.stepsOwner3 = (parseInt(stepsOwner3) - parseInt(comp.stepsOwner3)).toString();
        } else if (comp.stepsOwner3 === null) {
          updatedFields.stepsOwner3 = '0';
          updatedFields.initialSteps3 = stepsOwner3.toString();
        } else if (comp.stepsOwner3 === '0') {
          updatedFields.stepsOwner3 = (parseInt(stepsOwner3) - parseInt(comp.stepsOwner3)).toString();
        }
        if (owner3Status !== undefined) {
          updatedFields.owner3Status = owner3Status;
        }
        break;
    
      case comp.owner4:
        if (stepsOwner4 !== undefined && comp.stepsOwner4 !== null && comp.stepsOwner4 !== '0') {
          updatedFields.stepsOwner4 = (parseInt(stepsOwner4) - parseInt(comp.stepsOwner4)).toString();
        } else if (comp.stepsOwner4 === null) {
          updatedFields.stepsOwner4 = '0';
          updatedFields.initialSteps4 = stepsOwner4.toString();
        } else if (comp.stepsOwner4 === '0') {
          updatedFields.stepsOwner4 = (parseInt(stepsOwner4) - parseInt(comp.stepsOwner4)).toString();
        }
        if (owner4Status !== undefined) {
          updatedFields.owner4Status = owner4Status;
        }
        break;
    
      case comp.owner5:
        if (stepsOwner5 !== undefined && comp.stepsOwner5 !== null && comp.stepsOwner5 !== '0') {
          updatedFields.stepsOwner5 = (parseInt(stepsOwner5) - parseInt(comp.stepsOwner5)).toString();
        } else if (comp.stepsOwner5 === null) {
          updatedFields.stepsOwner5 = '0';
          updatedFields.initialSteps5 = stepsOwner5.toString();
        } else if (comp.stepsOwner5 === '0') {
          updatedFields.stepsOwner5 = (parseInt(stepsOwner5) - parseInt(comp.stepsOwner5)).toString();
        }
        if (owner5Status !== undefined) {
          updatedFields.owner5Status = owner5Status;
        }
        break;
    
      case comp.owner6:
        if (stepsOwner6 !== undefined && comp.stepsOwner6 !== null && comp.stepsOwner6 !== '0') {
          updatedFields.stepsOwner6 = (parseInt(stepsOwner6) - parseInt(comp.stepsOwner6)).toString();
        } else if (comp.stepsOwner6 === null) {
          updatedFields.stepsOwner6 = '0';
          updatedFields.initialSteps6 = stepsOwner6.toString();
        } else if (comp.stepsOwner6 === '0') {
          updatedFields.stepsOwner6 = (parseInt(stepsOwner6) - parseInt(comp.stepsOwner6)).toString();
        }
        if (owner6Status !== undefined) {
          updatedFields.owner6Status = owner6Status;
        }
        break;
    }
    

    if (owner3) {
      const owner3User = await User.findOne({ email: owner3 });
      if (owner3User) {
        updatedFields.owner3 = owner3User._id;
        updatedFields.user3AcceptedStatus = "pending";
        owner3User.competitions.push(compId);
        await owner3User.save();
      }
    }

    if (owner4) {
      const owner4User = await User.findOne({ email: owner4 });
      if (owner4User) {
        updatedFields.owner4 = owner4User._id;
        updatedFields.user4AcceptedStatus = "pending";
        owner4User.competitions.push(compId);
        await owner4User.save();
      }
    }

    if (owner5) {
      const owner5User = await User.findOne({ email: owner5 });
      if (owner5User) {
        updatedFields.owner5 = owner5User._id;
        updatedFields.user5AcceptedStatus = "pending";
        owner5User.competitions.push(compId);
        await owner5User.save();
      }
    }

    if (owner6) {
      const owner6User = await User.findOne({ email: owner6 });
      if (owner6User) {
        updatedFields.owner6 = owner6User._id;
        updatedFields.user6AcceptedStatus = "pending";
        owner6User.competitions.push(compId);
        await owner6User.save();
      }
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
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500;
    }
    next(error);
  }
};