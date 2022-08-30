const { User } = require('../models/index')

module.exports = {
    isAdmin(req, res, next) {
        if(User.isAdmin(req.user.roles))
            next()
        else 
            res.status(401).json({msg: "Permisos insuficientes"})
    }
}