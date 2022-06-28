const { Usuario } = require('../models/index')
const bcryp = require('bcrypt')
const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')

module.exports = {

    //Login
    signIn(req, res) {
        let { email, password } = req.body;

        Usconst { Usuario } = require('../models/index')
const bcryp = require('bcrypt')
const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')

module.exports = {

    //Login
    signIn(req, res) {
        let { email, password } = req.body;

        Usuario.findOne({
            where: {
                email: email
            }
        }).then(usuario => {
            if (!usuario) {
                res.status(404).json({ msg: "El usuario no fue encontrado" })
            } else {
                console.log(usuario.nombre)
                if (bcryp.compareSync(password, usuario.password)) {
                    //Crear token
                    let token = jwt.sign({ usuario: usuario }, authConfig.secret, {
                        expiresIn: authConfig.expires
                    })

                    res.json({
                        usuario: usuario,
                        token: token
                    })
                } else {
                    res.status(401).json({ msg: "El password es incorrecto" })
                }
            }
        }).catch(err => {
            res.status(500).json(err)
        })

    },

    //Registro
    signUp(req, res) {
        let password = bcryp.hashSync(req.body.password, Number.parseInt(authConfig.rounds))

        //Crear usuario
        Usuario.create({
            nombre: req.body.nombre,
            email: req.body.email,
            password: password
        }).then(usuario => {

            //Crear token
            let token = jwt.sign({ usuario: usuario }, authConfig.secret, {
                expiresIn: authConfig.expires
            })

            res.json({
                usuario: usuario,
                token: token
            })
        }).catch(err => {
            res.status(500).json(err)
        })
    }
}