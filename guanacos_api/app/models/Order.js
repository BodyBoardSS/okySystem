'use strict';

module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define('Order',{
    totalOrder: {type: DataTypes.DOUBLE,field:'TOTALORDERS'},
    schedule: {type: DataTypes.DATE,field:'SCHEDULE'},
    address: {type: DataTypes.STRING,field:'ADDRESS'}
  },{
    tableName: "order", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Order.associate = function(models) {
    Order.belongsTo(models.PaymentMethod, {as: "method", foreignKey: "idmethod"});
    Order.belongsTo(models.User, {as: "user", foreignKey: "iduser"});
    Order.hasMany(models.OrderDetail, {as: "detail", foreignKey: "idorder"});
  }
  
  return Order;
};