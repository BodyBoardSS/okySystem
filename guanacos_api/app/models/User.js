'use strict';

module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('User',{
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        isAlpha: {
          msg: "El nombre solo puede contener letras"
        },
        len: {
          args: [2, 255],
          msg: "El nombre debe de ser mayor a 2 caracteres"
        }
      }
    },
    lastName: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        isAlpha: {
          msg: "El apellido solo puede contener letras"
        },
        len: {
          args: [2, 255],
          msg: "El apellido debe de ser mayor a 2 caracteres"
        }
      }
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: {
          msg: "El email tiene que ser un correo valido"
        }
      }
    },phone: {
      type: DataTypes.STRING,
      allowNull: false,
    },image: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        len: {
          args: [6, 255],
          msg: "La contrasena debe de ser mayor a 6 caracteres"
        }
      }
    },
  },{
    tableName: "users", timestamps: false,freezeTableName: true, 
  });

  User.associate = function(models) {
    User.hasMany(models.Order, {as: "orders", foreignKey: "idclient"});
    User.hasMany(models.Address, {as: "address", foreignKey: "userid"})
    User.belongsToMany(models.Rol, {
      as: "roles", 
      through: "user_rol", 
      foreignKey: "iduser"
    });
  }

  User.isAdmin = function(roles) {
    return roles.find( rol => rol.rol === "RESTAURANTE")
  }
  return User;
};