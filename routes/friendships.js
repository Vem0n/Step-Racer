const express = require('express');

const friendsController = require('../controllers/friendship');
const isAuth = require('../middlewares/isAuth');

const router = express.Router();
const auth = isAuth;

router.post('/friend', auth, friendsController.addFriend);
router.delete('/friend/:friendId', auth, friendsController.deleteFriend);
router.put('/friend/:friendId', auth, friendsController.acceptFriend);
router.get('/friends', auth, friendsController.getFriends);

module.exports = router;