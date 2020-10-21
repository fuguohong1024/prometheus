/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : prometheus

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 12/10/2020 21:27:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for target
-- ----------------------------
DROP TABLE IF EXISTS `target`;
CREATE TABLE `target`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `target` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采集目标ip:port',
  `labels` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签 ex:{\"key\": \"ip\",\"value\": \"127.0.0.1\"}',
  `group_id` int(0) NOT NULL COMMENT 'fk',
  `describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'job' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
 ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of target
-- ----------------------------
INSERT INTO `target` VALUES (2, '2020-10-12 14:16:58', '2020-10-12 14:17:00', '47.112.13.163:9100', '{\r\n \"key\": \"ip\",\r\n \"value\": \"47.112.13.163\"\r\n}', 2, 'new');

SET FOREIGN_KEY_CHECKS = 1;
