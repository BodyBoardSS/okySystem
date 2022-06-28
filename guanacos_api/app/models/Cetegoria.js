'use strict';

module.exports = (sequelize, DataTypes) => {
  const Categoria = sequelize.define('Categoria',{
    nombre: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "categoria", timestamps: false,freezeTableNam'use strict';

module.exports = (sequelize, DataTypes) => {
  const Categoria = sequelize.define('Categoria',{
    nombre: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "categoria", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Categoria.associate = function(models) {
    Categoria.hasMany(models.Producto, {as: "productos", foreignKey: "categoriaid"})
  }
  return Categoria;
};