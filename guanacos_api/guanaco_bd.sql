-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 08, 2022 at 11:49 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `guanaco_bd`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `ID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `NEIGHBORHOOD` varchar(180) NOT NULL,
  `LAT` double NOT NULL,
  `LNG` double NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATEDAT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`ID`, `USERID`, `ADDRESS`, `NEIGHBORHOOD`, `LAT`, `LNG`, `CREATEDAT`, `UPDATEDAT`) VALUES
(3, 1, 'Casa Gabiie', 'Condominio San Jacinto', 13.682421829368469, -89.19056430459023, '2022-10-03 16:12:38', '2022-10-03 16:12:38'),
(4, 1, 'Urb. Nuevo Lourdes', 'Colon', 13.723855375884403, -89.38042547553778, '2022-10-06 05:07:00', '2022-10-06 05:07:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`ID`, `NAME`, `DESCRIPTION`, `CREATED_AT`, `UPDATED_AT`) VALUES
(1, 'Bebidas', 'Bebidas listas para ser disfrutadas por nuestros clientes.', '2022-09-19 22:38:55', '2022-09-19 22:38:55'),
(2, 'Complementos', 'Variedad de complementos listos para ser disfrutados por nuestros clientes.', '2022-09-19 22:40:00', '2022-09-19 22:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ID` int(11) NOT NULL,
  `IDCLIENT` int(11) NOT NULL,
  `IDDELIVERY` int(11) DEFAULT NULL,
  `IDADDRESS` int(11) NOT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `STATUS` varchar(90) NOT NULL,
  `CREATEDDATE` bigint(20) NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATEDAT` timestamp NOT NULL DEFAULT current_timestamp(),
  `TOTAL` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`ID`, `IDCLIENT`, `IDDELIVERY`, `IDADDRESS`, `LAT`, `LNG`, `STATUS`, `CREATEDDATE`, `CREATEDAT`, `UPDATEDAT`, `TOTAL`) VALUES
(7, 1, 1, 3, 13.682421829368469, -89.19056430459023, 'DESPACHADO', 20221003, '2022-10-06 23:22:52', '2022-10-06 23:22:52', 1.25),
(9, 1, 4, 3, 13.7235505, -89.3803261, 'EN CAMINO', 1665033029477, '2022-10-08 06:35:20', '2022-10-08 06:35:20', 2.25),
(10, 1, NULL, 3, NULL, NULL, 'PAGADO', 1665100248071, '2022-10-06 23:50:48', '2022-10-06 23:50:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `IDORDER` int(11) NOT NULL,
  `IDPRODUCT` int(11) NOT NULL,
  `QUANTITY` int(11) NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATEDAT` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`IDORDER`, `IDPRODUCT`, `QUANTITY`, `CREATEDAT`, `UPDATEDAT`) VALUES
(7, 1, 2, '2022-10-03 23:20:13', '2022-10-03 23:20:13'),
(9, 1, 3, '2022-10-06 05:10:29', '2022-10-06 05:10:29'),
(9, 2, 9, '2022-10-06 05:10:29', '2022-10-06 05:10:29'),
(10, 1, 8, '2022-10-06 23:50:48', '2022-10-06 23:50:48'),
(10, 2, 25, '2022-10-06 23:50:48', '2022-10-06 23:50:48');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ID` int(11) NOT NULL,
  `CATEGORYID` int(11) NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  `PRICE` double DEFAULT NULL,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  `IMAGE1` varchar(500) DEFAULT NULL,
  `IMAGE2` varchar(500) DEFAULT NULL,
  `IMAGE3` varchar(500) DEFAULT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATEDAT` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ID`, `CATEGORYID`, `NAME`, `PRICE`, `DESCRIPTION`, `IMAGE1`, `IMAGE2`, `IMAGE3`, `CREATEDAT`, `UPDATEDAT`) VALUES
(1, 1, 'Tamarindo', 0.25, 'Bebida natural a base de tamarindo.', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630290261?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630293031?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630293810?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', '2022-09-19 23:31:35', '2022-09-19 23:31:35'),
(2, 2, 'Tortilla de maiz', 0.05, 'No puede faltar la tortilla de maiz en cada platillo salvadoreño.', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454018?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454482?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454880?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef', '2022-10-01 04:17:17', '2022-09-19 23:34:15');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `ID` int(11) NOT NULL,
  `ROL` varchar(20) NOT NULL,
  `CREATEDAT` datetime NOT NULL,
  `UPDATEDAT` datetime NOT NULL,
  `IMAGE` varchar(255) DEFAULT NULL COMMENT 'Image of rol',
  `ROUTE` varchar(180) NOT NULL COMMENT 'Route of rol in app '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`ID`, `ROL`, `CREATEDAT`, `UPDATEDAT`, `IMAGE`, `ROUTE`) VALUES
(1, 'RESTAURANTE', '2022-06-23 11:28:53', '2022-06-23 11:28:53', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/restaurant.png?alt=media&token=8c64d499-b8c6-447c-8b6a-1dc77e9f5444', '/restaurant/home'),
(2, 'CLIENTE', '2022-06-23 11:29:05', '2022-06-23 11:29:05', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/cliente.jpg?alt=media&token=e7f76995-3f8f-4d63-9fb8-592b92aff8b2', '/client/home'),
(3, 'REPARTIDOR', '2022-06-23 11:29:05', '2022-06-23 11:29:05', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/delivery.png?alt=media&token=fa144e4b-6818-4e5c-9661-7f5ab1838719', '/delivery/home');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `EMAIL` varchar(180) NOT NULL,
  `NAME` varchar(90) NOT NULL,
  `LASTNAME` varchar(90) NOT NULL,
  `PHONE` varchar(90) NOT NULL,
  `IMAGE` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(90) NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `UPDATED_AT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `EMAIL`, `NAME`, `LASTNAME`, `PHONE`, `IMAGE`, `PASSWORD`, `CREATED_AT`, `UPDATED_AT`) VALUES
