CREATE TABLE `prometheus`.`target`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_at` datetime(0) NULL COMMENT '创建时间',
  `update_at` datetime(0) NULL COMMENT '更新时间',
  `target` varchar(200) NOT NULL COMMENT '采集目标ip:port',
  `labels` varchar(200) NULL COMMENT '标签 ex:{"key": "ip","value": "127.0.0.1"}',
  `group_id` integer(200) NOT NULL COMMENT 'fk',
  `describe` varchar(200) DEFAULT 'job' COMMENT '描述',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`group_id`) REFERENCES  target_config(`group_id`)
)ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci;


CREATE TABLE `prometheus`.`target_config`  (
  `group_id` integer(200) NOT NULL COMMENT 'fk',
  `createat` datetime(0) NULL COMMENT '创建时间',
  `updateat` datetime(0) NULL COMMENT '更新时间',
  `name` varchar(200) NOT NULL COMMENT 'job名字',
	`metrics_path` varchar(200) DEFAULT '/metrics' COMMENT '采集url',
  `labels` varchar(200) NULL COMMENT '标签',
	`scheme` varchar(200) DEFAULT 'http' COMMENT 'http/https',
  `interval` integer(200)  DEFAULT 60 COMMENT '采集间隔',
	`timeout` integer(200)  DEFAULT 60 COMMENT '超时时间',
  `describe` varchar(200) DEFAULT 'job' COMMENT '描述',
	`auth_user` varchar(200) ,
	`auth_password` varchar(200) ,
	`auth_token` varchar(200) ,
  PRIMARY KEY (`group_id`)
)ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci;