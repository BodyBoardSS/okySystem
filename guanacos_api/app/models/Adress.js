'use strict';

module.exports = (sequelize, DataTypes) => {
  const Address = sequelize.define('Address',{
    address: {
      type: DataTypes.STRING,
      allowNull: false
    },
    neighborhood: {
      type: DataTypes.STRING,
      allowNull: false
    },
    lat: {
        type: DataTypes.DOUBLE,
        allowNull: false
      },
    lng: {
        type: DataTypes.DOUBLE,
        allowNull: false
    }
  },{
    tableName: "address",freezeTableName: true
  });

  return Address;
};