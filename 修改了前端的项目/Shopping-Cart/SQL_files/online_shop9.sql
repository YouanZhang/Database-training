/*
 Navicat Premium Data Transfer

 Source Server         : online_shop3
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : online_shop7

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 26/06/2020 22:44:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for buyer
-- ----------------------------
DROP TABLE IF EXISTS `buyer`;
CREATE TABLE `buyer`  (
  `BUYER_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `NICK_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `E_MAIL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`BUYER_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of buyer
-- ----------------------------
INSERT INTO `buyer` VALUES (5, 'hbcccc', '123', 'hbc626', 'guangDong');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `BUYER_ID` int(0) UNSIGNED NOT NULL,
  `SKU_ID` int(0) NOT NULL,
  `QTY` int(0) NOT NULL,
  INDEX `buyer_fk`(`BUYER_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for first_class
-- ----------------------------
DROP TABLE IF EXISTS `first_class`;
CREATE TABLE `first_class`  (
  `FIRST_CLASS_ID` int(0) NOT NULL,
  `CLASS_DESC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CLASS_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`FIRST_CLASS_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mer_collection
-- ----------------------------

-- ----------------------------
-- Table structure for obj_data
-- ----------------------------
DROP TABLE IF EXISTS `obj_data`;
CREATE TABLE `obj_data`  (
  `OBJ_DATA_ID` int(0) NOT NULL,
  `SKU_ID` int(0) UNSIGNED NOT NULL,
  `SPU_ID` int(0) NULL DEFAULT NULL,
  `DATA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`OBJ_DATA_ID`) USING BTREE,
  INDEX `sku_fk`(`SKU_ID`) USING BTREE,
  CONSTRAINT `sku_fk` FOREIGN KEY (`SKU_ID`) REFERENCES `sku` (`SKU_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of obj_data
-- ----------------------------

-- ----------------------------
-- Table structure for parent_order
-- ----------------------------
DROP TABLE IF EXISTS `parent_order`;
CREATE TABLE `parent_order`  (
  `PARENT_ORDER_ID` int(0) NOT NULL AUTO_INCREMENT,
  `BUYER_ID` int(0) UNSIGNED NOT NULL,
  `BUYTIME` datetime(0) NULL DEFAULT NULL,
  `STATUS_ORDER` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PARENT_ORDER_ID`) USING BTREE,
  INDEX `buyer_fk`(`BUYER_ID`) USING BTREE,
  CONSTRAINT `buyer_fk` FOREIGN KEY (`BUYER_ID`) REFERENCES `buyer` (`BUYER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of parent_order
-- ----------------------------
INSERT INTO `parent_order` VALUES (1, 5, '2020-06-26 19:20:24', '0', 'guangDong');
INSERT INTO `parent_order` VALUES (2, 5, '2020-06-26 19:22:58', '0', 'guangDong');

-- ----------------------------
-- Table structure for second_class
-- ----------------------------
DROP TABLE IF EXISTS `second_class`;
CREATE TABLE `second_class`  (
  `SECOND_CLASS_ID` int(0) NOT NULL,
  `CLASS_DESC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CLASS_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FIRST_CLASS_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SECOND_CLASS_ID`) USING BTREE,
  INDEX `first_class`(`FIRST_CLASS_ID`) USING BTREE,
  CONSTRAINT `first_class` FOREIGN KEY (`FIRST_CLASS_ID`) REFERENCES `first_class` (`FIRST_CLASS_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of second_class
-- ----------------------------
INSERT INTO `second_class` VALUES (1, NULL, '手机', NULL);
INSERT INTO `second_class` VALUES (2, NULL, '笔记本电脑', NULL);
INSERT INTO `second_class` VALUES (3, NULL, '显卡', NULL);
INSERT INTO `second_class` VALUES (4, NULL, '课程', NULL);

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `SHOP_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SHOP_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIBE_WORD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PASSWORD` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `E_MAIL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SHOP_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES (1, 'Ronglai Tang', NULL, '123', '2879156336@qq.com');
INSERT INTO `shop` VALUES (2, '123', '123', '123', 'hbc626');

-- ----------------------------
-- Table structure for shop_collection
-- ----------------------------
DROP TABLE IF EXISTS `shop_collection`;
CREATE TABLE `shop_collection`  (
  `BUYER_ID` int(0) NOT NULL,
  `SHOP_ID` int(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop_collection
-- ----------------------------

-- ----------------------------
-- Table structure for sku
-- ----------------------------
DROP TABLE IF EXISTS `sku`;
CREATE TABLE `sku`  (
  `SKU_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SKU_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SKU_DESC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PRICE` int(0) NULL DEFAULT NULL,
  `SPU_ID` int(0) UNSIGNED NOT NULL,
  `QTY` int(0) NULL DEFAULT NULL,
  `CITY` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SHOP_ID` int(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`SKU_ID`) USING BTREE,
  INDEX `fk`(`SPU_ID`) USING BTREE,
  INDEX `shop_fk`(`SHOP_ID`) USING BTREE,
  CONSTRAINT `fk` FOREIGN KEY (`SPU_ID`) REFERENCES `spu` (`SPU_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shop_fk` FOREIGN KEY (`SHOP_ID`) REFERENCES `shop` (`SHOP_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sku
-- ----------------------------
INSERT INTO `sku` VALUES (7, '《数据库实训》', '这个课程实在是太棒了！', 128, 5, 198, '1593138401.jpg', 2);
INSERT INTO `sku` VALUES (8, '《UML》', '这个课程也十分不错！', 118, 5, 190, '1593138727.png', 2);
INSERT INTO `sku` VALUES (9, '微星（MSI）万图师XS GeForce RTX 2060 ', '【师出名门，生而不凡！】何需三风？定制风扇充足覆盖优化版PCB，更强散热更耐用！', 2599, 6, 32, '1593139006.jpg', 2);
INSERT INTO `sku` VALUES (10, '微星（MSI）魔龙 GeForce RTX 2070 ', '【6.27限时特价4299！魔光普照】大厂之集大成之作！超频大咖性能与寂冷同在！', 4599, 6, 40, '1593139095.jpg', 2);
INSERT INTO `sku` VALUES (11, '华为P40 5G手机 亮黑色 全网通(6G+128G)', '【立减100，咨询客服更优惠】华为直供。12期免息，现货速发！', 4158, 7, 60, '1593139319.jpg', 2);
INSERT INTO `sku` VALUES (12, '华为P40 5G手机 零度白 全网通(8G+128G)', '【立减100，咨询客服更优惠】华为直供。12期免息，现货速发！', 4488, 7, 40, '1593139352.jpg', 2);

-- ----------------------------
-- Table structure for spu
-- ----------------------------
DROP TABLE IF EXISTS `spu`;
CREATE TABLE `spu`  (
  `SPU_ID` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `SPU_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SPU_DESC` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SECOND_CLASS_ID` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`SPU_ID`) USING BTREE,
  INDEX `spu_forkey`(`SECOND_CLASS_ID`) USING BTREE,
  CONSTRAINT `spu_forkey` FOREIGN KEY (`SECOND_CLASS_ID`) REFERENCES `second_class` (`SECOND_CLASS_ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spu
-- ----------------------------
INSERT INTO `spu` VALUES (2, 'Huawei P40', '华为P40手机，全网通，4G/5G', NULL);
INSERT INTO `spu` VALUES (3, 'Huawei P40 Pro', '华为P40Pro手机，全网通，4G/5G', NULL);
INSERT INTO `spu` VALUES (5, '华工课程', '', 4);
INSERT INTO `spu` VALUES (6, 'Nvidia-RTX', '', 3);
INSERT INTO `spu` VALUES (7, '华为P40', '', 1);

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
  `EXPRESS_ID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SUB_ORDER_ID`) USING BTREE,
  INDEX `order_fk`(`PARENT_ORDER_ID`) USING BTREE,
  CONSTRAINT `order_fk` FOREIGN KEY (`PARENT_ORDER_ID`) REFERENCES `parent_order` (`PARENT_ORDER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sub_order
-- ----------------------------
INSERT INTO `sub_order` VALUES (1, 1, 9, 9, 2, 23391, 'default');
INSERT INTO `sub_order` VALUES (1, 2, 7, 1, 2, 128, 'default');
INSERT INTO `sub_order` VALUES (2, 3, 9, 9, 2, 23391, 'default');
INSERT INTO `sub_order` VALUES (2, 4, 7, 1, 2, 128, 'default');

SET FOREIGN_KEY_CHECKS = 1;
