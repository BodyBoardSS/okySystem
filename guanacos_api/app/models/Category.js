'use strict';

module.exports = (sequelize, DataTypes) => {
  const Category = sequelize.define('Category',{
    name: {
      type: DataTypes.STRING,
      allowNull: false
    }
  },{
    tableName: "category", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Category.associate = function(models) {
    Category.hasMany(models.Product, {as: "products", foreignKey: "categoryid"})
  }
  return Category;
};