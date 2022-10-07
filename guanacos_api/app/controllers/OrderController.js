const { Order, OrderDetail,User, Address, Product} = require('../models/index');

module.exports = {
    async index(req, res) {
        let orders = await Order.findAll()
        res.json(orders)
    },

    create(req, res) {
        Order.create({
            lat: req.body.lat,
            lng: req.body.lng,
            status: req.body.status,
            createdDate: Date.now(),
            idclient: req.body.idclient,
            idaddress: req.body.idaddress
        }).then(order => {
    
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

            res.status(201).json({
                success: true,
                message: 'La orden fue creada con éxito.',
                data: order
            })
        }).catch(function (err) {
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        });
    },

    update(req, res) {
        const { id } = req.params;
        Order.update({
            status: req.body.status,
            updatedAt: new Date(),
            iddelivery: req.body.iddelivery,
            lat:req.body.lat,
            lng:req.body.lng,
        },
            {
                where: { id: id }
            }
        ).then(function () {
            res.status(201).json({
                success: true,
                message: 'La orden fue actualizada con éxito.',
                data: id
            })
        }).catch(function (err) {
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        });
    },

    delete(req, res) {
        const { id } = req.params;
        Order.destroy({
            where: {
                id: id
            }
        }).then(function () {
            res.json({ message: "Deleted successfully" });
        }).catch(function (err) {
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

    async findByIdUser(req, res) {
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
                            id:req.params.iduser
                        }
                    },
                    {model:Product ,as:"products"},
                ]
            }
        );

        res.json(orders);
    }
}