const { User, Rol } = require('../models/index')
const storage = require('../ultils/cloud_storage')

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

        let image = '';
        const files = req.files;

        if (files)
            if (files.length > 0) {
                try {
                    const path = `image_${Date.now()}`;
                    const url = await storage(files[0], path)
                    if (url != undefined && url != null)
                        image = url    
                } catch (error) {
                    console.log(`Ocurrio un error ${error}`)
                }
            }

        await User.update({
            name: userReq.name,
            lastName: userReq.lastName,
            phone: userReq.phone,
            image: image
        },
        {
            where: { id: userReq.id }
        }).then(async u => {
            await User.findByPk(userReq.id, {
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
                    message: 'El usuario fue modificado.',
                    data: data
                })
            }).catch(err => {
                console.log(`Ocurrio un error ${err}`)
                res.status(500).json({
                    success: false,
                    message: err,
                    data: []
                });
            })
        }).catch(err => {
            console.log(`Ocurrio un error ${err}`)
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

        await User.update({
            name: userReq.name,
            lastName: userReq.lastName,
            phone: userReq.phone,
            notificationToken: userReq.notificationToken
        },
        {
            where: { id: userReq.id }
        }).then(async myUser => {
            await User.findByPk(userReq.id, {
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
                    notificationToken: user.notificationToken,
                    session_token: userReq.session_token
                }

                res.status(201).json({
                    success: true,
                    message: 'El usuario fue modificado.',
                    data: data
                })
            })
        }).catch(err => {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    },

    async finByRol(req, res){
        let users = await User.findAll({
            include: {
                model:Rol,
                as:"roles",
                where:{
                    rol: req.params.rol
                },
                attributes : [ 'id' ],
                required : true
            }
        });
        res.json(users)
    }
}