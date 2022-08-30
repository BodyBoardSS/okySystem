'use strict';

module.exports = (sequelize, DataTypes) => {
  const Product = sequelize.define('Product',{
    name: {type: DataTypes.STRING,field:'NAME'},
    price: {type: DataTypes.DECIMAL,field:'PRICE'},
    description: {type: DataTypes.STRING,field:'DESCRIPTION'},
    image: {type: DataTypes.STRING,field:'IMAGE'}
  },{
    tableName: "products", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Product.associate = function(models) {
    Product.belongsTo(models.Category, {as: "category", foreignKey:"categoryid"});
  }
  return Product;
};