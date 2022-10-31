-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: db4free.net    Database: guanaco_bd
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `USERID` int NOT NULL,
  `ADDRESS` varchar(255) NOT NULL,
  `NEIGHBORHOOD` varchar(180) NOT NULL,
  `LAT` double NOT NULL,
  `LNG` double NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `ADDRESS_USER_FK` (`USERID`),
  CONSTRAINT `ADDRESS_USER_FK` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (3,1,'Casa Gabiie','Condominio San Jacinto',13.682421829368469,-89.19056430459023,'2022-10-03 16:12:38','2022-10-03 16:12:38'),(4,1,'Urb. Nuevo Lourdes','Colon',13.723855375884403,-89.38042547553778,'2022-10-06 05:07:00','2022-10-06 05:07:00'),(5,29,'Urb. Campos Verdes','Lourdes',13.71138090162818,-89.3712456151843,'2022-10-09 06:20:32','2022-10-09 06:20:32'),(6,31,'Colonia Madrid ','San Salvador ',13.686119194167786,-89.19750284403563,'2022-10-10 03:05:17','2022-10-10 03:05:17'),(7,32,'san benito ','casa 206',13.6817911,-89.1922692,'2022-10-12 19:23:01','2022-10-12 19:23:01'),(8,36,'ygcvb','Chuy ',13.710906325000662,-89.2433112859726,'2022-10-13 03:13:01','2022-10-13 03:13:01');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bebidas','Bebidas listas para ser disfrutadas por nuestros clientes.','2022-09-19 22:38:55','2022-09-19 22:38:55'),(2,'Complementos','Variedad de complementos listos para ser disfrutados por nuestros clientes.','2022-09-19 22:40:00','2022-09-19 22:40:00'),(3,'Tipicos','Platillos tipicos','2022-10-13 03:32:31','2022-10-13 03:32:31');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `IDORDER` int NOT NULL,
  `IDPRODUCT` int NOT NULL,
  `QUANTITY` int NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDORDER`,`IDPRODUCT`),
  KEY `ORDERS_DETAIL_PRODUCT_FK` (`IDPRODUCT`),
  CONSTRAINT `ORDERS_DETAIL_ORDER_FK` FOREIGN KEY (`IDORDER`) REFERENCES `orders` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_DETAIL_PRODUCT_FK` FOREIGN KEY (`IDPRODUCT`) REFERENCES `products` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (11,1,4,'2022-10-09 06:20:38','2022-10-09 06:20:38'),(11,2,8,'2022-10-09 06:20:38','2022-10-09 06:20:38'),(12,1,4,'2022-10-09 06:29:16','2022-10-09 06:29:16'),(13,1,4,'2022-10-10 03:05:24','2022-10-10 03:05:24'),(14,1,3,'2022-10-10 16:34:24','2022-10-10 16:34:24'),(14,2,20,'2022-10-10 16:34:24','2022-10-10 16:34:24'),(14,3,3,'2022-10-10 16:34:24','2022-10-10 16:34:24'),(24,1,1,'2022-10-12 19:23:12','2022-10-12 19:23:12'),(25,1,1,'2022-10-13 03:13:09','2022-10-13 03:13:09');
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDCLIENT` int NOT NULL,
  `IDDELIVERY` int DEFAULT NULL,
  `IDADDRESS` int NOT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `STATUS` varchar(90) NOT NULL,
  `CREATEDDATE` bigint NOT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TOTAL` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ORDERS_CLIENT_FK` (`IDCLIENT`),
  KEY `ORDERS_DELIVERY_FK` (`IDDELIVERY`),
  KEY `ORDERS_ADDRESS_FK` (`IDADDRESS`),
  CONSTRAINT `ORDERS_ADDRESS_FK` FOREIGN KEY (`IDADDRESS`) REFERENCES `address` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_CLIENT_FK` FOREIGN KEY (`IDCLIENT`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_DELIVERY_FK` FOREIGN KEY (`IDDELIVERY`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (11,29,4,5,37.4219983,-122.084,'ENTREGADO',1665296437830,'2022-10-10 00:55:23','2022-10-10 00:55:23',1.5),(12,29,4,5,13.7097917,-89.3714967,'ENTREGADO',1665296955897,'2022-10-10 02:40:06','2022-10-10 02:40:06',1.5),(13,31,4,6,13.6868583,-89.19797,'ENTREGADO',1665371123293,'2022-10-10 04:32:17','2022-10-10 04:32:17',1),(14,29,4,5,13.6819728,-89.1902817,'ENTREGADO',1665419663901,'2022-10-12 06:10:03','2022-10-10 16:49:27',2.05),(24,32,4,7,13.709925,-89.2418767,'ENTREGADO',1665602591679,'2022-10-13 03:26:58','2022-10-13 03:26:57',0.25),(25,36,4,8,13.6868583,-89.19797,'ENTREGADO',1665630788683,'2022-10-13 03:22:38','2022-10-13 03:22:37',0.25);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CATEGORYID` int NOT NULL,
  `NAME` varchar(45) DEFAULT NULL,
  `PRICE` double DEFAULT NULL,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  `IMAGE1` varchar(500) DEFAULT NULL,
  `IMAGE2` varchar(500) DEFAULT NULL,
  `IMAGE3` varchar(500) DEFAULT NULL,
  `CREATEDAT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATEDAT` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PRODUCTO_CATEGORY_FK` (`CATEGORYID`),
  CONSTRAINT `PRODUCTO_CATEGORY_FK` FOREIGN KEY (`CATEGORYID`) REFERENCES `categories` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,'Tamarindo',0.25,'Bebida natural a base de tamarindo.','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630290261?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630293031?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630293810?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','2022-09-19 23:31:35','2022-09-19 23:31:35'),(2,2,'Tortilla de maiz',0.05,'No puede faltar la tortilla de maiz en cada platillo salvadoreÃ±o.','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454018?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454482?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663630454880?alt=media&token=4bdf443a-9ebf-461e-ba2f-870bb03861ef','2022-10-01 04:17:17','2022-09-19 23:34:15'),(3,1,'Jamaica',0.3,'Refresco natural de jamaica','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665369510636?alt=media&token=e4800c27-3fef-40cf-9f99-bdb5456db949','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665369514607?alt=media&token=e4800c27-3fef-40cf-9f99-bdb5456db949','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665369518073?alt=media&token=e4800c27-3fef-40cf-9f99-bdb5456db949','2022-10-10 02:38:38','2022-10-10 02:38:38');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ROL` varchar(20) NOT NULL,
  `CREATEDAT` datetime NOT NULL,
  `UPDATEDAT` datetime NOT NULL,
  `IMAGE` varchar(255) DEFAULT NULL COMMENT 'Image of rol',
  `ROUTE` varchar(180) NOT NULL COMMENT 'Route of rol in app ',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'RESTAURANTE','2022-06-23 11:28:53','2022-06-23 11:28:53','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/restaurant.png?alt=media&token=ccb24428-3741-4ae4-af31-7ff69d9e8b0b','/restaurant/home'),(2,'CLIENTE','2022-06-23 11:29:05','2022-06-23 11:29:05','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/cliente.png?alt=media&token=835fed08-b368-424e-b101-9d722b98338b','/client/home'),(3,'REPARTIDOR','2022-06-23 11:29:05','2022-06-23 11:29:05','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/delivery.png?alt=media&token=87dae374-49c9-4307-b74d-afcb896daa2d','/delivery/home');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_rol`
--

DROP TABLE IF EXISTS `user_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_rol` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDROL` int NOT NULL,
  `IDUSER` int NOT NULL,
  `CREATEDAT` datetime NOT NULL,
  `UPDATEDAT` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `USERROL_ROLES` (`IDROL`),
  KEY `USERROL_USER` (`IDUSER`),
  CONSTRAINT `USERROL_ROLES` FOREIGN KEY (`IDROL`) REFERENCES `roles` (`ID`),
  CONSTRAINT `USERROL_USER` FOREIGN KEY (`IDUSER`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_rol`
--

LOCK TABLES `user_rol` WRITE;
/*!40000 ALTER TABLE `user_rol` DISABLE KEYS */;
INSERT INTO `user_rol` VALUES (1,1,1,'2022-06-23 11:30:41','2022-06-23 11:30:41'),(2,3,3,'2022-06-23 11:32:54','2022-06-23 11:32:54'),(3,3,4,'2022-06-23 11:32:54','2022-06-23 11:32:54'),(4,3,6,'2022-06-23 11:32:54','2022-06-23 11:32:54'),(5,2,1,'2022-06-23 11:32:54','2022-06-23 11:32:54'),(6,2,25,'2022-08-29 22:51:59','2022-08-29 22:51:59'),(8,2,27,'2022-09-08 02:40:42','2022-09-08 02:40:42'),(9,2,28,'2022-09-08 21:26:01','2022-09-08 21:26:01'),(10,2,4,'2022-09-08 21:26:01','2022-09-08 21:26:01'),(11,2,29,'2022-10-09 06:18:47','2022-10-09 06:18:47'),(12,2,30,'2022-10-10 02:56:38','2022-10-10 02:56:38'),(13,2,31,'2022-10-10 02:59:11','2022-10-10 02:59:11'),(14,2,32,'2022-10-12 19:21:18','2022-10-12 19:21:18'),(15,2,33,'2022-10-12 20:06:26','2022-10-12 20:06:26'),(16,2,34,'2022-10-12 20:09:07','2022-10-12 20:09:07'),(17,2,35,'2022-10-12 20:20:39','2022-10-12 20:20:39'),(18,2,36,'2022-10-13 03:08:05','2022-10-13 03:08:05'),(19,1,36,'2022-10-13 03:08:05','2022-10-13 03:08:05'),(20,1,32,'2022-10-13 03:08:05','2022-10-13 03:08:05');
/*!40000 ALTER TABLE `user_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(180) NOT NULL,
  `NAME` varchar(90) NOT NULL,
  `LASTNAME` varchar(90) NOT NULL,
  `PHONE` varchar(90) NOT NULL,
  `IMAGE` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(90) NOT NULL,
  `CREATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATED_AT` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NOTIFICATION_TOKEN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  UNIQUE KEY `PHONE` (`PHONE`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'k@k.com','Manuel','Orellana','78343538','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665284801511?alt=media&token=98b7718b-4e69-4b99-9892-ed75d81ef94c','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-18 19:16:19','2022-10-18 19:16:19','cm2B4RQlSXGUxkl7ShwLvj:APA91bHmMVoVYK3ea_W54Y3usCBbeb4d8Yz4JBUX1kqNGyObGxouaWZ7VIfz042KPjU202cy4PgT_kRn5MjBkHlWSUdXPNvttB5Jap9wuh8oROEhlRkBPounrswoAGEkdQQlCg2ilA-0'),(3,'g@g.com','Gabriela','Guzman','78343534','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663219144315?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-10 01:09:57','2022-10-10 01:09:57','dSsn7E_cTjOqgGX2ajB7pw:APA91bFQdgZuAstFW0He7xOQf2s6rb14NGTUMZvPlnbBeynVYSsB-Qvj0cGNCnm38TjvDsrzEpfw_VeluIqbkk8b_U4WrzCu6Su12PUncdoeNqbvmU8XqsGB_juD2pVkl8wiZ1ff0ZMD'),(4,'ga@ga.com','Gabriel','Guzman','78343535','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665452759614?alt=media&token=0496dfa4-9555-462c-ab2b-74f00f84199c','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-13 03:19:25','2022-10-13 03:19:25','dSsn7E_cTjOqgGX2ajB7pw:APA91bFQdgZuAstFW0He7xOQf2s6rb14NGTUMZvPlnbBeynVYSsB-Qvj0cGNCnm38TjvDsrzEpfw_VeluIqbkk8b_U4WrzCu6Su12PUncdoeNqbvmU8XqsGB_juD2pVkl8wiZ1ff0ZMD'),(6,'lz@lz.com','Lissette','Guzman','78343536','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663223135986?alt=media&token=1a3f1ab3-ea61-451a-8e98-47d075d9d8d5','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-06 22:46:11','2022-10-06 22:46:11',NULL),(25,'javierlo@gmail.com','Antonio','Lopez','78436261','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-06 22:46:11','2022-10-06 22:46:11',NULL),(26,'gorellana@gmail.com','Gabriel','Orellana','78436263','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-06 22:46:11','2022-10-06 22:46:11',NULL),(27,'test@gmail.com','test','test','78453695','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1663218785922?alt=media&token=8f5eba1f-4653-463f-a12f-3b30c4410a48','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-06 22:46:11','2022-10-06 22:46:11',NULL),(28,'ko200596@gmail.com','Kevin','Orellana','78451236','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/KevinOrellana.jpg?alt=media&token=caedc065-ff17-407e-aebe-2c3c4a4944cd','$2a$08$T9JylWUDm2vGBP7599pr5uZzZ72Z7.tgSloeak75JH1AKNvVefIkq','2022-10-06 22:46:11','2022-10-06 22:46:11',NULL),(29,'lucrecia@gmail.com','Lucrecia','Lopez','78456321','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665296327225?alt=media&token=9ba44f67-d612-47a4-9ab7-cafb5baed865','$2b$10$i7cmJfQaF.mvGzubaB7VpOaPPsV/jkpRx5vc68N0DtWxHN.3Wp5d6','2022-10-12 05:35:34','2022-10-12 05:35:34','c_WsZgdWS52RAElTny-ORa:APA91bEmuQM1Udt0OENQ7fC1P9JoKd1reY59ZQ9EWxEIagKqvgCrzzBED4NkB3Fn7P6gTi28SPZ37M_-wW7kfDJ27bdlornDXwAQ8FmbWiNRIhrRXDKDynFQAHYh3Ja9wPY-7UuKeBEt'),(30,'kevnoobs@gmail.com','Luis','Flores','75461236','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665370590820?alt=media&token=e4800c27-3fef-40cf-9f99-bdb5456db949','$2b$10$SEqGgyWzMzmJEvDTnm1TL.2..wv3A6dlFJcYdaAsC6ulXD7/mBoxq','2022-10-10 02:56:39','2022-10-10 02:56:39','d5xMdQ_YQ3C5FqeX2klSce:APA91bGWJ_OWhav5n7CsNl2l0oExdyaAM6cSP5TZ9MSAGK0o9pzZMDkFLnaiV3ndgnXxbvOSfr2VqVsBkzxiev1VATrlXyJORhxG0zm-YIapUs0SPAhK5ThUwjX933EoEkInNLuwWigY'),(31,'gabiie.guzman@gmail.com','Gabriela','Guzman','79265152','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665370926711?alt=media&token=e4800c27-3fef-40cf-9f99-bdb5456db949','$2b$10$Iv.rCmeb4qIyKs3fkgljZOn8pPgmiefm2EHC7OoI38wdsizY8h9T2','2022-10-12 06:17:43','2022-10-12 06:17:43','cm2B4RQlSXGUxkl7ShwLvj:APA91bHmMVoVYK3ea_W54Y3usCBbeb4d8Yz4JBUX1kqNGyObGxouaWZ7VIfz042KPjU202cy4PgT_kRn5MjBkHlWSUdXPNvttB5Jap9wuh8oROEhlRkBPounrswoAGEkdQQlCg2ilA-0'),(32,'osmin9930@gmail.com','Alexis','Jimenez','73751729','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665602477484?alt=media&token=76a5b4e2-4991-46f6-ab3f-10159799314f','$2b$10$eOZzFgYZRVKLRJpRjbBpauDfQ.F5wUPi9q4k2b8DggEl4NDB.UX2q','2022-10-13 14:22:34','2022-10-13 14:22:34','d50MmPSASNiUgPs7i8aq4g:APA91bEZsrrVNev2KJJU1cDui-ngPmSSiK3mTnH6wY24e7-hK81zwfQraAOom9nFToFcSSIHNgV1hoWKgIBqNDWlQHdbmESJxAYMZToJitypoiiamCJjv3EMzuV02ix8EvNHzqmC0rg6'),(33,'prueba1@gmail.com','Luis','Henriquez','78451265','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665605185623?alt=media&token=541796e5-44fc-46c5-863c-67afa4825c55','$2b$10$O.nqT2RxubF79e2u65ZiUu7oh3BlRGvnAyfItJV8wan8G/OXrP9du','2022-10-12 20:07:00','2022-10-12 20:07:00','dSsn7E_cTjOqgGX2ajB7pw:APA91bFQdgZuAstFW0He7xOQf2s6rb14NGTUMZvPlnbBeynVYSsB-Qvj0cGNCnm38TjvDsrzEpfw_VeluIqbkk8b_U4WrzCu6Su12PUncdoeNqbvmU8XqsGB_juD2pVkl8wiZ1ff0ZMD'),(34,'prueba2@gmail.com','Carlos','Perez','65231047','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665605347294?alt=media&token=541796e5-44fc-46c5-863c-67afa4825c55','$2b$10$7NlIVLXMbea.ozlrK0foT.OMFFNdmSCBd9WuIzdvZ1vrzQo7AyELm','2022-10-12 20:09:09','2022-10-12 20:09:09','dSsn7E_cTjOqgGX2ajB7pw:APA91bFQdgZuAstFW0He7xOQf2s6rb14NGTUMZvPlnbBeynVYSsB-Qvj0cGNCnm38TjvDsrzEpfw_VeluIqbkk8b_U4WrzCu6Su12PUncdoeNqbvmU8XqsGB_juD2pVkl8wiZ1ff0ZMD'),(35,'maria.salazar@gmail.com','Maria','Salazar','70986542','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665606038466?alt=media&token=541796e5-44fc-46c5-863c-67afa4825c55','$2b$10$RJmRC89BsJ8XL.xWk/wO/OzbFtLY5mXSRRT27EryBFlOFLamOKC32','2022-10-12 20:20:40','2022-10-12 20:20:40','cm2B4RQlSXGUxkl7ShwLvj:APA91bHmMVoVYK3ea_W54Y3usCBbeb4d8Yz4JBUX1kqNGyObGxouaWZ7VIfz042KPjU202cy4PgT_kRn5MjBkHlWSUdXPNvttB5Jap9wuh8oROEhlRkBPounrswoAGEkdQQlCg2ilA-0'),(36,'aleguevara.yagm@gmail.com','Alejandra','Guevara','70076099','https://firebasestorage.googleapis.com/v0/b/guanacosapp.appspot.com/o/image_1665630484780?alt=media&token=0b889c5d-210d-44e6-ab0f-a6bf1e27d511','$2b$10$lg8nfUnJOGht.OqE5arLfuGoaaTyPDlVxydSQ.muOAH5QQWa6/nga','2022-10-13 03:08:06','2022-10-13 03:08:06','efqYG4AsTYyzNBuvHVI77A:APA91bFkVerzqwX8E2JMFXv-2V15e7f-1duJ2L2ASDmK-3RiuwBLi5_3J_yvZMUfVIH88oy6Q_A1ppG3eNNNg_nXEdQ3vnEe4CWfhJEo3T8KpbSWsQiGwdj9DqWMH6-LhRajh-m6djfy');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-26 22:51:17
