const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const { User } = require('../models/index')

module.exports = (req, res, next) => {
    //console.log(req.headers)

    //Comprobar que existe token
    if (!req.headers.authorization) {
        res.status(401).json({
            success: false,
            message: "Acceso no autorizado",
            data: []
        });
    } else {
        //Comprobar la valides de este token
        let token = req.headers.authorization.split(" ")[1]
        jwt.verify(token, authConfig.secret, (err, decode) => {
            if (err)
                res.status(500).json({
                    success: false,
                    message: `Ha ocurrido un problema al decodificar el token: ${err}`,
                    data: []
                });
            else{
                User.findByPk(decode.user.id, {include: "roles"}).then( user => {
                    req.user = user;
                    next();
                }).catch(function (err) {
                    console.log(`Error = ${err}`);
                    res.status(500).json({
                        success: false,
                        message: err,
                        data: []
                    });
                })
            }
        })
    }
}