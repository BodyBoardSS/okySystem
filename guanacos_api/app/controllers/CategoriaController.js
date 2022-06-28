const { Categoria, Producto } = require('../models/index')

module.exports = {
    async find(req, res, next) {
        let categoria = await Categoria.findByPk(req.params.id);
        if (!categoria)
            res.status(404).json({ msg: "La categoria no existe" })
        else {
            req.categoria = categoria;
            next();
        }
    },
    async index(req, res) {
        let categorias = await Categoria.findAll({
            include: {
                model: Producto,
                as: "productos",
                attributes: ['nombre', 'precio', 'descripcion']
            }
        })
        res.json(categorias)
    },

    async show(req, res) {
        let categoria = await Categoria.findByPk(req.params.id);
        if (!categoria)
            res.status(404).json({ msg: "La categoria no existe" })
        else
            res.json(categoria)
    },

    create(req, res) {
        Categoria.create({
            nombre: req.body.nombre
        }).then(categoria => {
            res.json(categoria);
            console.log(`Project with id = ${categoria.nombre} created successfully!`);
        }).catch(function (err) {
            console.log(`Error = ${err}`);
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    async update(req, res) {
        req.categoria.nombre = req.body.nombre;

        req.categoria.save().then(categoria => {
            res.json(categoria);
            console.log(`Project with id = ${id} updated successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser actualizado." + err });
        });
    },

    delete(req, res) {
        req.categoria.destroy().then(function () {
            res.json({ message: "Deleted successfully" });
            console.loconst { Categoria, Producto } = require('../models/index')

module.exports = {
    async find(req, res, next) {
        let categoria = await Categoria.findByPk(req.params.id);
        if (!categoria)
            res.status(404).json({ msg: "La categoria no existe" })
        else {
            req.categoria = categoria;
            next();
        }
    },
    async index(req, res) {
        let categorias = await Categoria.findAll({
            include: {
                model: Producto,
                as: "productos",
                attributes: ['nombre', 'precio', 'descripcion']
            }
        })
        res.json(categorias)
    },

    async show(req, res) {
        let categoria = await Categoria.findByPk(req.params.id);
        if (!categoria)
            res.status(404).json({ msg: "La categoria no existe" })
        else
            res.json(categoria)
    },

    create(req, res) {
        Categoria.create({
            nombre: req.body.nombre
        }).then(categoria => {
            res.json(categoria);
            console.log(`Project with id = ${categoria.nombre} created successfully!`);
        }).catch(function (err) {
            console.log(`Error = ${err}`);
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    async update(req, res) {
        req.categoria.nombre = req.body.nombre;

        req.categoria.save().then(categoria => {
            res.json(categoria);
            console.log(`Project with id = ${id} updated successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser actualizado." + err });
        });
    },

    delete(req, res) {
        req.categoria.destroy().then(function () {
            res.json({ message: "Deleted successfully" });
            console.log(`Project with id = ${id} deleted successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser eliminado." });
        })
    }
}