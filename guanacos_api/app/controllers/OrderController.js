const { Order, User, PaymentMethod, OrderDetail } = require('../models/index')

module.exports = {
    async index(req, res) {
        let orders = await Order.findAll({
            include: [{
                model: User,
                as: "user",
                attributes: ['name']
            }, {
                model: PaymentMethod,
                as: "metodo",
                attributes: ['name']
            }, {
                model: OrderDetail,
                as: "detalle",
                attributes: ['idproduct', 'quantity', 'price']
            }]
        })
        res.json(orders)
    },

    create(req, res) {
        Order.create({
            totalorder: req.body.totalorder,
            schedule: req.body.schedule,
            description: req.body.description,
            address: req.body.address,
            idmethod: req.body.metodo.idmethod,
            iduser: req.body.usuario.iduser
        }).then(product => {
    
            for (var key in req.body.detail) {
                if (req.body.detail.hasOwnProperty(key)) {
                    OrderDetail.create({
                        quantity: req.body.detail[key].quantity,
                        price: req.body.detail[key].price,
                        idproduct: req.body.detail[key].idproduct,
                        idorder: product.id
                    }).then(detail => {
                        console.log(`Se creo detalle ${detail}`);
                    }).catch(function (err) {
                        console.log(`Se ha producido un error: ${err}`);
                    });
                }
            }
            res.json(product);
            console.log(`Project with id = ${product.name} created successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    update(req, res) {
        const { id } = req.params;
        Order.update({
            name: req.body.anme,
            precio: req.body.precio,
            description: req.body.description,
            image: req.body.image,
            categoryid: req.body.categoryid
        },
            {
                where: { id: id }
            }
        ).then(function () {
            res.json({ message: "Updated successfully" });
            console.log(`Project with id = ${id} updated successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser actualizado." + err });
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
            console.log(`Project with id = ${id} deleted successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser eliminado." });
        })
    }
}