'use strict';

module.exports = (sequelize, DataTypes) => {
  const Usuario = sequelize.define('Usuario',{
    nombre: {
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
    email: {
      type: DataTypes.STRI'use strict';

module.exports = (sequelize, DataTypes) => {
  const Usuario = sequelize.define('Usuario',{
    nombre: {
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
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
      validate: {
        isEmail: {
          msg: "El email tiene que ser un correo valido"
        }
      }
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
    tableName: "usuario", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Usuario.associate = function(models) {
    Usuario.hasMany(models.Pedido, {as: "pedidos", foreignKey: "idusuario"});
    Usuario.belongsToMany(models.Rol, {
      as: "roles", 
      through: "usuario_rol", 
      foreignKey: "idusuario"
    });
  }

  Usuario.isAdmin = function(roles) {
    return roles.find( rol => rol.rol === "admin" )
  }
  return Usuario;
};