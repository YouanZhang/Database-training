/*
 Navicat Premium Data Transfer

 Source Server         : 我的本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : online_shop7

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 26/06/2020 00:47:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for buyer
-- ----------------------------
DROP TABLE IF EXISTS `buyer`;
CREATE TABLE `buyer` (
  `BUYER_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `NICK_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PASSWORD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `E_MAIL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ADDRESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`BUYER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of buyer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `BUYER_ID` int unsigned NOT NULL,
  `SKU_ID` int NOT NULL,
  `QTY` int NOT NULL,
  KEY `buyer_fk` (`BUYER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for first_class
-- ----------------------------
DROP TABLE IF EXISTS `first_class`;
CREATE TABLE `first_class` (
  `FIRST_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CLASS_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`FIRST_CLASS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of first_class
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mer_collection
-- ----------------------------
DROP TABLE IF EXISTS `mer_collection`;
CREATE TABLE `mer_collection` (
  `BUYER_ID` int NOT NULL,
  `SKU_ID` int NOT NULL,
  PRIMARY KEY (`BUYER_ID`,`SKU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of mer_collection
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for obj_data
-- ----------------------------
DROP TABLE IF EXISTS `obj_data`;
CREATE TABLE `obj_data` (
  `OBJ_DATA_ID` int NOT NULL,
  `SKU_ID` int unsigned NOT NULL,
  `SPU_ID` int DEFAULT NULL,
  `DATA` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`OBJ_DATA_ID`) USING BTREE,
  KEY `sku_fk` (`SKU_ID`),
  CONSTRAINT `sku_fk` FOREIGN KEY (`SKU_ID`) REFERENCES `sku` (`SKU_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of obj_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for parent_order
-- ----------------------------
DROP TABLE IF EXISTS `parent_order`;
CREATE TABLE `parent_order` (
  `PARENT_ORDER_ID` int NOT NULL AUTO_INCREMENT,
  `BUYER_ID` int unsigned NOT NULL,
  `BUYTIME` datetime DEFAULT NULL,
  `STATUS_ORDER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ADDRESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`) USING BTREE,
  KEY `buyer_fk` (`BUYER_ID`),
  CONSTRAINT `buyer_fk` FOREIGN KEY (`BUYER_ID`) REFERENCES `buyer` (`BUYER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of parent_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for second_class
-- ----------------------------
DROP TABLE IF EXISTS `second_class`;
CREATE TABLE `second_class` (
  `SECOND_CLASS_ID` int NOT NULL,
  `CLASS_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `CLASS_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `FIRST_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SECOND_CLASS_ID`) USING BTREE,
  KEY `first_class` (`FIRST_CLASS_ID`),
  CONSTRAINT `first_class` FOREIGN KEY (`FIRST_CLASS_ID`) REFERENCES `first_class` (`FIRST_CLASS_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of second_class
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `SHOP_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SHOP_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `DESCRIBE_WORD` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PASSWORD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `E_MAIL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`SHOP_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of shop
-- ----------------------------
BEGIN;
INSERT INTO `shop` VALUES (1, 'Ronglai Tang', NULL, '123', '2879156336@qq.com');
COMMIT;

-- ----------------------------
-- Table structure for shop_collection
-- ----------------------------
DROP TABLE IF EXISTS `shop_collection`;
CREATE TABLE `shop_collection` (
  `BUYER_ID` int NOT NULL,
  `SHOP_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of shop_collection
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku` (
  `SKU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SKU_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SKU_DESC` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `PRICE` int DEFAULT NULL,
  `SPU_ID` int unsigned NOT NULL,
  `QTY` int DEFAULT NULL,
  `CITY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SHOP_ID` int unsigned NOT NULL,
  PRIMARY KEY (`SKU_ID`) USING BTREE,
  KEY `fk` (`SPU_ID`),
  KEY `shop_fk` (`SHOP_ID`),
  CONSTRAINT `fk` FOREIGN KEY (`SPU_ID`) REFERENCES `spu` (`SPU_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shop_fk` FOREIGN KEY (`SHOP_ID`) REFERENCES `shop` (`SHOP_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sku
-- ----------------------------
BEGIN;
INSERT INTO `sku` VALUES (1, '华为P40Pro 8GB+128GB 冰霜银', '华为P40Pro，5G协议，存储量256GB, 银色', 5988, 3, 100, 'Canton', 1);
INSERT INTO `sku` VALUES (2, '华为P40Pro 8GB+128GB 亮黑色', '华为P40Pro，5G协议，存储量128GB, 黑色', 5988, 3, 100, 'Canton', 1);
INSERT INTO `sku` VALUES (3, '华为P40Pro 8GB+256GB 零度白', '华为P40Pro，5G协议，存储量256GB, 白色', 6488, 3, 100, 'Canton', 1);
INSERT INTO `sku` VALUES (4, '华为P40Pro 8GB+128GB 零度白', '华为P40Pro，5G协议，存储量128GB, 白色', 5988, 3, 100, 'Canton', 1);
INSERT INTO `sku` VALUES (5, '华为P40Pro 8GB+128GB 红色', '华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', 1);
INSERT INTO `sku` VALUES (6, '华为P40Pro 8GB+128GB 红色', '华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', 1);
COMMIT;

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu` (
  `SPU_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SPU_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SPU_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SECOND_CLASS_ID` int DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`) USING BTREE,
  KEY `spu_forkey` (`SECOND_CLASS_ID`),
  CONSTRAINT `spu_forkey` FOREIGN KEY (`SECOND_CLASS_ID`) REFERENCES `second_class` (`SECOND_CLASS_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of spu
-- ----------------------------
BEGIN;
INSERT INTO `spu` VALUES (1, 'test', 'test', NULL);
INSERT INTO `spu` VALUES (2, 'Huawei P40', '华为P40手机，全网通，4G/5G', NULL);
INSERT INTO `spu` VALUES (3, 'Huawei P40 Pro', '华为P40Pro手机，全网通，4G/5G', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sub_order
-- ----------------------------
DROP TABLE IF EXISTS `sub_order`;
CREATE TABLE `sub_order` (
  `PARENT_ORDER_ID` int NOT NULL,
  `SUB_ORDER_ID` int NOT NULL AUTO_INCREMENT,
  `SKU_ID` int DEFAULT NULL,
  `QTY` int DEFAULT NULL,
  `SHOP_ID` int DEFAULT NULL,
  `MONEY` int DEFAULT NULL,
  `EXPRESS_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`SUB_ORDER_ID`) USING BTREE,
  KEY `order_fk` (`PARENT_ORDER_ID`),
  CONSTRAINT `order_fk` FOREIGN KEY (`PARENT_ORDER_ID`) REFERENCES `parent_order` (`PARENT_ORDER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sub_order
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
