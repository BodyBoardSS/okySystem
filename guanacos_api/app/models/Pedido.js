'use strict';

module.exports = (sequelize, DataTypes) => {
  const Pedido = sequelize.define('Pedido',{
    totalPedido: {type: DataTypes.DOUBLE,field:'TOTALPEDIDO'},
    programado: {type: DataTypes.DATE,field:'PROGRAMADO'},
    direccion: {type: DataTypes.STRING,field:'DIRECCION'}
  },{
    tableName: "pedido", timestamps: false,freezeTableName: true, create'use strict';

module.exports = (sequelize, DataTypes) => {
  const Pedido = sequelize.define('Pedido',{
    totalPedido: {type: DataTypes.DOUBLE,field:'TOTALPEDIDO'},
    programado: {type: DataTypes.DATE,field:'PROGRAMADO'},
    direccion: {type: DataTypes.STRING,field:'DIRECCION'}
  },{
    tableName: "pedido", timestamps: false,freezeTableName: true, createdAt:false,updatedAt:false
  });

  Pedido.associate = function(models) {
    Pedido.belongsTo(models.Metodo, {as: "metodo", foreignKey: "idmetodo"});
    Pedido.belongsTo(models.Usuario, {as: "usuario", foreignKey: "idusuario"});
    Pedido.hasMany(models.PedidoDetalle, {as: "detalle", foreignKey: "idpedido"});
  }
  
  return Pedido;
};