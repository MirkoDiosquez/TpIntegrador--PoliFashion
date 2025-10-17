-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: DHT
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

DROP TABLE IF EXISTS `alerta_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta_stock` (
  `idAlerta` int NOT NULL AUTO_INCREMENT,
  `idPrenda` int NOT NULL,
  `fecha` datetime NOT NULL,
  `motivo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAlerta`),
  KEY `idPrenda` (`idPrenda`),
  CONSTRAINT `alerta_stock_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `prenda` (`idPrenda`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta_stock`
--

LOCK TABLES `alerta_stock` WRITE;
/*!40000 ALTER TABLE `alerta_stock` DISABLE KEYS */;
INSERT INTO `alerta_stock` VALUES (1,3,'2025-10-14 09:00:00','Stock crítico (3 unidades)');
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
  PRIMARY KEY (`dni`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('12345678','Lucía','Gómez','1995-06-15',100,'Femenino'),('23456789','Mateo','Pérez','1990-12-01',50,'Masculino'),('34567890','Sofía','Martínez','2000-03-22',30,'Femenino');
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
  PRIMARY KEY (`idCompra`),
  KEY `clienteDni` (`clienteDni`),
  KEY `idMetodo` (`idMetodo`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`clienteDni`) REFERENCES `cliente` (`dni`),
  CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`idMetodo`) REFERENCES `metodoPago` (`idMetodo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,'12345678','2025-10-10 14:20:00',1),(2,'23456789','2025-10-12 10:30:00',2);
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
  `idPrenda` int DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precioUnitario` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCompra` (`idCompra`),
  KEY `idPrenda` (`idPrenda`),
  CONSTRAINT `compra_detalle_ibfk_1` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`),
  CONSTRAINT `compra_detalle_ibfk_2` FOREIGN KEY (`idPrenda`) REFERENCES `prenda` (`idPrenda`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra_detalle`
--

LOCK TABLES `compra_detalle` WRITE;
/*!40000 ALTER TABLE `compra_detalle` DISABLE KEYS */;
INSERT INTO `compra_detalle` VALUES (1,1,1,1,4999.99),(2,1,3,2,3999),(3,2,2,1,5999.5);
/*!40000 ALTER TABLE `compra_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion` (
  `idCompra` int NOT NULL,
  `dniCliente` varchar(15) NOT NULL,
  `fechaHora` datetime NOT NULL,
  PRIMARY KEY (`idCompra`),
  KEY `dniCliente` (`dniCliente`),
  CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`),
  CONSTRAINT `devolucion_ibfk_2` FOREIGN KEY (`dniCliente`) REFERENCES `cliente` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
