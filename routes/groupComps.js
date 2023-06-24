const express = require('express');

const groupCompsController = require('../controllers/groupComps');
const isAuth = require('../middlewares/isAuth');

const router = express.Router();
const auth = isAuth;

router.get('/groupComps', auth, groupCompsController.getComps);
router.get('/groupComp/get/:gCompId', auth, groupCompsController.getComp);
router.post('/groupComp', auth, groupCompsController.createComp);
router.put('/groupComp/accept/:gCompId', auth, groupCompsController.acceptComp);
router.put('/groupComp/deny/:gCompId', auth, groupCompsController.denyComp);
router.put('/groupComp/update/:gCompId', auth, groupCompsController.updateComp);

module.exports = router;