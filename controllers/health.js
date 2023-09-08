const { validationResult } = require('express-validator');

exports.checkHealth =  async (req, res, next) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(500)
        } else {
            return res.status(200)
        }
    } catch (e) {
        console.log(e);
        return res.status(500)
    }
}