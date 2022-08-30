const { Category, Product } = require('../models/index')

module.exports = {
    async find(req, res, next) {
        let category = await Category.findByPk(req.params.id);
        if (!category)
            res.status(404).json({ msg: "La categoria no existe" })
        else {
            req.category = category;
            next();
        }
    },
    async index(req, res) {
        let categories = await Category.findAll({
            include: {
                model: Product,
                as: "products",
                attributes: ['name', 'price', 'description']
            }
        })
        res.json(categories)
    },

    async show(req, res) {
        let category = await Category.findByPk(req.params.id);
        if (!category)
            res.status(404).json({ msg: "La categoria no existe" })
        else
            res.json(category)
    },

    create(req, res) {
        Category.create({
            name: req.body.name
        }).then(category => {
            res.json(category);
            console.log(`Project with id = ${category.name} created successfully!`);
        }).catch(function (err) {
            console.log(`Error = ${err}`);
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    async update(req, res) {
        req.category.name = req.body.name;

        req.category.save().then(category => {
            res.json(category);
            console.log(`Project with id = ${id} updated successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser actualizado." + err });
        });
    },

    delete(req, res) {
        req.category.destroy().then(function () {
            res.json({ message: "Deleted successfully" });
            console.log(`Project with id = ${id} deleted successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser eliminado." });
        })
    }
}