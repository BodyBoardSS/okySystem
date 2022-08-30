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
            console.log(`Project with id = ${method.name} created successfully!`);
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser creado." });
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
            console.log(`Project with id = ${id} updated successfully!`);
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser actualizado."+ err});
        });
    },

    delete(req, res) {
        const { id } = req.params;
        PaymentMethod.destroy({
            where: {
                id: id
            }
        }).then(function () {
            console.log(`Project with id = ${id} deleted successfully!`);
            PaymentMethod.findAll().then(methods => {
                res.json(methods);
            });
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser eliminado." });
        })
    }
}