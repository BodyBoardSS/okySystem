'use strict';

module.exports = (sequelize, DataTypes) => {
  const OrderDetail = sequelize.define('OrderDetail',{
    quantity: {type: DataTypes.DOUBLE,field:'QUANTITY'}
  },{
    tableName: "order_detail", timestamps: false
  });
  
  return OrderDetail;
};