INSERT INTO `devolucion` VALUES (2,'23456789','2025-10-13 11:00:00');
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
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
  `fechaHora` datetime NOT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'Desfile Primavera','Evento de moda primavera 2025','2025-09-01 18:00:00','Buenos Aires'),(2,'Lanzamiento EcoWear','Nueva colección sostenible','2025-10-05 15:00:00','Córdoba');
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
  CONSTRAINT `evento_has_prenda_ibfk_1` FOREIGN KEY (`p_idPrenda`) REFERENCES `prenda` (`idPrenda`),
  CONSTRAINT `evento_has_prenda_ibfk_2` FOREIGN KEY (`e_idEvento`) REFERENCES `evento` (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento_has_prenda`
--

LOCK TABLES `evento_has_prenda` WRITE;
/*!40000 ALTER TABLE `evento_has_prenda` DISABLE KEYS */;
INSERT INTO `evento_has_prenda` VALUES (1,1,1),(2,3,2);
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
  `stockMinimo` int DEFAULT '5',
  `aceptaDevoluciones` tinyint(1) DEFAULT '0',
  `porcentajeComision` float DEFAULT NULL,
  `gananciasTotales` float DEFAULT '0',
  `puntos` int DEFAULT '0',
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES (1,'UrbanStyle',5,1,15.5,15000,200),(2,'EcoWear',3,0,10,8000,120);
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodoPago`
--

DROP TABLE IF EXISTS `metodoPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodoPago` (
  `idMetodo` int NOT NULL AUTO_INCREMENT,
  `nombreMetodo` varchar(50) NOT NULL,
  PRIMARY KEY (`idMetodo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodoPago`
--

LOCK TABLES `metodoPago` WRITE;
/*!40000 ALTER TABLE `metodoPago` DISABLE KEYS */;
INSERT INTO `metodoPago` VALUES (1,'Tarjeta de Crédito'),(2,'Transferencia'),(3,'Efectivo');
/*!40000 ALTER TABLE `metodoPago` ENABLE KEYS */;
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
  `color` varchar(30) NOT NULL,
  `genero` enum('Masculino','Femenino','Unisex') NOT NULL,
  `precio` float NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`idPrenda`),
  KEY `idTela` (`idTela`),
  KEY `idMarca` (`idMarca`),
  CONSTRAINT `prenda_ibfk_1` FOREIGN KEY (`idTela`) REFERENCES `tela` (`idTela`),
  CONSTRAINT `prenda_ibfk_2` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda`
--

LOCK TABLES `prenda` WRITE;
/*!40000 ALTER TABLE `prenda` DISABLE KEYS */;
INSERT INTO `prenda` VALUES (1,1,1,'Azul','Femenino',5000,'descripcion a modificar despues'),(2,1,2,'Negro','Masculino',6000,'descripcion a modificar despues'),(3,2,3,'Verde','Unisex',4000,'descripcion a modificar despues');
/*!40000 ALTER TABLE `prenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenda_has_talle`
--

DROP TABLE IF EXISTS `prenda_has_talle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenda_has_talle` (
  `id` int NOT NULL,
  `p_idPrenda` int DEFAULT NULL,
  `idTalle` int DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `p_idPrenda` (`p_idPrenda`),
  KEY `idTalle` (`idTalle`),
  CONSTRAINT `prenda_has_talle_ibfk_1` FOREIGN KEY (`p_idPrenda`) REFERENCES `prenda` (`idPrenda`),
  CONSTRAINT `prenda_has_talle_ibfk_2` FOREIGN KEY (`idTalle`) REFERENCES `talle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda_has_talle`
--

LOCK TABLES `prenda_has_talle` WRITE;
/*!40000 ALTER TABLE `prenda_has_talle` DISABLE KEYS */;
INSERT INTO `prenda_has_talle` VALUES (1,1,1,10),(2,1,2,5),(3,2,2,8),(4,3,3,3);
/*!40000 ALTER TABLE `prenda_has_talle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenda_has_tipo`
--

DROP TABLE IF EXISTS `prenda_has_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenda_has_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPrenda` int NOT NULL,
  `idTipo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idPrenda` (`idPrenda`),
  KEY `idTipo` (`idTipo`),
  CONSTRAINT `prenda_has_tipo_ibfk_1` FOREIGN KEY (`idPrenda`) REFERENCES `prenda` (`idPrenda`),
  CONSTRAINT `prenda_has_tipo_ibfk_2` FOREIGN KEY (`idTipo`) REFERENCES `tipo` (`idTipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda_has_tipo`
--

LOCK TABLES `prenda_has_tipo` WRITE;
/*!40000 ALTER TABLE `prenda_has_tipo` DISABLE KEYS */;
INSERT INTO `prenda_has_tipo` VALUES (1,1,1),(2,1,3),(3,2,2);
/*!40000 ALTER TABLE `prenda_has_tipo` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenia`
--

LOCK TABLES `resenia` WRITE;
/*!40000 ALTER TABLE `resenia` DISABLE KEYS */;
INSERT INTO `resenia` VALUES (1,'12345678',1,'Muy cómoda y linda!',5,'2025-10-11'),(2,'23456789',2,'Buena calidad, pero un poco caro.',4,'2025-10-13');
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
INSERT INTO `talle` VALUES (1,'S'),(2,'M'),(3,'L'),(4,'XL'),(5,'XXL');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tela`
--

LOCK TABLES `tela` WRITE;
/*!40000 ALTER TABLE `tela` DISABLE KEYS */;
INSERT INTO `tela` VALUES (1,'Algodón'),(2,'Poliéster'),(3,'Lino');
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
INSERT INTO `tipo` VALUES (1,'Camisa'),(2,'Pantalón'),(3,'Vestido'),(4,'Short'),(5,'Remera'),(6,'Buzo');
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

-- Dump completed on 2025-10-17  9:36:32
