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

 Date: 23/10/2020 15:34:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alert_rule
-- ----------------------------
DROP TABLE IF EXISTS `alert_rule`;
CREATE TABLE `alert_rule`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `createat` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updateat` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储报警规则的组名',
  `alert` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储报警规则的名称',
  `expr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储报警规则的表达式',
  `for` int(0) NOT NULL COMMENT '存储报警规则的延迟时间，默认单位为分钟',
  `labels` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储报警规则的label,ex  key:value,key1:value1...',
  `annotations` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储报警规则的注释,ex  key:value,key1:value1...',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of alert_rule
-- ----------------------------
INSERT INTO `alert_rule` VALUES (1, '2020-10-22 23:06:11', '2020-10-22 23:06:11', 'groupname', 'alertname', 'up == 0', 5, 'ip:127.0.0.1,type:yun', 'des:test,src:test');

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `group_id` int(0) NOT NULL COMMENT 'fk',
  `createat` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updateat` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'job_name',
  `metrics_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/metrics' COMMENT '采集url, default: /metrics',
  `scheme` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'http' COMMENT 'http/https, default: http',
  `interval` int(0) NULL DEFAULT 60 COMMENT '采集间隔, default: 60',
  `timeout` int(0) NULL DEFAULT 60 COMMENT '超时时间, default: 60',
  `describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'job' COMMENT '描述',
  `auth_user` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'https_user',
  `auth_password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'https_password',
  `auth_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'https_token',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `prometheus`.`job`(`group_id`, `createat`, `updateat`, `name`,  `describe`, `auth_user`, `auth_password`, `auth_token`) VALUES (1,NOW(), NOW(), 'ServerStatus',  'mjxj', NULL, NULL, NULL);
-- ----------------------------
-- Table structure for target
-- ----------------------------
DROP TABLE IF EXISTS `target`;
CREATE TABLE `target`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `target` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采集目标ip:port',
  `labels` varchar(200) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL COMMENT '标签 ,ex  key:value,key1:value1...',
  `group_id` int(0) NOT NULL COMMENT 'fk',
  `describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'job' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of target
-- ----------------------------
INSERT INTO `prometheus`.`target`(`create_at`, `update_at`, `target`, `labels`, `group_id`, `describe`) VALUES ( NOW(), NOW(), '192.168.2.50:30001', 'ip:mojing@192.168.2.50,instance:test-ServerStatus', 1, 'new');
SET FOREIGN_KEY_CHECKS = 1;
