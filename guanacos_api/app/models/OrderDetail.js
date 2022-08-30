'use strict';

module.exports = (sequelize, DataTypes) => {
  const OrderDetail = sequelize.define('OrderDetail',{
    quantity: {type: DataTypes.DOUBLE,field:'QUANTITY'},
    price: {type: DataTypes.DOUBLE,field:'PRICE'},
    discount: {type: DataTypes.DOUBLE,field:'DISCOUNT'}
  },{
    tableName: "order_detail", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  OrderDetail.associate = function(models) {
    OrderDetail.belongsTo(models.Product,{as: "product", foreignKey: "idproduct"});
    OrderDetail.belongsTo(models.Order,{as: "order", foreignKey: "idorder"});
  }
  
  return OrderDetail;
};