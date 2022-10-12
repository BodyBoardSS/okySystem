const { Order, OrderDetail,User, Address, Product} = require('../models/index');
const PushNotificationController = require('../controllers/PushNotificationController')

module.exports = {
    async index(req, res) {
        let orders = await Order.findAll()
        res.json(orders)
    },

    async create(req, res) {
        await Order.create({
            lat: req.body.lat,
            lng: req.body.lng,
            status: req.body.status,
            createdDate: Date.now(),
            total:req.body.total,
            idclient: req.body.idclient,
            idaddress: req.body.idaddress
        }).then(async order => {
    
            for (var key in req.body.detail) {
                if (req.body.detail.hasOwnProperty(key)) {
                    OrderDetail.create({
                        quantity: req.body.detail[key].quantity,
                        idproduct: req.body.detail[key].id,
                        idorder: order.id
                    }).then(detail => {
                        console.log(`Se creo detalle ${detail}`);
                    }).catch(function (err) {
                        console.log(`Se ha producido un error: ${err}`);
                    });
                }
            }

            let users = await User.findAll({
                where:{
                    id:1
                }
            })
            
            try {
                if(users !== undefined && users != null){
                    if(users.length > 0){
                        let tokens = []
                        users.forEach(u => {
                            tokens.push(u.notificationToken)
                            console.log(`Token: ${u.notificationToken}`)
                        });
                        
                        PushNotificationController.sendNotificationMultipleDevices(tokens,{
                            title:'Compra Realizada',
                            body:'Un cliente ha realizado una compra.',
                            id_notification:'2'
                        })
                    }
                }   
            } catch (error) {
                console.log(`Ocurrio un error al intentar enviar notificaciones: ${error}`)
            }

            res.status(201).json({
                success: true,
                message: 'La orden fue creada con éxito.',
                data: order
            })
        }).catch(function (err) {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        });
    },

    async update(req, res) {
        const { id } = req.params;
        await Order.update({
            status: req.body.status,
            updatedAt: new Date(),
            iddelivery: req.body.iddelivery,
            lat:req.body.lat,
            lng:req.body.lng,
        },
            {
                where: { id: id }
            }
        ).then(async function () {
            if(req.body.status !== undefined){
                if(req.body.status === 'DESPACHADO'){
                    let user = await User.findByPk(req.body.iddelivery);
                    if(user !== undefined && user != null){
                        PushNotificationController.sendNotification(tokeuser.notificationTokenNoti,{
                            title:'Pedido Asignado',
                            body:'Se le ha asignado un pedido para ser entregado.',
                            id_notification:'1'
                        })
                    }
                }
            }

            res.status(201).json({
                success: true,
                message: 'La orden fue actualizada con éxito.',
                data: id
            })
        }).catch(function (err) {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        });
    },

    async delete(req, res) {
        const { id } = req.params;
        await Order.destroy({
            where: {
                id: id
            }
        }).then(function () {
            res.json({ message: "Deleted successfully" });
        }).catch(function (err) {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    },
    async find(req, res, next) {
        let order = await Order.findByPk(req.params.id);
        if (!order)
            res.status(404).json({
                success: false,
                message: "La orden no existe",
                data: []
            });
        else {
            req.order = order;
            next();
        }
    },

    async findByStatus(req, res) {
        let orders = await Order.findAll(
            {
                where:{
                    status:req.params.status
                },
                include: [
                    {model:User ,as:"client"},
                    {model:Address ,as:"address"},
                    {model:User ,as:"delivery"},
                    {model:Product ,as:"products"},
                ]
            }
        );

        res.json(orders);
    },

    async findByIdDelivery(req, res) {
        let orders = await Order.findAll(
            {
                where:{
                    status:req.params.status
                },
                include: [
                    {model:User ,as:"client"},
                    {model:Address ,as:"address"},
                    {
                        model:User ,
                        as:"delivery",
                        where:{
                            id:req.params.idDelivery
                        }
                    },
                    {model:Product ,as:"products"},
                ]
            }
        );

        res.json(orders);
    },

    async findByIdClient(req, res) {
        let orders = await Order.findAll(
            {
                where:{
                    status:req.params.status
                },
                include: [
                    {model:User ,as:"client",
                    where:{
                        id:req.params.iduser
                    }},
                    {model:Address ,as:"address"},
                    {
                        model:User ,
                        as:"delivery",
                        
                    },
                    {model:Product ,as:"products"},
                ]
            }
        );

        res.json(orders);
    }
}