(1, 'k@k.com', 'Manuel', 'Orellana', '78343538', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663222962280?alt=media&token=1a3f1ab3-ea61-451a-8e98-47d075d9d8d5', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:45:55', '2022-10-06 22:45:55'),
(3, 'g@g.com', 'Gabriela', 'Guzman', '78343534', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663219144315?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(4, 'ga@ga.com', 'Gabriel', 'Guzman', '78343535', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663219144315?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(6, 'lz@lz.com', 'Lissette', 'Guzman', '78343536', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663223135986?alt=media&token=1a3f1ab3-ea61-451a-8e98-47d075d9d8d5', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(25, 'javierlo@gmail.com', 'Antonio', 'Lopez', '78436261', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(26, 'gorellana@gmail.com', 'Gabriel', 'Orellana', '78436263', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(27, 'test@gmail.com', 'test', 'test', '78453695', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11'),
(28, 'ko200596@gmail.com', 'Kevin', 'Orellana', '78451236', 'https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/KevinOrellana.jpg?alt=media&token=caedc065-ff17-407e-aebe-2c3c4a4944cd', '$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq', '2022-10-06 22:46:11', '2022-10-06 22:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `user_rol`
--

CREATE TABLE `user_rol` (
  `ID` int(11) NOT NULL,
  `IDROL` int(11) NOT NULL,
  `IDUSER` int(11) NOT NULL,
  `CREATEDAT` datetime NOT NULL,
  `UPDATEDAT` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_rol`
--

INSERT INTO `user_rol` (`ID`, `IDROL`, `IDUSER`, `CREATEDAT`, `UPDATEDAT`) VALUES
(1, 1, 1, '2022-06-23 11:30:41', '2022-06-23 11:30:41'),
(2, 3, 3, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(3, 3, 4, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(4, 3, 6, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(5, 2, 1, '2022-06-23 11:32:54', '2022-06-23 11:32:54'),
(6, 2, 25, '2022-08-29 22:51:59', '2022-08-29 22:51:59'),
(8, 2, 27, '2022-09-08 02:40:42', '2022-09-08 02:40:42'),
(9, 2, 28, '2022-09-08 21:26:01', '2022-09-08 21:26:01'),
(10, 2, 4, '2022-09-08 21:26:01', '2022-09-08 21:26:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ADDRESS_USER_FK` (`USERID`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ORDERS_CLIENT_FK` (`IDCLIENT`),
  ADD KEY `ORDERS_DELIVERY_FK` (`IDDELIVERY`),
  ADD KEY `ORDERS_ADDRESS_FK` (`IDADDRESS`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`IDORDER`,`IDPRODUCT`),
  ADD KEY `ORDERS_DETAIL_PRODUCT_FK` (`IDPRODUCT`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `PRODUCTO_CATEGORY_FK` (`CATEGORYID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `EMAIL` (`EMAIL`),
  ADD UNIQUE KEY `PHONE` (`PHONE`);

--
-- Indexes for table `user_rol`
--
ALTER TABLE `user_rol`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `USERROL_ROLES` (`IDROL`),
  ADD KEY `USERROL_USER` (`IDUSER`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `user_rol`
--
ALTER TABLE `user_rol`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `ADDRESS_USER_FK` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `ORDERS_ADDRESS_FK` FOREIGN KEY (`IDADDRESS`) REFERENCES `address` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ORDERS_CLIENT_FK` FOREIGN KEY (`IDCLIENT`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ORDERS_DELIVERY_FK` FOREIGN KEY (`IDDELIVERY`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `ORDERS_DETAIL_ORDER_FK` FOREIGN KEY (`IDORDER`) REFERENCES `orders` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ORDERS_DETAIL_PRODUCT_FK` FOREIGN KEY (`IDPRODUCT`) REFERENCES `products` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `PRODUCTO_CATEGORY_FK` FOREIGN KEY (`CATEGORYID`) REFERENCES `categories` (`ID`);

--
-- Constraints for table `user_rol`
--
ALTER TABLE `user_rol`
  ADD CONSTRAINT `USERROL_ROLES` FOREIGN KEY (`IDROL`) REFERENCES `roles` (`ID`),
  ADD CONSTRAINT `USERROL_USER` FOREIGN KEY (`IDUSER`) REFERENCES `users` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
