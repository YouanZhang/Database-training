/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : online_shop2

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 24/06/2020 14:30:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for buyer
-- ----------------------------
DROP TABLE IF EXISTS `buyer`;
CREATE TABLE `buyer`  (
  `BUYER_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NICK_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `E_MAIL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`BUYER_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buyer
-- ----------------------------

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `BUYER_ID` int(0) NOT NULL,
  `SKU_ID` int(0) NOT NULL,
  `QTY` int(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for first_class
-- ----------------------------
DROP TABLE IF EXISTS `first_class`;
CREATE TABLE `first_class`  (
  `FIRST_CLASS_ID` int(0) NOT NULL,
  `CLASS_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CLASS_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`FIRST_CLASS_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of first_class
-- ----------------------------

-- ----------------------------
-- Table structure for mer_collection
-- ----------------------------
DROP TABLE IF EXISTS `mer_collection`;
CREATE TABLE `mer_collection`  (
  `BUYER_ID` int(0) NOT NULL,
  `SKU_ID` int(0) NOT NULL,
  PRIMARY KEY (`BUYER_ID`, `SKU_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mer_collection
-- ----------------------------

-- ----------------------------
-- Table structure for obj_data
-- ----------------------------
DROP TABLE IF EXISTS `obj_data`;
CREATE TABLE `obj_data`  (
  `OBJ_DATA_ID` int(0) NOT NULL,
  `SKU_ID` int(0) NULL DEFAULT NULL,
  `SPU_ID` int(0) NULL DEFAULT NULL,
  `DATA` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`OBJ_DATA_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of obj_data
-- ----------------------------

-- ----------------------------
-- Table structure for parent_order
-- ----------------------------
DROP TABLE IF EXISTS `parent_order`;
CREATE TABLE `parent_order`  (
  `PARENT_ORDER_ID` int(0) NOT NULL AUTO_INCREMENT,
  `BUYER_ID` int(0) NULL DEFAULT NULL,
  `BUYTIME` datetime(0) NULL DEFAULT NULL,
  `STATUS_ORDER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of parent_order
-- ----------------------------

-- ----------------------------
-- Table structure for second_class
-- ----------------------------
DROP TABLE IF EXISTS `second_class`;
CREATE TABLE `second_class`  (
  `SECOND_CLASS_ID` int(0) NOT NULL,
  `CLASS_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CLASS_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FIRST_CLASS_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SECOND_CLASS_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of second_class
-- ----------------------------

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `SHOP_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SHOP_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIBE_WORD` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `E_MAIL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SHOP_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES (1, 'Ronglai Tang', NULL, '123', '2879156336@qq.com');

-- ----------------------------
-- Table structure for shop_collection
-- ----------------------------
DROP TABLE IF EXISTS `shop_collection`;
CREATE TABLE `shop_collection`  (
  `BUYER_ID` int(0) NOT NULL,
  `SHOP_ID` int(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_collection
-- ----------------------------

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `SKU_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SKU_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SKU_DESC` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PRICE` int(0) NULL DEFAULT NULL,
  `SPU_ID` int(0) NULL DEFAULT NULL,
  `QTY` int(0) NULL DEFAULT NULL,
  `CITY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SHOP_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SKU_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sku
-- ----------------------------
INSERT INTO `sku` VALUES (1, '华为P40Pro 8GB+128GB 冰霜银', '华为P40Pro，5G协议，存储量256GB, 银色', 5988, 3, NULL, NULL, NULL);
INSERT INTO `sku` VALUES (2, '华为P40Pro 8GB+128GB 亮黑色', '华为P40Pro，5G协议，存储量128GB, 黑色', 5988, 3, NULL, NULL, NULL);
INSERT INTO `sku` VALUES (3, '华为P40Pro 8GB+256GB 零度白', '华为P40Pro，5G协议，存储量256GB, 白色', 6488, 3, NULL, NULL, NULL);
INSERT INTO `sku` VALUES (4, '华为P40Pro 8GB+128GB 零度白', '华为P40Pro，5G协议，存储量128GB, 白色', 5988, 3, NULL, NULL, NULL);
INSERT INTO `sku` VALUES (5, '华为P40Pro 8GB+128GB 红色', '华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', NULL);
INSERT INTO `sku` VALUES (6, '华为P40Pro 8GB+128GB 红色', '华为P40Pro，5G协议，存储量128GB, 红色', 5988, 3, 100, '广州', NULL);

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu`  (
  `SPU_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SPU_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SPU_DESC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SECOND_CLASS_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spu
-- ----------------------------
INSERT INTO `spu` VALUES (1, 'test', 'test', NULL);
INSERT INTO `spu` VALUES (2, 'Huawei P40', '华为P40手机，全网通，4G/5G', NULL);
INSERT INTO `spu` VALUES (3, 'Huawei P40 Pro', '华为P40Pro手机，全网通，4G/5G', NULL);

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `WAREHOUSE_ID` int(0) NULL DEFAULT NULL,
  `SPU_ID` int(0) NOT NULL,
  `SKU_ID` int(0) NOT NULL,
  `QTY` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`, `SKU_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store
-- ----------------------------

-- ----------------------------
-- Table structure for sub_order
-- ----------------------------
DROP TABLE IF EXISTS `sub_order`;
CREATE TABLE `sub_order`  (
  `PARENT_ORDER_ID` int(0) NOT NULL,
  `SUB_ORDER_ID` int(0) NOT NULL AUTO_INCREMENT,
  `SKU_ID` int(0) NULL DEFAULT NULL,
  `QTY` int(0) NULL DEFAULT NULL,
  `SHOP_ID` int(0) NULL DEFAULT NULL,
  `MONEY` int(0) NULL DEFAULT NULL,
  `EXPRESS_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SUB_ORDER_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sub_order
-- ----------------------------

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse`  (
  `WAREHOUSE_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `WAREHOUSE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SHOP_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`WAREHOUSE_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouse
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
