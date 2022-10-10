const { Address, User } = require('../models/index')

module.exports = {
    async index(req, res) {
        let address = await Address.findAll()
        
        res.json(address)
    },

    async find(req, res, next) {
        let address = await Address.findByPk(req.params.id);
        if (!address)
            res.status(404).json({
                success: false,
                message: "La dirección no existe",
                data: []
            });
        else {
            req.address = address;
            next();
        }
    },

    async findByUser(req, res) {
        const { userId } = req.params;
        let address = await Address.findAll({
            where:{
                userid:userId
            }
        })
        res.json(address)
    },

    async create(req, res){
        await Address.create({
            address: req.body.address,
            neighborhood : req.body.neighborhood,
            lat : req.body.lat,
            lng : req.body.lng,
            userid:req.body.userid
        }).then(address => {
            res.status(201).json({
                success: true,
                message: 'La dirección fue creada con éxito.',
                data: address
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
        const addressReq = req.body
        const addressId = req.params.id

        await Address.update({
            address: addressReq.address,
            neighborhood: addressReq.neighborhood,
            lat: addressReq.lat,
            lng: addressReq.lng,
        },
        {
            where: { id: addressId }
        }).then(address => {
            res.status(201).json({
                success: true,
                message: 'La dirección fue modificada.',
                data: address
            })
        }).catch(err => {
            console.log(`Ocurrio un error ${err}`)
            res.status(500).json({
                success: false,
                message: err,
                data: []
            });
        })
    },
}