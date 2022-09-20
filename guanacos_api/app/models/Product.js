'use strict';

module.exports = (sequelize, DataTypes) => {
  const Product = sequelize.define('Product',{
    name: {type: DataTypes.STRING,field:'NAME'},
    price: {type: DataTypes.DOUBLE,field:'PRICE'},
    description: {type: DataTypes.STRING,field:'DESCRIPTION'},
    image1: {type: DataTypes.STRING,field:'IMAGE1'},
    image2: {type: DataTypes.STRING,field:'IMAGE2'},
    image3: {type: DataTypes.STRING,field:'IMAGE3'}
  },{
    tableName: "products",freezeTableName: true
  });

  Product.associate = function(models) {
    Product.belongsTo(models.Category, {as: "category", foreignKey:"categoryid"});
  }
  return Product;
};