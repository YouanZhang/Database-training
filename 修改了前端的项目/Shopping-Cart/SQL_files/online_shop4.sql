/*
 Navicat Premium Data Transfer

 Source Server         : 我的本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : online_shop2

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 23/06/2020 01:44:55
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of BUYER
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for CART
-- ----------------------------
DROP TABLE IF EXISTS `CART`;
CREATE TABLE `CART` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  `QTY` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of CART
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of FIRST_CLASS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for MER_COLLECTION
-- ----------------------------
DROP TABLE IF EXISTS `MER_COLLECTION`;
CREATE TABLE `MER_COLLECTION` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  PRIMARY KEY (`BUYER_ID`,`SKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of MER_COLLECTION
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of OBJ_DATA
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of PARENT_ORDER
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of SECOND_CLASS
-- ----------------------------
BEGIN;
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of SHOP
-- ----------------------------
BEGIN;
INSERT INTO `SHOP` VALUES (1, 'Ronglai Tang', NULL, '123', '2879156336@qq.com');
COMMIT;

-- ----------------------------
-- Table structure for SHOP_COLLECTION
-- ----------------------------
DROP TABLE IF EXISTS `SHOP_COLLECTION`;
CREATE TABLE `SHOP_COLLECTION` (
  `BUYER_ID` int NOT NULL,
  `SHOP_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of SHOP_COLLECTION
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for SKU
-- ----------------------------
DROP TABLE IF EXISTS `SKU`;
CREATE TABLE `SKU` (
  `SKU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SKU_DESC` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PRICE` int DEFAULT NULL,
  `SPU_ID` int DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  `CITY` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SKU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of SKU
-- ----------------------------
BEGIN;
INSERT INTO `SKU` VALUES (1, '华为P40Pro 8GB+128GB 冰霜银', '华为P40Pro，5G协议，存储量256GB, 银色', 5988, 3, NULL, NULL);
INSERT INTO `SKU` VALUES (2, '华为P40Pro 8GB+128GB 亮黑色', '华为P40Pro，5G协议，存储量128GB, 黑色', 5988, 3, NULL, NULL);
INSERT INTO `SKU` VALUES (3, '华为P40Pro 8GB+256GB 零度白', '华为P40Pro，5G协议，存储量256GB, 白色', 6488, 3, NULL, NULL);
INSERT INTO `SKU` VALUES (4, '华为P40Pro 8GB+128GB 零度白', '华为P40Pro，5G协议，存储量128GB, 白色', 5988, 3, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for SPU
-- ----------------------------
DROP TABLE IF EXISTS `SPU`;
CREATE TABLE `SPU` (
  `SPU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SPU_NAME` varchar(20) DEFAULT NULL,
  `SPU_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SECOND_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of SPU
-- ----------------------------
BEGIN;
INSERT INTO `SPU` VALUES (1, 'test', 'test', NULL);
INSERT INTO `SPU` VALUES (2, 'Huawei P40', '华为P40手机，全网通，4G/5G', NULL);
INSERT INTO `SPU` VALUES (3, 'Huawei P40 Pro', '华为P40Pro手机，全网通，4G/5G', NULL);
COMMIT;

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
-- Records of SUB_ORDER
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
