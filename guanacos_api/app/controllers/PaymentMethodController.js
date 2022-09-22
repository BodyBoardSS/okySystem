const { PaymentMethod } = require('../models/index')

module.exports = {
    async index(req, res) {
        let methods = await PaymentMethod.findAll()
        res.json(methods)
    },

    create(req, res) {
        PaymentMethod.create({
            name     : req.body.name
        }).then(method => {
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
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
        PaymentMethod.update({
            name     : req.body.name
        },
            {
                where: { id: id }
            }
        ).then(function () {
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
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
        PaymentMethod.destroy({
            where: {
                id: id
            }
        }).then(function () {
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
        }).catch(function (err) {
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    }
}