/*
 Navicat Premium Data Transfer

 Source Server         : 我的本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : 电商后台

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 20/06/2020 22:15:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for BUYER
-- ----------------------------
DROP TABLE IF EXISTS `BUYER`;
CREATE TABLE `BUYER` (
  `BUYER_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `NICK_NAME` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `E_MAIL` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BUYER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for CART
-- ----------------------------
DROP TABLE IF EXISTS `CART`;
CREATE TABLE `CART` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  PRIMARY KEY (`BUYER_ID`,`SKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for FIRST_CLASS
-- ----------------------------
DROP TABLE IF EXISTS `FIRST_CLASS`;
CREATE TABLE `FIRST_CLASS` (
  `FIRST_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) DEFAULT NULL,
  `CLASS_NAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`FIRST_CLASS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for OBJ_DATA
-- ----------------------------
DROP TABLE IF EXISTS `OBJ_DATA`;
CREATE TABLE `OBJ_DATA` (
  `OBJ_DATA_ID` int NOT NULL,
  `SKU_ID` int DEFAULT NULL,
  `SPU_ID` int DEFAULT NULL,
  `DATA` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`OBJ_DATA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for PARENT_ORDER
-- ----------------------------
DROP TABLE IF EXISTS `PARENT_ORDER`;
CREATE TABLE `PARENT_ORDER` (
  `PARENT_ORDER_ID` int NOT NULL,
  `BUYER_ID` int DEFAULT NULL,
  `BUYTIME` datetime DEFAULT NULL,
  `STATUS_ORDER` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for SECOND_CLASS
-- ----------------------------
DROP TABLE IF EXISTS `SECOND_CLASS`;
CREATE TABLE `SECOND_CLASS` (
  `SECOND_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) DEFAULT NULL,
  `CLASS_NAME` varchar(20) DEFAULT NULL,
  `FIRST_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SECOND_CLASS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for SHOP
-- ----------------------------
DROP TABLE IF EXISTS `SHOP`;
CREATE TABLE `SHOP` (
  `SHOP_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SHOP_NAME` varchar(20) DEFAULT NULL,
  `DESCRIBE_WORD` varchar(30) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `E_MAIL` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SHOP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for SKU
-- ----------------------------
DROP TABLE IF EXISTS `SKU`;
CREATE TABLE `SKU` (
  `SKU_ID` int NOT NULL,
  `SKU_NAME` varchar(20) DEFAULT NULL,
  `SKU_DESC` varchar(20) DEFAULT NULL,
  `OBJ_DATA_ID` int DEFAULT NULL,
  `PRICE` int DEFAULT NULL,
  `SPU_ID` int DEFAULT NULL,
  PRIMARY KEY (`SKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for SPU
-- ----------------------------
DROP TABLE IF EXISTS `SPU`;
CREATE TABLE `SPU` (
  `SPU_ID` int NOT NULL,
  `SPU_NAME` varchar(20) DEFAULT NULL,
  `SPU__DESC` varchar(20) DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for STORE
-- ----------------------------
DROP TABLE IF EXISTS `STORE`;
CREATE TABLE `STORE` (
  `WAREHOUSE_ID` int DEFAULT NULL,
  `SPU_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  `QTY` int DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`,`SKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for SUB_ORDER
-- ----------------------------
DROP TABLE IF EXISTS `SUB_ORDER`;
CREATE TABLE `SUB_ORDER` (
  `PARENT_ORDER_ID` int NOT NULL,
  `SUB_ORDER_ID` int NOT NULL,
  `SKU_ID` int DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  `SHOP_ID` int DEFAULT NULL,
  `MONEY` int DEFAULT NULL,
  `EXPRESS_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`,`SUB_ORDER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for WAREHOUSE
-- ----------------------------
DROP TABLE IF EXISTS `WAREHOUSE`;
CREATE TABLE `WAREHOUSE` (
  `WAREHOUSE_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `WAREHOUSE_NAME` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL,
  `SHOP_ID` int DEFAULT NULL,
  PRIMARY KEY (`WAREHOUSE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
