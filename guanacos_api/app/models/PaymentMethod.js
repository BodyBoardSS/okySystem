'use strict';

module.exports = (sequelize, DataTypes) => {
  const PaymentMethod = sequelize.define('PaymentMethod',{
    name: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "payment_method", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  PaymentMethod.associate = function(models) {
  }
  
  return PaymentMethod;
};