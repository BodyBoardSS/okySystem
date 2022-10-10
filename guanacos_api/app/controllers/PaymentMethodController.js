const { PaymentMethod } = require('../models/index')

module.exports = {
    async index(req, res) {
        let methods = await PaymentMethod.findAll()
        res.json(methods)
    },

    async create(req, res) {
        await PaymentMethod.create({
            name     : req.body.name
        }).then(method => {
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
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
        await PaymentMethod.update({
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
        await PaymentMethod.destroy({
            where: {
                id: id
            }
        }).then(function () {
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
        }).catch(function (err) {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    }
}