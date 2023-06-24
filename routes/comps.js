const express = require('express');

const compsController = require('../controllers/comps');
const isAuth = require('../middlewares/isAuth');

const router = express.Router();
const auth = isAuth;

router.get('/competitions', auth, compsController.getComps);
router.get('/competition/get/:compId', auth, compsController.getComp);
router.post('/competition', auth, compsController.createComp);
router.put('/competition/accept/:compId', auth, compsController.acceptComp);
router.delete('/competition/deny/:compId', auth, compsController.denyComp);
router.put('/competition/update/:compId', auth, compsController.updateComp);

module.exports = router;