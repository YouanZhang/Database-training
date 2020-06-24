-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: online_shop2
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BUYER`
--

DROP TABLE IF EXISTS `BUYER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUYER` (
  `BUYER_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `NICK_NAME` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `E_MAIL` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BUYER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BUYER`
--

LOCK TABLES `BUYER` WRITE;
/*!40000 ALTER TABLE `BUYER` DISABLE KEYS */;
/*!40000 ALTER TABLE `BUYER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CART`
--

DROP TABLE IF EXISTS `CART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CART` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  `QTY` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CART`
--

LOCK TABLES `CART` WRITE;
/*!40000 ALTER TABLE `CART` DISABLE KEYS */;
/*!40000 ALTER TABLE `CART` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FIRST_CLASS`
--

DROP TABLE IF EXISTS `FIRST_CLASS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FIRST_CLASS` (
  `FIRST_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) DEFAULT NULL,
  `CLASS_NAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`FIRST_CLASS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FIRST_CLASS`
--

LOCK TABLES `FIRST_CLASS` WRITE;
/*!40000 ALTER TABLE `FIRST_CLASS` DISABLE KEYS */;
/*!40000 ALTER TABLE `FIRST_CLASS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MER_COLLECTION`
--

DROP TABLE IF EXISTS `MER_COLLECTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MER_COLLECTION` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  PRIMARY KEY (`BUYER_ID`,`SKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MER_COLLECTION`
--

LOCK TABLES `MER_COLLECTION` WRITE;
/*!40000 ALTER TABLE `MER_COLLECTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `MER_COLLECTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OBJ_DATA`
--

DROP TABLE IF EXISTS `OBJ_DATA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OBJ_DATA` (
  `OBJ_DATA_ID` int NOT NULL,
  `SKU_ID` int DEFAULT NULL,
  `SPU_ID` int DEFAULT NULL,
  `DATA` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`OBJ_DATA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OBJ_DATA`
--

LOCK TABLES `OBJ_DATA` WRITE;
/*!40000 ALTER TABLE `OBJ_DATA` DISABLE KEYS */;
/*!40000 ALTER TABLE `OBJ_DATA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARENT_ORDER`
--

DROP TABLE IF EXISTS `PARENT_ORDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARENT_ORDER` (
  `PARENT_ORDER_ID` int NOT NULL AUTO_INCREMENT,
  `BUYER_ID` int DEFAULT NULL,
  `BUYTIME` datetime DEFAULT NULL,
  `STATUS_ORDER` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARENT_ORDER`
--

LOCK TABLES `PARENT_ORDER` WRITE;
/*!40000 ALTER TABLE `PARENT_ORDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `PARENT_ORDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SECOND_CLASS`
--

DROP TABLE IF EXISTS `SECOND_CLASS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SECOND_CLASS` (
  `SECOND_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) DEFAULT NULL,
  `CLASS_NAME` varchar(20) DEFAULT NULL,
  `FIRST_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SECOND_CLASS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SECOND_CLASS`
--

LOCK TABLES `SECOND_CLASS` WRITE;
/*!40000 ALTER TABLE `SECOND_CLASS` DISABLE KEYS */;
/*!40000 ALTER TABLE `SECOND_CLASS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHOP`
--

DROP TABLE IF EXISTS `SHOP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHOP` (
  `SHOP_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SHOP_NAME` varchar(20) DEFAULT NULL,
  `DESCRIBE_WORD` varchar(30) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `E_MAIL` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SHOP_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHOP`
--

LOCK TABLES `SHOP` WRITE;
/*!40000 ALTER TABLE `SHOP` DISABLE KEYS */;
INSERT INTO `SHOP` VALUES (1,'Ronglai Tang',NULL,'123','2879156336@qq.com');
/*!40000 ALTER TABLE `SHOP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SHOP_COLLECTION`
--

DROP TABLE IF EXISTS `SHOP_COLLECTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SHOP_COLLECTION` (
  `BUYER_ID` int NOT NULL,
  `SHOP_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SHOP_COLLECTION`
--

LOCK TABLES `SHOP_COLLECTION` WRITE;
/*!40000 ALTER TABLE `SHOP_COLLECTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SHOP_COLLECTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SKU`
--

DROP TABLE IF EXISTS `SKU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SKU` (
  `SKU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SKU_DESC` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PRICE` int DEFAULT NULL,
  `SPU_ID` int DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  `CITY` varchar(20) DEFAULT NULL,
  `SHOP_ID` int DEFAULT NULL,
  PRIMARY KEY (`SKU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SKU`
--

LOCK TABLES `SKU` WRITE;
/*!40000 ALTER TABLE `SKU` DISABLE KEYS */;
INSERT INTO `SKU` VALUES (1,'华为P40Pro 8GB+128GB 冰霜银','华为P40Pro，5G协议，存储量256GB, 银色',5988,3,NULL,NULL,NULL),(2,'华为P40Pro 8GB+128GB 亮黑色','华为P40Pro，5G协议，存储量128GB, 黑色',5988,3,NULL,NULL,NULL),(3,'华为P40Pro 8GB+256GB 零度白','华为P40Pro，5G协议，存储量256GB, 白色',6488,3,NULL,NULL,NULL),(4,'华为P40Pro 8GB+128GB 零度白','华为P40Pro，5G协议，存储量128GB, 白色',5988,3,NULL,NULL,NULL),(5,'华为P40Pro 8GB+128GB 红色','华为P40Pro，5G协议，存储量128GB, 红色',5988,3,100,'广州',NULL),(6,'华为P40Pro 8GB+128GB 红色','华为P40Pro，5G协议，存储量128GB, 红色',5988,3,100,'广州',NULL);
/*!40000 ALTER TABLE `SKU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SPU`
--

DROP TABLE IF EXISTS `SPU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SPU` (
  `SPU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SPU_NAME` varchar(20) DEFAULT NULL,
  `SPU_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SECOND_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPU`
--

LOCK TABLES `SPU` WRITE;
/*!40000 ALTER TABLE `SPU` DISABLE KEYS */;
INSERT INTO `SPU` VALUES (1,'test','test',NULL),(2,'Huawei P40','华为P40手机，全网通，4G/5G',NULL),(3,'Huawei P40 Pro','华为P40Pro手机，全网通，4G/5G',NULL);
/*!40000 ALTER TABLE `SPU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SUB_ORDER`
--

DROP TABLE IF EXISTS `SUB_ORDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SUB_ORDER` (
  `PARENT_ORDER_ID` int NOT NULL,
  `SUB_ORDER_ID` int NOT NULL AUTO_INCREMENT,
  `SKU_ID` int DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  `SHOP_ID` int DEFAULT NULL,
  `MONEY` int DEFAULT NULL,
  `EXPRESS_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`,`SUB_ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUB_ORDER`
--

LOCK TABLES `SUB_ORDER` WRITE;
/*!40000 ALTER TABLE `SUB_ORDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `SUB_ORDER` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-24  9:58:49
