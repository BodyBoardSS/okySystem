const { Category, Product } = require('../models/index')

module.exports = {
    async find(req, res, next) {
        let category = await Category.findByPk(req.params.id);
        if (!category)
            res.status(404).json({
                success: false,
                message: "La categoria no existe",
                data: []
            });
        else {
            req.category = category;
            next();
        }
    },
    async index(req, res) {
        let categories = await Category.findAll()
        res.json(categories)
    },

    async findById(req, res) {
        let category = await Category.findByPk(req.params.id);
        if (!category)
            res.status(404).json({
                success: false,
                message: "La categoria no existe",
                data: []
            });
        else
            res.json(category)
    },

    async create(req, res) {
        await Category.create({
            name: req.body.name,
            description : req.body.description
        }).then(category => {
            res.status(201).json({
                success: true,
                message: 'La categoría fue creada con éxito.',
                data: category
            })
        }).catch(function (err) {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: true,
                message: 'El registro no pudo ser creado.',
                data:[]
            })
        });
    },

    async update(req, res) {
        req.category.name = req.body.name;

        await req.category.save().then(category => {
            res.json(category);
            console.log(`Project with id = ${id} updated successfully!`);
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
        await req.category.destroy().then(function () {
            res.json({ message: "Deleted successfully" });
            console.log(`Project with id = ${id} deleted successfully!`);
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