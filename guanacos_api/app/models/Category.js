'use strict';

module.exports = (sequelize, DataTypes) => {
  const Category = sequelize.define('Category',{
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "categories",freezeTableName: true
  });

  Category.associate = function(models) {
    Category.hasMany(models.Product, {as: "products", foreignKey: "categoryid"})
  }
  return Category;
};