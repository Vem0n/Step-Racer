// @ts-ignore
const { default: mongoose } = require('mongoose');
const Friendship = require('../models/friendship');
const User = require('../models/user');

exports.addFriend = async (req, res, next) => {
    try {
        const user1email = req.userEmail;
        const user1 = req.userId;
        const user2email = req.body.friendEmail;
        const user2found =  await User.findOne({ email: user2email });
        let user2;

        if (!user2found) {
            return res.status(404).json({ message: 'User not found' });
        }

        if (user2found) {
            user2 = user2found._id;
        }

        const friendship = new Friendship({
            user1: user1,
            user1email: user1email,
            user2: user2,
            user2email: user2email,
            status: "pending"
        })

        const owner1 = await User.findById(req.userId);
        const owner2 = user2found;

        if (owner1 && owner2) {
            // @ts-ignore
            owner1.friends.push(friendship);
            // @ts-ignore
            owner2.friends.push(friendship);
            await owner1.save();
            await owner2.save();
          }

        const result = await friendship.save();

        res.status(200).json({
            message: '🧑‍🤝‍🧑🔥🔥',
            item: friendship,
            owners: {_id1: owner1?._id, name1: owner1?.name, _id2: owner2?._id, name2: owner2.name }
        })

        console.log(result);

    } catch (error) {
        if (!error.statusCode) {
            error.statusCode = 500;
        }
        next(error);
    }
}

exports.deleteFriend = async (req, res, next) => {
    try {
        const friendId = req.params._id;

        const friendship = await Friendship.findById(friendId);

        if (!friendship) {
            return res.status(404).json({message: "No friend of this ID found"})
        }

        if (friendship?.user1.toString() !== req.userId || friendship?.user2.toString() !== req.userId) {
            return res.status(403).json({message: "Not authorized"})
        }

        const owner1 = await User.findById(friendship?.user1);
        const owner2 = await User.findById(friendship?.user2);

        await Friendship.findByIdAndRemove(friendId);
        if (owner1 && owner2) {
            // @ts-ignore
            owner1.friends.pull(friendId);
            await owner1.save();
            // @ts-ignore
            owner2.friends.pull(friendId);
            await owner2.save();
        }

        res.status(200).json({
            message: "Friend deleted successfuly"
        })

    } catch (error) {
        if (!error.statusCode) {
            error.statusCode = 500;
        }
        next(error);
    }
}

exports.acceptFriend = async (req, res, next) => {
    try {
        const friendId = req.params._id;

        const friendship = await Friendship.findById(friendId);

        if (!friendship) {
            return res.status(404).json({message: "No friend of this ID found"})
        }

        if (friendship?.user2.toString() !== req.userId) {
            return res.status(403).json({message: "Not authorized"})
        }

        friendship.status = 'accepted';
        await friendship.save();
    
        res.status(200).json({ message: "Friendship accepted", item: friendship });

    } catch (error) {
      if (!error.statusCode) {
        error.statusCode = 500;
      }
      next(error);
    }
  }

  exports.getFriends = async (req, res, next) => {
    try {
        const userId = req.userId;
        const results = await Friendship.find({
          $or: [{ owner1: userId }, { owner2: userId }],
        });
    
        if (!results || results.length === 0) {
          return res.status(404).json({ message: 'No items found'});
        }
    
        res.status(200).json({ message: 'Success', results: results });
      } catch (e) {
        if (!e.statusCode) {
          e.statusCode = 500;
        }
        next(e);
      }
  }