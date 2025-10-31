-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: DHT2
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

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

CREATE DATABASE dht;
USE dht;

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
  PRIMARY KEY (`dni`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('10000001','Camila','Rodríguez','1998-05-14',0,'Femenino',NULL),('10000010','Tomás','Vega','1993-08-05',0,'Masculino',NULL),('12345678','Lucía','Gómez','1995-06-15',0,'Femenino',NULL),('23456789','Mateo','Pérez','1990-12-01',0,'Masculino',NULL),('34567890','Sofía','Martínez','2000-03-22',0,'Femenino',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,'12345678','2025-10-10 14:20:00',1,27498),(2,'12345678','2025-10-10 14:20:00',1,27498),(3,'23456789','2025-10-12 10:30:00',2,13999),(4,'12345678','2025-10-10 14:20:00',1,27498),(5,'12345678','2025-10-10 14:20:00',1,27498),(6,'23456789','2025-10-12 10:30:00',2,13999),(7,'10000001','2025-10-14 11:00:00',1,17998),(8,'12345678','2025-10-15 15:30:00',3,11999),(9,'23456789','2025-10-15 16:10:00',1,25999),(10,'10000001','2025-10-16 09:45:00',1,15999),(11,'12345678','2025-10-16 18:20:00',2,16999),(12,'23456789','2025-10-17 14:50:00',1,19999),(13,'10000001','2025-10-17 19:00:00',3,21999),(14,'12345678','2025-10-18 13:15:00',1,14999);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_detalle`
--

LOCK TABLES `compra_detalle` WRITE;
/*!40000 ALTER TABLE `compra_detalle` DISABLE KEYS */;
INSERT INTO `compra_detalle` VALUES (1,1,2,1,7499,12.5),(2,1,7,1,19999,12),(3,2,14,1,13999,10),(4,3,35,2,8999,12),(5,4,41,1,11999,10),(6,5,31,1,25999,12.5),(7,6,25,1,15999,10),(8,7,29,1,16999,13),(9,8,9,1,19999,12),(10,9,20,1,21999,10.5);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  PRIMARY KEY (`idPrenda`),
  KEY `idTela` (`idTela`),
  KEY `idMarca` (`idMarca`),
  KEY `idTipo` (`idTipo`),
  CONSTRAINT `prenda_ibfk_1` FOREIGN KEY (`idTela`) REFERENCES `tela` (`idTela`),
  CONSTRAINT `prenda_ibfk_2` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`),
  CONSTRAINT `prenda_ibfk_3` FOREIGN KEY (`idTipo`) REFERENCES `tipo` (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda`
--

LOCK TABLES `prenda` WRITE;
/*!40000 ALTER TABLE `prenda` DISABLE KEYS */;
INSERT INTO `prenda` VALUES (1,1,1,4,'Remera Sportswear','Masculino',7499,'Remera clásica de algodón con logo Nike.'),(2,2,2,1,'Pantalón Tiro 23','Masculino',19999,'Pantalón de entrenamiento con tecnología AEROREADY.'),(3,3,2,6,'Buzo Essentials Logo','Unisex',14999,'Buzo con capucha y logo Puma en el pecho.'),(4,4,4,6,'Buzo Oversize Urban','Unisex',13999,'Buzo de friza pesada, corte oversize y bolsillo canguro.'),(5,5,3,5,'Campera Lino Liviana','Femenino',21999,'Campera de lino 100% orgánico, ideal para media estación.'),(6,6,6,1,'Jean Slim Fit Denim','Masculino',15999,'Pantalón de jean VCP corte slim, lavado oscuro.'),(7,7,4,1,'Jogger Tribal Print','Unisex',16999,'Jogger de friza con estampado tribal KOTK.'),(8,1,2,5,'Campera Windrunner','Unisex',25999,'Campera cortaviento icónica Nike con diseño chevron.'),(9,2,1,4,'Remera 3-Stripes','Femenino',8999,'Remera clásica Adidas de algodón con las 3 tiras.'),(10,4,5,2,'Bermuda Cargo Kiech','Masculino',11999,'Bermuda de gabardina resistente con bolsillos cargo.');
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda_has_talleycolor`
--

LOCK TABLES `prenda_has_talleycolor` WRITE;
/*!40000 ALTER TABLE `prenda_has_talleycolor` DISABLE KEYS */;
INSERT INTO `prenda_has_talleycolor` VALUES (1,1,2,'Negro',20,5),(2,1,3,'Negro',30,5),(3,1,4,'Negro',25,5),(4,1,3,'Blanco',15,5),(5,1,4,'Blanco',15,5),(6,2,2,'Negro',15,5),(7,2,3,'Negro',15,5),(8,2,4,'Negro',10,5),(9,2,3,'Azul',3,5),(10,3,3,'Gris',20,5),(11,3,4,'Gris',15,5),(12,3,5,'Gris',10,5),(13,3,4,'Rojo',8,5),(14,4,2,'Gris',12,4),(15,4,3,'Gris',15,4),(16,4,4,'Gris',10,4),(17,4,2,'Negro',20,4),(18,4,3,'Negro',18,4),(19,4,4,'Negro',10,4),(20,5,2,'Verde',8,5),(21,5,3,'Verde',10,5),(22,5,2,'Azul',7,5),(23,5,3,'Azul',9,5),(24,6,3,'Azul',14,4),(25,6,4,'Azul',16,4),(26,6,5,'Azul',10,4),(27,7,3,'Negro',1,6),(28,7,4,'Negro',8,6),(29,7,3,'Gris',10,6),(30,7,4,'Gris',9,6),(31,8,3,'Rojo',10,5),(32,8,4,'Rojo',8,5),(33,8,3,'Azul',12,5),(34,8,4,'Azul',10,5),(35,9,1,'Blanco',20,5),(36,9,2,'Blanco',25,5),(37,9,3,'Blanco',20,5),(38,9,1,'Negro',15,5),(39,9,2,'Negro',18,5),(40,10,3,'Verde',18,4),(41,10,4,'Verde',20,4),(42,10,5,'Verde',12,4),(43,10,3,'Gris',15,4),(44,10,4,'Gris',14,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenia`
--

LOCK TABLES `resenia` WRITE;
/*!40000 ALTER TABLE `resenia` DISABLE KEYS */;
INSERT INTO `resenia` VALUES (1,'12345678',1,'Muy buena calidad, el talle M me quedó perfecto.',5,'2025-10-12'),(2,'23456789',4,'El buzo es perfecto, super oversize como me gusta.',5,'2025-10-15'),(3,'10000001',9,'La tela no era lo que esperaba, un poco fina.',3,'2025-10-18');
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

-- Dump completed on 2025-10-27 12:06:38
