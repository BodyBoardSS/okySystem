'use strict';

module.exports = (sequelize, DataTypes) => {
  const UserRol = sequelize.define('UserRol',{
    idRol: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    idUser: {
        type: DataTypes.INTEGER,
        allowNull: false
      }
  },{
    tableName: "user_rol",freezeTableName: true
  });

  UserRol.associate = function(models) {
    UserRol.belongsTo(models.Rol,{as: "rol", foreignKey: "idrol"});
    UserRol.belongsTo(models.User,{as: "user", foreignKey: "iduser"});
  }
  
  return UserRol;
};