const { Pedido, Usuario, Metodo, PedidoDetalle } = require('../models/index')

module.exports = {
    async index(req, res) {
        let pedidos = await Pedido.findAll({
            include: [{
                model: Usuario,
                as: "usuario",
                attributes: ['nombre']
            }, {
                model: Metodo,
                as: "metodo",
                attributes: ['nombre']
            }, {
                model: PedidoDetalle,
                as: "detalle",
                attributes: ['idproducto', 'cantidad', 'precio']
            }]
        })
        res.json(pedidos)
    },

    create(req, res) {
        Pedido.create({
            totalPedido: req.body.totalPedido,
            programado: req.body.programado,
            descripcion: req.body.descripcion,
            direccion: req.body.direccion,
            idmetodo: req.body.metodo.idmetodo,
            idusuario: req.body.usuario.idusuario
        }).then(producto => {
    
            for (var key in req.body.detalle) {
                if (req.body.detalle.hasOwnProperty(key)) {
                    PedidoDetalle.create({
                        cantidad: req.body.detalle[key].cantidad,
                        precio: req.body.detalle[key].precio,
                        idproducto: req.body.detalle[key].idproducto,
                        idpedido: producto.id
                    }).then(detalle => {
                        console.log(`Se creo detalle ${detalle}`);
                    }).catch(function (err) {
                        console.log(`Se ha producido un error: ${err}`);
                    });
 const { Pedido, Usuario, Metodo, PedidoDetalle } = require('../models/index')

module.exports = {
    async index(req, res) {
        let pedidos = await Pedido.findAll({
            include: [{
                model: Usuario,
                as: "usuario",
                attributes: ['nombre']
            }, {
                model: Metodo,
                as: "metodo",
                attributes: ['nombre']
            }, {
                model: PedidoDetalle,
                as: "detalle",
                attributes: ['idproducto', 'cantidad', 'precio']
            }]
        })
        res.json(pedidos)
    },

    create(req, res) {
        Pedido.create({
            totalPedido: req.body.totalPedido,
            programado: req.body.programado,
            descripcion: req.body.descripcion,
            direccion: req.body.direccion,
            idmetodo: req.body.metodo.idmetodo,
            idusuario: req.body.usuario.idusuario
        }).then(producto => {
    
            for (var key in req.body.detalle) {
                if (req.body.detalle.hasOwnProperty(key)) {
                    PedidoDetalle.create({
                        cantidad: req.body.detalle[key].cantidad,
                        precio: req.body.detalle[key].precio,
                        idproducto: req.body.detalle[key].idproducto,
                        idpedido: producto.id
                    }).then(detalle => {
                        console.log(`Se creo detalle ${detalle}`);
                    }).catch(function (err) {
                        console.log(`Se ha producido un error: ${err}`);
                    });
                }
            }
            res.json(producto);
            console.log(`Project with id = ${producto.nombre} created successfully!`);
        }).catch(function (err) {
            res.status(500).json({ error: "El registro no pudo ser creado." });
        });
    },

    update(req, res) {
        const { id } = req.params;
        Pedido.update({
            nombre: req.body.nombre,
            precio: req.body.precio,
            descripcion: req.body.descripcion,
            imagen: req.body.imagen,
            categoriaid: req.body.categoriaid
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
        Pedido.destroy({
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