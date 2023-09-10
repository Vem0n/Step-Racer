const express = require('express');
const { body } = require('express-validator');

const User = require('../models/user');
const authController = require('../controllers/auth');
const isAuth = require('../middlewares/isAuth');

const router = express.Router();
const auth =  isAuth;

router.put('/signup', [
    body('email').isEmail().withMessage('Enter a valid email').custom((value, { req }) => {
        return User.findOne({email: value}).then(userDoc => {
            if (userDoc) {
                return Promise.reject('There is an account assigned to this email')
            }
        })
    }).normalizeEmail(),
    body('password').trim().isLength({min: 5}),
    body('name').trim().not().isEmpty()
], authController.signup);

router.post('/login', authController.login);
router.delete('/:userId', auth, authController.deleteUser);
router.get('/OAuth', authController.OAuth);

module.exports = router;