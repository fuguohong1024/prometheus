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

 Date: 12/10/2020 21:28:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for target_config
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job`  (
    `id`    int(0) AUTO_INCREMENT COMMENT 'id',
  `group_id` int(0) NOT NULL COMMENT 'fk',
  `createat` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updateat` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `name` varchar(200) NOT NULL CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'job_name',
  `metrics_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/metrics' COMMENT '采集url, default: /metrics',
--   `labels` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
  `scheme` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'http' COMMENT 'http/https, default: http',
  `interval` int(0) NULL DEFAULT 60 COMMENT '采集间隔, default: 60',
  `timeout` int(0) NULL DEFAULT 60 COMMENT '超时时间, default: 60',
  `describe` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'job' COMMENT '描述',
  `auth_user` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_password` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auth_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of target_config
-- ----------------------------
INSERT INTO `job` VALUES (2,2, '2020-10-12 14:06:03', '2020-10-12 14:05:57', 'aliyun', '/metrics', 'http', 60, 60, 'test', NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
