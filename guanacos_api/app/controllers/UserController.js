const { User, UserRol, Rol } = require('../models/index')
const bcryp = require('bcrypt')
const jwt = require('jsonwebtoken')
const authConfig = require('../../config/auth')
const storage = require('../ultils/cloud_storage')
const { Op } = require("sequelize");

module.exports = {

    //Updated user with image
    async updateUserWithImage(req, res) {

        const userReq = JSON.parse(req.body.user);

        if (!userReq.name || !userReq.lastName || !userReq.phone) {
            return res.status(401).json({
                success: false,
                message: "Faltan campos requeridos",
                data: []
            });

        }


        if (files)
            if (files.length > 0) {
                console.log(`files.length: ${files.length}`)
                const path = `image_${Date.now()}`;
                const url = await storage(files[0], path)
                if (url != undefined && url != null)
                    image = url

                console.log(`Image: ${image}`)
            }

        User.update({
            name: userReq.name,
            lastName: userReq.lastName,
            phone: userReq.phone,
            image: image
        },
        {
            where: { id: userReq.id }
        }).then(async u => {
            User.findByPk(userReq.id, {
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
                    session_token: userReq.session_token
                }

                res.status(201).json({
                    success: true,
                    message: 'El usuario fue autenticado.',
                    data: data
                })
            })

        }).catch(err => {
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    },

    //Updated user withOut image
    async update(req, res) {

        const userReq = req.body;

        if (!userReq.name || !userReq.lastName || !userReq.phone) {
            return res.status(401).json({
                success: false,
                message: "Faltan campos requeridos",
                data: []
            });

        }

        User.update({
            name: userReq.name,
            lastName: userReq.lastName,
            phone: userReq.phone
        },
        {
            where: { id: userReq.id }
        }).then(async myUser => {
            User.findByPk(userReq.id, {
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
                    session_token: userReq.session_token
                }

                res.status(201).json({
                    success: true,
                    message: 'El usuario fue autenticado.',
                    data: data
                })
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