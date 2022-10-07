'use strict';

const Product = require("./Product");

module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define('Order',{
    lat: {type: DataTypes.DOUBLE,field:'LAT'},
    lng: {type: DataTypes.DOUBLE,field:'LNG'},
    total: {type: DataTypes.DOUBLE,field:'TOTAL'},
    status: {type: DataTypes.STRING,field:'STATUS'},
    createdDate: {type: DataTypes.INTEGER,field:'CREATEDDATE'}
  },{
    tableName: "orders"
  });

  Order.associate = function(models) {
    Order.belongsTo(models.User, {as: "client", foreignKey: "idclient"});
    Order.belongsTo(models.User, {as: "delivery", foreignKey: "iddelivery"});
    Order.belongsTo(models.Address, {as: "address", foreignKey: "idaddress"});
    Order.belongsToMany(models.Product, { through: 'OrderDetail', as:'products', foreignKey:"idorder"});
  }
  
  return Order;
};