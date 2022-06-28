const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const { Usuario } = require('../models/index')

module.exports = (req, res, next) => {
    //console.log(req.headers)

    //Comprobar que existe token
    if (!req.headers.authorization) {
        res.status(401).json({ msg: "Acceso no autorizado" })
    } else {
        //Comprobar la valides de este token
        let token = req.headers.authorization.split(" ")[1]

        jwt.verify(token, authConfig.secret, (err, decode) => {
            if (err)
                res.status(500).json({ msg: "Ha ocurrido un problema al decodificar el token", err })
            else{
                Usuario.findByPk(decode.usuario.id, {include: "roles"}).theconst jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const { Usuario } = require('../models/index')

module.exports = (req, res, next) => {
    //console.log(req.headers)

    //Comprobar que existe token
    if (!req.headers.authorization) {
        res.status(401).json({ msg: "Acceso no autorizado" })
    } else {
        //Comprobar la valides de este token
        let token = req.headers.authorization.split(" ")[1]

        jwt.verify(token, authConfig.secret, (err, decode) => {
            if (err)
                res.status(500).json({ msg: "Ha ocurrido un problema al decodificar el token", err })
            else{
                Usuario.findByPk(decode.usuario.id, {include: "roles"}).then( usuario => {
                    req.usuario = usuario;
                    next();
                }).catch(function (err) {
                    console.log(`Error = ${err}`);
                    res.status(500).json({ error: "Ocurrio un error interno." });
                })
            }
        })
    }
}