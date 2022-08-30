'use strict';

module.exports = (sequelize, DataTypes) => {
  const Rol = sequelize.define('Rol',{
    rol: {
      type: DataTypes.STRING,
      allowNull: false
    },
    image: {
      type: DataTypes.STRING,
      allowNull: false
    },
    route: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "roles",freezeTableName: true
  });

  Rol.associate = function(models) {
    Rol.belongsToMany(models.User, {
        as: "users", 
        through: "user_rol", 
        foreignKey: "idrol"
      });
  }
  
  return Rol;
};