const { Category, Product } = require('../models/index')
const storage = require('../ultils/cloud_storage')
const asyncForEach = require('../ultils/async_foreach')

module.exports = {
    async index(req, res) {
        let products = await Product.findAll({
            include: {
                model: Category,
                as: "category",
                attributes: ['name']
            }
        })
        res.json(products)
    },

    async create(req, res) {
        const product = JSON.parse(req.body.product);

        const files = req.files;
        let inserts = 0;

        if(files === 0){
            return res.status(500).json({
                success: false,
                message: 'Error al registrar, el producto no tiene imagenes.',
                data: []
            });
        } else {
            
            Product.create({
                name: product.name,
                description: product.description,
                price: product.price,
                categoryid: product.id_category
               
            }).then(myProoduct => {

                const start = async () => {
                    await asyncForEach(files, async (file) => {
                        console.log(`files.length: ${files.length}`)
                        const path = `image_${Date.now()}`;
                        const url = await storage(file, path)
                        if(url != undefined && url != null) {
                            if(inserts == 0) 
                                product.image1 = url
                            else if(inserts == 1)
                                product.image2 = url
                            else if(inserts == 2)
                                product.image3 = url
                            
                        }

                        await Product.update({
                            image1: product.image1,
                            image2: product.image2,
                            image3: product.image3
                        },
                            {
                                where: { id: myProoduct.id }
                            }
                        ).then(function () {
                                inserts++
                        }).catch(function (err) {
                            console.log(`Error when try update product ${err}`);
                        });

                        if(inserts == files.length){
                            res.status(201).json({
                                success: true,
                                message: 'El registro se ingreso correctamente',
                                data: myProoduct
                            })
                        }

                    });
                }
                start();
            }).catch(err => {
                res.status(500).json({
                    success: false,
                    message: err,
                    data: []
                });
            })
        }

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