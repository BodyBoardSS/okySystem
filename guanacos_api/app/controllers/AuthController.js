const { User,UserRol, Rol } = require('../models/index')
const bcryp = require('bcrypt')
const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const storage = require('../ultils/cloud_storage')
const { Op } = require("sequelize");

module.exports = {

    //Login
    async signIn(req, res) {

        if(!req.body.email || !req.body.password){
            res.status(401).json({
                success: false,
                message: 'El usuario no fue encontrado',
                data: null
            })
            return
        }
        
        let { email, password } = req.body;

        await User.findOne({
            where: {
                email: email
            }
        }).then(user => {
            if (!user) {
                res.status(404).json({
                    success: false,
                    message: 'El usuario no fue encontrado',
                    data: null
                })
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
                            lastName: user.lastName,
                            email: user.email,
                            phone: user.phone,
                            image: user.image,
                            roles : user.roles,
                            session_token: `JWT ${token}`
                        }

                        res.status(201).json({
                            success: true,
                            message: 'El usuario fue autenticado.',
                            data: data
                        })
                    })
                } else {
                    res.status(401).json({
                        success: false,
                        message: 'El password es incorrecto',
                        data: null
                    })
                }
            }
        }).catch(err => {
            res.status(401).json({
                success: false,
                message: err,
                data: null
            })
        })

    },

    //Registro
    async signUp(req, res) {
        let password = bcryp.hashSync(req.body.password, Number.parseInt(authConfig.rounds))

        //Crear usuario
        await User.create({
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
                session_token: `JWT ${token}`
            }

            res.status(201).json({
                success: true,
                message: 'El registro se ingreso correctamente',
                data: data
            })
        }).catch(err => {
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    },

    //Register with image
    async signUpWithImage(req, res) {

        const userReq = JSON.parse(req.body.user);

        if(!userReq.email || !userReq.password || !userReq.name || !userReq.lastName || !userReq.phone){
            return res.status(401).json({
                success: false,
                message: "Faltan campos requeridos",
                data: []
            });
            
        }

        //Crear usuario
        let password = bcryp.hashSync(userReq.password, Number.parseInt(authConfig.rounds))
        let image = '';
        const files = req.files;
        let isExistUser = await User.count({ 
            where: {
                    [Op.or] : [
                            {email: userReq.email},
                            {phone: userReq.phone}
                    ]
            }
        })

        if(isExistUser == 1) {
            return res.status(409).json({
                success: false,
                message: 'Favor intente con un correo o telefono distinto.',
                data: []
            });
        } else {
            if(files)
                if(files.length > 0){
                    console.log(`files.length: ${files.length}`)
                    const path = `image_${Date.now()}`;
                    const url = await storage(files[0], path)
                    if(url != undefined && url != null)
                        image = url

                    console.log(`Image: ${image}`)
                }
    
            User.create({
                name: userReq.name,
                email: userReq.email,
                lastName: userReq.lastName,
                phone: userReq.phone,
                password: password,
                image: image
            }).then(user => {

                UserRol.create({
                    idRol:userReq.idrol,
                    idUser:user.id,
                });

                //Crear token
                let token = jwt.sign({ user: user }, authConfig.secret, {
                    expiresIn: authConfig.expires
                })
    
                const data = {
                    id: user.id,
                    name: user.name,
                    lastName: user.lastName,
                    email: user.email,
                    phone: user.phone,
                    image: user.image,
                    session_token: `JWT ${token}`
                }
    
                res.status(201).json({
                    success: true,
                    message: 'El registro se ingreso correctamente',
                    data: data
                })
    
            }).catch(err => {
                res.status(500).json({
                    success: false,
                    message: err,
                    data: []
                });
            })
        }
    }
}