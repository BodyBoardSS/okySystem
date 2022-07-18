-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-07-2022 a las 04:46:27
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `guanaco_bd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`ID`, `NOMBRE`) VALUES
(1, 'Carne'),
(3, 'Bebida'),
(9, 'Complemento'),
(11, 'Ensalada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo`
--

CREATE TABLE `metodo` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `metodo`
--

INSERT INTO `metodo` (`ID`, `NOMBRE`) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `ID` int(11) NOT NULL,
  `IDUSUARIO` int(11) NOT NULL,
  `IDMETODO` int(11) NOT NULL,
  `TOTALPEDIDO` double DEFAULT NULL,
  `PROGRAMADO` date DEFAULT NULL,
  `DIRECCION` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`ID`, `IDUSUARIO`, `IDMETODO`, `TOTALPEDIDO`, `PROGRAMADO`, `DIRECCION`) VALUES
(1, 1, 1, 1, NULL, NULL),
(2, 1, 1, 1, NULL, NULL),
(3, 1, 1, 1.1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_detalle`
--

CREATE TABLE `pedido_detalle` (
  `ID` int(11) NOT NULL,
  `IDPEDIDO` int(11) NOT NULL,
  `IDPRODUCTO` int(11) NOT NULL,
  `CANTIDAD` double DEFAULT NULL,
  `PRECIO` double DEFAULT NULL,
  `DESCUENTO` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pedido_detalle`
--

INSERT INTO `pedido_detalle` (`ID`, `IDPEDIDO`, `IDPRODUCTO`, `CANTIDAD`, `PRECIO`, `DESCUENTO`) VALUES
(1, 1, 1, 2, 0.5, 0),
(2, 1, 2, 2, 0.5, 0),
(5, 3, 1, 2, 0.5, NULL),
(6, 3, 2, 2, 0.5, NULL),
(7, 3, 3, 2, 0.1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `ID` int(11) NOT NULL,
  `CATEGORIAID` int(11) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `PRECIO` decimal(4,2) DEFAULT NULL,
  `DESCIPCION` varchar(100) DEFAULT NULL,
  `IMAGEN` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`ID`, `CATEGORIAID`, `NOMBRE`, `PRECIO`, `DESCIPCION`, `IMAGEN`) VALUES
(1, 3, 'tamarindo', '0.25', 'Fresco natural tamarindo ', '/img/tamarindo.jpg'),
(2, 3, 'Jamaica', '0.25', 'Fresco natural jamaica ', '/img/jamaica.jpg'),
(3, 9, 'Tortilla', '0.25', 'tortilla de maiz', '/img/tortilla.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `rol` varchar(20) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `rol`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', '2022-06-23 11:28:53', '2022-06-23 11:28:53'),
(2, 'user', '2022-06-23 11:29:05', '2022-06-23 11:29:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `APELLIDO` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `TELEFONO` int(11) DEFAULT NULL,
  `PASSWORD` varchar(100) DEFAULT NULL,
  `FECHA_REGISTRO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID`, `NOMBRE`, `APELLIDO`, `EMAIL`, `TELEFONO`, `PASSWORD`, `FECHA_REGISTRO`) VALUES
(1, 'Kevin', 'Orellana', 'k@k.com', 78343564, '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-06-20'),
(3, 'Gabriela', 'Guzman', 'g@g.com', 78343534, '$2a$08$QiYMkZYmMf17qIDrQ0KAuO66DKnQlqmMRlVOB2q3NB1ej/uSV3RZi', '2022-06-20'),
(4, 'Gabriel', 'Guzman', 'ga@ga.com', 78343534, '$2a$10$7ek/pDw/NCraarTGDBwxNOJRXDHd5DdYWSURaOZZeY02YeVBPG6lO', '2022-06-20'),
(6, 'Lissette', 'Guzman', 'lz@lz.com', 78343534, '$2a$10$JSgTZ0N81XEKIlJlTwAEauyWB6tld.vZgFPmCkMGwpUInJa0rqSUe', '2022-06-21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id` int(11) NOT NULL,
  `idrol` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id`, `idrol`, `idusuario`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, '2022-06-23 11:30:41', '2022-06-23 11:30:41'),
(2, 2, 3, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(3, 2, 4, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(4, 2, 6, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(5, 2, 1, '2022-06-23 11:32:54', '2022-06-23 11:32:54');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `metodo`
--
ALTER TABLE `metodo`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PEDIDO_USUARIO_FK` (`IDUSUARIO`),
  ADD KEY `pedido_metodo_fk` (`IDMETODO`);

--
-- Indices de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD PRIMARY KEY (`ID`,`IDPEDIDO`),
  ADD KEY `DETALLE_PRODUCTO_FK` (`IDPRODUCTO`),
  ADD KEY `DETALLE_PEDIDO_FK` (`IDPEDIDO`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PRODUCTO_CATEGORIA_FK` (`CATEGORIAID`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuariorol_rol` (`idrol`),
  ADD KEY `usuariorol_usuario` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `metodo`
--
ALTER TABLE `metodo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `PEDIDO_USUARIO_FK` FOREIGN KEY (`IDUSUARIO`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `pedido_metodo_fk` FOREIGN KEY (`IDMETODO`) REFERENCES `metodo` (`ID`);

--
-- Filtros para la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD CONSTRAINT `DETALLE_PEDIDO_FK` FOREIGN KEY (`IDPEDIDO`) REFERENCES `pedido` (`ID`),
  ADD CONSTRAINT `DETALLE_PRODUCTO_FK` FOREIGN KEY (`IDPRODUCTO`) REFERENCES `producto` (`ID`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `PRODUCTO_CATEGORIA_FK` FOREIGN KEY (`CATEGORIAID`) REFERENCES `categoria` (`ID`);

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `usuariorol_rol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`),
  ADD CONSTRAINT `usuariorol_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
