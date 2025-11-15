-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: dhtcrew
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `alerta_stock`
--

DROP TABLE IF EXISTS `alerta_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta_stock` (
  `idAlerta` int NOT NULL AUTO_INCREMENT,
  `idVariantePrenda` int NOT NULL,
  `fecha` datetime NOT NULL,
  `motivo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAlerta`),
  KEY `idVariantePrenda` (`idVariantePrenda`),
  CONSTRAINT `alerta_stock_ibfk_1` FOREIGN KEY (`idVariantePrenda`) REFERENCES `prenda_has_talleycolor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta_stock`
--

LOCK TABLES `alerta_stock` WRITE;
/*!40000 ALTER TABLE `alerta_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerta_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `dni` varchar(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `puntos` int DEFAULT '0',
  `genero` enum('Masculino','Femenino','Otro') NOT NULL,
  `fotoPerfil` varchar(45) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `contrasenia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('10000001','Camila','Rodríguez','1998-05-14',0,'Femenino','userp.png','camirodriguez@gmail.com','camilita32'),('10000010','Tomás','Vega','1993-08-05',0,'Masculino','userp.png','vegaatomas@hotmail.com','tomas99'),('12345678','Lucía','Gómez','1995-06-15',0,'Femenino','userp.png','luciajgomez@gmail.com','13evermore'),('23456789','Mateo','Pérez','1990-12-01',0,'Masculino','mp.png','perezz@yahoo.com.ar','789perez'),('34567890','Sofía','Martínez','2000-03-22',0,'Femenino','sm.png','martinezs@gmail.com','m4rt1n3z');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `idCompra` int NOT NULL AUTO_INCREMENT,
  `clienteDni` varchar(15) NOT NULL,
  `datetimeCompra` datetime NOT NULL,
  `idMetodo` int NOT NULL,
  `costoTotal` float NOT NULL,
  PRIMARY KEY (`idCompra`),
  KEY `clienteDni` (`clienteDni`),
  KEY `idMetodo` (`idMetodo`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`clienteDni`) REFERENCES `cliente` (`dni`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`idMetodo`) REFERENCES `metodopago` (`idMetodo`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,'12345678','2025-10-10 14:20:00',1,27498),(2,'12345678','2025-10-10 14:20:00',1,27498),(3,'23456789','2025-10-12 10:30:00',2,13999),(4,'12345678','2025-10-10 14:20:00',1,27498),(5,'12345678','2025-10-10 14:20:00',1,27498),(6,'23456789','2025-10-12 10:30:00',2,13999),(7,'10000001','2025-10-14 11:00:00',1,17998),(8,'12345678','2025-10-15 15:30:00',3,11999),(9,'23456789','2025-10-15 16:10:00',1,25999),(10,'10000001','2025-10-16 09:45:00',1,15999),(11,'12345678','2025-10-16 18:20:00',2,16999),(12,'23456789','2025-10-17 14:50:00',1,19999),(13,'10000001','2025-10-17 19:00:00',3,21999),(14,'12345678','2025-10-18 13:15:00',1,14999),(15,'12345678','2023-12-05 10:00:00',1,0),(16,'23456789','2023-12-15 14:30:00',2,0),(17,'10000001','2024-01-10 11:00:00',4,0),(18,'34567890','2024-02-02 18:00:00',1,0),(19,'10000010','2024-03-15 20:15:00',1,0),(20,'12345678','2024-04-01 09:30:00',2,0),(21,'23456789','2024-05-10 12:00:00',3,0),(22,'10000001','2024-06-18 15:45:00',1,0),(23,'34567890','2024-07-20 17:00:00',4,0),(24,'10000010','2024-08-05 13:00:00',1,0),(25,'12345678','2024-09-12 11:20:00',2,0),(26,'23456789','2024-10-30 19:00:00',1,0),(27,'10000001','2024-11-15 16:10:00',4,0),(28,'34567890','2024-12-20 21:00:00',1,0),(29,'10000010','2025-01-10 08:00:00',2,0),(30,'12345678','2025-01-15 10:00:00',1,0),(31,'23456789','2025-01-20 11:00:00',2,0),(32,'10000001','2025-02-01 12:00:00',3,0),(33,'34567890','2025-02-10 13:00:00',4,0),(34,'10000010','2025-02-15 14:00:00',1,0),(35,'12345678','2025-02-20 15:00:00',1,0),(36,'23456789','2025-03-01 16:00:00',2,0),(37,'10000001','2025-03-05 17:00:00',1,0),(38,'34567890','2025-03-10 18:00:00',4,0),(39,'10000010','2025-03-15 19:00:00',1,0),(40,'12345678','2025-03-20 20:00:00',2,0),(41,'23456789','2025-04-01 09:00:00',3,0),(42,'10000001','2025-04-05 10:00:00',1,0),(43,'34567890','2025-04-10 11:00:00',2,0),(44,'10000010','2025-04-15 12:00:00',1,0),(45,'12345678','2025-04-20 13:00:00',4,0),(46,'23456789','2025-05-01 14:00:00',1,0),(47,'10000001','2025-05-05 15:00:00',2,0),(48,'34567890','2025-05-10 16:00:00',1,0),(49,'10000010','2025-05-15 17:00:00',3,0),(50,'12345678','2025-05-20 18:00:00',1,0),(51,'23456789','2025-06-01 19:00:00',4,0),(52,'10000001','2025-06-05 20:00:00',1,0),(53,'34567890','2025-06-10 08:00:00',2,0),(54,'10000010','2025-06-15 09:00:00',1,0),(55,'12345678','2025-06-20 10:00:00',3,0),(56,'23456789','2025-07-01 11:00:00',1,0),(57,'10000001','2025-07-05 12:00:00',4,0),(58,'34567890','2025-07-10 13:00:00',1,0),(59,'10000010','2025-07-15 14:00:00',2,0),(60,'12345678','2025-08-01 15:00:00',1,0),(61,'23456789','2025-08-15 16:00:00',3,0),(62,'10000001','2025-09-01 17:00:00',1,0),(63,'34567890','2025-09-15 18:00:00',4,0),(64,'10000010','2025-10-25 10:30:00',1,0),(65,'12345678','2024-03-01 10:15:00',1,0),(66,'23456789','2024-03-03 12:00:00',2,0),(67,'10000001','2024-03-05 15:30:00',4,0),(68,'34567890','2024-03-06 18:00:00',1,0),(69,'10000010','2024-04-10 09:00:00',1,0),(70,'12345678','2024-04-12 11:45:00',2,0),(71,'23456789','2024-05-15 14:00:00',3,0),(72,'10000001','2024-05-18 16:20:00',1,0),(73,'34567890','2024-06-20 17:00:00',4,0),(74,'10000010','2024-06-22 19:10:00',1,0),(75,'12345678','2025-02-25 10:00:00',2,0),(76,'23456789','2025-02-28 11:30:00',1,0),(77,'10000001','2025-03-01 13:00:00',4,0),(78,'34567890','2025-03-03 14:45:00',1,0),(79,'10000010','2025-03-05 16:00:00',3,0),(80,'12345678','2025-03-08 18:00:00',1,0),(81,'23456789','2025-04-10 09:30:00',2,0),(82,'10000001','2025-04-12 10:00:00',1,0),(83,'34567890','2025-04-15 12:15:00',4,0),(84,'10000010','2025-05-18 14:30:00',1,0),(85,'12345678','2024-07-20 15:00:00',2,0),(86,'23456789','2024-07-22 16:00:00',1,0),(87,'10000001','2024-08-24 10:00:00',1,0),(88,'34567890','2024-09-02 11:00:00',4,0),(89,'10000010','2024-09-05 13:00:00',1,0),(90,'12345678','2024-10-08 14:00:00',3,0),(91,'23456789','2024-10-10 16:00:00',1,0),(92,'10000001','2024-11-12 17:00:00',2,0),(93,'34567890','2024-11-15 18:00:00',1,0),(94,'10000010','2024-12-18 19:00:00',4,0),(95,'12345678','2025-06-20 10:00:00',1,0),(96,'23456789','2025-07-22 11:00:00',2,0),(97,'10000001','2025-08-25 14:00:00',1,0),(98,'34567890','2025-10-28 15:00:00',3,0),(99,'10000010','2025-11-01 16:00:00',1,0);
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra_detalle`
--

DROP TABLE IF EXISTS `compra_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idCompra` int DEFAULT NULL,
  `idVariantePrenda` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precioUnitario` float NOT NULL,
  `porcentajeComision` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCompra` (`idCompra`),
  KEY `idVariantePrenda` (`idVariantePrenda`),
  CONSTRAINT `cd_ibfk_1` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`),
  CONSTRAINT `cd_ibfk_2` FOREIGN KEY (`idVariantePrenda`) REFERENCES `prenda_has_talleycolor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_detalle`
--

LOCK TABLES `compra_detalle` WRITE;
/*!40000 ALTER TABLE `compra_detalle` DISABLE KEYS */;
INSERT INTO `compra_detalle` VALUES (1,1,2,1,7499,12.5),(2,1,7,1,19999,12),(3,2,14,1,13999,10),(4,3,35,2,8999,12),(5,4,41,1,11999,10),(6,5,31,1,25999,12.5),(7,6,25,1,15999,10),(8,7,29,1,16999,13),(9,8,9,1,19999,12),(10,9,20,1,21999,10.5),(11,15,1,1,3749.5,12.5),(12,15,48,1,14749.5,12),(13,15,14,1,6999.5,10),(14,16,14,1,6999.5,10),(15,16,29,1,8499.5,13),(16,16,54,1,39999.5,10),(17,17,45,2,29999.2,12.5),(18,17,87,1,15637.5,12.5),(19,17,25,1,11999.2,10),(20,18,123,1,29999.2,10),(21,18,25,1,11999.2,10),(22,18,35,1,6749.25,12),(23,19,7,1,12749.2,12),(24,19,111,1,38025,12),(25,19,35,2,6749.25,12),(26,20,96,1,28125,10),(27,20,54,1,59999.2,10),(28,20,63,1,13875,13),(29,21,63,2,13875,13),(30,21,29,1,12749.2,13),(31,21,1,1,5624.25,12.5),(32,22,20,1,21562.5,10.5),(33,22,22,1,14775,10.5),(34,22,48,1,22124.2,12),(35,23,1,1,5624.25,12.5),(36,23,45,1,29999.2,12.5),(37,23,87,1,15637.5,12.5),(38,24,51,1,26850,11.5),(39,24,72,2,21562.5,11.5),(40,24,7,1,12749.2,12),(41,25,123,1,29999.2,10),(42,25,60,1,36750,10),(43,25,75,1,23625,10),(44,26,1,1,5624.25,12.5),(45,26,48,1,22124.2,12),(46,26,72,1,21562.5,11.5),(47,27,111,1,38025,12),(48,27,35,1,6749.25,12),(49,27,66,1,66749.2,12.5),(50,28,54,1,59999.2,10),(51,28,96,1,28125,10),(52,28,105,1,15375,13),(53,29,63,1,18500,13),(54,29,84,1,80999,13),(55,29,45,1,39999,12.5),(56,30,10,1,11999,11.5),(57,31,17,1,18500,10),(58,32,24,1,80999,10),(59,33,31,1,25999,12.5),(60,34,40,1,11999,10),(61,35,50,1,29499,12),(62,36,57,1,32999,10.5),(63,37,66,1,88999,12.5),(64,38,75,1,31500,10),(65,39,81,1,45700,10),(66,40,90,1,27900,12),(67,41,99,1,25999,10.5),(68,42,105,1,20500,13),(69,43,115,1,29499,11.5),(70,44,120,1,31999,10.5),(71,45,130,1,19999,12.5),(72,46,132,1,19500,12),(73,47,2,1,19999,12.5),(74,48,8,1,25999,12),(75,49,13,1,35800,11.5),(76,50,22,1,19700,10.5),(77,51,27,1,42999,13),(78,52,38,1,23999,12),(79,53,47,1,39999,12.5),(80,54,55,1,79999,10),(81,55,64,1,18500,13),(82,56,71,1,38000,12),(83,57,78,1,19700,10.5),(84,58,88,1,20850,12.5),(85,59,94,1,42999,11.5),(86,60,102,1,24999,10),(87,61,112,1,50700,12),(88,62,118,1,44999,10),(89,63,125,1,39999,10),(90,64,134,1,19500,12),(91,65,152,1,71250,12.5),(92,66,144,1,61500,10),(93,67,87,1,15637.5,12.5),(94,68,123,1,29999.2,10),(95,69,135,1,17249.2,12.5),(96,70,168,1,44925,10),(97,71,185,1,69000,12.5),(98,72,210,1,20250,11.5),(99,73,230,1,38250,11.5),(100,74,54,1,59999.2,10),(101,75,45,1,39999,12.5),(102,76,63,1,18500,13),(103,77,72,1,28750,11.5),(104,78,81,1,45700,10),(105,79,93,1,42999,11.5),(106,80,105,1,20500,13),(107,81,117,1,44999,10),(108,82,126,1,23999,13),(109,83,140,1,31999,12),(110,84,148,1,24500,10.5),(111,85,1,1,5624.25,12.5),(112,85,50,1,22124.2,12),(113,86,14,1,10499.2,10),(114,86,144,1,61500,10),(115,87,152,1,71250,12.5),(116,87,185,1,69000,12.5),(117,88,135,1,17249.2,12.5),(118,88,87,2,15637.5,12.5),(119,89,230,1,38250,11.5),(120,89,210,1,20250,11.5),(121,90,168,1,44925,10),(122,90,123,1,29999.2,10),(123,91,14,1,10499.2,10),(124,91,54,1,59999.2,10),(125,91,10,1,8999.25,10),(126,92,190,1,40500,12),(127,92,50,1,22124.2,12),(128,93,200,1,25500,10.5),(129,93,201,1,25500,10.5),(130,94,215,1,22425,10.5),(131,94,22,1,16499.2,10.5),(132,95,222,1,75000,10),(133,95,203,1,53000,10),(134,96,225,1,26000,13),(135,96,63,1,18500,13),(136,97,136,1,31999,12),(137,97,45,1,39999,12.5),(138,98,233,1,85000,10),(139,98,150,1,21500,13),(140,99,143,1,82000,10);
/*!40000 ALTER TABLE `compra_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `idCompra` int NOT NULL,
  `dniCliente` varchar(15) NOT NULL,
  `fechaHora` datetime NOT NULL,
  `montoTotalReembolsado` float NOT NULL,
  PRIMARY KEY (`idDevolucion`),
  KEY `dniCliente` (`dniCliente`),
  KEY `idCompra` (`idCompra`),
  CONSTRAINT `dev_ibfk_1` FOREIGN KEY (`dniCliente`) REFERENCES `cliente` (`dni`),
  CONSTRAINT `dev_ibfk_2` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion_detalle`
--

DROP TABLE IF EXISTS `devolucion_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idDevolucion` int NOT NULL,
  `idCompraDetalle` int NOT NULL,
  `cantidadDevuelta` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idDevolucion` (`idDevolucion`),
  KEY `idCompraDetalle` (`idCompraDetalle`),
  CONSTRAINT `dd_ibfk_1` FOREIGN KEY (`idDevolucion`) REFERENCES `devolucion` (`idDevolucion`),
  CONSTRAINT `dd_ibfk_2` FOREIGN KEY (`idCompraDetalle`) REFERENCES `compra_detalle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion_detalle`
--

LOCK TABLES `devolucion_detalle` WRITE;
/*!40000 ALTER TABLE `devolucion_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `nombreEvento` varchar(100) NOT NULL,
  `descripcion` text,
  `fechaHoraComienzo` datetime NOT NULL,
  `fechaHoraFin` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'Lanzamiento EcoWear','Nueva colección sostenible de Kiech y Vancouver.','2025-11-01 18:00:00',NULL),(2,'DHT CyberWeek','Descuentos de hasta 40% en marcas seleccionadas.','2025-11-10 00:00:00',NULL),(3,'DHT Aniversario','Show run y lanzamiento colección aniversario.','2025-12-01 19:00:00',NULL),(4,'Urban Showcase: Nike x KOTK','Colaboración exclusiva de Nike y King of the Kongo.','2025-12-15 17:00:00',NULL),(5,'Fin de Temporada SS25','Liquidación final de temporada primavera-verano.','2026-01-15 10:00:00',NULL);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento_has_prenda`
--

DROP TABLE IF EXISTS `evento_has_prenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento_has_prenda` (
  `id` int NOT NULL,
  `p_idPrenda` int DEFAULT NULL,
  `e_idEvento` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `p_idPrenda` (`p_idPrenda`),
  KEY `e_idEvento` (`e_idEvento`),
  CONSTRAINT `ehp_ibfk_1` FOREIGN KEY (`p_idPrenda`) REFERENCES `prenda` (`idPrenda`),
  CONSTRAINT `ehp_ibfk_2` FOREIGN KEY (`e_idEvento`) REFERENCES `evento` (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento_has_prenda`
--

LOCK TABLES `evento_has_prenda` WRITE;
/*!40000 ALTER TABLE `evento_has_prenda` DISABLE KEYS */;
INSERT INTO `evento_has_prenda` VALUES (1,4,1),(2,5,1),(3,1,4),(4,8,4),(5,7,4);
/*!40000 ALTER TABLE `evento_has_prenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca` (
  `idMarca` int NOT NULL,
  `nombreMarca` varchar(100) NOT NULL,
  `stockMinimoDefault` int DEFAULT '5',
  `porcentajeComision` float DEFAULT '15',
  `gananciasTotales` float DEFAULT '0',
  `puntos` int DEFAULT '0',
  `ventasMinimasParaDevolucion` int DEFAULT '20',
  `cantidadVentasTotales` int DEFAULT '0',
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES (1,'Nike',5,12.5,0,0,20,0),(2,'Adidas',5,12,0,0,20,0),(3,'Puma',5,11.5,0,0,25,0),(4,'Kiech',4,10,0,0,1,0),(5,'Vancouver',5,10.5,0,0,15,0),(6,'VCP',4,10,0,0,15,0),(7,'King of the Kongo',6,13,0,0,10,0);
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca_has_tela`
--

DROP TABLE IF EXISTS `marca_has_tela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca_has_tela` (
  `idMarca` int NOT NULL,
  `idTela` int NOT NULL,
  PRIMARY KEY (`idMarca`,`idTela`),
  KEY `fk_marca_has_tela_tela` (`idTela`),
  CONSTRAINT `fk_marca_has_tela_marca` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`) ON DELETE CASCADE,
  CONSTRAINT `fk_marca_has_tela_tela` FOREIGN KEY (`idTela`) REFERENCES `tela` (`idTela`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca_has_tela`
--

LOCK TABLES `marca_has_tela` WRITE;
/*!40000 ALTER TABLE `marca_has_tela` DISABLE KEYS */;
INSERT INTO `marca_has_tela` VALUES (1,1),(2,1),(3,1),(7,1),(1,2),(2,2),(3,2),(5,3),(1,4),(4,4),(7,4),(4,5),(5,5),(6,6);
/*!40000 ALTER TABLE `marca_has_tela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodopago`
--

DROP TABLE IF EXISTS `metodopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodopago` (
  `idMetodo` int NOT NULL AUTO_INCREMENT,
  `nombreMetodo` varchar(50) NOT NULL,
  PRIMARY KEY (`idMetodo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodopago`
--

LOCK TABLES `metodopago` WRITE;
/*!40000 ALTER TABLE `metodopago` DISABLE KEYS */;
INSERT INTO `metodopago` VALUES (1,'Tarjeta de Crédito'),(2,'Transferencia'),(3,'Efectivo'),(4,'Billetera Digital');
/*!40000 ALTER TABLE `metodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenda`
--

DROP TABLE IF EXISTS `prenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenda` (
  `idPrenda` int NOT NULL AUTO_INCREMENT,
  `idMarca` int NOT NULL,
  `idTela` int NOT NULL,
  `idTipo` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `genero` enum('Masculino','Femenino','Unisex') NOT NULL,
  `precio` float NOT NULL,
  `descripcion` text,
  `foto2` varchar(50) DEFAULT NULL,
  `fotoPrincipal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idPrenda`),
  KEY `idTela` (`idTela`),
  KEY `idMarca` (`idMarca`),
  KEY `idTipo` (`idTipo`),
  CONSTRAINT `prenda_ibfk_1` FOREIGN KEY (`idTela`) REFERENCES `tela` (`idTela`),
  CONSTRAINT `prenda_ibfk_2` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`),
  CONSTRAINT `prenda_ibfk_3` FOREIGN KEY (`idTipo`) REFERENCES `tipo` (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda`
--

LOCK TABLES `prenda` WRITE;
/*!40000 ALTER TABLE `prenda` DISABLE KEYS */;
INSERT INTO `prenda` VALUES (1,1,1,4,'Remera Sportswear','Masculino',7499,'Remera clásica de algodón con logo Nike.',NULL,NULL),(2,2,2,1,'Pantalón Tiro 23','Masculino',19999,'Pantalón de entrenamiento con tecnología AEROREADY.',NULL,NULL),(3,3,2,6,'Buzo Essentials Logo','Unisex',14999,'Buzo con capucha y logo Puma en el pecho.',NULL,NULL),(4,4,4,6,'Buzo Oversize Urban','Unisex',13999,'Buzo de friza pesada, corte oversize y bolsillo canguro.',NULL,NULL),(5,5,3,5,'Campera Lino Liviana','Femenino',21999,'Campera de lino 100% orgánico, ideal para media estación.',NULL,NULL),(6,6,6,1,'Jean Slim Fit Denim','Masculino',15999,'Pantalón de jean VCP corte slim, lavado oscuro.',NULL,NULL),(7,7,4,1,'Jogger Tribal Print','Unisex',16999,'Jogger de friza con estampado tribal KOTK.',NULL,NULL),(8,1,2,5,'Campera Windrunner','Unisex',25999,'Campera cortaviento icónica Nike con diseño chevron.',NULL,NULL),(9,2,1,4,'Remera 3-Stripes','Femenino',8999,'Remera clásica Adidas de algodón con las 3 tiras.',NULL,NULL),(10,4,5,2,'Bermuda Cargo Kiech','Masculino',11999,'Bermuda de gabardina resistente con bolsillos cargo.',NULL,NULL),(11,1,2,3,'Short Dri-FIT','Masculino',39999,'Short de running liviano confeccionado en poliéster de alta performance con tecnología Dri-FIT. Ideal para entrenamientos intensos, repele la transpiración.',NULL,NULL),(12,2,1,4,'Remera Originals','Femenino',29499,'Remera clásica Originals de corte femenino, 100% algodón suave al tacto (Single Jersey). Presenta el icónico logo Trefoil estampado en el pecho.',NULL,NULL),(13,3,2,1,'Pantalón Essentials','Masculino',35800,'Pantalón jogger Puma Essentials. Fabricado en poliéster de secado rápido, con cintura elástica ajustable y puños en los tobillos para un calce deportivo.',NULL,NULL),(14,4,4,6,'Buzo Hoodie Classic','Unisex',79999,'Buzo canguro Kiech de corte oversize (Unisex). Confeccionado en friza pesada de algodón premium (perchada), ideal para bajas temperaturas. Capucha forrada y bolsillo canguro.',NULL,NULL),(15,5,5,1,'Pantalón Chino','Masculino',32999,'Pantalón chino Vancouver de corte recto (Straight Fit). Hecho en gabardina de algodón resistente y pre-lavada para mayor suavidad. Un básico versátil.',NULL,NULL),(16,6,6,1,'Jean Straight Fit','Femenino',49000,'Jean VCP de calce recto para mujer. Fabricado en denim 100% algodón rígido (13oz), con tiro alto que estiliza. Lavado clásico y costuras reforzadas.',NULL,NULL),(17,7,1,4,'Remera Graphic KOTK','Unisex',18500,'Remera KOTK (King of the Kongo) con estampa gráfica audaz. Confeccionada en algodón pima premium (24/1) que garantiza suavidad y durabilidad.',NULL,NULL),(18,1,4,6,'Buzo Club Fleece','Unisex',88999,'Buzo Nike Sportswear Club Fleece. Un clásico confeccionado en friza perchada (mezcla de algodón y poliéster) ultra suave. Corte estándar (Unisex), puños elásticos y logo Futura bordado.',NULL,NULL),(19,2,2,5,'Campera Rompeviento','Femenino',38000,'Campera rompeviento Adidas de corte femenino. Fabricada en poliéster reciclado (Primegreen), es liviana, repelente al agua y cuenta con las 3 tiras en las mangas.',NULL,NULL),(20,3,1,4,'Remera Essentials Logo','Masculino',28750,'Remera básica Puma Essentials. Hecha con algodón de alta calidad (BCI), ofrece un calce regular y confortable. Logo Puma No. 1 estampado en el pecho.',NULL,NULL),(21,4,5,1,'Pantalón Cargo Fit','Masculino',31500,'Pantalón cargo Kiech de estilo urbano. Confeccionado en gabardina de algodón gruesa y resistente, con múltiples bolsillos funcionales y corte relajado.',NULL,NULL),(22,5,3,4,'Remera Lino Basic','Femenino',19700,'Remera Vancouver de corte suelto (Relaxed Fit). Hecha en tejido 100% lino, es la prenda ideal para el verano por su frescura y ligereza. Calidad premium.',NULL,NULL),(23,6,6,5,'Campera Denim Trucker','Unisex',45700,'Clásica campera \"Trucker\" de VCP. Corte unisex, fabricada en denim de 13oz rígido que se amolda con el uso. Botones metálicos y doble bolsillo frontal.',NULL,NULL),(24,7,4,6,'Buzo KOTK Logo','Unisex',80999,'Buzo canguro KOTK (King of the Kongo). Friza pesada premium de máximo abrigo. Corte oversize, capucha amplia y logo KOTK bordado en alta definición en el pecho.',NULL,NULL),(25,1,1,4,'Remera Jordan','Masculino',20850,'Remera Nike Jordan. Fabricada en algodón suave de peso medio, ofrece un ajuste relajado y cómodo. Incluye el icónico logo Jumpman estampado.',NULL,NULL),(26,2,2,3,'Short AEROREADY','Femenino',27900,'Short deportivo Adidas para mujer. Tecnología AEROREADY que absorbe la humedad. Hecho de poliéster ligero, con cintura elástica y calzón interno para mayor confort.',NULL,NULL),(27,3,2,5,'Campera T7 Track','Masculino',42999,'La icónica campera Puma T7 Track. Un clásico deportivo en poliéster tricot brillante. Presenta las características franjas T7 de 7cm en las mangas y cuello alto.',NULL,NULL),(28,4,4,1,'Jogger Urban Friza','Unisex',37500,'Pantalón jogger Kiech de corte slim (Unisex). Confeccionado en friza de algodón suave y perchada. Cintura ajustable y puños elásticos para un look urbano.',NULL,NULL),(29,5,5,2,'Bermuda China','Masculino',25999,'Bermuda china Vancouver. Hecha en gabardina de algodón liviana y pre-lavada (stone-washed), ideal para el verano. Corte recto por encima de la rodilla.',NULL,NULL),(30,6,6,2,'Bermuda Jean','Masculino',24999,'Bermuda de jean VCP corte clásico. Fabricada en denim resistente de 12oz, con lavado localizado y costuras en color ocre. Cierre metálico.',NULL,NULL),(31,7,1,4,'Remera KOTK Box Logo','Unisex',20500,'Remera KOTK (King of the Kongo) con Box Logo. Algodón pesado de alta calidad (24/1). Corte recto (Unisex) y estampa del logo en serigrafía de alta densidad.',NULL,NULL),(32,1,2,1,'Pantalón Academy','Masculino',28500,'Pantalón de entrenamiento Nike Academy. Poliéster con tecnología Dri-FIT para mantener la frescura. Corte chupín con cierres en los tobillos para quitarlo fácilmente.',NULL,NULL),(33,2,1,6,'Buzo Trefoil Hoodie','Unisex',50700,'Buzo canguro Adidas Originals. Confeccionado en felpa francesa (algodón suave). Corte clásico (Unisex) y un gran logo Trefoil estampado que destaca.',NULL,NULL),(34,3,1,3,'Short Algodón Logo','Femenino',29499,'Short Puma de algodón rústico para mujer. Tejido liviano y transpirable. Cintura elástica con cordón y logo Puma Cat bordado en la pierna.',NULL,NULL),(35,4,5,5,'Campera Workwear','Masculino',44999,'Campera estilo \"Workwear\" de Kiech. Exterior de gabardina de algodón ultra resistente. Interior forrado en matelassé liviano. Cierre metálico reforzado.',NULL,NULL),(36,5,3,1,'Pantalón Lino Relax','Femenino',31999,'Pantalón Vancouver de lino puro. Corte \"Relaxed\" de pierna ancha, ultra fresco. Cintura elástica y lazo ajustable para un calce perfecto y natural.',NULL,NULL),(37,6,6,1,'Jean Mom Fit','Femenino',39999,'Jean VCP \"Mom Fit\" de calce retro. Tiro alto que define la cintura, corte holgado en caderas y piernas. Denim 100% algodón rígido (13oz).',NULL,NULL),(38,7,4,3,'Short Friza KOTK','Unisex',23999,'Short de friza liviana KOTK (King of the Kongo). Ideal para media estación. Corte unisex, bolsillos laterales y logo KOTK bordado en la pierna.',NULL,NULL),(39,1,4,1,'Jogger Sportswear','Femenino',19999,'Pantalón jogger Nike Sportswear para mujer. Hecho de friza perchada suave (mezcla de algodón y poliéster). Corte estándar que se estrecha en los tobillos.',NULL,NULL),(40,2,2,4,'Remera Run Icon','Masculino',19500,'Remera de running Adidas Run Icon. Tejido de poliéster técnico con tecnología AEROREADY. Corte anatómico y detalles reflectantes para visibilidad.',NULL,NULL),(41,1,1,4,'Remera Jordan \"Air\"','Masculino',22999,'Remera de algodón 24/1 de alto gramaje, con estampa \"Air\" en el pecho. Corte regular.',NULL,NULL),(42,2,2,3,'Short 3 Tiras \"Own the Run\"','Femenino',31999,'Short de running en poliéster liviano AEROREADY, con calzón interno y las 3 tiras reflectivas.',NULL,NULL),(43,3,1,4,'Remera Puma Motorsport BMW','Masculino',29999,'Remera de algodón premium, corte regular. Logo Puma Cat y escudo BMW M Motorsport.',NULL,NULL),(44,4,4,6,'Buzo Kiech \"Essentials\"','Unisex',82000,'Buzo de friza pesada perchada, 100% algodón. Corte oversize y capucha de doble forro.',NULL,NULL),(45,5,3,4,'Remera Vancouver \"Lino\"','Femenino',24500,'Remera de 100% lino, corte \"relaxed fit\". Increíblemente fresca, ideal para verano.',NULL,NULL),(46,6,6,1,'Jean VCP \"Skinny Black\"','Femenino',51000,'Jean de denim elastizado, tiro alto. Un básico color negro profundo que no se destiñe.',NULL,NULL),(47,7,1,4,'Remera KOTK \"Classic Logo\"','Unisex',21500,'Remera de algodón pima 30/1, la más suave. Logo KOTK bordado en el pecho, corte recto.',NULL,NULL),(48,1,4,1,'Jogger Nike Tech Fleece','Masculino',95000,'Pantalón jogger de friza técnica Nike Tech Fleece. Corte entallado, liviano y de abrigo superior.',NULL,NULL),(49,2,1,6,'Buzo Adidas \"Adicolor\"','Unisex',61000,'Buzo canguro de felpa francesa (algodón rústico), corte clásico. Logo trefoil bordado.',NULL,NULL),(50,4,5,5,'Campera Kiech \"Bomber\"','Masculino',68999,'Campera bomber de gabardina resistente, forro interior liviano. Puños y cuello elásticos.',NULL,NULL),(51,5,5,1,'Pantalón Vancouver \"Carpenter\"','Masculino',41000,'Pantalón de gabardina de algodón gruesa, estilo carpintero. Corte recto y costuras reforzadas.',NULL,NULL),(52,7,4,6,'Buzo KOTK \"Heavyweight\"','Unisex',89999,'El buzo definitivo. Friza pesada de 500g, corte boxy oversize. Capucha que no se cae.',NULL,NULL),(53,3,2,5,'Campera Puma \"T7\" Icon','Femenino',53000,'Campera deportiva de poliéster tricot. El diseño clásico T7 con franjas en las mangas.',NULL,NULL),(54,6,6,5,'Campera VCP \"Trucker\" Rígida','Unisex',59900,'Campera de denim rígido 14oz. El clásico corte trucker que mejora con cada uso.',NULL,NULL),(55,1,2,3,'Short Nike \"Fast 5inch\"','Masculino',28999,'Short de running 5 pulgadas en poliéster Dri-FIT, con bolsillo interno para llaves.',NULL,NULL),(56,2,1,4,'Remera Adidas \"Logo Lineage\"','Masculino',27500,'Remera de algodón single jersey, corte estándar. Estampa de logos lineales en la espalda.',NULL,NULL),(57,4,4,1,'Jogger Kiech \"Slim Friza\"','Femenino',41000,'Pantalón de friza liviana, corte slim. Cómodo para uso diario, con cintura ajustable.',NULL,NULL),(58,5,3,1,'Pantalón Vancouver \"Palazzo Lino\"','Femenino',46000,'Pantalón palazzo de 100% lino, tiro alto. El calce más fresco y elegante para verano.',NULL,NULL),(59,7,1,4,'Remera KOTK \"Washed\"','Unisex',24900,'Remera de algodón pesado con proceso de lavado \"stone washed\" para un look vintage.',NULL,NULL),(60,6,6,2,'Bermuda VCP \"Mom Fit\"','Femenino',38500,'Bermuda de denim rígido, tiro alto y corte \"Mom\" por encima de la rodilla. Lavado \"acid wash\".',NULL,NULL),(61,1,1,6,'Buzo Nike \"Solo Swoosh\"','Unisex',92000,'Buzo canguro de algodón (felpa francesa). Corte amplio y el logo \"Solo Swoosh\" bordado.',NULL,NULL),(62,2,2,1,'Pantalón Adidas \"Beckenbauer\"','Masculino',54000,'El icónico pantalón de poliéster tricot, corte slim. Cierres en los tobillos y las 3 tiras.',NULL,NULL),(63,3,1,4,'Remera Puma \"Archive\"','Femenino',26500,'Remera de algodón BCI, corte relajado. Logo Puma Archive No. 1 en el frente.',NULL,NULL),(64,4,4,6,'Buzo Kiech \"Logo Bordado\"','Unisex',83500,'Buzo de friza pesada con logo Kiech bordado en el centro. Calidad premium y corte oversize.',NULL,NULL),(65,5,5,2,'Bermuda Vancouver \"Cargo\"','Masculino',34000,'Bermuda cargo de gabardina de algodón, pre-lavada. Bolsillos laterales aplicados.',NULL,NULL),(66,6,6,1,'Jean VCP \"Relaxed Fit\"','Masculino',53000,'Jean de denim rígido (13oz), corte relajado y recto. Lavado \"medium blue\" clásico.',NULL,NULL),(67,7,4,1,'Jogger KOTK \"Friza Liviana\"','Unisex',48000,'Jogger de friza de verano (sin perchar). Corte recto y relajado, logo bordado.',NULL,NULL),(68,1,4,6,'Buzo Nike \"Phoenix Fleece\"','Femenino',81000,'Buzo de friza pesada, corte oversize y hombros caídos. Puños extra anchos.',NULL,NULL),(69,2,1,4,'Remera Adidas \"3-Stripes\" Larga','Femenino',30500,'Remera larga de algodón suave, con las 3 tiras en las mangas. Corte ajustado.',NULL,NULL),(70,3,2,3,'Short Puma \"TeamLIGA\"','Masculino',27000,'Short de fútbol en poliéster con tecnología dryCELL. Liviano y de secado rápido.',NULL,NULL),(71,4,5,1,'Pantalón Kiech \"Wide Leg\"','Unisex',49500,'Pantalón de gabardina fina, corte \"wide leg\" (pierna ancha) y tiro alto. Look sastrero.',NULL,NULL),(72,5,3,4,'Remera Vancouver \"Cuello Polo\"','Masculino',29900,'Remera de Lino y algodón, con cuello tipo polo y botones. Calce regular.',NULL,NULL),(73,6,6,5,'Campera VCP \"Sherpa Denim\"','Masculino',75000,'Campera de denim forrada íntegramente en corderito (sherpa). Ideal para invierno.',NULL,NULL),(74,7,1,4,'Remera KOTK \"Estampa Trasera\"','Unisex',26000,'Remera de algodón 24/1. Logo KOTK pequeño adelante y gráfica grande en la espalda.',NULL,NULL),(75,1,2,5,'Campera Nike \"Sportswear\" Run','Masculino',62000,'Campera rompeviento de poliéster ultraliviano, repelente al agua. Capucha plegable.',NULL,NULL),(76,2,1,3,'Short Adidas \"Essentials\" Algodón','Femenino',31500,'Short de felpa francesa (algodón rústico), tiro medio. Cómodo para uso diario.',NULL,NULL),(77,3,1,6,'Buzo Puma \"Classic Crew\"','Unisex',51000,'Buzo de algodón (felpa francesa) cuello redondo. Corte estándar, sin capucha.',NULL,NULL),(78,4,4,6,'Buzo Kiech \"Half-Zip\"','Unisex',85000,'Buzo de friza pesada con medio cierre (half-zip) metálico. Cuello alto.',NULL,NULL),(79,5,5,5,'Campera Vancouver \"Safari\"','Masculino',59900,'Campera de gabardina gruesa, 4 bolsillos frontales. Estilo safari, con lazo interno.',NULL,NULL),(80,7,4,3,'Short KOTK \"Washed Friza\"','Unisex',33000,'Short de friza pesada con lavado \"stone washed\". Corte por encima de la rodilla.',NULL,NULL);
/*!40000 ALTER TABLE `prenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenda_has_talleycolor`
--

DROP TABLE IF EXISTS `prenda_has_talleycolor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenda_has_talleycolor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `p_idPrenda` int DEFAULT NULL,
  `idTalle` int DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `stockMinimo` int DEFAULT '5',
  PRIMARY KEY (`id`),
  KEY `p_idPrenda` (`p_idPrenda`),
  KEY `idTalle` (`idTalle`),
  CONSTRAINT `phtc_ibfk_1` FOREIGN KEY (`p_idPrenda`) REFERENCES `prenda` (`idPrenda`) ON DELETE CASCADE,
  CONSTRAINT `phtc_ibfk_2` FOREIGN KEY (`idTalle`) REFERENCES `talle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda_has_talleycolor`
--

LOCK TABLES `prenda_has_talleycolor` WRITE;
/*!40000 ALTER TABLE `prenda_has_talleycolor` DISABLE KEYS */;
INSERT INTO `prenda_has_talleycolor` VALUES (1,1,2,'Negro',20,5),(2,1,3,'Negro',30,5),(3,1,4,'Negro',25,5),(4,1,3,'Blanco',15,5),(5,1,4,'Blanco',15,5),(6,2,2,'Negro',15,5),(7,2,3,'Negro',15,5),(8,2,4,'Negro',10,5),(9,2,3,'Azul',3,5),(10,3,3,'Gris',20,5),(11,3,4,'Gris',15,5),(12,3,5,'Gris',10,5),(13,3,4,'Rojo',8,5),(14,4,2,'Gris',12,4),(15,4,3,'Gris',15,4),(16,4,4,'Gris',10,4),(17,4,2,'Negro',20,4),(18,4,3,'Negro',18,4),(19,4,4,'Negro',10,4),(20,5,2,'Verde',8,5),(21,5,3,'Verde',10,5),(22,5,2,'Azul',7,5),(23,5,3,'Azul',9,5),(24,6,3,'Azul',14,4),(25,6,4,'Azul',16,4),(26,6,5,'Azul',10,4),(27,7,3,'Negro',1,6),(28,7,4,'Negro',8,6),(29,7,3,'Gris',10,6),(30,7,4,'Gris',9,6),(31,8,3,'Rojo',10,5),(32,8,4,'Rojo',8,5),(33,8,3,'Azul',12,5),(34,8,4,'Azul',10,5),(35,9,1,'Blanco',20,5),(36,9,2,'Blanco',25,5),(37,9,3,'Blanco',20,5),(38,9,1,'Negro',15,5),(39,9,2,'Negro',18,5),(40,10,3,'Verde',18,4),(41,10,4,'Verde',20,4),(42,10,5,'Verde',12,4),(43,10,3,'Gris',15,4),(44,10,4,'Gris',14,4),(45,11,3,'Negro',20,5),(46,11,4,'Negro',20,5),(47,11,3,'Azul',15,5),(48,12,1,'Blanco',25,5),(49,12,2,'Blanco',30,5),(50,12,3,'Blanco',20,5),(51,13,3,'Gris',15,5),(52,13,4,'Gris',15,5),(53,13,5,'Gris',10,5),(54,14,3,'Negro',10,4),(55,14,4,'Negro',10,4),(56,14,3,'Beige',8,4),(57,15,3,'Beige',12,5),(58,15,4,'Beige',15,5),(59,15,5,'Beige',10,5),(60,16,2,'Azul Claro',10,4),(61,16,3,'Azul Claro',12,4),(62,16,4,'Azul Claro',10,4),(63,17,3,'Negro',15,6),(64,17,4,'Negro',15,6),(65,17,5,'Blanco',10,6),(66,18,2,'Gris',20,5),(67,18,3,'Gris',25,5),(68,18,4,'Gris',20,5),(69,19,2,'Rosa',10,5),(70,19,3,'Rosa',12,5),(71,19,4,'Negro',15,5),(72,20,3,'Negro',30,5),(73,20,4,'Negro',30,5),(74,20,5,'Blanco',25,5),(75,21,3,'Verde Militar',10,4),(76,21,4,'Verde Militar',12,4),(77,21,5,'Negro',8,4),(78,22,2,'Blanco',15,5),(79,22,3,'Blanco',15,5),(80,22,4,'Celeste',10,5),(81,23,3,'Azul',10,4),(82,23,4,'Azul',10,4),(83,23,5,'Negro',8,4),(84,24,4,'Bordo',8,6),(85,24,5,'Bordo',8,6),(86,24,6,'Bordo',5,6),(87,25,3,'Rojo',15,5),(88,25,4,'Rojo',15,5),(89,25,5,'Negro',20,5),(90,26,1,'Negro',15,5),(91,26,2,'Negro',20,5),(92,26,3,'Negro',20,5),(93,27,3,'Negro',10,5),(94,27,4,'Negro',10,5),(95,27,5,'Azul',8,5),(96,28,2,'Gris Melange',15,4),(97,28,3,'Gris Melange',18,4),(98,28,4,'Negro',15,4),(99,29,3,'Azul Marino',12,5),(100,29,4,'Azul Marino',15,5),(101,29,5,'Beige',15,5),(102,30,3,'Azul Gastado',10,4),(103,30,4,'Azul Gastado',12,4),(104,30,5,'Negro',8,4),(105,31,3,'Blanco',20,6),(106,31,4,'Blanco',20,6),(107,31,5,'Negro',15,6),(108,32,2,'Negro',15,5),(109,32,3,'Negro',15,5),(110,32,4,'Azul',10,5),(111,33,3,'Rojo',10,5),(112,33,4,'Rojo',10,5),(113,33,5,'Negro',12,5),(114,34,1,'Gris',15,5),(115,34,2,'Gris',18,5),(116,34,3,'Negro',15,5),(117,35,3,'Marrón',8,4),(118,35,4,'Marrón',10,4),(119,35,5,'Negro',8,4),(120,36,2,'Beige',10,5),(121,36,3,'Beige',12,5),(122,36,4,'Blanco',8,5),(123,37,2,'Celeste',15,4),(124,37,3,'Celeste',15,4),(125,37,4,'Negro',10,4),(126,38,3,'Gris Melange',10,6),(127,38,4,'Gris Melange',10,6),(128,38,5,'Negro',8,6),(129,39,1,'Gris',15,5),(130,39,2,'Gris',18,5),(131,39,3,'Negro',20,5),(132,40,3,'Azul',20,5),(133,40,4,'Azul',20,5),(134,40,5,'Negro',15,5),(135,41,2,'Negro',15,5),(136,41,3,'Negro',20,5),(137,41,4,'Negro',10,5),(138,42,1,'Negro',10,5),(139,42,2,'Negro',10,5),(140,42,3,'Negro',5,5),(141,43,3,'Blanco',20,5),(142,43,4,'Blanco',15,5),(143,43,5,'Blanco',10,5),(144,44,3,'Gris Melange',10,4),(145,44,4,'Gris Melange',8,4),(146,44,5,'Gris Melange',0,4),(147,45,1,'Blanco Tiza',12,5),(148,45,2,'Blanco Tiza',10,5),(149,45,3,'Blanco Tiza',5,5),(150,46,2,'Negro',15,4),(151,46,3,'Negro',10,4),(152,46,4,'Negro',10,4),(153,47,2,'Blanco',10,6),(154,47,3,'Blanco',10,6),(155,47,4,'Blanco',0,6),(156,48,2,'Gris Oscuro',10,5),(157,48,3,'Gris Oscuro',10,5),(158,48,4,'Gris Oscuro',5,5),(159,49,3,'Negro',15,5),(160,49,4,'Negro',12,5),(161,49,5,'Negro',8,5),(162,50,2,'Verde Militar',8,4),(163,50,3,'Verde Militar',1,4),(164,50,4,'Verde Militar',0,4),(165,51,3,'Beige',10,5),(166,51,4,'Beige',8,5),(167,51,5,'Beige',5,5),(168,52,4,'Negro',10,6),(169,52,5,'Negro',8,6),(170,52,6,'Negro',5,6),(171,53,1,'Rojo',10,5),(172,53,2,'Rojo',10,5),(173,53,3,'Rojo',3,5),(174,54,3,'Azul Denim',10,4),(175,54,4,'Azul Denim',8,4),(176,54,5,'Azul Denim',5,4),(177,55,3,'Azul Marino',15,5),(178,55,4,'Azul Marino',15,5),(179,55,5,'Azul Marino',10,5),(180,56,2,'Gris Melange',20,5),(181,56,3,'Gris Melange',15,5),(182,56,4,'Gris Melange',10,5),(183,57,1,'Gris Topo',10,4),(184,57,2,'Gris Topo',5,4),(185,57,3,'Gris Topo',0,4),(186,58,1,'Natural',10,5),(187,58,2,'Natural',8,5),(188,58,3,'Natural',5,5),(189,59,3,'Negro Gastado',10,6),(190,59,4,'Negro Gastado',10,6),(191,59,5,'Negro Gastado',5,6),(192,60,2,'Celeste',10,4),(193,60,3,'Celeste',10,4),(194,60,4,'Celeste',2,4),(195,61,2,'Arena',10,5),(196,61,3,'Arena',10,5),(197,61,3,'Verde Seco',8,5),(198,62,3,'Negro',15,5),(199,62,4,'Negro',10,5),(200,62,3,'Azul Marino',10,5),(201,63,1,'Rosa Viejo',10,5),(202,63,2,'Rosa Viejo',5,5),(203,63,1,'Blanco',0,5),(204,64,4,'Negro',10,4),(205,64,5,'Negro',8,4),(206,64,4,'Bordo',5,4),(207,65,3,'Verde Militar',12,5),(208,65,4,'Verde Militar',10,5),(209,65,3,'Beige',10,5),(210,66,3,'Azul Gastado',10,4),(211,66,4,'Azul Gastado',10,4),(212,66,4,'Negro',5,4),(213,67,3,'Gris Melange',10,6),(214,67,4,'Gris Melange',0,6),(215,67,3,'Negro',8,6),(216,68,1,'Naranja',10,5),(217,68,2,'Naranja',8,5),(218,68,1,'Lila',5,5),(219,69,1,'Rojo',15,5),(220,69,2,'Rojo',10,5),(221,69,2,'Negro',20,5),(222,70,3,'Negro',20,5),(223,70,4,'Negro',15,5),(224,70,4,'Azul Francia',10,5),(225,71,2,'Negro',10,4),(226,71,3,'Negro',8,4),(227,71,3,'Gris Topo',0,4),(228,72,3,'Celeste',10,5),(229,72,4,'Celeste',10,5),(230,72,3,'Blanco',8,5),(231,73,3,'Negro Gastado',10,4),(232,73,4,'Negro Gastado',5,4),(233,73,3,'Azul',8,4),(234,74,3,'Blanco',20,6),(235,74,4,'Blanco',15,6),(236,74,3,'Negro',2,6),(237,75,3,'Negro',10,5),(238,75,4,'Negro',10,5),(239,75,3,'Amarillo Flúor',5,5),(240,76,1,'Gris Melange',15,5),(241,76,2,'Gris Melange',10,5),(242,76,2,'Negro',15,5),(243,77,3,'Azul Marino',10,5),(244,77,4,'Azul Marino',10,5),(245,77,3,'Gris',0,5),(246,78,4,'Beige',10,4),(247,78,5,'Beige',8,4),(248,78,4,'Negro',5,4),(249,79,3,'Marrón',10,5),(250,79,4,'Marrón',5,5),(251,79,3,'Negro',8,5),(252,80,2,'Gris Topo',10,6),(253,80,3,'Gris Topo',8,6),(254,80,3,'Negro Gastado',0,6);
/*!40000 ALTER TABLE `prenda_has_talleycolor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resenia`
--

DROP TABLE IF EXISTS `resenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resenia` (
  `idResenia` int NOT NULL AUTO_INCREMENT,
  `dniCliente` varchar(15) NOT NULL,
  `idPrenda` int NOT NULL,
  `comentario` text,
  `estrellas` int DEFAULT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`idResenia`),
  KEY `dniCliente` (`dniCliente`),
  KEY `idPrenda` (`idPrenda`),
  CONSTRAINT `resenia_ibfk_1` FOREIGN KEY (`dniCliente`) REFERENCES `cliente` (`dni`),
  CONSTRAINT `resenia_ibfk_2` FOREIGN KEY (`idPrenda`) REFERENCES `prenda` (`idPrenda`),
  CONSTRAINT `resenia_chk_1` CHECK ((`estrellas` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenia`
--

LOCK TABLES `resenia` WRITE;
/*!40000 ALTER TABLE `resenia` DISABLE KEYS */;
INSERT INTO `resenia` VALUES (1,'12345678',1,'Muy buena calidad, el talle M me quedó perfecto.',5,'2025-10-12'),(2,'23456789',4,'El buzo es perfecto, super oversize como me gusta.',5,'2025-10-15'),(3,'10000001',9,'La tela no era lo que esperaba, un poco fina.',3,'2025-10-18'),(4,'12345678',1,'Buena remera, talle justo.',4,'2023-12-10'),(5,'23456789',4,'El mejor buzo que tuve, la friza es excelente.',5,'2023-12-20'),(6,'10000001',11,'Shorts livianos, perfectos para correr.',5,'2024-01-15'),(7,'34567890',37,'Lindo calce, el color celeste es genial.',4,'2024-02-10'),(8,'10000010',9,'Esperaba un algodón más grueso.',3,'2024-03-20'),(9,'12345678',28,'Muy cómodo y abrigado.',5,'2024-04-05'),(10,'23456789',17,'La estampa es de buena calidad.',4,'2024-05-15'),(11,'10000001',5,'Hermosa campera de lino, muy elegante.',5,'2024-06-25'),(12,'34567890',25,'Clásica Jordan, no falla.',5,'2024-07-25'),(13,'10000010',20,'Remera básica que cumple.',4,'2024-08-10'),(14,'12345678',16,'Buen jean, un poco rígido al principio.',4,'2024-09-18'),(15,'23456789',12,'La remera adidas es de 10.',5,'2024-11-05'),(16,'10000001',33,'El buzo rojo es espectacular.',5,'2024-11-20'),(17,'34567890',14,'Excelente calidad, vale el precio.',5,'2024-12-25'),(18,'10000010',24,'Muy abrigado, el bordó es tal cual la foto.',5,'2025-01-15'),(19,'12345678',3,'Buen buzo, talle L amplio.',4,'2025-01-20'),(20,'10000001',6,'El talle M me quedó chico.',3,'2025-02-05'),(21,'34567890',8,'El rompeviento es icónico.',5,'2025-02-15'),(22,'10000010',10,'Buena bermuda cargo, muchos bolsillos.',4,'2025-02-20'),(23,'23456789',15,'El pantalón de gabardina es muy cómodo.',5,'2025-03-05'),(24,'12345678',41,'El algodón de la remera Jordan es bueno, pero un poco cara.',4,'2025-11-10'),(25,'23456789',44,'Calidad increíble, la friza del Kiech es súper pesada. Vale cada peso.',5,'2025-11-15'),(26,'10000001',46,'El calce del jean VCP es perfecto, muy elastizado.',5,'2025-11-20'),(27,'34567890',48,'El mejor jogger (Nike Tech) que tengo, liviano y abrigado.',5,'2025-11-25'),(28,'10000010',50,'La bomber está buena, pero el color verde no es como en la foto.',3,'2025-12-01'),(29,'12345678',52,'Literalmente el mejor buzo KOTK. La capucha es gigante y no se cae.',5,'2025-12-05'),(30,'23456789',54,'La campera VCP Trucker es muy rígida al principio, pero va aflojando. Clásica.',4,'2025-12-10'),(31,'10000001',61,'El color arena del Nike Solo Swoosh es hermoso. Corte oversize real.',5,'2025-12-15'),(32,'34567890',62,'Un clásico el Beckenbauer. El calce es perfecto, slim fit.',5,'2025-12-20'),(33,'10000010',63,'La remera Puma rosa es linda, pero el talle S es enorme.',3,'2025-12-25'),(34,'12345678',73,'La campera VCP con corderito es la más abrigada que existe.',5,'2026-01-05'),(35,'23456789',80,'El short KOTK es de una calidad increíble, pero no había stock en mi talle.',4,'2026-01-10'),(36,'10000001',42,'El short Adidas cumple. Es liviano para correr.',4,'2026-01-15'),(37,'34567890',58,'El pantalón de lino palazzo es un sueño. Súper fresco y elegante.',5,'2026-01-20'),(38,'10000010',70,'Short Puma básico de fútbol, buena tela.',4,'2026-01-25'),(39,'12345678',75,'Rompeviento Nike muy finito, ideal para llevarlo por si acaso.',4,'2026-01-30'),(40,'23456789',60,'La bermuda VCP \"acid wash\" es genial, muy retro.',5,'2026-02-05'),(41,'10000001',51,'Pantalón Vancouver súper resistente, buena gabardina.',5,'2026-02-10'),(42,'34567890',45,'El lino de la remera Vancouver pica un poco, no es tan suave.',3,'2026-02-15'),(43,'10000010',68,'Me encanta el corte del Phoenix Fleece. El color lila es hermoso.',5,'2026-02-20'),(44,'12345678',78,'Muy buena calidad el Kiech Half-Zip, el cierre es metálico.',5,'2026-02-25'),(45,'23456789',21,'Los pantalones cargo Kiech son muy cómodos.',4,'2026-03-01'),(46,'10000001',35,'Campera Kiech Workwear robusta, bien de laburo.',5,'2026-03-05'),(47,'34567890',11,'Los shorts Nike se secan al toque.',5,'2026-03-10'),(48,'10000010',15,'El chino Vancouver beige es un clásico, buen corte.',4,'2026-03-15'),(49,'12345678',18,'El buzo Nike Club Fleece es básico pero infaltable.',5,'2026-03-20'),(50,'23456789',19,'Muy liviana la campera Adidas, pero no abriga nada (obvio).',4,'2026-03-25'),(51,'10000001',33,'El logo del buzo Trefoil es estampado, pensé que era bordado.',3,'2026-04-01'),(52,'34567890',55,'Perfecto para correr, el largo del short Nike Fast es ideal.',5,'2026-04-05'),(53,'10000010',77,'Buzo cuello redondo Puma básico, buen algodón.',4,'2026-04-10'),(54,'12345678',66,'Jean VCP cómodo, no tan ajustado. Me gustó.',5,'2026-04-15'),(55,'23456789',71,'El corte del pantalón Kiech es muy ancho, más de lo que esperaba.',3,'2026-04-20'),(56,'10000001',49,'Buzo Adidas de media estación, el rústico es liviano.',4,'2026-04-25'),(57,'34567890',65,'Buena bermuda cargo Vancouver, la gabardina es suave.',4,'2026-05-01'),(58,'10000010',30,'Bermuda de jean VCP, buen corte, jean de calidad.',5,'2026-05-05');
/*!40000 ALTER TABLE `resenia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talle`
--

DROP TABLE IF EXISTS `talle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `talle` (
  `id` int NOT NULL,
  `talle` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talle`
--

LOCK TABLES `talle` WRITE;
/*!40000 ALTER TABLE `talle` DISABLE KEYS */;
INSERT INTO `talle` VALUES (1,'XS'),(2,'S'),(3,'M'),(4,'L'),(5,'XL'),(6,'XXL');
/*!40000 ALTER TABLE `talle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tela`
--

DROP TABLE IF EXISTS `tela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tela` (
  `idTela` int NOT NULL AUTO_INCREMENT,
  `nombreTela` varchar(50) NOT NULL,
  PRIMARY KEY (`idTela`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tela`
--

LOCK TABLES `tela` WRITE;
/*!40000 ALTER TABLE `tela` DISABLE KEYS */;
INSERT INTO `tela` VALUES (1,'Algodón'),(2,'Poliéster'),(3,'Lino'),(4,'Friza'),(5,'Gabardina'),(6,'Denim');
/*!40000 ALTER TABLE `tela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `idTipo` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'Pantalón'),(2,'Bermuda'),(3,'Short'),(4,'Remera'),(5,'Campera'),(6,'Buzo');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-15 17:27:28
