const { User,UserRol, Rol } = require('../models/index')
const bcryp = require('bcrypt')
const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const storage = require('../ultils/cloud_storage')
const { Op } = require("sequelize");

module.exports = {

    //Login
    signIn(req, res) {

        if(!req.body.email || !req.body.password){
            res.status(401).json("Faltan campos requeridos")
            return
        }
        
        let { email, password } = req.body;

        User.findOne({
            where: {
                email: email
            }
        }).then(user => {
            if (!user) {
                res.status(404).json({ msg: "El usuario no fue encontrado" })
            } else {
                if (bcryp.compareSync(password, user.password)) {
                    //Crear token
                    let token = jwt.sign({ user: user }, authConfig.secret, {
                        expiresIn: authConfig.expires
                    })
                    
                    User.findByPk(user.id, {
                        include: {model:Rol ,as:"roles", attributes:['id','rol','image','route']}
                    }).then( user => {
                        const data = {
                            id: user.id,
                            name: user.name,
                            lastname: user.lastname,
                            email: user.email,
                            phone: user.phone,
                            image: user.image,
                            roles : user.roles,
                            session_token: token
                        }

                        res.status(201).json({
                            success: true,
                            message: 'El usuario fue autenticado.',
                            data: data
                        })
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
        User.create({
            name: req.body.name,
            email: req.body.email,
            lastName: req.body.lastName,
            phone: req.body.phone,
            password: password
        }).then(user => {

            //Crear token
            let token = jwt.sign({ user: user }, authConfig.secret, {
                expiresIn: authConfig.expires
            })

            const data = {
                id: user.id,
                name: user.name,
                lastname: user.lastname,
                email: user.email,
                phone: user.phone,
                image: user.image,
                session_token: token
            }

            res.status(201).json({
                success: true,
                message: 'El registro se ingreso correctamente',
                data: data
            })
        }).catch(err => {
            res.status(500).json(err)
        })
    },

    //Register with image
    async signUpWithImage(req, res) {

        if(!req.body.email || !req.body.password || !req.body.name || !req.body.lastName || req.body.phone){
            res.status(401).json("Faltan campos requeridos")
            return
        }

        //Crear usuario
        let password = bcryp.hashSync(req.body.password, Number.parseInt(authConfig.rounds))
        let image = '';
        const files = req.files;
        let isExistUser = await User.count({ 
            where: {
                    [Op.or] : [
                            {email: req.body.email},
                            {phone: req.body.phone}
                    ]
            }
        })

        if(isExistUser == 1) {
            return res.status(409).json({
                success: false,
                message: 'Favor intente con un correo o telefono distinto.'
            });
        } else {
            if(files.length > 0){
                const path = `image_${Date.now()}`;
                const url = await storage(files[0], path)
                if(url != undefined && url != null)
                    image = url
            }
    
            User.create({
                name: req.body.name,
                email: req.body.email,
                lastName: req.body.lastName,
                phone: req.body.phone,
                password: password,
                image: image
            }).then(user => {

                UserRol.create({
                    idRol:req.body.idrol,
                    idUser:user.id,
                });

                //Crear token
                let token = jwt.sign({ user: user }, authConfig.secret, {
                    expiresIn: authConfig.expires
                })
    
                const data = {
                    id: user.id,
                    name: user.name,
                    lastname: user.lastname,
                    email: user.email,
                    phone: user.phone,
                    image: user.image,
                    session_token: token
                }
    
                res.status(201).json({
                    success: true,
                    message: 'El registro se ingreso correctamente',
                    data: data
                })
    
            }).catch(err => {
                res.status(500).json(err)
            })
        }
    }
}