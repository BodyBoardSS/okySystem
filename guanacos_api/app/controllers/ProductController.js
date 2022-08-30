const { Category, Product } = require('../models/index')

module.exports = {
    async index(req, res) {
        let products = await Producto.findAll({
            include: {
                model: Category,
                as: "category",
                attributes: ['name']
            }
        })
        res.json(products)
    },

    create(req, res) {
        Product.create({
            name: req.body.name,
            price: req.body.price,
            description: req.body.description,
            image: req.body.image,
            categoryid: req.body.categoryid
        }).then(product => {
            res.json(product);
            console.log(`Project with id = ${product.nombre} created successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    update(req, res) {
        const { id } = req.params;
        Product.update({
            name: req.body.name,
            price: req.body.price,
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
        Product.destroy({
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