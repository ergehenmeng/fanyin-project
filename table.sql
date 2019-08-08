/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50628
Source Host           : 127.0.0.1:3306
Source Database       : p2p

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2019-07-11 13:51:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `total` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '总资产',
  `available_balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '可用余额(清算+未清算)',
  `recharge` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '充值金额(未清算)',
  `tender_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '投标冻结',
  `withdraw_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现冻结',
  `accumulated_income` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '累计收益',
  `wait_capital` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收本金',
  `wait_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收利息',
  `version` int(10) unsigned DEFAULT '0' COMMENT '乐观锁版本号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_unique` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资产账户表';

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for account_detail_log
-- ----------------------------
DROP TABLE IF EXISTS `account_detail_log`;
CREATE TABLE `account_detail_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '实际操作金额',
  `classify` tinyint(2) DEFAULT NULL COMMENT '资金变动类型 0:充值 1:投资 2:回款 3:提现 4:平台奖励 5:承接奖励 6:转让回款 7:撤标 ',
  `total` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '当前总金额',
  `available_balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '可用余额(已清算+未清算)',
  `recharge` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '充值金额(未清算)',
  `tender_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '投标冻结金额',
  `withdraw_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现冻结金额',
  `accumulated_income` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '累计收益',
  `wait_capital` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收本金',
  `wait_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收利息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `type_index` (`classify`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资产变动详细记录表';

-- ----------------------------
-- Records of account_detail_log
-- ----------------------------

-- ----------------------------
-- Table structure for account_log
-- ----------------------------
DROP TABLE IF EXISTS `account_log`;
CREATE TABLE `account_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '金额',
  `classify` tinyint(2) unsigned DEFAULT NULL COMMENT '资金变动类型 0:充值 1:投资 2:回款 3:提现 4:平台奖励 5:承接奖励 6:转让回款',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `tender_id` int(10) unsigned DEFAULT NULL COMMENT '投标id',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人资金记录表';

-- ----------------------------
-- Records of account_log
-- ----------------------------

-- ----------------------------
-- Table structure for app_feedback
-- ----------------------------
DROP TABLE IF EXISTS `app_feedback`;
CREATE TABLE `app_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `state` tinyint(1) unsigned DEFAULT NULL COMMENT '状态: 0:待解决 1:已解决',
  `version` varchar(50) DEFAULT NULL COMMENT '软件版本',
  `system_version` varchar(50) DEFAULT NULL COMMENT '系统版本',
  `content` varchar(200) DEFAULT NULL COMMENT '反馈内容',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '反馈时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_status` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='APP用户反馈信息表';

-- ----------------------------
-- Records of app_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for app_version
-- ----------------------------
DROP TABLE IF EXISTS `app_version`;
CREATE TABLE `app_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `classify` char(20) DEFAULT NULL COMMENT '版本类型 IOS,ANDROID',
  `version` char(10) DEFAULT NULL COMMENT '版本号:1.2.8',
  `force_update` bit(1) DEFAULT b'0' COMMENT '是否强制更新 0:否 1:是',
  `url` varchar(500) DEFAULT NULL COMMENT '下载地址,android为实际下载地址,ios是跳转到app_store',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注信息:版本更新的东西或解决的问题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='APP版本管理表';

-- ----------------------------
-- Records of app_version
-- ----------------------------

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nid` varchar(20) DEFAULT NULL COMMENT '所属模板nid,例如充值,开户,提现等',
  `code` varchar(20) NOT NULL COMMENT '银行编码类型:ABC,ICBC',
  `transform_code` varchar(50) DEFAULT NULL COMMENT '第三方充值银行编码(三方支付公司采用的编码可能不是ABC,ICBC等)',
  `bank_name` varchar(20) NOT NULL COMMENT '银行名称',
  `limit_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '单卡当日限额',
  `icon` varchar(500) DEFAULT NULL COMMENT '银行图标(长图)',
  `logo` varchar(500) DEFAULT NULL COMMENT '银行图标logo(短图)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态:0:正常 1:已删除(数据库可见,后台不可见)',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态 0:未锁定1:锁定(相当于下架,后台可见,前台不可见)',
  `remark` varchar(100) DEFAULT NULL COMMENT '银行卡限额说明',
  PRIMARY KEY (`id`),
  KEY `type_index` (`code`),
  KEY `name_index` (`bank_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='银行信息表';

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES ('1', null, '1', null, '我是出借,你是出借吗', '0.00', null, null, '2018-04-25 14:36:43', null, '\0', '\0', '去');

-- ----------------------------
-- Table structure for bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bank_card`;
CREATE TABLE `bank_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `user_type` tinyint(1) unsigned DEFAULT '0' COMMENT '用户类型 0:投资人 1:借款人',
  `bank_code` varchar(10) DEFAULT NULL COMMENT '银行编号:ABC,ICBC',
  `bank_num` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `mobile` char(11) DEFAULT NULL COMMENT '银行预留手机号',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_index` (`user_id`) USING BTREE,
  KEY `user_type_index` (`user_type`),
  KEY `bank_code_index` (`bank_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡信息表';

-- ----------------------------
-- Records of bank_card
-- ----------------------------

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classify` tinyint(2) unsigned DEFAULT NULL COMMENT '轮播图类型:由system_dict的banner_classify维护(不同模块的轮播均在该表中维护)',
  `client_type` tinyint(1) unsigned DEFAULT '0' COMMENT '客户端类型 0:PC 1:APP',
  `img_url` varchar(500) NOT NULL COMMENT '轮播图片地址',
  `turn_url` varchar(500) DEFAULT NULL COMMENT '轮播图点击后跳转的URL',
  `sort` tinyint(2) unsigned DEFAULT NULL COMMENT '轮播图顺序(大<->小) 最大的在最前面',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '开始展示时间(可在指定时间后开始展示)',
  `end_time` datetime DEFAULT NULL COMMENT '取消展示的时间(只在某个时间段展示)',
  `click` bit(1) DEFAULT b'1' COMMENT '是否可点击 0:否 1:可以',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:未删除 1:已删除',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `type_client_type_index` (`classify`,`client_type`) USING BTREE COMMENT '组合索引',
  KEY `type_index` (`classify`),
  KEY `client_type_index` (`classify`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='轮播图维护表';

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('1', '1', '1', '1', '1', null, '2018-10-17 10:18:08', null, '', null, null, null, null);

-- ----------------------------
-- Table structure for borrower
-- ----------------------------
DROP TABLE IF EXISTS `borrower`;
CREATE TABLE `borrower` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` char(11) NOT NULL COMMENT '手机号码',
  `password` varchar(128) DEFAULT NULL COMMENT '登陆密码MD5',
  `deposit_no` varchar(128) DEFAULT NULL COMMENT '存管号',
  `deposit_status` tinyint(1) unsigned DEFAULT NULL COMMENT '存管状态',
  `locked` bit(1) DEFAULT b'0' COMMENT '用户状态 0:未锁定 1:锁定(不可登陆系统)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除(仅数据库可见)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人借款人信息';

-- ----------------------------
-- Records of borrower
-- ----------------------------

-- ----------------------------
-- Table structure for borrower_account
-- ----------------------------
DROP TABLE IF EXISTS `borrower_account`;
CREATE TABLE `borrower_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrower_id` int(10) unsigned DEFAULT NULL COMMENT '借款人id',
  `total` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '借款总额(该值只会累加)',
  `available_balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '可用余额(清算+未清算)',
  `recharge` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '充值金额',
  `withdraw_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现冻结金额',
  `repay` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '已还金额',
  `un_repay` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '未还金额',
  `pay` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '已缴费金额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `borrower_id_unique` (`borrower_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人资产表';

-- ----------------------------
-- Records of borrower_account
-- ----------------------------

-- ----------------------------
-- Table structure for borrower_account_log
-- ----------------------------
DROP TABLE IF EXISTS `borrower_account_log`;
CREATE TABLE `borrower_account_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrower_id` int(10) DEFAULT NULL COMMENT '借款人id',
  `amount` decimal(12,2) DEFAULT '0.00' COMMENT '资金金额',
  `classify` tinyint(2) DEFAULT NULL COMMENT '资金类型',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `project_id` int(10) DEFAULT NULL COMMENT '产品id',
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`),
  KEY `borrower_id_index` (`borrower_id`),
  KEY `borrower_id_type_index` (`classify`,`borrower_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人资金记录表';

-- ----------------------------
-- Records of borrower_account_log
-- ----------------------------

-- ----------------------------
-- Table structure for borrower_extend
-- ----------------------------
DROP TABLE IF EXISTS `borrower_extend`;
CREATE TABLE `borrower_extend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrower_id` int(10) DEFAULT NULL COMMENT '借款人ID',
  `real_name` varchar(20) DEFAULT NULL COMMENT '借款人真实姓名',
  `id_card` varchar(128) DEFAULT NULL COMMENT '身份证号码',
  `address` varchar(100) DEFAULT NULL COMMENT '户籍地址(身份证)',
  `local_address` varchar(100) DEFAULT NULL COMMENT '现居住地址',
  PRIMARY KEY (`id`),
  KEY `index_borrower_id` (`borrower_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人借款人扩展信息';

-- ----------------------------
-- Records of borrower_extend
-- ----------------------------

-- ----------------------------
-- Table structure for discount_coupon
-- ----------------------------
DROP TABLE IF EXISTS `discount_coupon`;
CREATE TABLE `discount_coupon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `title` varchar(100) DEFAULT NULL COMMENT '优惠券名称',
  `state` tinyint(1) DEFAULT NULL COMMENT '优惠券状态 0:未使用 1:已使用 2:已冻结,3已过期',
  `classify` tinyint(1) DEFAULT NULL COMMENT '优惠券类型 0:抵扣券 1:加息券',
  `face_value` decimal(10,2) DEFAULT NULL COMMENT '优惠券金额 抵扣券时表示元,加息券时表示%',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '有效开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '失效时间 如果为空则永久有效',
  `period_limit` tinyint(2) unsigned DEFAULT '0' COMMENT '期限限制(月)',
  `amount_limit` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '起投金额限制',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发放时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `user_id_status_index` (`user_id`,`state`),
  KEY `type_index` (`classify`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户优惠券表';

-- ----------------------------
-- Records of discount_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for discount_coupon_tender
-- ----------------------------
DROP TABLE IF EXISTS `discount_coupon_tender`;
CREATE TABLE `discount_coupon_tender` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tender_id` int(10) unsigned DEFAULT NULL COMMENT '投标id',
  `discount_coupon_id` int(10) unsigned DEFAULT NULL COMMENT '优惠券id',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间(使用时间)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投标优惠券关联表';

-- ----------------------------
-- Records of discount_coupon_tender
-- ----------------------------

-- ----------------------------
-- Table structure for help_instruction
-- ----------------------------
DROP TABLE IF EXISTS `help_instruction`;
CREATE TABLE `help_instruction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `classify` tinyint(2) DEFAULT NULL COMMENT '帮助分类取system_dict表中help_classify字段',
  `state` tinyint(1) DEFAULT '1' COMMENT '状态 0:不显示 1:显示',
  `ask` varchar(50) DEFAULT NULL COMMENT '问',
  `answer` varchar(2000) DEFAULT NULL COMMENT '答 支持',
  `sort` tinyint(4) DEFAULT '0' COMMENT '排序(小<->大)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:不删除(正常) 1:已删除',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='帮助说明信息表';

-- ----------------------------
-- Records of help_instruction
-- ----------------------------

-- ----------------------------
-- Table structure for image_log
-- ----------------------------
DROP TABLE IF EXISTS `image_log`;
CREATE TABLE `image_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '图片名称',
  `classify` tinyint(3) unsigned DEFAULT NULL COMMENT '图片分类 数据字典image_classify',
  `url` varchar(500) DEFAULT NULL COMMENT '文件存放地址',
  `size` bigint(15) unsigned DEFAULT NULL COMMENT '文件大小',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:未删除 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='图片上传记录';

-- ----------------------------
-- Records of image_log
-- ----------------------------
INSERT INTO `image_log` VALUES ('1', '首页打字', '1', '/upload/img/2018-11-29/af77cdda-0246-4925-a406-00180d0923cf.png', '166315', '', '\0', '2018-11-29 15:42:53', null);
INSERT INTO `image_log` VALUES ('2', 'sssss', '2', '/upload/img/2018-11-30/5802b358-8f64-4edd-85a4-c5d6b327e10d.jpg', '3636', '', '\0', '2018-11-30 13:40:32', null);
INSERT INTO `image_log` VALUES ('3', 'cccc', '1', '/upload/img/2018-11-30/134f8d13-8c24-474f-9900-f59fea1f2bc3.jpg', '146822', 'asasdxxx', '\0', '2018-11-30 14:14:30', null);

-- ----------------------------
-- Table structure for integral_log
-- ----------------------------
DROP TABLE IF EXISTS `integral_log`;
CREATE TABLE `integral_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `num` smallint(6) unsigned DEFAULT '1' COMMENT '积分数',
  `nid` char(20) NOT NULL COMMENT '积分类型(表integral_type nid)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '获取积分的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分记录表';

-- ----------------------------
-- Records of integral_log
-- ----------------------------

-- ----------------------------
-- Table structure for integral_type
-- ----------------------------
DROP TABLE IF EXISTS `integral_type`;
CREATE TABLE `integral_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nid` char(20) DEFAULT NULL COMMENT '积分类型nid',
  `type_name` varchar(100) DEFAULT NULL COMMENT '积分类型名称',
  `state` bit(1) DEFAULT b'1' COMMENT '积分类型状态 0:不可用 1:可用',
  `score` smallint(6) DEFAULT NULL COMMENT '积分个数',
  `manner` tinyint(1) DEFAULT '0' COMMENT '积分类型 0:收入 1:支出',
  `random` bit(1) DEFAULT b'0' COMMENT '是否为随机积分 0:不是 1:是',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='积分类型表';

-- ----------------------------
-- Records of integral_type
-- ----------------------------
INSERT INTO `integral_type` VALUES ('1', 'first_tender', '首投奖励', '', '10', '0', '\0', '2018-11-15 16:41:42', null, null);
INSERT INTO `integral_type` VALUES ('2', 'max_tender', '最高投奖励', '', '30', '0', '\0', '2018-11-15 16:42:45', null, null);
INSERT INTO `integral_type` VALUES ('3', 'last_tender', '扫尾奖励', '', '5', '0', '\0', '2018-11-15 16:43:11', null, null);
INSERT INTO `integral_type` VALUES ('4', 'sign_in', '签到奖励', '', '5', '0', '', '2018-11-15 16:44:45', null, null);
INSERT INTO `integral_type` VALUES ('5', 'tender', '投资奖励', '', '1', '0', '\0', '2018-11-17 14:11:10', null, '积分由系统参数tender_integral来决定,奖励积分=奖励值*(投标金额/tender_integral)');

-- ----------------------------
-- Table structure for message_template
-- ----------------------------
DROP TABLE IF EXISTS `message_template`;
CREATE TABLE `message_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '消息名称',
  `nid` varchar(50) DEFAULT NULL COMMENT '消息nid',
  `state` bit(1) DEFAULT b'1' COMMENT '状态 0:关闭 1:开启',
  `classify` tinyint(2) unsigned DEFAULT NULL COMMENT '消息类型',
  `content` varchar(1000) DEFAULT NULL COMMENT '消息内容',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tag` varchar(50) DEFAULT NULL COMMENT '后置处理标示符(消息推送跳转页面)',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息模板表';

-- ----------------------------
-- Records of message_template
-- ----------------------------

-- ----------------------------
-- Table structure for operation_data_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_data_log`;
CREATE TABLE `operation_data_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_time` date DEFAULT NULL COMMENT '统计数据时的时间 不包含时分秒',
  `borrow_amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '借款总额(元)',
  `borrow_num` int(10) unsigned DEFAULT '0' COMMENT '总借款个数(借款成功的标的个数)',
  `borrow_people` int(10) unsigned DEFAULT '0' COMMENT '总借款人数',
  `borrow_await` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '总待收金额',
  `tender_earnings` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '累计收益(已回款的利息,包含平台奖励)',
  `tender_people` int(10) unsigned DEFAULT '0' COMMENT '总投资人数',
  `register_people` int(10) unsigned DEFAULT '0' COMMENT '总注册人数',
  `overdue_num` int(10) unsigned DEFAULT '0' COMMENT '总逾期个数(针对标的统计)',
  `now_borrow_num` int(10) unsigned DEFAULT '0' COMMENT '当前借款个数(还在还款中的标的)',
  `now_borrow_people` int(10) unsigned DEFAULT '0' COMMENT '当前借款人数',
  `now_tender_people` int(10) unsigned DEFAULT '0' COMMENT '当前投资人数(在投的人数)',
  `today_borrow_num` int(10) unsigned DEFAULT '0' COMMENT '今日发标个数',
  `today_borrow_amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '今日发标金额',
  `today_tender_amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '今日投标金额',
  `today_overdue_num` int(10) unsigned DEFAULT '0' COMMENT '今日逾期个数(针对标的统计)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日运营数据统计日志表';

-- ----------------------------
-- Records of operation_data_log
-- ----------------------------

-- ----------------------------
-- Table structure for operation_report
-- ----------------------------
DROP TABLE IF EXISTS `operation_report`;
CREATE TABLE `operation_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `client_type` tinyint(1) DEFAULT NULL COMMENT '客户端类型 0:PC 1:APP',
  `img_url` varchar(500) DEFAULT NULL COMMENT '图片地址URL',
  `link_url` varchar(200) DEFAULT NULL COMMENT '链接地址URL',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `year` year(4) DEFAULT NULL COMMENT '年份',
  `month` date DEFAULT NULL COMMENT '月份(包含年)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '是否已删除 0:未删除,1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营报告表';

-- ----------------------------
-- Records of operation_report
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键标的ID',
  `borrower_id` int(10) unsigned NOT NULL COMMENT '借款人ID',
  `nid` varchar(50) DEFAULT NULL COMMENT '产品编号',
  `state` tinyint(2) DEFAULT '0' COMMENT '产品状态:-2:废弃-1:产品撤回,0:录入中,1待初审,2:待复审,3:募集中,4:满标待复审,5:还款中,6:还款完成,7:逾期结清',
  `classify` tinyint(2) DEFAULT '0' COMMENT '产品类型 0:个人贷,1:企业贷',
  `title` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `amount` decimal(12,2) DEFAULT '100.00' COMMENT '计划募集金额',
  `raise_amount` decimal(12,2) DEFAULT '0.00' COMMENT '已募集金额',
  `min_tender` decimal(12,2) DEFAULT '100.00' COMMENT '单次最小投标金额',
  `apr` decimal(3,1) DEFAULT '0.0' COMMENT '标的基础利率 单位%',
  `platform_apr` decimal(2,1) DEFAULT '0.0' COMMENT '平台加息利率 单位%',
  `period` tinyint(2) DEFAULT '1' COMMENT '期限(月)',
  `repayment_mode` tinyint(1) DEFAULT '0' COMMENT '还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '标的信息录入时间',
  `pre_sale_time` datetime DEFAULT NULL COMMENT '预售时间(默认标的发布时间)',
  `publish_time` datetime DEFAULT NULL COMMENT '产品发布时间(复审通过时间)',
  `recheck_time` datetime DEFAULT NULL COMMENT '满标复审时间',
  `end_time` datetime DEFAULT NULL COMMENT '标的完结时间(废弃,撤标,还款完成,逾期结清)等',
  PRIMARY KEY (`id`),
  KEY `borrower_id_index` (`borrower_id`),
  KEY `status_index` (`state`),
  KEY `period_index` (`period`),
  KEY `name_index` (`title`),
  KEY `repayment_type_index` (`repayment_mode`),
  KEY `nid_index` (`nid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for project_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `project_audit_log`;
CREATE TABLE `project_audit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` int(10) unsigned DEFAULT NULL COMMENT '标的ID',
  `state` tinyint(2) DEFAULT NULL COMMENT '审核状态 1:初审通过 2:初审打回 3:复审通过 4:复审拒绝 5:复审打回(直接回到录入中) 6:满标复审通过 7:产品撤回',
  `remark` varchar(200) DEFAULT NULL COMMENT '审核记录',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  `operator_id` int(10) unsigned DEFAULT NULL COMMENT '审核人',
  PRIMARY KEY (`id`),
  KEY `index_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的审核记录表';

-- ----------------------------
-- Records of project_audit_log
-- ----------------------------

-- ----------------------------
-- Table structure for project_car_ext
-- ----------------------------
DROP TABLE IF EXISTS `project_car_ext`;
CREATE TABLE `project_car_ext` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` int(10) unsigned NOT NULL COMMENT '标的信息表',
  `content` text COMMENT '项目详细信息(富文本)',
  PRIMARY KEY (`id`),
  KEY `index_project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的汽车附加信息表';

-- ----------------------------
-- Records of project_car_ext
-- ----------------------------

-- ----------------------------
-- Table structure for project_recover
-- ----------------------------
DROP TABLE IF EXISTS `project_recover`;
CREATE TABLE `project_recover` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '投资人ID',
  `state` tinyint(1) DEFAULT '0' COMMENT '回款状态 0:待回款 1:已回款',
  `tender_id` int(10) DEFAULT NULL COMMENT '投标ID',
  `project_id` int(10) DEFAULT NULL COMMENT '项目ID',
  `period` tinyint(2) DEFAULT NULL COMMENT '第几期回款',
  `periods` tinyint(2) DEFAULT NULL COMMENT '总期数',
  `capital` decimal(12,2) DEFAULT '0.00' COMMENT '应还本金',
  `interest` decimal(12,2) DEFAULT '0.00' COMMENT '预计回款利息(基础利息)',
  `platform_interest` decimal(12,2) DEFAULT '0.00' COMMENT '预计平台加息利息',
  `coupon_interest` decimal(12,2) DEFAULT '0.00' COMMENT '预计加息券利息',
  `receive_time` date DEFAULT NULL COMMENT '预计回款时间(精确到天)',
  `real_receive_time` datetime DEFAULT NULL COMMENT '实际回款时间',
  `receive_month` char(12) DEFAULT NULL COMMENT '预计回款月yyyy-MM',
  `real_receive_month` char(12) DEFAULT NULL COMMENT '实际回款月yyyy-MM',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人回款计划表';

-- ----------------------------
-- Records of project_recover
-- ----------------------------

-- ----------------------------
-- Table structure for project_repayment
-- ----------------------------
DROP TABLE IF EXISTS `project_repayment`;
CREATE TABLE `project_repayment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrower_id` int(10) unsigned DEFAULT NULL COMMENT '借款人ID',
  `project_id` int(10) unsigned DEFAULT NULL COMMENT '标的ID',
  `state` tinyint(1) DEFAULT '0' COMMENT '还款状态 0:未还款 1:正常还款,2:提前还款,3:部分还款,4:逾期还款',
  `period` tinyint(4) unsigned DEFAULT NULL COMMENT '第几期还款',
  `periods` tinyint(3) unsigned DEFAULT NULL COMMENT '总期数',
  `capital` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '预计还款本金',
  `interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '基础利息',
  `platform_interest` decimal(12,2) DEFAULT '0.00' COMMENT '平台加息利息',
  `coupon_interest` decimal(12,2) DEFAULT '0.00' COMMENT '加息券利息',
  `repay_time` date DEFAULT NULL COMMENT '预计还款时间(精确到天)',
  `real_repay_time` datetime DEFAULT NULL COMMENT '实际还款时间(精确到秒)',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  `repay_month` char(12) DEFAULT NULL COMMENT '预计还款月',
  `real_repay_month` char(12) DEFAULT NULL COMMENT '实际还款月',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`borrower_id`),
  KEY `index_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人还款计划表';

-- ----------------------------
-- Records of project_repayment
-- ----------------------------

-- ----------------------------
-- Table structure for project_tender
-- ----------------------------
DROP TABLE IF EXISTS `project_tender`;
CREATE TABLE `project_tender` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `project_id` int(10) DEFAULT NULL COMMENT '标的id',
  `account` decimal(12,2) unsigned DEFAULT NULL COMMENT '投标金额(元)',
  `base_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '基础收益(预计收益)',
  `platform_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '平台加息收益(预计收益)',
  `coupon_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '加息券收益(预计收益)',
  `voucher_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '抵扣券收益',
  `state` tinyint(2) DEFAULT '0' COMMENT '投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成',
  `channel` char(10) DEFAULT 'pc' COMMENT '投标渠道 pc,android,ios,h5,other',
  `ip` varchar(64) DEFAULT NULL COMMENT '投标ip',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '投标时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户投标表';

-- ----------------------------
-- Records of project_tender
-- ----------------------------

-- ----------------------------
-- Table structure for project_tender_statistics
-- ----------------------------
DROP TABLE IF EXISTS `project_tender_statistics`;
CREATE TABLE `project_tender_statistics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` int(10) unsigned DEFAULT NULL COMMENT '产品id',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `tender_id` int(10) unsigned DEFAULT NULL COMMENT '投标id',
  `classify` tinyint(1) unsigned DEFAULT NULL COMMENT '类型 0:首投 1:最高 2:扫尾',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `project_id_index` (`project_id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资统计信息表';

-- ----------------------------
-- Records of project_tender_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for project_tips
-- ----------------------------
DROP TABLE IF EXISTS `project_tips`;
CREATE TABLE `project_tips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_id` int(10) unsigned NOT NULL COMMENT '标的ID',
  `tips_id` int(10) unsigned DEFAULT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  KEY `borrow_id_index` (`project_id`),
  KEY `tips_id_index` (`tips_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的标签关系表';

-- ----------------------------
-- Records of project_tips
-- ----------------------------

-- ----------------------------
-- Table structure for push_log
-- ----------------------------
DROP TABLE IF EXISTS `push_log`;
CREATE TABLE `push_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `alias` varchar(100) DEFAULT NULL COMMENT '别名',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `classify` varchar(50) DEFAULT NULL COMMENT '推送类型',
  `content` varchar(100) DEFAULT NULL COMMENT '正文内容',
  `tag` char(50) DEFAULT NULL COMMENT '标签(用来指定页面)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '结果集',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息推送日志';

-- ----------------------------
-- Records of push_log
-- ----------------------------

-- ----------------------------
-- Table structure for recharge_log
-- ----------------------------
DROP TABLE IF EXISTS `recharge_log`;
CREATE TABLE `recharge_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `user_type` tinyint(1) DEFAULT NULL COMMENT '用户类型 0:投资人 1:借款人',
  `manner` tinyint(1) DEFAULT NULL COMMENT '充值方式 0:快捷充值 1:网银充值',
  `state` tinyint(1) unsigned DEFAULT '0' COMMENT '状态 0:订单生成 1:充值成功 2:充值失败',
  `amount` decimal(12,2) DEFAULT '0.00' COMMENT '充值金额',
  `real_amount` decimal(12,2) DEFAULT '0.00' COMMENT '实际到账金额',
  `order_no` varchar(128) DEFAULT NULL COMMENT '订单号',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '订单生成时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '订单更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录表';

-- ----------------------------
-- Records of recharge_log
-- ----------------------------

-- ----------------------------
-- Table structure for sms_log
-- ----------------------------
DROP TABLE IF EXISTS `sms_log`;
CREATE TABLE `sms_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `classify` varchar(50) DEFAULT NULL COMMENT '短信分类',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `content` varchar(100) DEFAULT NULL COMMENT '短信内容',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  `state` tinyint(1) unsigned DEFAULT NULL COMMENT '发送状态 0:失败 1:已发送',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='短信日志记录表';

-- ----------------------------
-- Records of sms_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_address
-- ----------------------------
DROP TABLE IF EXISTS `system_address`;
CREATE TABLE `system_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL COMMENT '区域名称',
  `nid` char(12) DEFAULT NULL COMMENT '区域代码',
  `pid` char(12) DEFAULT '0' COMMENT '父级区域代码',
  `zip_code` char(12) DEFAULT NULL COMMENT '邮编',
  `mark` char(1) DEFAULT NULL COMMENT '标示符-首字母',
  `classify` tinyint(1) unsigned DEFAULT NULL COMMENT '分类 省份1级 市2级 县3级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3574 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_address
-- ----------------------------
INSERT INTO `system_address` VALUES ('1', '北京', '110000', '0', null, 'B', '1');
INSERT INTO `system_address` VALUES ('2', '市辖区', '110100', '110000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3', '东城区', '110101', '110100', '100000', 'D', '3');
INSERT INTO `system_address` VALUES ('4', '西城区', '110102', '110100', '100000', 'X', '3');
INSERT INTO `system_address` VALUES ('5', '崇文区', '110103', '110100', '100000', 'C', '3');
INSERT INTO `system_address` VALUES ('6', '宣武区', '110104', '110100', '100000', 'X', '3');
INSERT INTO `system_address` VALUES ('7', '朝阳区', '110105', '110100', '100000', 'C', '3');
INSERT INTO `system_address` VALUES ('8', '丰台区', '110106', '110100', '100000', 'F', '3');
INSERT INTO `system_address` VALUES ('9', '石景山区', '110107', '110100', '100000', 'S', '3');
INSERT INTO `system_address` VALUES ('10', '海淀区', '110108', '110100', '100000', 'H', '3');
INSERT INTO `system_address` VALUES ('11', '门头沟区', '110109', '110100', '102300', 'M', '3');
INSERT INTO `system_address` VALUES ('12', '房山区', '110111', '110100', '102400', 'F', '3');
INSERT INTO `system_address` VALUES ('13', '通州区', '110112', '110100', '101100', 'T', '3');
INSERT INTO `system_address` VALUES ('14', '顺义区', '110113', '110100', '101300', 'S', '3');
INSERT INTO `system_address` VALUES ('15', '昌平区', '110114', '110100', '102200', 'C', '3');
INSERT INTO `system_address` VALUES ('16', '大兴区', '110115', '110100', '102600', 'D', '3');
INSERT INTO `system_address` VALUES ('17', '怀柔区', '110116', '110100', '101400', 'H', '3');
INSERT INTO `system_address` VALUES ('18', '平谷区', '110117', '110100', '101200', 'P', '3');
INSERT INTO `system_address` VALUES ('19', '密云县', '110228', '110100', '101500', 'M', '3');
INSERT INTO `system_address` VALUES ('20', '延庆县', '110229', '110100', '102100', 'Y', '3');
INSERT INTO `system_address` VALUES ('21', '天津', '120000', '0', null, 'T', '1');
INSERT INTO `system_address` VALUES ('22', '市辖区', '120100', '120000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('23', '和平区', '120101', '120100', '300000', 'H', '3');
INSERT INTO `system_address` VALUES ('24', '河东区', '120102', '120100', '300000', 'H', '3');
INSERT INTO `system_address` VALUES ('25', '河西区', '120103', '120100', '300000', 'H', '3');
INSERT INTO `system_address` VALUES ('26', '南开区', '120104', '120100', '300000', 'N', '3');
INSERT INTO `system_address` VALUES ('27', '河北区', '120105', '120100', '300000', 'H', '3');
INSERT INTO `system_address` VALUES ('28', '红桥区', '120106', '120100', '300000', 'H', '3');
INSERT INTO `system_address` VALUES ('29', '塘沽区', '120107', '120100', '300450', 'T', '3');
INSERT INTO `system_address` VALUES ('30', '汉沽区', '120108', '120100', '300480', 'H', '3');
INSERT INTO `system_address` VALUES ('31', '大港区', '120109', '120100', '300000', 'D', '3');
INSERT INTO `system_address` VALUES ('32', '东丽区', '120110', '120100', '300000', 'D', '3');
INSERT INTO `system_address` VALUES ('33', '西青区', '120111', '120100', '300000', 'X', '3');
INSERT INTO `system_address` VALUES ('34', '津南区', '120112', '120100', '300000', 'J', '3');
INSERT INTO `system_address` VALUES ('35', '北辰区', '120113', '120100', '300000', 'B', '3');
INSERT INTO `system_address` VALUES ('36', '武清区', '120114', '120100', '301700', 'W', '3');
INSERT INTO `system_address` VALUES ('37', '宝坻区', '120115', '120100', '301800', 'B', '3');
INSERT INTO `system_address` VALUES ('38', '滨海新区', '120116', '120100', '300000', 'B', '3');
INSERT INTO `system_address` VALUES ('39', '宁河县', '120221', '120100', '301500', 'N', '3');
INSERT INTO `system_address` VALUES ('40', '静海县', '120223', '120100', '301600', 'J', '3');
INSERT INTO `system_address` VALUES ('41', '蓟县', '120225', '120100', '301900', 'J', '3');
INSERT INTO `system_address` VALUES ('42', '河北', '130000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('43', '石家庄市', '130100', '130000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('44', '长安区', '130102', '130100', '050000', 'Z', '3');
INSERT INTO `system_address` VALUES ('45', '桥东区', '130103', '130100', '050000', 'Q', '3');
INSERT INTO `system_address` VALUES ('46', '桥西区', '130104', '130100', '050000', 'Q', '3');
INSERT INTO `system_address` VALUES ('47', '新华区', '130105', '130100', '050000', 'X', '3');
INSERT INTO `system_address` VALUES ('48', '井陉矿区', '130107', '130100', '050100', 'J', '3');
INSERT INTO `system_address` VALUES ('49', '裕华区', '130108', '130100', '050000', 'Y', '3');
INSERT INTO `system_address` VALUES ('50', '井陉县', '130121', '130100', '050300', 'J', '3');
INSERT INTO `system_address` VALUES ('51', '正定县', '130123', '130100', '050800', 'Z', '3');
INSERT INTO `system_address` VALUES ('52', '栾城区', '130124', '130100', '051430', 'L', '3');
INSERT INTO `system_address` VALUES ('53', '行唐县', '130125', '130100', '050600', 'X', '3');
INSERT INTO `system_address` VALUES ('54', '灵寿县', '130126', '130100', '050500', 'L', '3');
INSERT INTO `system_address` VALUES ('55', '高邑县', '130127', '130100', '051330', 'G', '3');
INSERT INTO `system_address` VALUES ('56', '深泽县', '130128', '130100', '052500', 'S', '3');
INSERT INTO `system_address` VALUES ('57', '赞皇县', '130129', '130100', '051230', 'Z', '3');
INSERT INTO `system_address` VALUES ('58', '无极县', '130130', '130100', '052460', 'W', '3');
INSERT INTO `system_address` VALUES ('59', '平山县', '130131', '130100', '050400', 'P', '3');
INSERT INTO `system_address` VALUES ('60', '元氏县', '130132', '130100', '051130', 'Y', '3');
INSERT INTO `system_address` VALUES ('61', '赵县', '130133', '130100', '051530', 'Z', '3');
INSERT INTO `system_address` VALUES ('62', '辛集市', '130181', '130100', '052360', 'X', '3');
INSERT INTO `system_address` VALUES ('63', '藁城区', '130182', '130100', '052160', 'G', '3');
INSERT INTO `system_address` VALUES ('64', '晋州市', '130183', '130100', '052200', 'J', '3');
INSERT INTO `system_address` VALUES ('65', '新乐市', '130184', '130100', '050700', 'X', '3');
INSERT INTO `system_address` VALUES ('66', '鹿泉区', '130185', '130100', '050200', 'L', '3');
INSERT INTO `system_address` VALUES ('67', '唐山市', '130200', '130000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('68', '路南区', '130202', '130200', '063000', 'L', '3');
INSERT INTO `system_address` VALUES ('69', '路北区', '130203', '130200', '063000', 'L', '3');
INSERT INTO `system_address` VALUES ('70', '古冶区', '130204', '130200', '063100', 'G', '3');
INSERT INTO `system_address` VALUES ('71', '开平区', '130205', '130200', '063000', 'K', '3');
INSERT INTO `system_address` VALUES ('72', '丰南区', '130207', '130200', '063300', 'F', '3');
INSERT INTO `system_address` VALUES ('73', '丰润区', '130208', '130200', '063000', 'F', '3');
INSERT INTO `system_address` VALUES ('74', '滦县', '130223', '130200', '063700', 'L', '3');
INSERT INTO `system_address` VALUES ('75', '滦南县', '130224', '130200', '063500', 'L', '3');
INSERT INTO `system_address` VALUES ('76', '乐亭县', '130225', '130200', '063600', 'L', '3');
INSERT INTO `system_address` VALUES ('77', '迁西县', '130227', '130200', '064300', 'Q', '3');
INSERT INTO `system_address` VALUES ('78', '玉田县', '130229', '130200', '064100', 'Y', '3');
INSERT INTO `system_address` VALUES ('79', '曹妃甸区', '130230', '130200', '063000', 'C', '3');
INSERT INTO `system_address` VALUES ('80', '遵化市', '130281', '130200', '064200', 'Z', '3');
INSERT INTO `system_address` VALUES ('81', '迁安市', '130283', '130200', '064400', 'Q', '3');
INSERT INTO `system_address` VALUES ('82', '唐海县', '130299', '130200', '063200', 'T', '3');
INSERT INTO `system_address` VALUES ('83', '秦皇岛市', '130300', '130000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('84', '海港区', '130302', '130300', '066000', 'H', '3');
INSERT INTO `system_address` VALUES ('85', '山海关区', '130303', '130300', '066200', 'S', '3');
INSERT INTO `system_address` VALUES ('86', '北戴河区', '130304', '130300', '066100', 'B', '3');
INSERT INTO `system_address` VALUES ('87', '青龙满族自治县', '130321', '130300', '066500', 'Q', '3');
INSERT INTO `system_address` VALUES ('88', '昌黎县', '130322', '130300', '066600', 'C', '3');
INSERT INTO `system_address` VALUES ('89', '抚宁县', '130323', '130300', '066300', 'F', '3');
INSERT INTO `system_address` VALUES ('90', '卢龙县', '130324', '130300', '066400', 'L', '3');
INSERT INTO `system_address` VALUES ('91', '经济技术开发区', '130399', '130300', '066000', 'J', '3');
INSERT INTO `system_address` VALUES ('92', '邯郸市', '130400', '130000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('93', '邯山区', '130402', '130400', '056000', 'H', '3');
INSERT INTO `system_address` VALUES ('94', '丛台区', '130403', '130400', '056000', 'C', '3');
INSERT INTO `system_address` VALUES ('95', '复兴区', '130404', '130400', '056000', 'F', '3');
INSERT INTO `system_address` VALUES ('96', '峰峰矿区', '130406', '130400', '056200', 'F', '3');
INSERT INTO `system_address` VALUES ('97', '邯郸县', '130421', '130400', '056000', 'H', '3');
INSERT INTO `system_address` VALUES ('98', '临漳县', '130423', '130400', '056600', 'L', '3');
INSERT INTO `system_address` VALUES ('99', '成安县', '130424', '130400', '056700', 'C', '3');
INSERT INTO `system_address` VALUES ('100', '大名县', '130425', '130400', '056900', 'D', '3');
INSERT INTO `system_address` VALUES ('101', '涉县', '130426', '130400', '056400', 'S', '3');
INSERT INTO `system_address` VALUES ('102', '磁县', '130427', '130400', '056500', 'C', '3');
INSERT INTO `system_address` VALUES ('103', '肥乡县', '130428', '130400', '057550', 'F', '3');
INSERT INTO `system_address` VALUES ('104', '永年县', '130429', '130400', '057150', 'Y', '3');
INSERT INTO `system_address` VALUES ('105', '邱县', '130430', '130400', '057450', 'Q', '3');
INSERT INTO `system_address` VALUES ('106', '鸡泽县', '130431', '130400', '057350', 'J', '3');
INSERT INTO `system_address` VALUES ('107', '广平县', '130432', '130400', '057650', 'G', '3');
INSERT INTO `system_address` VALUES ('108', '馆陶县', '130433', '130400', '057750', 'G', '3');
INSERT INTO `system_address` VALUES ('109', '魏县', '130434', '130400', '056800', 'W', '3');
INSERT INTO `system_address` VALUES ('110', '曲周县', '130435', '130400', '057250', 'Q', '3');
INSERT INTO `system_address` VALUES ('111', '武安市', '130481', '130400', '056300', 'W', '3');
INSERT INTO `system_address` VALUES ('112', '邢台市', '130500', '130000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('113', '桥东区', '130502', '130500', '054000', 'Q', '3');
INSERT INTO `system_address` VALUES ('114', '桥西区', '130503', '130500', '054000', 'Q', '3');
INSERT INTO `system_address` VALUES ('115', '邢台县', '130521', '130500', '054000', 'X', '3');
INSERT INTO `system_address` VALUES ('116', '临城县', '130522', '130500', '054300', 'L', '3');
INSERT INTO `system_address` VALUES ('117', '内丘县', '130523', '130500', '054200', 'N', '3');
INSERT INTO `system_address` VALUES ('118', '柏乡县', '130524', '130500', '055450', 'B', '3');
INSERT INTO `system_address` VALUES ('119', '隆尧县', '130525', '130500', '055350', 'L', '3');
INSERT INTO `system_address` VALUES ('120', '任县', '130526', '130500', '055150', 'R', '3');
INSERT INTO `system_address` VALUES ('121', '南和县', '130527', '130500', '054000', 'N', '3');
INSERT INTO `system_address` VALUES ('122', '宁晋县', '130528', '130500', '055550', 'N', '3');
INSERT INTO `system_address` VALUES ('123', '巨鹿县', '130529', '130500', '055250', 'J', '3');
INSERT INTO `system_address` VALUES ('124', '新河县', '130530', '130500', '051730', 'X', '3');
INSERT INTO `system_address` VALUES ('125', '广宗县', '130531', '130500', '054600', 'G', '3');
INSERT INTO `system_address` VALUES ('126', '平乡县', '130532', '130500', '054500', 'P', '3');
INSERT INTO `system_address` VALUES ('127', '威县', '130533', '130500', '054700', 'W', '3');
INSERT INTO `system_address` VALUES ('128', '清河县', '130534', '130500', '054800', 'Q', '3');
INSERT INTO `system_address` VALUES ('129', '临西县', '130535', '130500', '054900', 'L', '3');
INSERT INTO `system_address` VALUES ('130', '南宫市', '130581', '130500', '051800', 'N', '3');
INSERT INTO `system_address` VALUES ('131', '沙河市', '130582', '130500', '054100', 'S', '3');
INSERT INTO `system_address` VALUES ('132', '保定市', '130600', '130000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('133', '新市区', '130602', '130600', '071000', 'X', '3');
INSERT INTO `system_address` VALUES ('134', '北市区', '130603', '130600', '071000', 'B', '3');
INSERT INTO `system_address` VALUES ('135', '南市区', '130604', '130600', '071000', 'N', '3');
INSERT INTO `system_address` VALUES ('136', '满城区', '130621', '130600', '072150', 'M', '3');
INSERT INTO `system_address` VALUES ('137', '清苑区', '130622', '130600', '071100', 'Q', '3');
INSERT INTO `system_address` VALUES ('138', '涞水县', '130623', '130600', '074100', 'L', '3');
INSERT INTO `system_address` VALUES ('139', '阜平县', '130624', '130600', '073200', 'F', '3');
INSERT INTO `system_address` VALUES ('140', '徐水区', '130625', '130600', '072550', 'X', '3');
INSERT INTO `system_address` VALUES ('141', '定兴县', '130626', '130600', '072650', 'D', '3');
INSERT INTO `system_address` VALUES ('142', '唐县', '130627', '130600', '072350', 'T', '3');
INSERT INTO `system_address` VALUES ('143', '高阳县', '130628', '130600', '071500', 'G', '3');
INSERT INTO `system_address` VALUES ('144', '容城县', '130629', '130600', '071700', 'R', '3');
INSERT INTO `system_address` VALUES ('145', '涞源县', '130630', '130600', '074300', 'L', '3');
INSERT INTO `system_address` VALUES ('146', '望都县', '130631', '130600', '072450', 'W', '3');
INSERT INTO `system_address` VALUES ('147', '安新县', '130632', '130600', '071600', 'A', '3');
INSERT INTO `system_address` VALUES ('148', '易县', '130633', '130600', '074200', 'Y', '3');
INSERT INTO `system_address` VALUES ('149', '曲阳县', '130634', '130600', '073100', 'Q', '3');
INSERT INTO `system_address` VALUES ('150', '蠡县', '130635', '130600', '071400', 'L', '3');
INSERT INTO `system_address` VALUES ('151', '顺平县', '130636', '130600', '072250', 'S', '3');
INSERT INTO `system_address` VALUES ('152', '博野县', '130637', '130600', '071300', 'B', '3');
INSERT INTO `system_address` VALUES ('153', '雄县', '130638', '130600', '071800', 'X', '3');
INSERT INTO `system_address` VALUES ('154', '涿州市', '130681', '130600', '072750', 'Z', '3');
INSERT INTO `system_address` VALUES ('155', '定州市', '130682', '130600', '073000', 'D', '3');
INSERT INTO `system_address` VALUES ('156', '安国市', '130683', '130600', '071200', 'A', '3');
INSERT INTO `system_address` VALUES ('157', '高碑店市', '130684', '130600', '074000', 'G', '3');
INSERT INTO `system_address` VALUES ('158', '高开区', '130698', '130600', '071700', 'G', '3');
INSERT INTO `system_address` VALUES ('159', '张家口市', '130700', '130000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('160', '桥东区', '130702', '130700', '075000', 'Q', '3');
INSERT INTO `system_address` VALUES ('161', '桥西区', '130703', '130700', '075000', 'Q', '3');
INSERT INTO `system_address` VALUES ('162', '宣化区', '130705', '130700', '075000', 'X', '3');
INSERT INTO `system_address` VALUES ('163', '下花园区', '130706', '130700', '075399', 'X', '3');
INSERT INTO `system_address` VALUES ('164', '宣化县', '130721', '130700', '075100', 'X', '3');
INSERT INTO `system_address` VALUES ('165', '张北县', '130722', '130700', '076450', 'Z', '3');
INSERT INTO `system_address` VALUES ('166', '康保县', '130723', '130700', '076650', 'K', '3');
INSERT INTO `system_address` VALUES ('167', '沽源县', '130724', '130700', '076550', 'G', '3');
INSERT INTO `system_address` VALUES ('168', '尚义县', '130725', '130700', '076750', 'S', '3');
INSERT INTO `system_address` VALUES ('169', '蔚县', '130726', '130700', '075700', 'Y', '3');
INSERT INTO `system_address` VALUES ('170', '阳原县', '130727', '130700', '075800', 'Y', '3');
INSERT INTO `system_address` VALUES ('171', '怀安县', '130728', '130700', '076150', 'H', '3');
INSERT INTO `system_address` VALUES ('172', '万全县', '130729', '130700', '076250', 'W', '3');
INSERT INTO `system_address` VALUES ('173', '怀来县', '130730', '130700', '075400', 'H', '3');
INSERT INTO `system_address` VALUES ('174', '涿鹿县', '130731', '130700', '075600', 'Z', '3');
INSERT INTO `system_address` VALUES ('175', '赤城县', '130732', '130700', '075500', 'C', '3');
INSERT INTO `system_address` VALUES ('176', '崇礼县', '130733', '130700', '076350', 'C', '3');
INSERT INTO `system_address` VALUES ('177', '承德市', '130800', '130000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('178', '双桥区', '130802', '130800', '067000', 'S', '3');
INSERT INTO `system_address` VALUES ('179', '双滦区', '130803', '130800', '067000', 'S', '3');
INSERT INTO `system_address` VALUES ('180', '鹰手营子矿区', '130804', '130800', '067200', 'Y', '3');
INSERT INTO `system_address` VALUES ('181', '承德县', '130821', '130800', '067400', 'C', '3');
INSERT INTO `system_address` VALUES ('182', '兴隆县', '130822', '130800', '067300', 'X', '3');
INSERT INTO `system_address` VALUES ('183', '平泉县', '130823', '130800', '067500', 'P', '3');
INSERT INTO `system_address` VALUES ('184', '滦平县', '130824', '130800', '068250', 'L', '3');
INSERT INTO `system_address` VALUES ('185', '隆化县', '130825', '130800', '068150', 'L', '3');
INSERT INTO `system_address` VALUES ('186', '丰宁满族自治县', '130826', '130800', '068350', 'F', '3');
INSERT INTO `system_address` VALUES ('187', '宽城满族自治县', '130827', '130800', '067600', 'K', '3');
INSERT INTO `system_address` VALUES ('188', '围场满族蒙古族自治县', '130828', '130800', '068450', 'W', '3');
INSERT INTO `system_address` VALUES ('189', '沧州市', '130900', '130000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('190', '新华区', '130902', '130900', '061000', 'X', '3');
INSERT INTO `system_address` VALUES ('191', '运河区', '130903', '130900', '061000', 'Y', '3');
INSERT INTO `system_address` VALUES ('192', '沧县', '130921', '130900', '061000', 'C', '3');
INSERT INTO `system_address` VALUES ('193', '青县', '130922', '130900', '062650', 'Q', '3');
INSERT INTO `system_address` VALUES ('194', '东光县', '130923', '130900', '061600', 'D', '3');
INSERT INTO `system_address` VALUES ('195', '海兴县', '130924', '130900', '061200', 'H', '3');
INSERT INTO `system_address` VALUES ('196', '盐山县', '130925', '130900', '061300', 'Y', '3');
INSERT INTO `system_address` VALUES ('197', '肃宁县', '130926', '130900', '062350', 'S', '3');
INSERT INTO `system_address` VALUES ('198', '南皮县', '130927', '130900', '061500', 'N', '3');
INSERT INTO `system_address` VALUES ('199', '吴桥县', '130928', '130900', '061800', 'W', '3');
INSERT INTO `system_address` VALUES ('200', '献县', '130929', '130900', '062250', 'X', '3');
INSERT INTO `system_address` VALUES ('201', '孟村回族自治县', '130930', '130900', '061400', 'M', '3');
INSERT INTO `system_address` VALUES ('202', '泊头市', '130981', '130900', '062150', 'B', '3');
INSERT INTO `system_address` VALUES ('203', '任丘市', '130982', '130900', '062550', 'R', '3');
INSERT INTO `system_address` VALUES ('204', '黄骅市', '130983', '130900', '061100', 'H', '3');
INSERT INTO `system_address` VALUES ('205', '河间市', '130984', '130900', '062450', 'H', '3');
INSERT INTO `system_address` VALUES ('206', '廊坊市', '131000', '130000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('207', '安次区', '131002', '131000', '065000', 'A', '3');
INSERT INTO `system_address` VALUES ('208', '广阳区', '131003', '131000', '065000', 'G', '3');
INSERT INTO `system_address` VALUES ('209', '固安县', '131022', '131000', '065500', 'G', '3');
INSERT INTO `system_address` VALUES ('210', '永清县', '131023', '131000', '065600', 'Y', '3');
INSERT INTO `system_address` VALUES ('211', '香河县', '131024', '131000', '065400', 'X', '3');
INSERT INTO `system_address` VALUES ('212', '大城县', '131025', '131000', '065900', 'D', '3');
INSERT INTO `system_address` VALUES ('213', '文安县', '131026', '131000', '065800', 'W', '3');
INSERT INTO `system_address` VALUES ('214', '大厂回族自治县', '131028', '131000', '065300', 'D', '3');
INSERT INTO `system_address` VALUES ('215', '开发区', '131051', '131000', '065000', 'K', '3');
INSERT INTO `system_address` VALUES ('216', '燕郊经济技术开发区', '131052', '131000', '065000', 'Y', '3');
INSERT INTO `system_address` VALUES ('217', '霸州市', '131081', '131000', '065700', 'B', '3');
INSERT INTO `system_address` VALUES ('218', '三河市', '131082', '131000', '065201', 'S', '3');
INSERT INTO `system_address` VALUES ('219', '廊坊经济技术开发区', '131099', '131000', '065000', 'L', '3');
INSERT INTO `system_address` VALUES ('220', '衡水市', '131100', '130000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('221', '桃城区', '131102', '131100', '053000', 'T', '3');
INSERT INTO `system_address` VALUES ('222', '枣强县', '131121', '131100', '053100', 'Z', '3');
INSERT INTO `system_address` VALUES ('223', '武邑县', '131122', '131100', '053400', 'W', '3');
INSERT INTO `system_address` VALUES ('224', '武强县', '131123', '131100', '053300', 'W', '3');
INSERT INTO `system_address` VALUES ('225', '饶阳县', '131124', '131100', '053900', 'R', '3');
INSERT INTO `system_address` VALUES ('226', '安平县', '131125', '131100', '053600', 'A', '3');
INSERT INTO `system_address` VALUES ('227', '故城县', '131126', '131100', '253800', 'G', '3');
INSERT INTO `system_address` VALUES ('228', '景县', '131127', '131100', '053500', 'J', '3');
INSERT INTO `system_address` VALUES ('229', '阜城县', '131128', '131100', '053700', 'F', '3');
INSERT INTO `system_address` VALUES ('230', '冀州市', '131181', '131100', '053200', 'J', '3');
INSERT INTO `system_address` VALUES ('231', '深州市', '131182', '131100', '053800', 'S', '3');
INSERT INTO `system_address` VALUES ('232', '山西', '140000', '0', null, 'S', '1');
INSERT INTO `system_address` VALUES ('233', '太原市', '140100', '140000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('234', '小店区', '140105', '140100', '030000', 'X', '3');
INSERT INTO `system_address` VALUES ('235', '迎泽区', '140106', '140100', '030000', 'Y', '3');
INSERT INTO `system_address` VALUES ('236', '杏花岭区', '140107', '140100', '030000', 'X', '3');
INSERT INTO `system_address` VALUES ('237', '尖草坪区', '140108', '140100', '030000', 'J', '3');
INSERT INTO `system_address` VALUES ('238', '万柏林区', '140109', '140100', '030000', 'W', '3');
INSERT INTO `system_address` VALUES ('239', '晋源区', '140110', '140100', '030000', 'J', '3');
INSERT INTO `system_address` VALUES ('240', '清徐县', '140121', '140100', '030400', 'Q', '3');
INSERT INTO `system_address` VALUES ('241', '阳曲县', '140122', '140100', '030100', 'Y', '3');
INSERT INTO `system_address` VALUES ('242', '娄烦县', '140123', '140100', '030300', 'L', '3');
INSERT INTO `system_address` VALUES ('243', '古交市', '140181', '140100', '030200', 'G', '3');
INSERT INTO `system_address` VALUES ('244', '大同市', '140200', '140000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('245', '城区', '140202', '140200', '037000', 'C', '3');
INSERT INTO `system_address` VALUES ('246', '矿区', '140203', '140200', '037000', 'K', '3');
INSERT INTO `system_address` VALUES ('247', '南郊区', '140211', '140200', '037000', 'N', '3');
INSERT INTO `system_address` VALUES ('248', '新荣区', '140212', '140200', '037000', 'X', '3');
INSERT INTO `system_address` VALUES ('249', '阳高县', '140221', '140200', '038100', 'Y', '3');
INSERT INTO `system_address` VALUES ('250', '天镇县', '140222', '140200', '038200', 'T', '3');
INSERT INTO `system_address` VALUES ('251', '广灵县', '140223', '140200', '037500', 'G', '3');
INSERT INTO `system_address` VALUES ('252', '灵丘县', '140224', '140200', '034400', 'L', '3');
INSERT INTO `system_address` VALUES ('253', '浑源县', '140225', '140200', '037400', 'H', '3');
INSERT INTO `system_address` VALUES ('254', '左云县', '140226', '140200', '037100', 'Z', '3');
INSERT INTO `system_address` VALUES ('255', '大同县', '140227', '140200', '037300', 'D', '3');
INSERT INTO `system_address` VALUES ('256', '阳泉市', '140300', '140000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('257', '城区', '140302', '140300', '045000', 'C', '3');
INSERT INTO `system_address` VALUES ('258', '矿区', '140303', '140300', '045000', 'K', '3');
INSERT INTO `system_address` VALUES ('259', '郊区', '140311', '140300', '045000', 'J', '3');
INSERT INTO `system_address` VALUES ('260', '平定县', '140321', '140300', '045200', 'P', '3');
INSERT INTO `system_address` VALUES ('261', '盂县', '140322', '140300', '045100', 'Y', '3');
INSERT INTO `system_address` VALUES ('262', '长治市', '140400', '140000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('263', '长治县', '140421', '140400', '047100', 'Z', '3');
INSERT INTO `system_address` VALUES ('264', '襄垣县', '140423', '140400', '046200', 'X', '3');
INSERT INTO `system_address` VALUES ('265', '屯留县', '140424', '140400', '046100', 'T', '3');
INSERT INTO `system_address` VALUES ('266', '平顺县', '140425', '140400', '047400', 'P', '3');
INSERT INTO `system_address` VALUES ('267', '黎城县', '140426', '140400', '047600', 'L', '3');
INSERT INTO `system_address` VALUES ('268', '壶关县', '140427', '140400', '047300', 'H', '3');
INSERT INTO `system_address` VALUES ('269', '长子县', '140428', '140400', '046600', 'Z', '3');
INSERT INTO `system_address` VALUES ('270', '武乡县', '140429', '140400', '046400', 'W', '3');
INSERT INTO `system_address` VALUES ('271', '沁县', '140430', '140400', '046400', 'Q', '3');
INSERT INTO `system_address` VALUES ('272', '沁源县', '140431', '140400', '046500', 'Q', '3');
INSERT INTO `system_address` VALUES ('273', '潞城市', '140481', '140400', '047500', 'L', '3');
INSERT INTO `system_address` VALUES ('274', '城区', '140482', '140400', '046400', 'C', '3');
INSERT INTO `system_address` VALUES ('275', '郊区', '140483', '140400', '046400', 'J', '3');
INSERT INTO `system_address` VALUES ('276', '高新区', '140484', '140400', '046400', 'G', '3');
INSERT INTO `system_address` VALUES ('277', '晋城市', '140500', '140000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('278', '城区', '140502', '140500', '048000', 'C', '3');
INSERT INTO `system_address` VALUES ('279', '沁水县', '140521', '140500', '048200', 'Q', '3');
INSERT INTO `system_address` VALUES ('280', '阳城县', '140522', '140500', '048100', 'Y', '3');
INSERT INTO `system_address` VALUES ('281', '陵川县', '140524', '140500', '048300', 'L', '3');
INSERT INTO `system_address` VALUES ('282', '泽州县', '140525', '140500', '048000', 'Z', '3');
INSERT INTO `system_address` VALUES ('283', '高平市', '140581', '140500', '048400', 'G', '3');
INSERT INTO `system_address` VALUES ('284', '朔州市', '140600', '140000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('285', '朔城区', '140602', '140600', '036002', 'S', '3');
INSERT INTO `system_address` VALUES ('286', '平鲁区', '140603', '140600', '036800', 'P', '3');
INSERT INTO `system_address` VALUES ('287', '山阴县', '140621', '140600', '036000', 'S', '3');
INSERT INTO `system_address` VALUES ('288', '应县', '140622', '140600', '037600', 'Y', '3');
INSERT INTO `system_address` VALUES ('289', '右玉县', '140623', '140600', '037200', 'Y', '3');
INSERT INTO `system_address` VALUES ('290', '怀仁县', '140624', '140600', '038300', 'H', '3');
INSERT INTO `system_address` VALUES ('291', '晋中市', '140700', '140000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('292', '榆次区', '140702', '140700', '030600', 'Y', '3');
INSERT INTO `system_address` VALUES ('293', '榆社县', '140721', '140700', '031800', 'Y', '3');
INSERT INTO `system_address` VALUES ('294', '左权县', '140722', '140700', '032600', 'Z', '3');
INSERT INTO `system_address` VALUES ('295', '和顺县', '140723', '140700', '032700', 'H', '3');
INSERT INTO `system_address` VALUES ('296', '昔阳县', '140724', '140700', '045300', 'X', '3');
INSERT INTO `system_address` VALUES ('297', '寿阳县', '140725', '140700', '045400', 'S', '3');
INSERT INTO `system_address` VALUES ('298', '太谷县', '140726', '140700', '030800', 'T', '3');
INSERT INTO `system_address` VALUES ('299', '祁县', '140727', '140700', '030900', 'Q', '3');
INSERT INTO `system_address` VALUES ('300', '平遥县', '140728', '140700', '031100', 'P', '3');
INSERT INTO `system_address` VALUES ('301', '灵石县', '140729', '140700', '031300', 'L', '3');
INSERT INTO `system_address` VALUES ('302', '介休市', '140781', '140700', '032000', 'J', '3');
INSERT INTO `system_address` VALUES ('303', '运城市', '140800', '140000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('304', '盐湖区', '140802', '140800', '044000', 'Y', '3');
INSERT INTO `system_address` VALUES ('305', '风陵渡经济开发区', '140803', '140800', '044000', 'F', '3');
INSERT INTO `system_address` VALUES ('306', '临猗县', '140821', '140800', '044100', 'L', '3');
INSERT INTO `system_address` VALUES ('307', '万荣县', '140822', '140800', '044200', 'W', '3');
INSERT INTO `system_address` VALUES ('308', '闻喜县', '140823', '140800', '043800', 'W', '3');
INSERT INTO `system_address` VALUES ('309', '稷山县', '140824', '140800', '043200', 'J', '3');
INSERT INTO `system_address` VALUES ('310', '新绛县', '140825', '140800', '043100', 'X', '3');
INSERT INTO `system_address` VALUES ('311', '绛县', '140826', '140800', '043600', 'J', '3');
INSERT INTO `system_address` VALUES ('312', '垣曲县', '140827', '140800', '043700', 'Y', '3');
INSERT INTO `system_address` VALUES ('313', '夏县', '140828', '140800', '044400', 'X', '3');
INSERT INTO `system_address` VALUES ('314', '平陆县', '140829', '140800', '044300', 'P', '3');
INSERT INTO `system_address` VALUES ('315', '芮城县', '140830', '140800', '044600', 'R', '3');
INSERT INTO `system_address` VALUES ('316', '永济市', '140881', '140800', '044500', 'Y', '3');
INSERT INTO `system_address` VALUES ('317', '河津市', '140882', '140800', '043300', 'H', '3');
INSERT INTO `system_address` VALUES ('318', '忻州市', '140900', '140000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('319', '忻府区', '140902', '140900', '034000', 'X', '3');
INSERT INTO `system_address` VALUES ('320', '定襄县', '140921', '140900', '035400', 'D', '3');
INSERT INTO `system_address` VALUES ('321', '五台县', '140922', '140900', '035500', 'W', '3');
INSERT INTO `system_address` VALUES ('322', '代县', '140923', '140900', '034200', 'D', '3');
INSERT INTO `system_address` VALUES ('323', '繁峙县', '140924', '140900', '034300', 'F', '3');
INSERT INTO `system_address` VALUES ('324', '宁武县', '140925', '140900', '036000', 'N', '3');
INSERT INTO `system_address` VALUES ('325', '静乐县', '140926', '140900', '035100', 'J', '3');
INSERT INTO `system_address` VALUES ('326', '神池县', '140927', '140900', '036100', 'S', '3');
INSERT INTO `system_address` VALUES ('327', '五寨县', '140928', '140900', '036200', 'W', '3');
INSERT INTO `system_address` VALUES ('328', '岢岚县', '140929', '140900', '036300', 'K', '3');
INSERT INTO `system_address` VALUES ('329', '河曲县', '140930', '140900', '036500', 'H', '3');
INSERT INTO `system_address` VALUES ('330', '保德县', '140931', '140900', '036600', 'B', '3');
INSERT INTO `system_address` VALUES ('331', '偏关县', '140932', '140900', '036400', 'P', '3');
INSERT INTO `system_address` VALUES ('332', '原平市', '140981', '140900', '034100', 'Y', '3');
INSERT INTO `system_address` VALUES ('333', '临汾市', '141000', '140000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('334', '尧都区', '141002', '141000', '041000', 'Y', '3');
INSERT INTO `system_address` VALUES ('335', '曲沃县', '141021', '141000', '043400', 'Q', '3');
INSERT INTO `system_address` VALUES ('336', '翼城县', '141022', '141000', '043500', 'Y', '3');
INSERT INTO `system_address` VALUES ('337', '襄汾县', '141023', '141000', '041500', 'X', '3');
INSERT INTO `system_address` VALUES ('338', '洪洞县', '141024', '141000', '031600', 'H', '3');
INSERT INTO `system_address` VALUES ('339', '古县', '141025', '141000', '042400', 'G', '3');
INSERT INTO `system_address` VALUES ('340', '安泽县', '141026', '141000', '042500', 'A', '3');
INSERT INTO `system_address` VALUES ('341', '浮山县', '141027', '141000', '041000', 'F', '3');
INSERT INTO `system_address` VALUES ('342', '吉县', '141028', '141000', '042200', 'J', '3');
INSERT INTO `system_address` VALUES ('343', '乡宁县', '141029', '141000', '042100', 'X', '3');
INSERT INTO `system_address` VALUES ('344', '大宁县', '141030', '141000', '042300', 'D', '3');
INSERT INTO `system_address` VALUES ('345', '隰县', '141031', '141000', '041300', 'X', '3');
INSERT INTO `system_address` VALUES ('346', '永和县', '141032', '141000', '041400', 'Y', '3');
INSERT INTO `system_address` VALUES ('347', '蒲县', '141033', '141000', '041200', 'P', '3');
INSERT INTO `system_address` VALUES ('348', '汾西县', '141034', '141000', '031500', 'F', '3');
INSERT INTO `system_address` VALUES ('349', '侯马市', '141081', '141000', '043000', 'H', '3');
INSERT INTO `system_address` VALUES ('350', '霍州市', '141082', '141000', '031400', 'H', '3');
INSERT INTO `system_address` VALUES ('351', '吕梁市', '141100', '140000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('352', '离石区', '141102', '141100', '033000', 'L', '3');
INSERT INTO `system_address` VALUES ('353', '文水县', '141121', '141100', '032100', 'W', '3');
INSERT INTO `system_address` VALUES ('354', '交城县', '141122', '141100', '030500', 'J', '3');
INSERT INTO `system_address` VALUES ('355', '兴县', '141123', '141100', '033600', 'X', '3');
INSERT INTO `system_address` VALUES ('356', '临县', '141124', '141100', '033200', 'L', '3');
INSERT INTO `system_address` VALUES ('357', '柳林县', '141125', '141100', '033300', 'L', '3');
INSERT INTO `system_address` VALUES ('358', '石楼县', '141126', '141100', '032500', 'S', '3');
INSERT INTO `system_address` VALUES ('359', '岚县', '141127', '141100', '035200', 'L', '3');
INSERT INTO `system_address` VALUES ('360', '方山县', '141128', '141100', '033100', 'F', '3');
INSERT INTO `system_address` VALUES ('361', '中阳县', '141129', '141100', '033400', 'Z', '3');
INSERT INTO `system_address` VALUES ('362', '交口县', '141130', '141100', '032400', 'J', '3');
INSERT INTO `system_address` VALUES ('363', '孝义市', '141181', '141100', '032300', 'X', '3');
INSERT INTO `system_address` VALUES ('364', '汾阳市', '141182', '141100', '032200', 'F', '3');
INSERT INTO `system_address` VALUES ('365', '内蒙古', '150000', '0', null, 'N', '1');
INSERT INTO `system_address` VALUES ('366', '呼和浩特市', '150100', '150000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('367', '新城区', '150102', '150100', '010000', 'X', '3');
INSERT INTO `system_address` VALUES ('368', '回民区', '150103', '150100', '010000', 'H', '3');
INSERT INTO `system_address` VALUES ('369', '玉泉区', '150104', '150100', '010000', 'Y', '3');
INSERT INTO `system_address` VALUES ('370', '赛罕区', '150105', '150100', '010000', 'S', '3');
INSERT INTO `system_address` VALUES ('371', '土默特左旗', '150121', '150100', '010100', 'T', '3');
INSERT INTO `system_address` VALUES ('372', '托克托县', '150122', '150100', '010200', 'T', '3');
INSERT INTO `system_address` VALUES ('373', '和林格尔县', '150123', '150100', '011500', 'H', '3');
INSERT INTO `system_address` VALUES ('374', '清水河县', '150124', '150100', '011600', 'Q', '3');
INSERT INTO `system_address` VALUES ('375', '武川县', '150125', '150100', '011700', 'W', '3');
INSERT INTO `system_address` VALUES ('376', '包头市', '150200', '150000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('377', '东河区', '150202', '150200', '014000', 'D', '3');
INSERT INTO `system_address` VALUES ('378', '昆都仑区', '150203', '150200', '014010', 'K', '3');
INSERT INTO `system_address` VALUES ('379', '青山区', '150204', '150200', '014000', 'Q', '3');
INSERT INTO `system_address` VALUES ('380', '石拐区', '150205', '150200', '014070', 'S', '3');
INSERT INTO `system_address` VALUES ('381', '白云鄂博矿区', '150206', '150200', '014080', 'B', '3');
INSERT INTO `system_address` VALUES ('382', '九原区', '150207', '150200', '014060', 'J', '3');
INSERT INTO `system_address` VALUES ('383', '土默特右旗', '150221', '150200', '014100', 'T', '3');
INSERT INTO `system_address` VALUES ('384', '固阳县', '150222', '150200', '014200', 'G', '3');
INSERT INTO `system_address` VALUES ('385', '达尔罕茂明安联合旗', '150223', '150200', '014500', 'D', '3');
INSERT INTO `system_address` VALUES ('386', '乌海市', '150300', '150000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('387', '海勃湾区', '150302', '150300', '016000', 'H', '3');
INSERT INTO `system_address` VALUES ('388', '海南区', '150303', '150300', '016000', 'H', '3');
INSERT INTO `system_address` VALUES ('389', '乌达区', '150304', '150300', '016000', 'W', '3');
INSERT INTO `system_address` VALUES ('390', '赤峰市', '150400', '150000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('391', '红山区', '150402', '150400', '024000', 'H', '3');
INSERT INTO `system_address` VALUES ('392', '元宝山区', '150403', '150400', '024000', 'Y', '3');
INSERT INTO `system_address` VALUES ('393', '松山区', '150404', '150400', '024000', 'S', '3');
INSERT INTO `system_address` VALUES ('394', '阿鲁科尔沁旗', '150421', '150400', '025550', 'A', '3');
INSERT INTO `system_address` VALUES ('395', '巴林左旗', '150422', '150400', '025450', 'B', '3');
INSERT INTO `system_address` VALUES ('396', '巴林右旗', '150423', '150400', '025150', 'B', '3');
INSERT INTO `system_address` VALUES ('397', '林西县', '150424', '150400', '025250', 'L', '3');
INSERT INTO `system_address` VALUES ('398', '克什克腾旗', '150425', '150400', '025350', 'K', '3');
INSERT INTO `system_address` VALUES ('399', '翁牛特旗', '150426', '150400', '024500', 'W', '3');
INSERT INTO `system_address` VALUES ('400', '喀喇沁旗', '150428', '150400', '024400', 'K', '3');
INSERT INTO `system_address` VALUES ('401', '宁城县', '150429', '150400', '024200', 'N', '3');
INSERT INTO `system_address` VALUES ('402', '敖汉旗', '150430', '150400', '024300', 'A', '3');
INSERT INTO `system_address` VALUES ('403', '通辽市', '150500', '150000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('404', '科尔沁区', '150502', '150500', '028000', 'K', '3');
INSERT INTO `system_address` VALUES ('405', '科尔沁左翼中旗', '150521', '150500', '029300', 'K', '3');
INSERT INTO `system_address` VALUES ('406', '科尔沁左翼后旗', '150522', '150500', '028100', 'K', '3');
INSERT INTO `system_address` VALUES ('407', '开鲁县', '150523', '150500', '028400', 'K', '3');
INSERT INTO `system_address` VALUES ('408', '库伦旗', '150524', '150500', '028200', 'K', '3');
INSERT INTO `system_address` VALUES ('409', '奈曼旗', '150525', '150500', '028300', 'N', '3');
INSERT INTO `system_address` VALUES ('410', '扎鲁特旗', '150526', '150500', '029100', 'Z', '3');
INSERT INTO `system_address` VALUES ('411', '霍林郭勒市', '150581', '150500', '029200', 'H', '3');
INSERT INTO `system_address` VALUES ('412', '鄂尔多斯市', '150600', '150000', null, 'E', '2');
INSERT INTO `system_address` VALUES ('413', '东胜区', '150602', '150600', '017000', 'D', '3');
INSERT INTO `system_address` VALUES ('414', '达拉特旗', '150621', '150600', '014300', 'D', '3');
INSERT INTO `system_address` VALUES ('415', '准格尔旗', '150622', '150600', '017100', 'Z', '3');
INSERT INTO `system_address` VALUES ('416', '鄂托克前旗', '150623', '150600', '016200	', 'E', '3');
INSERT INTO `system_address` VALUES ('417', '鄂托克旗', '150624', '150600', '016100', 'E', '3');
INSERT INTO `system_address` VALUES ('418', '杭锦旗', '150625', '150600', '017400', 'H', '3');
INSERT INTO `system_address` VALUES ('419', '乌审旗', '150626', '150600', '017300', 'W', '3');
INSERT INTO `system_address` VALUES ('420', '伊金霍洛旗', '150627', '150600', '017200', 'Y', '3');
INSERT INTO `system_address` VALUES ('421', '呼伦贝尔市', '150700', '150000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('422', '海拉尔区', '150702', '150700', '021000', 'H', '3');
INSERT INTO `system_address` VALUES ('423', '扎赉诺尔区', '150703', '150700', '162750', 'Z', '3');
INSERT INTO `system_address` VALUES ('424', '阿荣旗', '150721', '150700', '162750	', 'A', '3');
INSERT INTO `system_address` VALUES ('425', '莫力达瓦达斡尔族自治旗', '150722', '150700', '162850', 'M', '3');
INSERT INTO `system_address` VALUES ('426', '鄂伦春自治旗', '150723', '150700', '022450', 'E', '3');
INSERT INTO `system_address` VALUES ('427', '鄂温克族自治旗', '150724', '150700', '021100', 'E', '3');
INSERT INTO `system_address` VALUES ('428', '陈巴尔虎旗', '150725', '150700', '021500', 'C', '3');
INSERT INTO `system_address` VALUES ('429', '新巴尔虎左旗', '150726', '150700', '021200', 'X', '3');
INSERT INTO `system_address` VALUES ('430', '新巴尔虎右旗', '150727', '150700', '021300', 'X', '3');
INSERT INTO `system_address` VALUES ('431', '满洲里市', '150781', '150700', '021400', 'M', '3');
INSERT INTO `system_address` VALUES ('432', '牙克石市', '150782', '150700', '022150', 'Y', '3');
INSERT INTO `system_address` VALUES ('433', '扎兰屯市', '150783', '150700', '162650', 'Z', '3');
INSERT INTO `system_address` VALUES ('434', '额尔古纳市', '150784', '150700', '022250', 'E', '3');
INSERT INTO `system_address` VALUES ('435', '根河市', '150785', '150700', '022350', 'G', '3');
INSERT INTO `system_address` VALUES ('436', '巴彦淖尔市', '150800', '150000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('437', '临河区', '150802', '150800', '015000', 'L', '3');
INSERT INTO `system_address` VALUES ('438', '五原县', '150821', '150800', '015100', 'W', '3');
INSERT INTO `system_address` VALUES ('439', '磴口县', '150822', '150800', '015200', 'D', '3');
INSERT INTO `system_address` VALUES ('440', '乌拉特前旗', '150823', '150800', '014400', 'W', '3');
INSERT INTO `system_address` VALUES ('441', '乌拉特中旗', '150824', '150800', '015300', 'W', '3');
INSERT INTO `system_address` VALUES ('442', '乌拉特后旗', '150825', '150800', '015500', 'W', '3');
INSERT INTO `system_address` VALUES ('443', '杭锦后旗', '150826', '150800', '015400', 'H', '3');
INSERT INTO `system_address` VALUES ('444', '乌兰察布市', '150900', '150000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('445', '集宁区', '150902', '150900', '012000', 'J', '3');
INSERT INTO `system_address` VALUES ('446', '卓资县', '150921', '150900', '012300', 'Z', '3');
INSERT INTO `system_address` VALUES ('447', '化德县', '150922', '150900', '013350', 'H', '3');
INSERT INTO `system_address` VALUES ('448', '商都县', '150923', '150900', '013400', 'S', '3');
INSERT INTO `system_address` VALUES ('449', '兴和县', '150924', '150900', '013650', 'X', '3');
INSERT INTO `system_address` VALUES ('450', '凉城县', '150925', '150900', '013750', 'L', '3');
INSERT INTO `system_address` VALUES ('451', '察哈尔右翼前旗', '150926', '150900', '012200', 'C', '3');
INSERT INTO `system_address` VALUES ('452', '察哈尔右翼中旗', '150927', '150900', '013500', 'C', '3');
INSERT INTO `system_address` VALUES ('453', '察哈尔右翼后旗', '150928', '150900', '012400', 'C', '3');
INSERT INTO `system_address` VALUES ('454', '四子王旗', '150929', '150900', '011800', 'S', '3');
INSERT INTO `system_address` VALUES ('455', '丰镇市', '150981', '150900', '012100', 'F', '3');
INSERT INTO `system_address` VALUES ('456', '兴安盟', '152200', '150000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('457', '乌兰浩特市', '152201', '152200', '137400', 'W', '3');
INSERT INTO `system_address` VALUES ('458', '阿尔山市', '152202', '152200', '137400', 'A', '3');
INSERT INTO `system_address` VALUES ('459', '科尔沁右翼前旗', '152221', '152200', '137400', 'K', '3');
INSERT INTO `system_address` VALUES ('460', '科尔沁右翼中旗', '152222', '152200', '137400', 'K', '3');
INSERT INTO `system_address` VALUES ('461', '扎赉特旗', '152223', '152200', '137600', 'Z', '3');
INSERT INTO `system_address` VALUES ('462', '突泉县', '152224', '152200', '137500', 'T', '3');
INSERT INTO `system_address` VALUES ('463', '锡林郭勒盟', '152500', '150000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('464', '二连浩特市', '152501', '152500', '012600', 'E', '3');
INSERT INTO `system_address` VALUES ('465', '锡林浩特市', '152502', '152500', '026000', 'X', '3');
INSERT INTO `system_address` VALUES ('466', '阿巴嘎旗', '152522', '152500', '011400', 'A', '3');
INSERT INTO `system_address` VALUES ('467', '苏尼特左旗', '152523', '152500', '011300', 'S', '3');
INSERT INTO `system_address` VALUES ('468', '苏尼特右旗', '152524', '152500', '011200', 'S', '3');
INSERT INTO `system_address` VALUES ('469', '东乌珠穆沁旗', '152525', '152500', '026300', 'D', '3');
INSERT INTO `system_address` VALUES ('470', '西乌珠穆沁旗', '152526', '152500', '026200', 'X', '3');
INSERT INTO `system_address` VALUES ('471', '太仆寺旗', '152527', '152500', '027000', 'T', '3');
INSERT INTO `system_address` VALUES ('472', '镶黄旗', '152528', '152500', '013250', 'X', '3');
INSERT INTO `system_address` VALUES ('473', '正镶白旗', '152529', '152500', '013800', 'Z', '3');
INSERT INTO `system_address` VALUES ('474', '正蓝旗', '152530', '152500', '027200', 'Z', '3');
INSERT INTO `system_address` VALUES ('475', '多伦县', '152531', '152500', '027300', 'D', '3');
INSERT INTO `system_address` VALUES ('476', '阿拉善盟', '152900', '150000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('477', '阿拉善左旗', '152921', '152900', '750300', 'A', '3');
INSERT INTO `system_address` VALUES ('478', '阿拉善右旗', '152922', '152900', '737300', 'A', '3');
INSERT INTO `system_address` VALUES ('479', '额济纳旗', '152923', '152900', '735400', 'E', '3');
INSERT INTO `system_address` VALUES ('480', '辽宁', '210000', '0', null, 'L', '1');
INSERT INTO `system_address` VALUES ('481', '沈阳市', '210100', '210000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('482', '和平区', '210102', '210100', '110000', 'H', '3');
INSERT INTO `system_address` VALUES ('483', '沈河区', '210103', '210100', '110000', 'S', '3');
INSERT INTO `system_address` VALUES ('484', '大东区', '210104', '210100', '110041', 'D', '3');
INSERT INTO `system_address` VALUES ('485', '皇姑区', '210105', '210100', '110000', 'H', '3');
INSERT INTO `system_address` VALUES ('486', '铁西区', '210106', '210100', '110020', 'T', '3');
INSERT INTO `system_address` VALUES ('487', '苏家屯区', '210111', '210100', '110100', 'S', '3');
INSERT INTO `system_address` VALUES ('488', '东陵区', '210112', '210100', '110000', 'D', '3');
INSERT INTO `system_address` VALUES ('489', '新城子区', '210113', '210100', '110000', 'X', '3');
INSERT INTO `system_address` VALUES ('490', '于洪区', '210114', '210100', '110000', 'Y', '3');
INSERT INTO `system_address` VALUES ('491', '辽中县', '210122', '210100', '110200', 'L', '3');
INSERT INTO `system_address` VALUES ('492', '康平县', '210123', '210100', '110500', 'K', '3');
INSERT INTO `system_address` VALUES ('493', '法库县', '210124', '210100', '110400', 'F', '3');
INSERT INTO `system_address` VALUES ('494', '新民市', '210181', '210100', '110300', 'X', '3');
INSERT INTO `system_address` VALUES ('495', '浑南区', '210182', '210100', '110000', 'H', '3');
INSERT INTO `system_address` VALUES ('496', '张士开发区', '210183', '210100', '110000', 'Z', '3');
INSERT INTO `system_address` VALUES ('497', '沈北新区', '210184', '210100', '110000', 'S', '3');
INSERT INTO `system_address` VALUES ('498', '大连市', '210200', '210000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('499', '中山区', '210202', '210200', '116000', 'Z', '3');
INSERT INTO `system_address` VALUES ('500', '西岗区', '210203', '210200', '116000', 'X', '3');
INSERT INTO `system_address` VALUES ('501', '沙河口区', '210204', '210200', '116000', 'S', '3');
INSERT INTO `system_address` VALUES ('502', '甘井子区', '210211', '210200', '116000', 'G', '3');
INSERT INTO `system_address` VALUES ('503', '旅顺口区', '210212', '210200', '116000', 'L', '3');
INSERT INTO `system_address` VALUES ('504', '金州区', '210213', '210200', '116000', 'J', '3');
INSERT INTO `system_address` VALUES ('505', '大连经济技术开发区', '210214', '210200', '116000', 'D', '3');
INSERT INTO `system_address` VALUES ('506', '长海县', '210224', '210200', '116500', 'Z', '3');
INSERT INTO `system_address` VALUES ('507', '开发区', '210251', '210200', '116000', 'K', '3');
INSERT INTO `system_address` VALUES ('508', '瓦房店市', '210281', '210200', '116300', 'W', '3');
INSERT INTO `system_address` VALUES ('509', '普兰店市', '210282', '210200', '116200', 'P', '3');
INSERT INTO `system_address` VALUES ('510', '庄河市', '210283', '210200', '116400', 'Z', '3');
INSERT INTO `system_address` VALUES ('511', '岭前区', '210297', '210200', '116000', 'L', '3');
INSERT INTO `system_address` VALUES ('512', '鞍山市', '210300', '210000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('513', '铁东区', '210302', '210300', '114000', 'T', '3');
INSERT INTO `system_address` VALUES ('514', '铁西区', '210303', '210300', '114000', 'T', '3');
INSERT INTO `system_address` VALUES ('515', '立山区', '210304', '210300', '114000', 'L', '3');
INSERT INTO `system_address` VALUES ('516', '千山区', '210311', '210300', '114000', 'Q', '3');
INSERT INTO `system_address` VALUES ('517', '台安县', '210321', '210300', '114100', 'T', '3');
INSERT INTO `system_address` VALUES ('518', '岫岩满族自治县', '210323', '210300', '114300', 'X', '3');
INSERT INTO `system_address` VALUES ('519', '高新区', '210351', '210300', '114000', 'G', '3');
INSERT INTO `system_address` VALUES ('520', '海城市', '210381', '210300', '114200', 'H', '3');
INSERT INTO `system_address` VALUES ('521', '抚顺市', '210400', '210000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('522', '新抚区', '210402', '210400', '113000', 'X', '3');
INSERT INTO `system_address` VALUES ('523', '东洲区', '210403', '210400', '113000', 'D', '3');
INSERT INTO `system_address` VALUES ('524', '望花区', '210404', '210400', '113000', 'W', '3');
INSERT INTO `system_address` VALUES ('525', '顺城区', '210411', '210400', '113000', 'S', '3');
INSERT INTO `system_address` VALUES ('526', '抚顺县', '210421', '210400', '113100', 'F', '3');
INSERT INTO `system_address` VALUES ('527', '新宾满族自治县', '210422', '210400', '113200', 'X', '3');
INSERT INTO `system_address` VALUES ('528', '清原满族自治县', '210423', '210400', '113300', 'Q', '3');
INSERT INTO `system_address` VALUES ('529', '本溪市', '210500', '210000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('530', '平山区', '210502', '210500', '117000', 'P', '3');
INSERT INTO `system_address` VALUES ('531', '溪湖区', '210503', '210500', '117000', 'X', '3');
INSERT INTO `system_address` VALUES ('532', '明山区', '210504', '210500', '117000', 'M', '3');
INSERT INTO `system_address` VALUES ('533', '南芬区', '210505', '210500', '117000', 'N', '3');
INSERT INTO `system_address` VALUES ('534', '本溪满族自治县', '210521', '210500', '117100', 'B', '3');
INSERT INTO `system_address` VALUES ('535', '桓仁满族自治县', '210522', '210500', '117200', 'H', '3');
INSERT INTO `system_address` VALUES ('536', '丹东市', '210600', '210000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('537', '元宝区', '210602', '210600', '118000', 'Y', '3');
INSERT INTO `system_address` VALUES ('538', '振兴区', '210603', '210600', '118000', 'Z', '3');
INSERT INTO `system_address` VALUES ('539', '振安区', '210604', '210600', '118000', 'Z', '3');
INSERT INTO `system_address` VALUES ('540', '宽甸满族自治县', '210624', '210600', '118200', 'K', '3');
INSERT INTO `system_address` VALUES ('541', '东港市', '210681', '210600', '118300', 'D', '3');
INSERT INTO `system_address` VALUES ('542', '凤城市', '210682', '210600', '118100', 'F', '3');
INSERT INTO `system_address` VALUES ('543', '锦州市', '210700', '210000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('544', '古塔区', '210702', '210700', '121000', 'G', '3');
INSERT INTO `system_address` VALUES ('545', '凌河区', '210703', '210700', '121000', 'L', '3');
INSERT INTO `system_address` VALUES ('546', '太和区', '210711', '210700', '121000', 'T', '3');
INSERT INTO `system_address` VALUES ('547', '黑山县', '210726', '210700', '121400', 'H', '3');
INSERT INTO `system_address` VALUES ('548', '义县', '210727', '210700', '121100', 'Y', '3');
INSERT INTO `system_address` VALUES ('549', '凌海市', '210781', '210700', '121200', 'L', '3');
INSERT INTO `system_address` VALUES ('550', '北镇市', '210782', '210700', '121300', 'B', '3');
INSERT INTO `system_address` VALUES ('551', '营口市', '210800', '210000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('552', '站前区', '210802', '210800', '115000', 'Z', '3');
INSERT INTO `system_address` VALUES ('553', '西市区', '210803', '210800', '115000', 'X', '3');
INSERT INTO `system_address` VALUES ('554', '鲅鱼圈区', '210804', '210800', '115000', 'B', '3');
INSERT INTO `system_address` VALUES ('555', '老边区', '210811', '210800', '115000', 'L', '3');
INSERT INTO `system_address` VALUES ('556', '盖州市', '210881', '210800', '115200', 'G', '3');
INSERT INTO `system_address` VALUES ('557', '大石桥市', '210882', '210800', '115100', 'D', '3');
INSERT INTO `system_address` VALUES ('558', '阜新市', '210900', '210000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('559', '海州区', '210902', '210900', '123000', 'H', '3');
INSERT INTO `system_address` VALUES ('560', '新邱区', '210903', '210900', '123000', 'X', '3');
INSERT INTO `system_address` VALUES ('561', '太平区', '210904', '210900', '123000', 'T', '3');
INSERT INTO `system_address` VALUES ('562', '清河门区', '210905', '210900', '123000', 'Q', '3');
INSERT INTO `system_address` VALUES ('563', '细河区', '210911', '210900', '123000', 'X', '3');
INSERT INTO `system_address` VALUES ('564', '阜新蒙古族自治县', '210921', '210900', '123100', 'F', '3');
INSERT INTO `system_address` VALUES ('565', '彰武县', '210922', '210900', '123200', 'Z', '3');
INSERT INTO `system_address` VALUES ('566', '辽阳市', '211000', '210000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('567', '白塔区', '211002', '211000', '111000', 'B', '3');
INSERT INTO `system_address` VALUES ('568', '文圣区', '211003', '211000', '111000', 'W', '3');
INSERT INTO `system_address` VALUES ('569', '宏伟区', '211004', '211000', '111000', 'H', '3');
INSERT INTO `system_address` VALUES ('570', '弓长岭区', '211005', '211000', '111000', 'G', '3');
INSERT INTO `system_address` VALUES ('571', '太子河区', '211011', '211000', '111000', 'T', '3');
INSERT INTO `system_address` VALUES ('572', '辽阳县', '211021', '211000', '111200', 'L', '3');
INSERT INTO `system_address` VALUES ('573', '灯塔市', '211081', '211000', '111300', 'D', '3');
INSERT INTO `system_address` VALUES ('574', '盘锦市', '211100', '210000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('575', '双台子区', '211102', '211100', '124000', 'S', '3');
INSERT INTO `system_address` VALUES ('576', '兴隆台区', '211103', '211100', '124000', 'X', '3');
INSERT INTO `system_address` VALUES ('577', '大洼县', '211121', '211100', '124200', 'D', '3');
INSERT INTO `system_address` VALUES ('578', '盘山县', '211122', '211100', '124100', 'P', '3');
INSERT INTO `system_address` VALUES ('579', '铁岭市', '211200', '210000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('580', '银州区', '211202', '211200', '112000', 'Y', '3');
INSERT INTO `system_address` VALUES ('581', '清河区', '211204', '211200', '112000', 'Q', '3');
INSERT INTO `system_address` VALUES ('582', '铁岭县', '211221', '211200', '112600', 'T', '3');
INSERT INTO `system_address` VALUES ('583', '西丰县', '211223', '211200', '112400', 'X', '3');
INSERT INTO `system_address` VALUES ('584', '昌图县', '211224', '211200', '112500', 'C', '3');
INSERT INTO `system_address` VALUES ('585', '调兵山市', '211281', '211200', '112700', 'D', '3');
INSERT INTO `system_address` VALUES ('586', '开原市', '211282', '211200', '112300', 'K', '3');
INSERT INTO `system_address` VALUES ('587', '朝阳市', '211300', '210000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('588', '双塔区', '211302', '211300', '122000', 'S', '3');
INSERT INTO `system_address` VALUES ('589', '龙城区', '211303', '211300', '122000', 'L', '3');
INSERT INTO `system_address` VALUES ('590', '朝阳县', '211321', '211300', '122000', 'C', '3');
INSERT INTO `system_address` VALUES ('591', '建平县', '211322', '211300', '122400', 'J', '3');
INSERT INTO `system_address` VALUES ('592', '喀喇沁左翼蒙古族自治县', '211324', '211300', '122300', 'K', '3');
INSERT INTO `system_address` VALUES ('593', '北票市', '211381', '211300', '122100', 'B', '3');
INSERT INTO `system_address` VALUES ('594', '凌源市', '211382', '211300', '122500', 'L', '3');
INSERT INTO `system_address` VALUES ('595', '葫芦岛市', '211400', '210000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('596', '连山区', '211402', '211400', '125000', 'L', '3');
INSERT INTO `system_address` VALUES ('597', '龙港区', '211403', '211400', '125000', 'L', '3');
INSERT INTO `system_address` VALUES ('598', '南票区', '211404', '211400', '125027', 'N', '3');
INSERT INTO `system_address` VALUES ('599', '绥中县', '211421', '211400', '125200', 'S', '3');
INSERT INTO `system_address` VALUES ('600', '建昌县', '211422', '211400', '125300', 'J', '3');
INSERT INTO `system_address` VALUES ('601', '兴城市', '211481', '211400', '125100', 'X', '3');
INSERT INTO `system_address` VALUES ('602', '吉林', '220000', '0', null, 'J', '1');
INSERT INTO `system_address` VALUES ('603', '长春市', '220100', '220000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('604', '南关区', '220102', '220100', '130000', 'N', '3');
INSERT INTO `system_address` VALUES ('605', '宽城区', '220103', '220100', '130000', 'K', '3');
INSERT INTO `system_address` VALUES ('606', '朝阳区', '220104', '220100', '130012', 'C', '3');
INSERT INTO `system_address` VALUES ('607', '二道区', '220105', '220100', '130000', 'E', '3');
INSERT INTO `system_address` VALUES ('608', '绿园区', '220106', '220100', '130000', 'L', '3');
INSERT INTO `system_address` VALUES ('609', '双阳区', '220112', '220100', '130600', 'S', '3');
INSERT INTO `system_address` VALUES ('610', '高新北区', '220117', '220100', '130000', 'G', '3');
INSERT INTO `system_address` VALUES ('611', '高新区', '220119', '220100', '130000', 'G', '3');
INSERT INTO `system_address` VALUES ('612', '农安县', '220122', '220100', '130200', 'N', '3');
INSERT INTO `system_address` VALUES ('613', '九台区', '220181', '220100', '130500', 'J', '3');
INSERT INTO `system_address` VALUES ('614', '榆树市', '220182', '220100', '130400', 'Y', '3');
INSERT INTO `system_address` VALUES ('615', '德惠市', '220183', '220100', '130300', 'D', '3');
INSERT INTO `system_address` VALUES ('616', '高新技术产业开发区', '220184', '220100', '130000', 'G', '3');
INSERT INTO `system_address` VALUES ('617', '汽车产业开发区', '220185', '220100', '130000', 'Q', '3');
INSERT INTO `system_address` VALUES ('618', '经济技术开发区', '220186', '220100', '130000', 'J', '3');
INSERT INTO `system_address` VALUES ('619', '净月旅游开发区', '220187', '220100', '130000', 'J', '3');
INSERT INTO `system_address` VALUES ('620', '吉林市', '220200', '220000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('621', '昌邑区', '220202', '220200', '132000', 'C', '3');
INSERT INTO `system_address` VALUES ('622', '龙潭区', '220203', '220200', '132000', 'L', '3');
INSERT INTO `system_address` VALUES ('623', '船营区', '220204', '220200', '132000', 'C', '3');
INSERT INTO `system_address` VALUES ('624', '丰满区', '220211', '220200', '132000', 'F', '3');
INSERT INTO `system_address` VALUES ('625', '永吉县', '220221', '220200', '132100', 'Y', '3');
INSERT INTO `system_address` VALUES ('626', '蛟河市', '220281', '220200', '132500', 'J', '3');
INSERT INTO `system_address` VALUES ('627', '桦甸市', '220282', '220200', '132400', 'H', '3');
INSERT INTO `system_address` VALUES ('628', '舒兰市', '220283', '220200', '132600', 'S', '3');
INSERT INTO `system_address` VALUES ('629', '磐石市', '220284', '220200', '132300', 'P', '3');
INSERT INTO `system_address` VALUES ('630', '四平市', '220300', '220000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('631', '铁西区', '220302', '220300', '136000', 'T', '3');
INSERT INTO `system_address` VALUES ('632', '铁东区', '220303', '220300', '136000', 'T', '3');
INSERT INTO `system_address` VALUES ('633', '梨树县', '220322', '220300', '136500', 'L', '3');
INSERT INTO `system_address` VALUES ('634', '伊通满族自治县', '220323', '220300', '130700', 'Y', '3');
INSERT INTO `system_address` VALUES ('635', '公主岭市', '220381', '220300', '136100', 'G', '3');
INSERT INTO `system_address` VALUES ('636', '双辽市', '220382', '220300', '136400', 'S', '3');
INSERT INTO `system_address` VALUES ('637', '辽源市', '220400', '220000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('638', '龙山区', '220402', '220400', '136200', 'L', '3');
INSERT INTO `system_address` VALUES ('639', '西安区', '220403', '220400', '136200', 'X', '3');
INSERT INTO `system_address` VALUES ('640', '东丰县', '220421', '220400', '136300', 'D', '3');
INSERT INTO `system_address` VALUES ('641', '东辽县', '220422', '220400', '136600', 'D', '3');
INSERT INTO `system_address` VALUES ('642', '通化市', '220500', '220000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('643', '东昌区', '220502', '220500', '134000', 'D', '3');
INSERT INTO `system_address` VALUES ('644', '二道江区', '220503', '220500', '134000', 'E', '3');
INSERT INTO `system_address` VALUES ('645', '通化县', '220521', '220500', '134100', 'T', '3');
INSERT INTO `system_address` VALUES ('646', '辉南县', '220523', '220500', '135100', 'H', '3');
INSERT INTO `system_address` VALUES ('647', '柳河县', '220524', '220500', '135300', 'L', '3');
INSERT INTO `system_address` VALUES ('648', '梅河口市', '220581', '220500', '135000', 'M', '3');
INSERT INTO `system_address` VALUES ('649', '集安市', '220582', '220500', '134200', 'J', '3');
INSERT INTO `system_address` VALUES ('650', '白山市', '220600', '220000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('651', '浑江区', '220602', '220600', '134300', 'H', '3');
INSERT INTO `system_address` VALUES ('652', '八道江区', '220603', '220600', '134300', 'B', '3');
INSERT INTO `system_address` VALUES ('653', '抚松县', '220621', '220600', '134500', 'F', '3');
INSERT INTO `system_address` VALUES ('654', '靖宇县', '220622', '220600', '135200', 'J', '3');
INSERT INTO `system_address` VALUES ('655', '长白朝鲜族自治县', '220623', '220600', '134400', 'Z', '3');
INSERT INTO `system_address` VALUES ('656', '江源区', '220625', '220600', '134700', 'J', '3');
INSERT INTO `system_address` VALUES ('657', '临江市', '220681', '220600', '134600', 'L', '3');
INSERT INTO `system_address` VALUES ('658', '松原市', '220700', '220000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('659', '宁江区', '220702', '220700', '138000', 'N', '3');
INSERT INTO `system_address` VALUES ('660', '前郭尔罗斯蒙古族自治县', '220721', '220700', '131100', 'Q', '3');
INSERT INTO `system_address` VALUES ('661', '长岭县', '220722', '220700', '131500', 'Z', '3');
INSERT INTO `system_address` VALUES ('662', '乾安县', '220723', '220700', '138000', 'Q', '3');
INSERT INTO `system_address` VALUES ('663', '扶余市', '220781', '220700', '131200', 'F', '3');
INSERT INTO `system_address` VALUES ('664', '白城市', '220800', '220000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('665', '洮北区', '220802', '220800', '137000', 'T', '3');
INSERT INTO `system_address` VALUES ('666', '镇赉县', '220821', '220800', '137300', 'Z', '3');
INSERT INTO `system_address` VALUES ('667', '通榆县', '220822', '220800', '137200', 'T', '3');
INSERT INTO `system_address` VALUES ('668', '洮南市', '220881', '220800', '137100', 'T', '3');
INSERT INTO `system_address` VALUES ('669', '大安市', '220882', '220800', '131300', 'D', '3');
INSERT INTO `system_address` VALUES ('670', '延边朝鲜族自治州', '222400', '220000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('671', '延吉市', '222401', '222400', '133000', 'Y', '3');
INSERT INTO `system_address` VALUES ('672', '图们市', '222402', '222400', '133100', 'T', '3');
INSERT INTO `system_address` VALUES ('673', '敦化市', '222403', '222400', '133700', 'D', '3');
INSERT INTO `system_address` VALUES ('674', '珲春市', '222404', '222400', '133300', 'H', '3');
INSERT INTO `system_address` VALUES ('675', '龙井市', '222405', '222400', '133400', 'L', '3');
INSERT INTO `system_address` VALUES ('676', '和龙市', '222406', '222400', '133500', 'H', '3');
INSERT INTO `system_address` VALUES ('677', '汪清县', '222424', '222400', '133200', 'W', '3');
INSERT INTO `system_address` VALUES ('678', '安图县', '222426', '222400', '133600', 'A', '3');
INSERT INTO `system_address` VALUES ('679', '黑龙江', '230000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('680', '哈尔滨市', '230100', '230000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('681', '道里区', '230102', '230100', '150000', 'D', '3');
INSERT INTO `system_address` VALUES ('682', '南岗区', '230103', '230100', '150000', 'N', '3');
INSERT INTO `system_address` VALUES ('683', '道外区', '230104', '230100', '150000', 'D', '3');
INSERT INTO `system_address` VALUES ('684', '香坊区', '230106', '230100', '150000', 'X', '3');
INSERT INTO `system_address` VALUES ('685', '动力区', '230107', '230100', '150040', 'D', '3');
INSERT INTO `system_address` VALUES ('686', '平房区', '230108', '230100', '150000', 'P', '3');
INSERT INTO `system_address` VALUES ('687', '松北区', '230109', '230100', '150000', 'S', '3');
INSERT INTO `system_address` VALUES ('688', '香坊区', '230110', '230100', '150036', 'X', '3');
INSERT INTO `system_address` VALUES ('689', '呼兰区', '230111', '230100', '150500', 'H', '3');
INSERT INTO `system_address` VALUES ('690', '依兰县', '230123', '230100', '154800', 'Y', '3');
INSERT INTO `system_address` VALUES ('691', '方正县', '230124', '230100', '150800', 'F', '3');
INSERT INTO `system_address` VALUES ('692', '宾县', '230125', '230100', '150400', 'B', '3');
INSERT INTO `system_address` VALUES ('693', '巴彦县', '230126', '230100', '151800', 'B', '3');
INSERT INTO `system_address` VALUES ('694', '木兰县', '230127', '230100', '151900', 'M', '3');
INSERT INTO `system_address` VALUES ('695', '通河县', '230128', '230100', '150900', 'T', '3');
INSERT INTO `system_address` VALUES ('696', '延寿县', '230129', '230100', '150700', 'Y', '3');
INSERT INTO `system_address` VALUES ('697', '阿城区', '230181', '230100', '150000', 'A', '3');
INSERT INTO `system_address` VALUES ('698', '双城区', '230182', '230100', '150100', 'S', '3');
INSERT INTO `system_address` VALUES ('699', '尚志市', '230183', '230100', '150600', 'S', '3');
INSERT INTO `system_address` VALUES ('700', '五常市', '230184', '230100', '150200', 'W', '3');
INSERT INTO `system_address` VALUES ('701', '阿城市', '230185', '230100', '150300', 'A', '3');
INSERT INTO `system_address` VALUES ('702', '齐齐哈尔市', '230200', '230000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('703', '龙沙区', '230202', '230200', '161000', 'L', '3');
INSERT INTO `system_address` VALUES ('704', '建华区', '230203', '230200', '161000', 'J', '3');
INSERT INTO `system_address` VALUES ('705', '铁锋区', '230204', '230200', '161000', 'T', '3');
INSERT INTO `system_address` VALUES ('706', '昂昂溪区', '230205', '230200', '161000', 'A', '3');
INSERT INTO `system_address` VALUES ('707', '富拉尔基区', '230206', '230200', '161000', 'F', '3');
INSERT INTO `system_address` VALUES ('708', '碾子山区', '230207', '230200', '161000', 'N', '3');
INSERT INTO `system_address` VALUES ('709', '梅里斯达斡尔族区', '230208', '230200', '161000', 'M', '3');
INSERT INTO `system_address` VALUES ('710', '龙江县', '230221', '230200', '161100', 'L', '3');
INSERT INTO `system_address` VALUES ('711', '依安县', '230223', '230200', '161500', 'Y', '3');
INSERT INTO `system_address` VALUES ('712', '泰来县', '230224', '230200', '162400', 'T', '3');
INSERT INTO `system_address` VALUES ('713', '甘南县', '230225', '230200', '162100', 'G', '3');
INSERT INTO `system_address` VALUES ('714', '富裕县', '230227', '230200', '161200', 'F', '3');
INSERT INTO `system_address` VALUES ('715', '克山县', '230229', '230200', '161600', 'K', '3');
INSERT INTO `system_address` VALUES ('716', '克东县', '230230', '230200', '164800', 'K', '3');
INSERT INTO `system_address` VALUES ('717', '拜泉县', '230231', '230200', '164700', 'B', '3');
INSERT INTO `system_address` VALUES ('718', '讷河市', '230281', '230200', '161300', 'N', '3');
INSERT INTO `system_address` VALUES ('719', '鸡西市', '230300', '230000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('720', '鸡冠区', '230302', '230300', '158100', 'J', '3');
INSERT INTO `system_address` VALUES ('721', '恒山区', '230303', '230300', '158100', 'H', '3');
INSERT INTO `system_address` VALUES ('722', '滴道区', '230304', '230300', '158100', 'D', '3');
INSERT INTO `system_address` VALUES ('723', '梨树区', '230305', '230300', '158100', 'L', '3');
INSERT INTO `system_address` VALUES ('724', '城子河区', '230306', '230300', '158100', 'C', '3');
INSERT INTO `system_address` VALUES ('725', '麻山区', '230307', '230300', '158100', 'M', '3');
INSERT INTO `system_address` VALUES ('726', '鸡东县', '230321', '230300', '158200', 'J', '3');
INSERT INTO `system_address` VALUES ('727', '虎林市', '230381', '230300', '158400', 'H', '3');
INSERT INTO `system_address` VALUES ('728', '密山市', '230382', '230300', '158300', 'M', '3');
INSERT INTO `system_address` VALUES ('729', '鹤岗市', '230400', '230000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('730', '向阳区', '230402', '230400', '154100', 'X', '3');
INSERT INTO `system_address` VALUES ('731', '工农区', '230403', '230400', '154100', 'G', '3');
INSERT INTO `system_address` VALUES ('732', '南山区', '230404', '230400', '154100', 'N', '3');
INSERT INTO `system_address` VALUES ('733', '兴安区', '230405', '230400', '154100', 'X', '3');
INSERT INTO `system_address` VALUES ('734', '东山区', '230406', '230400', '154100', 'D', '3');
INSERT INTO `system_address` VALUES ('735', '兴山区', '230407', '230400', '154100', 'X', '3');
INSERT INTO `system_address` VALUES ('736', '萝北县', '230421', '230400', '154200', 'L', '3');
INSERT INTO `system_address` VALUES ('737', '绥滨县', '230422', '230400', '156200', 'S', '3');
INSERT INTO `system_address` VALUES ('738', '双鸭山市', '230500', '230000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('739', '尖山区', '230502', '230500', '155100', 'J', '3');
INSERT INTO `system_address` VALUES ('740', '岭东区', '230503', '230500', '155100', 'L', '3');
INSERT INTO `system_address` VALUES ('741', '四方台区', '230505', '230500', '155100', 'S', '3');
INSERT INTO `system_address` VALUES ('742', '宝山区', '230506', '230500', '155100', 'B', '3');
INSERT INTO `system_address` VALUES ('743', '集贤县', '230521', '230500', '155900', 'J', '3');
INSERT INTO `system_address` VALUES ('744', '友谊县', '230522', '230500', '155800', 'Y', '3');
INSERT INTO `system_address` VALUES ('745', '宝清县', '230523', '230500', '155600', 'B', '3');
INSERT INTO `system_address` VALUES ('746', '饶河县', '230524', '230500', '155700', 'R', '3');
INSERT INTO `system_address` VALUES ('747', '大庆市', '230600', '230000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('748', '萨尔图区', '230602', '230600', '163000', 'S', '3');
INSERT INTO `system_address` VALUES ('749', '龙凤区', '230603', '230600', '163000', 'L', '3');
INSERT INTO `system_address` VALUES ('750', '让胡路区', '230604', '230600', '163000', 'R', '3');
INSERT INTO `system_address` VALUES ('751', '红岗区', '230605', '230600', '163000', 'H', '3');
INSERT INTO `system_address` VALUES ('752', '大同区', '230606', '230600', '163000', 'D', '3');
INSERT INTO `system_address` VALUES ('753', '肇州县', '230621', '230600', '166400', 'Z', '3');
INSERT INTO `system_address` VALUES ('754', '肇源县', '230622', '230600', '166500', 'Z', '3');
INSERT INTO `system_address` VALUES ('755', '林甸县', '230623', '230600', '166300	', 'L', '3');
INSERT INTO `system_address` VALUES ('756', '杜尔伯特蒙古族自治县', '230624', '230600', '166200', 'D', '3');
INSERT INTO `system_address` VALUES ('757', '伊春市', '230700', '230000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('758', '伊春区', '230702', '230700', '153000', 'Y', '3');
INSERT INTO `system_address` VALUES ('759', '南岔区', '230703', '230700', '153000', 'N', '3');
INSERT INTO `system_address` VALUES ('760', '友好区', '230704', '230700', '153000', 'Y', '3');
INSERT INTO `system_address` VALUES ('761', '西林区', '230705', '230700', '153000', 'X', '3');
INSERT INTO `system_address` VALUES ('762', '翠峦区', '230706', '230700', '153000', 'C', '3');
INSERT INTO `system_address` VALUES ('763', '新青区', '230707', '230700', '153036', 'X', '3');
INSERT INTO `system_address` VALUES ('764', '美溪区', '230708', '230700', '153000', 'M', '3');
INSERT INTO `system_address` VALUES ('765', '金山屯区', '230709', '230700', '153000', 'J', '3');
INSERT INTO `system_address` VALUES ('766', '五营区', '230710', '230700', '153000', 'W', '3');
INSERT INTO `system_address` VALUES ('767', '乌马河区', '230711', '230700', '153000', 'W', '3');
INSERT INTO `system_address` VALUES ('768', '汤旺河区', '230712', '230700', '153000', 'T', '3');
INSERT INTO `system_address` VALUES ('769', '带岭区', '230713', '230700', '153000', 'D', '3');
INSERT INTO `system_address` VALUES ('770', '乌伊岭区', '230714', '230700', '153000', 'W', '3');
INSERT INTO `system_address` VALUES ('771', '红星区', '230715', '230700', '153000', 'H', '3');
INSERT INTO `system_address` VALUES ('772', '上甘岭区', '230716', '230700', '153000', 'S', '3');
INSERT INTO `system_address` VALUES ('773', '嘉荫县', '230722', '230700', '153200', 'J', '3');
INSERT INTO `system_address` VALUES ('774', '铁力市', '230781', '230700', '152500', 'T', '3');
INSERT INTO `system_address` VALUES ('775', '佳木斯市', '230800', '230000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('776', '永红区', '230802', '230800', '154004', 'Y', '3');
INSERT INTO `system_address` VALUES ('777', '向阳区', '230803', '230800', '154000', 'X', '3');
INSERT INTO `system_address` VALUES ('778', '前进区', '230804', '230800', '154002', 'Q', '3');
INSERT INTO `system_address` VALUES ('779', '东风区', '230805', '230800', '154000', 'D', '3');
INSERT INTO `system_address` VALUES ('780', '郊区', '230811', '230800', '154000', 'J', '3');
INSERT INTO `system_address` VALUES ('781', '桦南县', '230822', '230800', '154400', 'H', '3');
INSERT INTO `system_address` VALUES ('782', '桦川县', '230826', '230800', '154300', 'H', '3');
INSERT INTO `system_address` VALUES ('783', '汤原县', '230828', '230800', '154700', 'T', '3');
INSERT INTO `system_address` VALUES ('784', '抚远县', '230833', '230800', '156500', 'F', '3');
INSERT INTO `system_address` VALUES ('785', '同江市', '230881', '230800', '156400', 'T', '3');
INSERT INTO `system_address` VALUES ('786', '富锦市', '230882', '230800', '156100', 'F', '3');
INSERT INTO `system_address` VALUES ('787', '七台河市', '230900', '230000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('788', '新兴区', '230902', '230900', '154600', 'X', '3');
INSERT INTO `system_address` VALUES ('789', '桃山区', '230903', '230900', '154600', 'T', '3');
INSERT INTO `system_address` VALUES ('790', '茄子河区', '230904', '230900', '154600', 'Q', '3');
INSERT INTO `system_address` VALUES ('791', '勃利县', '230921', '230900', '154500', 'B', '3');
INSERT INTO `system_address` VALUES ('792', '牡丹江市', '231000', '230000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('793', '东安区', '231002', '231000', '157000', 'D', '3');
INSERT INTO `system_address` VALUES ('794', '阳明区', '231003', '231000', '157000', 'Y', '3');
INSERT INTO `system_address` VALUES ('795', '爱民区', '231004', '231000', '157000', 'A', '3');
INSERT INTO `system_address` VALUES ('796', '西安区', '231005', '231000', '157000', 'X', '3');
INSERT INTO `system_address` VALUES ('797', '东宁县', '231024', '231000', '157200', 'D', '3');
INSERT INTO `system_address` VALUES ('798', '林口县', '231025', '231000', '157600', 'L', '3');
INSERT INTO `system_address` VALUES ('799', '绥芬河市', '231081', '231000', '157300', 'S', '3');
INSERT INTO `system_address` VALUES ('800', '海林市', '231083', '231000', '157100', 'H', '3');
INSERT INTO `system_address` VALUES ('801', '宁安市', '231084', '231000', '157400', 'N', '3');
INSERT INTO `system_address` VALUES ('802', '穆棱市', '231085', '231000', '157500', 'M', '3');
INSERT INTO `system_address` VALUES ('803', '黑河市', '231100', '230000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('804', '爱辉区', '231102', '231100', '164300', 'A', '3');
INSERT INTO `system_address` VALUES ('805', '嫩江县', '231121', '231100', '161400', 'N', '3');
INSERT INTO `system_address` VALUES ('806', '逊克县', '231123', '231100', '164400', 'X', '3');
INSERT INTO `system_address` VALUES ('807', '孙吴县', '231124', '231100', '164200', 'S', '3');
INSERT INTO `system_address` VALUES ('808', '北安市', '231181', '231100', '161400', 'B', '3');
INSERT INTO `system_address` VALUES ('809', '五大连池市', '231182', '231100', '164100', 'W', '3');
INSERT INTO `system_address` VALUES ('810', '绥化市', '231200', '230000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('811', '北林区', '231202', '231200', '152000', 'B', '3');
INSERT INTO `system_address` VALUES ('812', '望奎县', '231221', '231200', '152100', 'W', '3');
INSERT INTO `system_address` VALUES ('813', '兰西县', '231222', '231200', '151500', 'L', '3');
INSERT INTO `system_address` VALUES ('814', '青冈县', '231223', '231200', '151600', 'Q', '3');
INSERT INTO `system_address` VALUES ('815', '庆安县', '231224', '231200', '152400', 'Q', '3');
INSERT INTO `system_address` VALUES ('816', '明水县', '231225', '231200', '151700', 'M', '3');
INSERT INTO `system_address` VALUES ('817', '绥棱县', '231226', '231200', '152200', 'S', '3');
INSERT INTO `system_address` VALUES ('818', '安达市', '231281', '231200', '151400', 'A', '3');
INSERT INTO `system_address` VALUES ('819', '肇东市', '231282', '231200', '151100', 'Z', '3');
INSERT INTO `system_address` VALUES ('820', '海伦市', '231283', '231200', '152300', 'H', '3');
INSERT INTO `system_address` VALUES ('821', '大兴安岭地区', '232700', '230000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('822', '松岭区', '232702', '232700', '165010', 'S', '3');
INSERT INTO `system_address` VALUES ('823', '新林区', '232703', '232700', '165000', 'X', '3');
INSERT INTO `system_address` VALUES ('824', '呼中区', '232704', '232700', '165036', 'H', '3');
INSERT INTO `system_address` VALUES ('825', '呼玛县', '232721', '232700', '165100', 'H', '3');
INSERT INTO `system_address` VALUES ('826', '塔河县', '232722', '232700', '165200', 'T', '3');
INSERT INTO `system_address` VALUES ('827', '漠河县', '232723', '232700', '165300', 'M', '3');
INSERT INTO `system_address` VALUES ('828', '加格达奇区', '232724', '232700', '165000', 'J', '3');
INSERT INTO `system_address` VALUES ('829', '上海', '310000', '0', null, 'S', '1');
INSERT INTO `system_address` VALUES ('830', '市辖区', '310100', '310000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('831', '黄浦区', '310101', '310100', '200001', 'H', '3');
INSERT INTO `system_address` VALUES ('832', '卢湾区', '310103', '310100', '200020', 'L', '3');
INSERT INTO `system_address` VALUES ('833', '徐汇区', '310104', '310100', '200030', 'X', '3');
INSERT INTO `system_address` VALUES ('834', '长宁区', '310105', '310100', '200050', 'Z', '3');
INSERT INTO `system_address` VALUES ('835', '静安区', '310106', '310100', '200040', 'J', '3');
INSERT INTO `system_address` VALUES ('836', '普陀区', '310107', '310100', '200333', 'P', '3');
INSERT INTO `system_address` VALUES ('837', '闸北区', '310108', '310100', '200070', 'Z', '3');
INSERT INTO `system_address` VALUES ('838', '虹口区', '310109', '310100', '200080', 'H', '3');
INSERT INTO `system_address` VALUES ('839', '杨浦区', '310110', '310100', '200082', 'Y', '3');
INSERT INTO `system_address` VALUES ('840', '闵行区', '310112', '310100', '201100', 'M', '3');
INSERT INTO `system_address` VALUES ('841', '宝山区', '310113', '310100', '201900', 'B', '3');
INSERT INTO `system_address` VALUES ('842', '嘉定区', '310114', '310100', '201800', 'J', '3');
INSERT INTO `system_address` VALUES ('843', '浦东新区', '310115', '310100', '200120', 'P', '3');
INSERT INTO `system_address` VALUES ('844', '金山区', '310116', '310100', '200540', 'J', '3');
INSERT INTO `system_address` VALUES ('845', '松江区', '310117', '310100', '201600', 'S', '3');
INSERT INTO `system_address` VALUES ('846', '青浦区', '310118', '310100', '201700', 'Q', '3');
INSERT INTO `system_address` VALUES ('847', '南汇区', '310119', '310100', '201300', 'N', '3');
INSERT INTO `system_address` VALUES ('848', '奉贤区', '310120', '310100', '201499', 'F', '3');
INSERT INTO `system_address` VALUES ('849', '川沙区', '310152', '310100', '200000', 'C', '3');
INSERT INTO `system_address` VALUES ('850', '崇明县', '310230', '310100', '202150', 'C', '3');
INSERT INTO `system_address` VALUES ('851', '江苏', '320000', '0', null, 'J', '1');
INSERT INTO `system_address` VALUES ('852', '南京市', '320100', '320000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('853', '玄武区', '320102', '320100', '210000', 'X', '3');
INSERT INTO `system_address` VALUES ('854', '白下区', '320103', '320100', '210000', 'B', '3');
INSERT INTO `system_address` VALUES ('855', '秦淮区', '320104', '320100', '210000', 'Q', '3');
INSERT INTO `system_address` VALUES ('856', '建邺区', '320105', '320100', '210000', 'J', '3');
INSERT INTO `system_address` VALUES ('857', '鼓楼区', '320106', '320100', '210000', 'G', '3');
INSERT INTO `system_address` VALUES ('858', '下关区', '320107', '320100', '210000', 'X', '3');
INSERT INTO `system_address` VALUES ('859', '浦口区', '320111', '320100', '210000', 'P', '3');
INSERT INTO `system_address` VALUES ('860', '栖霞区', '320113', '320100', '210000', 'Q', '3');
INSERT INTO `system_address` VALUES ('861', '雨花台区', '320114', '320100', '210000', 'Y', '3');
INSERT INTO `system_address` VALUES ('862', '江宁区', '320115', '320100', '211100', 'J', '3');
INSERT INTO `system_address` VALUES ('863', '六合区', '320116', '320100', '211500', 'L', '3');
INSERT INTO `system_address` VALUES ('864', '溧水区', '320124', '320100', '211200', 'L', '3');
INSERT INTO `system_address` VALUES ('865', '高淳区', '320125', '320100', '211300', 'G', '3');
INSERT INTO `system_address` VALUES ('866', '无锡市', '320200', '320000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('867', '崇安区', '320202', '320200', '214000', 'C', '3');
INSERT INTO `system_address` VALUES ('868', '南长区', '320203', '320200', '214000', 'N', '3');
INSERT INTO `system_address` VALUES ('869', '北塘区', '320204', '320200', '214000', 'B', '3');
INSERT INTO `system_address` VALUES ('870', '锡山区', '320205', '320200', '214000', 'X', '3');
INSERT INTO `system_address` VALUES ('871', '惠山区', '320206', '320200', '214100', 'H', '3');
INSERT INTO `system_address` VALUES ('872', '滨湖区', '320211', '320200', '214100', 'B', '3');
INSERT INTO `system_address` VALUES ('873', '梁溪区', '320213', '320200', '214000', 'L', '3');
INSERT INTO `system_address` VALUES ('874', '新吴区', '320214', '320200', '214028', 'X', '3');
INSERT INTO `system_address` VALUES ('875', '江阴市', '320281', '320200', '214400', 'J', '3');
INSERT INTO `system_address` VALUES ('876', '宜兴市', '320282', '320200', '214200', 'Y', '3');
INSERT INTO `system_address` VALUES ('877', '新区', '320296', '320200', '214000', 'X', '3');
INSERT INTO `system_address` VALUES ('878', '徐州市', '320300', '320000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('879', '鼓楼区', '320302', '320300', '221000', 'G', '3');
INSERT INTO `system_address` VALUES ('880', '云龙区', '320303', '320300', '221000', 'Y', '3');
INSERT INTO `system_address` VALUES ('881', '九里区', '320304', '320300', '221140', 'J', '3');
INSERT INTO `system_address` VALUES ('882', '贾汪区', '320305', '320300', '221000', 'J', '3');
INSERT INTO `system_address` VALUES ('883', '泉山区', '320311', '320300', '221000', 'Q', '3');
INSERT INTO `system_address` VALUES ('884', '丰县', '320321', '320300', '221700', 'F', '3');
INSERT INTO `system_address` VALUES ('885', '沛县', '320322', '320300', '221600', 'P', '3');
INSERT INTO `system_address` VALUES ('886', '铜山区', '320323', '320300', '221100', 'T', '3');
INSERT INTO `system_address` VALUES ('887', '睢宁县', '320324', '320300', '221200', 'S', '3');
INSERT INTO `system_address` VALUES ('888', '新沂市', '320381', '320300', '221400', 'X', '3');
INSERT INTO `system_address` VALUES ('889', '邳州市', '320382', '320300', '221300', 'P', '3');
INSERT INTO `system_address` VALUES ('890', '常州市', '320400', '320000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('891', '天宁区', '320402', '320400', '213000', 'T', '3');
INSERT INTO `system_address` VALUES ('892', '钟楼区', '320404', '320400', '213000', 'Z', '3');
INSERT INTO `system_address` VALUES ('893', '戚墅堰区', '320405', '320400', '213000', 'Q', '3');
INSERT INTO `system_address` VALUES ('894', '新北区', '320411', '320400', '213001', 'X', '3');
INSERT INTO `system_address` VALUES ('895', '武进区', '320412', '320400', '213100', 'W', '3');
INSERT INTO `system_address` VALUES ('896', '溧阳市', '320481', '320400', '213300', 'L', '3');
INSERT INTO `system_address` VALUES ('897', '金坛区', '320482', '320400', '213200', 'J', '3');
INSERT INTO `system_address` VALUES ('898', '苏州市', '320500', '320000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('899', '沧浪区', '320502', '320500', '215000', 'C', '3');
INSERT INTO `system_address` VALUES ('900', '平江区', '320503', '320500', '215000', 'P', '3');
INSERT INTO `system_address` VALUES ('901', '金阊区', '320504', '320500', '215000', 'J', '3');
INSERT INTO `system_address` VALUES ('902', '虎丘区', '320505', '320500', '215004', 'H', '3');
INSERT INTO `system_address` VALUES ('903', '吴中区', '320506', '320500', '215100', 'W', '3');
INSERT INTO `system_address` VALUES ('904', '相城区', '320507', '320500', '215100', 'X', '3');
INSERT INTO `system_address` VALUES ('905', '姑苏区', '320508', '320500', '215008', 'G', '3');
INSERT INTO `system_address` VALUES ('906', '新区', '320510', '320500', '215000', 'X', '3');
INSERT INTO `system_address` VALUES ('907', '常熟市', '320581', '320500', '215500', 'C', '3');
INSERT INTO `system_address` VALUES ('908', '张家港市', '320582', '320500', '215600', 'Z', '3');
INSERT INTO `system_address` VALUES ('909', '昆山市', '320583', '320500', '215300', 'K', '3');
INSERT INTO `system_address` VALUES ('910', '吴江区', '320584', '320500', '215200', 'W', '3');
INSERT INTO `system_address` VALUES ('911', '太仓市', '320585', '320500', '215400', 'T', '3');
INSERT INTO `system_address` VALUES ('912', '园区', '320595', '320500', '215000', 'Y', '3');
INSERT INTO `system_address` VALUES ('913', '南通市', '320600', '320000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('914', '崇川区', '320602', '320600', '226000', 'C', '3');
INSERT INTO `system_address` VALUES ('915', '港闸区', '320611', '320600', '226000', 'G', '3');
INSERT INTO `system_address` VALUES ('916', '通州区', '320612', '320600', '226000', 'T', '3');
INSERT INTO `system_address` VALUES ('917', '开发区', '320613', '320600', '226000', 'K', '3');
INSERT INTO `system_address` VALUES ('918', '海安县', '320621', '320600', '226600', 'H', '3');
INSERT INTO `system_address` VALUES ('919', '如东县', '320623', '320600', '226400', 'R', '3');
INSERT INTO `system_address` VALUES ('920', '启东市', '320681', '320600', '226200', 'Q', '3');
INSERT INTO `system_address` VALUES ('921', '如皋市', '320682', '320600', '226500', 'R', '3');
INSERT INTO `system_address` VALUES ('922', '通州市', '320683', '320600', '226300', 'T', '3');
INSERT INTO `system_address` VALUES ('923', '海门市', '320684', '320600', '226100', 'H', '3');
INSERT INTO `system_address` VALUES ('924', '开发区', '320693', '320600', '226000', 'K', '3');
INSERT INTO `system_address` VALUES ('925', '连云港市', '320700', '320000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('926', '连云区', '320703', '320700', '222000', 'L', '3');
INSERT INTO `system_address` VALUES ('927', '新浦区', '320705', '320700', '222000', 'X', '3');
INSERT INTO `system_address` VALUES ('928', '海州区', '320706', '320700', '222000', 'H', '3');
INSERT INTO `system_address` VALUES ('929', '赣榆区', '320721', '320700', '222100', 'G', '3');
INSERT INTO `system_address` VALUES ('930', '东海县', '320722', '320700', '222300', 'D', '3');
INSERT INTO `system_address` VALUES ('931', '灌云县', '320723', '320700', '222200', 'G', '3');
INSERT INTO `system_address` VALUES ('932', '灌南县', '320724', '320700', '223500', 'G', '3');
INSERT INTO `system_address` VALUES ('933', '淮安市', '320800', '320000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('934', '清河区', '320802', '320800', '223001', 'Q', '3');
INSERT INTO `system_address` VALUES ('935', '淮安区', '320803', '320800', '223200', 'H', '3');
INSERT INTO `system_address` VALUES ('936', '淮阴区', '320804', '320800', '223300', 'H', '3');
INSERT INTO `system_address` VALUES ('937', '开发区', '320809', '320800', '223001', 'K', '3');
INSERT INTO `system_address` VALUES ('938', '清浦区', '320811', '320800', '223001', 'Q', '3');
INSERT INTO `system_address` VALUES ('939', '涟水县', '320826', '320800', '223400', 'L', '3');
INSERT INTO `system_address` VALUES ('940', '洪泽县', '320829', '320800', '223100', 'H', '3');
INSERT INTO `system_address` VALUES ('941', '盱眙县', '320830', '320800', '211700', 'X', '3');
INSERT INTO `system_address` VALUES ('942', '金湖县', '320831', '320800', '211600', 'J', '3');
INSERT INTO `system_address` VALUES ('943', '盐城市', '320900', '320000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('944', '亭湖区', '320902', '320900', '224000', 'T', '3');
INSERT INTO `system_address` VALUES ('945', '盐都区', '320903', '320900', '224000', 'Y', '3');
INSERT INTO `system_address` VALUES ('946', '响水县', '320921', '320900', '224600', 'X', '3');
INSERT INTO `system_address` VALUES ('947', '滨海县', '320922', '320900', '224500', 'B', '3');
INSERT INTO `system_address` VALUES ('948', '阜宁县', '320923', '320900', '224400', 'F', '3');
INSERT INTO `system_address` VALUES ('949', '射阳县', '320924', '320900', '224300', 'S', '3');
INSERT INTO `system_address` VALUES ('950', '建湖县', '320925', '320900', '224700', 'J', '3');
INSERT INTO `system_address` VALUES ('951', '东台市', '320981', '320900', '224200', 'D', '3');
INSERT INTO `system_address` VALUES ('952', '大丰市', '320982', '320900', '224100', 'D', '3');
INSERT INTO `system_address` VALUES ('953', '扬州市', '321000', '320000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('954', '广陵区', '321002', '321000', '225000', 'G', '3');
INSERT INTO `system_address` VALUES ('955', '邗江区', '321003', '321000', '225100', 'H', '3');
INSERT INTO `system_address` VALUES ('956', '维扬区', '321011', '321000', '225000', 'W', '3');
INSERT INTO `system_address` VALUES ('957', '宝应县', '321023', '321000', '225800', 'B', '3');
INSERT INTO `system_address` VALUES ('958', '仪征市', '321081', '321000', '211400', 'Y', '3');
INSERT INTO `system_address` VALUES ('959', '高邮市', '321084', '321000', '225600', 'G', '3');
INSERT INTO `system_address` VALUES ('960', '江都区', '321088', '321000', '225200', 'J', '3');
INSERT INTO `system_address` VALUES ('961', '经济开发区', '321092', '321000', '225000', 'J', '3');
INSERT INTO `system_address` VALUES ('962', '镇江市', '321100', '320000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('963', '京口区', '321102', '321100', '212000', 'J', '3');
INSERT INTO `system_address` VALUES ('964', '润州区', '321111', '321100', '212000', 'R', '3');
INSERT INTO `system_address` VALUES ('965', '丹徒区', '321112', '321100', '212100', 'D', '3');
INSERT INTO `system_address` VALUES ('966', '丹阳市', '321181', '321100', '212300', 'D', '3');
INSERT INTO `system_address` VALUES ('967', '扬中市', '321182', '321100', '212200', 'Y', '3');
INSERT INTO `system_address` VALUES ('968', '句容市', '321183', '321100', '212400', 'J', '3');
INSERT INTO `system_address` VALUES ('969', '泰州市', '321200', '320000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('970', '海陵区', '321202', '321200', '225300', 'H', '3');
INSERT INTO `system_address` VALUES ('971', '高港区', '321203', '321200', '225300', 'G', '3');
INSERT INTO `system_address` VALUES ('972', '兴化市', '321281', '321200', '225700', 'X', '3');
INSERT INTO `system_address` VALUES ('973', '靖江市', '321282', '321200', '214500', 'J', '3');
INSERT INTO `system_address` VALUES ('974', '泰兴市', '321283', '321200', '225400', 'T', '3');
INSERT INTO `system_address` VALUES ('975', '姜堰区', '321284', '321200', '225500', 'J', '3');
INSERT INTO `system_address` VALUES ('976', '宿迁市', '321300', '320000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('977', '宿城区', '321302', '321300', '223800', 'S', '3');
INSERT INTO `system_address` VALUES ('978', '宿豫区', '321311', '321300', '223800', 'S', '3');
INSERT INTO `system_address` VALUES ('979', '沭阳县', '321322', '321300', '223600', 'S', '3');
INSERT INTO `system_address` VALUES ('980', '泗阳县', '321323', '321300', '223700', 'S', '3');
INSERT INTO `system_address` VALUES ('981', '泗洪县', '321324', '321300', '223900', 'S', '3');
INSERT INTO `system_address` VALUES ('982', '浙江', '330000', '0', null, 'Z', '1');
INSERT INTO `system_address` VALUES ('983', '杭州市', '330100', '330000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('984', '上城区', '330102', '330100', '310000', 'S', '3');
INSERT INTO `system_address` VALUES ('985', '下城区', '330103', '330100', '310006', 'X', '3');
INSERT INTO `system_address` VALUES ('986', '江干区', '330104', '330100', '310000', 'J', '3');
INSERT INTO `system_address` VALUES ('987', '拱墅区', '330105', '330100', '310011', 'G', '3');
INSERT INTO `system_address` VALUES ('988', '西湖区', '330106', '330100', '310000', 'X', '3');
INSERT INTO `system_address` VALUES ('989', '滨江区', '330108', '330100', '310000', 'B', '3');
INSERT INTO `system_address` VALUES ('990', '萧山区', '330109', '330100', '311200', 'X', '3');
INSERT INTO `system_address` VALUES ('991', '余杭区', '330110', '330100', '311100', 'Y', '3');
INSERT INTO `system_address` VALUES ('992', '桐庐县', '330122', '330100', '311500', 'T', '3');
INSERT INTO `system_address` VALUES ('993', '淳安县', '330127', '330100', '311700', 'C', '3');
INSERT INTO `system_address` VALUES ('994', '建德市', '330182', '330100', '311600', 'J', '3');
INSERT INTO `system_address` VALUES ('995', '富阳区', '330183', '330100', '311400', 'F', '3');
INSERT INTO `system_address` VALUES ('996', '临安市', '330185', '330100', '311300', 'L', '3');
INSERT INTO `system_address` VALUES ('997', '宁波市', '330200', '330000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('998', '海曙区', '330203', '330200', '315000', 'H', '3');
INSERT INTO `system_address` VALUES ('999', '江东区', '330204', '330200', '315000', 'J', '3');
INSERT INTO `system_address` VALUES ('1000', '江北区', '330205', '330200', '315000', 'J', '3');
INSERT INTO `system_address` VALUES ('1001', '北仑区', '330206', '330200', '315800', 'B', '3');
INSERT INTO `system_address` VALUES ('1002', '镇海区', '330211', '330200', '315200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1003', '鄞州区', '330212', '330200', '315100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1004', '象山县', '330225', '330200', '315700', 'X', '3');
INSERT INTO `system_address` VALUES ('1005', '宁海县', '330226', '330200', '315600', 'N', '3');
INSERT INTO `system_address` VALUES ('1006', '余姚市', '330281', '330200', '315400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1007', '慈溪市', '330282', '330200', '315300', 'C', '3');
INSERT INTO `system_address` VALUES ('1008', '奉化市', '330283', '330200', '315500', 'F', '3');
INSERT INTO `system_address` VALUES ('1009', '高新区', '330299', '330200', '315000', 'G', '3');
INSERT INTO `system_address` VALUES ('1010', '温州市', '330300', '330000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('1011', '鹿城区', '330302', '330300', '325000', 'L', '3');
INSERT INTO `system_address` VALUES ('1012', '龙湾区', '330303', '330300', '325000', 'L', '3');
INSERT INTO `system_address` VALUES ('1013', '瓯海区', '330304', '330300', '325000', 'O', '3');
INSERT INTO `system_address` VALUES ('1014', '洞头县', '330322', '330300', '325700', 'D', '3');
INSERT INTO `system_address` VALUES ('1015', '永嘉县', '330324', '330300', '325100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1016', '平阳县', '330326', '330300', '325400', 'P', '3');
INSERT INTO `system_address` VALUES ('1017', '苍南县', '330327', '330300', '325800', 'C', '3');
INSERT INTO `system_address` VALUES ('1018', '文成县', '330328', '330300', '325300', 'W', '3');
INSERT INTO `system_address` VALUES ('1019', '泰顺县', '330329', '330300', '325500', 'T', '3');
INSERT INTO `system_address` VALUES ('1020', '瑞安市', '330381', '330300', '325200', 'R', '3');
INSERT INTO `system_address` VALUES ('1021', '乐清市', '330382', '330300', '325600', 'L', '3');
INSERT INTO `system_address` VALUES ('1022', '嘉兴市', '330400', '330000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1023', '南湖区', '330402', '330400', '314001', 'N', '3');
INSERT INTO `system_address` VALUES ('1024', '秀洲区', '330411', '330400', '314000', 'X', '3');
INSERT INTO `system_address` VALUES ('1025', '嘉善县', '330421', '330400', '314100', 'J', '3');
INSERT INTO `system_address` VALUES ('1026', '海盐县', '330424', '330400', '314300', 'H', '3');
INSERT INTO `system_address` VALUES ('1027', '海宁市', '330481', '330400', '314400', 'H', '3');
INSERT INTO `system_address` VALUES ('1028', '平湖市', '330482', '330400', '314200', 'P', '3');
INSERT INTO `system_address` VALUES ('1029', '桐乡市', '330483', '330400', '314500', 'T', '3');
INSERT INTO `system_address` VALUES ('1030', '湖州市', '330500', '330000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1031', '吴兴区', '330502', '330500', '313000', 'W', '3');
INSERT INTO `system_address` VALUES ('1032', '南浔区', '330503', '330500', '313000', 'N', '3');
INSERT INTO `system_address` VALUES ('1033', '德清县', '330521', '330500', '313200', 'D', '3');
INSERT INTO `system_address` VALUES ('1034', '长兴县', '330522', '330500', '313100', 'Z', '3');
INSERT INTO `system_address` VALUES ('1035', '安吉县', '330523', '330500', '313300', 'A', '3');
INSERT INTO `system_address` VALUES ('1036', '绍兴市', '330600', '330000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1037', '越城区', '330602', '330600', '312000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1038', '柯桥区', '330621', '330600', '312030', 'K', '3');
INSERT INTO `system_address` VALUES ('1039', '新昌县', '330624', '330600', '312500', 'X', '3');
INSERT INTO `system_address` VALUES ('1040', '诸暨市', '330681', '330600', '311800', 'Z', '3');
INSERT INTO `system_address` VALUES ('1041', '上虞区', '330682', '330600', '312300', 'S', '3');
INSERT INTO `system_address` VALUES ('1042', '嵊州市', '330683', '330600', '312400', 'S', '3');
INSERT INTO `system_address` VALUES ('1043', '金华市', '330700', '330000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1044', '婺城区', '330702', '330700', '321000', 'W', '3');
INSERT INTO `system_address` VALUES ('1045', '金东区', '330703', '330700', '321000', 'J', '3');
INSERT INTO `system_address` VALUES ('1046', '武义县', '330723', '330700', '321200', 'W', '3');
INSERT INTO `system_address` VALUES ('1047', '浦江县', '330726', '330700', '322200', 'P', '3');
INSERT INTO `system_address` VALUES ('1048', '磐安县', '330727', '330700', '322300', 'P', '3');
INSERT INTO `system_address` VALUES ('1049', '兰溪市', '330781', '330700', '321100', 'L', '3');
INSERT INTO `system_address` VALUES ('1050', '义乌市', '330782', '330700', '322000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1051', '东阳市', '330783', '330700', '322100', 'D', '3');
INSERT INTO `system_address` VALUES ('1052', '永康市', '330784', '330700', '321300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1053', '衢州市', '330800', '330000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('1054', '柯城区', '330802', '330800', '324000', 'K', '3');
INSERT INTO `system_address` VALUES ('1055', '衢江区', '330803', '330800', '324000', 'Q', '3');
INSERT INTO `system_address` VALUES ('1056', '常山县', '330822', '330800', '324200', 'C', '3');
INSERT INTO `system_address` VALUES ('1057', '开化县', '330824', '330800', '324300', 'K', '3');
INSERT INTO `system_address` VALUES ('1058', '龙游县', '330825', '330800', '324400', 'L', '3');
INSERT INTO `system_address` VALUES ('1059', '江山市', '330881', '330800', '324100', 'J', '3');
INSERT INTO `system_address` VALUES ('1060', '舟山市', '330900', '330000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1061', '定海区', '330902', '330900', '316000', 'D', '3');
INSERT INTO `system_address` VALUES ('1062', '普陀区', '330903', '330900', '316100', 'P', '3');
INSERT INTO `system_address` VALUES ('1063', '岱山县', '330921', '330900', '316200', 'D', '3');
INSERT INTO `system_address` VALUES ('1064', '嵊泗县', '330922', '330900', '202450', 'S', '3');
INSERT INTO `system_address` VALUES ('1065', '台州市', '331000', '330000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('1066', '椒江区', '331002', '331000', '317700', 'J', '3');
INSERT INTO `system_address` VALUES ('1067', '黄岩区', '331003', '331000', '318020', 'H', '3');
INSERT INTO `system_address` VALUES ('1068', '路桥区', '331004', '331000', '318000', 'L', '3');
INSERT INTO `system_address` VALUES ('1069', '玉环县', '331021', '331000', '317600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1070', '三门县', '331022', '331000', '317100', 'S', '3');
INSERT INTO `system_address` VALUES ('1071', '天台县', '331023', '331000', '317200', 'T', '3');
INSERT INTO `system_address` VALUES ('1072', '仙居县', '331024', '331000', '317300', 'X', '3');
INSERT INTO `system_address` VALUES ('1073', '温岭市', '331081', '331000', '317500', 'W', '3');
INSERT INTO `system_address` VALUES ('1074', '临海市', '331082', '331000', '317000', 'L', '3');
INSERT INTO `system_address` VALUES ('1075', '丽水市', '331100', '330000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1076', '莲都区', '331102', '331100', '323000', 'L', '3');
INSERT INTO `system_address` VALUES ('1077', '青田县', '331121', '331100', '323900', 'Q', '3');
INSERT INTO `system_address` VALUES ('1078', '缙云县', '331122', '331100', '321400', 'J', '3');
INSERT INTO `system_address` VALUES ('1079', '遂昌县', '331123', '331100', '323300', 'S', '3');
INSERT INTO `system_address` VALUES ('1080', '松阳县', '331124', '331100', '323400', 'S', '3');
INSERT INTO `system_address` VALUES ('1081', '云和县', '331125', '331100', '323600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1082', '庆元县', '331126', '331100', '323800', 'Q', '3');
INSERT INTO `system_address` VALUES ('1083', '景宁畲族自治县', '331127', '331100', '323500', 'J', '3');
INSERT INTO `system_address` VALUES ('1084', '龙泉市', '331181', '331100', '323700', 'L', '3');
INSERT INTO `system_address` VALUES ('1085', '安徽', '340000', '0', null, 'A', '1');
INSERT INTO `system_address` VALUES ('1086', '合肥市', '340100', '340000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1087', '瑶海区', '340102', '340100', '230000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1088', '庐阳区', '340103', '340100', '230000', 'L', '3');
INSERT INTO `system_address` VALUES ('1089', '蜀山区', '340104', '340100', '230000', 'S', '3');
INSERT INTO `system_address` VALUES ('1090', '包河区', '340111', '340100', '230000', 'B', '3');
INSERT INTO `system_address` VALUES ('1091', '长丰县', '340121', '340100', '231100', 'Z', '3');
INSERT INTO `system_address` VALUES ('1092', '肥东县', '340122', '340100', '230000', 'F', '3');
INSERT INTO `system_address` VALUES ('1093', '肥西县', '340123', '340100', '231200', 'F', '3');
INSERT INTO `system_address` VALUES ('1094', '高新区', '340151', '340100', '230000', 'G', '3');
INSERT INTO `system_address` VALUES ('1095', '中区', '340191', '340100', '230000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1096', '合肥经济技术开发区', '340198', '340100', '230000', 'H', '3');
INSERT INTO `system_address` VALUES ('1097', '合肥市政务新区', '340199', '340100', '230000', 'H', '3');
INSERT INTO `system_address` VALUES ('1098', '巢湖市', '341400', '340100', '238000', 'C', '3');
INSERT INTO `system_address` VALUES ('1099', '居巢区', '341402', '340100', '238000', 'J', '3');
INSERT INTO `system_address` VALUES ('1100', '庐江县', '341421', '340100', '231500', 'L', '3');
INSERT INTO `system_address` VALUES ('1101', '芜湖市', '340200', '340000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('1102', '镜湖区', '340202', '340200', '241000', 'J', '3');
INSERT INTO `system_address` VALUES ('1103', '弋江区', '340203', '340200', '241000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1104', '鸠江区', '340207', '340200', '241000', 'J', '3');
INSERT INTO `system_address` VALUES ('1105', '三山区', '340208', '340200', '241000', 'S', '3');
INSERT INTO `system_address` VALUES ('1106', '芜湖县', '340221', '340200', '241100', 'W', '3');
INSERT INTO `system_address` VALUES ('1107', '繁昌县', '340222', '340200', '241200', 'F', '3');
INSERT INTO `system_address` VALUES ('1108', '南陵县', '340223', '340200', '242400', 'N', '3');
INSERT INTO `system_address` VALUES ('1109', '无为县', '341422', '340200', '238300', 'W', '3');
INSERT INTO `system_address` VALUES ('1110', '蚌埠市', '340300', '340000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('1111', '龙子湖区', '340302', '340300', '233000', 'L', '3');
INSERT INTO `system_address` VALUES ('1112', '蚌山区', '340303', '340300', '233000', 'B', '3');
INSERT INTO `system_address` VALUES ('1113', '禹会区', '340304', '340300', '233000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1114', '淮上区', '340311', '340300', '233000', 'H', '3');
INSERT INTO `system_address` VALUES ('1115', '怀远县', '340321', '340300', '233400', 'H', '3');
INSERT INTO `system_address` VALUES ('1116', '五河县', '340322', '340300', '233000', 'W', '3');
INSERT INTO `system_address` VALUES ('1117', '固镇县', '340323', '340300', '233700', 'G', '3');
INSERT INTO `system_address` VALUES ('1118', '淮南市', '340400', '340000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1119', '大通区', '340402', '340400', '232000', 'D', '3');
INSERT INTO `system_address` VALUES ('1120', '田家庵区', '340403', '340400', '232000', 'T', '3');
INSERT INTO `system_address` VALUES ('1121', '谢家集区', '340404', '340400', '232000', 'X', '3');
INSERT INTO `system_address` VALUES ('1122', '八公山区', '340405', '340400', '232000', 'B', '3');
INSERT INTO `system_address` VALUES ('1123', '潘集区', '340406', '340400', '232000', 'P', '3');
INSERT INTO `system_address` VALUES ('1124', '凤台县', '340421', '340400', '232100', 'F', '3');
INSERT INTO `system_address` VALUES ('1125', '寿县', '341521', '340400', '232200', 'S', '3');
INSERT INTO `system_address` VALUES ('1126', '马鞍山市', '340500', '340000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('1127', '金家庄区', '340502', '340500', '243000', 'J', '3');
INSERT INTO `system_address` VALUES ('1128', '花山区', '340503', '340500', '243000', 'H', '3');
INSERT INTO `system_address` VALUES ('1129', '雨山区', '340504', '340500', '243000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1130', '博望区', '340506', '340500', '243131', 'B', '3');
INSERT INTO `system_address` VALUES ('1131', '当涂县', '340521', '340500', '243100', 'D', '3');
INSERT INTO `system_address` VALUES ('1132', '含山县', '341423', '340500', '238100', 'H', '3');
INSERT INTO `system_address` VALUES ('1133', '和县', '341424', '340500', '238200', 'H', '3');
INSERT INTO `system_address` VALUES ('1134', '淮北市', '340600', '340000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1135', '杜集区', '340602', '340600', '235000', 'D', '3');
INSERT INTO `system_address` VALUES ('1136', '相山区', '340603', '340600', '235000', 'X', '3');
INSERT INTO `system_address` VALUES ('1137', '烈山区', '340604', '340600', '235000', 'L', '3');
INSERT INTO `system_address` VALUES ('1138', '濉溪县', '340621', '340600', '235100', 'S', '3');
INSERT INTO `system_address` VALUES ('1139', '铜陵市', '340700', '340000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('1140', '铜官山区', '340702', '340700', '244000', 'T', '3');
INSERT INTO `system_address` VALUES ('1141', '狮子山区', '340703', '340700', '244000', 'S', '3');
INSERT INTO `system_address` VALUES ('1142', '郊区', '340711', '340700', '244000', 'J', '3');
INSERT INTO `system_address` VALUES ('1143', '义安区', '340721', '340700', '244100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1144', '枞阳县', '340823', '340700', '246700', 'Z', '3');
INSERT INTO `system_address` VALUES ('1145', '安庆市', '340800', '340000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('1146', '迎江区', '340802', '340800', '246000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1147', '大观区', '340803', '340800', '246000', 'D', '3');
INSERT INTO `system_address` VALUES ('1148', '宜秀区', '340811', '340800', '246003', 'Y', '3');
INSERT INTO `system_address` VALUES ('1149', '怀宁县', '340822', '340800', '246100', 'H', '3');
INSERT INTO `system_address` VALUES ('1150', '枞阳县', '340823', '340800', '246700', 'Z', '3');
INSERT INTO `system_address` VALUES ('1151', '潜山县', '340824', '340800', '246300', 'Q', '3');
INSERT INTO `system_address` VALUES ('1152', '太湖县', '340825', '340800', '246400', 'T', '3');
INSERT INTO `system_address` VALUES ('1153', '宿松县', '340826', '340800', '246500', 'S', '3');
INSERT INTO `system_address` VALUES ('1154', '望江县', '340827', '340800', '246200', 'W', '3');
INSERT INTO `system_address` VALUES ('1155', '岳西县', '340828', '340800', '246600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1156', '桐城市', '340881', '340800', '231400', 'T', '3');
INSERT INTO `system_address` VALUES ('1157', '黄山市', '341000', '340000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1158', '屯溪区', '341002', '341000', '245000', 'T', '3');
INSERT INTO `system_address` VALUES ('1159', '黄山区', '341003', '341000', '242700', 'H', '3');
INSERT INTO `system_address` VALUES ('1160', '徽州区', '341004', '341000', '245061', 'H', '3');
INSERT INTO `system_address` VALUES ('1161', '歙县', '341021', '341000', '245200', 'S', '3');
INSERT INTO `system_address` VALUES ('1162', '休宁县', '341022', '341000', '245400', 'X', '3');
INSERT INTO `system_address` VALUES ('1163', '黟县', '341023', '341000', '245500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1164', '祁门县', '341024', '341000', '245600', 'Q', '3');
INSERT INTO `system_address` VALUES ('1165', '滁州市', '341100', '340000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('1166', '琅琊区', '341102', '341100', '239000', 'L', '3');
INSERT INTO `system_address` VALUES ('1167', '南谯区', '341103', '341100', '239000', 'N', '3');
INSERT INTO `system_address` VALUES ('1168', '来安县', '341122', '341100', '239200', 'L', '3');
INSERT INTO `system_address` VALUES ('1169', '全椒县', '341124', '341100', '239500', 'Q', '3');
INSERT INTO `system_address` VALUES ('1170', '定远县', '341125', '341100', '233200', 'D', '3');
INSERT INTO `system_address` VALUES ('1171', '凤阳县', '341126', '341100', '233100', 'F', '3');
INSERT INTO `system_address` VALUES ('1172', '天长市', '341181', '341100', '239300', 'T', '3');
INSERT INTO `system_address` VALUES ('1173', '明光市', '341182', '341100', '239400', 'M', '3');
INSERT INTO `system_address` VALUES ('1174', '阜阳市', '341200', '340000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('1175', '颍州区', '341202', '341200', '236000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1176', '颍东区', '341203', '341200', '236000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1177', '颍泉区', '341204', '341200', '236000	', 'Y', '3');
INSERT INTO `system_address` VALUES ('1178', '临泉县', '341221', '341200', '236400', 'L', '3');
INSERT INTO `system_address` VALUES ('1179', '太和县', '341222', '341200', '236600', 'T', '3');
INSERT INTO `system_address` VALUES ('1180', '阜南县', '341225', '341200', '236300', 'F', '3');
INSERT INTO `system_address` VALUES ('1181', '颍上县', '341226', '341200', '236200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1182', '界首市', '341282', '341200', '236500', 'J', '3');
INSERT INTO `system_address` VALUES ('1183', '宿州市', '341300', '340000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1184', '埇桥区', '341302', '341300', '234000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1185', '砀山县', '341321', '341300', '235300', 'D', '3');
INSERT INTO `system_address` VALUES ('1186', '萧县', '341322', '341300', '235200', 'X', '3');
INSERT INTO `system_address` VALUES ('1187', '灵璧县', '341323', '341300', '234200', 'L', '3');
INSERT INTO `system_address` VALUES ('1188', '泗县', '341324', '341300', '234300', 'S', '3');
INSERT INTO `system_address` VALUES ('1189', '六安市', '341500', '340000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1190', '金安区', '341502', '341500', '237000', 'J', '3');
INSERT INTO `system_address` VALUES ('1191', '裕安区', '341503', '341500', '237000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1192', '霍邱县', '341522', '341500', '237400', 'H', '3');
INSERT INTO `system_address` VALUES ('1193', '舒城县', '341523', '341500', '231300', 'S', '3');
INSERT INTO `system_address` VALUES ('1194', '金寨县', '341524', '341500', '237300', 'J', '3');
INSERT INTO `system_address` VALUES ('1195', '霍山县', '341525', '341500', '237200', 'H', '3');
INSERT INTO `system_address` VALUES ('1196', '叶集区', '341526', '341500', '237431', 'Y', '3');
INSERT INTO `system_address` VALUES ('1197', '亳州市', '341600', '340000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('1198', '谯城区', '341602', '341600', '236800', 'Q', '3');
INSERT INTO `system_address` VALUES ('1199', '涡阳县', '341621', '341600', '233600', 'W', '3');
INSERT INTO `system_address` VALUES ('1200', '蒙城县', '341622', '341600', '233500', 'M', '3');
INSERT INTO `system_address` VALUES ('1201', '利辛县', '341623', '341600', '236700', 'L', '3');
INSERT INTO `system_address` VALUES ('1202', '池州市', '341700', '340000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('1203', '贵池区', '341702', '341700', '247100', 'G', '3');
INSERT INTO `system_address` VALUES ('1204', '东至县', '341721', '341700', '247200', 'D', '3');
INSERT INTO `system_address` VALUES ('1205', '石台县', '341722', '341700', '245100', 'S', '3');
INSERT INTO `system_address` VALUES ('1206', '青阳县', '341723', '341700', '242800', 'Q', '3');
INSERT INTO `system_address` VALUES ('1207', '宣城市', '341800', '340000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1208', '宣州区', '341802', '341800', '242000', 'X', '3');
INSERT INTO `system_address` VALUES ('1209', '郎溪县', '341821', '341800', '242100', 'L', '3');
INSERT INTO `system_address` VALUES ('1210', '广德县', '341822', '341800', '242200', 'G', '3');
INSERT INTO `system_address` VALUES ('1211', '泾县', '341823', '341800', '242500', 'J', '3');
INSERT INTO `system_address` VALUES ('1212', '绩溪县', '341824', '341800', '245300', 'J', '3');
INSERT INTO `system_address` VALUES ('1213', '旌德县', '341825', '341800', '242600', 'J', '3');
INSERT INTO `system_address` VALUES ('1214', '宁国市', '341881', '341800', '242300', 'N', '3');
INSERT INTO `system_address` VALUES ('1215', '福建', '350000', '0', null, 'F', '1');
INSERT INTO `system_address` VALUES ('1216', '福州市', '350100', '350000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('1217', '鼓楼区', '350102', '350100', '350000', 'G', '3');
INSERT INTO `system_address` VALUES ('1218', '台江区', '350103', '350100', '350000', 'T', '3');
INSERT INTO `system_address` VALUES ('1219', '仓山区', '350104', '350100', '350000', 'C', '3');
INSERT INTO `system_address` VALUES ('1220', '马尾区', '350105', '350100', '350000', 'M', '3');
INSERT INTO `system_address` VALUES ('1221', '晋安区', '350111', '350100', '350000', 'J', '3');
INSERT INTO `system_address` VALUES ('1222', '闽侯县', '350121', '350100', '350100', 'M', '3');
INSERT INTO `system_address` VALUES ('1223', '连江县', '350122', '350100', '350500', 'L', '3');
INSERT INTO `system_address` VALUES ('1224', '罗源县', '350123', '350100', '350600', 'L', '3');
INSERT INTO `system_address` VALUES ('1225', '闽清县', '350124', '350100', '350800', 'M', '3');
INSERT INTO `system_address` VALUES ('1226', '永泰县', '350125', '350100', '350700', 'Y', '3');
INSERT INTO `system_address` VALUES ('1227', '平潭县', '350128', '350100', '350400', 'P', '3');
INSERT INTO `system_address` VALUES ('1228', '福清市', '350181', '350100', '350300', 'F', '3');
INSERT INTO `system_address` VALUES ('1229', '长乐市', '350182', '350100', '350200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1230', '厦门市', '350200', '350000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1231', '思明区', '350203', '350200', '361001', 'S', '3');
INSERT INTO `system_address` VALUES ('1232', '海沧区', '350205', '350200', '361000', 'H', '3');
INSERT INTO `system_address` VALUES ('1233', '湖里区', '350206', '350200', '361000', 'H', '3');
INSERT INTO `system_address` VALUES ('1234', '集美区', '350211', '350200', '361000', 'J', '3');
INSERT INTO `system_address` VALUES ('1235', '同安区', '350212', '350200', '361100', 'T', '3');
INSERT INTO `system_address` VALUES ('1236', '翔安区', '350213', '350200', '361100', 'X', '3');
INSERT INTO `system_address` VALUES ('1237', '莆田市', '350300', '350000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('1238', '城厢区', '350302', '350300', '351100', 'C', '3');
INSERT INTO `system_address` VALUES ('1239', '涵江区', '350303', '350300', '351100', 'H', '3');
INSERT INTO `system_address` VALUES ('1240', '荔城区', '350304', '350300', '351100', 'L', '3');
INSERT INTO `system_address` VALUES ('1241', '秀屿区', '350305', '350300', '351100', 'X', '3');
INSERT INTO `system_address` VALUES ('1242', '仙游县', '350322', '350300', '351200', 'X', '3');
INSERT INTO `system_address` VALUES ('1243', '三明市', '350400', '350000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1244', '梅列区', '350402', '350400', '365000', 'M', '3');
INSERT INTO `system_address` VALUES ('1245', '三元区', '350403', '350400', '365000', 'S', '3');
INSERT INTO `system_address` VALUES ('1246', '明溪县', '350421', '350400', '365200', 'M', '3');
INSERT INTO `system_address` VALUES ('1247', '清流县', '350423', '350400', '365300', 'Q', '3');
INSERT INTO `system_address` VALUES ('1248', '宁化县', '350424', '350400', '365400', 'N', '3');
INSERT INTO `system_address` VALUES ('1249', '大田县', '350425', '350400', '366100', 'D', '3');
INSERT INTO `system_address` VALUES ('1250', '尤溪县', '350426', '350400', '365100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1251', '沙县', '350427', '350400', '365500', 'S', '3');
INSERT INTO `system_address` VALUES ('1252', '将乐县', '350428', '350400', '353300', 'J', '3');
INSERT INTO `system_address` VALUES ('1253', '泰宁县', '350429', '350400', '354400', 'T', '3');
INSERT INTO `system_address` VALUES ('1254', '建宁县', '350430', '350400', '354500', 'J', '3');
INSERT INTO `system_address` VALUES ('1255', '永安市', '350481', '350400', '366000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1256', '泉州市', '350500', '350000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('1257', '鲤城区', '350502', '350500', '362000', 'L', '3');
INSERT INTO `system_address` VALUES ('1258', '丰泽区', '350503', '350500', '362000', 'F', '3');
INSERT INTO `system_address` VALUES ('1259', '洛江区', '350504', '350500', '362000', 'L', '3');
INSERT INTO `system_address` VALUES ('1260', '泉港区', '350505', '350500', '362800', 'Q', '3');
INSERT INTO `system_address` VALUES ('1261', '惠安县', '350521', '350500', '362100', 'H', '3');
INSERT INTO `system_address` VALUES ('1262', '安溪县', '350524', '350500', '362400', 'A', '3');
INSERT INTO `system_address` VALUES ('1263', '永春县', '350525', '350500', '362600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1264', '德化县', '350526', '350500', '362500', 'D', '3');
INSERT INTO `system_address` VALUES ('1265', '金门县', '350527', '350500', '362000', 'J', '3');
INSERT INTO `system_address` VALUES ('1266', '石狮市', '350581', '350500', '362700', 'S', '3');
INSERT INTO `system_address` VALUES ('1267', '晋江市', '350582', '350500', '362200', 'J', '3');
INSERT INTO `system_address` VALUES ('1268', '南安市', '350583', '350500', '362300', 'N', '3');
INSERT INTO `system_address` VALUES ('1269', '漳州市', '350600', '350000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1270', '芗城区', '350602', '350600', '363000', 'X', '3');
INSERT INTO `system_address` VALUES ('1271', '龙文区', '350603', '350600', '363000', 'L', '3');
INSERT INTO `system_address` VALUES ('1272', '云霄县', '350622', '350600', '363300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1273', '漳浦县', '350623', '350600', '363200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1274', '诏安县', '350624', '350600', '363500', 'Z', '3');
INSERT INTO `system_address` VALUES ('1275', '长泰县', '350625', '350600', '363900', 'Z', '3');
INSERT INTO `system_address` VALUES ('1276', '东山县', '350626', '350600', '363400', 'D', '3');
INSERT INTO `system_address` VALUES ('1277', '南靖县', '350627', '350600', '363600', 'N', '3');
INSERT INTO `system_address` VALUES ('1278', '平和县', '350628', '350600', '363700', 'P', '3');
INSERT INTO `system_address` VALUES ('1279', '华安县', '350629', '350600', '363800', 'H', '3');
INSERT INTO `system_address` VALUES ('1280', '龙海市', '350681', '350600', '363100', 'L', '3');
INSERT INTO `system_address` VALUES ('1281', '南平市', '350700', '350000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('1282', '延平区', '350702', '350700', '353000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1283', '顺昌县', '350721', '350700', '353200', 'S', '3');
INSERT INTO `system_address` VALUES ('1284', '浦城县', '350722', '350700', '353400', 'P', '3');
INSERT INTO `system_address` VALUES ('1285', '光泽县', '350723', '350700', '354100', 'G', '3');
INSERT INTO `system_address` VALUES ('1286', '松溪县', '350724', '350700', '353500', 'S', '3');
INSERT INTO `system_address` VALUES ('1287', '政和县', '350725', '350700', '353600', 'Z', '3');
INSERT INTO `system_address` VALUES ('1288', '邵武市', '350781', '350700', '354000', 'S', '3');
INSERT INTO `system_address` VALUES ('1289', '武夷山市', '350782', '350700', '354300', 'W', '3');
INSERT INTO `system_address` VALUES ('1290', '建瓯市', '350783', '350700', '353100', 'J', '3');
INSERT INTO `system_address` VALUES ('1291', '建阳区', '350784', '350700', '354200	', 'J', '3');
INSERT INTO `system_address` VALUES ('1292', '龙岩市', '350800', '350000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1293', '新罗区', '350802', '350800', '364000', 'X', '3');
INSERT INTO `system_address` VALUES ('1294', '长汀县', '350821', '350800', '366300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1295', '永定区', '350822', '350800', '364100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1296', '上杭县', '350823', '350800', '364200', 'S', '3');
INSERT INTO `system_address` VALUES ('1297', '武平县', '350824', '350800', '364300', 'W', '3');
INSERT INTO `system_address` VALUES ('1298', '连城县', '350825', '350800', '366200', 'L', '3');
INSERT INTO `system_address` VALUES ('1299', '漳平市', '350881', '350800', '364400', 'Z', '3');
INSERT INTO `system_address` VALUES ('1300', '宁德市', '350900', '350000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('1301', '蕉城区', '350902', '350900', '352000', 'J', '3');
INSERT INTO `system_address` VALUES ('1302', '霞浦县', '350921', '350900', '355100', 'X', '3');
INSERT INTO `system_address` VALUES ('1303', '古田县', '350922', '350900', '352200', 'G', '3');
INSERT INTO `system_address` VALUES ('1304', '屏南县', '350923', '350900', '352300', 'P', '3');
INSERT INTO `system_address` VALUES ('1305', '寿宁县', '350924', '350900', '355500', 'S', '3');
INSERT INTO `system_address` VALUES ('1306', '周宁县', '350925', '350900', '355400', 'Z', '3');
INSERT INTO `system_address` VALUES ('1307', '柘荣县', '350926', '350900', '355300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1308', '福安市', '350981', '350900', '355000', 'F', '3');
INSERT INTO `system_address` VALUES ('1309', '福鼎市', '350982', '350900', '355200', 'F', '3');
INSERT INTO `system_address` VALUES ('1310', '江西', '360000', '0', null, 'J', '1');
INSERT INTO `system_address` VALUES ('1311', '南昌市', '360100', '360000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('1312', '东湖区', '360102', '360100', '330000', 'D', '3');
INSERT INTO `system_address` VALUES ('1313', '西湖区', '360103', '360100', '330000', 'X', '3');
INSERT INTO `system_address` VALUES ('1314', '青云谱区', '360104', '360100', '330000', 'Q', '3');
INSERT INTO `system_address` VALUES ('1315', '湾里区', '360105', '360100', '330000', 'W', '3');
INSERT INTO `system_address` VALUES ('1316', '青山湖区', '360111', '360100', '330000', 'Q', '3');
INSERT INTO `system_address` VALUES ('1317', '南昌县', '360121', '360100', '330200', 'N', '3');
INSERT INTO `system_address` VALUES ('1318', '新建县', '360122', '360100', '330100', 'X', '3');
INSERT INTO `system_address` VALUES ('1319', '安义县', '360123', '360100', '330500', 'A', '3');
INSERT INTO `system_address` VALUES ('1320', '进贤县', '360124', '360100', '331700', 'J', '3');
INSERT INTO `system_address` VALUES ('1321', '红谷滩新区', '360125', '360100', '330000', 'H', '3');
INSERT INTO `system_address` VALUES ('1322', '经济技术开发区', '360126', '360100', '330000', 'J', '3');
INSERT INTO `system_address` VALUES ('1323', '昌北区', '360127', '360100', '330000', 'C', '3');
INSERT INTO `system_address` VALUES ('1324', '景德镇市', '360200', '360000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1325', '昌江区', '360202', '360200', '333000', 'C', '3');
INSERT INTO `system_address` VALUES ('1326', '珠山区', '360203', '360200', '333000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1327', '浮梁县', '360222', '360200', '333400', 'F', '3');
INSERT INTO `system_address` VALUES ('1328', '乐平市', '360281', '360200', '333300', 'L', '3');
INSERT INTO `system_address` VALUES ('1329', '萍乡市', '360300', '360000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('1330', '安源区', '360302', '360300', '337000', 'A', '3');
INSERT INTO `system_address` VALUES ('1331', '湘东区', '360313', '360300', '337000', 'X', '3');
INSERT INTO `system_address` VALUES ('1332', '莲花县', '360321', '360300', '337100', 'L', '3');
INSERT INTO `system_address` VALUES ('1333', '上栗县', '360322', '360300', '337009', 'S', '3');
INSERT INTO `system_address` VALUES ('1334', '芦溪县', '360323', '360300', '337000', 'L', '3');
INSERT INTO `system_address` VALUES ('1335', '九江市', '360400', '360000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1336', '庐山区', '360402', '360400', '332900', 'L', '3');
INSERT INTO `system_address` VALUES ('1337', '浔阳区', '360403', '360400', '332000', 'X', '3');
INSERT INTO `system_address` VALUES ('1338', '九江县', '360421', '360400', '332100', 'J', '3');
INSERT INTO `system_address` VALUES ('1339', '武宁县', '360423', '360400', '332300', 'W', '3');
INSERT INTO `system_address` VALUES ('1340', '修水县', '360424', '360400', '332400', 'X', '3');
INSERT INTO `system_address` VALUES ('1341', '永修县', '360425', '360400', '330300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1342', '德安县', '360426', '360400', '330400', 'D', '3');
INSERT INTO `system_address` VALUES ('1343', '星子县', '360427', '360400', '332800', 'X', '3');
INSERT INTO `system_address` VALUES ('1344', '都昌县', '360428', '360400', '332600', 'D', '3');
INSERT INTO `system_address` VALUES ('1345', '湖口县', '360429', '360400', '332500', 'H', '3');
INSERT INTO `system_address` VALUES ('1346', '彭泽县', '360430', '360400', '332700', 'P', '3');
INSERT INTO `system_address` VALUES ('1347', '瑞昌市', '360481', '360400', '332200', 'R', '3');
INSERT INTO `system_address` VALUES ('1348', '共青城市', '360483', '360400', '332020', 'G', '3');
INSERT INTO `system_address` VALUES ('1349', '新余市', '360500', '360000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1350', '渝水区', '360502', '360500', '338000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1351', '分宜县', '360521', '360500', '336600', 'F', '3');
INSERT INTO `system_address` VALUES ('1352', '鹰潭市', '360600', '360000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1353', '月湖区', '360602', '360600', '335000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1354', '余江县', '360622', '360600', '335200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1355', '贵溪市', '360681', '360600', '335400', 'G', '3');
INSERT INTO `system_address` VALUES ('1356', '赣州市', '360700', '360000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('1357', '章贡区', '360702', '360700', '341000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1358', '信丰县', '360704', '360700', '341600', 'X', '3');
INSERT INTO `system_address` VALUES ('1359', '赣县区', '360722', '360700', '341100', 'G', '3');
INSERT INTO `system_address` VALUES ('1360', '大余县', '360723', '360700', '341500', 'D', '3');
INSERT INTO `system_address` VALUES ('1361', '上犹县', '360724', '360700', '341200', 'S', '3');
INSERT INTO `system_address` VALUES ('1362', '崇义县', '360725', '360700', '341300', 'C', '3');
INSERT INTO `system_address` VALUES ('1363', '安远县', '360726', '360700', '342100', 'A', '3');
INSERT INTO `system_address` VALUES ('1364', '龙南县', '360727', '360700', '341700', 'L', '3');
INSERT INTO `system_address` VALUES ('1365', '定南县', '360728', '360700', '341900', 'D', '3');
INSERT INTO `system_address` VALUES ('1366', '全南县', '360729', '360700', '341800', 'Q', '3');
INSERT INTO `system_address` VALUES ('1367', '宁都县', '360730', '360700', '342800', 'N', '3');
INSERT INTO `system_address` VALUES ('1368', '于都县', '360731', '360700', '342300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1369', '兴国县', '360732', '360700', '342400', 'X', '3');
INSERT INTO `system_address` VALUES ('1370', '会昌县', '360733', '360700', '342600', 'H', '3');
INSERT INTO `system_address` VALUES ('1371', '寻乌县', '360734', '360700', '342200', 'X', '3');
INSERT INTO `system_address` VALUES ('1372', '石城县', '360735', '360700', '342700', 'S', '3');
INSERT INTO `system_address` VALUES ('1373', '黄金区', '360751', '360700', '341000', 'H', '3');
INSERT INTO `system_address` VALUES ('1374', '瑞金市', '360781', '360700', '342500', 'R', '3');
INSERT INTO `system_address` VALUES ('1375', '南康区', '360782', '360700', '341400', 'N', '3');
INSERT INTO `system_address` VALUES ('1376', '吉安市', '360800', '360000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1377', '吉州区', '360802', '360800', '343000', 'J', '3');
INSERT INTO `system_address` VALUES ('1378', '青原区', '360803', '360800', '343000', 'Q', '3');
INSERT INTO `system_address` VALUES ('1379', '吉安县', '360821', '360800', '343100', 'J', '3');
INSERT INTO `system_address` VALUES ('1380', '吉水县', '360822', '360800', '331600', 'J', '3');
INSERT INTO `system_address` VALUES ('1381', '峡江县', '360823', '360800', '331400', 'X', '3');
INSERT INTO `system_address` VALUES ('1382', '新干县', '360824', '360800', '331300', 'X', '3');
INSERT INTO `system_address` VALUES ('1383', '永丰县', '360825', '360800', '331500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1384', '泰和县', '360826', '360800', '343700', 'T', '3');
INSERT INTO `system_address` VALUES ('1385', '遂川县', '360827', '360800', '343900', 'S', '3');
INSERT INTO `system_address` VALUES ('1386', '万安县', '360828', '360800', '343800', 'W', '3');
INSERT INTO `system_address` VALUES ('1387', '安福县', '360829', '360800', '343200', 'A', '3');
INSERT INTO `system_address` VALUES ('1388', '永新县', '360830', '360800', '343400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1389', '井冈山市', '360881', '360800', '343600', 'J', '3');
INSERT INTO `system_address` VALUES ('1390', '宜春市', '360900', '360000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1391', '袁州区', '360902', '360900', '336000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1392', '奉新县', '360921', '360900', '330700', 'F', '3');
INSERT INTO `system_address` VALUES ('1393', '万载县', '360922', '360900', '336100', 'W', '3');
INSERT INTO `system_address` VALUES ('1394', '上高县', '360923', '360900', '336400', 'S', '3');
INSERT INTO `system_address` VALUES ('1395', '宜丰县', '360924', '360900', '336300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1396', '靖安县', '360925', '360900', '330600', 'J', '3');
INSERT INTO `system_address` VALUES ('1397', '铜鼓县', '360926', '360900', '336200', 'T', '3');
INSERT INTO `system_address` VALUES ('1398', '丰城市', '360981', '360900', '331100', 'F', '3');
INSERT INTO `system_address` VALUES ('1399', '樟树市', '360982', '360900', '331200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1400', '高安市', '360983', '360900', '330800', 'G', '3');
INSERT INTO `system_address` VALUES ('1401', '抚州市', '361000', '360000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('1402', '临川区', '361002', '361000', '344100', 'L', '3');
INSERT INTO `system_address` VALUES ('1403', '南城县', '361021', '361000', '344700', 'N', '3');
INSERT INTO `system_address` VALUES ('1404', '黎川县', '361022', '361000', '344600', 'L', '3');
INSERT INTO `system_address` VALUES ('1405', '南丰县', '361023', '361000', '344500', 'N', '3');
INSERT INTO `system_address` VALUES ('1406', '崇仁县', '361024', '361000', '344200', 'C', '3');
INSERT INTO `system_address` VALUES ('1407', '乐安县', '361025', '361000', '344300', 'L', '3');
INSERT INTO `system_address` VALUES ('1408', '宜黄县', '361026', '361000', '344400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1409', '金溪县', '361027', '361000', '344800', 'J', '3');
INSERT INTO `system_address` VALUES ('1410', '资溪县', '361028', '361000', '335300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1411', '东乡县', '361029', '361000', '331800', 'D', '3');
INSERT INTO `system_address` VALUES ('1412', '广昌县', '361030', '361000', '344900', 'G', '3');
INSERT INTO `system_address` VALUES ('1413', '上饶市', '361100', '360000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1414', '信州区', '361102', '361100', '334000', 'X', '3');
INSERT INTO `system_address` VALUES ('1415', '上饶县', '361121', '361100', '334100', 'S', '3');
INSERT INTO `system_address` VALUES ('1416', '广丰县', '361122', '361100', '334600', 'G', '3');
INSERT INTO `system_address` VALUES ('1417', '玉山县', '361123', '361100', '334700', 'Y', '3');
INSERT INTO `system_address` VALUES ('1418', '铅山县', '361124', '361100', '334500', 'Q', '3');
INSERT INTO `system_address` VALUES ('1419', '横峰县', '361125', '361100', '334300', 'H', '3');
INSERT INTO `system_address` VALUES ('1420', '弋阳县', '361126', '361100', '334400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1421', '余干县', '361127', '361100', '335100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1422', '鄱阳县', '361128', '361100', '333100', 'P', '3');
INSERT INTO `system_address` VALUES ('1423', '万年县', '361129', '361100', '335500', 'W', '3');
INSERT INTO `system_address` VALUES ('1424', '婺源县', '361130', '361100', '333200', 'W', '3');
INSERT INTO `system_address` VALUES ('1425', '德兴市', '361181', '361100', '334200', 'D', '3');
INSERT INTO `system_address` VALUES ('1426', '山东', '370000', '0', null, 'S', '1');
INSERT INTO `system_address` VALUES ('1427', '济南市', '370100', '370000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1428', '高新区', '250101', '370100', '250000', 'G', '3');
INSERT INTO `system_address` VALUES ('1429', '历下区', '370102', '370100', '250000', 'L', '3');
INSERT INTO `system_address` VALUES ('1430', '市中区', '370103', '370100', '250000', 'S', '3');
INSERT INTO `system_address` VALUES ('1431', '槐荫区', '370104', '370100', '250000', 'H', '3');
INSERT INTO `system_address` VALUES ('1432', '天桥区', '370105', '370100', '250000', 'T', '3');
INSERT INTO `system_address` VALUES ('1433', '历城区', '370112', '370100', '250100', 'L', '3');
INSERT INTO `system_address` VALUES ('1434', '长清区', '370113', '370100', '250300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1435', '平阴县', '370124', '370100', '250400', 'P', '3');
INSERT INTO `system_address` VALUES ('1436', '济阳县', '370125', '370100', '251400', 'J', '3');
INSERT INTO `system_address` VALUES ('1437', '商河县', '370126', '370100', '251600', 'S', '3');
INSERT INTO `system_address` VALUES ('1438', '章丘市', '370181', '370100', '250200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1439', '青岛市', '370200', '370000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('1440', '市南区', '370202', '370200', '266000', 'S', '3');
INSERT INTO `system_address` VALUES ('1441', '市北区', '370203', '370200', '266000', 'S', '3');
INSERT INTO `system_address` VALUES ('1442', '西海岸新区', '370204', '370200', '266000', 'X', '3');
INSERT INTO `system_address` VALUES ('1443', '四方区', '370205', '370200', '266000', 'S', '3');
INSERT INTO `system_address` VALUES ('1444', '黄岛区', '370211', '370200', '266000', 'H', '3');
INSERT INTO `system_address` VALUES ('1445', '崂山区', '370212', '370200', '266100', 'L', '3');
INSERT INTO `system_address` VALUES ('1446', '李沧区', '370213', '370200', '266000', 'L', '3');
INSERT INTO `system_address` VALUES ('1447', '城阳区', '370214', '370200', '266000', 'C', '3');
INSERT INTO `system_address` VALUES ('1448', '开发区', '370251', '370200', '266000', 'K', '3');
INSERT INTO `system_address` VALUES ('1449', '胶州市', '370281', '370200', '266300', 'J', '3');
INSERT INTO `system_address` VALUES ('1450', '即墨市', '370282', '370200', '266200', 'J', '3');
INSERT INTO `system_address` VALUES ('1451', '平度市', '370283', '370200', '266700', 'P', '3');
INSERT INTO `system_address` VALUES ('1452', '胶南市', '370284', '370200', '266400', 'J', '3');
INSERT INTO `system_address` VALUES ('1453', '莱西市', '370285', '370200', '266600', 'L', '3');
INSERT INTO `system_address` VALUES ('1454', '淄博市', '370300', '370000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1455', '淄川区', '370302', '370300', '255100', 'Z', '3');
INSERT INTO `system_address` VALUES ('1456', '张店区', '370303', '370300', '255000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1457', '博山区', '370304', '370300', '255200', 'B', '3');
INSERT INTO `system_address` VALUES ('1458', '临淄区', '370305', '370300', '255400', 'L', '3');
INSERT INTO `system_address` VALUES ('1459', '周村区', '370306', '370300', '255300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1460', '桓台县', '370321', '370300', '256400', 'H', '3');
INSERT INTO `system_address` VALUES ('1461', '高青县', '370322', '370300', '256300', 'G', '3');
INSERT INTO `system_address` VALUES ('1462', '沂源县', '370323', '370300', '256100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1463', '枣庄市', '370400', '370000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1464', '市中区', '370402', '370400', '277000', 'S', '3');
INSERT INTO `system_address` VALUES ('1465', '薛城区', '370403', '370400', '277000', 'X', '3');
INSERT INTO `system_address` VALUES ('1466', '峄城区', '370404', '370400', '277300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1467', '台儿庄区', '370405', '370400', '277400', 'T', '3');
INSERT INTO `system_address` VALUES ('1468', '山亭区', '370406', '370400', '277200', 'S', '3');
INSERT INTO `system_address` VALUES ('1469', '滕州市', '370481', '370400', '277500', 'T', '3');
INSERT INTO `system_address` VALUES ('1470', '东营市', '370500', '370000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('1471', '东营区', '370502', '370500', '257100', 'D', '3');
INSERT INTO `system_address` VALUES ('1472', '河口区', '370503', '370500', '257200', 'H', '3');
INSERT INTO `system_address` VALUES ('1473', '垦利县', '370521', '370500', '257500', 'K', '3');
INSERT INTO `system_address` VALUES ('1474', '利津县', '370522', '370500', '257400', 'L', '3');
INSERT INTO `system_address` VALUES ('1475', '广饶县', '370523', '370500', '257300', 'G', '3');
INSERT INTO `system_address` VALUES ('1476', '西城区', '370589', '370500', '257000', 'X', '3');
INSERT INTO `system_address` VALUES ('1477', '东城区', '370590', '370500', '257000', 'D', '3');
INSERT INTO `system_address` VALUES ('1478', '烟台市', '370600', '370000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1479', '芝罘区', '370602', '370600', '264000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1480', '福山区', '370611', '370600', '265500', 'F', '3');
INSERT INTO `system_address` VALUES ('1481', '牟平区', '370612', '370600', '264100', 'M', '3');
INSERT INTO `system_address` VALUES ('1482', '莱山区', '370613', '370600', '264000', 'L', '3');
INSERT INTO `system_address` VALUES ('1483', '长岛县', '370634', '370600', '265800', 'Z', '3');
INSERT INTO `system_address` VALUES ('1484', '龙口市', '370681', '370600', '265700', 'L', '3');
INSERT INTO `system_address` VALUES ('1485', '莱阳市', '370682', '370600', '265200', 'L', '3');
INSERT INTO `system_address` VALUES ('1486', '莱州市', '370683', '370600', '261400', 'L', '3');
INSERT INTO `system_address` VALUES ('1487', '蓬莱市', '370684', '370600', '265600', 'P', '3');
INSERT INTO `system_address` VALUES ('1488', '招远市', '370685', '370600', '265400', 'Z', '3');
INSERT INTO `system_address` VALUES ('1489', '栖霞市', '370686', '370600', '265300', 'Q', '3');
INSERT INTO `system_address` VALUES ('1490', '海阳市', '370687', '370600', '265100', 'H', '3');
INSERT INTO `system_address` VALUES ('1491', '潍坊市', '370700', '370000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('1492', '潍城区', '370702', '370700', '261000', 'W', '3');
INSERT INTO `system_address` VALUES ('1493', '寒亭区', '370703', '370700', '261100', 'H', '3');
INSERT INTO `system_address` VALUES ('1494', '坊子区', '370704', '370700', '261200', 'F', '3');
INSERT INTO `system_address` VALUES ('1495', '奎文区', '370705', '370700', '261000', 'K', '3');
INSERT INTO `system_address` VALUES ('1496', '滨海经济技术开发区', '370706', '370700', '261000', 'B', '3');
INSERT INTO `system_address` VALUES ('1497', '临朐县', '370724', '370700', '262600', 'L', '3');
INSERT INTO `system_address` VALUES ('1498', '昌乐县', '370725', '370700', '262400', 'C', '3');
INSERT INTO `system_address` VALUES ('1499', '开发区', '370751', '370700', '261000', 'K', '3');
INSERT INTO `system_address` VALUES ('1500', '青州市', '370781', '370700', '262500', 'Q', '3');
INSERT INTO `system_address` VALUES ('1501', '诸城市', '370782', '370700', '262200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1502', '寿光市', '370783', '370700', '262700', 'S', '3');
INSERT INTO `system_address` VALUES ('1503', '安丘市', '370784', '370700', '262100', 'A', '3');
INSERT INTO `system_address` VALUES ('1504', '高密市', '370785', '370700', '261500', 'G', '3');
INSERT INTO `system_address` VALUES ('1505', '昌邑市', '370786', '370700', '261300', 'C', '3');
INSERT INTO `system_address` VALUES ('1506', '济宁市', '370800', '370000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1507', '市中区', '370802', '370800', '272000', 'S', '3');
INSERT INTO `system_address` VALUES ('1508', '任城区', '370811', '370800', '272000', 'R', '3');
INSERT INTO `system_address` VALUES ('1509', '微山县', '370826', '370800', '277600', 'W', '3');
INSERT INTO `system_address` VALUES ('1510', '鱼台县', '370827', '370800', '272300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1511', '金乡县', '370828', '370800', '272200', 'J', '3');
INSERT INTO `system_address` VALUES ('1512', '嘉祥县', '370829', '370800', '272400', 'J', '3');
INSERT INTO `system_address` VALUES ('1513', '汶上县', '370830', '370800', '272500', 'W', '3');
INSERT INTO `system_address` VALUES ('1514', '泗水县', '370831', '370800', '273200', 'S', '3');
INSERT INTO `system_address` VALUES ('1515', '梁山县', '370832', '370800', '272600', 'L', '3');
INSERT INTO `system_address` VALUES ('1516', '曲阜市', '370881', '370800', '273100', 'Q', '3');
INSERT INTO `system_address` VALUES ('1517', '兖州区', '370882', '370800', '272100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1518', '邹城市', '370883', '370800', '273500', 'Z', '3');
INSERT INTO `system_address` VALUES ('1519', '泰安市', '370900', '370000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('1520', '泰山区', '370902', '370900', '271000', 'T', '3');
INSERT INTO `system_address` VALUES ('1521', '岱岳区', '370903', '370900', '271000', 'D', '3');
INSERT INTO `system_address` VALUES ('1522', '宁阳县', '370921', '370900', '271400', 'N', '3');
INSERT INTO `system_address` VALUES ('1523', '东平县', '370923', '370900', '271500', 'D', '3');
INSERT INTO `system_address` VALUES ('1524', '新泰市', '370982', '370900', '271200', 'X', '3');
INSERT INTO `system_address` VALUES ('1525', '肥城市', '370983', '370900', '271600', 'F', '3');
INSERT INTO `system_address` VALUES ('1526', '威海市', '371000', '370000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('1527', '环翠区', '371002', '371000', '264200', 'H', '3');
INSERT INTO `system_address` VALUES ('1528', '文登区', '371081', '371000', '264400', 'W', '3');
INSERT INTO `system_address` VALUES ('1529', '荣成市', '371082', '371000', '264300', 'R', '3');
INSERT INTO `system_address` VALUES ('1530', '乳山市', '371083', '371000', '264500', 'R', '3');
INSERT INTO `system_address` VALUES ('1531', '日照市', '371100', '370000', null, 'R', '2');
INSERT INTO `system_address` VALUES ('1532', '东港区', '371102', '371100', '276800', 'D', '3');
INSERT INTO `system_address` VALUES ('1533', '岚山区', '371103', '371100', '276800', 'L', '3');
INSERT INTO `system_address` VALUES ('1534', '五莲县', '371121', '371100', '262300', 'W', '3');
INSERT INTO `system_address` VALUES ('1535', '莒县', '371122', '371100', '276500', 'J', '3');
INSERT INTO `system_address` VALUES ('1536', '莱芜市', '371200', '370000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1537', '莱城区', '371202', '371200', '271100', 'L', '3');
INSERT INTO `system_address` VALUES ('1538', '钢城区', '371203', '371200', '271100', 'G', '3');
INSERT INTO `system_address` VALUES ('1539', '临沂市', '371300', '370000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1540', '兰山区', '371302', '371300', '276000', 'L', '3');
INSERT INTO `system_address` VALUES ('1541', '罗庄区', '371311', '371300', '276000', 'L', '3');
INSERT INTO `system_address` VALUES ('1542', '河东区', '371312', '371300', '276000', 'H', '3');
INSERT INTO `system_address` VALUES ('1543', '沂南县', '371321', '371300', '276300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1544', '郯城县', '371322', '371300', '276100', 'T', '3');
INSERT INTO `system_address` VALUES ('1545', '沂水县', '371323', '371300', '276400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1546', '兰陵县', '371324', '371300', '277700', 'L', '3');
INSERT INTO `system_address` VALUES ('1547', '费县', '371325', '371300', '273400', 'F', '3');
INSERT INTO `system_address` VALUES ('1548', '平邑县', '371326', '371300', '273300', 'P', '3');
INSERT INTO `system_address` VALUES ('1549', '莒南县', '371327', '371300', '276600', 'J', '3');
INSERT INTO `system_address` VALUES ('1550', '蒙阴县', '371328', '371300', '276200', 'M', '3');
INSERT INTO `system_address` VALUES ('1551', '临沭县', '371329', '371300', '276700', 'L', '3');
INSERT INTO `system_address` VALUES ('1552', '德州市', '371400', '370000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('1553', '德城区', '371402', '371400', '253000', 'D', '3');
INSERT INTO `system_address` VALUES ('1554', '陵城区', '371421', '371400', '253500', 'L', '3');
INSERT INTO `system_address` VALUES ('1555', '宁津县', '371422', '371400', '253400', 'N', '3');
INSERT INTO `system_address` VALUES ('1556', '庆云县', '371423', '371400', '253700', 'Q', '3');
INSERT INTO `system_address` VALUES ('1557', '临邑县', '371424', '371400', '251500', 'L', '3');
INSERT INTO `system_address` VALUES ('1558', '齐河县', '371425', '371400', '251100', 'Q', '3');
INSERT INTO `system_address` VALUES ('1559', '平原县', '371426', '371400', '253100', 'P', '3');
INSERT INTO `system_address` VALUES ('1560', '夏津县', '371427', '371400', '253200', 'X', '3');
INSERT INTO `system_address` VALUES ('1561', '武城县', '371428', '371400', '253300', 'W', '3');
INSERT INTO `system_address` VALUES ('1562', '开发区', '371451', '371400', '253000', 'K', '3');
INSERT INTO `system_address` VALUES ('1563', '乐陵市', '371481', '371400', '253600', 'L', '3');
INSERT INTO `system_address` VALUES ('1564', '禹城市', '371482', '371400', '251200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1565', '聊城市', '371500', '370000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1566', '东昌府区', '371502', '371500', '252000', 'D', '3');
INSERT INTO `system_address` VALUES ('1567', '阳谷县', '371521', '371500', '252300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1568', '莘县', '371522', '371500', '252400', 'X', '3');
INSERT INTO `system_address` VALUES ('1569', '茌平县', '371523', '371500', '252100', 'C', '3');
INSERT INTO `system_address` VALUES ('1570', '东阿县', '371524', '371500', '252200', 'D', '3');
INSERT INTO `system_address` VALUES ('1571', '冠县', '371525', '371500', '252500', 'G', '3');
INSERT INTO `system_address` VALUES ('1572', '高唐县', '371526', '371500', '252800', 'G', '3');
INSERT INTO `system_address` VALUES ('1573', '临清市', '371581', '371500', '252600', 'L', '3');
INSERT INTO `system_address` VALUES ('1574', '滨州市', '371600', '370000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('1575', '滨城区', '371602', '371600', '256600', 'B', '3');
INSERT INTO `system_address` VALUES ('1576', '惠民县', '371621', '371600', '251700', 'H', '3');
INSERT INTO `system_address` VALUES ('1577', '阳信县', '371622', '371600', '251800', 'Y', '3');
INSERT INTO `system_address` VALUES ('1578', '无棣县', '371623', '371600', '251900', 'W', '3');
INSERT INTO `system_address` VALUES ('1579', '沾化区', '371624', '371600', '256800', 'Z', '3');
INSERT INTO `system_address` VALUES ('1580', '博兴县', '371625', '371600', '256500', 'B', '3');
INSERT INTO `system_address` VALUES ('1581', '邹平县', '371626', '371600', '256200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1582', '菏泽市', '371700', '370000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1583', '牡丹区', '371702', '371700', '274000', 'M', '3');
INSERT INTO `system_address` VALUES ('1584', '曹县', '371721', '371700', '274400', 'C', '3');
INSERT INTO `system_address` VALUES ('1585', '单县', '371722', '371700', '274300', 'D', '3');
INSERT INTO `system_address` VALUES ('1586', '成武县', '371723', '371700', '274200', 'C', '3');
INSERT INTO `system_address` VALUES ('1587', '巨野县', '371724', '371700', '274900', 'J', '3');
INSERT INTO `system_address` VALUES ('1588', '郓城县', '371725', '371700', '274700', 'Y', '3');
INSERT INTO `system_address` VALUES ('1589', '鄄城县', '371726', '371700', '274600', 'J', '3');
INSERT INTO `system_address` VALUES ('1590', '定陶县', '371727', '371700', '274100', 'D', '3');
INSERT INTO `system_address` VALUES ('1591', '东明县', '371728', '371700', '274500', 'D', '3');
INSERT INTO `system_address` VALUES ('1592', '河南', '410000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('1593', '郑州市', '410100', '410000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1594', '中原区', '410102', '410100', '450000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1595', '二七区', '410103', '410100', '450000', 'E', '3');
INSERT INTO `system_address` VALUES ('1596', '管城回族区', '410104', '410100', '450000', 'G', '3');
INSERT INTO `system_address` VALUES ('1597', '金水区', '410105', '410100', '450000', 'J', '3');
INSERT INTO `system_address` VALUES ('1598', '上街区', '410106', '410100', '450000', 'S', '3');
INSERT INTO `system_address` VALUES ('1599', '惠济区', '410108', '410100', '450000', 'H', '3');
INSERT INTO `system_address` VALUES ('1600', '中牟县', '410122', '410100', '451450', 'Z', '3');
INSERT INTO `system_address` VALUES ('1601', '巩义市', '410181', '410100', '451200', 'G', '3');
INSERT INTO `system_address` VALUES ('1602', '荥阳市', '410182', '410100', '450100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1603', '新密市', '410183', '410100', '452370', 'X', '3');
INSERT INTO `system_address` VALUES ('1604', '新郑市', '410184', '410100', '451100', 'X', '3');
INSERT INTO `system_address` VALUES ('1605', '登封市', '410185', '410100', '452470', 'D', '3');
INSERT INTO `system_address` VALUES ('1606', '郑东新区', '410186', '410100', '450046', 'Z', '3');
INSERT INTO `system_address` VALUES ('1607', '高新区', '410187', '410100', '450000', 'G', '3');
INSERT INTO `system_address` VALUES ('1608', '经济开发区', '410193', '410100', '450000', 'J', '3');
INSERT INTO `system_address` VALUES ('1609', '开封市', '410200', '410000', null, 'K', '2');
INSERT INTO `system_address` VALUES ('1610', '龙亭区', '410202', '410200', '475000', 'L', '3');
INSERT INTO `system_address` VALUES ('1611', '顺河回族区', '410203', '410200', '475000', 'S', '3');
INSERT INTO `system_address` VALUES ('1612', '鼓楼区', '410204', '410200', '475000', 'G', '3');
INSERT INTO `system_address` VALUES ('1613', '禹王台区', '410205', '410200', '475000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1614', '金明区', '410211', '410200', '475000', 'J', '3');
INSERT INTO `system_address` VALUES ('1615', '杞县', '410221', '410200', '475200', 'Q', '3');
INSERT INTO `system_address` VALUES ('1616', '通许县', '410222', '410200', '475400', 'T', '3');
INSERT INTO `system_address` VALUES ('1617', '尉氏县', '410223', '410200', '475500', 'W', '3');
INSERT INTO `system_address` VALUES ('1618', '祥符区', '410224', '410200', '475100', 'X', '3');
INSERT INTO `system_address` VALUES ('1619', '兰考县', '410225', '410200', '475300', 'L', '3');
INSERT INTO `system_address` VALUES ('1620', '洛阳市', '410300', '410000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1621', '老城区', '410302', '410300', '471000', 'L', '3');
INSERT INTO `system_address` VALUES ('1622', '西工区', '410303', '410300', '471000', 'X', '3');
INSERT INTO `system_address` VALUES ('1623', '瀍河回族区', '410304', '410300', '471000', 'C', '3');
INSERT INTO `system_address` VALUES ('1624', '涧西区', '410305', '410300', '471000', 'J', '3');
INSERT INTO `system_address` VALUES ('1625', '吉利区', '410306', '410300', '471000', 'J', '3');
INSERT INTO `system_address` VALUES ('1626', '洛龙区', '410307', '410300', '471000', 'L', '3');
INSERT INTO `system_address` VALUES ('1627', '孟津县', '410322', '410300', '471100', 'M', '3');
INSERT INTO `system_address` VALUES ('1628', '新安县', '410323', '410300', '471800', 'X', '3');
INSERT INTO `system_address` VALUES ('1629', '栾川县', '410324', '410300', '471500', 'L', '3');
INSERT INTO `system_address` VALUES ('1630', '嵩县', '410325', '410300', '471400', 'S', '3');
INSERT INTO `system_address` VALUES ('1631', '汝阳县', '410326', '410300', '471200', 'R', '3');
INSERT INTO `system_address` VALUES ('1632', '宜阳县', '410327', '410300', '471600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1633', '洛宁县', '410328', '410300', '471700', 'L', '3');
INSERT INTO `system_address` VALUES ('1634', '伊川县', '410329', '410300', '471300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1635', '偃师市', '410381', '410300', '471900', 'Y', '3');
INSERT INTO `system_address` VALUES ('1636', '平顶山市', '410400', '410000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('1637', '新华区', '410402', '410400', '467000', 'X', '3');
INSERT INTO `system_address` VALUES ('1638', '卫东区', '410403', '410400', '467000', 'W', '3');
INSERT INTO `system_address` VALUES ('1639', '石龙区', '410404', '410400', '467000', 'S', '3');
INSERT INTO `system_address` VALUES ('1640', '湛河区', '410411', '410400', '467000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1641', '宝丰县', '410421', '410400', '467400', 'B', '3');
INSERT INTO `system_address` VALUES ('1642', '叶县', '410422', '410400', '467200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1643', '鲁山县', '410423', '410400', '467300', 'L', '3');
INSERT INTO `system_address` VALUES ('1644', '郏县', '410425', '410400', '467100', 'J', '3');
INSERT INTO `system_address` VALUES ('1645', '舞钢市', '410481', '410400', '462500', 'W', '3');
INSERT INTO `system_address` VALUES ('1646', '汝州市', '410482', '410400', '467599', 'R', '3');
INSERT INTO `system_address` VALUES ('1647', '安阳市', '410500', '410000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('1648', '文峰区', '410502', '410500', '455000', 'W', '3');
INSERT INTO `system_address` VALUES ('1649', '北关区', '410503', '410500', '455000', 'B', '3');
INSERT INTO `system_address` VALUES ('1650', '殷都区', '410505', '410500', '455000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1651', '龙安区', '410506', '410500', '455000', 'L', '3');
INSERT INTO `system_address` VALUES ('1652', '安阳县', '410522', '410500', '455100', 'A', '3');
INSERT INTO `system_address` VALUES ('1653', '汤阴县', '410523', '410500', '456150', 'T', '3');
INSERT INTO `system_address` VALUES ('1654', '滑县', '410526', '410500', '456400', 'H', '3');
INSERT INTO `system_address` VALUES ('1655', '内黄县', '410527', '410500', '456300', 'N', '3');
INSERT INTO `system_address` VALUES ('1656', '林州市', '410581', '410500', '456500', 'L', '3');
INSERT INTO `system_address` VALUES ('1657', '鹤壁市', '410600', '410000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1658', '鹤山区', '410602', '410600', '458000', 'H', '3');
INSERT INTO `system_address` VALUES ('1659', '山城区', '410603', '410600', '458000', 'S', '3');
INSERT INTO `system_address` VALUES ('1660', '淇滨区', '410611', '410600', '458030', 'Q', '3');
INSERT INTO `system_address` VALUES ('1661', '浚县', '410621', '410600', '456250', 'J', '3');
INSERT INTO `system_address` VALUES ('1662', '淇县', '410622', '410600', '456750', 'Q', '3');
INSERT INTO `system_address` VALUES ('1663', '新乡市', '410700', '410000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1664', '红旗区', '410702', '410700', '453000', 'H', '3');
INSERT INTO `system_address` VALUES ('1665', '卫滨区', '410703', '410700', '453000', 'W', '3');
INSERT INTO `system_address` VALUES ('1666', '凤泉区', '410704', '410700', '453011', 'F', '3');
INSERT INTO `system_address` VALUES ('1667', '牧野区', '410711', '410700', '453002', 'M', '3');
INSERT INTO `system_address` VALUES ('1668', '新乡县', '410721', '410700', '453700', 'X', '3');
INSERT INTO `system_address` VALUES ('1669', '获嘉县', '410724', '410700', '453800', 'H', '3');
INSERT INTO `system_address` VALUES ('1670', '原阳县', '410725', '410700', '453500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1671', '延津县', '410726', '410700', '453200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1672', '封丘县', '410727', '410700', '453300', 'F', '3');
INSERT INTO `system_address` VALUES ('1673', '长垣县', '410728', '410700', '453400', 'Z', '3');
INSERT INTO `system_address` VALUES ('1674', '卫辉市', '410781', '410700', '453100', 'W', '3');
INSERT INTO `system_address` VALUES ('1675', '辉县市', '410782', '410700', '453600', 'H', '3');
INSERT INTO `system_address` VALUES ('1676', '焦作市', '410800', '410000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1677', '解放区', '410802', '410800', '454150', 'J', '3');
INSERT INTO `system_address` VALUES ('1678', '中站区', '410803', '410800', '454150', 'Z', '3');
INSERT INTO `system_address` VALUES ('1679', '马村区', '410804', '410800', '454150', 'M', '3');
INSERT INTO `system_address` VALUES ('1680', '山阳区', '410811', '410800', '454150', 'S', '3');
INSERT INTO `system_address` VALUES ('1681', '修武县', '410821', '410800', '454350', 'X', '3');
INSERT INTO `system_address` VALUES ('1682', '博爱县', '410822', '410800', '454450', 'B', '3');
INSERT INTO `system_address` VALUES ('1683', '武陟县', '410823', '410800', '454950', 'W', '3');
INSERT INTO `system_address` VALUES ('1684', '温县', '410825', '410800', '454850', 'W', '3');
INSERT INTO `system_address` VALUES ('1685', '沁阳市', '410882', '410800', '454550', 'Q', '3');
INSERT INTO `system_address` VALUES ('1686', '孟州市', '410883', '410800', '454750', 'M', '3');
INSERT INTO `system_address` VALUES ('1687', '濮阳市', '410900', '410000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('1688', '华龙区', '410902', '410900', '457001', 'H', '3');
INSERT INTO `system_address` VALUES ('1689', '清丰县', '410922', '410900', '457300', 'Q', '3');
INSERT INTO `system_address` VALUES ('1690', '南乐县', '410923', '410900', '457400', 'N', '3');
INSERT INTO `system_address` VALUES ('1691', '范县', '410926', '410900', '457500', 'F', '3');
INSERT INTO `system_address` VALUES ('1692', '台前县', '410927', '410900', '457600', 'T', '3');
INSERT INTO `system_address` VALUES ('1693', '濮阳县', '410928', '410900', '457100', 'P', '3');
INSERT INTO `system_address` VALUES ('1694', '许昌市', '411000', '410000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1695', '魏都区', '411002', '411000', '461000', 'W', '3');
INSERT INTO `system_address` VALUES ('1696', '许昌县', '411023', '411000', '461100', 'X', '3');
INSERT INTO `system_address` VALUES ('1697', '鄢陵县', '411024', '411000', '461200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1698', '襄城县', '411025', '411000', '452670', 'X', '3');
INSERT INTO `system_address` VALUES ('1699', '禹州市', '411081', '411000', '461670', 'Y', '3');
INSERT INTO `system_address` VALUES ('1700', '长葛市', '411082', '411000', '461500', 'Z', '3');
INSERT INTO `system_address` VALUES ('1701', '漯河市', '411100', '410000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('1702', '源汇区', '411102', '411100', '462000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1703', '郾城区', '411103', '411100', '462300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1704', '召陵区', '411104', '411100', '462300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1705', '舞阳县', '411121', '411100', '462400', 'W', '3');
INSERT INTO `system_address` VALUES ('1706', '临颍县', '411122', '411100', '462600', 'L', '3');
INSERT INTO `system_address` VALUES ('1707', '三门峡市', '411200', '410000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1708', '湖滨区', '411202', '411200', '472000', 'H', '3');
INSERT INTO `system_address` VALUES ('1709', '渑池县', '411221', '411200', '472400', 'M', '3');
INSERT INTO `system_address` VALUES ('1710', '陕州区', '411222', '411200', '472100', 'S', '3');
INSERT INTO `system_address` VALUES ('1711', '卢氏县', '411224', '411200', '472200', 'L', '3');
INSERT INTO `system_address` VALUES ('1712', '义马市', '411281', '411200', '472300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1713', '灵宝市', '411282', '411200', '472500', 'L', '3');
INSERT INTO `system_address` VALUES ('1714', '南阳市', '411300', '410000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('1715', '宛城区', '411302', '411300', '473000', 'W', '3');
INSERT INTO `system_address` VALUES ('1716', '卧龙区', '411303', '411300', '473000', 'W', '3');
INSERT INTO `system_address` VALUES ('1717', '南召县', '411321', '411300', '474650', 'N', '3');
INSERT INTO `system_address` VALUES ('1718', '方城县', '411322', '411300', '473200', 'F', '3');
INSERT INTO `system_address` VALUES ('1719', '西峡县', '411323', '411300', '474550', 'X', '3');
INSERT INTO `system_address` VALUES ('1720', '镇平县', '411324', '411300', '474250', 'Z', '3');
INSERT INTO `system_address` VALUES ('1721', '内乡县', '411325', '411300', '474350', 'N', '3');
INSERT INTO `system_address` VALUES ('1722', '淅川县', '411326', '411300', '474450', 'X', '3');
INSERT INTO `system_address` VALUES ('1723', '社旗县', '411327', '411300', '473300', 'S', '3');
INSERT INTO `system_address` VALUES ('1724', '唐河县', '411328', '411300', '473400', 'T', '3');
INSERT INTO `system_address` VALUES ('1725', '新野县', '411329', '411300', '473500', 'X', '3');
INSERT INTO `system_address` VALUES ('1726', '桐柏县', '411330', '411300', '474750', 'T', '3');
INSERT INTO `system_address` VALUES ('1727', '邓州市', '411381', '411300', '474150', 'D', '3');
INSERT INTO `system_address` VALUES ('1728', '商丘市', '411400', '410000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1729', '梁园区', '411402', '411400', '476000', 'L', '3');
INSERT INTO `system_address` VALUES ('1730', '睢阳区', '411403', '411400', '476000', 'S', '3');
INSERT INTO `system_address` VALUES ('1731', '民权县', '411421', '411400', '476800', 'M', '3');
INSERT INTO `system_address` VALUES ('1732', '睢县', '411422', '411400', '476900', 'S', '3');
INSERT INTO `system_address` VALUES ('1733', '宁陵县', '411423', '411400', '476700', 'N', '3');
INSERT INTO `system_address` VALUES ('1734', '柘城县', '411424', '411400', '476200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1735', '虞城县', '411425', '411400', '476300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1736', '夏邑县', '411426', '411400', '476400', 'X', '3');
INSERT INTO `system_address` VALUES ('1737', '永城市', '411481', '411400', '476600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1738', '信阳市', '411500', '410000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1739', '浉河区', '411502', '411500', '464000', 'S', '3');
INSERT INTO `system_address` VALUES ('1740', '平桥区', '411503', '411500', '464000', 'P', '3');
INSERT INTO `system_address` VALUES ('1741', '罗山县', '411521', '411500', '464200', 'L', '3');
INSERT INTO `system_address` VALUES ('1742', '光山县', '411522', '411500', '465450', 'G', '3');
INSERT INTO `system_address` VALUES ('1743', '新县', '411523', '411500', '465550', 'X', '3');
INSERT INTO `system_address` VALUES ('1744', '商城县', '411524', '411500', '465350', 'S', '3');
INSERT INTO `system_address` VALUES ('1745', '固始县', '411525', '411500', '465200', 'G', '3');
INSERT INTO `system_address` VALUES ('1746', '潢川县', '411526', '411500', '465150', 'H', '3');
INSERT INTO `system_address` VALUES ('1747', '淮滨县', '411527', '411500', '464400', 'H', '3');
INSERT INTO `system_address` VALUES ('1748', '息县', '411528', '411500', '464300', 'X', '3');
INSERT INTO `system_address` VALUES ('1749', '周口市', '411600', '410000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1750', '川汇区', '411602', '411600', '466000', 'C', '3');
INSERT INTO `system_address` VALUES ('1751', '扶沟县', '411621', '411600', '461300', 'F', '3');
INSERT INTO `system_address` VALUES ('1752', '西华县', '411622', '411600', '466600', 'X', '3');
INSERT INTO `system_address` VALUES ('1753', '商水县', '411623', '411600', '466100', 'S', '3');
INSERT INTO `system_address` VALUES ('1754', '沈丘县', '411624', '411600', '466300', 'S', '3');
INSERT INTO `system_address` VALUES ('1755', '郸城县', '411625', '411600', '477150', 'D', '3');
INSERT INTO `system_address` VALUES ('1756', '淮阳县', '411626', '411600', '466700', 'H', '3');
INSERT INTO `system_address` VALUES ('1757', '太康县', '411627', '411600', '475400', 'T', '3');
INSERT INTO `system_address` VALUES ('1758', '鹿邑县', '411628', '411600', '477200', 'L', '3');
INSERT INTO `system_address` VALUES ('1759', '项城市', '411681', '411600', '466200', 'X', '3');
INSERT INTO `system_address` VALUES ('1760', '驻马店市', '411700', '410000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1761', '驿城区', '411702', '411700', '463000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1762', '西平县', '411721', '411700', '463600', 'X', '3');
INSERT INTO `system_address` VALUES ('1763', '上蔡县', '411722', '411700', '463800', 'S', '3');
INSERT INTO `system_address` VALUES ('1764', '平舆县', '411723', '411700', '463400', 'P', '3');
INSERT INTO `system_address` VALUES ('1765', '正阳县', '411724', '411700', '463900', 'Z', '3');
INSERT INTO `system_address` VALUES ('1766', '确山县', '411725', '411700', '463200', 'Q', '3');
INSERT INTO `system_address` VALUES ('1767', '泌阳县', '411726', '411700', '463700', 'M', '3');
INSERT INTO `system_address` VALUES ('1768', '汝南县', '411727', '411700', '463300', 'R', '3');
INSERT INTO `system_address` VALUES ('1769', '遂平县', '411728', '411700', '463100', 'S', '3');
INSERT INTO `system_address` VALUES ('1770', '新蔡县', '411729', '411700', '463500', 'X', '3');
INSERT INTO `system_address` VALUES ('1771', '省直辖县', '419000', '410000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1772', '湖北', '420000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('1773', '武汉市', '420100', '420000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('1774', '江岸区', '420102', '420100', '430014', 'J', '3');
INSERT INTO `system_address` VALUES ('1775', '江汉区', '420103', '420100', '430000', 'J', '3');
INSERT INTO `system_address` VALUES ('1776', '硚口区', '420104', '420100', '430000', 'Q', '3');
INSERT INTO `system_address` VALUES ('1777', '汉阳区', '420105', '420100', '430050', 'H', '3');
INSERT INTO `system_address` VALUES ('1778', '武昌区', '420106', '420100', '430000', 'W', '3');
INSERT INTO `system_address` VALUES ('1779', '青山区', '420107', '420100', '430080', 'Q', '3');
INSERT INTO `system_address` VALUES ('1780', '洪山区', '420111', '420100', '430070', 'H', '3');
INSERT INTO `system_address` VALUES ('1781', '东西湖区', '420112', '420100', '430040', 'D', '3');
INSERT INTO `system_address` VALUES ('1782', '汉南区', '420113', '420100', '430090', 'H', '3');
INSERT INTO `system_address` VALUES ('1783', '蔡甸区', '420114', '420100', '430100', 'C', '3');
INSERT INTO `system_address` VALUES ('1784', '江夏区', '420115', '420100', '430200', 'J', '3');
INSERT INTO `system_address` VALUES ('1785', '黄陂区', '420116', '420100', '432200', 'H', '3');
INSERT INTO `system_address` VALUES ('1786', '新洲区', '420117', '420100', '431400', 'X', '3');
INSERT INTO `system_address` VALUES ('1787', '武汉经济技术开发区', '420199', '420100', '430000', 'W', '3');
INSERT INTO `system_address` VALUES ('1788', '黄石市', '420200', '420000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1789', '黄石港区', '420202', '420200', '435000', 'H', '3');
INSERT INTO `system_address` VALUES ('1790', '西塞山区', '420203', '420200', '435000', 'X', '3');
INSERT INTO `system_address` VALUES ('1791', '下陆区', '420204', '420200', '435000', 'X', '3');
INSERT INTO `system_address` VALUES ('1792', '铁山区', '420205', '420200', '435000', 'T', '3');
INSERT INTO `system_address` VALUES ('1793', '阳新县', '420222', '420200', '435200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1794', '大冶市', '420281', '420200', '435100', 'D', '3');
INSERT INTO `system_address` VALUES ('1795', '十堰市', '420300', '420000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1796', '茅箭区', '420302', '420300', '442000', 'M', '3');
INSERT INTO `system_address` VALUES ('1797', '张湾区', '420303', '420300', '442000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1798', '郧阳区', '420321', '420300', '442500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1799', '郧西县', '420322', '420300', '442600', 'Y', '3');
INSERT INTO `system_address` VALUES ('1800', '竹山县', '420323', '420300', '442200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1801', '竹溪县', '420324', '420300', '442300', 'Z', '3');
INSERT INTO `system_address` VALUES ('1802', '房县', '420325', '420300', '442100', 'F', '3');
INSERT INTO `system_address` VALUES ('1803', '丹江口市', '420381', '420300', '442700', 'D', '3');
INSERT INTO `system_address` VALUES ('1804', '城区', '420382', '420300', '442000', 'C', '3');
INSERT INTO `system_address` VALUES ('1805', '宜昌市', '420500', '420000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1806', '西陵区', '420502', '420500', '443000', 'X', '3');
INSERT INTO `system_address` VALUES ('1807', '伍家岗区', '420503', '420500', '443000', 'W', '3');
INSERT INTO `system_address` VALUES ('1808', '点军区', '420504', '420500', '443000', 'D', '3');
INSERT INTO `system_address` VALUES ('1809', '猇亭区', '420505', '420500', '443007', 'Y', '3');
INSERT INTO `system_address` VALUES ('1810', '夷陵区', '420506', '420500', '443100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1811', '远安县', '420525', '420500', '444200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1812', '兴山县', '420526', '420500', '443700', 'X', '3');
INSERT INTO `system_address` VALUES ('1813', '秭归县', '420527', '420500', '443600', 'Z', '3');
INSERT INTO `system_address` VALUES ('1814', '长阳土家族自治县', '420528', '420500', '443500', 'Z', '3');
INSERT INTO `system_address` VALUES ('1815', '五峰土家族自治县', '420529', '420500', '443400', 'W', '3');
INSERT INTO `system_address` VALUES ('1816', '葛洲坝区', '420551', '420500', '443003', 'G', '3');
INSERT INTO `system_address` VALUES ('1817', '开发区', '420552', '420500', '443000', 'K', '3');
INSERT INTO `system_address` VALUES ('1818', '宜都市', '420581', '420500', '443000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1819', '当阳市', '420582', '420500', '444100', 'D', '3');
INSERT INTO `system_address` VALUES ('1820', '枝江市', '420583', '420500', '443200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1821', '襄阳市', '420600', '420000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1822', '襄城区', '420602', '420600', '441000', 'X', '3');
INSERT INTO `system_address` VALUES ('1823', '樊城区', '420606', '420600', '441000', 'F', '3');
INSERT INTO `system_address` VALUES ('1824', '襄州区', '420607', '420600', '441100', 'X', '3');
INSERT INTO `system_address` VALUES ('1825', '南漳县', '420624', '420600', '441500', 'N', '3');
INSERT INTO `system_address` VALUES ('1826', '谷城县', '420625', '420600', '441700', 'G', '3');
INSERT INTO `system_address` VALUES ('1827', '保康县', '420626', '420600', '441600', 'B', '3');
INSERT INTO `system_address` VALUES ('1828', '老河口市', '420682', '420600', '441800', 'L', '3');
INSERT INTO `system_address` VALUES ('1829', '枣阳市', '420683', '420600', '441200', 'Z', '3');
INSERT INTO `system_address` VALUES ('1830', '宜城市', '420684', '420600', '441400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1831', '鄂州市', '420700', '420000', null, 'E', '2');
INSERT INTO `system_address` VALUES ('1832', '梁子湖区', '420702', '420700', '436000', 'L', '3');
INSERT INTO `system_address` VALUES ('1833', '华容区', '420703', '420700', '436000', 'H', '3');
INSERT INTO `system_address` VALUES ('1834', '鄂城区', '420704', '420700', '436000', 'E', '3');
INSERT INTO `system_address` VALUES ('1835', '荆门市', '420800', '420000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1836', '东宝区', '420802', '420800', '448000', 'D', '3');
INSERT INTO `system_address` VALUES ('1837', '掇刀区', '420804', '420800', '448000', 'D', '3');
INSERT INTO `system_address` VALUES ('1838', '京山县', '420821', '420800', '431800', 'J', '3');
INSERT INTO `system_address` VALUES ('1839', '沙洋县', '420822', '420800', '448200', 'S', '3');
INSERT INTO `system_address` VALUES ('1840', '钟祥市', '420881', '420800', '431900', 'Z', '3');
INSERT INTO `system_address` VALUES ('1841', '孝感市', '420900', '420000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1842', '孝南区', '420902', '420900', '432100', 'X', '3');
INSERT INTO `system_address` VALUES ('1843', '孝昌县', '420921', '420900', '432900', 'X', '3');
INSERT INTO `system_address` VALUES ('1844', '大悟县', '420922', '420900', '432800', 'D', '3');
INSERT INTO `system_address` VALUES ('1845', '云梦县', '420923', '420900', '432500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1846', '应城市', '420981', '420900', '432400', 'Y', '3');
INSERT INTO `system_address` VALUES ('1847', '安陆市', '420982', '420900', '432600', 'A', '3');
INSERT INTO `system_address` VALUES ('1848', '汉川市', '420984', '420900', '432300', 'H', '3');
INSERT INTO `system_address` VALUES ('1849', '荆州市', '421000', '420000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('1850', '沙市区', '421002', '421000', '434000', 'S', '3');
INSERT INTO `system_address` VALUES ('1851', '荆州区', '421003', '421000', '434020', 'J', '3');
INSERT INTO `system_address` VALUES ('1852', '公安县', '421022', '421000', '434300', 'G', '3');
INSERT INTO `system_address` VALUES ('1853', '监利县', '421023', '421000', '433300', 'J', '3');
INSERT INTO `system_address` VALUES ('1854', '江陵县', '421024', '421000', '434100', 'J', '3');
INSERT INTO `system_address` VALUES ('1855', '石首市', '421081', '421000', '434400', 'S', '3');
INSERT INTO `system_address` VALUES ('1856', '洪湖市', '421083', '421000', '433200', 'H', '3');
INSERT INTO `system_address` VALUES ('1857', '松滋市', '421087', '421000', '434200', 'S', '3');
INSERT INTO `system_address` VALUES ('1858', '黄冈市', '421100', '420000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1859', '黄州区', '421102', '421100', '438000', 'H', '3');
INSERT INTO `system_address` VALUES ('1860', '团风县', '421121', '421100', '438000', 'T', '3');
INSERT INTO `system_address` VALUES ('1861', '红安县', '421122', '421100', '438400', 'H', '3');
INSERT INTO `system_address` VALUES ('1862', '罗田县', '421123', '421100', '438600', 'L', '3');
INSERT INTO `system_address` VALUES ('1863', '英山县', '421124', '421100', '438700', 'Y', '3');
INSERT INTO `system_address` VALUES ('1864', '浠水县', '421125', '421100', '438200', 'X', '3');
INSERT INTO `system_address` VALUES ('1865', '蕲春县', '421126', '421100', '435300', 'Q', '3');
INSERT INTO `system_address` VALUES ('1866', '黄梅县', '421127', '421100', '435500', 'H', '3');
INSERT INTO `system_address` VALUES ('1867', '麻城市', '421181', '421100', '438300', 'M', '3');
INSERT INTO `system_address` VALUES ('1868', '武穴市', '421182', '421100', '435400', 'W', '3');
INSERT INTO `system_address` VALUES ('1869', '咸宁市', '421200', '420000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1870', '咸安区', '421202', '421200', '437000', 'X', '3');
INSERT INTO `system_address` VALUES ('1871', '嘉鱼县', '421221', '421200', '437200', 'J', '3');
INSERT INTO `system_address` VALUES ('1872', '通城县', '421222', '421200', '437400', 'T', '3');
INSERT INTO `system_address` VALUES ('1873', '崇阳县', '421223', '421200', '437500', 'C', '3');
INSERT INTO `system_address` VALUES ('1874', '通山县', '421224', '421200', '437600', 'T', '3');
INSERT INTO `system_address` VALUES ('1875', '赤壁市', '421281', '421200', '437300', 'C', '3');
INSERT INTO `system_address` VALUES ('1876', '温泉城区', '421282', '421200', '437000', 'W', '3');
INSERT INTO `system_address` VALUES ('1877', '随州市', '421300', '420000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1878', '曾都区', '421303', '421300', '441300', 'C', '3');
INSERT INTO `system_address` VALUES ('1879', '随县', '421321', '421300', '431500', 'S', '3');
INSERT INTO `system_address` VALUES ('1880', '广水市', '421381', '421300', '432700', 'G', '3');
INSERT INTO `system_address` VALUES ('1881', '恩施土家族苗族自治州', '422800', '420000', null, 'E', '2');
INSERT INTO `system_address` VALUES ('1882', '恩施市', '422801', '422800', '445000', 'E', '3');
INSERT INTO `system_address` VALUES ('1883', '利川市', '422802', '422800', '445400', 'L', '3');
INSERT INTO `system_address` VALUES ('1884', '建始县', '422822', '422800', '445300', 'J', '3');
INSERT INTO `system_address` VALUES ('1885', '巴东县', '422823', '422800', '444300', 'B', '3');
INSERT INTO `system_address` VALUES ('1886', '宣恩县', '422825', '422800', '445500', 'X', '3');
INSERT INTO `system_address` VALUES ('1887', '咸丰县', '422826', '422800', '445600', 'X', '3');
INSERT INTO `system_address` VALUES ('1888', '来凤县', '422827', '422800', '445700', 'L', '3');
INSERT INTO `system_address` VALUES ('1889', '鹤峰县', '422828', '422800', '445800', 'H', '3');
INSERT INTO `system_address` VALUES ('1890', '仙桃市', '422900', '429000', '433000', 'X', '3');
INSERT INTO `system_address` VALUES ('1891', '潜江市', '429005', '429000', '433100', 'Q', '3');
INSERT INTO `system_address` VALUES ('1892', '天门市', '429006', '429000', '431700', 'T', '3');
INSERT INTO `system_address` VALUES ('1893', '神农架林区', '429021', '429000', '442400', 'S', '3');
INSERT INTO `system_address` VALUES ('1894', '湖南', '430000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('1895', '长沙市', '430100', '430000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1896', '芙蓉区', '430102', '430100', '410000', 'F', '3');
INSERT INTO `system_address` VALUES ('1897', '天心区', '430103', '430100', '410000', 'T', '3');
INSERT INTO `system_address` VALUES ('1898', '岳麓区', '430104', '430100', '410000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1899', '开福区', '430105', '430100', '410000', 'K', '3');
INSERT INTO `system_address` VALUES ('1900', '雨花区', '430111', '430100', '410000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1901', '长沙县', '430121', '430100', '410100', 'Z', '3');
INSERT INTO `system_address` VALUES ('1902', '望城区', '430122', '430100', '410200', 'W', '3');
INSERT INTO `system_address` VALUES ('1903', '宁乡县', '430124', '430100', '410600', 'N', '3');
INSERT INTO `system_address` VALUES ('1904', '浏阳市', '430181', '430100', '410300', 'L', '3');
INSERT INTO `system_address` VALUES ('1905', '株洲市', '430200', '430000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1906', '荷塘区', '430202', '430200', '412000', 'H', '3');
INSERT INTO `system_address` VALUES ('1907', '芦淞区', '430203', '430200', '412000', 'L', '3');
INSERT INTO `system_address` VALUES ('1908', '石峰区', '430204', '430200', '412000', 'S', '3');
INSERT INTO `system_address` VALUES ('1909', '天元区', '430211', '430200', '412000', 'T', '3');
INSERT INTO `system_address` VALUES ('1910', '株洲县', '430221', '430200', '412000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1911', '攸县', '430223', '430200', '412300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1912', '茶陵县', '430224', '430200', '412400', 'C', '3');
INSERT INTO `system_address` VALUES ('1913', '炎陵县', '430225', '430200', '412500', 'Y', '3');
INSERT INTO `system_address` VALUES ('1914', '醴陵市', '430281', '430200', '412200', 'L', '3');
INSERT INTO `system_address` VALUES ('1915', '湘潭市', '430300', '430000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('1916', '雨湖区', '430302', '430300', '411100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1917', '岳塘区', '430304', '430300', '411100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1918', '湘潭县', '430321', '430300', '411200', 'X', '3');
INSERT INTO `system_address` VALUES ('1919', '湘乡市', '430381', '430300', '411400', 'X', '3');
INSERT INTO `system_address` VALUES ('1920', '韶山市', '430382', '430300', '411300', 'S', '3');
INSERT INTO `system_address` VALUES ('1921', '衡阳市', '430400', '430000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('1922', '珠晖区', '430405', '430400', '421000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1923', '雁峰区', '430406', '430400', '421000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1924', '石鼓区', '430407', '430400', '421000', 'S', '3');
INSERT INTO `system_address` VALUES ('1925', '蒸湘区', '430408', '430400', '421000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1926', '南岳区', '430412', '430400', '421000', 'N', '3');
INSERT INTO `system_address` VALUES ('1927', '衡阳县', '430421', '430400', '421200', 'H', '3');
INSERT INTO `system_address` VALUES ('1928', '衡南县', '430422', '430400', '421100', 'H', '3');
INSERT INTO `system_address` VALUES ('1929', '衡山县', '430423', '430400', '421300', 'H', '3');
INSERT INTO `system_address` VALUES ('1930', '衡东县', '430424', '430400', '421400', 'H', '3');
INSERT INTO `system_address` VALUES ('1931', '祁东县', '430426', '430400', '421600', 'Q', '3');
INSERT INTO `system_address` VALUES ('1932', '耒阳市', '430481', '430400', '421800', 'L', '3');
INSERT INTO `system_address` VALUES ('1933', '常宁市', '430482', '430400', '421500', 'C', '3');
INSERT INTO `system_address` VALUES ('1934', '邵阳市', '430500', '430000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('1935', '双清区', '430502', '430500', '422000	', 'S', '3');
INSERT INTO `system_address` VALUES ('1936', '大祥区', '430503', '430500', '422000	', 'D', '3');
INSERT INTO `system_address` VALUES ('1937', '北塔区', '430511', '430500', '422000	', 'B', '3');
INSERT INTO `system_address` VALUES ('1938', '邵东县', '430521', '430500', '422800', 'S', '3');
INSERT INTO `system_address` VALUES ('1939', '新邵县', '430522', '430500', '422900', 'X', '3');
INSERT INTO `system_address` VALUES ('1940', '邵阳县', '430523', '430500', '422100', 'S', '3');
INSERT INTO `system_address` VALUES ('1941', '隆回县', '430524', '430500', '422200', 'L', '3');
INSERT INTO `system_address` VALUES ('1942', '洞口县', '430525', '430500', '422300', 'D', '3');
INSERT INTO `system_address` VALUES ('1943', '绥宁县', '430527', '430500', '422600', 'S', '3');
INSERT INTO `system_address` VALUES ('1944', '新宁县', '430528', '430500', '422700', 'X', '3');
INSERT INTO `system_address` VALUES ('1945', '城步苗族自治县', '430529', '430500', '422500', 'C', '3');
INSERT INTO `system_address` VALUES ('1946', '武冈市', '430581', '430500', '422400', 'W', '3');
INSERT INTO `system_address` VALUES ('1947', '岳阳市', '430600', '430000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1948', '岳阳楼区', '430602', '430600', '414000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1949', '云溪区', '430603', '430600', '414000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1950', '君山区', '430611', '430600', '414000', 'J', '3');
INSERT INTO `system_address` VALUES ('1951', '岳阳县', '430621', '430600', '414000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1952', '华容县', '430623', '430600', '414200', 'H', '3');
INSERT INTO `system_address` VALUES ('1953', '湘阴县', '430624', '430600', '410500', 'X', '3');
INSERT INTO `system_address` VALUES ('1954', '平江县', '430626', '430600', '410400', 'P', '3');
INSERT INTO `system_address` VALUES ('1955', '汨罗市', '430681', '430600', '414400', 'M', '3');
INSERT INTO `system_address` VALUES ('1956', '临湘市', '430682', '430600', '414300', 'L', '3');
INSERT INTO `system_address` VALUES ('1957', '常德市', '430700', '430000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('1958', '武陵区', '430702', '430700', '415000', 'W', '3');
INSERT INTO `system_address` VALUES ('1959', '鼎城区', '430703', '430700', '415100', 'D', '3');
INSERT INTO `system_address` VALUES ('1960', '安乡县', '430721', '430700', '415600', 'A', '3');
INSERT INTO `system_address` VALUES ('1961', '汉寿县', '430722', '430700', '415900', 'H', '3');
INSERT INTO `system_address` VALUES ('1962', '澧县', '430723', '430700', '415500', 'L', '3');
INSERT INTO `system_address` VALUES ('1963', '临澧县', '430724', '430700', '415200', 'L', '3');
INSERT INTO `system_address` VALUES ('1964', '桃源县', '430725', '430700', '415700', 'T', '3');
INSERT INTO `system_address` VALUES ('1965', '石门县', '430726', '430700', '415300', 'S', '3');
INSERT INTO `system_address` VALUES ('1966', '津市市', '430781', '430700', '415400', 'J', '3');
INSERT INTO `system_address` VALUES ('1967', '张家界市', '430800', '430000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('1968', '永定区', '430802', '430800', '427000', 'Y', '3');
INSERT INTO `system_address` VALUES ('1969', '武陵源区', '430811', '430800', '427400', 'W', '3');
INSERT INTO `system_address` VALUES ('1970', '慈利县', '430821', '430800', '427200', 'C', '3');
INSERT INTO `system_address` VALUES ('1971', '桑植县', '430822', '430800', '427100', 'S', '3');
INSERT INTO `system_address` VALUES ('1972', '益阳市', '430900', '430000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1973', '资阳区', '430902', '430900', '413000', 'Z', '3');
INSERT INTO `system_address` VALUES ('1974', '赫山区', '430903', '430900', '413000', 'H', '3');
INSERT INTO `system_address` VALUES ('1975', '南县', '430921', '430900', '413200', 'N', '3');
INSERT INTO `system_address` VALUES ('1976', '桃江县', '430922', '430900', '413400', 'T', '3');
INSERT INTO `system_address` VALUES ('1977', '安化县', '430923', '430900', '413500', 'A', '3');
INSERT INTO `system_address` VALUES ('1978', '沅江市', '430981', '430900', '413100', 'Y', '3');
INSERT INTO `system_address` VALUES ('1979', '郴州市', '431000', '430000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('1980', '北湖区', '431002', '431000', '423000', 'B', '3');
INSERT INTO `system_address` VALUES ('1981', '苏仙区', '431003', '431000', '423000', 'S', '3');
INSERT INTO `system_address` VALUES ('1982', '桂阳县', '431021', '431000', '424400', 'G', '3');
INSERT INTO `system_address` VALUES ('1983', '宜章县', '431022', '431000', '424200', 'Y', '3');
INSERT INTO `system_address` VALUES ('1984', '永兴县', '431023', '431000', '423300', 'Y', '3');
INSERT INTO `system_address` VALUES ('1985', '嘉禾县', '431024', '431000', '424500', 'J', '3');
INSERT INTO `system_address` VALUES ('1986', '临武县', '431025', '431000', '424300', 'L', '3');
INSERT INTO `system_address` VALUES ('1987', '汝城县', '431026', '431000', '424100', 'R', '3');
INSERT INTO `system_address` VALUES ('1988', '桂东县', '431027', '431000', '423500', 'G', '3');
INSERT INTO `system_address` VALUES ('1989', '安仁县', '431028', '431000', '423600', 'A', '3');
INSERT INTO `system_address` VALUES ('1990', '资兴市', '431081', '431000', '423400', 'Z', '3');
INSERT INTO `system_address` VALUES ('1991', '永州市', '431100', '430000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('1992', '零陵区', '431102', '431100', '425100', 'L', '3');
INSERT INTO `system_address` VALUES ('1993', '冷水滩区', '431103', '431100', '425000', 'L', '3');
INSERT INTO `system_address` VALUES ('1994', '祁阳县', '431121', '431100', '426100', 'Q', '3');
INSERT INTO `system_address` VALUES ('1995', '东安县', '431122', '431100', '425900', 'D', '3');
INSERT INTO `system_address` VALUES ('1996', '双牌县', '431123', '431100', '425200', 'S', '3');
INSERT INTO `system_address` VALUES ('1997', '道县', '431124', '431100', '425300', 'D', '3');
INSERT INTO `system_address` VALUES ('1998', '江永县', '431125', '431100', '425400', 'J', '3');
INSERT INTO `system_address` VALUES ('1999', '宁远县', '431126', '431100', '425600', 'N', '3');
INSERT INTO `system_address` VALUES ('2000', '蓝山县', '431127', '431100', '425800', 'L', '3');
INSERT INTO `system_address` VALUES ('2001', '新田县', '431128', '431100', '425700', 'X', '3');
INSERT INTO `system_address` VALUES ('2002', '江华瑶族自治县', '431129', '431100', '425500', 'J', '3');
INSERT INTO `system_address` VALUES ('2003', '怀化市', '431200', '430000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2004', '鹤城区', '431202', '431200', '418000', 'H', '3');
INSERT INTO `system_address` VALUES ('2005', '中方县', '431221', '431200', '418000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2006', '沅陵县', '431222', '431200', '419600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2007', '辰溪县', '431223', '431200', '419500', 'C', '3');
INSERT INTO `system_address` VALUES ('2008', '溆浦县', '431224', '431200', '419300', 'X', '3');
INSERT INTO `system_address` VALUES ('2009', '会同县', '431225', '431200', '418300', 'H', '3');
INSERT INTO `system_address` VALUES ('2010', '麻阳苗族自治县', '431226', '431200', '419400', 'M', '3');
INSERT INTO `system_address` VALUES ('2011', '新晃侗族自治县', '431227', '431200', '419200', 'X', '3');
INSERT INTO `system_address` VALUES ('2012', '芷江侗族自治县', '431228', '431200', '419100', 'Z', '3');
INSERT INTO `system_address` VALUES ('2013', '靖州苗族侗族自治县', '431229', '431200', '418400', 'J', '3');
INSERT INTO `system_address` VALUES ('2014', '通道侗族自治县', '431230', '431200', '418500	', 'T', '3');
INSERT INTO `system_address` VALUES ('2015', '洪江市', '431281', '431200', '418200', 'H', '3');
INSERT INTO `system_address` VALUES ('2016', '娄底市', '431300', '430000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2017', '娄星区', '431302', '431300', '417000', 'L', '3');
INSERT INTO `system_address` VALUES ('2018', '双峰县', '431321', '431300', '417700', 'S', '3');
INSERT INTO `system_address` VALUES ('2019', '新化县', '431322', '431300', '417600', 'X', '3');
INSERT INTO `system_address` VALUES ('2020', '冷水江市', '431381', '431300', '417500', 'L', '3');
INSERT INTO `system_address` VALUES ('2021', '涟源市', '431382', '431300', '417100', 'L', '3');
INSERT INTO `system_address` VALUES ('2022', '湘西土家族苗族自治州', '433100', '430000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('2023', '吉首市', '433101', '433100', '416000', 'J', '3');
INSERT INTO `system_address` VALUES ('2024', '泸溪县', '433122', '433100', '416100', 'L', '3');
INSERT INTO `system_address` VALUES ('2025', '凤凰县', '433123', '433100', '416200', 'F', '3');
INSERT INTO `system_address` VALUES ('2026', '花垣县', '433124', '433100', '416400', 'H', '3');
INSERT INTO `system_address` VALUES ('2027', '保靖县', '433125', '433100', '416500', 'B', '3');
INSERT INTO `system_address` VALUES ('2028', '古丈县', '433126', '433100', '416300', 'G', '3');
INSERT INTO `system_address` VALUES ('2029', '永顺县', '433127', '433100', '416700', 'Y', '3');
INSERT INTO `system_address` VALUES ('2030', '龙山县', '433130', '433100', '416800', 'L', '3');
INSERT INTO `system_address` VALUES ('2031', '广东', '440000', '0', null, 'G', '1');
INSERT INTO `system_address` VALUES ('2032', '广州市', '440100', '440000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2033', '荔湾区', '440103', '440100', '510000', 'L', '3');
INSERT INTO `system_address` VALUES ('2034', '越秀区', '440104', '440100', '510000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2035', '海珠区', '440105', '440100', '510000', 'H', '3');
INSERT INTO `system_address` VALUES ('2036', '天河区', '440106', '440100', '510000', 'T', '3');
INSERT INTO `system_address` VALUES ('2037', '白云区', '440111', '440100', '510000', 'B', '3');
INSERT INTO `system_address` VALUES ('2038', '黄埔区', '440112', '440100', '510700', 'H', '3');
INSERT INTO `system_address` VALUES ('2039', '番禺区', '440113', '440100', '511400', 'F', '3');
INSERT INTO `system_address` VALUES ('2040', '花都区', '440114', '440100', '510800', 'H', '3');
INSERT INTO `system_address` VALUES ('2041', '南沙区', '440115', '440100', '511400', 'N', '3');
INSERT INTO `system_address` VALUES ('2042', '萝岗区', '440116', '440100', '510000', 'L', '3');
INSERT INTO `system_address` VALUES ('2043', '增城区', '440118', '440100', '511300', 'Z', '3');
INSERT INTO `system_address` VALUES ('2044', '从化区', '440184', '440100', '510900', 'C', '3');
INSERT INTO `system_address` VALUES ('2045', '东山区', '440188', '440100', '510080', 'D', '3');
INSERT INTO `system_address` VALUES ('2046', '韶关市', '440200', '440000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2047', '武江区', '440203', '440200', '512000', 'W', '3');
INSERT INTO `system_address` VALUES ('2048', '浈江区', '440204', '440200', '512000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2049', '曲江区', '440205', '440200', '512100', 'Q', '3');
INSERT INTO `system_address` VALUES ('2050', '始兴县', '440222', '440200', '512500', 'S', '3');
INSERT INTO `system_address` VALUES ('2051', '仁化县', '440224', '440200', '512300', 'R', '3');
INSERT INTO `system_address` VALUES ('2052', '翁源县', '440229', '440200', '512600', 'W', '3');
INSERT INTO `system_address` VALUES ('2053', '乳源瑶族自治县', '440232', '440200', '512600', 'R', '3');
INSERT INTO `system_address` VALUES ('2054', '新丰县', '440233', '440200', '511100', 'X', '3');
INSERT INTO `system_address` VALUES ('2055', '乐昌市', '440281', '440200', '512200', 'L', '3');
INSERT INTO `system_address` VALUES ('2056', '南雄市', '440282', '440200', '512400', 'N', '3');
INSERT INTO `system_address` VALUES ('2057', '深圳市', '440300', '440000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2058', '罗湖区', '440303', '440300', '518000', 'L', '3');
INSERT INTO `system_address` VALUES ('2059', '福田区', '440304', '440300', '518000', 'F', '3');
INSERT INTO `system_address` VALUES ('2060', '南山区', '440305', '440300', '518000', 'N', '3');
INSERT INTO `system_address` VALUES ('2061', '宝安区', '440306', '440300', '518100', 'B', '3');
INSERT INTO `system_address` VALUES ('2062', '龙岗区', '440307', '440300', '518100', 'L', '3');
INSERT INTO `system_address` VALUES ('2063', '盐田区', '440308', '440300', '518000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2064', '光明新区', '440320', '440300', '518000', 'G', '3');
INSERT INTO `system_address` VALUES ('2065', '坪山新区', '440321', '440300', '518118', 'P', '3');
INSERT INTO `system_address` VALUES ('2066', '大鹏新区', '440322', '440300', '518116', 'D', '3');
INSERT INTO `system_address` VALUES ('2067', '龙华新区', '440323', '440300', '518110', 'L', '3');
INSERT INTO `system_address` VALUES ('2068', '珠海市', '440400', '440000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2069', '香洲区', '440402', '440400', '519000', 'X', '3');
INSERT INTO `system_address` VALUES ('2070', '斗门区', '440403', '440400', '519100', 'D', '3');
INSERT INTO `system_address` VALUES ('2071', '金湾区', '440404', '440400', '519090', 'J', '3');
INSERT INTO `system_address` VALUES ('2072', '金唐区', '440486', '440400', '519000', 'J', '3');
INSERT INTO `system_address` VALUES ('2073', '南湾区', '440487', '440400', '519000', 'N', '3');
INSERT INTO `system_address` VALUES ('2074', '汕头市', '440500', '440000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2075', '龙湖区', '440507', '440500', '515000', 'L', '3');
INSERT INTO `system_address` VALUES ('2076', '金平区', '440511', '440500', '515000', 'J', '3');
INSERT INTO `system_address` VALUES ('2077', '濠江区', '440512', '440500', '515000', 'H', '3');
INSERT INTO `system_address` VALUES ('2078', '潮阳区', '440513', '440500', '515100', 'C', '3');
INSERT INTO `system_address` VALUES ('2079', '潮南区', '440514', '440500', '515100', 'C', '3');
INSERT INTO `system_address` VALUES ('2080', '澄海区', '440515', '440500', '515800', 'C', '3');
INSERT INTO `system_address` VALUES ('2081', '南澳县', '440523', '440500', '515900', 'N', '3');
INSERT INTO `system_address` VALUES ('2082', '佛山市', '440600', '440000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('2083', '禅城区', '440604', '440600', '528000', 'S', '3');
INSERT INTO `system_address` VALUES ('2084', '南海区', '440605', '440600', '528200', 'N', '3');
INSERT INTO `system_address` VALUES ('2085', '顺德区', '440606', '440600', '528300', 'S', '3');
INSERT INTO `system_address` VALUES ('2086', '三水区', '440607', '440600', '528100', 'S', '3');
INSERT INTO `system_address` VALUES ('2087', '高明区', '440608', '440600', '528500', 'G', '3');
INSERT INTO `system_address` VALUES ('2088', '江门市', '440700', '440000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('2089', '蓬江区', '440703', '440700', '529000', 'P', '3');
INSERT INTO `system_address` VALUES ('2090', '江海区', '440704', '440700', '529000', 'J', '3');
INSERT INTO `system_address` VALUES ('2091', '新会区', '440705', '440700', '529100', 'X', '3');
INSERT INTO `system_address` VALUES ('2092', '台山市', '440781', '440700', '529200', 'T', '3');
INSERT INTO `system_address` VALUES ('2093', '开平市', '440783', '440700', '529300', 'K', '3');
INSERT INTO `system_address` VALUES ('2094', '鹤山市', '440784', '440700', '529700', 'H', '3');
INSERT INTO `system_address` VALUES ('2095', '恩平市', '440785', '440700', '529400', 'E', '3');
INSERT INTO `system_address` VALUES ('2096', '湛江市', '440800', '440000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2097', '赤坎区', '440802', '440800', '524033', 'C', '3');
INSERT INTO `system_address` VALUES ('2098', '霞山区', '440803', '440800', '524000', 'X', '3');
INSERT INTO `system_address` VALUES ('2099', '坡头区', '440804', '440800', '524000', 'P', '3');
INSERT INTO `system_address` VALUES ('2100', '麻章区', '440811', '440800', '524000', 'M', '3');
INSERT INTO `system_address` VALUES ('2101', '遂溪县', '440823', '440800', '524300', 'S', '3');
INSERT INTO `system_address` VALUES ('2102', '徐闻县', '440825', '440800', '524100', 'X', '3');
INSERT INTO `system_address` VALUES ('2103', '廉江市', '440881', '440800', '524400', 'L', '3');
INSERT INTO `system_address` VALUES ('2104', '雷州市', '440882', '440800', '524200', 'L', '3');
INSERT INTO `system_address` VALUES ('2105', '吴川市', '440883', '440800', '524500', 'W', '3');
INSERT INTO `system_address` VALUES ('2106', '茂名市', '440900', '440000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('2107', '茂南区', '440902', '440900', '525000', 'M', '3');
INSERT INTO `system_address` VALUES ('2108', '茂港区', '440903', '440900', '525000', 'M', '3');
INSERT INTO `system_address` VALUES ('2109', '电白区', '440923', '440900', '525400', 'D', '3');
INSERT INTO `system_address` VALUES ('2110', '高州市', '440981', '440900', '525200', 'G', '3');
INSERT INTO `system_address` VALUES ('2111', '化州市', '440982', '440900', '525100', 'H', '3');
INSERT INTO `system_address` VALUES ('2112', '信宜市', '440983', '440900', '525300', 'X', '3');
INSERT INTO `system_address` VALUES ('2113', '肇庆市', '441200', '440000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2114', '端州区', '441202', '441200', '526000', 'D', '3');
INSERT INTO `system_address` VALUES ('2115', '鼎湖区', '441203', '441200', '526000', 'D', '3');
INSERT INTO `system_address` VALUES ('2116', '广宁县', '441223', '441200', '526300', 'G', '3');
INSERT INTO `system_address` VALUES ('2117', '怀集县', '441224', '441200', '526400', 'H', '3');
INSERT INTO `system_address` VALUES ('2118', '封开县', '441225', '441200', '526500', 'F', '3');
INSERT INTO `system_address` VALUES ('2119', '德庆县', '441226', '441200', '526600', 'D', '3');
INSERT INTO `system_address` VALUES ('2120', '高要区', '441283', '441200', '526100', 'G', '3');
INSERT INTO `system_address` VALUES ('2121', '四会市', '441284', '441200', '526200', 'S', '3');
INSERT INTO `system_address` VALUES ('2122', '惠州市', '441300', '440000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2123', '惠城区', '441302', '441300', '516000', 'H', '3');
INSERT INTO `system_address` VALUES ('2124', '惠阳区', '441303', '441300', '516200', 'H', '3');
INSERT INTO `system_address` VALUES ('2125', '博罗县', '441322', '441300', '516100', 'B', '3');
INSERT INTO `system_address` VALUES ('2126', '惠东县', '441323', '441300', '516300', 'H', '3');
INSERT INTO `system_address` VALUES ('2127', '龙门县', '441324', '441300', '516800', 'L', '3');
INSERT INTO `system_address` VALUES ('2128', '大亚湾区', '441325', '441300', '516000', 'D', '3');
INSERT INTO `system_address` VALUES ('2129', '梅州市', '441400', '440000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('2130', '梅江区', '441402', '441400', '514000', 'M', '3');
INSERT INTO `system_address` VALUES ('2131', '梅县', '441421', '441400', '514700', 'M', '3');
INSERT INTO `system_address` VALUES ('2132', '大埔县', '441422', '441400', '514200', 'D', '3');
INSERT INTO `system_address` VALUES ('2133', '丰顺县', '441423', '441400', '514300', 'F', '3');
INSERT INTO `system_address` VALUES ('2134', '五华县', '441424', '441400', '514400', 'W', '3');
INSERT INTO `system_address` VALUES ('2135', '平远县', '441426', '441400', '514600', 'P', '3');
INSERT INTO `system_address` VALUES ('2136', '蕉岭县', '441427', '441400', '514100', 'J', '3');
INSERT INTO `system_address` VALUES ('2137', '兴宁市', '441481', '441400', '514500', 'X', '3');
INSERT INTO `system_address` VALUES ('2138', '汕尾市', '441500', '440000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2139', '城区', '441502', '441500', '516600', 'C', '3');
INSERT INTO `system_address` VALUES ('2140', '海丰县', '441521', '441500', '516400', 'H', '3');
INSERT INTO `system_address` VALUES ('2141', '陆河县', '441523', '441500', '516700', 'L', '3');
INSERT INTO `system_address` VALUES ('2142', '陆丰市', '441581', '441500', '516500', 'L', '3');
INSERT INTO `system_address` VALUES ('2143', '河源市', '441600', '440000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2144', '源城区', '441602', '441600', '517000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2145', '紫金县', '441621', '441600', '517400', 'Z', '3');
INSERT INTO `system_address` VALUES ('2146', '龙川县', '441622', '441600', '517300', 'L', '3');
INSERT INTO `system_address` VALUES ('2147', '连平县', '441623', '441600', '517100', 'L', '3');
INSERT INTO `system_address` VALUES ('2148', '和平县', '441624', '441600', '517200', 'H', '3');
INSERT INTO `system_address` VALUES ('2149', '东源县', '441625', '441600', '517500', 'D', '3');
INSERT INTO `system_address` VALUES ('2150', '阳江市', '441700', '440000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2151', '江城区', '441702', '441700', '529500', 'J', '3');
INSERT INTO `system_address` VALUES ('2152', '阳西县', '441721', '441700', '529800', 'Y', '3');
INSERT INTO `system_address` VALUES ('2153', '阳东区', '441723', '441700', '529900', 'Y', '3');
INSERT INTO `system_address` VALUES ('2154', '阳春市', '441781', '441700', '529600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2155', '清远市', '441800', '440000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2156', '清城区', '441802', '441800', '511500', 'Q', '3');
INSERT INTO `system_address` VALUES ('2157', '佛冈县', '441821', '441800', '511600', 'F', '3');
INSERT INTO `system_address` VALUES ('2158', '阳山县', '441823', '441800', '513100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2159', '连山壮族瑶族自治县', '441825', '441800', '513200', 'L', '3');
INSERT INTO `system_address` VALUES ('2160', '连南瑶族自治县', '441826', '441800', '513300', 'L', '3');
INSERT INTO `system_address` VALUES ('2161', '清新区', '441827', '441800', '511800', 'Q', '3');
INSERT INTO `system_address` VALUES ('2162', '英德市', '441881', '441800', '513000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2163', '连州市', '441882', '441800', '513400', 'L', '3');
INSERT INTO `system_address` VALUES ('2164', '东莞市', '441900', '440000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2165', '中山市', '442000', '440000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2166', '中山火炬开发区', '442002', '442000', '528437', 'Z', '3');
INSERT INTO `system_address` VALUES ('2167', '石岐区', '442003', '442000', '528400', 'S', '3');
INSERT INTO `system_address` VALUES ('2169', '潮州市', '445100', '440000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('2170', '湘桥区', '445102', '445100', '521000', 'X', '3');
INSERT INTO `system_address` VALUES ('2171', '潮安区', '445121', '445100', '515600', 'C', '3');
INSERT INTO `system_address` VALUES ('2172', '饶平县', '445122', '445100', '515700', 'R', '3');
INSERT INTO `system_address` VALUES ('2173', '枫溪区', '445185', '445100', '521000', 'F', '3');
INSERT INTO `system_address` VALUES ('2174', '揭阳市', '445200', '440000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('2175', '榕城区', '445202', '445200', '522000', 'R', '3');
INSERT INTO `system_address` VALUES ('2176', '揭东区', '445221', '445200', '515500', 'J', '3');
INSERT INTO `system_address` VALUES ('2177', '揭西县', '445222', '445200', '515400', 'J', '3');
INSERT INTO `system_address` VALUES ('2178', '惠来县', '445224', '445200', '515200', 'H', '3');
INSERT INTO `system_address` VALUES ('2179', '普宁市', '445281', '445200', '515300', 'P', '3');
INSERT INTO `system_address` VALUES ('2180', '东山区', '445284', '445200', '510080', 'D', '3');
INSERT INTO `system_address` VALUES ('2181', '云浮市', '445300', '440000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2182', '云城区', '445302', '445300', '527300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2183', '新兴县', '445321', '445300', '527400', 'X', '3');
INSERT INTO `system_address` VALUES ('2184', '郁南县', '445322', '445300', '527100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2185', '云安区', '445323', '445300', '527500', 'Y', '3');
INSERT INTO `system_address` VALUES ('2186', '罗定市', '445381', '445300', '527200', 'L', '3');
INSERT INTO `system_address` VALUES ('2187', '广西', '450000', '0', null, 'G', '1');
INSERT INTO `system_address` VALUES ('2188', '南宁市', '450100', '450000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('2189', '兴宁区', '450102', '450100', '530000', 'X', '3');
INSERT INTO `system_address` VALUES ('2190', '青秀区', '450103', '450100', '530000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2191', '江南区', '450105', '450100', '530000', 'J', '3');
INSERT INTO `system_address` VALUES ('2192', '西乡塘区', '450107', '450100', '530000', 'X', '3');
INSERT INTO `system_address` VALUES ('2193', '良庆区', '450108', '450100', '530200', 'L', '3');
INSERT INTO `system_address` VALUES ('2194', '邕宁区', '450109', '450100', '530200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2195', '武鸣区', '450110', '450100', '530100', 'W', '3');
INSERT INTO `system_address` VALUES ('2196', '隆安县', '450123', '450100', '532700', 'L', '3');
INSERT INTO `system_address` VALUES ('2197', '马山县', '450124', '450100', '530600', 'M', '3');
INSERT INTO `system_address` VALUES ('2198', '上林县', '450125', '450100', '530500', 'S', '3');
INSERT INTO `system_address` VALUES ('2199', '宾阳县', '450126', '450100', '530400', 'B', '3');
INSERT INTO `system_address` VALUES ('2200', '横县', '450127', '450100', '530300', 'H', '3');
INSERT INTO `system_address` VALUES ('2201', '柳州市', '450200', '450000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2202', '城中区', '450202', '450200', '545000', 'C', '3');
INSERT INTO `system_address` VALUES ('2203', '鱼峰区', '450203', '450200', '545000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2204', '柳南区', '450204', '450200', '545000', 'L', '3');
INSERT INTO `system_address` VALUES ('2205', '柳北区', '450205', '450200', '545000', 'L', '3');
INSERT INTO `system_address` VALUES ('2206', '柳江县', '450221', '450200', '545100', 'L', '3');
INSERT INTO `system_address` VALUES ('2207', '柳城县', '450222', '450200', '545200', 'L', '3');
INSERT INTO `system_address` VALUES ('2208', '鹿寨县', '450223', '450200', '545600', 'L', '3');
INSERT INTO `system_address` VALUES ('2209', '融安县', '450224', '450200', '545400', 'R', '3');
INSERT INTO `system_address` VALUES ('2210', '融水苗族自治县', '450225', '450200', '545300', 'R', '3');
INSERT INTO `system_address` VALUES ('2211', '三江侗族自治县', '450226', '450200', '545500', 'S', '3');
INSERT INTO `system_address` VALUES ('2212', '桂林市', '450300', '450000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2213', '秀峰区', '450302', '450300', '541000', 'X', '3');
INSERT INTO `system_address` VALUES ('2214', '叠彩区', '450303', '450300', '541000', 'D', '3');
INSERT INTO `system_address` VALUES ('2215', '象山区', '450304', '450300', '541000', 'X', '3');
INSERT INTO `system_address` VALUES ('2216', '七星区', '450305', '450300', '541000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2217', '雁山区', '450311', '450300', '541000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2218', '阳朔县', '450321', '450300', '541900', 'Y', '3');
INSERT INTO `system_address` VALUES ('2219', '临桂区', '450322', '450300', '541100', 'L', '3');
INSERT INTO `system_address` VALUES ('2220', '灵川县', '450323', '450300', '541200', 'L', '3');
INSERT INTO `system_address` VALUES ('2221', '全州县', '450324', '450300', '541500', 'Q', '3');
INSERT INTO `system_address` VALUES ('2222', '兴安县', '450325', '450300', '541300', 'X', '3');
INSERT INTO `system_address` VALUES ('2223', '永福县', '450326', '450300', '541899', 'Y', '3');
INSERT INTO `system_address` VALUES ('2224', '灌阳县', '450327', '450300', '541600', 'G', '3');
INSERT INTO `system_address` VALUES ('2225', '龙胜各族自治县', '450328', '450300', '541700', 'L', '3');
INSERT INTO `system_address` VALUES ('2226', '资源县', '450329', '450300', '541400', 'Z', '3');
INSERT INTO `system_address` VALUES ('2227', '平乐县', '450330', '450300', '542400', 'P', '3');
INSERT INTO `system_address` VALUES ('2228', '荔浦县', '450331', '450300', '546600', 'L', '3');
INSERT INTO `system_address` VALUES ('2229', '恭城瑶族自治县', '450332', '450300', '542500', 'G', '3');
INSERT INTO `system_address` VALUES ('2230', '梧州市', '450400', '450000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('2231', '万秀区', '450403', '450400', '543000', 'W', '3');
INSERT INTO `system_address` VALUES ('2232', '蝶山区', '450404', '450400', '543000', 'D', '3');
INSERT INTO `system_address` VALUES ('2233', '长洲区', '450405', '450400', '543000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2234', '龙圩区', '450406', '450400', '543004', 'L', '3');
INSERT INTO `system_address` VALUES ('2235', '苍梧县', '450421', '450400', '543100', 'C', '3');
INSERT INTO `system_address` VALUES ('2236', '藤县', '450422', '450400', '543300', 'T', '3');
INSERT INTO `system_address` VALUES ('2237', '蒙山县', '450423', '450400', '546700', 'M', '3');
INSERT INTO `system_address` VALUES ('2238', '岑溪市', '450481', '450400', '543200', 'C', '3');
INSERT INTO `system_address` VALUES ('2239', '北海市', '450500', '450000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2240', '海城区', '450502', '450500', '536000', 'H', '3');
INSERT INTO `system_address` VALUES ('2241', '银海区', '450503', '450500', '536000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2242', '铁山港区', '450512', '450500', '536000', 'T', '3');
INSERT INTO `system_address` VALUES ('2243', '合浦县', '450521', '450500', '536100', 'H', '3');
INSERT INTO `system_address` VALUES ('2244', '防城港市', '450600', '450000', null, 'F', '2');
INSERT INTO `system_address` VALUES ('2245', '港口区', '450602', '450600', '538000', 'G', '3');
INSERT INTO `system_address` VALUES ('2246', '防城区', '450603', '450600', '538000', 'F', '3');
INSERT INTO `system_address` VALUES ('2247', '上思县', '450621', '450600', '535500', 'S', '3');
INSERT INTO `system_address` VALUES ('2248', '东兴市', '450681', '450600', '538100', 'D', '3');
INSERT INTO `system_address` VALUES ('2249', '钦州市', '450700', '450000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2250', '钦南区', '450702', '450700', '535000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2251', '钦北区', '450703', '450700', '535000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2252', '灵山县', '450721', '450700', '535400', 'L', '3');
INSERT INTO `system_address` VALUES ('2253', '浦北县', '450722', '450700', '535300', 'P', '3');
INSERT INTO `system_address` VALUES ('2254', '贵港市', '450800', '450000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2255', '港北区', '450802', '450800', '537100', 'G', '3');
INSERT INTO `system_address` VALUES ('2256', '港南区', '450803', '450800', '537100', 'G', '3');
INSERT INTO `system_address` VALUES ('2257', '覃塘区', '450804', '450800', '537100', 'T', '3');
INSERT INTO `system_address` VALUES ('2258', '平南县', '450821', '450800', '537300', 'P', '3');
INSERT INTO `system_address` VALUES ('2259', '桂平市', '450881', '450800', '537200', 'G', '3');
INSERT INTO `system_address` VALUES ('2260', '玉林市', '450900', '450000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2261', '玉州区', '450902', '450900', '537000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2262', '福绵区', '450903', '450900', '537000', 'F', '3');
INSERT INTO `system_address` VALUES ('2263', '容县', '450921', '450900', '537500', 'R', '3');
INSERT INTO `system_address` VALUES ('2264', '陆川县', '450922', '450900', '537700', 'L', '3');
INSERT INTO `system_address` VALUES ('2265', '博白县', '450923', '450900', '537600', 'B', '3');
INSERT INTO `system_address` VALUES ('2266', '兴业县', '450924', '450900', '537800', 'X', '3');
INSERT INTO `system_address` VALUES ('2267', '北流市', '450981', '450900', '537400', 'B', '3');
INSERT INTO `system_address` VALUES ('2268', '百色市', '451000', '450000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2269', '右江区', '451002', '451000', '533000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2270', '田阳县', '451021', '451000', '533600', 'T', '3');
INSERT INTO `system_address` VALUES ('2271', '田东县', '451022', '451000', '531500', 'T', '3');
INSERT INTO `system_address` VALUES ('2272', '平果县', '451023', '451000', '531400', 'P', '3');
INSERT INTO `system_address` VALUES ('2273', '德保县', '451024', '451000', '533700', 'D', '3');
INSERT INTO `system_address` VALUES ('2274', '靖西县', '451025', '451000', '533800', 'J', '3');
INSERT INTO `system_address` VALUES ('2275', '那坡县', '451026', '451000', '533900', 'N', '3');
INSERT INTO `system_address` VALUES ('2276', '凌云县', '451027', '451000', '533100', 'L', '3');
INSERT INTO `system_address` VALUES ('2277', '乐业县', '451028', '451000', '533200', 'L', '3');
INSERT INTO `system_address` VALUES ('2278', '田林县', '451029', '451000', '533300', 'T', '3');
INSERT INTO `system_address` VALUES ('2279', '西林县', '451030', '451000', '533500', 'X', '3');
INSERT INTO `system_address` VALUES ('2280', '隆林各族自治县', '451031', '451000', '533400', 'L', '3');
INSERT INTO `system_address` VALUES ('2281', '贺州市', '451100', '450000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2282', '八步区', '451102', '451100', '542800', 'B', '3');
INSERT INTO `system_address` VALUES ('2283', '平桂管理区', '451119', '451100', '542827', 'P', '3');
INSERT INTO `system_address` VALUES ('2284', '昭平县', '451121', '451100', '546800', 'Z', '3');
INSERT INTO `system_address` VALUES ('2285', '钟山县', '451122', '451100', '542600', 'Z', '3');
INSERT INTO `system_address` VALUES ('2286', '富川瑶族自治县', '451123', '451100', '542700', 'F', '3');
INSERT INTO `system_address` VALUES ('2287', '河池市', '451200', '450000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2288', '金城江区', '451202', '451200', '547000', 'J', '3');
INSERT INTO `system_address` VALUES ('2289', '南丹县', '451221', '451200', '547200', 'N', '3');
INSERT INTO `system_address` VALUES ('2290', '天峨县', '451222', '451200', '547300', 'T', '3');
INSERT INTO `system_address` VALUES ('2291', '凤山县', '451223', '451200', '547600', 'F', '3');
INSERT INTO `system_address` VALUES ('2292', '东兰县', '451224', '451200', '547400', 'D', '3');
INSERT INTO `system_address` VALUES ('2293', '罗城仫佬族自治县', '451225', '451200', '546400', 'L', '3');
INSERT INTO `system_address` VALUES ('2294', '环江毛南族自治县', '451226', '451200', '547100', 'H', '3');
INSERT INTO `system_address` VALUES ('2295', '巴马瑶族自治县', '451227', '451200', '547500', 'B', '3');
INSERT INTO `system_address` VALUES ('2296', '都安瑶族自治县', '451228', '451200', '530700', 'D', '3');
INSERT INTO `system_address` VALUES ('2297', '大化瑶族自治县', '451229', '451200', '530800', 'D', '3');
INSERT INTO `system_address` VALUES ('2298', '宜州市', '451281', '451200', '546300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2299', '来宾市', '451300', '450000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2300', '兴宾区', '451302', '451300', '546100', 'X', '3');
INSERT INTO `system_address` VALUES ('2301', '忻城县', '451321', '451300', '546200', 'X', '3');
INSERT INTO `system_address` VALUES ('2302', '象州县', '451322', '451300', '545800', 'X', '3');
INSERT INTO `system_address` VALUES ('2303', '武宣县', '451323', '451300', '545900', 'W', '3');
INSERT INTO `system_address` VALUES ('2304', '金秀瑶族自治县', '451324', '451300', '545700', 'J', '3');
INSERT INTO `system_address` VALUES ('2305', '合山市', '451381', '451300', '546500', 'H', '3');
INSERT INTO `system_address` VALUES ('2306', '崇左市', '451400', '450000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('2307', '江州区', '451402', '451400', '532200', 'J', '3');
INSERT INTO `system_address` VALUES ('2308', '扶绥县', '451421', '451400', '532100', 'F', '3');
INSERT INTO `system_address` VALUES ('2309', '宁明县', '451422', '451400', '532500', 'N', '3');
INSERT INTO `system_address` VALUES ('2310', '龙州县', '451423', '451400', '532400', 'L', '3');
INSERT INTO `system_address` VALUES ('2311', '大新县', '451424', '451400', '532300', 'D', '3');
INSERT INTO `system_address` VALUES ('2312', '天等县', '451425', '451400', '532800', 'T', '3');
INSERT INTO `system_address` VALUES ('2313', '凭祥市', '451481', '451400', '532600', 'P', '3');
INSERT INTO `system_address` VALUES ('2314', '海南', '460000', '0', null, 'H', '1');
INSERT INTO `system_address` VALUES ('2315', '海口市', '460100', '460000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2316', '秀英区', '460105', '460100', '570100', 'X', '3');
INSERT INTO `system_address` VALUES ('2317', '龙华区', '460106', '460100', '570100', 'L', '3');
INSERT INTO `system_address` VALUES ('2318', '琼山区', '460107', '460100', '571100', 'Q', '3');
INSERT INTO `system_address` VALUES ('2319', '美兰区', '460108', '460100', '570100', 'M', '3');
INSERT INTO `system_address` VALUES ('2320', '三亚市', '460200', '460000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2321', '三亚市', '460201', '460200', '572000', 'S', '3');
INSERT INTO `system_address` VALUES ('2326', '五指山市', '469001', '469000', '572200', 'W', '3');
INSERT INTO `system_address` VALUES ('2327', '琼海市', '469002', '469000', '571400', 'Q', '3');
INSERT INTO `system_address` VALUES ('2328', '儋州市', '469003', '460000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2329', '文昌市', '469005', '469000', '571300', 'W', '3');
INSERT INTO `system_address` VALUES ('2330', '万宁市', '469006', '469000', '571500', 'W', '3');
INSERT INTO `system_address` VALUES ('2331', '东方市', '469007', '469000', '572600', 'D', '3');
INSERT INTO `system_address` VALUES ('2332', '定安县', '469025', '469000', '571200', 'D', '3');
INSERT INTO `system_address` VALUES ('2333', '屯昌县', '469026', '469000', '571600', 'T', '3');
INSERT INTO `system_address` VALUES ('2334', '澄迈县', '469027', '469000', '571900', 'C', '3');
INSERT INTO `system_address` VALUES ('2335', '临高县', '469028', '469000', '571800', 'L', '3');
INSERT INTO `system_address` VALUES ('2336', '昌江黎族自治县', '469031', '469000', '572700', 'C', '3');
INSERT INTO `system_address` VALUES ('2337', '乐东黎族自治县', '469033', '469000', '572500', 'L', '3');
INSERT INTO `system_address` VALUES ('2338', '陵水黎族自治县', '469034', '469000', '572400', 'L', '3');
INSERT INTO `system_address` VALUES ('2339', '保亭黎族苗族自治县', '469035', '469000', '572300', 'B', '3');
INSERT INTO `system_address` VALUES ('2340', '琼中黎族苗族自治县', '469036', '469000', '572900', 'Q', '3');
INSERT INTO `system_address` VALUES ('2341', '重庆', '500000', '0', null, 'Z', '1');
INSERT INTO `system_address` VALUES ('2342', '重庆市', '500100', '500000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2343', '万州区', '500101', '500100', '404100', 'W', '3');
INSERT INTO `system_address` VALUES ('2344', '涪陵区', '500102', '500100', '408000', 'F', '3');
INSERT INTO `system_address` VALUES ('2345', '渝中区', '500103', '500100', '400000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2346', '大渡口区', '500104', '500100', '400000', 'D', '3');
INSERT INTO `system_address` VALUES ('2347', '江北区', '500105', '500100', '400000', 'J', '3');
INSERT INTO `system_address` VALUES ('2348', '沙坪坝区', '500106', '500100', '400000', 'S', '3');
INSERT INTO `system_address` VALUES ('2349', '九龙坡区', '500107', '500100', '400000', 'J', '3');
INSERT INTO `system_address` VALUES ('2350', '南岸区', '500108', '500100', '400000', 'N', '3');
INSERT INTO `system_address` VALUES ('2351', '北碚区', '500109', '500100', '400700', 'B', '3');
INSERT INTO `system_address` VALUES ('2352', '万盛区', '500110', '500100', '400800', 'W', '3');
INSERT INTO `system_address` VALUES ('2353', '双桥区', '500111', '500100', '400900', 'S', '3');
INSERT INTO `system_address` VALUES ('2354', '渝北区', '500112', '500100', '401120', 'Y', '3');
INSERT INTO `system_address` VALUES ('2355', '巴南区', '500113', '500100', '401320', 'B', '3');
INSERT INTO `system_address` VALUES ('2356', '黔江区', '500114', '500100', '409000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2357', '长寿区', '500115', '500100', '401220', 'Z', '3');
INSERT INTO `system_address` VALUES ('2358', '北部新区', '500199', '500100', '400000', 'B', '3');
INSERT INTO `system_address` VALUES ('2359', '两江新区', '500200', '500100', '401147', 'L', '3');
INSERT INTO `system_address` VALUES ('2360', '綦江区', '500222', '500100', '401420', 'Q', '3');
INSERT INTO `system_address` VALUES ('2361', '潼南区', '500223', '500100', '402660', 'T', '3');
INSERT INTO `system_address` VALUES ('2362', '铜梁区', '500224', '500100', '402560', 'T', '3');
INSERT INTO `system_address` VALUES ('2363', '大足区', '500225', '500100', '402360', 'D', '3');
INSERT INTO `system_address` VALUES ('2364', '荣昌区', '500226', '500100', '402460', 'R', '3');
INSERT INTO `system_address` VALUES ('2365', '璧山区', '500227', '500100', '402700', 'B', '3');
INSERT INTO `system_address` VALUES ('2366', '梁平区', '500228', '500100', '405200', 'L', '3');
INSERT INTO `system_address` VALUES ('2367', '城口县', '500229', '500200', '405900', 'C', '3');
INSERT INTO `system_address` VALUES ('2368', '丰都县', '500230', '500200', '408200', 'F', '3');
INSERT INTO `system_address` VALUES ('2369', '垫江县', '500231', '500200', '408300', 'D', '3');
INSERT INTO `system_address` VALUES ('2370', '武隆县', '500232', '500100', '408500', 'W', '3');
INSERT INTO `system_address` VALUES ('2371', '忠县', '500233', '500200', '404300', 'Z', '3');
INSERT INTO `system_address` VALUES ('2372', '开县', '500234', '500100', '405400', 'K', '3');
INSERT INTO `system_address` VALUES ('2373', '云阳县', '500235', '500200', '404500', 'Y', '3');
INSERT INTO `system_address` VALUES ('2374', '奉节县', '500236', '500200', '404600', 'F', '3');
INSERT INTO `system_address` VALUES ('2375', '巫山县', '500237', '500200', '404700', 'W', '3');
INSERT INTO `system_address` VALUES ('2376', '巫溪县', '500238', '500200', '405800', 'W', '3');
INSERT INTO `system_address` VALUES ('2377', '石柱土家族自治县', '500240', '500200', '409100', 'S', '3');
INSERT INTO `system_address` VALUES ('2378', '秀山土家族苗族自治县', '500241', '500200', '409900', 'X', '3');
INSERT INTO `system_address` VALUES ('2379', '酉阳土家族苗族自治县', '500242', '500200', '409800', 'Y', '3');
INSERT INTO `system_address` VALUES ('2380', '彭水苗族土家族自治县', '500243', '500200', '409600', 'P', '3');
INSERT INTO `system_address` VALUES ('2381', '江津区', '500381', '500100', '402260', 'J', '3');
INSERT INTO `system_address` VALUES ('2382', '合川区', '500382', '500100', '401520', 'H', '3');
INSERT INTO `system_address` VALUES ('2383', '永川区', '500383', '500100', '402160', 'Y', '3');
INSERT INTO `system_address` VALUES ('2384', '南川区', '500384', '500100', '408400', 'N', '3');
INSERT INTO `system_address` VALUES ('2385', '四川', '510000', '0', null, 'S', '1');
INSERT INTO `system_address` VALUES ('2386', '成都市', '510100', '510000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('2387', '锦江区', '510104', '510100', '610000', 'J', '3');
INSERT INTO `system_address` VALUES ('2388', '青羊区', '510105', '510100', '610000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2389', '金牛区', '510106', '510100', '610000', 'J', '3');
INSERT INTO `system_address` VALUES ('2390', '武侯区', '510107', '510100', '610000', 'W', '3');
INSERT INTO `system_address` VALUES ('2391', '成华区', '510108', '510100', '610000', 'C', '3');
INSERT INTO `system_address` VALUES ('2392', '龙泉驿区', '510112', '510100', '610100', 'L', '3');
INSERT INTO `system_address` VALUES ('2393', '青白江区', '510113', '510100', '610300', 'Q', '3');
INSERT INTO `system_address` VALUES ('2394', '新都区', '510114', '510100', '610500', 'X', '3');
INSERT INTO `system_address` VALUES ('2395', '温江区', '510115', '510100', '611130', 'W', '3');
INSERT INTO `system_address` VALUES ('2396', '天府新区', '510116', '510100', '610000', 'T', '3');
INSERT INTO `system_address` VALUES ('2397', '高新区', '510117', '510100', '610000', 'G', '3');
INSERT INTO `system_address` VALUES ('2398', '金堂县', '510121', '510100', '610400', 'J', '3');
INSERT INTO `system_address` VALUES ('2399', '双流县', '510122', '510100', '610200', 'S', '3');
INSERT INTO `system_address` VALUES ('2400', '郫县', '510124', '510100', '611730', 'P', '3');
INSERT INTO `system_address` VALUES ('2401', '大邑县', '510129', '510100', '611300', 'D', '3');
INSERT INTO `system_address` VALUES ('2402', '蒲江县', '510131', '510100', '611600', 'P', '3');
INSERT INTO `system_address` VALUES ('2403', '新津县', '510132', '510100', '611400', 'X', '3');
INSERT INTO `system_address` VALUES ('2404', '都江堰市', '510181', '510100', '611800', 'D', '3');
INSERT INTO `system_address` VALUES ('2405', '彭州市', '510182', '510100', '611900', 'P', '3');
INSERT INTO `system_address` VALUES ('2406', '邛崃市', '510183', '510100', '611500', 'Q', '3');
INSERT INTO `system_address` VALUES ('2407', '崇州市', '510184', '510100', '611200', 'C', '3');
INSERT INTO `system_address` VALUES ('2408', '自贡市', '510300', '510000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2409', '自流井区', '510302', '510300', '643000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2410', '贡井区', '510303', '510300', '643020', 'G', '3');
INSERT INTO `system_address` VALUES ('2411', '大安区', '510304', '510300', '643010', 'D', '3');
INSERT INTO `system_address` VALUES ('2412', '沿滩区', '510311', '510300', '643030', 'Y', '3');
INSERT INTO `system_address` VALUES ('2413', '荣县', '510321', '510300', '643100', 'R', '3');
INSERT INTO `system_address` VALUES ('2414', '富顺县', '510322', '510300', '643200', 'F', '3');
INSERT INTO `system_address` VALUES ('2415', '攀枝花市', '510400', '510000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('2416', '东区', '510402', '510400', '617000', 'D', '3');
INSERT INTO `system_address` VALUES ('2417', '西区', '510403', '510400', '617000', 'X', '3');
INSERT INTO `system_address` VALUES ('2418', '仁和区', '510411', '510400', '617000', 'R', '3');
INSERT INTO `system_address` VALUES ('2419', '米易县', '510421', '510400', '617200', 'M', '3');
INSERT INTO `system_address` VALUES ('2420', '盐边县', '510422', '510400', '617100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2421', '泸州市', '510500', '510000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2422', '江阳区', '510502', '510500', '646000', 'J', '3');
INSERT INTO `system_address` VALUES ('2423', '纳溪区', '510503', '510500', '646300', 'N', '3');
INSERT INTO `system_address` VALUES ('2424', '龙马潭区', '510504', '510500', '646000', 'L', '3');
INSERT INTO `system_address` VALUES ('2425', '泸县', '510521', '510500', '646100', 'L', '3');
INSERT INTO `system_address` VALUES ('2426', '合江县', '510522', '510500', '646200', 'H', '3');
INSERT INTO `system_address` VALUES ('2427', '叙永县', '510524', '510500', '646400', 'X', '3');
INSERT INTO `system_address` VALUES ('2428', '古蔺县', '510525', '510500', '646500', 'G', '3');
INSERT INTO `system_address` VALUES ('2429', '德阳市', '510600', '510000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2430', '旌阳区', '510603', '510600', '618000', 'J', '3');
INSERT INTO `system_address` VALUES ('2431', '中江县', '510623', '510600', '618100', 'Z', '3');
INSERT INTO `system_address` VALUES ('2432', '罗江县', '510626', '510600', '618500', 'L', '3');
INSERT INTO `system_address` VALUES ('2433', '广汉市', '510681', '510600', '618300', 'G', '3');
INSERT INTO `system_address` VALUES ('2434', '什邡市', '510682', '510600', '618400', 'S', '3');
INSERT INTO `system_address` VALUES ('2435', '绵竹市', '510683', '510600', '618200', 'M', '3');
INSERT INTO `system_address` VALUES ('2436', '绵阳市', '510700', '510000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('2437', '涪城区', '510703', '510700', '621000', 'F', '3');
INSERT INTO `system_address` VALUES ('2438', '游仙区', '510704', '510700', '621000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2439', '三台县', '510722', '510700', '621100', 'S', '3');
INSERT INTO `system_address` VALUES ('2440', '盐亭县', '510723', '510700', '621600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2441', '安县', '510724', '510700', '622650', 'A', '3');
INSERT INTO `system_address` VALUES ('2442', '梓潼县', '510725', '510700', '622150', 'Z', '3');
INSERT INTO `system_address` VALUES ('2443', '北川羌族自治县', '510726', '510700', '622750', 'B', '3');
INSERT INTO `system_address` VALUES ('2444', '平武县', '510727', '510700', '622550', 'P', '3');
INSERT INTO `system_address` VALUES ('2445', '高新区', '510751', '510700', '621000', 'G', '3');
INSERT INTO `system_address` VALUES ('2446', '江油市', '510781', '510700', '621700', 'J', '3');
INSERT INTO `system_address` VALUES ('2447', '广元市', '510800', '510000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2448', '利州区', '510802', '510800', '628000', 'L', '3');
INSERT INTO `system_address` VALUES ('2449', '昭化区', '510811', '510800', '628000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2450', '朝天区', '510812', '510800', '628000', 'C', '3');
INSERT INTO `system_address` VALUES ('2451', '旺苍县', '510821', '510800', '628200', 'W', '3');
INSERT INTO `system_address` VALUES ('2452', '青川县', '510822', '510800', '628100', 'Q', '3');
INSERT INTO `system_address` VALUES ('2453', '剑阁县', '510823', '510800', '628300', 'J', '3');
INSERT INTO `system_address` VALUES ('2454', '苍溪县', '510824', '510800', '628400', 'C', '3');
INSERT INTO `system_address` VALUES ('2455', '遂宁市', '510900', '510000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2456', '船山区', '510903', '510900', '629000', 'C', '3');
INSERT INTO `system_address` VALUES ('2457', '安居区', '510904', '510900', '629000', 'A', '3');
INSERT INTO `system_address` VALUES ('2458', '蓬溪县', '510921', '510900', '629100', 'P', '3');
INSERT INTO `system_address` VALUES ('2459', '射洪县', '510922', '510900', '629200', 'S', '3');
INSERT INTO `system_address` VALUES ('2460', '大英县', '510923', '510900', '629300', 'D', '3');
INSERT INTO `system_address` VALUES ('2461', '内江市', '511000', '510000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('2462', '市中区', '511002', '511000', '641000', 'S', '3');
INSERT INTO `system_address` VALUES ('2463', '东兴区', '511011', '511000', '641100', 'D', '3');
INSERT INTO `system_address` VALUES ('2464', '威远县', '511024', '511000', '642450', 'W', '3');
INSERT INTO `system_address` VALUES ('2465', '资中县', '511025', '511000', '641200', 'Z', '3');
INSERT INTO `system_address` VALUES ('2466', '隆昌县', '511028', '511000', '642150', 'L', '3');
INSERT INTO `system_address` VALUES ('2467', '乐山市', '511100', '510000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2468', '市中区', '511102', '511100', '614000', 'S', '3');
INSERT INTO `system_address` VALUES ('2469', '沙湾区', '511111', '511100', '614900', 'S', '3');
INSERT INTO `system_address` VALUES ('2470', '五通桥区', '511112', '511100', '614800', 'W', '3');
INSERT INTO `system_address` VALUES ('2471', '金口河区', '511113', '511100', '614700', 'J', '3');
INSERT INTO `system_address` VALUES ('2472', '犍为县', '511123', '511100', '614400', 'J', '3');
INSERT INTO `system_address` VALUES ('2473', '井研县', '511124', '511100', '613100', 'J', '3');
INSERT INTO `system_address` VALUES ('2474', '夹江县', '511126', '511100', '614100', 'J', '3');
INSERT INTO `system_address` VALUES ('2475', '沐川县', '511129', '511100', '614500', 'M', '3');
INSERT INTO `system_address` VALUES ('2476', '峨边彝族自治县', '511132', '511100', '614300', 'E', '3');
INSERT INTO `system_address` VALUES ('2477', '马边彝族自治县', '511133', '511100', '614600', 'M', '3');
INSERT INTO `system_address` VALUES ('2478', '峨眉山市', '511181', '511100', '614200', 'E', '3');
INSERT INTO `system_address` VALUES ('2479', '南充市', '511300', '510000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('2480', '顺庆区', '511302', '511300', '637000', 'S', '3');
INSERT INTO `system_address` VALUES ('2481', '高坪区', '511303', '511300', '637100', 'G', '3');
INSERT INTO `system_address` VALUES ('2482', '嘉陵区', '511304', '511300', '637500', 'J', '3');
INSERT INTO `system_address` VALUES ('2483', '南部县', '511321', '511300', '637300', 'N', '3');
INSERT INTO `system_address` VALUES ('2484', '营山县', '511322', '511300', '637700', 'Y', '3');
INSERT INTO `system_address` VALUES ('2485', '蓬安县', '511323', '511300', '637800', 'P', '3');
INSERT INTO `system_address` VALUES ('2486', '仪陇县', '511324', '511300', '637600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2487', '西充县', '511325', '511300', '637200', 'X', '3');
INSERT INTO `system_address` VALUES ('2488', '阆中市', '511381', '511300', '637400', 'L', '3');
INSERT INTO `system_address` VALUES ('2489', '眉山市', '511400', '510000', null, 'M', '2');
INSERT INTO `system_address` VALUES ('2490', '东坡区', '511402', '511400', '620000', 'D', '3');
INSERT INTO `system_address` VALUES ('2491', '仁寿县', '511421', '511400', '620500', 'R', '3');
INSERT INTO `system_address` VALUES ('2492', '彭山区', '511422', '511400', '620800', 'P', '3');
INSERT INTO `system_address` VALUES ('2493', '洪雅县', '511423', '511400', '620300', 'H', '3');
INSERT INTO `system_address` VALUES ('2494', '丹棱县', '511424', '511400', '620200', 'D', '3');
INSERT INTO `system_address` VALUES ('2495', '青神县', '511425', '511400', '620400', 'Q', '3');
INSERT INTO `system_address` VALUES ('2496', '宜宾市', '511500', '510000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2497', '翠屏区', '511502', '511500', '644000', 'C', '3');
INSERT INTO `system_address` VALUES ('2498', '宜宾县', '511521', '511500', '644600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2499', '南溪区', '511522', '511500', '644100', 'N', '3');
INSERT INTO `system_address` VALUES ('2500', '江安县', '511523', '511500', '644200', 'J', '3');
INSERT INTO `system_address` VALUES ('2501', '长宁县', '511524', '511500', '644300', 'Z', '3');
INSERT INTO `system_address` VALUES ('2502', '高县', '511525', '511500', '645150', 'G', '3');
INSERT INTO `system_address` VALUES ('2503', '珙县', '511526', '511500', '644500', 'G', '3');
INSERT INTO `system_address` VALUES ('2504', '筠连县', '511527', '511500', '645250', 'Y', '3');
INSERT INTO `system_address` VALUES ('2505', '兴文县', '511528', '511500', '644400', 'X', '3');
INSERT INTO `system_address` VALUES ('2506', '屏山县', '511529', '511500', '645350', 'P', '3');
INSERT INTO `system_address` VALUES ('2507', '广安市', '511600', '510000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2508', '广安区', '511602', '511600', '638550', 'G', '3');
INSERT INTO `system_address` VALUES ('2509', '前锋区', '511603', '511600', '638019', 'Q', '3');
INSERT INTO `system_address` VALUES ('2510', '岳池县', '511621', '511600', '638300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2511', '武胜县', '511622', '511600', '638400', 'W', '3');
INSERT INTO `system_address` VALUES ('2512', '邻水县', '511623', '511600', '638500', 'L', '3');
INSERT INTO `system_address` VALUES ('2513', '华蓥市', '511681', '511600', '409800', 'H', '3');
INSERT INTO `system_address` VALUES ('2514', '市辖区', '511682', '511600', '638500', 'S', '3');
INSERT INTO `system_address` VALUES ('2515', '达州市', '511700', '510000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2516', '通川区', '511702', '511700', '635000', 'T', '3');
INSERT INTO `system_address` VALUES ('2517', '达川区', '511721', '511700', '635000', 'D', '3');
INSERT INTO `system_address` VALUES ('2518', '宣汉县', '511722', '511700', '636150', 'X', '3');
INSERT INTO `system_address` VALUES ('2519', '开江县', '511723', '511700', '636250', 'K', '3');
INSERT INTO `system_address` VALUES ('2520', '大竹县', '511724', '511700', '635100', 'D', '3');
INSERT INTO `system_address` VALUES ('2521', '渠县', '511725', '511700', '635200', 'Q', '3');
INSERT INTO `system_address` VALUES ('2522', '万源市', '511781', '511700', '636350', 'W', '3');
INSERT INTO `system_address` VALUES ('2523', '雅安市', '511800', '510000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2524', '雨城区', '511802', '511800', '625000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2525', '名山区', '511821', '511800', '625100', 'M', '3');
INSERT INTO `system_address` VALUES ('2526', '荥经县', '511822', '511800', '625200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2527', '汉源县', '511823', '511800', '625300', 'H', '3');
INSERT INTO `system_address` VALUES ('2528', '石棉县', '511824', '511800', '625400', 'S', '3');
INSERT INTO `system_address` VALUES ('2529', '天全县', '511825', '511800', '625500', 'T', '3');
INSERT INTO `system_address` VALUES ('2530', '芦山县', '511826', '511800', '625600', 'L', '3');
INSERT INTO `system_address` VALUES ('2531', '宝兴县', '511827', '511800', '625700', 'B', '3');
INSERT INTO `system_address` VALUES ('2532', '巴中市', '511900', '510000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2533', '巴州区', '511902', '511900', '636600', 'B', '3');
INSERT INTO `system_address` VALUES ('2534', '恩阳区', '511903', '511900', '636063', 'E', '3');
INSERT INTO `system_address` VALUES ('2535', '通江县', '511921', '511900', '636700', 'T', '3');
INSERT INTO `system_address` VALUES ('2536', '南江县', '511922', '511900', '635600', 'N', '3');
INSERT INTO `system_address` VALUES ('2537', '平昌县', '511923', '511900', '636400', 'P', '3');
INSERT INTO `system_address` VALUES ('2538', '资阳市', '512000', '510000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2539', '雁江区', '512002', '512000', '641300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2540', '安岳县', '512021', '512000', '642350', 'A', '3');
INSERT INTO `system_address` VALUES ('2541', '乐至县', '512022', '512000', '641500', 'L', '3');
INSERT INTO `system_address` VALUES ('2542', '简阳市', '512081', '512000', '641400', 'J', '3');
INSERT INTO `system_address` VALUES ('2543', '阿坝藏族羌族自治州', '513200', '510000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('2544', '汶川县', '513221', '513200', '623000', 'W', '3');
INSERT INTO `system_address` VALUES ('2545', '理县', '513222', '513200', '623100', 'L', '3');
INSERT INTO `system_address` VALUES ('2546', '茂县', '513223', '513200', '623200', 'M', '3');
INSERT INTO `system_address` VALUES ('2547', '松潘县', '513224', '513200', '623300', 'S', '3');
INSERT INTO `system_address` VALUES ('2548', '九寨沟县', '513225', '513200', '623400', 'J', '3');
INSERT INTO `system_address` VALUES ('2549', '金川县', '513226', '513200', '624100', 'J', '3');
INSERT INTO `system_address` VALUES ('2550', '小金县', '513227', '513200', '624200', 'X', '3');
INSERT INTO `system_address` VALUES ('2551', '黑水县', '513228', '513200', '623500', 'H', '3');
INSERT INTO `system_address` VALUES ('2552', '马尔康县', '513229', '513200', '624000', 'M', '3');
INSERT INTO `system_address` VALUES ('2553', '壤塘县', '513230', '513200', '624300', 'R', '3');
INSERT INTO `system_address` VALUES ('2554', '阿坝县', '513231', '513200', '624600', 'A', '3');
INSERT INTO `system_address` VALUES ('2555', '若尔盖县', '513232', '513200', '624500', 'R', '3');
INSERT INTO `system_address` VALUES ('2556', '红原县', '513233', '513200', '624400', 'H', '3');
INSERT INTO `system_address` VALUES ('2557', '甘孜藏族自治州', '513300', '510000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2558', '康定区', '513321', '513300', '626000', 'K', '3');
INSERT INTO `system_address` VALUES ('2559', '泸定县', '513322', '513300', '626100', 'L', '3');
INSERT INTO `system_address` VALUES ('2560', '丹巴县', '513323', '513300', '626300', 'D', '3');
INSERT INTO `system_address` VALUES ('2561', '九龙县', '513324', '513300', '616200', 'J', '3');
INSERT INTO `system_address` VALUES ('2562', '雅江县', '513325', '513300', '627450', 'Y', '3');
INSERT INTO `system_address` VALUES ('2563', '道孚县', '513326', '513300', '626400', 'D', '3');
INSERT INTO `system_address` VALUES ('2564', '炉霍县', '513327', '513300', '626500', 'L', '3');
INSERT INTO `system_address` VALUES ('2565', '甘孜县', '513328', '513300', '626700', 'G', '3');
INSERT INTO `system_address` VALUES ('2566', '新龙县', '513329', '513300', '626800', 'X', '3');
INSERT INTO `system_address` VALUES ('2567', '德格县', '513330', '513300', '627250', 'D', '3');
INSERT INTO `system_address` VALUES ('2568', '白玉县', '513331', '513300', '627150', 'B', '3');
INSERT INTO `system_address` VALUES ('2569', '石渠县', '513332', '513300', '627350', 'S', '3');
INSERT INTO `system_address` VALUES ('2570', '色达县', '513333', '513300', '626600', 'S', '3');
INSERT INTO `system_address` VALUES ('2571', '理塘县', '513334', '513300', '624300', 'L', '3');
INSERT INTO `system_address` VALUES ('2572', '巴塘县', '513335', '513300', '627650', 'B', '3');
INSERT INTO `system_address` VALUES ('2573', '乡城县', '513336', '513300', '627850', 'X', '3');
INSERT INTO `system_address` VALUES ('2574', '稻城县', '513337', '513300', '627750', 'D', '3');
INSERT INTO `system_address` VALUES ('2575', '得荣县', '513338', '513300', '627950', 'D', '3');
INSERT INTO `system_address` VALUES ('2576', '凉山彝族自治州', '513400', '510000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2577', '西昌市', '513401', '513400', '615000', 'X', '3');
INSERT INTO `system_address` VALUES ('2578', '木里藏族自治县', '513422', '513400', '615800', 'M', '3');
INSERT INTO `system_address` VALUES ('2579', '盐源县', '513423', '513400', '615700', 'Y', '3');
INSERT INTO `system_address` VALUES ('2580', '德昌县', '513424', '513400', '615500', 'D', '3');
INSERT INTO `system_address` VALUES ('2581', '会理县', '513425', '513400', '615100', 'H', '3');
INSERT INTO `system_address` VALUES ('2582', '会东县', '513426', '513400', '615200', 'H', '3');
INSERT INTO `system_address` VALUES ('2583', '宁南县', '513427', '513400', '615400', 'N', '3');
INSERT INTO `system_address` VALUES ('2584', '普格县', '513428', '513400', '615300', 'P', '3');
INSERT INTO `system_address` VALUES ('2585', '布拖县', '513429', '513400', '615350', 'B', '3');
INSERT INTO `system_address` VALUES ('2586', '金阳县', '513430', '513400', '616250', 'J', '3');
INSERT INTO `system_address` VALUES ('2587', '昭觉县', '513431', '513400', '616150', 'Z', '3');
INSERT INTO `system_address` VALUES ('2588', '喜德县', '513432', '513400', '616750', 'X', '3');
INSERT INTO `system_address` VALUES ('2589', '冕宁县', '513433', '513400', '615600', 'M', '3');
INSERT INTO `system_address` VALUES ('2590', '越西县', '513434', '513400', '616650', 'Y', '3');
INSERT INTO `system_address` VALUES ('2591', '甘洛县', '513435', '513400', '616850', 'G', '3');
INSERT INTO `system_address` VALUES ('2592', '美姑县', '513436', '513400', '616450', 'M', '3');
INSERT INTO `system_address` VALUES ('2593', '雷波县', '513437', '513400', '616550', 'L', '3');
INSERT INTO `system_address` VALUES ('2594', '贵州', '520000', '0', null, 'G', '1');
INSERT INTO `system_address` VALUES ('2595', '贵阳市', '520100', '520000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('2596', '铜仁市', '520102', '520100', '554300', 'T', '3');
INSERT INTO `system_address` VALUES ('2597', '云岩区', '520103', '520100', '550000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2598', '花溪区', '520111', '520100', '550000', 'H', '3');
INSERT INTO `system_address` VALUES ('2599', '乌当区', '520112', '520100', '550000', 'W', '3');
INSERT INTO `system_address` VALUES ('2600', '白云区', '520113', '520100', '550000', 'B', '3');
INSERT INTO `system_address` VALUES ('2601', '小河区', '520114', '520100', '550000', 'X', '3');
INSERT INTO `system_address` VALUES ('2602', '开阳县', '520121', '520100', '550300', 'K', '3');
INSERT INTO `system_address` VALUES ('2603', '息烽县', '520122', '520100', '551100', 'X', '3');
INSERT INTO `system_address` VALUES ('2604', '修文县', '520123', '520100', '550200', 'X', '3');
INSERT INTO `system_address` VALUES ('2605', '观山湖区', '520151', '520100', '550081', 'G', '3');
INSERT INTO `system_address` VALUES ('2606', '清镇市', '520181', '520100', '551400', 'Q', '3');
INSERT INTO `system_address` VALUES ('2607', '六盘水市', '520200', '520000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2608', '钟山区', '520201', '520200', '553000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2609', '六枝特区', '520203', '520200', '553400', 'L', '3');
INSERT INTO `system_address` VALUES ('2610', '水城县', '520221', '520200', '553600', 'S', '3');
INSERT INTO `system_address` VALUES ('2611', '盘县', '520222', '520200', '553537', 'P', '3');
INSERT INTO `system_address` VALUES ('2612', '遵义市', '520300', '520000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2613', '红花岗区', '520302', '520300', '563000', 'H', '3');
INSERT INTO `system_address` VALUES ('2614', '汇川区', '520303', '520300', '563000', 'H', '3');
INSERT INTO `system_address` VALUES ('2615', '遵义县', '520321', '520300', '563100', 'Z', '3');
INSERT INTO `system_address` VALUES ('2616', '桐梓县', '520322', '520300', '563200', 'T', '3');
INSERT INTO `system_address` VALUES ('2617', '绥阳县', '520323', '520300', '563300', 'S', '3');
INSERT INTO `system_address` VALUES ('2618', '正安县', '520324', '520300', '563400', 'Z', '3');
INSERT INTO `system_address` VALUES ('2619', '道真仡佬族苗族自治县', '520325', '520300', '563500', 'D', '3');
INSERT INTO `system_address` VALUES ('2620', '务川仡佬族苗族自治县', '520326', '520300', '564300', 'W', '3');
INSERT INTO `system_address` VALUES ('2621', '凤冈县', '520327', '520300', '564200', 'F', '3');
INSERT INTO `system_address` VALUES ('2622', '湄潭县', '520328', '520300', '564100', 'M', '3');
INSERT INTO `system_address` VALUES ('2623', '余庆县', '520329', '520300', '564400', 'Y', '3');
INSERT INTO `system_address` VALUES ('2624', '习水县', '520330', '520300', '564600', 'X', '3');
INSERT INTO `system_address` VALUES ('2625', '赤水市', '520381', '520300', '564700', 'C', '3');
INSERT INTO `system_address` VALUES ('2626', '仁怀市', '520382', '520300', '564500', 'R', '3');
INSERT INTO `system_address` VALUES ('2627', '安顺市', '520400', '520000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('2628', '西秀区', '520402', '520400', '561000', 'X', '3');
INSERT INTO `system_address` VALUES ('2629', '平坝区', '520421', '520400', '561100', 'P', '3');
INSERT INTO `system_address` VALUES ('2630', '普定县', '520422', '520400', '562100', 'P', '3');
INSERT INTO `system_address` VALUES ('2631', '镇宁布依族苗族自治县', '520423', '520400', '561200', 'Z', '3');
INSERT INTO `system_address` VALUES ('2632', '关岭布依族苗族自治县', '520424', '520400', '561300', 'G', '3');
INSERT INTO `system_address` VALUES ('2633', '紫云苗族布依族自治县', '520425', '520400', '550800', 'Z', '3');
INSERT INTO `system_address` VALUES ('2634', '铜仁市', '522200', '520000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('2635', '碧江区', '522201', '522200', '554300', 'B', '3');
INSERT INTO `system_address` VALUES ('2636', '江口县', '522222', '522200', '554400', 'J', '3');
INSERT INTO `system_address` VALUES ('2637', '玉屏侗族自治县', '522223', '522200', '554000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2638', '石阡县', '522224', '522200', '555100', 'S', '3');
INSERT INTO `system_address` VALUES ('2639', '思南县', '522225', '522200', '565100', 'S', '3');
INSERT INTO `system_address` VALUES ('2640', '印江土家族苗族自治县', '522226', '522200', '555200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2641', '德江县', '522227', '522200', '565200', 'D', '3');
INSERT INTO `system_address` VALUES ('2642', '沿河土家族自治县', '522228', '522200', '565300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2643', '松桃苗族自治县', '522229', '522200', '554100', 'S', '3');
INSERT INTO `system_address` VALUES ('2644', '万山区', '522230', '522200', '554200', 'W', '3');
INSERT INTO `system_address` VALUES ('2645', '黔西南布依族苗族自治州', '522300', '520000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2646', '兴义市', '522301', '522300', '562400', 'X', '3');
INSERT INTO `system_address` VALUES ('2647', '兴仁县', '522322', '522300', '562300', 'X', '3');
INSERT INTO `system_address` VALUES ('2648', '普安县', '522323', '522300', '561500', 'P', '3');
INSERT INTO `system_address` VALUES ('2649', '晴隆县', '522324', '522300', '561400', 'Q', '3');
INSERT INTO `system_address` VALUES ('2650', '贞丰县', '522325', '522300', '562200', 'Z', '3');
INSERT INTO `system_address` VALUES ('2651', '望谟县', '522326', '522300', '552300', 'W', '3');
INSERT INTO `system_address` VALUES ('2652', '册亨县', '522327', '522300', '552200', 'C', '3');
INSERT INTO `system_address` VALUES ('2653', '安龙县', '522328', '522300', '552400', 'A', '3');
INSERT INTO `system_address` VALUES ('2654', '毕节市', '522400', '520000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2655', '七星关区', '520502', '522400', '551700', 'Q', '3');
INSERT INTO `system_address` VALUES ('2656', '大方县', '520521', '522400', '551600', 'D', '3');
INSERT INTO `system_address` VALUES ('2657', '黔西县', '520522', '522400', '551500', 'Q', '3');
INSERT INTO `system_address` VALUES ('2658', '金沙县', '520523', '522400', '551800', 'J', '3');
INSERT INTO `system_address` VALUES ('2659', '织金县', '520524', '522400', '552100', 'Z', '3');
INSERT INTO `system_address` VALUES ('2660', '纳雍县', '520525', '522400', '553300', 'N', '3');
INSERT INTO `system_address` VALUES ('2661', '威宁彝族回族苗族自治县', '520526', '522400', '553100', 'W', '3');
INSERT INTO `system_address` VALUES ('2662', '赫章县', '520527', '522400', '553200', 'H', '3');
INSERT INTO `system_address` VALUES ('2663', '黔东南苗族侗族自治州', '522600', '520000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2664', '凯里市', '522601', '522600', '556000', 'K', '3');
INSERT INTO `system_address` VALUES ('2665', '黄平县', '522622', '522600', '556100', 'H', '3');
INSERT INTO `system_address` VALUES ('2666', '施秉县', '522623', '522600', '556200', 'S', '3');
INSERT INTO `system_address` VALUES ('2667', '三穗县', '522624', '522600', '556500', 'S', '3');
INSERT INTO `system_address` VALUES ('2668', '镇远县', '522625', '522600', '557700', 'Z', '3');
INSERT INTO `system_address` VALUES ('2669', '岑巩县', '522626', '522600', '557800', 'C', '3');
INSERT INTO `system_address` VALUES ('2670', '天柱县', '522627', '522600', '556600', 'T', '3');
INSERT INTO `system_address` VALUES ('2671', '锦屏县', '522628', '522600', '556700', 'J', '3');
INSERT INTO `system_address` VALUES ('2672', '剑河县', '522629', '522600', '556400', 'J', '3');
INSERT INTO `system_address` VALUES ('2673', '台江县', '522630', '522600', '556300', 'T', '3');
INSERT INTO `system_address` VALUES ('2674', '黎平县', '522631', '522600', '557300', 'L', '3');
INSERT INTO `system_address` VALUES ('2675', '榕江县', '522632', '522600', '557200', 'R', '3');
INSERT INTO `system_address` VALUES ('2676', '从江县', '522633', '522600', '557400', 'C', '3');
INSERT INTO `system_address` VALUES ('2677', '雷山县', '522634', '522600', '557100', 'L', '3');
INSERT INTO `system_address` VALUES ('2678', '麻江县', '522635', '522600', '557600', 'M', '3');
INSERT INTO `system_address` VALUES ('2679', '丹寨县', '522636', '522600', '557500', 'D', '3');
INSERT INTO `system_address` VALUES ('2680', '黔南布依族苗族自治州', '522700', '520000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2681', '都匀市', '522701', '522700', '558000', 'D', '3');
INSERT INTO `system_address` VALUES ('2682', '福泉市', '522702', '522700', '550500', 'F', '3');
INSERT INTO `system_address` VALUES ('2683', '荔波县', '522722', '522700', '558400', 'L', '3');
INSERT INTO `system_address` VALUES ('2684', '贵定县', '522723', '522700', '551300', 'G', '3');
INSERT INTO `system_address` VALUES ('2685', '瓮安县', '522725', '522700', '550400', 'W', '3');
INSERT INTO `system_address` VALUES ('2686', '独山县', '522726', '522700', '558200', 'D', '3');
INSERT INTO `system_address` VALUES ('2687', '平塘县', '522727', '522700', '558300', 'P', '3');
INSERT INTO `system_address` VALUES ('2688', '罗甸县', '522728', '522700', '550100', 'L', '3');
INSERT INTO `system_address` VALUES ('2689', '长顺县', '522729', '522700', '550700', 'Z', '3');
INSERT INTO `system_address` VALUES ('2690', '龙里县', '522730', '522700', '551200', 'L', '3');
INSERT INTO `system_address` VALUES ('2691', '惠水县', '522731', '522700', '550600', 'H', '3');
INSERT INTO `system_address` VALUES ('2692', '三都水族自治县', '522732', '522700', '558100', 'S', '3');
INSERT INTO `system_address` VALUES ('2693', '云南', '530000', '0', null, 'Y', '1');
INSERT INTO `system_address` VALUES ('2694', '昆明市', '530100', '530000', null, 'K', '2');
INSERT INTO `system_address` VALUES ('2695', '五华区', '530102', '530100', '650000', 'W', '3');
INSERT INTO `system_address` VALUES ('2696', '盘龙区', '530103', '530100', '650000', 'P', '3');
INSERT INTO `system_address` VALUES ('2697', '官渡区', '530111', '530100', '650200', 'G', '3');
INSERT INTO `system_address` VALUES ('2698', '西山区', '530112', '530100', '650100', 'X', '3');
INSERT INTO `system_address` VALUES ('2699', '东川区', '530113', '530100', '654100', 'D', '3');
INSERT INTO `system_address` VALUES ('2700', '呈贡区', '530114', '530100', '650500', 'C', '3');
INSERT INTO `system_address` VALUES ('2701', '晋宁县', '530122', '530100', '650600', 'J', '3');
INSERT INTO `system_address` VALUES ('2702', '富民县', '530124', '530100', '650400', 'F', '3');
INSERT INTO `system_address` VALUES ('2703', '宜良县', '530125', '530100', '652100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2704', '石林彝族自治县', '530126', '530100', '652200', 'S', '3');
INSERT INTO `system_address` VALUES ('2705', '嵩明县', '530127', '530100', '651700', 'S', '3');
INSERT INTO `system_address` VALUES ('2706', '禄劝彝族苗族自治县', '530128', '530100', '651500', 'L', '3');
INSERT INTO `system_address` VALUES ('2707', '寻甸回族彝族自治县', '530129', '530100', '655200', 'X', '3');
INSERT INTO `system_address` VALUES ('2708', '安宁市', '530181', '530100', '650300', 'A', '3');
INSERT INTO `system_address` VALUES ('2709', '曲靖市', '530300', '530000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('2710', '麒麟区', '530302', '530300', '655000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2711', '马龙县', '530321', '530300', '655100', 'M', '3');
INSERT INTO `system_address` VALUES ('2712', '陆良县', '530322', '530300', '655699', 'L', '3');
INSERT INTO `system_address` VALUES ('2713', '师宗县', '530323', '530300', '655700', 'S', '3');
INSERT INTO `system_address` VALUES ('2714', '罗平县', '530324', '530300', '655800', 'L', '3');
INSERT INTO `system_address` VALUES ('2715', '富源县', '530325', '530300', '655500', 'F', '3');
INSERT INTO `system_address` VALUES ('2716', '会泽县', '530326', '530300', '654200', 'H', '3');
INSERT INTO `system_address` VALUES ('2717', '沾益县', '530328', '530300', '655331', 'Z', '3');
INSERT INTO `system_address` VALUES ('2718', '宣威市', '530381', '530300', '655400', 'X', '3');
INSERT INTO `system_address` VALUES ('2719', '玉溪市', '530400', '530000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2720', '红塔区', '530402', '530400', '653100', 'H', '3');
INSERT INTO `system_address` VALUES ('2721', '江川县', '530421', '530400', '652600', 'J', '3');
INSERT INTO `system_address` VALUES ('2722', '澄江县', '530422', '530400', '652500', 'C', '3');
INSERT INTO `system_address` VALUES ('2723', '通海县', '530423', '530400', '652700', 'T', '3');
INSERT INTO `system_address` VALUES ('2724', '华宁县', '530424', '530400', '652800', 'H', '3');
INSERT INTO `system_address` VALUES ('2725', '易门县', '530425', '530400', '651100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2726', '峨山彝族自治县', '530426', '530400', '653200', 'E', '3');
INSERT INTO `system_address` VALUES ('2727', '新平彝族傣族自治县', '530427', '530400', '653400', 'X', '3');
INSERT INTO `system_address` VALUES ('2728', '元江哈尼族彝族傣族自治县', '530428', '530400', '653300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2729', '保山市', '530500', '530000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2730', '隆阳区', '530502', '530500', '678000', 'L', '3');
INSERT INTO `system_address` VALUES ('2731', '施甸县', '530521', '530500', '678200', 'S', '3');
INSERT INTO `system_address` VALUES ('2732', '腾冲县', '530522', '530500', '679100', 'T', '3');
INSERT INTO `system_address` VALUES ('2733', '龙陵县', '530523', '530500', '678300', 'L', '3');
INSERT INTO `system_address` VALUES ('2734', '昌宁县', '530524', '530500', '678100', 'C', '3');
INSERT INTO `system_address` VALUES ('2735', '昭通市', '530600', '530000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('2736', '昭阳区', '530602', '530600', '657000', 'Z', '3');
INSERT INTO `system_address` VALUES ('2737', '鲁甸县', '530621', '530600', '657100', 'L', '3');
INSERT INTO `system_address` VALUES ('2738', '巧家县', '530622', '530600', '654600', 'Q', '3');
INSERT INTO `system_address` VALUES ('2739', '盐津县', '530623', '530600', '657500', 'Y', '3');
INSERT INTO `system_address` VALUES ('2740', '大关县', '530624', '530600', '657400', 'D', '3');
INSERT INTO `system_address` VALUES ('2741', '永善县', '530625', '530600', '657300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2742', '绥江县', '530626', '530600', '657700', 'S', '3');
INSERT INTO `system_address` VALUES ('2743', '镇雄县', '530627', '530600', '657200', 'Z', '3');
INSERT INTO `system_address` VALUES ('2744', '彝良县', '530628', '530600', '657600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2745', '威信县', '530629', '530600', '657900', 'W', '3');
INSERT INTO `system_address` VALUES ('2746', '水富县', '530630', '530600', '657800', 'S', '3');
INSERT INTO `system_address` VALUES ('2747', '丽江市', '530700', '530000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2748', '古城区', '530702', '530700', '674100', 'G', '3');
INSERT INTO `system_address` VALUES ('2749', '玉龙纳西族自治县', '530721', '530700', '674100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2750', '永胜县', '530722', '530700', '674200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2751', '华坪县', '530723', '530700', '674800', 'H', '3');
INSERT INTO `system_address` VALUES ('2752', '宁蒗彝族自治县', '530724', '530700', '674300', 'N', '3');
INSERT INTO `system_address` VALUES ('2753', '普洱市', '530800', '530000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('2754', '思茅区', '530802', '530800', '665000', 'S', '3');
INSERT INTO `system_address` VALUES ('2755', '宁洱哈尼族彝族自治县', '530821', '530800', '665000', 'N', '3');
INSERT INTO `system_address` VALUES ('2756', '墨江哈尼族自治县', '530822', '530800', '654800', 'M', '3');
INSERT INTO `system_address` VALUES ('2757', '景东彝族自治县', '530823', '530800', '676200', 'J', '3');
INSERT INTO `system_address` VALUES ('2758', '景谷傣族彝族自治县', '530824', '530800', '666400', 'J', '3');
INSERT INTO `system_address` VALUES ('2759', '镇沅彝族哈尼族拉祜族自治县', '530825', '530800', '666500', 'Z', '3');
INSERT INTO `system_address` VALUES ('2760', '江城哈尼族彝族自治县', '530826', '530800', '665900', 'J', '3');
INSERT INTO `system_address` VALUES ('2761', '孟连傣族拉祜族佤族自治县', '530827', '530800', '665800', 'M', '3');
INSERT INTO `system_address` VALUES ('2762', '澜沧拉祜族自治县', '530828', '530800', '665600', 'L', '3');
INSERT INTO `system_address` VALUES ('2763', '西盟佤族自治县', '530829', '530800', '665700', 'X', '3');
INSERT INTO `system_address` VALUES ('2764', '临沧市', '530900', '530000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2765', '临翔区', '530902', '530900', '677000', 'L', '3');
INSERT INTO `system_address` VALUES ('2766', '凤庆县', '530921', '530900', '675900', 'F', '3');
INSERT INTO `system_address` VALUES ('2767', '云县', '530922', '530900', '675800', 'Y', '3');
INSERT INTO `system_address` VALUES ('2768', '永德县', '530923', '530900', '677600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2769', '镇康县', '530924', '530900', '677700', 'Z', '3');
INSERT INTO `system_address` VALUES ('2770', '双江拉祜族佤族布朗族傣族自治县', '530925', '530900', '677300', 'S', '3');
INSERT INTO `system_address` VALUES ('2771', '耿马傣族佤族自治县', '530926', '530900', '677500', 'G', '3');
INSERT INTO `system_address` VALUES ('2772', '沧源佤族自治县', '530927', '530900', '677400', 'C', '3');
INSERT INTO `system_address` VALUES ('2773', '楚雄彝族自治州', '532300', '530000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('2774', '楚雄市', '532301', '532300', '675000', 'C', '3');
INSERT INTO `system_address` VALUES ('2775', '双柏县', '532322', '532300', '675100', 'S', '3');
INSERT INTO `system_address` VALUES ('2776', '牟定县', '532323', '532300', '675500', 'M', '3');
INSERT INTO `system_address` VALUES ('2777', '南华县', '532324', '532300', '675200', 'N', '3');
INSERT INTO `system_address` VALUES ('2778', '姚安县', '532325', '532300', '675300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2779', '大姚县', '532326', '532300', '675400', 'D', '3');
INSERT INTO `system_address` VALUES ('2780', '永仁县', '532327', '532300', '651400', 'Y', '3');
INSERT INTO `system_address` VALUES ('2781', '元谋县', '532328', '532300', '651300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2782', '武定县', '532329', '532300', '651600', 'W', '3');
INSERT INTO `system_address` VALUES ('2783', '禄丰县', '532331', '532300', '651200', 'L', '3');
INSERT INTO `system_address` VALUES ('2784', '红河哈尼族彝族自治州', '532500', '530000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2785', '个旧市', '532501', '532500', '661000', 'G', '3');
INSERT INTO `system_address` VALUES ('2786', '开远市', '532502', '532500', '661600', 'K', '3');
INSERT INTO `system_address` VALUES ('2787', '蒙自市', '532522', '532500', '661100', 'M', '3');
INSERT INTO `system_address` VALUES ('2788', '屏边苗族自治县', '532523', '532500', '661200', 'P', '3');
INSERT INTO `system_address` VALUES ('2789', '建水县', '532524', '532500', '654300', 'J', '3');
INSERT INTO `system_address` VALUES ('2790', '石屏县', '532525', '532500', '662200', 'S', '3');
INSERT INTO `system_address` VALUES ('2791', '弥勒市', '532526', '532500', '652300', 'M', '3');
INSERT INTO `system_address` VALUES ('2792', '泸西县', '532527', '532500', '652400', 'L', '3');
INSERT INTO `system_address` VALUES ('2793', '元阳县', '532528', '532500', '662400', 'Y', '3');
INSERT INTO `system_address` VALUES ('2794', '红河县', '532529', '532500', '654400', 'H', '3');
INSERT INTO `system_address` VALUES ('2795', '金平苗族瑶族傣族自治县', '532530', '532500', '661500', 'J', '3');
INSERT INTO `system_address` VALUES ('2796', '绿春县', '532531', '532500', '662500', 'L', '3');
INSERT INTO `system_address` VALUES ('2797', '河口瑶族自治县', '532532', '532500', '661300', 'H', '3');
INSERT INTO `system_address` VALUES ('2798', '文山壮族苗族自治州', '532600', '530000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('2799', '文山市', '532621', '532600', '663000', 'W', '3');
INSERT INTO `system_address` VALUES ('2800', '砚山县', '532622', '532600', '663100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2801', '西畴县', '532623', '532600', '663500', 'X', '3');
INSERT INTO `system_address` VALUES ('2802', '麻栗坡县', '532624', '532600', '663600', 'M', '3');
INSERT INTO `system_address` VALUES ('2803', '马关县', '532625', '532600', '663700', 'M', '3');
INSERT INTO `system_address` VALUES ('2804', '丘北县', '532626', '532600', '663200', 'Q', '3');
INSERT INTO `system_address` VALUES ('2805', '广南县', '532627', '532600', '663300', 'G', '3');
INSERT INTO `system_address` VALUES ('2806', '富宁县', '532628', '532600', '663400', 'F', '3');
INSERT INTO `system_address` VALUES ('2807', '西双版纳傣族自治州', '532800', '530000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('2808', '景洪市', '532801', '532800', '666100', 'J', '3');
INSERT INTO `system_address` VALUES ('2809', '勐海县', '532822', '532800', '666200', 'M', '3');
INSERT INTO `system_address` VALUES ('2810', '勐腊县', '532823', '532800', '666300', 'M', '3');
INSERT INTO `system_address` VALUES ('2811', '大理白族自治州', '532900', '530000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2812', '大理市', '532901', '532900', '671000', 'D', '3');
INSERT INTO `system_address` VALUES ('2813', '漾濞彝族自治县', '532922', '532900', '672500', 'Y', '3');
INSERT INTO `system_address` VALUES ('2814', '祥云县', '532923', '532900', '672100', 'X', '3');
INSERT INTO `system_address` VALUES ('2815', '宾川县', '532924', '532900', '671600', 'B', '3');
INSERT INTO `system_address` VALUES ('2816', '弥渡县', '532925', '532900', '675600', 'M', '3');
INSERT INTO `system_address` VALUES ('2817', '南涧彝族自治县', '532926', '532900', '675700', 'N', '3');
INSERT INTO `system_address` VALUES ('2818', '巍山彝族回族自治县', '532927', '532900', '672400', 'W', '3');
INSERT INTO `system_address` VALUES ('2819', '永平县', '532928', '532900', '672600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2820', '云龙县', '532929', '532900', '672700', 'Y', '3');
INSERT INTO `system_address` VALUES ('2821', '洱源县', '532930', '532900', '671200', 'E', '3');
INSERT INTO `system_address` VALUES ('2822', '剑川县', '532931', '532900', '671300', 'J', '3');
INSERT INTO `system_address` VALUES ('2823', '鹤庆县', '532932', '532900', '671500', 'H', '3');
INSERT INTO `system_address` VALUES ('2824', '德宏傣族景颇族自治州', '533100', '530000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2825', '瑞丽市', '533102', '533100', '678600', 'R', '3');
INSERT INTO `system_address` VALUES ('2826', '芒市', '533103', '533100', '678400', 'M', '3');
INSERT INTO `system_address` VALUES ('2827', '梁河县', '533122', '533100', '679200', 'L', '3');
INSERT INTO `system_address` VALUES ('2828', '盈江县', '533123', '533100', '679300', 'Y', '3');
INSERT INTO `system_address` VALUES ('2829', '陇川县', '533124', '533100', '678700', 'L', '3');
INSERT INTO `system_address` VALUES ('2830', '怒江傈僳族自治州', '533300', '530000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('2831', '泸水县', '533321', '533300', '673200', 'L', '3');
INSERT INTO `system_address` VALUES ('2832', '福贡县', '533323', '533300', '673400', 'F', '3');
INSERT INTO `system_address` VALUES ('2833', '贡山独龙族怒族自治县', '533324', '533300', '673500', 'G', '3');
INSERT INTO `system_address` VALUES ('2834', '兰坪白族普米族自治县', '533325', '533300', '671400', 'L', '3');
INSERT INTO `system_address` VALUES ('2835', '迪庆藏族自治州', '533400', '530000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('2836', '香格里拉市', '533421', '533400', '674400', 'X', '3');
INSERT INTO `system_address` VALUES ('2837', '德钦县', '533422', '533400', '674500', 'D', '3');
INSERT INTO `system_address` VALUES ('2838', '维西傈僳族自治县', '533423', '533400', '674600', 'W', '3');
INSERT INTO `system_address` VALUES ('2839', '西藏', '540000', '0', null, 'X', '1');
INSERT INTO `system_address` VALUES ('2840', '拉萨市', '540100', '540000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2841', '城关区', '540102', '540100', '850000', 'C', '3');
INSERT INTO `system_address` VALUES ('2842', '林周县', '540121', '540100', '851600', 'L', '3');
INSERT INTO `system_address` VALUES ('2843', '当雄县', '540122', '540100', '851500', 'D', '3');
INSERT INTO `system_address` VALUES ('2844', '尼木县', '540123', '540100', '851600', 'N', '3');
INSERT INTO `system_address` VALUES ('2845', '曲水县', '540124', '540100', '850600', 'Q', '3');
INSERT INTO `system_address` VALUES ('2846', '堆龙德庆县', '540125', '540100', '851400', 'D', '3');
INSERT INTO `system_address` VALUES ('2847', '达孜县', '540126', '540100', '850100', 'D', '3');
INSERT INTO `system_address` VALUES ('2848', '墨竹工卡县', '540127', '540100', '850200', 'M', '3');
INSERT INTO `system_address` VALUES ('2849', '昌都市', '542100', '540000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('2850', '卡若区', '542121', '542100', '854000', 'K', '3');
INSERT INTO `system_address` VALUES ('2851', '江达县', '542122', '542100', '854100', 'J', '3');
INSERT INTO `system_address` VALUES ('2852', '贡觉县', '542123', '542100', '854200', 'G', '3');
INSERT INTO `system_address` VALUES ('2853', '类乌齐县', '542124', '542100', '855600', 'L', '3');
INSERT INTO `system_address` VALUES ('2854', '丁青县', '542125', '542100', '855700', 'D', '3');
INSERT INTO `system_address` VALUES ('2855', '察雅县', '542126', '542100', '854300', 'C', '3');
INSERT INTO `system_address` VALUES ('2856', '八宿县', '542127', '542100', '854600', 'B', '3');
INSERT INTO `system_address` VALUES ('2857', '左贡县', '542128', '542100', '854400', 'Z', '3');
INSERT INTO `system_address` VALUES ('2858', '芒康县', '542129', '542100', '854500', 'M', '3');
INSERT INTO `system_address` VALUES ('2859', '洛隆县', '542132', '542100', '855400', 'L', '3');
INSERT INTO `system_address` VALUES ('2860', '边坝县', '542133', '542100', '855500', 'B', '3');
INSERT INTO `system_address` VALUES ('2861', '山南地区', '542200', '540000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('2862', '乃东县', '542221', '542200', '856100', 'N', '3');
INSERT INTO `system_address` VALUES ('2863', '扎囊县', '542222', '542200', '850800', 'Z', '3');
INSERT INTO `system_address` VALUES ('2864', '贡嘎县', '542223', '542200', '850700', 'G', '3');
INSERT INTO `system_address` VALUES ('2865', '桑日县', '542224', '542200', '856200', 'S', '3');
INSERT INTO `system_address` VALUES ('2866', '琼结县', '542225', '542200', '856800', 'Q', '3');
INSERT INTO `system_address` VALUES ('2867', '曲松县', '542226', '542200', '856300', 'Q', '3');
INSERT INTO `system_address` VALUES ('2868', '措美县', '542227', '542200', '856900', 'C', '3');
INSERT INTO `system_address` VALUES ('2869', '洛扎县', '542228', '542200', '851200', 'L', '3');
INSERT INTO `system_address` VALUES ('2870', '加查县', '542229', '542200', '856400', 'J', '3');
INSERT INTO `system_address` VALUES ('2871', '隆子县', '542231', '542200', '856600', 'L', '3');
INSERT INTO `system_address` VALUES ('2872', '错那县', '542232', '542200', '856700', 'C', '3');
INSERT INTO `system_address` VALUES ('2873', '浪卡子县', '542233', '542200', '851100', 'L', '3');
INSERT INTO `system_address` VALUES ('2874', '日喀则市', '542300', '540000', null, 'R', '2');
INSERT INTO `system_address` VALUES ('2875', '桑珠孜区', '542301', '542300', '857000', 'S', '3');
INSERT INTO `system_address` VALUES ('2876', '南木林县', '542322', '542300', '857100', 'N', '3');
INSERT INTO `system_address` VALUES ('2877', '江孜县', '542323', '542300', '858100', 'J', '3');
INSERT INTO `system_address` VALUES ('2878', '定日县', '542324', '542300', '858200', 'D', '3');
INSERT INTO `system_address` VALUES ('2879', '萨迦县', '542325', '542300', '857800', 'S', '3');
INSERT INTO `system_address` VALUES ('2880', '拉孜县', '542326', '542300', '858100', 'L', '3');
INSERT INTO `system_address` VALUES ('2881', '昂仁县', '542327', '542300', '858500', 'A', '3');
INSERT INTO `system_address` VALUES ('2882', '谢通门县', '542328', '542300', '858900', 'X', '3');
INSERT INTO `system_address` VALUES ('2883', '白朗县', '542329', '542300', '857300', 'B', '3');
INSERT INTO `system_address` VALUES ('2884', '仁布县', '542330', '542300', '857200', 'R', '3');
INSERT INTO `system_address` VALUES ('2885', '康马县', '542331', '542300', '857500', 'K', '3');
INSERT INTO `system_address` VALUES ('2886', '定结县', '542332', '542300', '857900', 'D', '3');
INSERT INTO `system_address` VALUES ('2887', '仲巴县', '542333', '542300', '858800', 'Z', '3');
INSERT INTO `system_address` VALUES ('2888', '亚东县', '542334', '542300', '857600', 'Y', '3');
INSERT INTO `system_address` VALUES ('2889', '吉隆县', '542335', '542300', '858700', 'J', '3');
INSERT INTO `system_address` VALUES ('2890', '聂拉木县', '542336', '542300', '858300', 'N', '3');
INSERT INTO `system_address` VALUES ('2891', '萨嘎县', '542337', '542300', '858600', 'S', '3');
INSERT INTO `system_address` VALUES ('2892', '岗巴县', '542338', '542300', '857700', 'G', '3');
INSERT INTO `system_address` VALUES ('2893', '那曲地区', '542400', '540000', null, 'N', '2');
INSERT INTO `system_address` VALUES ('2894', '那曲县', '542421', '542400', '852000', 'N', '3');
INSERT INTO `system_address` VALUES ('2895', '嘉黎县', '542422', '542400', '852400', 'J', '3');
INSERT INTO `system_address` VALUES ('2896', '比如县', '542423', '542400', '852300', 'B', '3');
INSERT INTO `system_address` VALUES ('2897', '聂荣县', '542424', '542400', '853500', 'N', '3');
INSERT INTO `system_address` VALUES ('2898', '安多县', '542425', '542400', '853400', 'A', '3');
INSERT INTO `system_address` VALUES ('2899', '申扎县', '542426', '542400', '853100', 'S', '3');
INSERT INTO `system_address` VALUES ('2900', '索县', '542427', '542400', '852200', 'S', '3');
INSERT INTO `system_address` VALUES ('2901', '班戈县', '542428', '542400', '852500', 'B', '3');
INSERT INTO `system_address` VALUES ('2902', '巴青县', '542429', '542400', '852100', 'B', '3');
INSERT INTO `system_address` VALUES ('2903', '尼玛县', '542430', '542400', '853200', 'N', '3');
INSERT INTO `system_address` VALUES ('2904', '双湖县', '542432', '542400', '853300', 'S', '3');
INSERT INTO `system_address` VALUES ('2905', '阿里地区', '542500', '540000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('2906', '普兰县', '542521', '542500', '859500', 'P', '3');
INSERT INTO `system_address` VALUES ('2907', '札达县', '542522', '542500', '859600', 'Z', '3');
INSERT INTO `system_address` VALUES ('2908', '噶尔县', '542523', '542500', '859000', 'G', '3');
INSERT INTO `system_address` VALUES ('2909', '日土县', '542524', '542500', '859700', 'R', '3');
INSERT INTO `system_address` VALUES ('2910', '革吉县', '542525', '542500', '859100', 'G', '3');
INSERT INTO `system_address` VALUES ('2911', '改则县', '542526', '542500', '859200', 'G', '3');
INSERT INTO `system_address` VALUES ('2912', '措勤县', '542527', '542500', '859300', 'C', '3');
INSERT INTO `system_address` VALUES ('2913', '林芝市', '542600', '540000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('2914', '巴宜区', '542621', '542600', '860000', 'B', '3');
INSERT INTO `system_address` VALUES ('2915', '工布江达县', '542622', '542600', '860200', 'G', '3');
INSERT INTO `system_address` VALUES ('2916', '米林县', '542623', '542600', '860500', 'M', '3');
INSERT INTO `system_address` VALUES ('2917', '墨脱县', '542624', '542600', '860700', 'M', '3');
INSERT INTO `system_address` VALUES ('2918', '波密县', '542625', '542600', '860300', 'B', '3');
INSERT INTO `system_address` VALUES ('2919', '察隅县', '542626', '542600', '860600', 'C', '3');
INSERT INTO `system_address` VALUES ('2920', '朗县', '542627', '542600', '860400', 'L', '3');
INSERT INTO `system_address` VALUES ('2921', '陕西', '610000', '0', null, 'S', '1');
INSERT INTO `system_address` VALUES ('2922', '西安市', '610100', '610000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('2923', '新城区', '610102', '610100', '710000', 'X', '3');
INSERT INTO `system_address` VALUES ('2924', '碑林区', '610103', '610100', '710000', 'B', '3');
INSERT INTO `system_address` VALUES ('2925', '莲湖区', '610104', '610100', '710000', 'L', '3');
INSERT INTO `system_address` VALUES ('2926', '灞桥区', '610111', '610100', '710000', 'B', '3');
INSERT INTO `system_address` VALUES ('2927', '未央区', '610112', '610100', '710000', 'W', '3');
INSERT INTO `system_address` VALUES ('2928', '雁塔区', '610113', '610100', '710000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2929', '阎良区', '610114', '610100', '710000', 'Y', '3');
INSERT INTO `system_address` VALUES ('2930', '临潼区', '610115', '610100', '710600', 'L', '3');
INSERT INTO `system_address` VALUES ('2931', '长安区', '610116', '610100', '710100', 'Z', '3');
INSERT INTO `system_address` VALUES ('2932', '高陵区', '610117', '610100', '710200', 'G', '3');
INSERT INTO `system_address` VALUES ('2933', '蓝田县', '610122', '610100', '710500', 'L', '3');
INSERT INTO `system_address` VALUES ('2934', '周至县', '610124', '610100', '710400', 'Z', '3');
INSERT INTO `system_address` VALUES ('2935', '户县', '610125', '610100', '710300', 'H', '3');
INSERT INTO `system_address` VALUES ('2936', '高陵区', '610126', '610100', '710200', 'G', '3');
INSERT INTO `system_address` VALUES ('2937', '曲江新区', '610199', '610100', '710000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2938', '铜川市', '610200', '610000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('2939', '王益区', '610202', '610200', '727000', 'W', '3');
INSERT INTO `system_address` VALUES ('2940', '印台区', '610203', '610200', '727007', 'Y', '3');
INSERT INTO `system_address` VALUES ('2941', '耀州区', '610204', '610200', '727100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2942', '宜君县', '610222', '610200', '727200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2943', '宝鸡市', '610300', '610000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('2944', '渭滨区', '610302', '610300', '721000', 'W', '3');
INSERT INTO `system_address` VALUES ('2945', '金台区', '610303', '610300', '721000', 'J', '3');
INSERT INTO `system_address` VALUES ('2946', '陈仓区', '610304', '610300', '721300', 'C', '3');
INSERT INTO `system_address` VALUES ('2947', '凤翔县', '610322', '610300', '721400', 'F', '3');
INSERT INTO `system_address` VALUES ('2948', '岐山县', '610323', '610300', '722400', 'Q', '3');
INSERT INTO `system_address` VALUES ('2949', '扶风县', '610324', '610300', '722200', 'F', '3');
INSERT INTO `system_address` VALUES ('2950', '眉县', '610326', '610300', '722300', 'M', '3');
INSERT INTO `system_address` VALUES ('2951', '陇县', '610327', '610300', '721200', 'L', '3');
INSERT INTO `system_address` VALUES ('2952', '千阳县', '610328', '610300', '721100', 'Q', '3');
INSERT INTO `system_address` VALUES ('2953', '麟游县', '610329', '610300', '721500', 'L', '3');
INSERT INTO `system_address` VALUES ('2954', '凤县', '610330', '610300', '721700', 'F', '3');
INSERT INTO `system_address` VALUES ('2955', '太白县', '610331', '610300', '721600', 'T', '3');
INSERT INTO `system_address` VALUES ('2956', '咸阳市', '610400', '610000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('2957', '秦都区', '610402', '610400', '712000', 'Q', '3');
INSERT INTO `system_address` VALUES ('2958', '杨陵区', '610403', '610400', '712100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2959', '渭城区', '610404', '610400', '712000', 'W', '3');
INSERT INTO `system_address` VALUES ('2960', '三原县', '610422', '610400', '713800', 'S', '3');
INSERT INTO `system_address` VALUES ('2961', '泾阳县', '610423', '610400', '713700', 'J', '3');
INSERT INTO `system_address` VALUES ('2962', '乾县', '610424', '610400', '713300', 'Q', '3');
INSERT INTO `system_address` VALUES ('2963', '礼泉县', '610425', '610400', '713200', 'L', '3');
INSERT INTO `system_address` VALUES ('2964', '永寿县', '610426', '610400', '713400', 'Y', '3');
INSERT INTO `system_address` VALUES ('2965', '彬县', '610427', '610400', '713500', 'B', '3');
INSERT INTO `system_address` VALUES ('2966', '长武县', '610428', '610400', '713600', 'Z', '3');
INSERT INTO `system_address` VALUES ('2967', '旬邑县', '610429', '610400', '711300', 'X', '3');
INSERT INTO `system_address` VALUES ('2968', '淳化县', '610430', '610400', '711200', 'C', '3');
INSERT INTO `system_address` VALUES ('2969', '武功县', '610431', '610400', '712200', 'W', '3');
INSERT INTO `system_address` VALUES ('2970', '兴平市', '610481', '610400', '713100', 'X', '3');
INSERT INTO `system_address` VALUES ('2971', '渭南市', '610500', '610000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('2972', '临渭区', '610502', '610500', '714000', 'L', '3');
INSERT INTO `system_address` VALUES ('2973', '华县', '610521', '610500', '714100', 'H', '3');
INSERT INTO `system_address` VALUES ('2974', '潼关县', '610522', '610500', '714300', 'T', '3');
INSERT INTO `system_address` VALUES ('2975', '大荔县', '610523', '610500', '715100', 'D', '3');
INSERT INTO `system_address` VALUES ('2976', '合阳县', '610524', '610500', '715300', 'H', '3');
INSERT INTO `system_address` VALUES ('2977', '澄城县', '610525', '610500', '715200', 'C', '3');
INSERT INTO `system_address` VALUES ('2978', '蒲城县', '610526', '610500', '715500', 'P', '3');
INSERT INTO `system_address` VALUES ('2979', '白水县', '610527', '610500', '715600', 'B', '3');
INSERT INTO `system_address` VALUES ('2980', '富平县', '610528', '610500', '711700', 'F', '3');
INSERT INTO `system_address` VALUES ('2981', '韩城市', '610581', '610500', '715400', 'H', '3');
INSERT INTO `system_address` VALUES ('2982', '华阴市', '610582', '610500', '714200', 'H', '3');
INSERT INTO `system_address` VALUES ('2983', '延安市', '610600', '610000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('2984', '宝塔区', '610602', '610600', '716000', 'B', '3');
INSERT INTO `system_address` VALUES ('2985', '延长县', '610621', '610600', '717100', 'Y', '3');
INSERT INTO `system_address` VALUES ('2986', '延川县', '610622', '610600', '717200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2987', '子长县', '610623', '610600', '717300', 'Z', '3');
INSERT INTO `system_address` VALUES ('2988', '安塞县', '610624', '610600', '717400', 'A', '3');
INSERT INTO `system_address` VALUES ('2989', '志丹县', '610625', '610600', '717500', 'Z', '3');
INSERT INTO `system_address` VALUES ('2990', '吴起县', '610626', '610600', '717600', 'W', '3');
INSERT INTO `system_address` VALUES ('2991', '甘泉县', '610627', '610600', '716100', 'G', '3');
INSERT INTO `system_address` VALUES ('2992', '富县', '610628', '610600', '727500', 'F', '3');
INSERT INTO `system_address` VALUES ('2993', '洛川县', '610629', '610600', '727400', 'L', '3');
INSERT INTO `system_address` VALUES ('2994', '宜川县', '610630', '610600', '716200', 'Y', '3');
INSERT INTO `system_address` VALUES ('2995', '黄龙县', '610631', '610600', '715700', 'H', '3');
INSERT INTO `system_address` VALUES ('2996', '黄陵县', '610632', '610600', '727300', 'H', '3');
INSERT INTO `system_address` VALUES ('2997', '汉中市', '610700', '610000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('2998', '汉台区', '610702', '610700', '723000', 'H', '3');
INSERT INTO `system_address` VALUES ('2999', '南郑县', '610721', '610700', '723100', 'N', '3');
INSERT INTO `system_address` VALUES ('3000', '城固县', '610722', '610700', '723200', 'C', '3');
INSERT INTO `system_address` VALUES ('3001', '洋县', '610723', '610700', '723300', 'Y', '3');
INSERT INTO `system_address` VALUES ('3002', '西乡县', '610724', '610700', '723500', 'X', '3');
INSERT INTO `system_address` VALUES ('3003', '勉县', '610725', '610700', '724200', 'M', '3');
INSERT INTO `system_address` VALUES ('3004', '宁强县', '610726', '610700', '724400', 'N', '3');
INSERT INTO `system_address` VALUES ('3005', '略阳县', '610727', '610700', '724300', 'L', '3');
INSERT INTO `system_address` VALUES ('3006', '镇巴县', '610728', '610700', '723600', 'Z', '3');
INSERT INTO `system_address` VALUES ('3007', '留坝县', '610729', '610700', '724100', 'L', '3');
INSERT INTO `system_address` VALUES ('3008', '佛坪县', '610730', '610700', '723400', 'F', '3');
INSERT INTO `system_address` VALUES ('3009', '榆林市', '610800', '610000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('3010', '榆阳区', '610802', '610800', '719000', 'Y', '3');
INSERT INTO `system_address` VALUES ('3011', '神木县', '610821', '610800', '719300', 'S', '3');
INSERT INTO `system_address` VALUES ('3012', '府谷县', '610822', '610800', '719400', 'F', '3');
INSERT INTO `system_address` VALUES ('3013', '横山县', '610823', '610800', '719200', 'H', '3');
INSERT INTO `system_address` VALUES ('3014', '靖边县', '610824', '610800', '718500', 'J', '3');
INSERT INTO `system_address` VALUES ('3015', '定边县', '610825', '610800', '718600', 'D', '3');
INSERT INTO `system_address` VALUES ('3016', '绥德县', '610826', '610800', '718000', 'S', '3');
INSERT INTO `system_address` VALUES ('3017', '米脂县', '610827', '610800', '718100', 'M', '3');
INSERT INTO `system_address` VALUES ('3018', '佳县', '610828', '610800', '719200', 'J', '3');
INSERT INTO `system_address` VALUES ('3019', '吴堡县', '610829', '610800', '718200', 'W', '3');
INSERT INTO `system_address` VALUES ('3020', '清涧县', '610830', '610800', '718300', 'Q', '3');
INSERT INTO `system_address` VALUES ('3021', '子洲县', '610831', '610800', '718400', 'Z', '3');
INSERT INTO `system_address` VALUES ('3022', '安康市', '610900', '610000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('3023', '汉滨区', '610902', '610900', '725000', 'H', '3');
INSERT INTO `system_address` VALUES ('3024', '汉阴县', '610921', '610900', '725100', 'H', '3');
INSERT INTO `system_address` VALUES ('3025', '石泉县', '610922', '610900', '725200', 'S', '3');
INSERT INTO `system_address` VALUES ('3026', '宁陕县', '610923', '610900', '711600', 'N', '3');
INSERT INTO `system_address` VALUES ('3027', '紫阳县', '610924', '610900', '725300', 'Z', '3');
INSERT INTO `system_address` VALUES ('3028', '岚皋县', '610925', '610900', '725400', 'L', '3');
INSERT INTO `system_address` VALUES ('3029', '平利县', '610926', '610900', '725500', 'P', '3');
INSERT INTO `system_address` VALUES ('3030', '镇坪县', '610927', '610900', '725600', 'Z', '3');
INSERT INTO `system_address` VALUES ('3031', '旬阳县', '610928', '610900', '725700', 'X', '3');
INSERT INTO `system_address` VALUES ('3032', '白河县', '610929', '610900', '725800', 'B', '3');
INSERT INTO `system_address` VALUES ('3033', '商洛市', '611000', '610000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3034', '商州区', '611002', '611000', '726000', 'S', '3');
INSERT INTO `system_address` VALUES ('3035', '洛南县', '611021', '611000', '726100', 'L', '3');
INSERT INTO `system_address` VALUES ('3036', '丹凤县', '611022', '611000', '726200', 'D', '3');
INSERT INTO `system_address` VALUES ('3037', '商南县', '611023', '611000', '726300', 'S', '3');
INSERT INTO `system_address` VALUES ('3038', '山阳县', '611024', '611000', '726400', 'S', '3');
INSERT INTO `system_address` VALUES ('3039', '镇安县', '611025', '611000', '711500', 'Z', '3');
INSERT INTO `system_address` VALUES ('3040', '柞水县', '611026', '611000', '711400', 'Z', '3');
INSERT INTO `system_address` VALUES ('3041', '甘肃', '620000', '0', null, 'G', '1');
INSERT INTO `system_address` VALUES ('3042', '兰州市', '620100', '620000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('3043', '城关区', '620102', '620100', '730030', 'C', '3');
INSERT INTO `system_address` VALUES ('3044', '七里河区', '620103', '620100', '730050', 'Q', '3');
INSERT INTO `system_address` VALUES ('3045', '西固区', '620104', '620100', '730060', 'X', '3');
INSERT INTO `system_address` VALUES ('3046', '安宁区', '620105', '620100', '730070', 'A', '3');
INSERT INTO `system_address` VALUES ('3047', '红古区', '620111', '620100', '730080', 'H', '3');
INSERT INTO `system_address` VALUES ('3048', '永登县', '620121', '620100', '730300', 'Y', '3');
INSERT INTO `system_address` VALUES ('3049', '皋兰县', '620122', '620100', '730200', 'G', '3');
INSERT INTO `system_address` VALUES ('3050', '榆中县', '620123', '620100', '730100', 'Y', '3');
INSERT INTO `system_address` VALUES ('3051', '兰州新区', '1000665', '620100', '730000', 'L', '3');
INSERT INTO `system_address` VALUES ('3052', '嘉峪关市', '620200', '620000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('3053', '金昌市', '620300', '620000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('3054', '金川区', '620302', '620300', '737100', 'J', '3');
INSERT INTO `system_address` VALUES ('3055', '永昌县', '620321', '620300', '737200', 'Y', '3');
INSERT INTO `system_address` VALUES ('3056', '白银市', '620400', '620000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('3057', '白银区', '620402', '620400', '730900', 'B', '3');
INSERT INTO `system_address` VALUES ('3058', '平川区', '620403', '620400', '730900', 'P', '3');
INSERT INTO `system_address` VALUES ('3059', '靖远县', '620421', '620400', '730600', 'J', '3');
INSERT INTO `system_address` VALUES ('3060', '会宁县', '620422', '620400', '730700', 'H', '3');
INSERT INTO `system_address` VALUES ('3061', '景泰县', '620423', '620400', '730400', 'J', '3');
INSERT INTO `system_address` VALUES ('3062', '天水市', '620500', '620000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3063', '秦州区', '620502', '620500', '741000', 'Q', '3');
INSERT INTO `system_address` VALUES ('3064', '麦积区', '620503', '620500', '741020', 'M', '3');
INSERT INTO `system_address` VALUES ('3065', '清水县', '620521', '620500', '741400', 'Q', '3');
INSERT INTO `system_address` VALUES ('3066', '秦安县', '620522', '620500', '741600', 'Q', '3');
INSERT INTO `system_address` VALUES ('3067', '甘谷县', '620523', '620500', '741200', 'G', '3');
INSERT INTO `system_address` VALUES ('3068', '武山县', '620524', '620500', '741300', 'W', '3');
INSERT INTO `system_address` VALUES ('3069', '张家川回族自治县', '620525', '620500', '741500', 'Z', '3');
INSERT INTO `system_address` VALUES ('3070', '武威市', '620600', '620000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('3071', '凉州区', '620602', '620600', '733000', 'L', '3');
INSERT INTO `system_address` VALUES ('3072', '民勤县', '620621', '620600', '733300', 'M', '3');
INSERT INTO `system_address` VALUES ('3073', '古浪县', '620622', '620600', '733100', 'G', '3');
INSERT INTO `system_address` VALUES ('3074', '天祝藏族自治县', '620623', '620600', '733200', 'T', '3');
INSERT INTO `system_address` VALUES ('3075', '张掖市', '620700', '620000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('3076', '甘州区', '620702', '620700', '734000', 'G', '3');
INSERT INTO `system_address` VALUES ('3077', '肃南裕固族自治县', '620721', '620700', '734400', 'S', '3');
INSERT INTO `system_address` VALUES ('3078', '民乐县', '620722', '620700', '734500', 'M', '3');
INSERT INTO `system_address` VALUES ('3079', '临泽县', '620723', '620700', '734200', 'L', '3');
INSERT INTO `system_address` VALUES ('3080', '高台县', '620724', '620700', '734300', 'G', '3');
INSERT INTO `system_address` VALUES ('3081', '山丹县', '620725', '620700', '734100', 'S', '3');
INSERT INTO `system_address` VALUES ('3082', '平凉市', '620800', '620000', null, 'P', '2');
INSERT INTO `system_address` VALUES ('3083', '崆峒区', '620802', '620800', '744000', 'K', '3');
INSERT INTO `system_address` VALUES ('3084', '泾川县', '620821', '620800', '744300', 'J', '3');
INSERT INTO `system_address` VALUES ('3085', '灵台县', '620822', '620800', '744400', 'L', '3');
INSERT INTO `system_address` VALUES ('3086', '崇信县', '620823', '620800', '744200', 'C', '3');
INSERT INTO `system_address` VALUES ('3087', '华亭县', '620824', '620800', '744100', 'H', '3');
INSERT INTO `system_address` VALUES ('3088', '庄浪县', '620825', '620800', '744600', 'Z', '3');
INSERT INTO `system_address` VALUES ('3089', '静宁县', '620826', '620800', '743400', 'J', '3');
INSERT INTO `system_address` VALUES ('3090', '酒泉市', '620900', '620000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('3091', '肃州区', '620902', '620900', '735000', 'S', '3');
INSERT INTO `system_address` VALUES ('3092', '金塔县', '620921', '620900', '735300', 'J', '3');
INSERT INTO `system_address` VALUES ('3093', '瓜州县', '620922', '620900', '736100', 'G', '3');
INSERT INTO `system_address` VALUES ('3094', '肃北蒙古族自治县', '620923', '620900', '736300', 'S', '3');
INSERT INTO `system_address` VALUES ('3095', '阿克塞哈萨克族自治县', '620924', '620900', '736400', 'A', '3');
INSERT INTO `system_address` VALUES ('3096', '玉门市', '620981', '620900', '735200', 'Y', '3');
INSERT INTO `system_address` VALUES ('3097', '敦煌市', '620982', '620900', '736200', 'D', '3');
INSERT INTO `system_address` VALUES ('3098', '庆阳市', '621000', '620000', null, 'Q', '2');
INSERT INTO `system_address` VALUES ('3099', '西峰区', '621002', '621000', '745000', 'X', '3');
INSERT INTO `system_address` VALUES ('3100', '庆城县', '621021', '621000', '745100', 'Q', '3');
INSERT INTO `system_address` VALUES ('3101', '环县', '621022', '621000', '745700', 'H', '3');
INSERT INTO `system_address` VALUES ('3102', '华池县', '621023', '621000', '745600', 'H', '3');
INSERT INTO `system_address` VALUES ('3103', '合水县', '621024', '621000', '745400', 'H', '3');
INSERT INTO `system_address` VALUES ('3104', '正宁县', '621025', '621000', '745300', 'Z', '3');
INSERT INTO `system_address` VALUES ('3105', '宁县', '621026', '621000', '745200', 'N', '3');
INSERT INTO `system_address` VALUES ('3106', '镇原县', '621027', '621000', '744500', 'Z', '3');
INSERT INTO `system_address` VALUES ('3107', '定西市', '621100', '620000', null, 'D', '2');
INSERT INTO `system_address` VALUES ('3108', '安定区', '621102', '621100', '744300', 'A', '3');
INSERT INTO `system_address` VALUES ('3109', '通渭县', '621121', '621100', '743300', 'T', '3');
INSERT INTO `system_address` VALUES ('3110', '陇西县', '621122', '621100', '748100', 'L', '3');
INSERT INTO `system_address` VALUES ('3111', '渭源县', '621123', '621100', '748200', 'W', '3');
INSERT INTO `system_address` VALUES ('3112', '临洮县', '621124', '621100', '730500', 'L', '3');
INSERT INTO `system_address` VALUES ('3113', '漳县', '621125', '621100', '748300', 'Z', '3');
INSERT INTO `system_address` VALUES ('3114', '岷县', '621126', '621100', '748400', 'M', '3');
INSERT INTO `system_address` VALUES ('3115', '陇南市', '621200', '620000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('3116', '武都区', '621202', '621200', '746000', 'W', '3');
INSERT INTO `system_address` VALUES ('3117', '成县', '621221', '621200', '742500', 'C', '3');
INSERT INTO `system_address` VALUES ('3118', '文县', '621222', '621200', '746400', 'W', '3');
INSERT INTO `system_address` VALUES ('3119', '宕昌县', '621223', '621200', '748500', 'D', '3');
INSERT INTO `system_address` VALUES ('3120', '康县', '621224', '621200', '746500', 'K', '3');
INSERT INTO `system_address` VALUES ('3121', '西和县', '621225', '621200', '742100', 'X', '3');
INSERT INTO `system_address` VALUES ('3122', '礼县', '621226', '621200', '742200', 'L', '3');
INSERT INTO `system_address` VALUES ('3123', '徽县', '621227', '621200', '742300', 'H', '3');
INSERT INTO `system_address` VALUES ('3124', '两当县', '621228', '621200', '742400', 'L', '3');
INSERT INTO `system_address` VALUES ('3125', '临夏回族自治州', '622900', '620000', null, 'L', '2');
INSERT INTO `system_address` VALUES ('3126', '临夏市', '622901', '622900', '731100', 'L', '3');
INSERT INTO `system_address` VALUES ('3127', '临夏县', '622921', '622900', '731800', 'L', '3');
INSERT INTO `system_address` VALUES ('3128', '康乐县', '622922', '622900', '731500', 'K', '3');
INSERT INTO `system_address` VALUES ('3129', '永靖县', '622923', '622900', '731600', 'Y', '3');
INSERT INTO `system_address` VALUES ('3130', '广河县', '622924', '622900', '731300', 'G', '3');
INSERT INTO `system_address` VALUES ('3131', '和政县', '622925', '622900', '731200', 'H', '3');
INSERT INTO `system_address` VALUES ('3132', '东乡族自治县', '622926', '622900', '731400', 'D', '3');
INSERT INTO `system_address` VALUES ('3133', '积石山保安族东乡族撒拉族自治县', '622927', '622900', '731700', 'J', '3');
INSERT INTO `system_address` VALUES ('3134', '甘南藏族自治州', '623000', '620000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('3135', '合作市', '623001', '623000', '747000', 'H', '3');
INSERT INTO `system_address` VALUES ('3136', '临潭县', '623021', '623000', '747500', 'L', '3');
INSERT INTO `system_address` VALUES ('3137', '卓尼县', '623022', '623000', '747600', 'Z', '3');
INSERT INTO `system_address` VALUES ('3138', '舟曲县', '623023', '623000', '746300', 'Z', '3');
INSERT INTO `system_address` VALUES ('3139', '迭部县', '623024', '623000', '747400', 'D', '3');
INSERT INTO `system_address` VALUES ('3140', '玛曲县', '623025', '623000', '747300', 'M', '3');
INSERT INTO `system_address` VALUES ('3141', '碌曲县', '623026', '623000', '747200', 'L', '3');
INSERT INTO `system_address` VALUES ('3142', '夏河县', '623027', '623000', '747100', 'X', '3');
INSERT INTO `system_address` VALUES ('3143', '青海', '630000', '0', null, 'Q', '1');
INSERT INTO `system_address` VALUES ('3144', '西宁市', '630100', '630000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('3145', '城东区', '630102', '630100', '810000', 'C', '3');
INSERT INTO `system_address` VALUES ('3146', '城中区', '630103', '630100', '810000', 'C', '3');
INSERT INTO `system_address` VALUES ('3147', '城西区', '630104', '630100', '810000', 'C', '3');
INSERT INTO `system_address` VALUES ('3148', '城北区', '630105', '630100', '810000', 'C', '3');
INSERT INTO `system_address` VALUES ('3149', '大通回族土族自治县', '630121', '630100', '810100', 'D', '3');
INSERT INTO `system_address` VALUES ('3150', '湟中县', '630122', '630100', '811600', 'H', '3');
INSERT INTO `system_address` VALUES ('3151', '湟源县', '630123', '630100', '812100', 'H', '3');
INSERT INTO `system_address` VALUES ('3152', '海东市', '632100', '630000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3153', '平安区', '632121', '632100', '810600', 'P', '3');
INSERT INTO `system_address` VALUES ('3154', '民和回族土族自治县', '632122', '632100', '810800', 'M', '3');
INSERT INTO `system_address` VALUES ('3155', '乐都区', '632123', '632100', '810700', 'L', '3');
INSERT INTO `system_address` VALUES ('3156', '互助土族自治县', '632126', '632100', '810500', 'H', '3');
INSERT INTO `system_address` VALUES ('3157', '化隆回族自治县', '632127', '632100', '810900', 'H', '3');
INSERT INTO `system_address` VALUES ('3158', '循化撒拉族自治县', '632128', '632100', '811100', 'X', '3');
INSERT INTO `system_address` VALUES ('3159', '海北藏族自治州', '632200', '630000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3160', '门源回族自治县', '632221', '632200', '810300', 'M', '3');
INSERT INTO `system_address` VALUES ('3161', '祁连县', '632222', '632200', '810400', 'Q', '3');
INSERT INTO `system_address` VALUES ('3162', '海晏县', '632223', '632200', '812200', 'H', '3');
INSERT INTO `system_address` VALUES ('3163', '刚察县', '632224', '632200', '812300', 'G', '3');
INSERT INTO `system_address` VALUES ('3164', '黄南藏族自治州', '632300', '630000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3165', '同仁县', '632321', '632300', '811300', 'T', '3');
INSERT INTO `system_address` VALUES ('3166', '尖扎县', '632322', '632300', '811200', 'J', '3');
INSERT INTO `system_address` VALUES ('3167', '泽库县', '632323', '632300', '811400', 'Z', '3');
INSERT INTO `system_address` VALUES ('3168', '河南蒙古族自治县', '632324', '632300', '811500', 'H', '3');
INSERT INTO `system_address` VALUES ('3169', '海南藏族自治州', '632500', '630000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3170', '共和县', '632521', '632500', '813000', 'G', '3');
INSERT INTO `system_address` VALUES ('3171', '同德县', '632522', '632500', '813200', 'T', '3');
INSERT INTO `system_address` VALUES ('3172', '贵德县', '632523', '632500', '811700', 'G', '3');
INSERT INTO `system_address` VALUES ('3173', '兴海县', '632524', '632500', '813300', 'X', '3');
INSERT INTO `system_address` VALUES ('3174', '贵南县', '632525', '632500', '813100', 'G', '3');
INSERT INTO `system_address` VALUES ('3175', '果洛藏族自治州', '632600', '630000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('3176', '玛沁县', '632621', '632600', '814000', 'M', '3');
INSERT INTO `system_address` VALUES ('3177', '班玛县', '632622', '632600', '814300', 'B', '3');
INSERT INTO `system_address` VALUES ('3178', '甘德县', '632623', '632600', '814100', 'G', '3');
INSERT INTO `system_address` VALUES ('3179', '达日县', '632624', '632600', '814200', 'D', '3');
INSERT INTO `system_address` VALUES ('3180', '久治县', '632625', '632600', '624700', 'J', '3');
INSERT INTO `system_address` VALUES ('3181', '玛多县', '632626', '632600', '813500', 'M', '3');
INSERT INTO `system_address` VALUES ('3182', '玉树藏族自治州', '632700', '630000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('3183', '玉树市', '632721', '632700', '815000', 'Y', '3');
INSERT INTO `system_address` VALUES ('3184', '杂多县', '632722', '632700', '815300', 'Z', '3');
INSERT INTO `system_address` VALUES ('3185', '称多县', '632723', '632700', '815100', 'C', '3');
INSERT INTO `system_address` VALUES ('3186', '治多县', '632724', '632700', '815400', 'Z', '3');
INSERT INTO `system_address` VALUES ('3187', '囊谦县', '632725', '632700', '815200', 'N', '3');
INSERT INTO `system_address` VALUES ('3188', '曲麻莱县', '632726', '632700', '815500', 'Q', '3');
INSERT INTO `system_address` VALUES ('3189', '海西蒙古族藏族自治州', '632800', '630000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3190', '格尔木市', '632801', '632800', '816000', 'G', '3');
INSERT INTO `system_address` VALUES ('3191', '德令哈市', '632802', '632800', '817000', 'D', '3');
INSERT INTO `system_address` VALUES ('3192', '乌兰县', '632821', '632800', '817100', 'W', '3');
INSERT INTO `system_address` VALUES ('3193', '都兰县', '632822', '632800', '816100', 'D', '3');
INSERT INTO `system_address` VALUES ('3194', '天峻县', '632823', '632800', '817200', 'T', '3');
INSERT INTO `system_address` VALUES ('3195', '宁夏', '640000', '0', null, 'N', '1');
INSERT INTO `system_address` VALUES ('3196', '银川市', '640100', '640000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('3197', '兴庆区', '640104', '640100', '750000', 'X', '3');
INSERT INTO `system_address` VALUES ('3198', '西夏区', '640105', '640100', '750000', 'X', '3');
INSERT INTO `system_address` VALUES ('3199', '金凤区', '640106', '640100', '750000', 'J', '3');
INSERT INTO `system_address` VALUES ('3200', '永宁县', '640121', '640100', '750100', 'Y', '3');
INSERT INTO `system_address` VALUES ('3201', '贺兰县', '640122', '640100', '750200', 'H', '3');
INSERT INTO `system_address` VALUES ('3202', '灵武市', '640181', '640100', '751400', 'L', '3');
INSERT INTO `system_address` VALUES ('3203', '石嘴山市', '640200', '640000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3204', '大武口区', '640202', '640200', '753000', 'D', '3');
INSERT INTO `system_address` VALUES ('3205', '惠农区', '640205', '640200', '753600', 'H', '3');
INSERT INTO `system_address` VALUES ('3206', '平罗县', '640221', '640200', '753400', 'P', '3');
INSERT INTO `system_address` VALUES ('3207', '吴忠市', '640300', '640000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('3208', '利通区', '640302', '640300', '751100', 'L', '3');
INSERT INTO `system_address` VALUES ('3209', '红寺堡区', '640303', '640300', '751900', 'H', '3');
INSERT INTO `system_address` VALUES ('3210', '盐池县', '640323', '640300', '751500', 'Y', '3');
INSERT INTO `system_address` VALUES ('3211', '同心县', '640324', '640300', '751300', 'T', '3');
INSERT INTO `system_address` VALUES ('3212', '青铜峡市', '640381', '640300', '751600', 'Q', '3');
INSERT INTO `system_address` VALUES ('3213', '固原市', '640400', '640000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('3214', '原州区', '640402', '640400', '756000', 'Y', '3');
INSERT INTO `system_address` VALUES ('3215', '西吉县', '640422', '640400', '756200', 'X', '3');
INSERT INTO `system_address` VALUES ('3216', '隆德县', '640423', '640400', '756300', 'L', '3');
INSERT INTO `system_address` VALUES ('3217', '泾源县', '640424', '640400', '756400', 'J', '3');
INSERT INTO `system_address` VALUES ('3218', '彭阳县', '640425', '640400', '756500', 'P', '3');
INSERT INTO `system_address` VALUES ('3219', '中卫市', '640500', '640000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('3220', '沙坡头区', '640502', '640500', '755000', 'S', '3');
INSERT INTO `system_address` VALUES ('3221', '中宁县', '640521', '640500', '755100', 'Z', '3');
INSERT INTO `system_address` VALUES ('3222', '海原县', '640522', '640500', '755200', 'H', '3');
INSERT INTO `system_address` VALUES ('3223', '新疆', '650000', '0', null, 'X', '1');
INSERT INTO `system_address` VALUES ('3224', '乌鲁木齐市', '650100', '650000', null, 'W', '2');
INSERT INTO `system_address` VALUES ('3225', '天山区', '650102', '650100', '830000', 'T', '3');
INSERT INTO `system_address` VALUES ('3226', '沙依巴克区', '650103', '650100', '830000', 'S', '3');
INSERT INTO `system_address` VALUES ('3227', '新市区', '650104', '650100', '830000', 'X', '3');
INSERT INTO `system_address` VALUES ('3228', '水磨沟区', '650105', '650100', '830017', 'S', '3');
INSERT INTO `system_address` VALUES ('3229', '头屯河区', '650106', '650100', '830000', 'T', '3');
INSERT INTO `system_address` VALUES ('3230', '达坂城区', '650107', '650100', '830039', 'D', '3');
INSERT INTO `system_address` VALUES ('3231', '米东区', '650109', '650100', '831400', 'M', '3');
INSERT INTO `system_address` VALUES ('3232', '乌鲁木齐县', '650121', '650100', '830000', 'W', '3');
INSERT INTO `system_address` VALUES ('3233', '克拉玛依市', '650200', '650000', null, 'K', '2');
INSERT INTO `system_address` VALUES ('3234', '独山子区', '650202', '650200', '838600', 'D', '3');
INSERT INTO `system_address` VALUES ('3235', '克拉玛依区', '650203', '650200', '834000', 'K', '3');
INSERT INTO `system_address` VALUES ('3236', '白碱滩区', '650204', '650200', '834000', 'B', '3');
INSERT INTO `system_address` VALUES ('3237', '乌尔禾区', '650205', '650200', '834000', 'W', '3');
INSERT INTO `system_address` VALUES ('3238', '吐鲁番市', '652100', '650000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3239', '高昌区', '652101', '652100', '838000', 'G', '3');
INSERT INTO `system_address` VALUES ('3240', '鄯善县', '652122', '652100', '838200', 'S', '3');
INSERT INTO `system_address` VALUES ('3241', '托克逊县', '652123', '652100', '838100', 'T', '3');
INSERT INTO `system_address` VALUES ('3242', '哈密地区', '652200', '650000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3243', '哈密市', '652201', '652200', '839000', 'H', '3');
INSERT INTO `system_address` VALUES ('3244', '巴里坤哈萨克自治县', '652222', '652200', '839200', 'B', '3');
INSERT INTO `system_address` VALUES ('3245', '伊吾县', '652223', '652200', '839300', 'Y', '3');
INSERT INTO `system_address` VALUES ('3246', '昌吉回族自治州', '652300', '650000', null, 'C', '2');
INSERT INTO `system_address` VALUES ('3247', '昌吉市', '652301', '652300', '831100', 'C', '3');
INSERT INTO `system_address` VALUES ('3248', '阜康市', '652302', '652300', '831500', 'F', '3');
INSERT INTO `system_address` VALUES ('3249', '呼图壁县', '652323', '652300', '831200', 'H', '3');
INSERT INTO `system_address` VALUES ('3250', '玛纳斯县', '652324', '652300', '832200', 'M', '3');
INSERT INTO `system_address` VALUES ('3251', '奇台县', '652325', '652300', '831800', 'Q', '3');
INSERT INTO `system_address` VALUES ('3252', '吉木萨尔县', '652327', '652300', '831700', 'J', '3');
INSERT INTO `system_address` VALUES ('3253', '木垒哈萨克自治县', '652328', '652300', '831900', 'M', '3');
INSERT INTO `system_address` VALUES ('3254', '博尔塔拉蒙古自治州', '652700', '650000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('3255', '博乐市', '652701', '652700', '833400', 'B', '3');
INSERT INTO `system_address` VALUES ('3256', '阿拉山口市', '652702', '652700', '833418', 'A', '3');
INSERT INTO `system_address` VALUES ('3257', '精河县', '652722', '652700', '833300', 'J', '3');
INSERT INTO `system_address` VALUES ('3258', '温泉县', '652723', '652700', '833500', 'W', '3');
INSERT INTO `system_address` VALUES ('3259', '巴音郭楞蒙古自治州', '652800', '650000', null, 'B', '2');
INSERT INTO `system_address` VALUES ('3260', '库尔勒市', '652801', '652800', '841000', 'K', '3');
INSERT INTO `system_address` VALUES ('3261', '轮台县', '652822', '652800', '841600', 'L', '3');
INSERT INTO `system_address` VALUES ('3262', '尉犁县', '652823', '652800', '841500', 'W', '3');
INSERT INTO `system_address` VALUES ('3263', '若羌县', '652824', '652800', '841800', 'R', '3');
INSERT INTO `system_address` VALUES ('3264', '且末县', '652825', '652800', '841900', 'Q', '3');
INSERT INTO `system_address` VALUES ('3265', '焉耆回族自治县', '652826', '652800', '841100', 'Y', '3');
INSERT INTO `system_address` VALUES ('3266', '和静县', '652827', '652800', '841300', 'H', '3');
INSERT INTO `system_address` VALUES ('3267', '和硕县', '652828', '652800', '841200', 'H', '3');
INSERT INTO `system_address` VALUES ('3268', '博湖县', '652829', '652800', '841400', 'B', '3');
INSERT INTO `system_address` VALUES ('3269', '阿克苏地区', '652900', '650000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('3270', '阿克苏市', '652901', '652900', '843000', 'A', '3');
INSERT INTO `system_address` VALUES ('3271', '温宿县', '652922', '652900', '843100', 'W', '3');
INSERT INTO `system_address` VALUES ('3272', '库车县', '652923', '652900', '842000', 'K', '3');
INSERT INTO `system_address` VALUES ('3273', '沙雅县', '652924', '652900', '842200', 'S', '3');
INSERT INTO `system_address` VALUES ('3274', '新和县', '652925', '652900', '842100', 'X', '3');
INSERT INTO `system_address` VALUES ('3275', '拜城县', '652926', '652900', '842300', 'B', '3');
INSERT INTO `system_address` VALUES ('3276', '乌什县', '652927', '652900', '843400', 'W', '3');
INSERT INTO `system_address` VALUES ('3277', '阿瓦提县', '652928', '652900', '843200', 'A', '3');
INSERT INTO `system_address` VALUES ('3278', '柯坪县', '652929', '652900', '843600', 'K', '3');
INSERT INTO `system_address` VALUES ('3279', '克孜勒苏柯尔克孜自治州', '653000', '650000', null, 'K', '2');
INSERT INTO `system_address` VALUES ('3280', '阿图什市', '653001', '653000', '845350', 'A', '3');
INSERT INTO `system_address` VALUES ('3281', '阿克陶县', '653022', '653000', '845550', 'A', '3');
INSERT INTO `system_address` VALUES ('3282', '阿合奇县', '653023', '653000', '843500', 'A', '3');
INSERT INTO `system_address` VALUES ('3283', '乌恰县', '653024', '653000', '845450', 'W', '3');
INSERT INTO `system_address` VALUES ('3284', '喀什地区', '653100', '650000', null, 'K', '2');
INSERT INTO `system_address` VALUES ('3285', '喀什市', '653101', '653100', '844000', 'K', '3');
INSERT INTO `system_address` VALUES ('3286', '疏附县', '653121', '653100', '844100', 'S', '3');
INSERT INTO `system_address` VALUES ('3287', '疏勒县', '653122', '653100', '844200', 'S', '3');
INSERT INTO `system_address` VALUES ('3288', '英吉沙县', '653123', '653100', '844500', 'Y', '3');
INSERT INTO `system_address` VALUES ('3289', '泽普县', '653124', '653100', '844800', 'Z', '3');
INSERT INTO `system_address` VALUES ('3290', '莎车县', '653125', '653100', '844710', 'S', '3');
INSERT INTO `system_address` VALUES ('3291', '叶城县', '653126', '653100', '844900', 'Y', '3');
INSERT INTO `system_address` VALUES ('3292', '麦盖提县', '653127', '653100', '844600', 'M', '3');
INSERT INTO `system_address` VALUES ('3293', '岳普湖县', '653128', '653100', '844400', 'Y', '3');
INSERT INTO `system_address` VALUES ('3294', '伽师县', '653129', '653100', '844300', 'J', '3');
INSERT INTO `system_address` VALUES ('3295', '巴楚县', '653130', '653100', '843800', 'B', '3');
INSERT INTO `system_address` VALUES ('3296', '塔什库尔干塔吉克自治县', '653131', '653100', '845250', 'T', '3');
INSERT INTO `system_address` VALUES ('3297', '和田地区', '653200', '650000', null, 'H', '2');
INSERT INTO `system_address` VALUES ('3298', '和田市', '653201', '653200', '848000', 'H', '3');
INSERT INTO `system_address` VALUES ('3299', '和田县', '653221', '653200', '848000', 'H', '3');
INSERT INTO `system_address` VALUES ('3300', '墨玉县', '653222', '653200', '848100', 'M', '3');
INSERT INTO `system_address` VALUES ('3301', '皮山县', '653223', '653200', '845150', 'P', '3');
INSERT INTO `system_address` VALUES ('3302', '洛浦县', '653224', '653200', '848200', 'L', '3');
INSERT INTO `system_address` VALUES ('3303', '策勒县', '653225', '653200', '848300', 'C', '3');
INSERT INTO `system_address` VALUES ('3304', '于田县', '653226', '653200', '848400', 'Y', '3');
INSERT INTO `system_address` VALUES ('3305', '民丰县', '653227', '653200', '848500', 'M', '3');
INSERT INTO `system_address` VALUES ('3306', '伊犁哈萨克自治州', '654000', '650000', null, 'Y', '2');
INSERT INTO `system_address` VALUES ('3307', '伊宁市', '654002', '654000', '835000', 'Y', '3');
INSERT INTO `system_address` VALUES ('3308', '奎屯市', '654003', '654000', '833200', 'K', '3');
INSERT INTO `system_address` VALUES ('3309', '霍尔果斯市', '654004', '654000', '835000', 'H', '3');
INSERT INTO `system_address` VALUES ('3310', '伊宁县', '654021', '654000', '835100', 'Y', '3');
INSERT INTO `system_address` VALUES ('3311', '察布查尔锡伯自治县', '654022', '654000', '835300', 'C', '3');
INSERT INTO `system_address` VALUES ('3312', '霍城县', '654023', '654000', '835200', 'H', '3');
INSERT INTO `system_address` VALUES ('3313', '巩留县', '654024', '654000', '835400', 'G', '3');
INSERT INTO `system_address` VALUES ('3314', '新源县', '654025', '654000', '835800', 'X', '3');
INSERT INTO `system_address` VALUES ('3315', '昭苏县', '654026', '654000', '835600', 'Z', '3');
INSERT INTO `system_address` VALUES ('3316', '特克斯县', '654027', '654000', '835500', 'T', '3');
INSERT INTO `system_address` VALUES ('3317', '尼勒克县', '654028', '654000', '835700', 'N', '3');
INSERT INTO `system_address` VALUES ('3318', '塔城地区', '654200', '650000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3319', '塔城市', '654201', '654200', '834300', 'T', '3');
INSERT INTO `system_address` VALUES ('3320', '乌苏市', '654202', '654200', '833300', 'W', '3');
INSERT INTO `system_address` VALUES ('3321', '额敏县', '654221', '654200', '834600', 'E', '3');
INSERT INTO `system_address` VALUES ('3322', '沙湾县', '654223', '654200', '832100', 'S', '3');
INSERT INTO `system_address` VALUES ('3323', '托里县', '654224', '654200', '834500', 'T', '3');
INSERT INTO `system_address` VALUES ('3324', '裕民县', '654225', '654200', '834800', 'Y', '3');
INSERT INTO `system_address` VALUES ('3325', '和布克赛尔蒙古自治县', '654226', '654200', '834400', 'H', '3');
INSERT INTO `system_address` VALUES ('3326', '阿勒泰地区', '654300', '650000', null, 'A', '2');
INSERT INTO `system_address` VALUES ('3327', '阿勒泰市', '654301', '654300', '836500', 'A', '3');
INSERT INTO `system_address` VALUES ('3328', '布尔津县', '654321', '654300', '836600', 'B', '3');
INSERT INTO `system_address` VALUES ('3329', '富蕴县', '654322', '654300', '836100', 'F', '3');
INSERT INTO `system_address` VALUES ('3330', '福海县', '654323', '654300', '836400', 'F', '3');
INSERT INTO `system_address` VALUES ('3331', '哈巴河县', '654324', '654300', '836700', 'H', '3');
INSERT INTO `system_address` VALUES ('3332', '青河县', '654325', '654300', '836200', 'Q', '3');
INSERT INTO `system_address` VALUES ('3333', '吉木乃县', '654326', '654300', '836800', 'J', '3');
INSERT INTO `system_address` VALUES ('3334', '石河子市', '659001', '659000', '832000', 'S', '3');
INSERT INTO `system_address` VALUES ('3335', '阿拉尔市', '659002', '659000', '843300', 'A', '3');
INSERT INTO `system_address` VALUES ('3336', '图木舒克市', '659003', '659000', '844000', 'T', '3');
INSERT INTO `system_address` VALUES ('3337', '五家渠市', '659004', '659000', '831300', 'W', '3');
INSERT INTO `system_address` VALUES ('3338', '北屯市', '659005', '659000', '836000', 'B', '3');
INSERT INTO `system_address` VALUES ('3339', '铁门关市', '659006', '659000', '841007', 'T', '3');
INSERT INTO `system_address` VALUES ('3340', '可克达拉市', '659008', '659000', '835213', 'K', '3');
INSERT INTO `system_address` VALUES ('3341', '台湾', '710000', '0', null, 'T', '1');
INSERT INTO `system_address` VALUES ('3342', '香港', '810000', '0', null, 'X', '1');
INSERT INTO `system_address` VALUES ('3343', '中西區', '810101', '810100', '999077', 'Z', '3');
INSERT INTO `system_address` VALUES ('3344', '灣仔區', '810102', '810100', '999077', 'W', '3');
INSERT INTO `system_address` VALUES ('3345', '東區', '810103', '810100', '999077', 'D', '3');
INSERT INTO `system_address` VALUES ('3346', '南區', '810104', '810100', '999077', 'N', '3');
INSERT INTO `system_address` VALUES ('3347', '油尖旺區', '810105', '810100', '999077', 'Y', '3');
INSERT INTO `system_address` VALUES ('3348', '深水埗區', '810106', '810100', '999077', 'S', '3');
INSERT INTO `system_address` VALUES ('3349', '九龍城區', '810107', '810100', '999077', 'J', '3');
INSERT INTO `system_address` VALUES ('3350', '黃大仙區', '810108', '810100', '999077', 'H', '3');
INSERT INTO `system_address` VALUES ('3351', '觀塘區', '810109', '810100', '999077', 'G', '3');
INSERT INTO `system_address` VALUES ('3352', '荃灣區', '810110', '810100', '999077', 'Q', '3');
INSERT INTO `system_address` VALUES ('3353', '屯門區', '810111', '810100', '999077', 'T', '3');
INSERT INTO `system_address` VALUES ('3354', '元朗區', '810112', '810100', '999077', 'Y', '3');
INSERT INTO `system_address` VALUES ('3355', '北區', '810113', '810100', '999077', 'B', '3');
INSERT INTO `system_address` VALUES ('3356', '大埔區', '810114', '810100', '999077', 'D', '3');
INSERT INTO `system_address` VALUES ('3357', '西貢區', '810115', '810100', '999077', 'X', '3');
INSERT INTO `system_address` VALUES ('3358', '沙田區', '810116', '810100', '999077', 'S', '3');
INSERT INTO `system_address` VALUES ('3359', '葵青區', '810117', '810100', '999077', 'K', '3');
INSERT INTO `system_address` VALUES ('3360', '離島區', '810118', '810100', '999077', 'L', '3');
INSERT INTO `system_address` VALUES ('3361', '澳门', '820000', '0', null, 'A', '1');
INSERT INTO `system_address` VALUES ('3362', '花地瑪堂區', '820101', '820100', '999078', 'H', '3');
INSERT INTO `system_address` VALUES ('3363', '花王堂區', '820102', '820100', '999078', 'H', '3');
INSERT INTO `system_address` VALUES ('3364', '望德堂區', '820103', '820100', '999078', 'W', '3');
INSERT INTO `system_address` VALUES ('3365', '大堂區', '820104', '820100', '999078', 'D', '3');
INSERT INTO `system_address` VALUES ('3366', '風順堂區', '820105', '820100', '999078', 'F', '3');
INSERT INTO `system_address` VALUES ('3367', '嘉模堂區', '820106', '820100', '999078', 'J', '3');
INSERT INTO `system_address` VALUES ('3368', '路氹填海區', '820107', '820100', '999078', 'L', '3');
INSERT INTO `system_address` VALUES ('3369', '聖方濟各堂區', '820108', '820100', '999078', 'S', '3');
INSERT INTO `system_address` VALUES ('3370', '济源市', '419001', '419000', '454650', 'J', '3');
INSERT INTO `system_address` VALUES ('3371', '省直辖县', '429000', '420000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3372', '市区', '441901', '441900', '523000', 'S', '3');
INSERT INTO `system_address` VALUES ('3373', '市辖区', '620201', '620200', '735100', 'S', '3');
INSERT INTO `system_address` VALUES ('3374', '三沙市', '460300', '460000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3375', '省直辖县', '469000', '460000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3376', '白沙黎族自治县', '469025', '469000', '572800', 'B', '3');
INSERT INTO `system_address` VALUES ('3377', '市辖区', '500100', '500000', null, 'S', '2');
INSERT INTO `system_address` VALUES ('3378', '县', '500200', '500000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('3379', '台北市', '710100', '710000', '000100', 'T', '2');
INSERT INTO `system_address` VALUES ('3380', '新北市', '710200', '710000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('3381', '桃园市', '710300', '710000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3382', '台中市', '710400', '710000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3383', '台南市', '710500', '710000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3384', '高雄市', '710600', '710000', null, 'G', '2');
INSERT INTO `system_address` VALUES ('3385', '基隆市', '710700', '710000', '', 'J', '2');
INSERT INTO `system_address` VALUES ('3386', '新竹市', '710800', '710000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('3387', '嘉义市', '710900', '710000', null, 'J', '2');
INSERT INTO `system_address` VALUES ('3388', '县', '711000', '710000', null, 'X', '2');
INSERT INTO `system_address` VALUES ('3389', '新竹县', '711010', '711000', '000300', 'X', '3');
INSERT INTO `system_address` VALUES ('3390', '苗栗县', '711020', '711000', '000037', 'M', '3');
INSERT INTO `system_address` VALUES ('3391', '彰化县', '711030', '711000', '000500', 'Z', '3');
INSERT INTO `system_address` VALUES ('3392', '南投县', '711040', '711000', '000540', 'N', '3');
INSERT INTO `system_address` VALUES ('3393', '云林县', '711050', '711000', '000640', 'Y', '3');
INSERT INTO `system_address` VALUES ('3394', '嘉义县', '711060', '711000', '000600', 'J', '3');
INSERT INTO `system_address` VALUES ('3395', '屏东县', '711070', '711000', '000900', 'P', '3');
INSERT INTO `system_address` VALUES ('3396', '宜兰县', '711080', '711000', '000260', 'Y', '3');
INSERT INTO `system_address` VALUES ('3397', '花莲县', '711090', '711000', '097047', 'H', '3');
INSERT INTO `system_address` VALUES ('3398', '台东县', '711100', '711000', '000950', 'T', '3');
INSERT INTO `system_address` VALUES ('3399', '澎湖县', '711110', '711000', '000880', 'P', '3');
INSERT INTO `system_address` VALUES ('3400', '金门县', '711120', '711000', '000890', 'J', '3');
INSERT INTO `system_address` VALUES ('3402', '中正区', '710101', '710100', '000100', 'Z', '3');
INSERT INTO `system_address` VALUES ('3403', '大同区', '710102', '710100', '000103', 'D', '3');
INSERT INTO `system_address` VALUES ('3404', '中山区', '710103', '710100', '000104', 'Z', '3');
INSERT INTO `system_address` VALUES ('3405', '万华区', '710104', '710100', '000108', 'W', '3');
INSERT INTO `system_address` VALUES ('3406', '信义区', '710105', '710100', '000110', 'X', '3');
INSERT INTO `system_address` VALUES ('3407', '松山区', '710106', '710100', '000105', 'S', '3');
INSERT INTO `system_address` VALUES ('3408', '大安区', '710107', '710100', '000106', 'D', '3');
INSERT INTO `system_address` VALUES ('3409', '南港区', '710108', '710100', '000115', 'N', '3');
INSERT INTO `system_address` VALUES ('3410', '北投区', '710109', '710100', '000112', 'B', '3');
INSERT INTO `system_address` VALUES ('3411', '内湖区', '710110', '710100', '000114', 'N', '3');
INSERT INTO `system_address` VALUES ('3412', '士林区', '710111', '710100', '000111', 'S', '3');
INSERT INTO `system_address` VALUES ('3413', '文山区', '710112', '710100', '000116', 'W', '3');
INSERT INTO `system_address` VALUES ('3414', '板桥区', '710201', '710200', '000220', 'B', '3');
INSERT INTO `system_address` VALUES ('3415', '土城区', '710202', '710200', '000236', 'T', '3');
INSERT INTO `system_address` VALUES ('3416', '新庄区', '710203', '710200', '000242', 'X', '3');
INSERT INTO `system_address` VALUES ('3417', '新店区', '710204', '710200', '000231', 'X', '3');
INSERT INTO `system_address` VALUES ('3418', '深坑区', '710205', '710200', '000222', 'S', '3');
INSERT INTO `system_address` VALUES ('3419', '石碇区', '710206', '710200', '000223', 'S', '3');
INSERT INTO `system_address` VALUES ('3420', '坪林区', '710207', '710200', '000232', 'P', '3');
INSERT INTO `system_address` VALUES ('3421', '乌来区', '710208', '710200', '000233', 'W', '3');
INSERT INTO `system_address` VALUES ('3422', '五股区', '710209', '710200', '000248', 'W', '3');
INSERT INTO `system_address` VALUES ('3423', '八里区', '710210', '710200', '000249', 'B', '3');
INSERT INTO `system_address` VALUES ('3424', '林口区', '710211', '710200', '000244', 'L', '3');
INSERT INTO `system_address` VALUES ('3425', '淡水区', '710212', '710200', '025170', 'D', '3');
INSERT INTO `system_address` VALUES ('3426', '中和区', '710213', '710200', '023545', 'Z', '3');
INSERT INTO `system_address` VALUES ('3427', '永和区', '710214', '710200', '000234', 'Y', '3');
INSERT INTO `system_address` VALUES ('3428', '三重区', '710215', '710200', '000241', 'S', '3');
INSERT INTO `system_address` VALUES ('3429', '芦洲区', '710216', '710200', '000247', 'L', '3');
INSERT INTO `system_address` VALUES ('3430', '泰山区', '710217', '710200', '000243', 'T', '3');
INSERT INTO `system_address` VALUES ('3431', '树林区', '710218', '710200', '000238', 'L', '3');
INSERT INTO `system_address` VALUES ('3432', '莺歌区', '710219', '710200', '000239', 'Y', '3');
INSERT INTO `system_address` VALUES ('3433', '三峡区', '710220', '710200', '000237', 'S', '3');
INSERT INTO `system_address` VALUES ('3434', '汐止区', '710221', '710200', '000221', 'X', '3');
INSERT INTO `system_address` VALUES ('3435', '金山区', '710222', '710200', '020841', 'J', '3');
INSERT INTO `system_address` VALUES ('3436', '万里区', '710223', '710200', '000207', 'W', '3');
INSERT INTO `system_address` VALUES ('3437', '三芝区', '710224', '710200', '000252', 'S', '3');
INSERT INTO `system_address` VALUES ('3438', '石门区', '710225', '710200', '000253', 'S', '3');
INSERT INTO `system_address` VALUES ('3439', '瑞芳区', '710226', '710200', '000224', 'R', '3');
INSERT INTO `system_address` VALUES ('3440', '贡寮区', '710227', '710200', '000228', 'G', '3');
INSERT INTO `system_address` VALUES ('3441', '双溪区', '710228', '710200', '000227', 'S', '3');
INSERT INTO `system_address` VALUES ('3442', '平溪区', '710229', '710200', '000226', 'P', '3');
INSERT INTO `system_address` VALUES ('3443', '桃园区', '710301', '710300', '000330', 'T', '3');
INSERT INTO `system_address` VALUES ('3444', '中坜区', '710302', '710300', '000320', 'Z', '3');
INSERT INTO `system_address` VALUES ('3445', '平镇区', '710303', '710300', '000324', 'P', '3');
INSERT INTO `system_address` VALUES ('3446', '八德区', '710304', '710300', '000334', 'B', '3');
INSERT INTO `system_address` VALUES ('3447', '杨梅区', '710305', '710300', '000326', 'Y', '3');
INSERT INTO `system_address` VALUES ('3448', '芦竹区', '710306', '710300', '000338', 'L', '3');
INSERT INTO `system_address` VALUES ('3449', '大溪区', '710307', '710300', '000335', 'D', '3');
INSERT INTO `system_address` VALUES ('3450', '龙潭区', '710308', '710300', '000325', 'Z', '3');
INSERT INTO `system_address` VALUES ('3451', '龟山区', '710309', '710300', '000333', 'G', '3');
INSERT INTO `system_address` VALUES ('3452', '大园区', '710310', '710300', '000337', 'D', '3');
INSERT INTO `system_address` VALUES ('3453', '观音区', '710311', '710300', '000328', 'G', '3');
INSERT INTO `system_address` VALUES ('3454', '新屋区', '710312', '710300', '000327', 'X', '3');
INSERT INTO `system_address` VALUES ('3455', '复兴区', '710313', '710300', '000336', 'F', '3');
INSERT INTO `system_address` VALUES ('3456', '中区', '710401', '710400', '000400', 'Z', '3');
INSERT INTO `system_address` VALUES ('3457', '东区', '710402', '710400', '000401', 'D', '3');
INSERT INTO `system_address` VALUES ('3458', '西区', '710403', '710400', '000403', 'X', '3');
INSERT INTO `system_address` VALUES ('3459', '南区', '710404', '710400', '000402', 'N', '3');
INSERT INTO `system_address` VALUES ('3460', '北区', '710405', '710400', '000404', 'B', '3');
INSERT INTO `system_address` VALUES ('3461', '西屯区', '710406', '710400', '000407', 'X', '3');
INSERT INTO `system_address` VALUES ('3462', '南屯区', '710407', '710400', '000408', 'N', '3');
INSERT INTO `system_address` VALUES ('3463', '北屯区', '710408', '710400', '000406', 'B', '3');
INSERT INTO `system_address` VALUES ('3464', '丰原区', '710409', '710400', '000420', 'F', '3');
INSERT INTO `system_address` VALUES ('3465', '大里区', '710410', '710400', '000412', 'D', '3');
INSERT INTO `system_address` VALUES ('3466', '太平区', '710411', '710400', '000411', 'T', '3');
INSERT INTO `system_address` VALUES ('3467', '东势区', '710412', '710400', '000423', 'D', '3');
INSERT INTO `system_address` VALUES ('3468', '大甲区\r\n', '710413', '710400', '000437', 'D', '3');
INSERT INTO `system_address` VALUES ('3469', '清水区', '710414', '710400', '000436', 'Q', '3');
INSERT INTO `system_address` VALUES ('3470', '沙鹿区', '710415', '710400', '000433', 'S', '3');
INSERT INTO `system_address` VALUES ('3471', '梧栖区', '710416', '710400', '000435', 'W', '3');
INSERT INTO `system_address` VALUES ('3472', '后里区', '710417', '710400', '000421', 'H', '3');
INSERT INTO `system_address` VALUES ('3473', '神冈区', '710418', '710400', '000429', 'S', '3');
INSERT INTO `system_address` VALUES ('3474', '潭子区', '710419', '710400', '000427', 'T', '3');
INSERT INTO `system_address` VALUES ('3475', '大雅区', '710420', '710400', '000428', 'D', '3');
INSERT INTO `system_address` VALUES ('3476', '新社区', '710421', '710400', '000426', 'X', '3');
INSERT INTO `system_address` VALUES ('3477', '石冈区', '710422', '710400', '000422', 'S', '3');
INSERT INTO `system_address` VALUES ('3478', '外埔区', '710423', '710400', '000438', 'W', '3');
INSERT INTO `system_address` VALUES ('3479', '大安区', '710424', '710400', '000439', 'D', '3');
INSERT INTO `system_address` VALUES ('3480', '乌日区', '710425', '710400', '000414', 'W', '3');
INSERT INTO `system_address` VALUES ('3481', '大肚区', '710426', '710400', '000432', 'D', '3');
INSERT INTO `system_address` VALUES ('3482', '龙井区', '710427', '710400', '000434', 'L', '3');
INSERT INTO `system_address` VALUES ('3483', '雾峰区', '710428', '710400', '000413', 'W', '3');
INSERT INTO `system_address` VALUES ('3484', '和平区', '710429', '710400', '000424', 'H', '3');
INSERT INTO `system_address` VALUES ('3485', '中西区', '710501', '710500', '000700', 'Z', '3');
INSERT INTO `system_address` VALUES ('3486', '东区', '710502', '710500', '000701', 'D', '3');
INSERT INTO `system_address` VALUES ('3487', '南区', '710503', '710500', '000702', 'N', '3');
INSERT INTO `system_address` VALUES ('3488', '北区', '710504', '710500', '000704', 'N', '3');
INSERT INTO `system_address` VALUES ('3489', '安平区', '710505', '710500', '000708', 'A', '3');
INSERT INTO `system_address` VALUES ('3490', '安南区', '710506', '710500', '000709', 'A', '3');
INSERT INTO `system_address` VALUES ('3491', '永康区', '710507', '710500', '000710', 'Y', '3');
INSERT INTO `system_address` VALUES ('3492', '归仁区', '710508', '710500', '000711', 'G', '3');
INSERT INTO `system_address` VALUES ('3493', '新化区', '710509', '710500', '000712', 'X', '3');
INSERT INTO `system_address` VALUES ('3494', '左镇区', '710510', '710500', '000713', 'Z', '3');
INSERT INTO `system_address` VALUES ('3495', '玉井区', '710511', '710500', '000714', 'Y', '3');
INSERT INTO `system_address` VALUES ('3496', '楠西区', '710512', '710500', '000715', 'N', '3');
INSERT INTO `system_address` VALUES ('3497', '南化区', '710513', '710500', '000716', 'N', '3');
INSERT INTO `system_address` VALUES ('3498', '仁德区', '710514', '710500', '000717', 'R', '3');
INSERT INTO `system_address` VALUES ('3499', '关庙区', '710515', '710500', '000718', 'G', '3');
INSERT INTO `system_address` VALUES ('3500', '龙崎区', '710516', '710500', '000719', 'L', '3');
INSERT INTO `system_address` VALUES ('3501', '官田区', '710517', '710500', '000720', 'G', '3');
INSERT INTO `system_address` VALUES ('3502', '麻豆区', '710518', '710500', '000721', 'M', '3');
INSERT INTO `system_address` VALUES ('3503', '佳里区', '710519', '710500', '000722', 'J', '3');
INSERT INTO `system_address` VALUES ('3504', '西港区', '710520', '710500', '000723', 'X', '3');
INSERT INTO `system_address` VALUES ('3505', '七股区', '710521', '710500', '000724', 'Q', '3');
INSERT INTO `system_address` VALUES ('3506', '将军区', '710522', '710500', '000725', 'J', '3');
INSERT INTO `system_address` VALUES ('3507', '学甲区', '710523', '710500', '000726', 'X', '3');
INSERT INTO `system_address` VALUES ('3508', '北门区', '710524', '710500', '000727', 'B', '3');
INSERT INTO `system_address` VALUES ('3509', '新营区', '710525', '710500', '000730', 'X', '3');
INSERT INTO `system_address` VALUES ('3510', '后壁区', '710526', '710500', '000731', 'H', '3');
INSERT INTO `system_address` VALUES ('3511', '白河区', '710527', '710500', '000732', 'B', '3');
INSERT INTO `system_address` VALUES ('3512', '东山区', '710528', '710500', '000733', 'D', '3');
INSERT INTO `system_address` VALUES ('3513', '六甲区', '710529', '710500', '000734', 'L', '3');
INSERT INTO `system_address` VALUES ('3514', '下营区', '710530', '710500', '000735', 'X', '3');
INSERT INTO `system_address` VALUES ('3515', '柳营区', '710531', '710500', '000736', 'L', '3');
INSERT INTO `system_address` VALUES ('3516', '盐水区', '710532', '710500', '000737', 'Y', '3');
INSERT INTO `system_address` VALUES ('3517', '善化区', '710533', '710500', '000741', 'S', '3');
INSERT INTO `system_address` VALUES ('3518', '大内区', '710534', '710500', '000742', 'D', '3');
INSERT INTO `system_address` VALUES ('3519', '山上区', '710535', '710500', '000743', 's', '3');
INSERT INTO `system_address` VALUES ('3520', '新市区', '710536', '710500', '000744', 'X', '3');
INSERT INTO `system_address` VALUES ('3521', '安定区', '710537', '710500', '000745', 'A', '3');
INSERT INTO `system_address` VALUES ('3522', '楠梓区', '710601', '710600', '000811', 'N', '3');
INSERT INTO `system_address` VALUES ('3523', '左营区', '710602', '710600', '000813', 'Z', '3');
INSERT INTO `system_address` VALUES ('3524', '鼓山区', '710603', '710600', '000804', 'G', '3');
INSERT INTO `system_address` VALUES ('3525', '三民区', '710604', '710600', '000807', 'S', '3');
INSERT INTO `system_address` VALUES ('3526', '盐埕区', '710605', '710600', '000803', 'Y', '3');
INSERT INTO `system_address` VALUES ('3527', '前金区', '710606', '710600', '000801', 'Q', '3');
INSERT INTO `system_address` VALUES ('3528', '新兴区', '710607', '710600', '000800', 'X', '3');
INSERT INTO `system_address` VALUES ('3529', '苓雅区', '710608', '710600', '000802', 'L', '3');
INSERT INTO `system_address` VALUES ('3530', '前镇区', '710609', '710600', '000806', 'Q', '3');
INSERT INTO `system_address` VALUES ('3531', '旗津区', '710610', '710600', '000805', 'Q', '3');
INSERT INTO `system_address` VALUES ('3532', '小港区', '710611', '710600', '000812', 'X', '3');
INSERT INTO `system_address` VALUES ('3533', '凤山区', '710612', '710600', '000830', 'F', '3');
INSERT INTO `system_address` VALUES ('3534', '大寮区', '710613', '710600', '000831', 'D', '3');
INSERT INTO `system_address` VALUES ('3535', '鸟松区', '710614', '710600', '000833', 'N', '3');
INSERT INTO `system_address` VALUES ('3536', '林园区', '710615', '710600', '000832', 'L', '3');
INSERT INTO `system_address` VALUES ('3537', '仁武区', '710616', '710600', '000814', 'W', '3');
INSERT INTO `system_address` VALUES ('3538', '大树区', '710617', '710600', '000840', 'D', '3');
INSERT INTO `system_address` VALUES ('3539', '大社区', '710618', '710600', '000815', 'D', '3');
INSERT INTO `system_address` VALUES ('3540', '冈山区', '710619', '710600', '000820', 'G', '3');
INSERT INTO `system_address` VALUES ('3541', '路竹区', '710620', '710600', '000821', 'L', '3');
INSERT INTO `system_address` VALUES ('3542', '桥头区', '710621', '710600', '000825', 'Q', '3');
INSERT INTO `system_address` VALUES ('3543', '梓官区', '710622', '710600', '000826', 'X', '3');
INSERT INTO `system_address` VALUES ('3544', '弥陀区', '710623', '710600', '000827', 'M', '3');
INSERT INTO `system_address` VALUES ('3545', '永安区', '710624', '710600', '000828', 'Y', '3');
INSERT INTO `system_address` VALUES ('3546', '燕巢区', '710625', '710600', '000824', 'Y', '3');
INSERT INTO `system_address` VALUES ('3547', '阿莲区', '710626', '710600', '000822', 'A', '3');
INSERT INTO `system_address` VALUES ('3548', '茄萣区', '710627', '710600', '000852', 'Q', '3');
INSERT INTO `system_address` VALUES ('3549', '湖内区', '710628', '710600', '000829', 'H', '3');
INSERT INTO `system_address` VALUES ('3550', '旗山区', '710629', '710600', '000842', 'H', '3');
INSERT INTO `system_address` VALUES ('3551', '美浓区', '710630', '710600', '000843', 'M', '3');
INSERT INTO `system_address` VALUES ('3552', '内门区', '710631', '710600', '000845', 'N', '3');
INSERT INTO `system_address` VALUES ('3553', '杉林区', '710632', '710600', '000846', 'S', '3');
INSERT INTO `system_address` VALUES ('3554', '甲仙区', '710633', '710600', '000847', 'J', '3');
INSERT INTO `system_address` VALUES ('3555', '六龟区', '710634', '710600', '000844', 'L', '3');
INSERT INTO `system_address` VALUES ('3556', '茂林区', '710635', '710600', '000851', 'M', '3');
INSERT INTO `system_address` VALUES ('3557', '桃源区', '710636', '710600', '000848', 'T', '3');
INSERT INTO `system_address` VALUES ('3558', '那玛夏区', '710637', '710600', '000849', 'N', '3');
INSERT INTO `system_address` VALUES ('3559', '中正区', '710701', '710700', '000202', 'Z', '3');
INSERT INTO `system_address` VALUES ('3560', '七堵区', '710702', '710700', '000206', 'Q', '3');
INSERT INTO `system_address` VALUES ('3561', '暖暖区', '710703', '710700', '000205', 'N', '3');
INSERT INTO `system_address` VALUES ('3562', '仁爱区', '710704', '710700', '000200', 'R', '3');
INSERT INTO `system_address` VALUES ('3563', '中山区', '710705', '710700', '000203', 'Z', '3');
INSERT INTO `system_address` VALUES ('3564', '安乐区', '710706', '710700', '000204', 'A', '3');
INSERT INTO `system_address` VALUES ('3565', '信义区', '710707', '710700', '000201', 'X', '3');
INSERT INTO `system_address` VALUES ('3566', '东区', '710801', '710800', '000300', 'D', '3');
INSERT INTO `system_address` VALUES ('3567', '北区', '710802', '710800', '000300', 'B', '3');
INSERT INTO `system_address` VALUES ('3568', '香山区', '710803', '710800', '000300', 'X', '3');
INSERT INTO `system_address` VALUES ('3569', '东区', '710901', '710900', '000600', 'D', '3');
INSERT INTO `system_address` VALUES ('3570', '西区', '710902', '710900', '000600', 'X', '3');
INSERT INTO `system_address` VALUES ('3571', '自治直辖县', '659000', '650000', null, 'Z', '2');
INSERT INTO `system_address` VALUES ('3572', '特别行政区', '810100', '810000', null, 'T', '2');
INSERT INTO `system_address` VALUES ('3573', '特别行政区', '820100', '820000', null, 'T', '2');

-- ----------------------------
-- Table structure for system_area2
-- ----------------------------
DROP TABLE IF EXISTS `system_area2`;
CREATE TABLE `system_area2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编码',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '区域名称',
  `sort` int(11) unsigned DEFAULT NULL COMMENT '排序',
  `jkey` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'dkey',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3641 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='全国区域信息表';

-- ----------------------------
-- Records of system_area2
-- ----------------------------
INSERT INTO `system_area2` VALUES ('1', '0001', '行政区划', '0', '01');
INSERT INTO `system_area2` VALUES ('2', '00010001', '北京', '0', '110000');
INSERT INTO `system_area2` VALUES ('3', '000100010001', '北京市', '2', '110100');
INSERT INTO `system_area2` VALUES ('4', '0001000100010001', '东城区', '3', '110101');
INSERT INTO `system_area2` VALUES ('5', '0001000100010002', '西城区', '4', '110102');
INSERT INTO `system_area2` VALUES ('6', '0001000100010003', '崇文区', '5', '110103');
INSERT INTO `system_area2` VALUES ('7', '0001000100010004', '宣武区', '6', '110104');
INSERT INTO `system_area2` VALUES ('8', '0001000100010005', '朝阳区', '7', '110105');
INSERT INTO `system_area2` VALUES ('9', '0001000100010006', '丰台区', '8', '110106');
INSERT INTO `system_area2` VALUES ('10', '0001000100010007', '石景山区', '9', '110107');
INSERT INTO `system_area2` VALUES ('11', '0001000100010008', '海淀区', '10', '110108');
INSERT INTO `system_area2` VALUES ('12', '0001000100010009', '门头沟区', '11', '110109');
INSERT INTO `system_area2` VALUES ('13', '0001000100010010', '房山区', '12', '110111');
INSERT INTO `system_area2` VALUES ('14', '0001000100010011', '通州区', '13', '110112');
INSERT INTO `system_area2` VALUES ('15', '0001000100010012', '顺义区', '14', '110113');
INSERT INTO `system_area2` VALUES ('16', '0001000100010013', '昌平区', '15', '110114');
INSERT INTO `system_area2` VALUES ('17', '0001000100010014', '大兴区', '16', '110115');
INSERT INTO `system_area2` VALUES ('18', '0001000100010015', '怀柔区', '17', '110116');
INSERT INTO `system_area2` VALUES ('19', '0001000100010016', '平谷区', '18', '110117');
INSERT INTO `system_area2` VALUES ('20', '0001000100010017', '密云县', '19', '110228');
INSERT INTO `system_area2` VALUES ('21', '0001000100010018', '延庆县', '20', '110229');
INSERT INTO `system_area2` VALUES ('22', '00010002', '天津', '21', '120000');
INSERT INTO `system_area2` VALUES ('23', '000100020001', '天津市', '22', '120100');
INSERT INTO `system_area2` VALUES ('24', '0001000200010001', '和平区', '23', '120101');
INSERT INTO `system_area2` VALUES ('25', '0001000200010002', '河东区', '24', '120102');
INSERT INTO `system_area2` VALUES ('26', '0001000200010003', '河西区', '25', '120103');
INSERT INTO `system_area2` VALUES ('27', '0001000200010004', '南开区', '26', '120104');
INSERT INTO `system_area2` VALUES ('28', '0001000200010005', '河北区', '27', '120105');
INSERT INTO `system_area2` VALUES ('29', '0001000200010006', '红桥区', '28', '120106');
INSERT INTO `system_area2` VALUES ('30', '0001000200010007', '塘沽区', '29', '120107');
INSERT INTO `system_area2` VALUES ('31', '0001000200010008', '汉沽区', '30', '120108');
INSERT INTO `system_area2` VALUES ('32', '0001000200010009', '大港区', '31', '120109');
INSERT INTO `system_area2` VALUES ('33', '0001000200010010', '东丽区', '32', '120110');
INSERT INTO `system_area2` VALUES ('34', '0001000200010011', '西青区', '33', '120111');
INSERT INTO `system_area2` VALUES ('35', '0001000200010012', '津南区', '34', '120112');
INSERT INTO `system_area2` VALUES ('36', '0001000200010013', '北辰区', '35', '120113');
INSERT INTO `system_area2` VALUES ('37', '0001000200010014', '武清区', '36', '120114');
INSERT INTO `system_area2` VALUES ('38', '0001000200010015', '宝坻区', '37', '120115');
INSERT INTO `system_area2` VALUES ('39', '0001000200010016', '滨海新区', '38', '120116');
INSERT INTO `system_area2` VALUES ('40', '0001000200010017', '宁河县', '39', '120221');
INSERT INTO `system_area2` VALUES ('41', '0001000200010018', '静海县', '40', '120223');
INSERT INTO `system_area2` VALUES ('42', '0001000200010019', '蓟县', '41', '120225');
INSERT INTO `system_area2` VALUES ('43', '00010003', '河北省', '42', '130000');
INSERT INTO `system_area2` VALUES ('44', '000100030001', '石家庄市', '43', '130100');
INSERT INTO `system_area2` VALUES ('45', '0001000300010001', '长安区', '44', '130102');
INSERT INTO `system_area2` VALUES ('46', '0001000300010002', '桥东区', '45', '130103');
INSERT INTO `system_area2` VALUES ('47', '0001000300010003', '桥西区', '46', '130104');
INSERT INTO `system_area2` VALUES ('48', '0001000300010004', '新华区', '47', '130105');
INSERT INTO `system_area2` VALUES ('49', '0001000300010005', '井陉矿区', '48', '130107');
INSERT INTO `system_area2` VALUES ('50', '0001000300010006', '裕华区', '49', '130108');
INSERT INTO `system_area2` VALUES ('51', '0001000300010007', '井陉县', '50', '130121');
INSERT INTO `system_area2` VALUES ('52', '0001000300010008', '正定县', '51', '130123');
INSERT INTO `system_area2` VALUES ('53', '0001000300010009', '栾城县', '52', '130124');
INSERT INTO `system_area2` VALUES ('54', '0001000300010010', '行唐县', '53', '130125');
INSERT INTO `system_area2` VALUES ('55', '0001000300010011', '灵寿县', '54', '130126');
INSERT INTO `system_area2` VALUES ('56', '0001000300010012', '高邑县', '55', '130127');
INSERT INTO `system_area2` VALUES ('57', '0001000300010013', '深泽县', '56', '130128');
INSERT INTO `system_area2` VALUES ('58', '0001000300010014', '赞皇县', '57', '130129');
INSERT INTO `system_area2` VALUES ('59', '0001000300010015', '无极县', '58', '130130');
INSERT INTO `system_area2` VALUES ('60', '0001000300010016', '平山县', '59', '130131');
INSERT INTO `system_area2` VALUES ('61', '0001000300010017', '元氏县', '60', '130132');
INSERT INTO `system_area2` VALUES ('62', '0001000300010018', '赵县', '61', '130133');
INSERT INTO `system_area2` VALUES ('63', '0001000300010019', '辛集市', '62', '130181');
INSERT INTO `system_area2` VALUES ('64', '0001000300010020', '藁城市', '63', '130182');
INSERT INTO `system_area2` VALUES ('65', '0001000300010021', '晋州市', '64', '130183');
INSERT INTO `system_area2` VALUES ('66', '0001000300010022', '新乐市', '65', '130184');
INSERT INTO `system_area2` VALUES ('67', '0001000300010023', '鹿泉市', '66', '130185');
INSERT INTO `system_area2` VALUES ('68', '000100030002', '唐山市', '67', '130200');
INSERT INTO `system_area2` VALUES ('69', '0001000300020001', '路南区', '68', '130202');
INSERT INTO `system_area2` VALUES ('70', '0001000300020002', '路北区', '69', '130203');
INSERT INTO `system_area2` VALUES ('71', '0001000300020003', '古冶区', '70', '130204');
INSERT INTO `system_area2` VALUES ('72', '0001000300020004', '开平区', '71', '130205');
INSERT INTO `system_area2` VALUES ('73', '0001000300020005', '丰南区', '72', '130207');
INSERT INTO `system_area2` VALUES ('74', '0001000300020006', '丰润区', '73', '130208');
INSERT INTO `system_area2` VALUES ('75', '0001000300020007', '滦县', '74', '130223');
INSERT INTO `system_area2` VALUES ('76', '0001000300020008', '滦南县', '75', '130224');
INSERT INTO `system_area2` VALUES ('77', '0001000300020009', '乐亭县', '76', '130225');
INSERT INTO `system_area2` VALUES ('78', '0001000300020010', '迁西县', '77', '130227');
INSERT INTO `system_area2` VALUES ('79', '0001000300020011', '玉田县', '78', '130229');
INSERT INTO `system_area2` VALUES ('80', '0001000300020012', '唐海县', '79', '130230');
INSERT INTO `system_area2` VALUES ('81', '0001000300020013', '遵化市', '80', '130281');
INSERT INTO `system_area2` VALUES ('82', '0001000300020014', '迁安市', '81', '130283');
INSERT INTO `system_area2` VALUES ('83', '000100030003', '秦皇岛市', '82', '130300');
INSERT INTO `system_area2` VALUES ('84', '0001000300030001', '海港区', '83', '130302');
INSERT INTO `system_area2` VALUES ('85', '0001000300030002', '山海关区', '84', '130303');
INSERT INTO `system_area2` VALUES ('86', '0001000300030003', '北戴河区', '85', '130304');
INSERT INTO `system_area2` VALUES ('87', '0001000300030004', '青龙满族自治县', '86', '130321');
INSERT INTO `system_area2` VALUES ('88', '0001000300030005', '昌黎县', '87', '130322');
INSERT INTO `system_area2` VALUES ('89', '0001000300030006', '抚宁县', '88', '130323');
INSERT INTO `system_area2` VALUES ('90', '0001000300030007', '卢龙县', '89', '130324');
INSERT INTO `system_area2` VALUES ('91', '0001000300030008', '经济技术开发区', '90', '130399');
INSERT INTO `system_area2` VALUES ('92', '000100030004', '邯郸市', '91', '130400');
INSERT INTO `system_area2` VALUES ('93', '0001000300040001', '邯山区', '92', '130402');
INSERT INTO `system_area2` VALUES ('94', '0001000300040002', '丛台区', '93', '130403');
INSERT INTO `system_area2` VALUES ('95', '0001000300040003', '复兴区', '94', '130404');
INSERT INTO `system_area2` VALUES ('96', '0001000300040004', '峰峰矿区', '95', '130406');
INSERT INTO `system_area2` VALUES ('97', '0001000300040005', '邯郸县', '96', '130421');
INSERT INTO `system_area2` VALUES ('98', '0001000300040006', '临漳县', '97', '130423');
INSERT INTO `system_area2` VALUES ('99', '0001000300040007', '成安县', '98', '130424');
INSERT INTO `system_area2` VALUES ('100', '0001000300040008', '大名县', '99', '130425');
INSERT INTO `system_area2` VALUES ('101', '0001000300040009', '涉县', '100', '130426');
INSERT INTO `system_area2` VALUES ('102', '0001000300040010', '磁县', '101', '130427');
INSERT INTO `system_area2` VALUES ('103', '0001000300040011', '肥乡县', '102', '130428');
INSERT INTO `system_area2` VALUES ('104', '0001000300040012', '永年县', '103', '130429');
INSERT INTO `system_area2` VALUES ('105', '0001000300040013', '邱县', '104', '130430');
INSERT INTO `system_area2` VALUES ('106', '0001000300040014', '鸡泽县', '105', '130431');
INSERT INTO `system_area2` VALUES ('107', '0001000300040015', '广平县', '106', '130432');
INSERT INTO `system_area2` VALUES ('108', '0001000300040016', '馆陶县', '107', '130433');
INSERT INTO `system_area2` VALUES ('109', '0001000300040017', '魏县', '108', '130434');
INSERT INTO `system_area2` VALUES ('110', '0001000300040018', '曲周县', '109', '130435');
INSERT INTO `system_area2` VALUES ('111', '0001000300040019', '武安市', '110', '130481');
INSERT INTO `system_area2` VALUES ('112', '000100030005', '邢台市', '111', '130500');
INSERT INTO `system_area2` VALUES ('113', '0001000300050001', '桥东区', '112', '130502');
INSERT INTO `system_area2` VALUES ('114', '0001000300050002', '桥西区', '113', '130503');
INSERT INTO `system_area2` VALUES ('115', '0001000300050003', '邢台县', '114', '130521');
INSERT INTO `system_area2` VALUES ('116', '0001000300050004', '临城县', '115', '130522');
INSERT INTO `system_area2` VALUES ('117', '0001000300050005', '内丘县', '116', '130523');
INSERT INTO `system_area2` VALUES ('118', '0001000300050006', '柏乡县', '117', '130524');
INSERT INTO `system_area2` VALUES ('119', '0001000300050007', '隆尧县', '118', '130525');
INSERT INTO `system_area2` VALUES ('120', '0001000300050008', '任县', '119', '130526');
INSERT INTO `system_area2` VALUES ('121', '0001000300050009', '南和县', '120', '130527');
INSERT INTO `system_area2` VALUES ('122', '0001000300050010', '宁晋县', '121', '130528');
INSERT INTO `system_area2` VALUES ('123', '0001000300050011', '巨鹿县', '122', '130529');
INSERT INTO `system_area2` VALUES ('124', '0001000300050012', '新河县', '123', '130530');
INSERT INTO `system_area2` VALUES ('125', '0001000300050013', '广宗县', '124', '130531');
INSERT INTO `system_area2` VALUES ('126', '0001000300050014', '平乡县', '125', '130532');
INSERT INTO `system_area2` VALUES ('127', '0001000300050015', '威县', '126', '130533');
INSERT INTO `system_area2` VALUES ('128', '0001000300050016', '清河县', '127', '130534');
INSERT INTO `system_area2` VALUES ('129', '0001000300050017', '临西县', '128', '130535');
INSERT INTO `system_area2` VALUES ('130', '0001000300050018', '南宫市', '129', '130581');
INSERT INTO `system_area2` VALUES ('131', '0001000300050019', '沙河市', '130', '130582');
INSERT INTO `system_area2` VALUES ('132', '000100030006', '保定市', '131', '130600');
INSERT INTO `system_area2` VALUES ('133', '0001000300060001', '新市区', '132', '130602');
INSERT INTO `system_area2` VALUES ('134', '0001000300060002', '北市区', '133', '130603');
INSERT INTO `system_area2` VALUES ('135', '0001000300060003', '南市区', '134', '130604');
INSERT INTO `system_area2` VALUES ('136', '0001000300060004', '满城县', '135', '130621');
INSERT INTO `system_area2` VALUES ('137', '0001000300060005', '清苑县', '136', '130622');
INSERT INTO `system_area2` VALUES ('138', '0001000300060006', '涞水县', '137', '130623');
INSERT INTO `system_area2` VALUES ('139', '0001000300060007', '阜平县', '138', '130624');
INSERT INTO `system_area2` VALUES ('140', '0001000300060008', '徐水县', '139', '130625');
INSERT INTO `system_area2` VALUES ('141', '0001000300060009', '定兴县', '140', '130626');
INSERT INTO `system_area2` VALUES ('142', '0001000300060010', '唐县', '141', '130627');
INSERT INTO `system_area2` VALUES ('143', '0001000300060011', '高阳县', '142', '130628');
INSERT INTO `system_area2` VALUES ('144', '0001000300060012', '容城县', '143', '130629');
INSERT INTO `system_area2` VALUES ('145', '0001000300060013', '涞源县', '144', '130630');
INSERT INTO `system_area2` VALUES ('146', '0001000300060014', '望都县', '145', '130631');
INSERT INTO `system_area2` VALUES ('147', '0001000300060015', '安新县', '146', '130632');
INSERT INTO `system_area2` VALUES ('148', '0001000300060016', '易县', '147', '130633');
INSERT INTO `system_area2` VALUES ('149', '0001000300060017', '曲阳县', '148', '130634');
INSERT INTO `system_area2` VALUES ('150', '0001000300060018', '蠡县', '149', '130635');
INSERT INTO `system_area2` VALUES ('151', '0001000300060019', '顺平县', '150', '130636');
INSERT INTO `system_area2` VALUES ('152', '0001000300060020', '博野县', '151', '130637');
INSERT INTO `system_area2` VALUES ('153', '0001000300060021', '雄县', '152', '130638');
INSERT INTO `system_area2` VALUES ('154', '0001000300060022', '涿州市', '153', '130681');
INSERT INTO `system_area2` VALUES ('155', '0001000300060023', '定州市', '154', '130682');
INSERT INTO `system_area2` VALUES ('156', '0001000300060024', '安国市', '155', '130683');
INSERT INTO `system_area2` VALUES ('157', '0001000300060025', '高碑店市', '156', '130684');
INSERT INTO `system_area2` VALUES ('158', '0001000300060026', '高开区', '157', '130698');
INSERT INTO `system_area2` VALUES ('159', '000100030007', '张家口市', '158', '130700');
INSERT INTO `system_area2` VALUES ('160', '0001000300070001', '桥东区', '159', '130702');
INSERT INTO `system_area2` VALUES ('161', '0001000300070002', '桥西区', '160', '130703');
INSERT INTO `system_area2` VALUES ('162', '0001000300070003', '宣化区', '161', '130705');
INSERT INTO `system_area2` VALUES ('163', '0001000300070004', '下花园区', '162', '130706');
INSERT INTO `system_area2` VALUES ('164', '0001000300070005', '宣化县', '163', '130721');
INSERT INTO `system_area2` VALUES ('165', '0001000300070006', '张北县', '164', '130722');
INSERT INTO `system_area2` VALUES ('166', '0001000300070007', '康保县', '165', '130723');
INSERT INTO `system_area2` VALUES ('167', '0001000300070008', '沽源县', '166', '130724');
INSERT INTO `system_area2` VALUES ('168', '0001000300070009', '尚义县', '167', '130725');
INSERT INTO `system_area2` VALUES ('169', '0001000300070010', '蔚县', '168', '130726');
INSERT INTO `system_area2` VALUES ('170', '0001000300070011', '阳原县', '169', '130727');
INSERT INTO `system_area2` VALUES ('171', '0001000300070012', '怀安县', '170', '130728');
INSERT INTO `system_area2` VALUES ('172', '0001000300070013', '万全县', '171', '130729');
INSERT INTO `system_area2` VALUES ('173', '0001000300070014', '怀来县', '172', '130730');
INSERT INTO `system_area2` VALUES ('174', '0001000300070015', '涿鹿县', '173', '130731');
INSERT INTO `system_area2` VALUES ('175', '0001000300070016', '赤城县', '174', '130732');
INSERT INTO `system_area2` VALUES ('176', '0001000300070017', '崇礼县', '175', '130733');
INSERT INTO `system_area2` VALUES ('177', '000100030008', '承德市', '176', '130800');
INSERT INTO `system_area2` VALUES ('178', '0001000300080001', '双桥区', '177', '130802');
INSERT INTO `system_area2` VALUES ('179', '0001000300080002', '双滦区', '178', '130803');
INSERT INTO `system_area2` VALUES ('180', '0001000300080003', '鹰手营子矿区', '179', '130804');
INSERT INTO `system_area2` VALUES ('181', '0001000300080004', '承德县', '180', '130821');
INSERT INTO `system_area2` VALUES ('182', '0001000300080005', '兴隆县', '181', '130822');
INSERT INTO `system_area2` VALUES ('183', '0001000300080006', '平泉县', '182', '130823');
INSERT INTO `system_area2` VALUES ('184', '0001000300080007', '滦平县', '183', '130824');
INSERT INTO `system_area2` VALUES ('185', '0001000300080008', '隆化县', '184', '130825');
INSERT INTO `system_area2` VALUES ('186', '0001000300080009', '丰宁满族自治县', '185', '130826');
INSERT INTO `system_area2` VALUES ('187', '0001000300080010', '宽城满族自治县', '186', '130827');
INSERT INTO `system_area2` VALUES ('188', '0001000300080011', '围场满族蒙古族自治县', '187', '130828');
INSERT INTO `system_area2` VALUES ('189', '000100030009', '沧州市', '188', '130900');
INSERT INTO `system_area2` VALUES ('190', '0001000300090001', '新华区', '189', '130902');
INSERT INTO `system_area2` VALUES ('191', '0001000300090002', '运河区', '190', '130903');
INSERT INTO `system_area2` VALUES ('192', '0001000300090003', '沧县', '191', '130921');
INSERT INTO `system_area2` VALUES ('193', '0001000300090004', '青县', '192', '130922');
INSERT INTO `system_area2` VALUES ('194', '0001000300090005', '东光县', '193', '130923');
INSERT INTO `system_area2` VALUES ('195', '0001000300090006', '海兴县', '194', '130924');
INSERT INTO `system_area2` VALUES ('196', '0001000300090007', '盐山县', '195', '130925');
INSERT INTO `system_area2` VALUES ('197', '0001000300090008', '肃宁县', '196', '130926');
INSERT INTO `system_area2` VALUES ('198', '0001000300090009', '南皮县', '197', '130927');
INSERT INTO `system_area2` VALUES ('199', '0001000300090010', '吴桥县', '198', '130928');
INSERT INTO `system_area2` VALUES ('200', '0001000300090011', '献县', '199', '130929');
INSERT INTO `system_area2` VALUES ('201', '0001000300090012', '孟村回族自治县', '200', '130930');
INSERT INTO `system_area2` VALUES ('202', '0001000300090013', '泊头市', '201', '130981');
INSERT INTO `system_area2` VALUES ('203', '0001000300090014', '任丘市', '202', '130982');
INSERT INTO `system_area2` VALUES ('204', '0001000300090015', '黄骅市', '203', '130983');
INSERT INTO `system_area2` VALUES ('205', '0001000300090016', '河间市', '204', '130984');
INSERT INTO `system_area2` VALUES ('206', '000100030010', '廊坊市', '205', '131000');
INSERT INTO `system_area2` VALUES ('207', '0001000300100001', '安次区', '206', '131002');
INSERT INTO `system_area2` VALUES ('208', '0001000300100002', '广阳区', '207', '131003');
INSERT INTO `system_area2` VALUES ('209', '0001000300100003', '固安县', '208', '131022');
INSERT INTO `system_area2` VALUES ('210', '0001000300100004', '永清县', '209', '131023');
INSERT INTO `system_area2` VALUES ('211', '0001000300100005', '香河县', '210', '131024');
INSERT INTO `system_area2` VALUES ('212', '0001000300100006', '大城县', '211', '131025');
INSERT INTO `system_area2` VALUES ('213', '0001000300100007', '文安县', '212', '131026');
INSERT INTO `system_area2` VALUES ('214', '0001000300100008', '大厂回族自治县', '213', '131028');
INSERT INTO `system_area2` VALUES ('215', '0001000300100009', '开发区', '214', '131051');
INSERT INTO `system_area2` VALUES ('216', '0001000300100010', '燕郊经济技术开发区', '215', '131052');
INSERT INTO `system_area2` VALUES ('217', '0001000300100011', '霸州市', '216', '131081');
INSERT INTO `system_area2` VALUES ('218', '0001000300100012', '三河市', '217', '131082');
INSERT INTO `system_area2` VALUES ('219', '000100030011', '衡水市', '218', '131100');
INSERT INTO `system_area2` VALUES ('220', '0001000300110001', '桃城区', '219', '131102');
INSERT INTO `system_area2` VALUES ('221', '0001000300110002', '枣强县', '220', '131121');
INSERT INTO `system_area2` VALUES ('222', '0001000300110003', '武邑县', '221', '131122');
INSERT INTO `system_area2` VALUES ('223', '0001000300110004', '武强县', '222', '131123');
INSERT INTO `system_area2` VALUES ('224', '0001000300110005', '饶阳县', '223', '131124');
INSERT INTO `system_area2` VALUES ('225', '0001000300110006', '安平县', '224', '131125');
INSERT INTO `system_area2` VALUES ('226', '0001000300110007', '故城县', '225', '131126');
INSERT INTO `system_area2` VALUES ('227', '0001000300110008', '景县', '226', '131127');
INSERT INTO `system_area2` VALUES ('228', '0001000300110009', '阜城县', '227', '131128');
INSERT INTO `system_area2` VALUES ('229', '0001000300110010', '冀州市', '228', '131181');
INSERT INTO `system_area2` VALUES ('230', '0001000300110011', '深州市', '229', '131182');
INSERT INTO `system_area2` VALUES ('231', '00010004', '山西省', '230', '140000');
INSERT INTO `system_area2` VALUES ('232', '000100040001', '太原市', '231', '140100');
INSERT INTO `system_area2` VALUES ('233', '0001000400010001', '小店区', '232', '140105');
INSERT INTO `system_area2` VALUES ('234', '0001000400010002', '迎泽区', '233', '140106');
INSERT INTO `system_area2` VALUES ('235', '0001000400010003', '杏花岭区', '234', '140107');
INSERT INTO `system_area2` VALUES ('236', '0001000400010004', '尖草坪区', '235', '140108');
INSERT INTO `system_area2` VALUES ('237', '0001000400010005', '万柏林区', '236', '140109');
INSERT INTO `system_area2` VALUES ('238', '0001000400010006', '晋源区', '237', '140110');
INSERT INTO `system_area2` VALUES ('239', '0001000400010007', '清徐县', '238', '140121');
INSERT INTO `system_area2` VALUES ('240', '0001000400010008', '阳曲县', '239', '140122');
INSERT INTO `system_area2` VALUES ('241', '0001000400010009', '娄烦县', '240', '140123');
INSERT INTO `system_area2` VALUES ('242', '0001000400010010', '古交市', '241', '140181');
INSERT INTO `system_area2` VALUES ('243', '000100040002', '大同市', '242', '140200');
INSERT INTO `system_area2` VALUES ('244', '0001000400020001', '城区', '243', '140202');
INSERT INTO `system_area2` VALUES ('245', '0001000400020002', '矿区', '244', '140203');
INSERT INTO `system_area2` VALUES ('246', '0001000400020003', '南郊区', '245', '140211');
INSERT INTO `system_area2` VALUES ('247', '0001000400020004', '新荣区', '246', '140212');
INSERT INTO `system_area2` VALUES ('248', '0001000400020005', '阳高县', '247', '140221');
INSERT INTO `system_area2` VALUES ('249', '0001000400020006', '天镇县', '248', '140222');
INSERT INTO `system_area2` VALUES ('250', '0001000400020007', '广灵县', '249', '140223');
INSERT INTO `system_area2` VALUES ('251', '0001000400020008', '灵丘县', '250', '140224');
INSERT INTO `system_area2` VALUES ('252', '0001000400020009', '浑源县', '251', '140225');
INSERT INTO `system_area2` VALUES ('253', '0001000400020010', '左云县', '252', '140226');
INSERT INTO `system_area2` VALUES ('254', '0001000400020011', '大同县', '253', '140227');
INSERT INTO `system_area2` VALUES ('255', '000100040003', '阳泉市', '254', '140300');
INSERT INTO `system_area2` VALUES ('256', '0001000400030001', '城区', '255', '140302');
INSERT INTO `system_area2` VALUES ('257', '0001000400030002', '矿区', '256', '140303');
INSERT INTO `system_area2` VALUES ('258', '0001000400030003', '郊区', '257', '140311');
INSERT INTO `system_area2` VALUES ('259', '0001000400030004', '平定县', '258', '140321');
INSERT INTO `system_area2` VALUES ('260', '0001000400030005', '盂县', '259', '140322');
INSERT INTO `system_area2` VALUES ('261', '000100040004', '长治市', '260', '140400');
INSERT INTO `system_area2` VALUES ('262', '0001000400040001', '长治县', '261', '140421');
INSERT INTO `system_area2` VALUES ('263', '0001000400040002', '襄垣县', '262', '140423');
INSERT INTO `system_area2` VALUES ('264', '0001000400040003', '屯留县', '263', '140424');
INSERT INTO `system_area2` VALUES ('265', '0001000400040004', '平顺县', '264', '140425');
INSERT INTO `system_area2` VALUES ('266', '0001000400040005', '黎城县', '265', '140426');
INSERT INTO `system_area2` VALUES ('267', '0001000400040006', '壶关县', '266', '140427');
INSERT INTO `system_area2` VALUES ('268', '0001000400040007', '长子县', '267', '140428');
INSERT INTO `system_area2` VALUES ('269', '0001000400040008', '武乡县', '268', '140429');
INSERT INTO `system_area2` VALUES ('270', '0001000400040009', '沁县', '269', '140430');
INSERT INTO `system_area2` VALUES ('271', '0001000400040010', '沁源县', '270', '140431');
INSERT INTO `system_area2` VALUES ('272', '0001000400040011', '潞城市', '271', '140481');
INSERT INTO `system_area2` VALUES ('273', '0001000400040012', '城区', '272', '140482');
INSERT INTO `system_area2` VALUES ('274', '0001000400040013', '郊区', '273', '140483');
INSERT INTO `system_area2` VALUES ('275', '0001000400040014', '高新区', '274', '140484');
INSERT INTO `system_area2` VALUES ('276', '000100040005', '晋城市', '275', '140500');
INSERT INTO `system_area2` VALUES ('277', '0001000400050001', '城区', '276', '140502');
INSERT INTO `system_area2` VALUES ('278', '0001000400050002', '沁水县', '277', '140521');
INSERT INTO `system_area2` VALUES ('279', '0001000400050003', '阳城县', '278', '140522');
INSERT INTO `system_area2` VALUES ('280', '0001000400050004', '陵川县', '279', '140524');
INSERT INTO `system_area2` VALUES ('281', '0001000400050005', '泽州县', '280', '140525');
INSERT INTO `system_area2` VALUES ('282', '0001000400050006', '高平市', '281', '140581');
INSERT INTO `system_area2` VALUES ('283', '000100040006', '朔州市', '282', '140600');
INSERT INTO `system_area2` VALUES ('284', '0001000400060001', '朔城区', '283', '140602');
INSERT INTO `system_area2` VALUES ('285', '0001000400060002', '平鲁区', '284', '140603');
INSERT INTO `system_area2` VALUES ('286', '0001000400060003', '山阴县', '285', '140621');
INSERT INTO `system_area2` VALUES ('287', '0001000400060004', '应县', '286', '140622');
INSERT INTO `system_area2` VALUES ('288', '0001000400060005', '右玉县', '287', '140623');
INSERT INTO `system_area2` VALUES ('289', '0001000400060006', '怀仁县', '288', '140624');
INSERT INTO `system_area2` VALUES ('290', '000100040007', '晋中市', '289', '140700');
INSERT INTO `system_area2` VALUES ('291', '0001000400070001', '榆次区', '290', '140702');
INSERT INTO `system_area2` VALUES ('292', '0001000400070002', '榆社县', '291', '140721');
INSERT INTO `system_area2` VALUES ('293', '0001000400070003', '左权县', '292', '140722');
INSERT INTO `system_area2` VALUES ('294', '0001000400070004', '和顺县', '293', '140723');
INSERT INTO `system_area2` VALUES ('295', '0001000400070005', '昔阳县', '294', '140724');
INSERT INTO `system_area2` VALUES ('296', '0001000400070006', '寿阳县', '295', '140725');
INSERT INTO `system_area2` VALUES ('297', '0001000400070007', '太谷县', '296', '140726');
INSERT INTO `system_area2` VALUES ('298', '0001000400070008', '祁县', '297', '140727');
INSERT INTO `system_area2` VALUES ('299', '0001000400070009', '平遥县', '298', '140728');
INSERT INTO `system_area2` VALUES ('300', '0001000400070010', '灵石县', '299', '140729');
INSERT INTO `system_area2` VALUES ('301', '0001000400070011', '介休市', '300', '140781');
INSERT INTO `system_area2` VALUES ('302', '000100040008', '运城市', '301', '140800');
INSERT INTO `system_area2` VALUES ('303', '0001000400080001', '盐湖区', '302', '140802');
INSERT INTO `system_area2` VALUES ('304', '0001000400080002', '临猗县', '303', '140821');
INSERT INTO `system_area2` VALUES ('305', '0001000400080003', '万荣县', '304', '140822');
INSERT INTO `system_area2` VALUES ('306', '0001000400080004', '闻喜县', '305', '140823');
INSERT INTO `system_area2` VALUES ('307', '0001000400080005', '稷山县', '306', '140824');
INSERT INTO `system_area2` VALUES ('308', '0001000400080006', '新绛县', '307', '140825');
INSERT INTO `system_area2` VALUES ('309', '0001000400080007', '绛县', '308', '140826');
INSERT INTO `system_area2` VALUES ('310', '0001000400080008', '垣曲县', '309', '140827');
INSERT INTO `system_area2` VALUES ('311', '0001000400080009', '夏县', '310', '140828');
INSERT INTO `system_area2` VALUES ('312', '0001000400080010', '平陆县', '311', '140829');
INSERT INTO `system_area2` VALUES ('313', '0001000400080011', '芮城县', '312', '140830');
INSERT INTO `system_area2` VALUES ('314', '0001000400080012', '永济市', '313', '140881');
INSERT INTO `system_area2` VALUES ('315', '0001000400080013', '河津市', '314', '140882');
INSERT INTO `system_area2` VALUES ('316', '000100040009', '忻州市', '315', '140900');
INSERT INTO `system_area2` VALUES ('317', '0001000400090001', '忻府区', '316', '140902');
INSERT INTO `system_area2` VALUES ('318', '0001000400090002', '定襄县', '317', '140921');
INSERT INTO `system_area2` VALUES ('319', '0001000400090003', '五台县', '318', '140922');
INSERT INTO `system_area2` VALUES ('320', '0001000400090004', '代县', '319', '140923');
INSERT INTO `system_area2` VALUES ('321', '0001000400090005', '繁峙县', '320', '140924');
INSERT INTO `system_area2` VALUES ('322', '0001000400090006', '宁武县', '321', '140925');
INSERT INTO `system_area2` VALUES ('323', '0001000400090007', '静乐县', '322', '140926');
INSERT INTO `system_area2` VALUES ('324', '0001000400090008', '神池县', '323', '140927');
INSERT INTO `system_area2` VALUES ('325', '0001000400090009', '五寨县', '324', '140928');
INSERT INTO `system_area2` VALUES ('326', '0001000400090010', '岢岚县', '325', '140929');
INSERT INTO `system_area2` VALUES ('327', '0001000400090011', '河曲县', '326', '140930');
INSERT INTO `system_area2` VALUES ('328', '0001000400090012', '保德县', '327', '140931');
INSERT INTO `system_area2` VALUES ('329', '0001000400090013', '偏关县', '328', '140932');
INSERT INTO `system_area2` VALUES ('330', '0001000400090014', '原平市', '329', '140981');
INSERT INTO `system_area2` VALUES ('331', '000100040010', '临汾市', '330', '141000');
INSERT INTO `system_area2` VALUES ('332', '0001000400100001', '尧都区', '331', '141002');
INSERT INTO `system_area2` VALUES ('333', '0001000400100002', '曲沃县', '332', '141021');
INSERT INTO `system_area2` VALUES ('334', '0001000400100003', '翼城县', '333', '141022');
INSERT INTO `system_area2` VALUES ('335', '0001000400100004', '襄汾县', '334', '141023');
INSERT INTO `system_area2` VALUES ('336', '0001000400100005', '洪洞县', '335', '141024');
INSERT INTO `system_area2` VALUES ('337', '0001000400100006', '古县', '336', '141025');
INSERT INTO `system_area2` VALUES ('338', '0001000400100007', '安泽县', '337', '141026');
INSERT INTO `system_area2` VALUES ('339', '0001000400100008', '浮山县', '338', '141027');
INSERT INTO `system_area2` VALUES ('340', '0001000400100009', '吉县', '339', '141028');
INSERT INTO `system_area2` VALUES ('341', '0001000400100010', '乡宁县', '340', '141029');
INSERT INTO `system_area2` VALUES ('342', '0001000400100011', '大宁县', '341', '141030');
INSERT INTO `system_area2` VALUES ('343', '0001000400100012', '隰县', '342', '141031');
INSERT INTO `system_area2` VALUES ('344', '0001000400100013', '永和县', '343', '141032');
INSERT INTO `system_area2` VALUES ('345', '0001000400100014', '蒲县', '344', '141033');
INSERT INTO `system_area2` VALUES ('346', '0001000400100015', '汾西县', '345', '141034');
INSERT INTO `system_area2` VALUES ('347', '0001000400100016', '侯马市', '346', '141081');
INSERT INTO `system_area2` VALUES ('348', '0001000400100017', '霍州市', '347', '141082');
INSERT INTO `system_area2` VALUES ('349', '000100040011', '吕梁市', '348', '141100');
INSERT INTO `system_area2` VALUES ('350', '0001000400110001', '离石区', '349', '141102');
INSERT INTO `system_area2` VALUES ('351', '0001000400110002', '文水县', '350', '141121');
INSERT INTO `system_area2` VALUES ('352', '0001000400110003', '交城县', '351', '141122');
INSERT INTO `system_area2` VALUES ('353', '0001000400110004', '兴县', '352', '141123');
INSERT INTO `system_area2` VALUES ('354', '0001000400110005', '临县', '353', '141124');
INSERT INTO `system_area2` VALUES ('355', '0001000400110006', '柳林县', '354', '141125');
INSERT INTO `system_area2` VALUES ('356', '0001000400110007', '石楼县', '355', '141126');
INSERT INTO `system_area2` VALUES ('357', '0001000400110008', '岚县', '356', '141127');
INSERT INTO `system_area2` VALUES ('358', '0001000400110009', '方山县', '357', '141128');
INSERT INTO `system_area2` VALUES ('359', '0001000400110010', '中阳县', '358', '141129');
INSERT INTO `system_area2` VALUES ('360', '0001000400110011', '交口县', '359', '141130');
INSERT INTO `system_area2` VALUES ('361', '0001000400110012', '孝义市', '360', '141181');
INSERT INTO `system_area2` VALUES ('362', '0001000400110013', '汾阳市', '361', '141182');
INSERT INTO `system_area2` VALUES ('363', '00010005', '内蒙古自治区', '362', '150000');
INSERT INTO `system_area2` VALUES ('364', '000100050001', '呼和浩特市', '363', '150100');
INSERT INTO `system_area2` VALUES ('365', '0001000500010001', '新城区', '364', '150102');
INSERT INTO `system_area2` VALUES ('366', '0001000500010002', '回民区', '365', '150103');
INSERT INTO `system_area2` VALUES ('367', '0001000500010003', '玉泉区', '366', '150104');
INSERT INTO `system_area2` VALUES ('368', '0001000500010004', '赛罕区', '367', '150105');
INSERT INTO `system_area2` VALUES ('369', '0001000500010005', '土默特左旗', '368', '150121');
INSERT INTO `system_area2` VALUES ('370', '0001000500010006', '托克托县', '369', '150122');
INSERT INTO `system_area2` VALUES ('371', '0001000500010007', '和林格尔县', '370', '150123');
INSERT INTO `system_area2` VALUES ('372', '0001000500010008', '清水河县', '371', '150124');
INSERT INTO `system_area2` VALUES ('373', '0001000500010009', '武川县', '372', '150125');
INSERT INTO `system_area2` VALUES ('374', '000100050002', '包头市', '373', '150200');
INSERT INTO `system_area2` VALUES ('375', '0001000500020001', '东河区', '374', '150202');
INSERT INTO `system_area2` VALUES ('376', '0001000500020002', '昆都仑区', '375', '150203');
INSERT INTO `system_area2` VALUES ('377', '0001000500020003', '青山区', '376', '150204');
INSERT INTO `system_area2` VALUES ('378', '0001000500020004', '石拐区', '377', '150205');
INSERT INTO `system_area2` VALUES ('379', '0001000500020005', '白云矿区', '378', '150206');
INSERT INTO `system_area2` VALUES ('380', '0001000500020006', '九原区', '379', '150207');
INSERT INTO `system_area2` VALUES ('381', '0001000500020007', '土默特右旗', '380', '150221');
INSERT INTO `system_area2` VALUES ('382', '0001000500020008', '固阳县', '381', '150222');
INSERT INTO `system_area2` VALUES ('383', '0001000500020009', '达尔罕茂明安联合旗', '382', '150223');
INSERT INTO `system_area2` VALUES ('384', '000100050003', '乌海市', '383', '150300');
INSERT INTO `system_area2` VALUES ('385', '0001000500030001', '海勃湾区', '384', '150302');
INSERT INTO `system_area2` VALUES ('386', '0001000500030002', '海南区', '385', '150303');
INSERT INTO `system_area2` VALUES ('387', '0001000500030003', '乌达区', '386', '150304');
INSERT INTO `system_area2` VALUES ('388', '000100050004', '赤峰市', '387', '150400');
INSERT INTO `system_area2` VALUES ('389', '0001000500040001', '红山区', '388', '150402');
INSERT INTO `system_area2` VALUES ('390', '0001000500040002', '元宝山区', '389', '150403');
INSERT INTO `system_area2` VALUES ('391', '0001000500040003', '松山区', '390', '150404');
INSERT INTO `system_area2` VALUES ('392', '0001000500040004', '阿鲁科尔沁旗', '391', '150421');
INSERT INTO `system_area2` VALUES ('393', '0001000500040005', '巴林左旗', '392', '150422');
INSERT INTO `system_area2` VALUES ('394', '0001000500040006', '巴林右旗', '393', '150423');
INSERT INTO `system_area2` VALUES ('395', '0001000500040007', '林西县', '394', '150424');
INSERT INTO `system_area2` VALUES ('396', '0001000500040008', '克什克腾旗', '395', '150425');
INSERT INTO `system_area2` VALUES ('397', '0001000500040009', '翁牛特旗', '396', '150426');
INSERT INTO `system_area2` VALUES ('398', '0001000500040010', '喀喇沁旗', '397', '150428');
INSERT INTO `system_area2` VALUES ('399', '0001000500040011', '宁城县', '398', '150429');
INSERT INTO `system_area2` VALUES ('400', '0001000500040012', '敖汉旗', '399', '150430');
INSERT INTO `system_area2` VALUES ('401', '000100050005', '通辽市', '400', '150500');
INSERT INTO `system_area2` VALUES ('402', '0001000500050001', '科尔沁区', '401', '150502');
INSERT INTO `system_area2` VALUES ('403', '0001000500050002', '科尔沁左翼中旗', '402', '150521');
INSERT INTO `system_area2` VALUES ('404', '0001000500050003', '科尔沁左翼后旗', '403', '150522');
INSERT INTO `system_area2` VALUES ('405', '0001000500050004', '开鲁县', '404', '150523');
INSERT INTO `system_area2` VALUES ('406', '0001000500050005', '库伦旗', '405', '150524');
INSERT INTO `system_area2` VALUES ('407', '0001000500050006', '奈曼旗', '406', '150525');
INSERT INTO `system_area2` VALUES ('408', '0001000500050007', '扎鲁特旗', '407', '150526');
INSERT INTO `system_area2` VALUES ('409', '0001000500050008', '霍林郭勒市', '408', '150581');
INSERT INTO `system_area2` VALUES ('410', '000100050006', '鄂尔多斯市', '409', '150600');
INSERT INTO `system_area2` VALUES ('411', '0001000500060001', '东胜区', '410', '150602');
INSERT INTO `system_area2` VALUES ('412', '0001000500060002', '达拉特旗', '411', '150621');
INSERT INTO `system_area2` VALUES ('413', '0001000500060003', '准格尔旗', '412', '150622');
INSERT INTO `system_area2` VALUES ('414', '0001000500060004', '鄂托克前旗', '413', '150623');
INSERT INTO `system_area2` VALUES ('415', '0001000500060005', '鄂托克旗', '414', '150624');
INSERT INTO `system_area2` VALUES ('416', '0001000500060006', '杭锦旗', '415', '150625');
INSERT INTO `system_area2` VALUES ('417', '0001000500060007', '乌审旗', '416', '150626');
INSERT INTO `system_area2` VALUES ('418', '0001000500060008', '伊金霍洛旗', '417', '150627');
INSERT INTO `system_area2` VALUES ('419', '000100050007', '呼伦贝尔市', '418', '150700');
INSERT INTO `system_area2` VALUES ('420', '0001000500070001', '海拉尔区', '419', '150702');
INSERT INTO `system_area2` VALUES ('421', '0001000500070002', '阿荣旗', '420', '150721');
INSERT INTO `system_area2` VALUES ('422', '0001000500070003', '莫力达瓦达斡尔族自治旗', '421', '150722');
INSERT INTO `system_area2` VALUES ('423', '0001000500070004', '鄂伦春自治旗', '422', '150723');
INSERT INTO `system_area2` VALUES ('424', '0001000500070005', '鄂温克族自治旗', '423', '150724');
INSERT INTO `system_area2` VALUES ('425', '0001000500070006', '陈巴尔虎旗', '424', '150725');
INSERT INTO `system_area2` VALUES ('426', '0001000500070007', '新巴尔虎左旗', '425', '150726');
INSERT INTO `system_area2` VALUES ('427', '0001000500070008', '新巴尔虎右旗', '426', '150727');
INSERT INTO `system_area2` VALUES ('428', '0001000500070009', '满洲里市', '427', '150781');
INSERT INTO `system_area2` VALUES ('429', '0001000500070010', '牙克石市', '428', '150782');
INSERT INTO `system_area2` VALUES ('430', '0001000500070011', '扎兰屯市', '429', '150783');
INSERT INTO `system_area2` VALUES ('431', '0001000500070012', '额尔古纳市', '430', '150784');
INSERT INTO `system_area2` VALUES ('432', '0001000500070013', '根河市', '431', '150785');
INSERT INTO `system_area2` VALUES ('433', '000100050008', '巴彦淖尔市', '432', '150800');
INSERT INTO `system_area2` VALUES ('434', '0001000500080001', '临河区', '433', '150802');
INSERT INTO `system_area2` VALUES ('435', '0001000500080002', '五原县', '434', '150821');
INSERT INTO `system_area2` VALUES ('436', '0001000500080003', '磴口县', '435', '150822');
INSERT INTO `system_area2` VALUES ('437', '0001000500080004', '乌拉特前旗', '436', '150823');
INSERT INTO `system_area2` VALUES ('438', '0001000500080005', '乌拉特中旗', '437', '150824');
INSERT INTO `system_area2` VALUES ('439', '0001000500080006', '乌拉特后旗', '438', '150825');
INSERT INTO `system_area2` VALUES ('440', '0001000500080007', '杭锦后旗', '439', '150826');
INSERT INTO `system_area2` VALUES ('441', '000100050009', '乌兰察布市', '440', '150900');
INSERT INTO `system_area2` VALUES ('442', '0001000500090001', '集宁区', '441', '150902');
INSERT INTO `system_area2` VALUES ('443', '0001000500090002', '卓资县', '442', '150921');
INSERT INTO `system_area2` VALUES ('444', '0001000500090003', '化德县', '443', '150922');
INSERT INTO `system_area2` VALUES ('445', '0001000500090004', '商都县', '444', '150923');
INSERT INTO `system_area2` VALUES ('446', '0001000500090005', '兴和县', '445', '150924');
INSERT INTO `system_area2` VALUES ('447', '0001000500090006', '凉城县', '446', '150925');
INSERT INTO `system_area2` VALUES ('448', '0001000500090007', '察哈尔右翼前旗', '447', '150926');
INSERT INTO `system_area2` VALUES ('449', '0001000500090008', '察哈尔右翼中旗', '448', '150927');
INSERT INTO `system_area2` VALUES ('450', '0001000500090009', '察哈尔右翼后旗', '449', '150928');
INSERT INTO `system_area2` VALUES ('451', '0001000500090010', '四子王旗', '450', '150929');
INSERT INTO `system_area2` VALUES ('452', '0001000500090011', '丰镇市', '451', '150981');
INSERT INTO `system_area2` VALUES ('453', '000100050010', '兴安盟', '452', '152200');
INSERT INTO `system_area2` VALUES ('454', '0001000500100001', '乌兰浩特市', '453', '152201');
INSERT INTO `system_area2` VALUES ('455', '0001000500100002', '阿尔山市', '454', '152202');
INSERT INTO `system_area2` VALUES ('456', '0001000500100003', '科尔沁右翼前旗', '455', '152221');
INSERT INTO `system_area2` VALUES ('457', '0001000500100004', '科尔沁右翼中旗', '456', '152222');
INSERT INTO `system_area2` VALUES ('458', '0001000500100005', '扎赉特旗', '457', '152223');
INSERT INTO `system_area2` VALUES ('459', '0001000500100006', '突泉县', '458', '152224');
INSERT INTO `system_area2` VALUES ('460', '000100050011', '锡林郭勒盟', '459', '152500');
INSERT INTO `system_area2` VALUES ('461', '0001000500110001', '二连浩特市', '460', '152501');
INSERT INTO `system_area2` VALUES ('462', '0001000500110002', '锡林浩特市', '461', '152502');
INSERT INTO `system_area2` VALUES ('463', '0001000500110003', '阿巴嘎旗', '462', '152522');
INSERT INTO `system_area2` VALUES ('464', '0001000500110004', '苏尼特左旗', '463', '152523');
INSERT INTO `system_area2` VALUES ('465', '0001000500110005', '苏尼特右旗', '464', '152524');
INSERT INTO `system_area2` VALUES ('466', '0001000500110006', '东乌珠穆沁旗', '465', '152525');
INSERT INTO `system_area2` VALUES ('467', '0001000500110007', '西乌珠穆沁旗', '466', '152526');
INSERT INTO `system_area2` VALUES ('468', '0001000500110008', '太仆寺旗', '467', '152527');
INSERT INTO `system_area2` VALUES ('469', '0001000500110009', '镶黄旗', '468', '152528');
INSERT INTO `system_area2` VALUES ('470', '0001000500110010', '正镶白旗', '469', '152529');
INSERT INTO `system_area2` VALUES ('471', '0001000500110011', '正蓝旗', '470', '152530');
INSERT INTO `system_area2` VALUES ('472', '0001000500110012', '多伦县', '471', '152531');
INSERT INTO `system_area2` VALUES ('473', '000100050012', '阿拉善盟', '472', '152900');
INSERT INTO `system_area2` VALUES ('474', '0001000500120001', '阿拉善左旗', '473', '152921');
INSERT INTO `system_area2` VALUES ('475', '0001000500120002', '阿拉善右旗', '474', '152922');
INSERT INTO `system_area2` VALUES ('476', '0001000500120003', '额济纳旗', '475', '152923');
INSERT INTO `system_area2` VALUES ('477', '00010006', '辽宁省', '476', '210000');
INSERT INTO `system_area2` VALUES ('478', '000100060001', '沈阳市', '477', '210100');
INSERT INTO `system_area2` VALUES ('479', '0001000600010001', '和平区', '478', '210102');
INSERT INTO `system_area2` VALUES ('480', '0001000600010002', '沈河区', '479', '210103');
INSERT INTO `system_area2` VALUES ('481', '0001000600010003', '大东区', '480', '210104');
INSERT INTO `system_area2` VALUES ('482', '0001000600010004', '皇姑区', '481', '210105');
INSERT INTO `system_area2` VALUES ('483', '0001000600010005', '铁西区', '482', '210106');
INSERT INTO `system_area2` VALUES ('484', '0001000600010006', '苏家屯区', '483', '210111');
INSERT INTO `system_area2` VALUES ('485', '0001000600010007', '东陵区', '484', '210112');
INSERT INTO `system_area2` VALUES ('486', '0001000600010008', '新城子区', '485', '210113');
INSERT INTO `system_area2` VALUES ('487', '0001000600010009', '于洪区', '486', '210114');
INSERT INTO `system_area2` VALUES ('488', '0001000600010010', '辽中县', '487', '210122');
INSERT INTO `system_area2` VALUES ('489', '0001000600010011', '康平县', '488', '210123');
INSERT INTO `system_area2` VALUES ('490', '0001000600010012', '法库县', '489', '210124');
INSERT INTO `system_area2` VALUES ('491', '0001000600010013', '新民市', '490', '210181');
INSERT INTO `system_area2` VALUES ('492', '0001000600010014', '浑南新区', '491', '210182');
INSERT INTO `system_area2` VALUES ('493', '0001000600010015', '张士开发区', '492', '210183');
INSERT INTO `system_area2` VALUES ('494', '0001000600010016', '沈北新区', '493', '210184');
INSERT INTO `system_area2` VALUES ('495', '000100060002', '大连市', '494', '210200');
INSERT INTO `system_area2` VALUES ('496', '0001000600020001', '中山区', '495', '210202');
INSERT INTO `system_area2` VALUES ('497', '0001000600020002', '西岗区', '496', '210203');
INSERT INTO `system_area2` VALUES ('498', '0001000600020003', '沙河口区', '497', '210204');
INSERT INTO `system_area2` VALUES ('499', '0001000600020004', '甘井子区', '498', '210211');
INSERT INTO `system_area2` VALUES ('500', '0001000600020005', '旅顺口区', '499', '210212');
INSERT INTO `system_area2` VALUES ('501', '0001000600020006', '金州区', '500', '210213');
INSERT INTO `system_area2` VALUES ('502', '0001000600020007', '长海县', '501', '210224');
INSERT INTO `system_area2` VALUES ('503', '0001000600020008', '开发区', '502', '210251');
INSERT INTO `system_area2` VALUES ('504', '0001000600020009', '瓦房店市', '503', '210281');
INSERT INTO `system_area2` VALUES ('505', '0001000600020010', '普兰店市', '504', '210282');
INSERT INTO `system_area2` VALUES ('506', '0001000600020011', '庄河市', '505', '210283');
INSERT INTO `system_area2` VALUES ('507', '0001000600020012', '岭前区', '506', '210297');
INSERT INTO `system_area2` VALUES ('508', '000100060003', '鞍山市', '507', '210300');
INSERT INTO `system_area2` VALUES ('509', '0001000600030001', '铁东区', '508', '210302');
INSERT INTO `system_area2` VALUES ('510', '0001000600030002', '铁西区', '509', '210303');
INSERT INTO `system_area2` VALUES ('511', '0001000600030003', '立山区', '510', '210304');
INSERT INTO `system_area2` VALUES ('512', '0001000600030004', '千山区', '511', '210311');
INSERT INTO `system_area2` VALUES ('513', '0001000600030005', '台安县', '512', '210321');
INSERT INTO `system_area2` VALUES ('514', '0001000600030006', '岫岩满族自治县', '513', '210323');
INSERT INTO `system_area2` VALUES ('515', '0001000600030007', '高新区', '514', '210351');
INSERT INTO `system_area2` VALUES ('516', '0001000600030008', '海城市', '515', '210381');
INSERT INTO `system_area2` VALUES ('517', '000100060004', '抚顺市', '516', '210400');
INSERT INTO `system_area2` VALUES ('518', '0001000600040001', '新抚区', '517', '210402');
INSERT INTO `system_area2` VALUES ('519', '0001000600040002', '东洲区', '518', '210403');
INSERT INTO `system_area2` VALUES ('520', '0001000600040003', '望花区', '519', '210404');
INSERT INTO `system_area2` VALUES ('521', '0001000600040004', '顺城区', '520', '210411');
INSERT INTO `system_area2` VALUES ('522', '0001000600040005', '抚顺县', '521', '210421');
INSERT INTO `system_area2` VALUES ('523', '0001000600040006', '新宾满族自治县', '522', '210422');
INSERT INTO `system_area2` VALUES ('524', '0001000600040007', '清原满族自治县', '523', '210423');
INSERT INTO `system_area2` VALUES ('525', '000100060005', '本溪市', '524', '210500');
INSERT INTO `system_area2` VALUES ('526', '0001000600050001', '平山区', '525', '210502');
INSERT INTO `system_area2` VALUES ('527', '0001000600050002', '溪湖区', '526', '210503');
INSERT INTO `system_area2` VALUES ('528', '0001000600050003', '明山区', '527', '210504');
INSERT INTO `system_area2` VALUES ('529', '0001000600050004', '南芬区', '528', '210505');
INSERT INTO `system_area2` VALUES ('530', '0001000600050005', '本溪满族自治县', '529', '210521');
INSERT INTO `system_area2` VALUES ('531', '0001000600050006', '桓仁满族自治县', '530', '210522');
INSERT INTO `system_area2` VALUES ('532', '000100060006', '丹东市', '531', '210600');
INSERT INTO `system_area2` VALUES ('533', '0001000600060001', '元宝区', '532', '210602');
INSERT INTO `system_area2` VALUES ('534', '0001000600060002', '振兴区', '533', '210603');
INSERT INTO `system_area2` VALUES ('535', '0001000600060003', '振安区', '534', '210604');
INSERT INTO `system_area2` VALUES ('536', '0001000600060004', '宽甸满族自治县', '535', '210624');
INSERT INTO `system_area2` VALUES ('537', '0001000600060005', '东港市', '536', '210681');
INSERT INTO `system_area2` VALUES ('538', '0001000600060006', '凤城市', '537', '210682');
INSERT INTO `system_area2` VALUES ('539', '000100060007', '锦州市', '538', '210700');
INSERT INTO `system_area2` VALUES ('540', '0001000600070001', '古塔区', '539', '210702');
INSERT INTO `system_area2` VALUES ('541', '0001000600070002', '凌河区', '540', '210703');
INSERT INTO `system_area2` VALUES ('542', '0001000600070003', '太和区', '541', '210711');
INSERT INTO `system_area2` VALUES ('543', '0001000600070004', '黑山县', '542', '210726');
INSERT INTO `system_area2` VALUES ('544', '0001000600070005', '义县', '543', '210727');
INSERT INTO `system_area2` VALUES ('545', '0001000600070006', '凌海市', '544', '210781');
INSERT INTO `system_area2` VALUES ('546', '0001000600070007', '北镇市', '545', '210782');
INSERT INTO `system_area2` VALUES ('547', '000100060008', '营口市', '546', '210800');
INSERT INTO `system_area2` VALUES ('548', '0001000600080001', '站前区', '547', '210802');
INSERT INTO `system_area2` VALUES ('549', '0001000600080002', '西市区', '548', '210803');
INSERT INTO `system_area2` VALUES ('550', '0001000600080003', '鲅鱼圈区', '549', '210804');
INSERT INTO `system_area2` VALUES ('551', '0001000600080004', '老边区', '550', '210811');
INSERT INTO `system_area2` VALUES ('552', '0001000600080005', '盖州市', '551', '210881');
INSERT INTO `system_area2` VALUES ('553', '0001000600080006', '大石桥市', '552', '210882');
INSERT INTO `system_area2` VALUES ('554', '000100060009', '阜新市', '553', '210900');
INSERT INTO `system_area2` VALUES ('555', '0001000600090001', '海州区', '554', '210902');
INSERT INTO `system_area2` VALUES ('556', '0001000600090002', '新邱区', '555', '210903');
INSERT INTO `system_area2` VALUES ('557', '0001000600090003', '太平区', '556', '210904');
INSERT INTO `system_area2` VALUES ('558', '0001000600090004', '清河门区', '557', '210905');
INSERT INTO `system_area2` VALUES ('559', '0001000600090005', '细河区', '558', '210911');
INSERT INTO `system_area2` VALUES ('560', '0001000600090006', '阜新蒙古族自治县', '559', '210921');
INSERT INTO `system_area2` VALUES ('561', '0001000600090007', '彰武县', '560', '210922');
INSERT INTO `system_area2` VALUES ('562', '000100060010', '辽阳市', '561', '211000');
INSERT INTO `system_area2` VALUES ('563', '0001000600100001', '白塔区', '562', '211002');
INSERT INTO `system_area2` VALUES ('564', '0001000600100002', '文圣区', '563', '211003');
INSERT INTO `system_area2` VALUES ('565', '0001000600100003', '宏伟区', '564', '211004');
INSERT INTO `system_area2` VALUES ('566', '0001000600100004', '弓长岭区', '565', '211005');
INSERT INTO `system_area2` VALUES ('567', '0001000600100005', '太子河区', '566', '211011');
INSERT INTO `system_area2` VALUES ('568', '0001000600100006', '辽阳县', '567', '211021');
INSERT INTO `system_area2` VALUES ('569', '0001000600100007', '灯塔市', '568', '211081');
INSERT INTO `system_area2` VALUES ('570', '000100060011', '盘锦市', '569', '211100');
INSERT INTO `system_area2` VALUES ('571', '0001000600110001', '双台子区', '570', '211102');
INSERT INTO `system_area2` VALUES ('572', '0001000600110002', '兴隆台区', '571', '211103');
INSERT INTO `system_area2` VALUES ('573', '0001000600110003', '大洼县', '572', '211121');
INSERT INTO `system_area2` VALUES ('574', '0001000600110004', '盘山县', '573', '211122');
INSERT INTO `system_area2` VALUES ('575', '000100060012', '铁岭市', '574', '211200');
INSERT INTO `system_area2` VALUES ('576', '0001000600120001', '银州区', '575', '211202');
INSERT INTO `system_area2` VALUES ('577', '0001000600120002', '清河区', '576', '211204');
INSERT INTO `system_area2` VALUES ('578', '0001000600120003', '铁岭县', '577', '211221');
INSERT INTO `system_area2` VALUES ('579', '0001000600120004', '西丰县', '578', '211223');
INSERT INTO `system_area2` VALUES ('580', '0001000600120005', '昌图县', '579', '211224');
INSERT INTO `system_area2` VALUES ('581', '0001000600120006', '调兵山市', '580', '211281');
INSERT INTO `system_area2` VALUES ('582', '0001000600120007', '开原市', '581', '211282');
INSERT INTO `system_area2` VALUES ('583', '000100060013', '朝阳市', '582', '211300');
INSERT INTO `system_area2` VALUES ('584', '0001000600130001', '双塔区', '583', '211302');
INSERT INTO `system_area2` VALUES ('585', '0001000600130002', '龙城区', '584', '211303');
INSERT INTO `system_area2` VALUES ('586', '0001000600130003', '朝阳县', '585', '211321');
INSERT INTO `system_area2` VALUES ('587', '0001000600130004', '建平县', '586', '211322');
INSERT INTO `system_area2` VALUES ('588', '0001000600130005', '喀喇沁左翼蒙古族自治县', '587', '211324');
INSERT INTO `system_area2` VALUES ('589', '0001000600130006', '北票市', '588', '211381');
INSERT INTO `system_area2` VALUES ('590', '0001000600130007', '凌源市', '589', '211382');
INSERT INTO `system_area2` VALUES ('591', '000100060014', '葫芦岛市', '590', '211400');
INSERT INTO `system_area2` VALUES ('592', '0001000600140001', '连山区', '591', '211402');
INSERT INTO `system_area2` VALUES ('593', '0001000600140002', '龙港区', '592', '211403');
INSERT INTO `system_area2` VALUES ('594', '0001000600140003', '南票区', '593', '211404');
INSERT INTO `system_area2` VALUES ('595', '0001000600140004', '绥中县', '594', '211421');
INSERT INTO `system_area2` VALUES ('596', '0001000600140005', '建昌县', '595', '211422');
INSERT INTO `system_area2` VALUES ('597', '0001000600140006', '兴城市', '596', '211481');
INSERT INTO `system_area2` VALUES ('598', '00010007', '吉林省', '597', '220000');
INSERT INTO `system_area2` VALUES ('599', '000100070001', '长春市', '598', '220100');
INSERT INTO `system_area2` VALUES ('600', '0001000700010001', '南关区', '599', '220102');
INSERT INTO `system_area2` VALUES ('601', '0001000700010002', '宽城区', '600', '220103');
INSERT INTO `system_area2` VALUES ('602', '0001000700010003', '朝阳区', '601', '220104');
INSERT INTO `system_area2` VALUES ('603', '0001000700010004', '二道区', '602', '220105');
INSERT INTO `system_area2` VALUES ('604', '0001000700010005', '绿园区', '603', '220106');
INSERT INTO `system_area2` VALUES ('605', '0001000700010006', '双阳区', '604', '220112');
INSERT INTO `system_area2` VALUES ('606', '0001000700010007', '农安县', '605', '220122');
INSERT INTO `system_area2` VALUES ('607', '0001000700010008', '九台市', '606', '220181');
INSERT INTO `system_area2` VALUES ('608', '0001000700010009', '榆树市', '607', '220182');
INSERT INTO `system_area2` VALUES ('609', '0001000700010010', '德惠市', '608', '220183');
INSERT INTO `system_area2` VALUES ('610', '0001000700010011', '高新技术产业开发区', '609', '220184');
INSERT INTO `system_area2` VALUES ('611', '0001000700010012', '汽车产业开发区', '610', '220185');
INSERT INTO `system_area2` VALUES ('612', '0001000700010013', '经济技术开发区', '611', '220186');
INSERT INTO `system_area2` VALUES ('613', '0001000700010014', '净月旅游开发区', '612', '220187');
INSERT INTO `system_area2` VALUES ('614', '000100070002', '吉林市', '613', '220200');
INSERT INTO `system_area2` VALUES ('615', '0001000700020001', '昌邑区', '614', '220202');
INSERT INTO `system_area2` VALUES ('616', '0001000700020002', '龙潭区', '615', '220203');
INSERT INTO `system_area2` VALUES ('617', '0001000700020003', '船营区', '616', '220204');
INSERT INTO `system_area2` VALUES ('618', '0001000700020004', '丰满区', '617', '220211');
INSERT INTO `system_area2` VALUES ('619', '0001000700020005', '永吉县', '618', '220221');
INSERT INTO `system_area2` VALUES ('620', '0001000700020006', '蛟河市', '619', '220281');
INSERT INTO `system_area2` VALUES ('621', '0001000700020007', '桦甸市', '620', '220282');
INSERT INTO `system_area2` VALUES ('622', '0001000700020008', '舒兰市', '621', '220283');
INSERT INTO `system_area2` VALUES ('623', '0001000700020009', '磐石市', '622', '220284');
INSERT INTO `system_area2` VALUES ('624', '000100070003', '四平市', '623', '220300');
INSERT INTO `system_area2` VALUES ('625', '0001000700030001', '铁西区', '624', '220302');
INSERT INTO `system_area2` VALUES ('626', '0001000700030002', '铁东区', '625', '220303');
INSERT INTO `system_area2` VALUES ('627', '0001000700030003', '梨树县', '626', '220322');
INSERT INTO `system_area2` VALUES ('628', '0001000700030004', '伊通满族自治县', '627', '220323');
INSERT INTO `system_area2` VALUES ('629', '0001000700030005', '公主岭市', '628', '220381');
INSERT INTO `system_area2` VALUES ('630', '0001000700030006', '双辽市', '629', '220382');
INSERT INTO `system_area2` VALUES ('631', '000100070004', '辽源市', '630', '220400');
INSERT INTO `system_area2` VALUES ('632', '0001000700040001', '龙山区', '631', '220402');
INSERT INTO `system_area2` VALUES ('633', '0001000700040002', '西安区', '632', '220403');
INSERT INTO `system_area2` VALUES ('634', '0001000700040003', '东丰县', '633', '220421');
INSERT INTO `system_area2` VALUES ('635', '0001000700040004', '东辽县', '634', '220422');
INSERT INTO `system_area2` VALUES ('636', '000100070005', '通化市', '635', '220500');
INSERT INTO `system_area2` VALUES ('637', '0001000700050001', '东昌区', '636', '220502');
INSERT INTO `system_area2` VALUES ('638', '0001000700050002', '二道江区', '637', '220503');
INSERT INTO `system_area2` VALUES ('639', '0001000700050003', '通化县', '638', '220521');
INSERT INTO `system_area2` VALUES ('640', '0001000700050004', '辉南县', '639', '220523');
INSERT INTO `system_area2` VALUES ('641', '0001000700050005', '柳河县', '640', '220524');
INSERT INTO `system_area2` VALUES ('642', '0001000700050006', '梅河口市', '641', '220581');
INSERT INTO `system_area2` VALUES ('643', '0001000700050007', '集安市', '642', '220582');
INSERT INTO `system_area2` VALUES ('644', '000100070006', '白山市', '643', '220600');
INSERT INTO `system_area2` VALUES ('645', '0001000700060001', '八道江区', '644', '220602');
INSERT INTO `system_area2` VALUES ('646', '0001000700060002', '抚松县', '645', '220621');
INSERT INTO `system_area2` VALUES ('647', '0001000700060003', '靖宇县', '646', '220622');
INSERT INTO `system_area2` VALUES ('648', '0001000700060004', '长白朝鲜族自治县', '647', '220623');
INSERT INTO `system_area2` VALUES ('649', '0001000700060005', '江源市', '648', '220625');
INSERT INTO `system_area2` VALUES ('650', '0001000700060006', '临江市', '649', '220681');
INSERT INTO `system_area2` VALUES ('651', '000100070007', '松原市', '650', '220700');
INSERT INTO `system_area2` VALUES ('652', '0001000700070001', '宁江区', '651', '220702');
INSERT INTO `system_area2` VALUES ('653', '0001000700070002', '前郭尔罗斯蒙古族自治县', '652', '220721');
INSERT INTO `system_area2` VALUES ('654', '0001000700070003', '长岭县', '653', '220722');
INSERT INTO `system_area2` VALUES ('655', '0001000700070004', '乾安县', '654', '220723');
INSERT INTO `system_area2` VALUES ('656', '0001000700070005', '扶余县', '655', '220724');
INSERT INTO `system_area2` VALUES ('657', '000100070008', '白城市', '656', '220800');
INSERT INTO `system_area2` VALUES ('658', '0001000700080001', '洮北区', '657', '220802');
INSERT INTO `system_area2` VALUES ('659', '0001000700080002', '镇赉县', '658', '220821');
INSERT INTO `system_area2` VALUES ('660', '0001000700080003', '通榆县', '659', '220822');
INSERT INTO `system_area2` VALUES ('661', '0001000700080004', '洮南市', '660', '220881');
INSERT INTO `system_area2` VALUES ('662', '0001000700080005', '大安市', '661', '220882');
INSERT INTO `system_area2` VALUES ('663', '000100070009', '延边朝鲜族自治州', '662', '222400');
INSERT INTO `system_area2` VALUES ('664', '0001000700090001', '延吉市', '663', '222401');
INSERT INTO `system_area2` VALUES ('665', '0001000700090002', '图们市', '664', '222402');
INSERT INTO `system_area2` VALUES ('666', '0001000700090003', '敦化市', '665', '222403');
INSERT INTO `system_area2` VALUES ('667', '0001000700090004', '珲春市', '666', '222404');
INSERT INTO `system_area2` VALUES ('668', '0001000700090005', '龙井市', '667', '222405');
INSERT INTO `system_area2` VALUES ('669', '0001000700090006', '和龙市', '668', '222406');
INSERT INTO `system_area2` VALUES ('670', '0001000700090007', '汪清县', '669', '222424');
INSERT INTO `system_area2` VALUES ('671', '0001000700090008', '安图县', '670', '222426');
INSERT INTO `system_area2` VALUES ('672', '00010008', '黑龙江省', '671', '230000');
INSERT INTO `system_area2` VALUES ('673', '000100080001', '哈尔滨市', '672', '230100');
INSERT INTO `system_area2` VALUES ('674', '0001000800010001', '道里区', '673', '230102');
INSERT INTO `system_area2` VALUES ('675', '0001000800010002', '南岗区', '674', '230103');
INSERT INTO `system_area2` VALUES ('676', '0001000800010003', '道外区', '675', '230104');
INSERT INTO `system_area2` VALUES ('677', '0001000800010004', '香坊区', '676', '230106');
INSERT INTO `system_area2` VALUES ('678', '0001000800010005', '动力区', '677', '230107');
INSERT INTO `system_area2` VALUES ('679', '0001000800010006', '平房区', '678', '230108');
INSERT INTO `system_area2` VALUES ('680', '0001000800010007', '松北区', '679', '230109');
INSERT INTO `system_area2` VALUES ('681', '0001000800010008', '呼兰区', '680', '230111');
INSERT INTO `system_area2` VALUES ('682', '0001000800010009', '依兰县', '681', '230123');
INSERT INTO `system_area2` VALUES ('683', '0001000800010010', '方正县', '682', '230124');
INSERT INTO `system_area2` VALUES ('684', '0001000800010011', '宾县', '683', '230125');
INSERT INTO `system_area2` VALUES ('685', '0001000800010012', '巴彦县', '684', '230126');
INSERT INTO `system_area2` VALUES ('686', '0001000800010013', '木兰县', '685', '230127');
INSERT INTO `system_area2` VALUES ('687', '0001000800010014', '通河县', '686', '230128');
INSERT INTO `system_area2` VALUES ('688', '0001000800010015', '延寿县', '687', '230129');
INSERT INTO `system_area2` VALUES ('689', '0001000800010016', '阿城市', '688', '230181');
INSERT INTO `system_area2` VALUES ('690', '0001000800010017', '双城市', '689', '230182');
INSERT INTO `system_area2` VALUES ('691', '0001000800010018', '尚志市', '690', '230183');
INSERT INTO `system_area2` VALUES ('692', '0001000800010019', '五常市', '691', '230184');
INSERT INTO `system_area2` VALUES ('693', '0001000800010020', '阿城市', '692', '230185');
INSERT INTO `system_area2` VALUES ('694', '000100080002', '齐齐哈尔市', '693', '230200');
INSERT INTO `system_area2` VALUES ('695', '0001000800020001', '龙沙区', '694', '230202');
INSERT INTO `system_area2` VALUES ('696', '0001000800020002', '建华区', '695', '230203');
INSERT INTO `system_area2` VALUES ('697', '0001000800020003', '铁锋区', '696', '230204');
INSERT INTO `system_area2` VALUES ('698', '0001000800020004', '昂昂溪区', '697', '230205');
INSERT INTO `system_area2` VALUES ('699', '0001000800020005', '富拉尔基区', '698', '230206');
INSERT INTO `system_area2` VALUES ('700', '0001000800020006', '碾子山区', '699', '230207');
INSERT INTO `system_area2` VALUES ('701', '0001000800020007', '梅里斯达斡尔族区', '700', '230208');
INSERT INTO `system_area2` VALUES ('702', '0001000800020008', '龙江县', '701', '230221');
INSERT INTO `system_area2` VALUES ('703', '0001000800020009', '依安县', '702', '230223');
INSERT INTO `system_area2` VALUES ('704', '0001000800020010', '泰来县', '703', '230224');
INSERT INTO `system_area2` VALUES ('705', '0001000800020011', '甘南县', '704', '230225');
INSERT INTO `system_area2` VALUES ('706', '0001000800020012', '富裕县', '705', '230227');
INSERT INTO `system_area2` VALUES ('707', '0001000800020013', '克山县', '706', '230229');
INSERT INTO `system_area2` VALUES ('708', '0001000800020014', '克东县', '707', '230230');
INSERT INTO `system_area2` VALUES ('709', '0001000800020015', '拜泉县', '708', '230231');
INSERT INTO `system_area2` VALUES ('710', '0001000800020016', '讷河市', '709', '230281');
INSERT INTO `system_area2` VALUES ('711', '000100080003', '鸡西市', '710', '230300');
INSERT INTO `system_area2` VALUES ('712', '0001000800030001', '鸡冠区', '711', '230302');
INSERT INTO `system_area2` VALUES ('713', '0001000800030002', '恒山区', '712', '230303');
INSERT INTO `system_area2` VALUES ('714', '0001000800030003', '滴道区', '713', '230304');
INSERT INTO `system_area2` VALUES ('715', '0001000800030004', '梨树区', '714', '230305');
INSERT INTO `system_area2` VALUES ('716', '0001000800030005', '城子河区', '715', '230306');
INSERT INTO `system_area2` VALUES ('717', '0001000800030006', '麻山区', '716', '230307');
INSERT INTO `system_area2` VALUES ('718', '0001000800030007', '鸡东县', '717', '230321');
INSERT INTO `system_area2` VALUES ('719', '0001000800030008', '虎林市', '718', '230381');
INSERT INTO `system_area2` VALUES ('720', '0001000800030009', '密山市', '719', '230382');
INSERT INTO `system_area2` VALUES ('721', '000100080004', '鹤岗市', '720', '230400');
INSERT INTO `system_area2` VALUES ('722', '0001000800040001', '向阳区', '721', '230402');
INSERT INTO `system_area2` VALUES ('723', '0001000800040002', '工农区', '722', '230403');
INSERT INTO `system_area2` VALUES ('724', '0001000800040003', '南山区', '723', '230404');
INSERT INTO `system_area2` VALUES ('725', '0001000800040004', '兴安区', '724', '230405');
INSERT INTO `system_area2` VALUES ('726', '0001000800040005', '东山区', '725', '230406');
INSERT INTO `system_area2` VALUES ('727', '0001000800040006', '兴山区', '726', '230407');
INSERT INTO `system_area2` VALUES ('728', '0001000800040007', '萝北县', '727', '230421');
INSERT INTO `system_area2` VALUES ('729', '0001000800040008', '绥滨县', '728', '230422');
INSERT INTO `system_area2` VALUES ('730', '000100080005', '双鸭山市', '729', '230500');
INSERT INTO `system_area2` VALUES ('731', '0001000800050001', '尖山区', '730', '230502');
INSERT INTO `system_area2` VALUES ('732', '0001000800050002', '岭东区', '731', '230503');
INSERT INTO `system_area2` VALUES ('733', '0001000800050003', '四方台区', '732', '230505');
INSERT INTO `system_area2` VALUES ('734', '0001000800050004', '宝山区', '733', '230506');
INSERT INTO `system_area2` VALUES ('735', '0001000800050005', '集贤县', '734', '230521');
INSERT INTO `system_area2` VALUES ('736', '0001000800050006', '友谊县', '735', '230522');
INSERT INTO `system_area2` VALUES ('737', '0001000800050007', '宝清县', '736', '230523');
INSERT INTO `system_area2` VALUES ('738', '0001000800050008', '饶河县', '737', '230524');
INSERT INTO `system_area2` VALUES ('739', '000100080006', '大庆市', '738', '230600');
INSERT INTO `system_area2` VALUES ('740', '0001000800060001', '萨尔图区', '739', '230602');
INSERT INTO `system_area2` VALUES ('741', '0001000800060002', '龙凤区', '740', '230603');
INSERT INTO `system_area2` VALUES ('742', '0001000800060003', '让胡路区', '741', '230604');
INSERT INTO `system_area2` VALUES ('743', '0001000800060004', '红岗区', '742', '230605');
INSERT INTO `system_area2` VALUES ('744', '0001000800060005', '大同区', '743', '230606');
INSERT INTO `system_area2` VALUES ('745', '0001000800060006', '肇州县', '744', '230621');
INSERT INTO `system_area2` VALUES ('746', '0001000800060007', '肇源县', '745', '230622');
INSERT INTO `system_area2` VALUES ('747', '0001000800060008', '林甸县', '746', '230623');
INSERT INTO `system_area2` VALUES ('748', '0001000800060009', '杜尔伯特蒙古族自治县', '747', '230624');
INSERT INTO `system_area2` VALUES ('749', '000100080007', '伊春市', '748', '230700');
INSERT INTO `system_area2` VALUES ('750', '0001000800070001', '伊春区', '749', '230702');
INSERT INTO `system_area2` VALUES ('751', '0001000800070002', '南岔区', '750', '230703');
INSERT INTO `system_area2` VALUES ('752', '0001000800070003', '友好区', '751', '230704');
INSERT INTO `system_area2` VALUES ('753', '0001000800070004', '西林区', '752', '230705');
INSERT INTO `system_area2` VALUES ('754', '0001000800070005', '翠峦区', '753', '230706');
INSERT INTO `system_area2` VALUES ('755', '0001000800070006', '新青区', '754', '230707');
INSERT INTO `system_area2` VALUES ('756', '0001000800070007', '美溪区', '755', '230708');
INSERT INTO `system_area2` VALUES ('757', '0001000800070008', '金山屯区', '756', '230709');
INSERT INTO `system_area2` VALUES ('758', '0001000800070009', '五营区', '757', '230710');
INSERT INTO `system_area2` VALUES ('759', '0001000800070010', '乌马河区', '758', '230711');
INSERT INTO `system_area2` VALUES ('760', '0001000800070011', '汤旺河区', '759', '230712');
INSERT INTO `system_area2` VALUES ('761', '0001000800070012', '带岭区', '760', '230713');
INSERT INTO `system_area2` VALUES ('762', '0001000800070013', '乌伊岭区', '761', '230714');
INSERT INTO `system_area2` VALUES ('763', '0001000800070014', '红星区', '762', '230715');
INSERT INTO `system_area2` VALUES ('764', '0001000800070015', '上甘岭区', '763', '230716');
INSERT INTO `system_area2` VALUES ('765', '0001000800070016', '嘉荫县', '764', '230722');
INSERT INTO `system_area2` VALUES ('766', '0001000800070017', '铁力市', '765', '230781');
INSERT INTO `system_area2` VALUES ('767', '000100080008', '佳木斯市', '766', '230800');
INSERT INTO `system_area2` VALUES ('768', '0001000800080001', '永红区', '767', '230802');
INSERT INTO `system_area2` VALUES ('769', '0001000800080002', '向阳区', '768', '230803');
INSERT INTO `system_area2` VALUES ('770', '0001000800080003', '前进区', '769', '230804');
INSERT INTO `system_area2` VALUES ('771', '0001000800080004', '东风区', '770', '230805');
INSERT INTO `system_area2` VALUES ('772', '0001000800080005', '郊区', '771', '230811');
INSERT INTO `system_area2` VALUES ('773', '0001000800080006', '桦南县', '772', '230822');
INSERT INTO `system_area2` VALUES ('774', '0001000800080007', '桦川县', '773', '230826');
INSERT INTO `system_area2` VALUES ('775', '0001000800080008', '汤原县', '774', '230828');
INSERT INTO `system_area2` VALUES ('776', '0001000800080009', '抚远县', '775', '230833');
INSERT INTO `system_area2` VALUES ('777', '0001000800080010', '同江市', '776', '230881');
INSERT INTO `system_area2` VALUES ('778', '0001000800080011', '富锦市', '777', '230882');
INSERT INTO `system_area2` VALUES ('779', '000100080009', '七台河市', '778', '230900');
INSERT INTO `system_area2` VALUES ('780', '0001000800090001', '新兴区', '779', '230902');
INSERT INTO `system_area2` VALUES ('781', '0001000800090002', '桃山区', '780', '230903');
INSERT INTO `system_area2` VALUES ('782', '0001000800090003', '茄子河区', '781', '230904');
INSERT INTO `system_area2` VALUES ('783', '0001000800090004', '勃利县', '782', '230921');
INSERT INTO `system_area2` VALUES ('784', '000100080010', '牡丹江市', '783', '231000');
INSERT INTO `system_area2` VALUES ('785', '0001000800100001', '东安区', '784', '231002');
INSERT INTO `system_area2` VALUES ('786', '0001000800100002', '阳明区', '785', '231003');
INSERT INTO `system_area2` VALUES ('787', '0001000800100003', '爱民区', '786', '231004');
INSERT INTO `system_area2` VALUES ('788', '0001000800100004', '西安区', '787', '231005');
INSERT INTO `system_area2` VALUES ('789', '0001000800100005', '东宁县', '788', '231024');
INSERT INTO `system_area2` VALUES ('790', '0001000800100006', '林口县', '789', '231025');
INSERT INTO `system_area2` VALUES ('791', '0001000800100007', '绥芬河市', '790', '231081');
INSERT INTO `system_area2` VALUES ('792', '0001000800100008', '海林市', '791', '231083');
INSERT INTO `system_area2` VALUES ('793', '0001000800100009', '宁安市', '792', '231084');
INSERT INTO `system_area2` VALUES ('794', '0001000800100010', '穆棱市', '793', '231085');
INSERT INTO `system_area2` VALUES ('795', '000100080011', '黑河市', '794', '231100');
INSERT INTO `system_area2` VALUES ('796', '0001000800110001', '爱辉区', '795', '231102');
INSERT INTO `system_area2` VALUES ('797', '0001000800110002', '嫩江县', '796', '231121');
INSERT INTO `system_area2` VALUES ('798', '0001000800110003', '逊克县', '797', '231123');
INSERT INTO `system_area2` VALUES ('799', '0001000800110004', '孙吴县', '798', '231124');
INSERT INTO `system_area2` VALUES ('800', '0001000800110005', '北安市', '799', '231181');
INSERT INTO `system_area2` VALUES ('801', '0001000800110006', '五大连池市', '800', '231182');
INSERT INTO `system_area2` VALUES ('802', '000100080012', '绥化市', '801', '231200');
INSERT INTO `system_area2` VALUES ('803', '0001000800120001', '北林区', '802', '231202');
INSERT INTO `system_area2` VALUES ('804', '0001000800120002', '望奎县', '803', '231221');
INSERT INTO `system_area2` VALUES ('805', '0001000800120003', '兰西县', '804', '231222');
INSERT INTO `system_area2` VALUES ('806', '0001000800120004', '青冈县', '805', '231223');
INSERT INTO `system_area2` VALUES ('807', '0001000800120005', '庆安县', '806', '231224');
INSERT INTO `system_area2` VALUES ('808', '0001000800120006', '明水县', '807', '231225');
INSERT INTO `system_area2` VALUES ('809', '0001000800120007', '绥棱县', '808', '231226');
INSERT INTO `system_area2` VALUES ('810', '0001000800120008', '安达市', '809', '231281');
INSERT INTO `system_area2` VALUES ('811', '0001000800120009', '肇东市', '810', '231282');
INSERT INTO `system_area2` VALUES ('812', '0001000800120010', '海伦市', '811', '231283');
INSERT INTO `system_area2` VALUES ('813', '000100080013', '大兴安岭地区', '812', '232700');
INSERT INTO `system_area2` VALUES ('814', '0001000800130001', '呼玛县', '813', '232721');
INSERT INTO `system_area2` VALUES ('815', '0001000800130002', '塔河县', '814', '232722');
INSERT INTO `system_area2` VALUES ('816', '0001000800130003', '漠河县', '815', '232723');
INSERT INTO `system_area2` VALUES ('817', '0001000800130004', '加格达奇区', '816', '232724');
INSERT INTO `system_area2` VALUES ('818', '00010009', '上海', '817', '310000');
INSERT INTO `system_area2` VALUES ('819', '000100090001', '上海市', '818', '310100');
INSERT INTO `system_area2` VALUES ('820', '0001000900010001', '黄浦区', '819', '310101');
INSERT INTO `system_area2` VALUES ('821', '0001000900010002', '卢湾区', '820', '310103');
INSERT INTO `system_area2` VALUES ('822', '0001000900010003', '徐汇区', '821', '310104');
INSERT INTO `system_area2` VALUES ('823', '0001000900010004', '长宁区', '822', '310105');
INSERT INTO `system_area2` VALUES ('824', '0001000900010005', '静安区', '823', '310106');
INSERT INTO `system_area2` VALUES ('825', '0001000900010006', '普陀区', '824', '310107');
INSERT INTO `system_area2` VALUES ('826', '0001000900010007', '闸北区', '825', '310108');
INSERT INTO `system_area2` VALUES ('827', '0001000900010008', '虹口区', '826', '310109');
INSERT INTO `system_area2` VALUES ('828', '0001000900010009', '杨浦区', '827', '310110');
INSERT INTO `system_area2` VALUES ('829', '0001000900010010', '闵行区', '828', '310112');
INSERT INTO `system_area2` VALUES ('830', '0001000900010011', '宝山区', '829', '310113');
INSERT INTO `system_area2` VALUES ('831', '0001000900010012', '嘉定区', '830', '310114');
INSERT INTO `system_area2` VALUES ('832', '0001000900010013', '浦东新区', '831', '310115');
INSERT INTO `system_area2` VALUES ('833', '0001000900010014', '金山区', '832', '310116');
INSERT INTO `system_area2` VALUES ('834', '0001000900010015', '松江区', '833', '310117');
INSERT INTO `system_area2` VALUES ('835', '0001000900010016', '青浦区', '834', '310118');
INSERT INTO `system_area2` VALUES ('836', '0001000900010017', '南汇区', '835', '310119');
INSERT INTO `system_area2` VALUES ('837', '0001000900010018', '奉贤区', '836', '310120');
INSERT INTO `system_area2` VALUES ('838', '0001000900010019', '川沙区', '837', '310152');
INSERT INTO `system_area2` VALUES ('839', '0001000900010020', '崇明县', '838', '310230');
INSERT INTO `system_area2` VALUES ('840', '00010010', '江苏省', '839', '320000');
INSERT INTO `system_area2` VALUES ('841', '000100100001', '南京市', '840', '320100');
INSERT INTO `system_area2` VALUES ('842', '0001001000010001', '玄武区', '841', '320102');
INSERT INTO `system_area2` VALUES ('843', '0001001000010002', '白下区', '842', '320103');
INSERT INTO `system_area2` VALUES ('844', '0001001000010003', '秦淮区', '843', '320104');
INSERT INTO `system_area2` VALUES ('845', '0001001000010004', '建邺区', '844', '320105');
INSERT INTO `system_area2` VALUES ('846', '0001001000010005', '鼓楼区', '845', '320106');
INSERT INTO `system_area2` VALUES ('847', '0001001000010006', '下关区', '846', '320107');
INSERT INTO `system_area2` VALUES ('848', '0001001000010007', '浦口区', '847', '320111');
INSERT INTO `system_area2` VALUES ('849', '0001001000010008', '栖霞区', '848', '320113');
INSERT INTO `system_area2` VALUES ('850', '0001001000010009', '雨花台区', '849', '320114');
INSERT INTO `system_area2` VALUES ('851', '0001001000010010', '江宁区', '850', '320115');
INSERT INTO `system_area2` VALUES ('852', '0001001000010011', '六合区', '851', '320116');
INSERT INTO `system_area2` VALUES ('853', '0001001000010012', '溧水县', '852', '320124');
INSERT INTO `system_area2` VALUES ('854', '0001001000010013', '高淳县', '853', '320125');
INSERT INTO `system_area2` VALUES ('855', '000100100002', '无锡市', '854', '320200');
INSERT INTO `system_area2` VALUES ('856', '0001001000020001', '崇安区', '855', '320202');
INSERT INTO `system_area2` VALUES ('857', '0001001000020002', '南长区', '856', '320203');
INSERT INTO `system_area2` VALUES ('858', '0001001000020003', '北塘区', '857', '320204');
INSERT INTO `system_area2` VALUES ('859', '0001001000020004', '锡山区', '858', '320205');
INSERT INTO `system_area2` VALUES ('860', '0001001000020005', '惠山区', '859', '320206');
INSERT INTO `system_area2` VALUES ('861', '0001001000020006', '滨湖区', '860', '320211');
INSERT INTO `system_area2` VALUES ('862', '0001001000020007', '江阴市', '861', '320281');
INSERT INTO `system_area2` VALUES ('863', '0001001000020008', '宜兴市', '862', '320282');
INSERT INTO `system_area2` VALUES ('864', '0001001000020009', '新区', '863', '320296');
INSERT INTO `system_area2` VALUES ('865', '000100100003', '徐州市', '864', '320300');
INSERT INTO `system_area2` VALUES ('866', '0001001000030001', '鼓楼区', '865', '320302');
INSERT INTO `system_area2` VALUES ('867', '0001001000030002', '云龙区', '866', '320303');
INSERT INTO `system_area2` VALUES ('868', '0001001000030003', '九里区', '867', '320304');
INSERT INTO `system_area2` VALUES ('869', '0001001000030004', '贾汪区', '868', '320305');
INSERT INTO `system_area2` VALUES ('870', '0001001000030005', '泉山区', '869', '320311');
INSERT INTO `system_area2` VALUES ('871', '0001001000030006', '丰县', '870', '320321');
INSERT INTO `system_area2` VALUES ('872', '0001001000030007', '沛县', '871', '320322');
INSERT INTO `system_area2` VALUES ('873', '0001001000030008', '铜山县', '872', '320323');
INSERT INTO `system_area2` VALUES ('874', '0001001000030009', '睢宁县', '873', '320324');
INSERT INTO `system_area2` VALUES ('875', '0001001000030010', '新沂市', '874', '320381');
INSERT INTO `system_area2` VALUES ('876', '0001001000030011', '邳州市', '875', '320382');
INSERT INTO `system_area2` VALUES ('877', '000100100004', '常州市', '876', '320400');
INSERT INTO `system_area2` VALUES ('878', '0001001000040001', '天宁区', '877', '320402');
INSERT INTO `system_area2` VALUES ('879', '0001001000040002', '钟楼区', '878', '320404');
INSERT INTO `system_area2` VALUES ('880', '0001001000040003', '戚墅堰区', '879', '320405');
INSERT INTO `system_area2` VALUES ('881', '0001001000040004', '新北区', '880', '320411');
INSERT INTO `system_area2` VALUES ('882', '0001001000040005', '武进区', '881', '320412');
INSERT INTO `system_area2` VALUES ('883', '0001001000040006', '溧阳市', '882', '320481');
INSERT INTO `system_area2` VALUES ('884', '0001001000040007', '金坛市', '883', '320482');
INSERT INTO `system_area2` VALUES ('885', '000100100005', '苏州市', '884', '320500');
INSERT INTO `system_area2` VALUES ('886', '0001001000050001', '沧浪区', '885', '320502');
INSERT INTO `system_area2` VALUES ('887', '0001001000050002', '平江区', '886', '320503');
INSERT INTO `system_area2` VALUES ('888', '0001001000050003', '金阊区', '887', '320504');
INSERT INTO `system_area2` VALUES ('889', '0001001000050004', '虎丘区', '888', '320505');
INSERT INTO `system_area2` VALUES ('890', '0001001000050005', '吴中区', '889', '320506');
INSERT INTO `system_area2` VALUES ('891', '0001001000050006', '相城区', '890', '320507');
INSERT INTO `system_area2` VALUES ('892', '0001001000050007', '常熟市', '891', '320581');
INSERT INTO `system_area2` VALUES ('893', '0001001000050008', '张家港市', '892', '320582');
INSERT INTO `system_area2` VALUES ('894', '0001001000050009', '昆山市', '893', '320583');
INSERT INTO `system_area2` VALUES ('895', '0001001000050010', '吴江市', '894', '320584');
INSERT INTO `system_area2` VALUES ('896', '0001001000050011', '太仓市', '895', '320585');
INSERT INTO `system_area2` VALUES ('897', '0001001000050012', '新区', '896', '320594');
INSERT INTO `system_area2` VALUES ('898', '0001001000050013', '园区', '897', '320595');
INSERT INTO `system_area2` VALUES ('899', '000100100006', '南通市', '898', '320600');
INSERT INTO `system_area2` VALUES ('900', '0001001000060001', '崇川区', '899', '320602');
INSERT INTO `system_area2` VALUES ('901', '0001001000060002', '港闸区', '900', '320611');
INSERT INTO `system_area2` VALUES ('902', '0001001000060003', '通州区', '901', '320612');
INSERT INTO `system_area2` VALUES ('903', '0001001000060004', '海安县', '902', '320621');
INSERT INTO `system_area2` VALUES ('904', '0001001000060005', '如东县', '903', '320623');
INSERT INTO `system_area2` VALUES ('905', '0001001000060006', '启东市', '904', '320681');
INSERT INTO `system_area2` VALUES ('906', '0001001000060007', '如皋市', '905', '320682');
INSERT INTO `system_area2` VALUES ('907', '0001001000060008', '通州市', '906', '320683');
INSERT INTO `system_area2` VALUES ('908', '0001001000060009', '海门市', '907', '320684');
INSERT INTO `system_area2` VALUES ('909', '0001001000060010', '开发区', '908', '320693');
INSERT INTO `system_area2` VALUES ('910', '000100100007', '连云港市', '909', '320700');
INSERT INTO `system_area2` VALUES ('911', '0001001000070001', '连云区', '910', '320703');
INSERT INTO `system_area2` VALUES ('912', '0001001000070002', '新浦区', '911', '320705');
INSERT INTO `system_area2` VALUES ('913', '0001001000070003', '海州区', '912', '320706');
INSERT INTO `system_area2` VALUES ('914', '0001001000070004', '赣榆县', '913', '320721');
INSERT INTO `system_area2` VALUES ('915', '0001001000070005', '东海县', '914', '320722');
INSERT INTO `system_area2` VALUES ('916', '0001001000070006', '灌云县', '915', '320723');
INSERT INTO `system_area2` VALUES ('917', '0001001000070007', '灌南县', '916', '320724');
INSERT INTO `system_area2` VALUES ('918', '000100100008', '淮安市', '917', '320800');
INSERT INTO `system_area2` VALUES ('919', '0001001000080001', '清河区', '918', '320802');
INSERT INTO `system_area2` VALUES ('920', '0001001000080002', '楚州区', '919', '320803');
INSERT INTO `system_area2` VALUES ('921', '0001001000080003', '淮阴区', '920', '320804');
INSERT INTO `system_area2` VALUES ('922', '0001001000080004', '清浦区', '921', '320811');
INSERT INTO `system_area2` VALUES ('923', '0001001000080005', '涟水县', '922', '320826');
INSERT INTO `system_area2` VALUES ('924', '0001001000080006', '洪泽县', '923', '320829');
INSERT INTO `system_area2` VALUES ('925', '0001001000080007', '盱眙县', '924', '320830');
INSERT INTO `system_area2` VALUES ('926', '0001001000080008', '金湖县', '925', '320831');
INSERT INTO `system_area2` VALUES ('927', '000100100009', '盐城市', '926', '320900');
INSERT INTO `system_area2` VALUES ('928', '0001001000090001', '亭湖区', '927', '320902');
INSERT INTO `system_area2` VALUES ('929', '0001001000090002', '盐都区', '928', '320903');
INSERT INTO `system_area2` VALUES ('930', '0001001000090003', '响水县', '929', '320921');
INSERT INTO `system_area2` VALUES ('931', '0001001000090004', '滨海县', '930', '320922');
INSERT INTO `system_area2` VALUES ('932', '0001001000090005', '阜宁县', '931', '320923');
INSERT INTO `system_area2` VALUES ('933', '0001001000090006', '射阳县', '932', '320924');
INSERT INTO `system_area2` VALUES ('934', '0001001000090007', '建湖县', '933', '320925');
INSERT INTO `system_area2` VALUES ('935', '0001001000090008', '东台市', '934', '320981');
INSERT INTO `system_area2` VALUES ('936', '0001001000090009', '大丰市', '935', '320982');
INSERT INTO `system_area2` VALUES ('937', '000100100010', '扬州市', '936', '321000');
INSERT INTO `system_area2` VALUES ('938', '0001001000100001', '广陵区', '937', '321002');
INSERT INTO `system_area2` VALUES ('939', '0001001000100002', '邗江区', '938', '321003');
INSERT INTO `system_area2` VALUES ('940', '0001001000100003', '维扬区', '939', '321011');
INSERT INTO `system_area2` VALUES ('941', '0001001000100004', '宝应县', '940', '321023');
INSERT INTO `system_area2` VALUES ('942', '0001001000100005', '仪征市', '941', '321081');
INSERT INTO `system_area2` VALUES ('943', '0001001000100006', '高邮市', '942', '321084');
INSERT INTO `system_area2` VALUES ('944', '0001001000100007', '江都市', '943', '321088');
INSERT INTO `system_area2` VALUES ('945', '0001001000100008', '经济开发区', '944', '321092');
INSERT INTO `system_area2` VALUES ('946', '000100100011', '镇江市', '945', '321100');
INSERT INTO `system_area2` VALUES ('947', '0001001000110001', '京口区', '946', '321102');
INSERT INTO `system_area2` VALUES ('948', '0001001000110002', '润州区', '947', '321111');
INSERT INTO `system_area2` VALUES ('949', '0001001000110003', '丹徒区', '948', '321112');
INSERT INTO `system_area2` VALUES ('950', '0001001000110004', '丹阳市', '949', '321181');
INSERT INTO `system_area2` VALUES ('951', '0001001000110005', '扬中市', '950', '321182');
INSERT INTO `system_area2` VALUES ('952', '0001001000110006', '句容市', '951', '321183');
INSERT INTO `system_area2` VALUES ('953', '000100100012', '泰州市', '952', '321200');
INSERT INTO `system_area2` VALUES ('954', '0001001000120001', '海陵区', '953', '321202');
INSERT INTO `system_area2` VALUES ('955', '0001001000120002', '高港区', '954', '321203');
INSERT INTO `system_area2` VALUES ('956', '0001001000120003', '兴化市', '955', '321281');
INSERT INTO `system_area2` VALUES ('957', '0001001000120004', '靖江市', '956', '321282');
INSERT INTO `system_area2` VALUES ('958', '0001001000120005', '泰兴市', '957', '321283');
INSERT INTO `system_area2` VALUES ('959', '0001001000120006', '姜堰市', '958', '321284');
INSERT INTO `system_area2` VALUES ('960', '000100100013', '宿迁市', '959', '321300');
INSERT INTO `system_area2` VALUES ('961', '0001001000130001', '宿城区', '960', '321302');
INSERT INTO `system_area2` VALUES ('962', '0001001000130002', '宿豫区', '961', '321311');
INSERT INTO `system_area2` VALUES ('963', '0001001000130003', '沭阳县', '962', '321322');
INSERT INTO `system_area2` VALUES ('964', '0001001000130004', '泗阳县', '963', '321323');
INSERT INTO `system_area2` VALUES ('965', '0001001000130005', '泗洪县', '964', '321324');
INSERT INTO `system_area2` VALUES ('966', '00010011', '浙江省', '965', '330000');
INSERT INTO `system_area2` VALUES ('967', '000100110001', '杭州市', '966', '330100');
INSERT INTO `system_area2` VALUES ('968', '0001001100010001', '上城区', '967', '330102');
INSERT INTO `system_area2` VALUES ('969', '0001001100010002', '下城区', '968', '330103');
INSERT INTO `system_area2` VALUES ('970', '0001001100010003', '江干区', '969', '330104');
INSERT INTO `system_area2` VALUES ('971', '0001001100010004', '拱墅区', '970', '330105');
INSERT INTO `system_area2` VALUES ('972', '0001001100010005', '西湖区', '971', '330106');
INSERT INTO `system_area2` VALUES ('973', '0001001100010006', '滨江区', '972', '330108');
INSERT INTO `system_area2` VALUES ('974', '0001001100010007', '萧山区', '973', '330109');
INSERT INTO `system_area2` VALUES ('975', '0001001100010008', '余杭区', '974', '330110');
INSERT INTO `system_area2` VALUES ('976', '0001001100010009', '桐庐县', '975', '330122');
INSERT INTO `system_area2` VALUES ('977', '0001001100010010', '淳安县', '976', '330127');
INSERT INTO `system_area2` VALUES ('978', '0001001100010011', '建德市', '977', '330182');
INSERT INTO `system_area2` VALUES ('979', '0001001100010012', '富阳市', '978', '330183');
INSERT INTO `system_area2` VALUES ('980', '0001001100010013', '临安市', '979', '330185');
INSERT INTO `system_area2` VALUES ('981', '000100110002', '宁波市', '980', '330200');
INSERT INTO `system_area2` VALUES ('982', '0001001100020001', '海曙区', '981', '330203');
INSERT INTO `system_area2` VALUES ('983', '0001001100020002', '江东区', '982', '330204');
INSERT INTO `system_area2` VALUES ('984', '0001001100020003', '江北区', '983', '330205');
INSERT INTO `system_area2` VALUES ('985', '0001001100020004', '北仑区', '984', '330206');
INSERT INTO `system_area2` VALUES ('986', '0001001100020005', '镇海区', '985', '330211');
INSERT INTO `system_area2` VALUES ('987', '0001001100020006', '鄞州区', '986', '330212');
INSERT INTO `system_area2` VALUES ('988', '0001001100020007', '象山县', '987', '330225');
INSERT INTO `system_area2` VALUES ('989', '0001001100020008', '宁海县', '988', '330226');
INSERT INTO `system_area2` VALUES ('990', '0001001100020009', '余姚市', '989', '330281');
INSERT INTO `system_area2` VALUES ('991', '0001001100020010', '慈溪市', '990', '330282');
INSERT INTO `system_area2` VALUES ('992', '0001001100020011', '奉化市', '991', '330283');
INSERT INTO `system_area2` VALUES ('993', '000100110003', '温州市', '992', '330300');
INSERT INTO `system_area2` VALUES ('994', '0001001100030001', '鹿城区', '993', '330302');
INSERT INTO `system_area2` VALUES ('995', '0001001100030002', '龙湾区', '994', '330303');
INSERT INTO `system_area2` VALUES ('996', '0001001100030003', '瓯海区', '995', '330304');
INSERT INTO `system_area2` VALUES ('997', '0001001100030004', '洞头县', '996', '330322');
INSERT INTO `system_area2` VALUES ('998', '0001001100030005', '永嘉县', '997', '330324');
INSERT INTO `system_area2` VALUES ('999', '0001001100030006', '平阳县', '998', '330326');
INSERT INTO `system_area2` VALUES ('1000', '0001001100030007', '苍南县', '999', '330327');
INSERT INTO `system_area2` VALUES ('1001', '0001001100030008', '文成县', '1000', '330328');
INSERT INTO `system_area2` VALUES ('1002', '0001001100030009', '泰顺县', '1001', '330329');
INSERT INTO `system_area2` VALUES ('1003', '0001001100030010', '瑞安市', '1002', '330381');
INSERT INTO `system_area2` VALUES ('1004', '0001001100030011', '乐清市', '1003', '330382');
INSERT INTO `system_area2` VALUES ('1005', '000100110004', '嘉兴市', '1004', '330400');
INSERT INTO `system_area2` VALUES ('1006', '0001001100040001', '南湖区', '1005', '330402');
INSERT INTO `system_area2` VALUES ('1007', '0001001100040002', '秀洲区', '1006', '330411');
INSERT INTO `system_area2` VALUES ('1008', '0001001100040003', '嘉善县', '1007', '330421');
INSERT INTO `system_area2` VALUES ('1009', '0001001100040004', '海盐县', '1008', '330424');
INSERT INTO `system_area2` VALUES ('1010', '0001001100040005', '海宁市', '1009', '330481');
INSERT INTO `system_area2` VALUES ('1011', '0001001100040006', '平湖市', '1010', '330482');
INSERT INTO `system_area2` VALUES ('1012', '0001001100040007', '桐乡市', '1011', '330483');
INSERT INTO `system_area2` VALUES ('1013', '000100110005', '湖州市', '1012', '330500');
INSERT INTO `system_area2` VALUES ('1014', '0001001100050001', '吴兴区', '1013', '330502');
INSERT INTO `system_area2` VALUES ('1015', '0001001100050002', '南浔区', '1014', '330503');
INSERT INTO `system_area2` VALUES ('1016', '0001001100050003', '德清县', '1015', '330521');
INSERT INTO `system_area2` VALUES ('1017', '0001001100050004', '长兴县', '1016', '330522');
INSERT INTO `system_area2` VALUES ('1018', '0001001100050005', '安吉县', '1017', '330523');
INSERT INTO `system_area2` VALUES ('1019', '000100110006', '绍兴市', '1018', '330600');
INSERT INTO `system_area2` VALUES ('1020', '0001001100060001', '越城区', '1019', '330602');
INSERT INTO `system_area2` VALUES ('1021', '0001001100060002', '绍兴县', '1020', '330621');
INSERT INTO `system_area2` VALUES ('1022', '0001001100060003', '新昌县', '1021', '330624');
INSERT INTO `system_area2` VALUES ('1023', '0001001100060004', '诸暨市', '1022', '330681');
INSERT INTO `system_area2` VALUES ('1024', '0001001100060005', '上虞市', '1023', '330682');
INSERT INTO `system_area2` VALUES ('1025', '0001001100060006', '嵊州市', '1024', '330683');
INSERT INTO `system_area2` VALUES ('1026', '000100110007', '金华市', '1025', '330700');
INSERT INTO `system_area2` VALUES ('1027', '0001001100070001', '婺城区', '1026', '330702');
INSERT INTO `system_area2` VALUES ('1028', '0001001100070002', '金东区', '1027', '330703');
INSERT INTO `system_area2` VALUES ('1029', '0001001100070003', '武义县', '1028', '330723');
INSERT INTO `system_area2` VALUES ('1030', '0001001100070004', '浦江县', '1029', '330726');
INSERT INTO `system_area2` VALUES ('1031', '0001001100070005', '磐安县', '1030', '330727');
INSERT INTO `system_area2` VALUES ('1032', '0001001100070006', '兰溪市', '1031', '330781');
INSERT INTO `system_area2` VALUES ('1033', '0001001100070007', '义乌市', '1032', '330782');
INSERT INTO `system_area2` VALUES ('1034', '0001001100070008', '东阳市', '1033', '330783');
INSERT INTO `system_area2` VALUES ('1035', '0001001100070009', '永康市', '1034', '330784');
INSERT INTO `system_area2` VALUES ('1036', '000100110008', '衢州市', '1035', '330800');
INSERT INTO `system_area2` VALUES ('1037', '0001001100080001', '柯城区', '1036', '330802');
INSERT INTO `system_area2` VALUES ('1038', '0001001100080002', '衢江区', '1037', '330803');
INSERT INTO `system_area2` VALUES ('1039', '0001001100080003', '常山县', '1038', '330822');
INSERT INTO `system_area2` VALUES ('1040', '0001001100080004', '开化县', '1039', '330824');
INSERT INTO `system_area2` VALUES ('1041', '0001001100080005', '龙游县', '1040', '330825');
INSERT INTO `system_area2` VALUES ('1042', '0001001100080006', '江山市', '1041', '330881');
INSERT INTO `system_area2` VALUES ('1043', '000100110009', '舟山市', '1042', '330900');
INSERT INTO `system_area2` VALUES ('1044', '0001001100090001', '定海区', '1043', '330902');
INSERT INTO `system_area2` VALUES ('1045', '0001001100090002', '普陀区', '1044', '330903');
INSERT INTO `system_area2` VALUES ('1046', '0001001100090003', '岱山县', '1045', '330921');
INSERT INTO `system_area2` VALUES ('1047', '0001001100090004', '嵊泗县', '1046', '330922');
INSERT INTO `system_area2` VALUES ('1048', '000100110010', '台州市', '1047', '331000');
INSERT INTO `system_area2` VALUES ('1049', '0001001100100001', '椒江区', '1048', '331002');
INSERT INTO `system_area2` VALUES ('1050', '0001001100100002', '黄岩区', '1049', '331003');
INSERT INTO `system_area2` VALUES ('1051', '0001001100100003', '路桥区', '1050', '331004');
INSERT INTO `system_area2` VALUES ('1052', '0001001100100004', '玉环县', '1051', '331021');
INSERT INTO `system_area2` VALUES ('1053', '0001001100100005', '三门县', '1052', '331022');
INSERT INTO `system_area2` VALUES ('1054', '0001001100100006', '天台县', '1053', '331023');
INSERT INTO `system_area2` VALUES ('1055', '0001001100100007', '仙居县', '1054', '331024');
INSERT INTO `system_area2` VALUES ('1056', '0001001100100008', '温岭市', '1055', '331081');
INSERT INTO `system_area2` VALUES ('1057', '0001001100100009', '临海市', '1056', '331082');
INSERT INTO `system_area2` VALUES ('1058', '000100110011', '丽水市', '1057', '331100');
INSERT INTO `system_area2` VALUES ('1059', '0001001100110001', '莲都区', '1058', '331102');
INSERT INTO `system_area2` VALUES ('1060', '0001001100110002', '青田县', '1059', '331121');
INSERT INTO `system_area2` VALUES ('1061', '0001001100110003', '缙云县', '1060', '331122');
INSERT INTO `system_area2` VALUES ('1062', '0001001100110004', '遂昌县', '1061', '331123');
INSERT INTO `system_area2` VALUES ('1063', '0001001100110005', '松阳县', '1062', '331124');
INSERT INTO `system_area2` VALUES ('1064', '0001001100110006', '云和县', '1063', '331125');
INSERT INTO `system_area2` VALUES ('1065', '0001001100110007', '庆元县', '1064', '331126');
INSERT INTO `system_area2` VALUES ('1066', '0001001100110008', '景宁畲族自治县', '1065', '331127');
INSERT INTO `system_area2` VALUES ('1067', '0001001100110009', '龙泉市', '1066', '331181');
INSERT INTO `system_area2` VALUES ('1068', '00010012', '安徽省', '1067', '340000');
INSERT INTO `system_area2` VALUES ('1069', '000100120001', '合肥市', '1068', '340100');
INSERT INTO `system_area2` VALUES ('1070', '0001001200010001', '瑶海区', '1069', '340102');
INSERT INTO `system_area2` VALUES ('1071', '0001001200010002', '庐阳区', '1070', '340103');
INSERT INTO `system_area2` VALUES ('1072', '0001001200010003', '蜀山区', '1071', '340104');
INSERT INTO `system_area2` VALUES ('1073', '0001001200010004', '包河区', '1072', '340111');
INSERT INTO `system_area2` VALUES ('1074', '0001001200010005', '长丰县', '1073', '340121');
INSERT INTO `system_area2` VALUES ('1075', '0001001200010006', '肥东县', '1074', '340122');
INSERT INTO `system_area2` VALUES ('1076', '0001001200010007', '肥西县', '1075', '340123');
INSERT INTO `system_area2` VALUES ('1077', '0001001200010008', '高新区', '1076', '340151');
INSERT INTO `system_area2` VALUES ('1078', '0001001200010009', '中区', '1077', '340191');
INSERT INTO `system_area2` VALUES ('1079', '0001001200010010', '巢湖市', '1078', '341400');
INSERT INTO `system_area2` VALUES ('1080', '0001001200010011', '居巢区', '1079', '341402');
INSERT INTO `system_area2` VALUES ('1081', '0001001200010012', '庐江县', '1080', '341421');
INSERT INTO `system_area2` VALUES ('1082', '000100120002', '芜湖市', '1081', '340200');
INSERT INTO `system_area2` VALUES ('1083', '0001001200020001', '镜湖区', '1082', '340202');
INSERT INTO `system_area2` VALUES ('1084', '0001001200020002', '弋江区', '1083', '340203');
INSERT INTO `system_area2` VALUES ('1085', '0001001200020003', '鸠江区', '1084', '340207');
INSERT INTO `system_area2` VALUES ('1086', '0001001200020004', '三山区', '1085', '340208');
INSERT INTO `system_area2` VALUES ('1087', '0001001200020005', '芜湖县', '1086', '340221');
INSERT INTO `system_area2` VALUES ('1088', '0001001200020006', '繁昌县', '1087', '340222');
INSERT INTO `system_area2` VALUES ('1089', '0001001200020007', '南陵县', '1088', '340223');
INSERT INTO `system_area2` VALUES ('1090', '0001001200020008', '无为县', '1089', '341422');
INSERT INTO `system_area2` VALUES ('1091', '000100120003', '蚌埠市', '1090', '340300');
INSERT INTO `system_area2` VALUES ('1092', '0001001200030001', '龙子湖区', '1091', '340302');
INSERT INTO `system_area2` VALUES ('1093', '0001001200030002', '蚌山区', '1092', '340303');
INSERT INTO `system_area2` VALUES ('1094', '0001001200030003', '禹会区', '1093', '340304');
INSERT INTO `system_area2` VALUES ('1095', '0001001200030004', '淮上区', '1094', '340311');
INSERT INTO `system_area2` VALUES ('1096', '0001001200030005', '怀远县', '1095', '340321');
INSERT INTO `system_area2` VALUES ('1097', '0001001200030006', '五河县', '1096', '340322');
INSERT INTO `system_area2` VALUES ('1098', '0001001200030007', '固镇县', '1097', '340323');
INSERT INTO `system_area2` VALUES ('1099', '000100120004', '淮南市', '1098', '340400');
INSERT INTO `system_area2` VALUES ('1100', '0001001200040001', '大通区', '1099', '340402');
INSERT INTO `system_area2` VALUES ('1101', '0001001200040002', '田家庵区', '1100', '340403');
INSERT INTO `system_area2` VALUES ('1102', '0001001200040003', '谢家集区', '1101', '340404');
INSERT INTO `system_area2` VALUES ('1103', '0001001200040004', '八公山区', '1102', '340405');
INSERT INTO `system_area2` VALUES ('1104', '0001001200040005', '潘集区', '1103', '340406');
INSERT INTO `system_area2` VALUES ('1105', '0001001200040006', '凤台县', '1104', '340421');
INSERT INTO `system_area2` VALUES ('1106', '000100120005', '马鞍山市', '1105', '340500');
INSERT INTO `system_area2` VALUES ('1107', '0001001200050001', '金家庄区', '1106', '340502');
INSERT INTO `system_area2` VALUES ('1108', '0001001200050002', '花山区', '1107', '340503');
INSERT INTO `system_area2` VALUES ('1109', '0001001200050003', '雨山区', '1108', '340504');
INSERT INTO `system_area2` VALUES ('1110', '0001001200050004', '当涂县', '1109', '340521');
INSERT INTO `system_area2` VALUES ('1111', '0001001200050005', '含山县', '1110', '341423');
INSERT INTO `system_area2` VALUES ('1112', '0001001200050006', '和县', '1111', '341424');
INSERT INTO `system_area2` VALUES ('1113', '000100120006', '淮北市', '1112', '340600');
INSERT INTO `system_area2` VALUES ('1114', '0001001200060001', '杜集区', '1113', '340602');
INSERT INTO `system_area2` VALUES ('1115', '0001001200060002', '相山区', '1114', '340603');
INSERT INTO `system_area2` VALUES ('1116', '0001001200060003', '烈山区', '1115', '340604');
INSERT INTO `system_area2` VALUES ('1117', '0001001200060004', '濉溪县', '1116', '340621');
INSERT INTO `system_area2` VALUES ('1118', '000100120007', '铜陵市', '1117', '340700');
INSERT INTO `system_area2` VALUES ('1119', '0001001200070001', '铜官山区', '1118', '340702');
INSERT INTO `system_area2` VALUES ('1120', '0001001200070002', '狮子山区', '1119', '340703');
INSERT INTO `system_area2` VALUES ('1121', '0001001200070003', '郊区', '1120', '340711');
INSERT INTO `system_area2` VALUES ('1122', '0001001200070004', '铜陵县', '1121', '340721');
INSERT INTO `system_area2` VALUES ('1123', '000100120008', '安庆市', '1122', '340800');
INSERT INTO `system_area2` VALUES ('1124', '0001001200080001', '迎江区', '1123', '340802');
INSERT INTO `system_area2` VALUES ('1125', '0001001200080002', '大观区', '1124', '340803');
INSERT INTO `system_area2` VALUES ('1126', '0001001200080003', '宜秀区', '1125', '340811');
INSERT INTO `system_area2` VALUES ('1127', '0001001200080004', '怀宁县', '1126', '340822');
INSERT INTO `system_area2` VALUES ('1128', '0001001200080005', '枞阳县', '1127', '340823');
INSERT INTO `system_area2` VALUES ('1129', '0001001200080006', '潜山县', '1128', '340824');
INSERT INTO `system_area2` VALUES ('1130', '0001001200080007', '太湖县', '1129', '340825');
INSERT INTO `system_area2` VALUES ('1131', '0001001200080008', '宿松县', '1130', '340826');
INSERT INTO `system_area2` VALUES ('1132', '0001001200080009', '望江县', '1131', '340827');
INSERT INTO `system_area2` VALUES ('1133', '0001001200080010', '岳西县', '1132', '340828');
INSERT INTO `system_area2` VALUES ('1134', '0001001200080011', '桐城市', '1133', '340881');
INSERT INTO `system_area2` VALUES ('1135', '000100120009', '黄山市', '1134', '341000');
INSERT INTO `system_area2` VALUES ('1136', '0001001200090001', '屯溪区', '1135', '341002');
INSERT INTO `system_area2` VALUES ('1137', '0001001200090002', '黄山区', '1136', '341003');
INSERT INTO `system_area2` VALUES ('1138', '0001001200090003', '徽州区', '1137', '341004');
INSERT INTO `system_area2` VALUES ('1139', '0001001200090004', '歙县', '1138', '341021');
INSERT INTO `system_area2` VALUES ('1140', '0001001200090005', '休宁县', '1139', '341022');
INSERT INTO `system_area2` VALUES ('1141', '0001001200090006', '黟县', '1140', '341023');
INSERT INTO `system_area2` VALUES ('1142', '0001001200090007', '祁门县', '1141', '341024');
INSERT INTO `system_area2` VALUES ('1143', '000100120010', '滁州市', '1142', '341100');
INSERT INTO `system_area2` VALUES ('1144', '0001001200100001', '琅琊区', '1143', '341102');
INSERT INTO `system_area2` VALUES ('1145', '0001001200100002', '南谯区', '1144', '341103');
INSERT INTO `system_area2` VALUES ('1146', '0001001200100003', '来安县', '1145', '341122');
INSERT INTO `system_area2` VALUES ('1147', '0001001200100004', '全椒县', '1146', '341124');
INSERT INTO `system_area2` VALUES ('1148', '0001001200100005', '定远县', '1147', '341125');
INSERT INTO `system_area2` VALUES ('1149', '0001001200100006', '凤阳县', '1148', '341126');
INSERT INTO `system_area2` VALUES ('1150', '0001001200100007', '天长市', '1149', '341181');
INSERT INTO `system_area2` VALUES ('1151', '0001001200100008', '明光市', '1150', '341182');
INSERT INTO `system_area2` VALUES ('1152', '000100120011', '阜阳市', '1151', '341200');
INSERT INTO `system_area2` VALUES ('1153', '0001001200110001', '颍州区', '1152', '341202');
INSERT INTO `system_area2` VALUES ('1154', '0001001200110002', '颍东区', '1153', '341203');
INSERT INTO `system_area2` VALUES ('1155', '0001001200110003', '颍泉区', '1154', '341204');
INSERT INTO `system_area2` VALUES ('1156', '0001001200110004', '临泉县', '1155', '341221');
INSERT INTO `system_area2` VALUES ('1157', '0001001200110005', '太和县', '1156', '341222');
INSERT INTO `system_area2` VALUES ('1158', '0001001200110006', '阜南县', '1157', '341225');
INSERT INTO `system_area2` VALUES ('1159', '0001001200110007', '颍上县', '1158', '341226');
INSERT INTO `system_area2` VALUES ('1160', '0001001200110008', '界首市', '1159', '341282');
INSERT INTO `system_area2` VALUES ('1161', '000100120012', '宿州市', '1160', '341300');
INSERT INTO `system_area2` VALUES ('1162', '0001001200120001', '埇桥区', '1161', '341302');
INSERT INTO `system_area2` VALUES ('1163', '0001001200120002', '砀山县', '1162', '341321');
INSERT INTO `system_area2` VALUES ('1164', '0001001200120003', '萧县', '1163', '341322');
INSERT INTO `system_area2` VALUES ('1165', '0001001200120004', '灵璧县', '1164', '341323');
INSERT INTO `system_area2` VALUES ('1166', '0001001200120005', '泗县', '1165', '341324');
INSERT INTO `system_area2` VALUES ('1167', '000100120013', '六安市', '1166', '341500');
INSERT INTO `system_area2` VALUES ('1168', '0001001200130001', '金安区', '1167', '341502');
INSERT INTO `system_area2` VALUES ('1169', '0001001200130002', '裕安区', '1168', '341503');
INSERT INTO `system_area2` VALUES ('1170', '0001001200130003', '寿县', '1169', '341521');
INSERT INTO `system_area2` VALUES ('1171', '0001001200130004', '霍邱县', '1170', '341522');
INSERT INTO `system_area2` VALUES ('1172', '0001001200130005', '舒城县', '1171', '341523');
INSERT INTO `system_area2` VALUES ('1173', '0001001200130006', '金寨县', '1172', '341524');
INSERT INTO `system_area2` VALUES ('1174', '0001001200130007', '霍山县', '1173', '341525');
INSERT INTO `system_area2` VALUES ('1175', '000100120014', '亳州市', '1174', '341600');
INSERT INTO `system_area2` VALUES ('1176', '0001001200140001', '谯城区', '1175', '341602');
INSERT INTO `system_area2` VALUES ('1177', '0001001200140002', '涡阳县', '1176', '341621');
INSERT INTO `system_area2` VALUES ('1178', '0001001200140003', '蒙城县', '1177', '341622');
INSERT INTO `system_area2` VALUES ('1179', '0001001200140004', '利辛县', '1178', '341623');
INSERT INTO `system_area2` VALUES ('1180', '000100120015', '池州市', '1179', '341700');
INSERT INTO `system_area2` VALUES ('1181', '0001001200150001', '贵池区', '1180', '341702');
INSERT INTO `system_area2` VALUES ('1182', '0001001200150002', '东至县', '1181', '341721');
INSERT INTO `system_area2` VALUES ('1183', '0001001200150003', '石台县', '1182', '341722');
INSERT INTO `system_area2` VALUES ('1184', '0001001200150004', '青阳县', '1183', '341723');
INSERT INTO `system_area2` VALUES ('1185', '000100120016', '宣城市', '1184', '341800');
INSERT INTO `system_area2` VALUES ('1186', '0001001200160001', '宣州区', '1185', '341802');
INSERT INTO `system_area2` VALUES ('1187', '0001001200160002', '郎溪县', '1186', '341821');
INSERT INTO `system_area2` VALUES ('1188', '0001001200160003', '广德县', '1187', '341822');
INSERT INTO `system_area2` VALUES ('1189', '0001001200160004', '泾县', '1188', '341823');
INSERT INTO `system_area2` VALUES ('1190', '0001001200160005', '绩溪县', '1189', '341824');
INSERT INTO `system_area2` VALUES ('1191', '0001001200160006', '旌德县', '1190', '341825');
INSERT INTO `system_area2` VALUES ('1192', '0001001200160007', '宁国市', '1191', '341881');
INSERT INTO `system_area2` VALUES ('1193', '00010013', '福建省', '1192', '350000');
INSERT INTO `system_area2` VALUES ('1194', '000100130001', '福州市', '1193', '350100');
INSERT INTO `system_area2` VALUES ('1195', '0001001300010001', '鼓楼区', '1194', '350102');
INSERT INTO `system_area2` VALUES ('1196', '0001001300010002', '台江区', '1195', '350103');
INSERT INTO `system_area2` VALUES ('1197', '0001001300010003', '仓山区', '1196', '350104');
INSERT INTO `system_area2` VALUES ('1198', '0001001300010004', '马尾区', '1197', '350105');
INSERT INTO `system_area2` VALUES ('1199', '0001001300010005', '晋安区', '1198', '350111');
INSERT INTO `system_area2` VALUES ('1200', '0001001300010006', '闽侯县', '1199', '350121');
INSERT INTO `system_area2` VALUES ('1201', '0001001300010007', '连江县', '1200', '350122');
INSERT INTO `system_area2` VALUES ('1202', '0001001300010008', '罗源县', '1201', '350123');
INSERT INTO `system_area2` VALUES ('1203', '0001001300010009', '闽清县', '1202', '350124');
INSERT INTO `system_area2` VALUES ('1204', '0001001300010010', '永泰县', '1203', '350125');
INSERT INTO `system_area2` VALUES ('1205', '0001001300010011', '平潭县', '1204', '350128');
INSERT INTO `system_area2` VALUES ('1206', '0001001300010012', '福清市', '1205', '350181');
INSERT INTO `system_area2` VALUES ('1207', '0001001300010013', '长乐市', '1206', '350182');
INSERT INTO `system_area2` VALUES ('1208', '000100130002', '厦门市', '1207', '350200');
INSERT INTO `system_area2` VALUES ('1209', '0001001300020001', '思明区', '1208', '350203');
INSERT INTO `system_area2` VALUES ('1210', '0001001300020002', '海沧区', '1209', '350205');
INSERT INTO `system_area2` VALUES ('1211', '0001001300020003', '湖里区', '1210', '350206');
INSERT INTO `system_area2` VALUES ('1212', '0001001300020004', '集美区', '1211', '350211');
INSERT INTO `system_area2` VALUES ('1213', '0001001300020005', '同安区', '1212', '350212');
INSERT INTO `system_area2` VALUES ('1214', '0001001300020006', '翔安区', '1213', '350213');
INSERT INTO `system_area2` VALUES ('1215', '000100130003', '莆田市', '1214', '350300');
INSERT INTO `system_area2` VALUES ('1216', '0001001300030001', '城厢区', '1215', '350302');
INSERT INTO `system_area2` VALUES ('1217', '0001001300030002', '涵江区', '1216', '350303');
INSERT INTO `system_area2` VALUES ('1218', '0001001300030003', '荔城区', '1217', '350304');
INSERT INTO `system_area2` VALUES ('1219', '0001001300030004', '秀屿区', '1218', '350305');
INSERT INTO `system_area2` VALUES ('1220', '0001001300030005', '仙游县', '1219', '350322');
INSERT INTO `system_area2` VALUES ('1221', '000100130004', '三明市', '1220', '350400');
INSERT INTO `system_area2` VALUES ('1222', '0001001300040001', '梅列区', '1221', '350402');
INSERT INTO `system_area2` VALUES ('1223', '0001001300040002', '三元区', '1222', '350403');
INSERT INTO `system_area2` VALUES ('1224', '0001001300040003', '明溪县', '1223', '350421');
INSERT INTO `system_area2` VALUES ('1225', '0001001300040004', '清流县', '1224', '350423');
INSERT INTO `system_area2` VALUES ('1226', '0001001300040005', '宁化县', '1225', '350424');
INSERT INTO `system_area2` VALUES ('1227', '0001001300040006', '大田县', '1226', '350425');
INSERT INTO `system_area2` VALUES ('1228', '0001001300040007', '尤溪县', '1227', '350426');
INSERT INTO `system_area2` VALUES ('1229', '0001001300040008', '沙县', '1228', '350427');
INSERT INTO `system_area2` VALUES ('1230', '0001001300040009', '将乐县', '1229', '350428');
INSERT INTO `system_area2` VALUES ('1231', '0001001300040010', '泰宁县', '1230', '350429');
INSERT INTO `system_area2` VALUES ('1232', '0001001300040011', '建宁县', '1231', '350430');
INSERT INTO `system_area2` VALUES ('1233', '0001001300040012', '永安市', '1232', '350481');
INSERT INTO `system_area2` VALUES ('1234', '000100130005', '泉州市', '1233', '350500');
INSERT INTO `system_area2` VALUES ('1235', '0001001300050001', '鲤城区', '1234', '350502');
INSERT INTO `system_area2` VALUES ('1236', '0001001300050002', '丰泽区', '1235', '350503');
INSERT INTO `system_area2` VALUES ('1237', '0001001300050003', '洛江区', '1236', '350504');
INSERT INTO `system_area2` VALUES ('1238', '0001001300050004', '泉港区', '1237', '350505');
INSERT INTO `system_area2` VALUES ('1239', '0001001300050005', '惠安县', '1238', '350521');
INSERT INTO `system_area2` VALUES ('1240', '0001001300050006', '安溪县', '1239', '350524');
INSERT INTO `system_area2` VALUES ('1241', '0001001300050007', '永春县', '1240', '350525');
INSERT INTO `system_area2` VALUES ('1242', '0001001300050008', '德化县', '1241', '350526');
INSERT INTO `system_area2` VALUES ('1243', '0001001300050009', '金门县', '1242', '350527');
INSERT INTO `system_area2` VALUES ('1244', '0001001300050010', '石狮市', '1243', '350581');
INSERT INTO `system_area2` VALUES ('1245', '0001001300050011', '晋江市', '1244', '350582');
INSERT INTO `system_area2` VALUES ('1246', '0001001300050012', '南安市', '1245', '350583');
INSERT INTO `system_area2` VALUES ('1247', '000100130006', '漳州市', '1246', '350600');
INSERT INTO `system_area2` VALUES ('1248', '0001001300060001', '芗城区', '1247', '350602');
INSERT INTO `system_area2` VALUES ('1249', '0001001300060002', '龙文区', '1248', '350603');
INSERT INTO `system_area2` VALUES ('1250', '0001001300060003', '云霄县', '1249', '350622');
INSERT INTO `system_area2` VALUES ('1251', '0001001300060004', '漳浦县', '1250', '350623');
INSERT INTO `system_area2` VALUES ('1252', '0001001300060005', '诏安县', '1251', '350624');
INSERT INTO `system_area2` VALUES ('1253', '0001001300060006', '长泰县', '1252', '350625');
INSERT INTO `system_area2` VALUES ('1254', '0001001300060007', '东山县', '1253', '350626');
INSERT INTO `system_area2` VALUES ('1255', '0001001300060008', '南靖县', '1254', '350627');
INSERT INTO `system_area2` VALUES ('1256', '0001001300060009', '平和县', '1255', '350628');
INSERT INTO `system_area2` VALUES ('1257', '0001001300060010', '华安县', '1256', '350629');
INSERT INTO `system_area2` VALUES ('1258', '0001001300060011', '龙海市', '1257', '350681');
INSERT INTO `system_area2` VALUES ('1259', '000100130007', '南平市', '1258', '350700');
INSERT INTO `system_area2` VALUES ('1260', '0001001300070001', '延平区', '1259', '350702');
INSERT INTO `system_area2` VALUES ('1261', '0001001300070002', '顺昌县', '1260', '350721');
INSERT INTO `system_area2` VALUES ('1262', '0001001300070003', '浦城县', '1261', '350722');
INSERT INTO `system_area2` VALUES ('1263', '0001001300070004', '光泽县', '1262', '350723');
INSERT INTO `system_area2` VALUES ('1264', '0001001300070005', '松溪县', '1263', '350724');
INSERT INTO `system_area2` VALUES ('1265', '0001001300070006', '政和县', '1264', '350725');
INSERT INTO `system_area2` VALUES ('1266', '0001001300070007', '邵武市', '1265', '350781');
INSERT INTO `system_area2` VALUES ('1267', '0001001300070008', '武夷山市', '1266', '350782');
INSERT INTO `system_area2` VALUES ('1268', '0001001300070009', '建瓯市', '1267', '350783');
INSERT INTO `system_area2` VALUES ('1269', '0001001300070010', '建阳市', '1268', '350784');
INSERT INTO `system_area2` VALUES ('1270', '000100130008', '龙岩市', '1269', '350800');
INSERT INTO `system_area2` VALUES ('1271', '0001001300080001', '新罗区', '1270', '350802');
INSERT INTO `system_area2` VALUES ('1272', '0001001300080002', '长汀县', '1271', '350821');
INSERT INTO `system_area2` VALUES ('1273', '0001001300080003', '永定县', '1272', '350822');
INSERT INTO `system_area2` VALUES ('1274', '0001001300080004', '上杭县', '1273', '350823');
INSERT INTO `system_area2` VALUES ('1275', '0001001300080005', '武平县', '1274', '350824');
INSERT INTO `system_area2` VALUES ('1276', '0001001300080006', '连城县', '1275', '350825');
INSERT INTO `system_area2` VALUES ('1277', '0001001300080007', '漳平市', '1276', '350881');
INSERT INTO `system_area2` VALUES ('1278', '000100130009', '宁德市', '1277', '350900');
INSERT INTO `system_area2` VALUES ('1279', '0001001300090001', '蕉城区', '1278', '350902');
INSERT INTO `system_area2` VALUES ('1280', '0001001300090002', '霞浦县', '1279', '350921');
INSERT INTO `system_area2` VALUES ('1281', '0001001300090003', '古田县', '1280', '350922');
INSERT INTO `system_area2` VALUES ('1282', '0001001300090004', '屏南县', '1281', '350923');
INSERT INTO `system_area2` VALUES ('1283', '0001001300090005', '寿宁县', '1282', '350924');
INSERT INTO `system_area2` VALUES ('1284', '0001001300090006', '周宁县', '1283', '350925');
INSERT INTO `system_area2` VALUES ('1285', '0001001300090007', '柘荣县', '1284', '350926');
INSERT INTO `system_area2` VALUES ('1286', '0001001300090008', '福安市', '1285', '350981');
INSERT INTO `system_area2` VALUES ('1287', '0001001300090009', '福鼎市', '1286', '350982');
INSERT INTO `system_area2` VALUES ('1288', '00010014', '江西省', '1287', '360000');
INSERT INTO `system_area2` VALUES ('1289', '000100140001', '南昌市', '1288', '360100');
INSERT INTO `system_area2` VALUES ('1290', '0001001400010001', '东湖区', '1289', '360102');
INSERT INTO `system_area2` VALUES ('1291', '0001001400010002', '西湖区', '1290', '360103');
INSERT INTO `system_area2` VALUES ('1292', '0001001400010003', '青云谱区', '1291', '360104');
INSERT INTO `system_area2` VALUES ('1293', '0001001400010004', '湾里区', '1292', '360105');
INSERT INTO `system_area2` VALUES ('1294', '0001001400010005', '青山湖区', '1293', '360111');
INSERT INTO `system_area2` VALUES ('1295', '0001001400010006', '南昌县', '1294', '360121');
INSERT INTO `system_area2` VALUES ('1296', '0001001400010007', '新建县', '1295', '360122');
INSERT INTO `system_area2` VALUES ('1297', '0001001400010008', '安义县', '1296', '360123');
INSERT INTO `system_area2` VALUES ('1298', '0001001400010009', '进贤县', '1297', '360124');
INSERT INTO `system_area2` VALUES ('1299', '0001001400010010', '红谷滩新区', '1298', '360125');
INSERT INTO `system_area2` VALUES ('1300', '0001001400010011', '经济技术开发区', '1299', '360126');
INSERT INTO `system_area2` VALUES ('1301', '0001001400010012', '昌北区', '1300', '360127');
INSERT INTO `system_area2` VALUES ('1302', '000100140002', '景德镇市', '1301', '360200');
INSERT INTO `system_area2` VALUES ('1303', '0001001400020001', '昌江区', '1302', '360202');
INSERT INTO `system_area2` VALUES ('1304', '0001001400020002', '珠山区', '1303', '360203');
INSERT INTO `system_area2` VALUES ('1305', '0001001400020003', '浮梁县', '1304', '360222');
INSERT INTO `system_area2` VALUES ('1306', '0001001400020004', '乐平市', '1305', '360281');
INSERT INTO `system_area2` VALUES ('1307', '000100140003', '萍乡市', '1306', '360300');
INSERT INTO `system_area2` VALUES ('1308', '0001001400030001', '安源区', '1307', '360302');
INSERT INTO `system_area2` VALUES ('1309', '0001001400030002', '湘东区', '1308', '360313');
INSERT INTO `system_area2` VALUES ('1310', '0001001400030003', '莲花县', '1309', '360321');
INSERT INTO `system_area2` VALUES ('1311', '0001001400030004', '上栗县', '1310', '360322');
INSERT INTO `system_area2` VALUES ('1312', '0001001400030005', '芦溪县', '1311', '360323');
INSERT INTO `system_area2` VALUES ('1313', '000100140004', '九江市', '1312', '360400');
INSERT INTO `system_area2` VALUES ('1314', '0001001400040001', '庐山区', '1313', '360402');
INSERT INTO `system_area2` VALUES ('1315', '0001001400040002', '浔阳区', '1314', '360403');
INSERT INTO `system_area2` VALUES ('1316', '0001001400040003', '九江县', '1315', '360421');
INSERT INTO `system_area2` VALUES ('1317', '0001001400040004', '武宁县', '1316', '360423');
INSERT INTO `system_area2` VALUES ('1318', '0001001400040005', '修水县', '1317', '360424');
INSERT INTO `system_area2` VALUES ('1319', '0001001400040006', '永修县', '1318', '360425');
INSERT INTO `system_area2` VALUES ('1320', '0001001400040007', '德安县', '1319', '360426');
INSERT INTO `system_area2` VALUES ('1321', '0001001400040008', '星子县', '1320', '360427');
INSERT INTO `system_area2` VALUES ('1322', '0001001400040009', '都昌县', '1321', '360428');
INSERT INTO `system_area2` VALUES ('1323', '0001001400040010', '湖口县', '1322', '360429');
INSERT INTO `system_area2` VALUES ('1324', '0001001400040011', '彭泽县', '1323', '360430');
INSERT INTO `system_area2` VALUES ('1325', '0001001400040012', '瑞昌市', '1324', '360481');
INSERT INTO `system_area2` VALUES ('1326', '000100140005', '新余市', '1325', '360500');
INSERT INTO `system_area2` VALUES ('1327', '0001001400050001', '渝水区', '1326', '360502');
INSERT INTO `system_area2` VALUES ('1328', '0001001400050002', '分宜县', '1327', '360521');
INSERT INTO `system_area2` VALUES ('1329', '000100140006', '鹰潭市', '1328', '360600');
INSERT INTO `system_area2` VALUES ('1330', '0001001400060001', '月湖区', '1329', '360602');
INSERT INTO `system_area2` VALUES ('1331', '0001001400060002', '余江县', '1330', '360622');
INSERT INTO `system_area2` VALUES ('1332', '0001001400060003', '贵溪市', '1331', '360681');
INSERT INTO `system_area2` VALUES ('1333', '000100140007', '赣州市', '1332', '360700');
INSERT INTO `system_area2` VALUES ('1334', '0001001400070001', '章贡区', '1333', '360702');
INSERT INTO `system_area2` VALUES ('1335', '0001001400070002', '赣县', '1334', '360721');
INSERT INTO `system_area2` VALUES ('1336', '0001001400070003', '信丰县', '1335', '360722');
INSERT INTO `system_area2` VALUES ('1337', '0001001400070004', '大余县', '1336', '360723');
INSERT INTO `system_area2` VALUES ('1338', '0001001400070005', '上犹县', '1337', '360724');
INSERT INTO `system_area2` VALUES ('1339', '0001001400070006', '崇义县', '1338', '360725');
INSERT INTO `system_area2` VALUES ('1340', '0001001400070007', '安远县', '1339', '360726');
INSERT INTO `system_area2` VALUES ('1341', '0001001400070008', '龙南县', '1340', '360727');
INSERT INTO `system_area2` VALUES ('1342', '0001001400070009', '定南县', '1341', '360728');
INSERT INTO `system_area2` VALUES ('1343', '0001001400070010', '全南县', '1342', '360729');
INSERT INTO `system_area2` VALUES ('1344', '0001001400070011', '宁都县', '1343', '360730');
INSERT INTO `system_area2` VALUES ('1345', '0001001400070012', '于都县', '1344', '360731');
INSERT INTO `system_area2` VALUES ('1346', '0001001400070013', '兴国县', '1345', '360732');
INSERT INTO `system_area2` VALUES ('1347', '0001001400070014', '会昌县', '1346', '360733');
INSERT INTO `system_area2` VALUES ('1348', '0001001400070015', '寻乌县', '1347', '360734');
INSERT INTO `system_area2` VALUES ('1349', '0001001400070016', '石城县', '1348', '360735');
INSERT INTO `system_area2` VALUES ('1350', '0001001400070017', '黄金区', '1349', '360751');
INSERT INTO `system_area2` VALUES ('1351', '0001001400070018', '瑞金市', '1350', '360781');
INSERT INTO `system_area2` VALUES ('1352', '0001001400070019', '南康市', '1351', '360782');
INSERT INTO `system_area2` VALUES ('1353', '000100140008', '吉安市', '1352', '360800');
INSERT INTO `system_area2` VALUES ('1354', '0001001400080001', '吉州区', '1353', '360802');
INSERT INTO `system_area2` VALUES ('1355', '0001001400080002', '青原区', '1354', '360803');
INSERT INTO `system_area2` VALUES ('1356', '0001001400080003', '吉安县', '1355', '360821');
INSERT INTO `system_area2` VALUES ('1357', '0001001400080004', '吉水县', '1356', '360822');
INSERT INTO `system_area2` VALUES ('1358', '0001001400080005', '峡江县', '1357', '360823');
INSERT INTO `system_area2` VALUES ('1359', '0001001400080006', '新干县', '1358', '360824');
INSERT INTO `system_area2` VALUES ('1360', '0001001400080007', '永丰县', '1359', '360825');
INSERT INTO `system_area2` VALUES ('1361', '0001001400080008', '泰和县', '1360', '360826');
INSERT INTO `system_area2` VALUES ('1362', '0001001400080009', '遂川县', '1361', '360827');
INSERT INTO `system_area2` VALUES ('1363', '0001001400080010', '万安县', '1362', '360828');
INSERT INTO `system_area2` VALUES ('1364', '0001001400080011', '安福县', '1363', '360829');
INSERT INTO `system_area2` VALUES ('1365', '0001001400080012', '永新县', '1364', '360830');
INSERT INTO `system_area2` VALUES ('1366', '0001001400080013', '井冈山市', '1365', '360881');
INSERT INTO `system_area2` VALUES ('1367', '000100140009', '宜春市', '1366', '360900');
INSERT INTO `system_area2` VALUES ('1368', '0001001400090001', '袁州区', '1367', '360902');
INSERT INTO `system_area2` VALUES ('1369', '0001001400090002', '奉新县', '1368', '360921');
INSERT INTO `system_area2` VALUES ('1370', '0001001400090003', '万载县', '1369', '360922');
INSERT INTO `system_area2` VALUES ('1371', '0001001400090004', '上高县', '1370', '360923');
INSERT INTO `system_area2` VALUES ('1372', '0001001400090005', '宜丰县', '1371', '360924');
INSERT INTO `system_area2` VALUES ('1373', '0001001400090006', '靖安县', '1372', '360925');
INSERT INTO `system_area2` VALUES ('1374', '0001001400090007', '铜鼓县', '1373', '360926');
INSERT INTO `system_area2` VALUES ('1375', '0001001400090008', '丰城市', '1374', '360981');
INSERT INTO `system_area2` VALUES ('1376', '0001001400090009', '樟树市', '1375', '360982');
INSERT INTO `system_area2` VALUES ('1377', '0001001400090010', '高安市', '1376', '360983');
INSERT INTO `system_area2` VALUES ('1378', '000100140010', '抚州市', '1377', '361000');
INSERT INTO `system_area2` VALUES ('1379', '0001001400100001', '临川区', '1378', '361002');
INSERT INTO `system_area2` VALUES ('1380', '0001001400100002', '南城县', '1379', '361021');
INSERT INTO `system_area2` VALUES ('1381', '0001001400100003', '黎川县', '1380', '361022');
INSERT INTO `system_area2` VALUES ('1382', '0001001400100004', '南丰县', '1381', '361023');
INSERT INTO `system_area2` VALUES ('1383', '0001001400100005', '崇仁县', '1382', '361024');
INSERT INTO `system_area2` VALUES ('1384', '0001001400100006', '乐安县', '1383', '361025');
INSERT INTO `system_area2` VALUES ('1385', '0001001400100007', '宜黄县', '1384', '361026');
INSERT INTO `system_area2` VALUES ('1386', '0001001400100008', '金溪县', '1385', '361027');
INSERT INTO `system_area2` VALUES ('1387', '0001001400100009', '资溪县', '1386', '361028');
INSERT INTO `system_area2` VALUES ('1388', '0001001400100010', '东乡县', '1387', '361029');
INSERT INTO `system_area2` VALUES ('1389', '0001001400100011', '广昌县', '1388', '361030');
INSERT INTO `system_area2` VALUES ('1390', '000100140011', '上饶市', '1389', '361100');
INSERT INTO `system_area2` VALUES ('1391', '0001001400110001', '信州区', '1390', '361102');
INSERT INTO `system_area2` VALUES ('1392', '0001001400110002', '上饶县', '1391', '361121');
INSERT INTO `system_area2` VALUES ('1393', '0001001400110003', '广丰县', '1392', '361122');
INSERT INTO `system_area2` VALUES ('1394', '0001001400110004', '玉山县', '1393', '361123');
INSERT INTO `system_area2` VALUES ('1395', '0001001400110005', '铅山县', '1394', '361124');
INSERT INTO `system_area2` VALUES ('1396', '0001001400110006', '横峰县', '1395', '361125');
INSERT INTO `system_area2` VALUES ('1397', '0001001400110007', '弋阳县', '1396', '361126');
INSERT INTO `system_area2` VALUES ('1398', '0001001400110008', '余干县', '1397', '361127');
INSERT INTO `system_area2` VALUES ('1399', '0001001400110009', '鄱阳县', '1398', '361128');
INSERT INTO `system_area2` VALUES ('1400', '0001001400110010', '万年县', '1399', '361129');
INSERT INTO `system_area2` VALUES ('1401', '0001001400110011', '婺源县', '1400', '361130');
INSERT INTO `system_area2` VALUES ('1402', '0001001400110012', '德兴市', '1401', '361181');
INSERT INTO `system_area2` VALUES ('1403', '00010015', '山东省', '1402', '370000');
INSERT INTO `system_area2` VALUES ('1404', '000100150001', '济南市', '1403', '370100');
INSERT INTO `system_area2` VALUES ('1405', '0001001500010001', '历下区', '1404', '370102');
INSERT INTO `system_area2` VALUES ('1406', '0001001500010002', '市中区', '1405', '370103');
INSERT INTO `system_area2` VALUES ('1407', '0001001500010003', '槐荫区', '1406', '370104');
INSERT INTO `system_area2` VALUES ('1408', '0001001500010004', '天桥区', '1407', '370105');
INSERT INTO `system_area2` VALUES ('1409', '0001001500010005', '历城区', '1408', '370112');
INSERT INTO `system_area2` VALUES ('1410', '0001001500010006', '长清区', '1409', '370113');
INSERT INTO `system_area2` VALUES ('1411', '0001001500010007', '平阴县', '1410', '370124');
INSERT INTO `system_area2` VALUES ('1412', '0001001500010008', '济阳县', '1411', '370125');
INSERT INTO `system_area2` VALUES ('1413', '0001001500010009', '商河县', '1412', '370126');
INSERT INTO `system_area2` VALUES ('1414', '0001001500010010', '章丘市', '1413', '370181');
INSERT INTO `system_area2` VALUES ('1415', '000100150002', '青岛市', '1414', '370200');
INSERT INTO `system_area2` VALUES ('1416', '0001001500020001', '市南区', '1415', '370202');
INSERT INTO `system_area2` VALUES ('1417', '0001001500020002', '市北区', '1416', '370203');
INSERT INTO `system_area2` VALUES ('1418', '0001001500020003', '四方区', '1417', '370205');
INSERT INTO `system_area2` VALUES ('1419', '0001001500020004', '黄岛区', '1418', '370211');
INSERT INTO `system_area2` VALUES ('1420', '0001001500020005', '崂山区', '1419', '370212');
INSERT INTO `system_area2` VALUES ('1421', '0001001500020006', '李沧区', '1420', '370213');
INSERT INTO `system_area2` VALUES ('1422', '0001001500020007', '城阳区', '1421', '370214');
INSERT INTO `system_area2` VALUES ('1423', '0001001500020008', '开发区', '1422', '370251');
INSERT INTO `system_area2` VALUES ('1424', '0001001500020009', '胶州市', '1423', '370281');
INSERT INTO `system_area2` VALUES ('1425', '0001001500020010', '即墨市', '1424', '370282');
INSERT INTO `system_area2` VALUES ('1426', '0001001500020011', '平度市', '1425', '370283');
INSERT INTO `system_area2` VALUES ('1427', '0001001500020012', '胶南市', '1426', '370284');
INSERT INTO `system_area2` VALUES ('1428', '0001001500020013', '莱西市', '1427', '370285');
INSERT INTO `system_area2` VALUES ('1429', '000100150003', '淄博市', '1428', '370300');
INSERT INTO `system_area2` VALUES ('1430', '0001001500030001', '淄川区', '1429', '370302');
INSERT INTO `system_area2` VALUES ('1431', '0001001500030002', '张店区', '1430', '370303');
INSERT INTO `system_area2` VALUES ('1432', '0001001500030003', '博山区', '1431', '370304');
INSERT INTO `system_area2` VALUES ('1433', '0001001500030004', '临淄区', '1432', '370305');
INSERT INTO `system_area2` VALUES ('1434', '0001001500030005', '周村区', '1433', '370306');
INSERT INTO `system_area2` VALUES ('1435', '0001001500030006', '桓台县', '1434', '370321');
INSERT INTO `system_area2` VALUES ('1436', '0001001500030007', '高青县', '1435', '370322');
INSERT INTO `system_area2` VALUES ('1437', '0001001500030008', '沂源县', '1436', '370323');
INSERT INTO `system_area2` VALUES ('1438', '000100150004', '枣庄市', '1437', '370400');
INSERT INTO `system_area2` VALUES ('1439', '0001001500040001', '市中区', '1438', '370402');
INSERT INTO `system_area2` VALUES ('1440', '0001001500040002', '薛城区', '1439', '370403');
INSERT INTO `system_area2` VALUES ('1441', '0001001500040003', '峄城区', '1440', '370404');
INSERT INTO `system_area2` VALUES ('1442', '0001001500040004', '台儿庄区', '1441', '370405');
INSERT INTO `system_area2` VALUES ('1443', '0001001500040005', '山亭区', '1442', '370406');
INSERT INTO `system_area2` VALUES ('1444', '0001001500040006', '滕州市', '1443', '370481');
INSERT INTO `system_area2` VALUES ('1445', '000100150005', '东营市', '1444', '370500');
INSERT INTO `system_area2` VALUES ('1446', '0001001500050001', '东营区', '1445', '370502');
INSERT INTO `system_area2` VALUES ('1447', '0001001500050002', '河口区', '1446', '370503');
INSERT INTO `system_area2` VALUES ('1448', '0001001500050003', '垦利县', '1447', '370521');
INSERT INTO `system_area2` VALUES ('1449', '0001001500050004', '利津县', '1448', '370522');
INSERT INTO `system_area2` VALUES ('1450', '0001001500050005', '广饶县', '1449', '370523');
INSERT INTO `system_area2` VALUES ('1451', '0001001500050006', '西城区', '1450', '370589');
INSERT INTO `system_area2` VALUES ('1452', '0001001500050007', '东城区', '1451', '370590');
INSERT INTO `system_area2` VALUES ('1453', '000100150006', '烟台市', '1452', '370600');
INSERT INTO `system_area2` VALUES ('1454', '0001001500060001', '芝罘区', '1453', '370602');
INSERT INTO `system_area2` VALUES ('1455', '0001001500060002', '福山区', '1454', '370611');
INSERT INTO `system_area2` VALUES ('1456', '0001001500060003', '牟平区', '1455', '370612');
INSERT INTO `system_area2` VALUES ('1457', '0001001500060004', '莱山区', '1456', '370613');
INSERT INTO `system_area2` VALUES ('1458', '0001001500060005', '长岛县', '1457', '370634');
INSERT INTO `system_area2` VALUES ('1459', '0001001500060006', '龙口市', '1458', '370681');
INSERT INTO `system_area2` VALUES ('1460', '0001001500060007', '莱阳市', '1459', '370682');
INSERT INTO `system_area2` VALUES ('1461', '0001001500060008', '莱州市', '1460', '370683');
INSERT INTO `system_area2` VALUES ('1462', '0001001500060009', '蓬莱市', '1461', '370684');
INSERT INTO `system_area2` VALUES ('1463', '0001001500060010', '招远市', '1462', '370685');
INSERT INTO `system_area2` VALUES ('1464', '0001001500060011', '栖霞市', '1463', '370686');
INSERT INTO `system_area2` VALUES ('1465', '0001001500060012', '海阳市', '1464', '370687');
INSERT INTO `system_area2` VALUES ('1466', '000100150007', '潍坊市', '1465', '370700');
INSERT INTO `system_area2` VALUES ('1467', '0001001500070001', '潍城区', '1466', '370702');
INSERT INTO `system_area2` VALUES ('1468', '0001001500070002', '寒亭区', '1467', '370703');
INSERT INTO `system_area2` VALUES ('1469', '0001001500070003', '坊子区', '1468', '370704');
INSERT INTO `system_area2` VALUES ('1470', '0001001500070004', '奎文区', '1469', '370705');
INSERT INTO `system_area2` VALUES ('1471', '0001001500070005', '临朐县', '1470', '370724');
INSERT INTO `system_area2` VALUES ('1472', '0001001500070006', '昌乐县', '1471', '370725');
INSERT INTO `system_area2` VALUES ('1473', '0001001500070007', '开发区', '1472', '370751');
INSERT INTO `system_area2` VALUES ('1474', '0001001500070008', '青州市', '1473', '370781');
INSERT INTO `system_area2` VALUES ('1475', '0001001500070009', '诸城市', '1474', '370782');
INSERT INTO `system_area2` VALUES ('1476', '0001001500070010', '寿光市', '1475', '370783');
INSERT INTO `system_area2` VALUES ('1477', '0001001500070011', '安丘市', '1476', '370784');
INSERT INTO `system_area2` VALUES ('1478', '0001001500070012', '高密市', '1477', '370785');
INSERT INTO `system_area2` VALUES ('1479', '0001001500070013', '昌邑市', '1478', '370786');
INSERT INTO `system_area2` VALUES ('1480', '000100150008', '济宁市', '1479', '370800');
INSERT INTO `system_area2` VALUES ('1481', '0001001500080001', '市中区', '1480', '370802');
INSERT INTO `system_area2` VALUES ('1482', '0001001500080002', '任城区', '1481', '370811');
INSERT INTO `system_area2` VALUES ('1483', '0001001500080003', '微山县', '1482', '370826');
INSERT INTO `system_area2` VALUES ('1484', '0001001500080004', '鱼台县', '1483', '370827');
INSERT INTO `system_area2` VALUES ('1485', '0001001500080005', '金乡县', '1484', '370828');
INSERT INTO `system_area2` VALUES ('1486', '0001001500080006', '嘉祥县', '1485', '370829');
INSERT INTO `system_area2` VALUES ('1487', '0001001500080007', '汶上县', '1486', '370830');
INSERT INTO `system_area2` VALUES ('1488', '0001001500080008', '泗水县', '1487', '370831');
INSERT INTO `system_area2` VALUES ('1489', '0001001500080009', '梁山县', '1488', '370832');
INSERT INTO `system_area2` VALUES ('1490', '0001001500080010', '曲阜市', '1489', '370881');
INSERT INTO `system_area2` VALUES ('1491', '0001001500080011', '兖州市', '1490', '370882');
INSERT INTO `system_area2` VALUES ('1492', '0001001500080012', '邹城市', '1491', '370883');
INSERT INTO `system_area2` VALUES ('1493', '000100150009', '泰安市', '1492', '370900');
INSERT INTO `system_area2` VALUES ('1494', '0001001500090001', '泰山区', '1493', '370902');
INSERT INTO `system_area2` VALUES ('1495', '0001001500090002', '岱岳区', '1494', '370903');
INSERT INTO `system_area2` VALUES ('1496', '0001001500090003', '宁阳县', '1495', '370921');
INSERT INTO `system_area2` VALUES ('1497', '0001001500090004', '东平县', '1496', '370923');
INSERT INTO `system_area2` VALUES ('1498', '0001001500090005', '新泰市', '1497', '370982');
INSERT INTO `system_area2` VALUES ('1499', '0001001500090006', '肥城市', '1498', '370983');
INSERT INTO `system_area2` VALUES ('1500', '000100150010', '威海市', '1499', '371000');
INSERT INTO `system_area2` VALUES ('1501', '0001001500100001', '环翠区', '1500', '371002');
INSERT INTO `system_area2` VALUES ('1502', '0001001500100002', '文登市', '1501', '371081');
INSERT INTO `system_area2` VALUES ('1503', '0001001500100003', '荣成市', '1502', '371082');
INSERT INTO `system_area2` VALUES ('1504', '0001001500100004', '乳山市', '1503', '371083');
INSERT INTO `system_area2` VALUES ('1505', '000100150011', '日照市', '1504', '371100');
INSERT INTO `system_area2` VALUES ('1506', '0001001500110001', '东港区', '1505', '371102');
INSERT INTO `system_area2` VALUES ('1507', '0001001500110002', '岚山区', '1506', '371103');
INSERT INTO `system_area2` VALUES ('1508', '0001001500110003', '五莲县', '1507', '371121');
INSERT INTO `system_area2` VALUES ('1509', '0001001500110004', '莒县', '1508', '371122');
INSERT INTO `system_area2` VALUES ('1510', '000100150012', '莱芜市', '1509', '371200');
INSERT INTO `system_area2` VALUES ('1511', '0001001500120001', '莱城区', '1510', '371202');
INSERT INTO `system_area2` VALUES ('1512', '0001001500120002', '钢城区', '1511', '371203');
INSERT INTO `system_area2` VALUES ('1513', '000100150013', '临沂市', '1512', '371300');
INSERT INTO `system_area2` VALUES ('1514', '0001001500130001', '兰山区', '1513', '371302');
INSERT INTO `system_area2` VALUES ('1515', '0001001500130002', '罗庄区', '1514', '371311');
INSERT INTO `system_area2` VALUES ('1516', '0001001500130003', '河东区', '1515', '371312');
INSERT INTO `system_area2` VALUES ('1517', '0001001500130004', '沂南县', '1516', '371321');
INSERT INTO `system_area2` VALUES ('1518', '0001001500130005', '郯城县', '1517', '371322');
INSERT INTO `system_area2` VALUES ('1519', '0001001500130006', '沂水县', '1518', '371323');
INSERT INTO `system_area2` VALUES ('1520', '0001001500130007', '苍山县', '1519', '371324');
INSERT INTO `system_area2` VALUES ('1521', '0001001500130008', '费县', '1520', '371325');
INSERT INTO `system_area2` VALUES ('1522', '0001001500130009', '平邑县', '1521', '371326');
INSERT INTO `system_area2` VALUES ('1523', '0001001500130010', '莒南县', '1522', '371327');
INSERT INTO `system_area2` VALUES ('1524', '0001001500130011', '蒙阴县', '1523', '371328');
INSERT INTO `system_area2` VALUES ('1525', '0001001500130012', '临沭县', '1524', '371329');
INSERT INTO `system_area2` VALUES ('1526', '000100150014', '德州市', '1525', '371400');
INSERT INTO `system_area2` VALUES ('1527', '0001001500140001', '德城区', '1526', '371402');
INSERT INTO `system_area2` VALUES ('1528', '0001001500140002', '陵县', '1527', '371421');
INSERT INTO `system_area2` VALUES ('1529', '0001001500140003', '宁津县', '1528', '371422');
INSERT INTO `system_area2` VALUES ('1530', '0001001500140004', '庆云县', '1529', '371423');
INSERT INTO `system_area2` VALUES ('1531', '0001001500140005', '临邑县', '1530', '371424');
INSERT INTO `system_area2` VALUES ('1532', '0001001500140006', '齐河县', '1531', '371425');
INSERT INTO `system_area2` VALUES ('1533', '0001001500140007', '平原县', '1532', '371426');
INSERT INTO `system_area2` VALUES ('1534', '0001001500140008', '夏津县', '1533', '371427');
INSERT INTO `system_area2` VALUES ('1535', '0001001500140009', '武城县', '1534', '371428');
INSERT INTO `system_area2` VALUES ('1536', '0001001500140010', '开发区', '1535', '371451');
INSERT INTO `system_area2` VALUES ('1537', '0001001500140011', '乐陵市', '1536', '371481');
INSERT INTO `system_area2` VALUES ('1538', '0001001500140012', '禹城市', '1537', '371482');
INSERT INTO `system_area2` VALUES ('1539', '000100150015', '聊城市', '1538', '371500');
INSERT INTO `system_area2` VALUES ('1540', '0001001500150001', '东昌府区', '1539', '371502');
INSERT INTO `system_area2` VALUES ('1541', '0001001500150002', '阳谷县', '1540', '371521');
INSERT INTO `system_area2` VALUES ('1542', '0001001500150003', '莘县', '1541', '371522');
INSERT INTO `system_area2` VALUES ('1543', '0001001500150004', '茌平县', '1542', '371523');
INSERT INTO `system_area2` VALUES ('1544', '0001001500150005', '东阿县', '1543', '371524');
INSERT INTO `system_area2` VALUES ('1545', '0001001500150006', '冠县', '1544', '371525');
INSERT INTO `system_area2` VALUES ('1546', '0001001500150007', '高唐县', '1545', '371526');
INSERT INTO `system_area2` VALUES ('1547', '0001001500150008', '临清市', '1546', '371581');
INSERT INTO `system_area2` VALUES ('1548', '000100150016', '滨州市', '1547', '371600');
INSERT INTO `system_area2` VALUES ('1549', '0001001500160001', '滨城区', '1548', '371602');
INSERT INTO `system_area2` VALUES ('1550', '0001001500160002', '惠民县', '1549', '371621');
INSERT INTO `system_area2` VALUES ('1551', '0001001500160003', '阳信县', '1550', '371622');
INSERT INTO `system_area2` VALUES ('1552', '0001001500160004', '无棣县', '1551', '371623');
INSERT INTO `system_area2` VALUES ('1553', '0001001500160005', '沾化县', '1552', '371624');
INSERT INTO `system_area2` VALUES ('1554', '0001001500160006', '博兴县', '1553', '371625');
INSERT INTO `system_area2` VALUES ('1555', '0001001500160007', '邹平县', '1554', '371626');
INSERT INTO `system_area2` VALUES ('1556', '000100150017', '菏泽市', '1555', '371700');
INSERT INTO `system_area2` VALUES ('1557', '0001001500170001', '牡丹区', '1556', '371702');
INSERT INTO `system_area2` VALUES ('1558', '0001001500170002', '曹县', '1557', '371721');
INSERT INTO `system_area2` VALUES ('1559', '0001001500170003', '单县', '1558', '371722');
INSERT INTO `system_area2` VALUES ('1560', '0001001500170004', '成武县', '1559', '371723');
INSERT INTO `system_area2` VALUES ('1561', '0001001500170005', '巨野县', '1560', '371724');
INSERT INTO `system_area2` VALUES ('1562', '0001001500170006', '郓城县', '1561', '371725');
INSERT INTO `system_area2` VALUES ('1563', '0001001500170007', '鄄城县', '1562', '371726');
INSERT INTO `system_area2` VALUES ('1564', '0001001500170008', '定陶县', '1563', '371727');
INSERT INTO `system_area2` VALUES ('1565', '0001001500170009', '东明县', '1564', '371728');
INSERT INTO `system_area2` VALUES ('1566', '00010016', '河南省', '1565', '410000');
INSERT INTO `system_area2` VALUES ('1567', '000100160001', '郑州市', '1566', '410100');
INSERT INTO `system_area2` VALUES ('1568', '0001001600010001', '中原区', '1567', '410102');
INSERT INTO `system_area2` VALUES ('1569', '0001001600010002', '二七区', '1568', '410103');
INSERT INTO `system_area2` VALUES ('1570', '0001001600010003', '管城回族区', '1569', '410104');
INSERT INTO `system_area2` VALUES ('1571', '0001001600010004', '金水区', '1570', '410105');
INSERT INTO `system_area2` VALUES ('1572', '0001001600010005', '上街区', '1571', '410106');
INSERT INTO `system_area2` VALUES ('1573', '0001001600010006', '惠济区', '1572', '410108');
INSERT INTO `system_area2` VALUES ('1574', '0001001600010007', '中牟县', '1573', '410122');
INSERT INTO `system_area2` VALUES ('1575', '0001001600010008', '巩义市', '1574', '410181');
INSERT INTO `system_area2` VALUES ('1576', '0001001600010009', '荥阳市', '1575', '410182');
INSERT INTO `system_area2` VALUES ('1577', '0001001600010010', '新密市', '1576', '410183');
INSERT INTO `system_area2` VALUES ('1578', '0001001600010011', '新郑市', '1577', '410184');
INSERT INTO `system_area2` VALUES ('1579', '0001001600010012', '登封市', '1578', '410185');
INSERT INTO `system_area2` VALUES ('1580', '0001001600010013', '郑东新区', '1579', '410186');
INSERT INTO `system_area2` VALUES ('1581', '0001001600010014', '高新区', '1580', '410187');
INSERT INTO `system_area2` VALUES ('1582', '000100160002', '开封市', '1581', '410200');
INSERT INTO `system_area2` VALUES ('1583', '0001001600020001', '龙亭区', '1582', '410202');
INSERT INTO `system_area2` VALUES ('1584', '0001001600020002', '顺河回族区', '1583', '410203');
INSERT INTO `system_area2` VALUES ('1585', '0001001600020003', '鼓楼区', '1584', '410204');
INSERT INTO `system_area2` VALUES ('1586', '0001001600020004', '禹王台区', '1585', '410205');
INSERT INTO `system_area2` VALUES ('1587', '0001001600020005', '金明区', '1586', '410211');
INSERT INTO `system_area2` VALUES ('1588', '0001001600020006', '杞县', '1587', '410221');
INSERT INTO `system_area2` VALUES ('1589', '0001001600020007', '通许县', '1588', '410222');
INSERT INTO `system_area2` VALUES ('1590', '0001001600020008', '尉氏县', '1589', '410223');
INSERT INTO `system_area2` VALUES ('1591', '0001001600020009', '开封县', '1590', '410224');
INSERT INTO `system_area2` VALUES ('1592', '0001001600020010', '兰考县', '1591', '410225');
INSERT INTO `system_area2` VALUES ('1593', '000100160003', '洛阳市', '1592', '410300');
INSERT INTO `system_area2` VALUES ('1594', '0001001600030001', '老城区', '1593', '410302');
INSERT INTO `system_area2` VALUES ('1595', '0001001600030002', '西工区', '1594', '410303');
INSERT INTO `system_area2` VALUES ('1596', '0001001600030003', '廛河回族区', '1595', '410304');
INSERT INTO `system_area2` VALUES ('1597', '0001001600030004', '涧西区', '1596', '410305');
INSERT INTO `system_area2` VALUES ('1598', '0001001600030005', '吉利区', '1597', '410306');
INSERT INTO `system_area2` VALUES ('1599', '0001001600030006', '洛龙区', '1598', '410307');
INSERT INTO `system_area2` VALUES ('1600', '0001001600030007', '孟津县', '1599', '410322');
INSERT INTO `system_area2` VALUES ('1601', '0001001600030008', '新安县', '1600', '410323');
INSERT INTO `system_area2` VALUES ('1602', '0001001600030009', '栾川县', '1601', '410324');
INSERT INTO `system_area2` VALUES ('1603', '0001001600030010', '嵩县', '1602', '410325');
INSERT INTO `system_area2` VALUES ('1604', '0001001600030011', '汝阳县', '1603', '410326');
INSERT INTO `system_area2` VALUES ('1605', '0001001600030012', '宜阳县', '1604', '410327');
INSERT INTO `system_area2` VALUES ('1606', '0001001600030013', '洛宁县', '1605', '410328');
INSERT INTO `system_area2` VALUES ('1607', '0001001600030014', '伊川县', '1606', '410329');
INSERT INTO `system_area2` VALUES ('1608', '0001001600030015', '偃师市', '1607', '410381');
INSERT INTO `system_area2` VALUES ('1609', '0001001600030016', '高新区', '1608', '471004');
INSERT INTO `system_area2` VALUES ('1610', '000100160004', '平顶山市', '1609', '410400');
INSERT INTO `system_area2` VALUES ('1611', '0001001600040001', '新华区', '1610', '410402');
INSERT INTO `system_area2` VALUES ('1612', '0001001600040002', '卫东区', '1611', '410403');
INSERT INTO `system_area2` VALUES ('1613', '0001001600040003', '石龙区', '1612', '410404');
INSERT INTO `system_area2` VALUES ('1614', '0001001600040004', '湛河区', '1613', '410411');
INSERT INTO `system_area2` VALUES ('1615', '0001001600040005', '宝丰县', '1614', '410421');
INSERT INTO `system_area2` VALUES ('1616', '0001001600040006', '叶县', '1615', '410422');
INSERT INTO `system_area2` VALUES ('1617', '0001001600040007', '鲁山县', '1616', '410423');
INSERT INTO `system_area2` VALUES ('1618', '0001001600040008', '郏县', '1617', '410425');
INSERT INTO `system_area2` VALUES ('1619', '0001001600040009', '舞钢市', '1618', '410481');
INSERT INTO `system_area2` VALUES ('1620', '0001001600040010', '汝州市', '1619', '410482');
INSERT INTO `system_area2` VALUES ('1621', '000100160005', '安阳市', '1620', '410500');
INSERT INTO `system_area2` VALUES ('1622', '0001001600050001', '文峰区', '1621', '410502');
INSERT INTO `system_area2` VALUES ('1623', '0001001600050002', '北关区', '1622', '410503');
INSERT INTO `system_area2` VALUES ('1624', '0001001600050003', '殷都区', '1623', '410505');
INSERT INTO `system_area2` VALUES ('1625', '0001001600050004', '龙安区', '1624', '410506');
INSERT INTO `system_area2` VALUES ('1626', '0001001600050005', '安阳县', '1625', '410522');
INSERT INTO `system_area2` VALUES ('1627', '0001001600050006', '汤阴县', '1626', '410523');
INSERT INTO `system_area2` VALUES ('1628', '0001001600050007', '滑县', '1627', '410526');
INSERT INTO `system_area2` VALUES ('1629', '0001001600050008', '内黄县', '1628', '410527');
INSERT INTO `system_area2` VALUES ('1630', '0001001600050009', '林州市', '1629', '410581');
INSERT INTO `system_area2` VALUES ('1631', '000100160006', '鹤壁市', '1630', '410600');
INSERT INTO `system_area2` VALUES ('1632', '0001001600060001', '鹤山区', '1631', '410602');
INSERT INTO `system_area2` VALUES ('1633', '0001001600060002', '山城区', '1632', '410603');
INSERT INTO `system_area2` VALUES ('1634', '0001001600060003', '淇滨区', '1633', '410611');
INSERT INTO `system_area2` VALUES ('1635', '0001001600060004', '浚县', '1634', '410621');
INSERT INTO `system_area2` VALUES ('1636', '0001001600060005', '淇县', '1635', '410622');
INSERT INTO `system_area2` VALUES ('1637', '000100160007', '新乡市', '1636', '410700');
INSERT INTO `system_area2` VALUES ('1638', '0001001600070001', '红旗区', '1637', '410702');
INSERT INTO `system_area2` VALUES ('1639', '0001001600070002', '卫滨区', '1638', '410703');
INSERT INTO `system_area2` VALUES ('1640', '0001001600070003', '凤泉区', '1639', '410704');
INSERT INTO `system_area2` VALUES ('1641', '0001001600070004', '牧野区', '1640', '410711');
INSERT INTO `system_area2` VALUES ('1642', '0001001600070005', '新乡县', '1641', '410721');
INSERT INTO `system_area2` VALUES ('1643', '0001001600070006', '获嘉县', '1642', '410724');
INSERT INTO `system_area2` VALUES ('1644', '0001001600070007', '原阳县', '1643', '410725');
INSERT INTO `system_area2` VALUES ('1645', '0001001600070008', '延津县', '1644', '410726');
INSERT INTO `system_area2` VALUES ('1646', '0001001600070009', '封丘县', '1645', '410727');
INSERT INTO `system_area2` VALUES ('1647', '0001001600070010', '长垣县', '1646', '410728');
INSERT INTO `system_area2` VALUES ('1648', '0001001600070011', '卫辉市', '1647', '410781');
INSERT INTO `system_area2` VALUES ('1649', '0001001600070012', '辉县市', '1648', '410782');
INSERT INTO `system_area2` VALUES ('1650', '000100160008', '焦作市', '1649', '410800');
INSERT INTO `system_area2` VALUES ('1651', '0001001600080001', '解放区', '1650', '410802');
INSERT INTO `system_area2` VALUES ('1652', '0001001600080002', '中站区', '1651', '410803');
INSERT INTO `system_area2` VALUES ('1653', '0001001600080003', '马村区', '1652', '410804');
INSERT INTO `system_area2` VALUES ('1654', '0001001600080004', '山阳区', '1653', '410811');
INSERT INTO `system_area2` VALUES ('1655', '0001001600080005', '修武县', '1654', '410821');
INSERT INTO `system_area2` VALUES ('1656', '0001001600080006', '博爱县', '1655', '410822');
INSERT INTO `system_area2` VALUES ('1657', '0001001600080007', '武陟县', '1656', '410823');
INSERT INTO `system_area2` VALUES ('1658', '0001001600080008', '温县', '1657', '410825');
INSERT INTO `system_area2` VALUES ('1659', '0001001600080009', '沁阳市', '1658', '410882');
INSERT INTO `system_area2` VALUES ('1660', '0001001600080010', '孟州市', '1659', '410883');
INSERT INTO `system_area2` VALUES ('1661', '000100160009', '济源市', '1660', '410881');
INSERT INTO `system_area2` VALUES ('1662', '000100160010', '濮阳市', '1661', '410900');
INSERT INTO `system_area2` VALUES ('1663', '0001001600100001', '华龙区', '1662', '410902');
INSERT INTO `system_area2` VALUES ('1664', '0001001600100002', '清丰县', '1663', '410922');
INSERT INTO `system_area2` VALUES ('1665', '0001001600100003', '南乐县', '1664', '410923');
INSERT INTO `system_area2` VALUES ('1666', '0001001600100004', '范县', '1665', '410926');
INSERT INTO `system_area2` VALUES ('1667', '0001001600100005', '台前县', '1666', '410927');
INSERT INTO `system_area2` VALUES ('1668', '0001001600100006', '濮阳县', '1667', '410928');
INSERT INTO `system_area2` VALUES ('1669', '000100160011', '许昌市', '1668', '411000');
INSERT INTO `system_area2` VALUES ('1670', '0001001600110001', '魏都区', '1669', '411002');
INSERT INTO `system_area2` VALUES ('1671', '0001001600110002', '许昌县', '1670', '411023');
INSERT INTO `system_area2` VALUES ('1672', '0001001600110003', '鄢陵县', '1671', '411024');
INSERT INTO `system_area2` VALUES ('1673', '0001001600110004', '襄城县', '1672', '411025');
INSERT INTO `system_area2` VALUES ('1674', '0001001600110005', '禹州市', '1673', '411081');
INSERT INTO `system_area2` VALUES ('1675', '0001001600110006', '长葛市', '1674', '411082');
INSERT INTO `system_area2` VALUES ('1676', '000100160012', '漯河市', '1675', '411100');
INSERT INTO `system_area2` VALUES ('1677', '0001001600120001', '源汇区', '1676', '411102');
INSERT INTO `system_area2` VALUES ('1678', '0001001600120002', '郾城区', '1677', '411103');
INSERT INTO `system_area2` VALUES ('1679', '0001001600120003', '召陵区', '1678', '411104');
INSERT INTO `system_area2` VALUES ('1680', '0001001600120004', '舞阳县', '1679', '411121');
INSERT INTO `system_area2` VALUES ('1681', '0001001600120005', '临颍县', '1680', '411122');
INSERT INTO `system_area2` VALUES ('1682', '000100160013', '三门峡市', '1681', '411200');
INSERT INTO `system_area2` VALUES ('1683', '0001001600130001', '湖滨区', '1682', '411202');
INSERT INTO `system_area2` VALUES ('1684', '0001001600130002', '渑池县', '1683', '411221');
INSERT INTO `system_area2` VALUES ('1685', '0001001600130003', '陕县', '1684', '411222');
INSERT INTO `system_area2` VALUES ('1686', '0001001600130004', '卢氏县', '1685', '411224');
INSERT INTO `system_area2` VALUES ('1687', '0001001600130005', '义马市', '1686', '411281');
INSERT INTO `system_area2` VALUES ('1688', '0001001600130006', '灵宝市', '1687', '411282');
INSERT INTO `system_area2` VALUES ('1689', '000100160014', '南阳市', '1688', '411300');
INSERT INTO `system_area2` VALUES ('1690', '0001001600140001', '宛城区', '1689', '411302');
INSERT INTO `system_area2` VALUES ('1691', '0001001600140002', '卧龙区', '1690', '411303');
INSERT INTO `system_area2` VALUES ('1692', '0001001600140003', '南召县', '1691', '411321');
INSERT INTO `system_area2` VALUES ('1693', '0001001600140004', '方城县', '1692', '411322');
INSERT INTO `system_area2` VALUES ('1694', '0001001600140005', '西峡县', '1693', '411323');
INSERT INTO `system_area2` VALUES ('1695', '0001001600140006', '镇平县', '1694', '411324');
INSERT INTO `system_area2` VALUES ('1696', '0001001600140007', '内乡县', '1695', '411325');
INSERT INTO `system_area2` VALUES ('1697', '0001001600140008', '淅川县', '1696', '411326');
INSERT INTO `system_area2` VALUES ('1698', '0001001600140009', '社旗县', '1697', '411327');
INSERT INTO `system_area2` VALUES ('1699', '0001001600140010', '唐河县', '1698', '411328');
INSERT INTO `system_area2` VALUES ('1700', '0001001600140011', '新野县', '1699', '411329');
INSERT INTO `system_area2` VALUES ('1701', '0001001600140012', '桐柏县', '1700', '411330');
INSERT INTO `system_area2` VALUES ('1702', '0001001600140013', '邓州市', '1701', '411381');
INSERT INTO `system_area2` VALUES ('1703', '000100160015', '商丘市', '1702', '411400');
INSERT INTO `system_area2` VALUES ('1704', '0001001600150001', '梁园区', '1703', '411402');
INSERT INTO `system_area2` VALUES ('1705', '0001001600150002', '睢阳区', '1704', '411403');
INSERT INTO `system_area2` VALUES ('1706', '0001001600150003', '民权县', '1705', '411421');
INSERT INTO `system_area2` VALUES ('1707', '0001001600150004', '睢县', '1706', '411422');
INSERT INTO `system_area2` VALUES ('1708', '0001001600150005', '宁陵县', '1707', '411423');
INSERT INTO `system_area2` VALUES ('1709', '0001001600150006', '柘城县', '1708', '411424');
INSERT INTO `system_area2` VALUES ('1710', '0001001600150007', '虞城县', '1709', '411425');
INSERT INTO `system_area2` VALUES ('1711', '0001001600150008', '夏邑县', '1710', '411426');
INSERT INTO `system_area2` VALUES ('1712', '0001001600150009', '永城市', '1711', '411481');
INSERT INTO `system_area2` VALUES ('1713', '000100160016', '信阳市', '1712', '411500');
INSERT INTO `system_area2` VALUES ('1714', '0001001600160001', '浉河区', '1713', '411502');
INSERT INTO `system_area2` VALUES ('1715', '0001001600160002', '平桥区', '1714', '411503');
INSERT INTO `system_area2` VALUES ('1716', '0001001600160003', '罗山县', '1715', '411521');
INSERT INTO `system_area2` VALUES ('1717', '0001001600160004', '光山县', '1716', '411522');
INSERT INTO `system_area2` VALUES ('1718', '0001001600160005', '新县', '1717', '411523');
INSERT INTO `system_area2` VALUES ('1719', '0001001600160006', '商城县', '1718', '411524');
INSERT INTO `system_area2` VALUES ('1720', '0001001600160007', '固始县', '1719', '411525');
INSERT INTO `system_area2` VALUES ('1721', '0001001600160008', '潢川县', '1720', '411526');
INSERT INTO `system_area2` VALUES ('1722', '0001001600160009', '淮滨县', '1721', '411527');
INSERT INTO `system_area2` VALUES ('1723', '0001001600160010', '息县', '1722', '411528');
INSERT INTO `system_area2` VALUES ('1724', '000100160017', '周口市', '1723', '411600');
INSERT INTO `system_area2` VALUES ('1725', '0001001600170001', '川汇区', '1724', '411602');
INSERT INTO `system_area2` VALUES ('1726', '0001001600170002', '扶沟县', '1725', '411621');
INSERT INTO `system_area2` VALUES ('1727', '0001001600170003', '西华县', '1726', '411622');
INSERT INTO `system_area2` VALUES ('1728', '0001001600170004', '商水县', '1727', '411623');
INSERT INTO `system_area2` VALUES ('1729', '0001001600170005', '沈丘县', '1728', '411624');
INSERT INTO `system_area2` VALUES ('1730', '0001001600170006', '郸城县', '1729', '411625');
INSERT INTO `system_area2` VALUES ('1731', '0001001600170007', '淮阳县', '1730', '411626');
INSERT INTO `system_area2` VALUES ('1732', '0001001600170008', '太康县', '1731', '411627');
INSERT INTO `system_area2` VALUES ('1733', '0001001600170009', '鹿邑县', '1732', '411628');
INSERT INTO `system_area2` VALUES ('1734', '0001001600170010', '项城市', '1733', '411681');
INSERT INTO `system_area2` VALUES ('1735', '000100160018', '驻马店市', '1734', '411700');
INSERT INTO `system_area2` VALUES ('1736', '0001001600180001', '驿城区', '1735', '411702');
INSERT INTO `system_area2` VALUES ('1737', '0001001600180002', '西平县', '1736', '411721');
INSERT INTO `system_area2` VALUES ('1738', '0001001600180003', '上蔡县', '1737', '411722');
INSERT INTO `system_area2` VALUES ('1739', '0001001600180004', '平舆县', '1738', '411723');
INSERT INTO `system_area2` VALUES ('1740', '0001001600180005', '正阳县', '1739', '411724');
INSERT INTO `system_area2` VALUES ('1741', '0001001600180006', '确山县', '1740', '411725');
INSERT INTO `system_area2` VALUES ('1742', '0001001600180007', '泌阳县', '1741', '411726');
INSERT INTO `system_area2` VALUES ('1743', '0001001600180008', '汝南县', '1742', '411727');
INSERT INTO `system_area2` VALUES ('1744', '0001001600180009', '遂平县', '1743', '411728');
INSERT INTO `system_area2` VALUES ('1745', '0001001600180010', '新蔡县', '1744', '411729');
INSERT INTO `system_area2` VALUES ('1746', '00010017', '湖北省', '1745', '420000');
INSERT INTO `system_area2` VALUES ('1747', '000100170001', '武汉市', '1746', '420100');
INSERT INTO `system_area2` VALUES ('1748', '0001001700010001', '江岸区', '1747', '420102');
INSERT INTO `system_area2` VALUES ('1749', '0001001700010002', '江汉区', '1748', '420103');
INSERT INTO `system_area2` VALUES ('1750', '0001001700010003', '硚口区', '1749', '420104');
INSERT INTO `system_area2` VALUES ('1751', '0001001700010004', '汉阳区', '1750', '420105');
INSERT INTO `system_area2` VALUES ('1752', '0001001700010005', '武昌区', '1751', '420106');
INSERT INTO `system_area2` VALUES ('1753', '0001001700010006', '青山区', '1752', '420107');
INSERT INTO `system_area2` VALUES ('1754', '0001001700010007', '洪山区', '1753', '420111');
INSERT INTO `system_area2` VALUES ('1755', '0001001700010008', '东西湖区', '1754', '420112');
INSERT INTO `system_area2` VALUES ('1756', '0001001700010009', '汉南区', '1755', '420113');
INSERT INTO `system_area2` VALUES ('1757', '0001001700010010', '蔡甸区', '1756', '420114');
INSERT INTO `system_area2` VALUES ('1758', '0001001700010011', '江夏区', '1757', '420115');
INSERT INTO `system_area2` VALUES ('1759', '0001001700010012', '黄陂区', '1758', '420116');
INSERT INTO `system_area2` VALUES ('1760', '0001001700010013', '新洲区', '1759', '420117');
INSERT INTO `system_area2` VALUES ('1761', '000100170002', '黄石市', '1760', '420200');
INSERT INTO `system_area2` VALUES ('1762', '0001001700020001', '黄石港区', '1761', '420202');
INSERT INTO `system_area2` VALUES ('1763', '0001001700020002', '西塞山区', '1762', '420203');
INSERT INTO `system_area2` VALUES ('1764', '0001001700020003', '下陆区', '1763', '420204');
INSERT INTO `system_area2` VALUES ('1765', '0001001700020004', '铁山区', '1764', '420205');
INSERT INTO `system_area2` VALUES ('1766', '0001001700020005', '阳新县', '1765', '420222');
INSERT INTO `system_area2` VALUES ('1767', '0001001700020006', '大冶市', '1766', '420281');
INSERT INTO `system_area2` VALUES ('1768', '000100170003', '十堰市', '1767', '420300');
INSERT INTO `system_area2` VALUES ('1769', '0001001700030001', '茅箭区', '1768', '420302');
INSERT INTO `system_area2` VALUES ('1770', '0001001700030002', '张湾区', '1769', '420303');
INSERT INTO `system_area2` VALUES ('1771', '0001001700030003', '郧县', '1770', '420321');
INSERT INTO `system_area2` VALUES ('1772', '0001001700030004', '郧西县', '1771', '420322');
INSERT INTO `system_area2` VALUES ('1773', '0001001700030005', '竹山县', '1772', '420323');
INSERT INTO `system_area2` VALUES ('1774', '0001001700030006', '竹溪县', '1773', '420324');
INSERT INTO `system_area2` VALUES ('1775', '0001001700030007', '房县', '1774', '420325');
INSERT INTO `system_area2` VALUES ('1776', '0001001700030008', '丹江口市', '1775', '420381');
INSERT INTO `system_area2` VALUES ('1777', '0001001700030009', '城区', '1776', '420382');
INSERT INTO `system_area2` VALUES ('1778', '000100170004', '宜昌市', '1777', '420500');
INSERT INTO `system_area2` VALUES ('1779', '0001001700040001', '西陵区', '1778', '420502');
INSERT INTO `system_area2` VALUES ('1780', '0001001700040002', '伍家岗区', '1779', '420503');
INSERT INTO `system_area2` VALUES ('1781', '0001001700040003', '点军区', '1780', '420504');
INSERT INTO `system_area2` VALUES ('1782', '0001001700040004', '猇亭区', '1781', '420505');
INSERT INTO `system_area2` VALUES ('1783', '0001001700040005', '夷陵区', '1782', '420506');
INSERT INTO `system_area2` VALUES ('1784', '0001001700040006', '远安县', '1783', '420525');
INSERT INTO `system_area2` VALUES ('1785', '0001001700040007', '兴山县', '1784', '420526');
INSERT INTO `system_area2` VALUES ('1786', '0001001700040008', '秭归县', '1785', '420527');
INSERT INTO `system_area2` VALUES ('1787', '0001001700040009', '长阳土家族自治县', '1786', '420528');
INSERT INTO `system_area2` VALUES ('1788', '0001001700040010', '五峰土家族自治县', '1787', '420529');
INSERT INTO `system_area2` VALUES ('1789', '0001001700040011', '葛洲坝区', '1788', '420551');
INSERT INTO `system_area2` VALUES ('1790', '0001001700040012', '开发区', '1789', '420552');
INSERT INTO `system_area2` VALUES ('1791', '0001001700040013', '宜都市', '1790', '420581');
INSERT INTO `system_area2` VALUES ('1792', '0001001700040014', '当阳市', '1791', '420582');
INSERT INTO `system_area2` VALUES ('1793', '0001001700040015', '枝江市', '1792', '420583');
INSERT INTO `system_area2` VALUES ('1794', '000100170005', '襄阳市', '1793', '420600');
INSERT INTO `system_area2` VALUES ('1795', '0001001700050001', '襄城区', '1794', '420602');
INSERT INTO `system_area2` VALUES ('1796', '0001001700050002', '樊城区', '1795', '420606');
INSERT INTO `system_area2` VALUES ('1797', '0001001700050003', '襄州区', '1796', '420607');
INSERT INTO `system_area2` VALUES ('1798', '0001001700050004', '南漳县', '1797', '420624');
INSERT INTO `system_area2` VALUES ('1799', '0001001700050005', '谷城县', '1798', '420625');
INSERT INTO `system_area2` VALUES ('1800', '0001001700050006', '保康县', '1799', '420626');
INSERT INTO `system_area2` VALUES ('1801', '0001001700050007', '老河口市', '1800', '420682');
INSERT INTO `system_area2` VALUES ('1802', '0001001700050008', '枣阳市', '1801', '420683');
INSERT INTO `system_area2` VALUES ('1803', '0001001700050009', '宜城市', '1802', '420684');
INSERT INTO `system_area2` VALUES ('1804', '000100170006', '鄂州市', '1803', '420700');
INSERT INTO `system_area2` VALUES ('1805', '0001001700060001', '梁子湖区', '1804', '420702');
INSERT INTO `system_area2` VALUES ('1806', '0001001700060002', '华容区', '1805', '420703');
INSERT INTO `system_area2` VALUES ('1807', '0001001700060003', '鄂城区', '1806', '420704');
INSERT INTO `system_area2` VALUES ('1808', '000100170007', '荆门市', '1807', '420800');
INSERT INTO `system_area2` VALUES ('1809', '0001001700070001', '东宝区', '1808', '420802');
INSERT INTO `system_area2` VALUES ('1810', '0001001700070002', '掇刀区', '1809', '420804');
INSERT INTO `system_area2` VALUES ('1811', '0001001700070003', '京山县', '1810', '420821');
INSERT INTO `system_area2` VALUES ('1812', '0001001700070004', '沙洋县', '1811', '420822');
INSERT INTO `system_area2` VALUES ('1813', '0001001700070005', '钟祥市', '1812', '420881');
INSERT INTO `system_area2` VALUES ('1814', '000100170008', '孝感市', '1813', '420900');
INSERT INTO `system_area2` VALUES ('1815', '0001001700080001', '孝南区', '1814', '420902');
INSERT INTO `system_area2` VALUES ('1816', '0001001700080002', '孝昌县', '1815', '420921');
INSERT INTO `system_area2` VALUES ('1817', '0001001700080003', '大悟县', '1816', '420922');
INSERT INTO `system_area2` VALUES ('1818', '0001001700080004', '云梦县', '1817', '420923');
INSERT INTO `system_area2` VALUES ('1819', '0001001700080005', '应城市', '1818', '420981');
INSERT INTO `system_area2` VALUES ('1820', '0001001700080006', '安陆市', '1819', '420982');
INSERT INTO `system_area2` VALUES ('1821', '0001001700080007', '汉川市', '1820', '420984');
INSERT INTO `system_area2` VALUES ('1822', '000100170009', '荆州市', '1821', '421000');
INSERT INTO `system_area2` VALUES ('1823', '0001001700090001', '沙市区', '1822', '421002');
INSERT INTO `system_area2` VALUES ('1824', '0001001700090002', '荆州区', '1823', '421003');
INSERT INTO `system_area2` VALUES ('1825', '0001001700090003', '公安县', '1824', '421022');
INSERT INTO `system_area2` VALUES ('1826', '0001001700090004', '监利县', '1825', '421023');
INSERT INTO `system_area2` VALUES ('1827', '0001001700090005', '江陵县', '1826', '421024');
INSERT INTO `system_area2` VALUES ('1828', '0001001700090006', '石首市', '1827', '421081');
INSERT INTO `system_area2` VALUES ('1829', '0001001700090007', '洪湖市', '1828', '421083');
INSERT INTO `system_area2` VALUES ('1830', '0001001700090008', '松滋市', '1829', '421087');
INSERT INTO `system_area2` VALUES ('1831', '000100170010', '黄冈市', '1830', '421100');
INSERT INTO `system_area2` VALUES ('1832', '0001001700100001', '黄州区', '1831', '421102');
INSERT INTO `system_area2` VALUES ('1833', '0001001700100002', '团风县', '1832', '421121');
INSERT INTO `system_area2` VALUES ('1834', '0001001700100003', '红安县', '1833', '421122');
INSERT INTO `system_area2` VALUES ('1835', '0001001700100004', '罗田县', '1834', '421123');
INSERT INTO `system_area2` VALUES ('1836', '0001001700100005', '英山县', '1835', '421124');
INSERT INTO `system_area2` VALUES ('1837', '0001001700100006', '浠水县', '1836', '421125');
INSERT INTO `system_area2` VALUES ('1838', '0001001700100007', '蕲春县', '1837', '421126');
INSERT INTO `system_area2` VALUES ('1839', '0001001700100008', '黄梅县', '1838', '421127');
INSERT INTO `system_area2` VALUES ('1840', '0001001700100009', '麻城市', '1839', '421181');
INSERT INTO `system_area2` VALUES ('1841', '0001001700100010', '武穴市', '1840', '421182');
INSERT INTO `system_area2` VALUES ('1842', '000100170011', '咸宁市', '1841', '421200');
INSERT INTO `system_area2` VALUES ('1843', '0001001700110001', '咸安区', '1842', '421202');
INSERT INTO `system_area2` VALUES ('1844', '0001001700110002', '嘉鱼县', '1843', '421221');
INSERT INTO `system_area2` VALUES ('1845', '0001001700110003', '通城县', '1844', '421222');
INSERT INTO `system_area2` VALUES ('1846', '0001001700110004', '崇阳县', '1845', '421223');
INSERT INTO `system_area2` VALUES ('1847', '0001001700110005', '通山县', '1846', '421224');
INSERT INTO `system_area2` VALUES ('1848', '0001001700110006', '赤壁市', '1847', '421281');
INSERT INTO `system_area2` VALUES ('1849', '0001001700110007', '温泉城区', '1848', '421282');
INSERT INTO `system_area2` VALUES ('1850', '000100170012', '随州市', '1849', '421300');
INSERT INTO `system_area2` VALUES ('1851', '0001001700120001', '曾都区', '1850', '421302');
INSERT INTO `system_area2` VALUES ('1852', '0001001700120002', '随县', '1851', '421321');
INSERT INTO `system_area2` VALUES ('1853', '0001001700120003', '广水市', '1852', '421381');
INSERT INTO `system_area2` VALUES ('1854', '000100170013', '恩施土家族苗族自治州', '1853', '422800');
INSERT INTO `system_area2` VALUES ('1855', '0001001700130001', '恩施市', '1854', '422801');
INSERT INTO `system_area2` VALUES ('1856', '0001001700130002', '利川市', '1855', '422802');
INSERT INTO `system_area2` VALUES ('1857', '0001001700130003', '建始县', '1856', '422822');
INSERT INTO `system_area2` VALUES ('1858', '0001001700130004', '巴东县', '1857', '422823');
INSERT INTO `system_area2` VALUES ('1859', '0001001700130005', '宣恩县', '1858', '422825');
INSERT INTO `system_area2` VALUES ('1860', '0001001700130006', '咸丰县', '1859', '422826');
INSERT INTO `system_area2` VALUES ('1861', '0001001700130007', '来凤县', '1860', '422827');
INSERT INTO `system_area2` VALUES ('1862', '0001001700130008', '鹤峰县', '1861', '422828');
INSERT INTO `system_area2` VALUES ('1863', '000100170014', '仙桃市', '1862', '429004');
INSERT INTO `system_area2` VALUES ('1864', '000100170015', '潜江市', '1863', '429005');
INSERT INTO `system_area2` VALUES ('1865', '000100170016', '天门市', '1864', '429006');
INSERT INTO `system_area2` VALUES ('1866', '000100170017', '神农架林区', '1865', '429021');
INSERT INTO `system_area2` VALUES ('1867', '00010018', '湖南省', '1866', '430000');
INSERT INTO `system_area2` VALUES ('1868', '000100180001', '长沙市', '1867', '430100');
INSERT INTO `system_area2` VALUES ('1869', '0001001800010001', '芙蓉区', '1868', '430102');
INSERT INTO `system_area2` VALUES ('1870', '0001001800010002', '天心区', '1869', '430103');
INSERT INTO `system_area2` VALUES ('1871', '0001001800010003', '岳麓区', '1870', '430104');
INSERT INTO `system_area2` VALUES ('1872', '0001001800010004', '开福区', '1871', '430105');
INSERT INTO `system_area2` VALUES ('1873', '0001001800010005', '雨花区', '1872', '430111');
INSERT INTO `system_area2` VALUES ('1874', '0001001800010006', '长沙县', '1873', '430121');
INSERT INTO `system_area2` VALUES ('1875', '0001001800010007', '望城县', '1874', '430122');
INSERT INTO `system_area2` VALUES ('1876', '0001001800010008', '宁乡县', '1875', '430124');
INSERT INTO `system_area2` VALUES ('1877', '0001001800010009', '浏阳市', '1876', '430181');
INSERT INTO `system_area2` VALUES ('1878', '000100180002', '株洲市', '1877', '430200');
INSERT INTO `system_area2` VALUES ('1879', '0001001800020001', '荷塘区', '1878', '430202');
INSERT INTO `system_area2` VALUES ('1880', '0001001800020002', '芦淞区', '1879', '430203');
INSERT INTO `system_area2` VALUES ('1881', '0001001800020003', '石峰区', '1880', '430204');
INSERT INTO `system_area2` VALUES ('1882', '0001001800020004', '天元区', '1881', '430211');
INSERT INTO `system_area2` VALUES ('1883', '0001001800020005', '株洲县', '1882', '430221');
INSERT INTO `system_area2` VALUES ('1884', '0001001800020006', '攸县', '1883', '430223');
INSERT INTO `system_area2` VALUES ('1885', '0001001800020007', '茶陵县', '1884', '430224');
INSERT INTO `system_area2` VALUES ('1886', '0001001800020008', '炎陵县', '1885', '430225');
INSERT INTO `system_area2` VALUES ('1887', '0001001800020009', '醴陵市', '1886', '430281');
INSERT INTO `system_area2` VALUES ('1888', '000100180003', '湘潭市', '1887', '430300');
INSERT INTO `system_area2` VALUES ('1889', '0001001800030001', '雨湖区', '1888', '430302');
INSERT INTO `system_area2` VALUES ('1890', '0001001800030002', '岳塘区', '1889', '430304');
INSERT INTO `system_area2` VALUES ('1891', '0001001800030003', '湘潭县', '1890', '430321');
INSERT INTO `system_area2` VALUES ('1892', '0001001800030004', '湘乡市', '1891', '430381');
INSERT INTO `system_area2` VALUES ('1893', '0001001800030005', '韶山市', '1892', '430382');
INSERT INTO `system_area2` VALUES ('1894', '000100180004', '衡阳市', '1893', '430400');
INSERT INTO `system_area2` VALUES ('1895', '0001001800040001', '珠晖区', '1894', '430405');
INSERT INTO `system_area2` VALUES ('1896', '0001001800040002', '雁峰区', '1895', '430406');
INSERT INTO `system_area2` VALUES ('1897', '0001001800040003', '石鼓区', '1896', '430407');
INSERT INTO `system_area2` VALUES ('1898', '0001001800040004', '蒸湘区', '1897', '430408');
INSERT INTO `system_area2` VALUES ('1899', '0001001800040005', '南岳区', '1898', '430412');
INSERT INTO `system_area2` VALUES ('1900', '0001001800040006', '衡阳县', '1899', '430421');
INSERT INTO `system_area2` VALUES ('1901', '0001001800040007', '衡南县', '1900', '430422');
INSERT INTO `system_area2` VALUES ('1902', '0001001800040008', '衡山县', '1901', '430423');
INSERT INTO `system_area2` VALUES ('1903', '0001001800040009', '衡东县', '1902', '430424');
INSERT INTO `system_area2` VALUES ('1904', '0001001800040010', '祁东县', '1903', '430426');
INSERT INTO `system_area2` VALUES ('1905', '0001001800040011', '耒阳市', '1904', '430481');
INSERT INTO `system_area2` VALUES ('1906', '0001001800040012', '常宁市', '1905', '430482');
INSERT INTO `system_area2` VALUES ('1907', '000100180005', '邵阳市', '1906', '430500');
INSERT INTO `system_area2` VALUES ('1908', '0001001800050001', '双清区', '1907', '430502');
INSERT INTO `system_area2` VALUES ('1909', '0001001800050002', '大祥区', '1908', '430503');
INSERT INTO `system_area2` VALUES ('1910', '0001001800050003', '北塔区', '1909', '430511');
INSERT INTO `system_area2` VALUES ('1911', '0001001800050004', '邵东县', '1910', '430521');
INSERT INTO `system_area2` VALUES ('1912', '0001001800050005', '新邵县', '1911', '430522');
INSERT INTO `system_area2` VALUES ('1913', '0001001800050006', '邵阳县', '1912', '430523');
INSERT INTO `system_area2` VALUES ('1914', '0001001800050007', '隆回县', '1913', '430524');
INSERT INTO `system_area2` VALUES ('1915', '0001001800050008', '洞口县', '1914', '430525');
INSERT INTO `system_area2` VALUES ('1916', '0001001800050009', '绥宁县', '1915', '430527');
INSERT INTO `system_area2` VALUES ('1917', '0001001800050010', '新宁县', '1916', '430528');
INSERT INTO `system_area2` VALUES ('1918', '0001001800050011', '城步苗族自治县', '1917', '430529');
INSERT INTO `system_area2` VALUES ('1919', '0001001800050012', '武冈市', '1918', '430581');
INSERT INTO `system_area2` VALUES ('1920', '000100180006', '岳阳市', '1919', '430600');
INSERT INTO `system_area2` VALUES ('1921', '0001001800060001', '岳阳楼区', '1920', '430602');
INSERT INTO `system_area2` VALUES ('1922', '0001001800060002', '云溪区', '1921', '430603');
INSERT INTO `system_area2` VALUES ('1923', '0001001800060003', '君山区', '1922', '430611');
INSERT INTO `system_area2` VALUES ('1924', '0001001800060004', '岳阳县', '1923', '430621');
INSERT INTO `system_area2` VALUES ('1925', '0001001800060005', '华容县', '1924', '430623');
INSERT INTO `system_area2` VALUES ('1926', '0001001800060006', '湘阴县', '1925', '430624');
INSERT INTO `system_area2` VALUES ('1927', '0001001800060007', '平江县', '1926', '430626');
INSERT INTO `system_area2` VALUES ('1928', '0001001800060008', '汨罗市', '1927', '430681');
INSERT INTO `system_area2` VALUES ('1929', '0001001800060009', '临湘市', '1928', '430682');
INSERT INTO `system_area2` VALUES ('1930', '000100180007', '常德市', '1929', '430700');
INSERT INTO `system_area2` VALUES ('1931', '0001001800070001', '武陵区', '1930', '430702');
INSERT INTO `system_area2` VALUES ('1932', '0001001800070002', '鼎城区', '1931', '430703');
INSERT INTO `system_area2` VALUES ('1933', '0001001800070003', '安乡县', '1932', '430721');
INSERT INTO `system_area2` VALUES ('1934', '0001001800070004', '汉寿县', '1933', '430722');
INSERT INTO `system_area2` VALUES ('1935', '0001001800070005', '澧县', '1934', '430723');
INSERT INTO `system_area2` VALUES ('1936', '0001001800070006', '临澧县', '1935', '430724');
INSERT INTO `system_area2` VALUES ('1937', '0001001800070007', '桃源县', '1936', '430725');
INSERT INTO `system_area2` VALUES ('1938', '0001001800070008', '石门县', '1937', '430726');
INSERT INTO `system_area2` VALUES ('1939', '0001001800070009', '津市市', '1938', '430781');
INSERT INTO `system_area2` VALUES ('1940', '000100180008', '张家界市', '1939', '430800');
INSERT INTO `system_area2` VALUES ('1941', '0001001800080001', '永定区', '1940', '430802');
INSERT INTO `system_area2` VALUES ('1942', '0001001800080002', '武陵源区', '1941', '430811');
INSERT INTO `system_area2` VALUES ('1943', '0001001800080003', '慈利县', '1942', '430821');
INSERT INTO `system_area2` VALUES ('1944', '0001001800080004', '桑植县', '1943', '430822');
INSERT INTO `system_area2` VALUES ('1945', '000100180009', '益阳市', '1944', '430900');
INSERT INTO `system_area2` VALUES ('1946', '0001001800090001', '资阳区', '1945', '430902');
INSERT INTO `system_area2` VALUES ('1947', '0001001800090002', '赫山区', '1946', '430903');
INSERT INTO `system_area2` VALUES ('1948', '0001001800090003', '南县', '1947', '430921');
INSERT INTO `system_area2` VALUES ('1949', '0001001800090004', '桃江县', '1948', '430922');
INSERT INTO `system_area2` VALUES ('1950', '0001001800090005', '安化县', '1949', '430923');
INSERT INTO `system_area2` VALUES ('1951', '0001001800090006', '沅江市', '1950', '430981');
INSERT INTO `system_area2` VALUES ('1952', '000100180010', '郴州市', '1951', '431000');
INSERT INTO `system_area2` VALUES ('1953', '0001001800100001', '北湖区', '1952', '431002');
INSERT INTO `system_area2` VALUES ('1954', '0001001800100002', '苏仙区', '1953', '431003');
INSERT INTO `system_area2` VALUES ('1955', '0001001800100003', '桂阳县', '1954', '431021');
INSERT INTO `system_area2` VALUES ('1956', '0001001800100004', '宜章县', '1955', '431022');
INSERT INTO `system_area2` VALUES ('1957', '0001001800100005', '永兴县', '1956', '431023');
INSERT INTO `system_area2` VALUES ('1958', '0001001800100006', '嘉禾县', '1957', '431024');
INSERT INTO `system_area2` VALUES ('1959', '0001001800100007', '临武县', '1958', '431025');
INSERT INTO `system_area2` VALUES ('1960', '0001001800100008', '汝城县', '1959', '431026');
INSERT INTO `system_area2` VALUES ('1961', '0001001800100009', '桂东县', '1960', '431027');
INSERT INTO `system_area2` VALUES ('1962', '0001001800100010', '安仁县', '1961', '431028');
INSERT INTO `system_area2` VALUES ('1963', '0001001800100011', '资兴市', '1962', '431081');
INSERT INTO `system_area2` VALUES ('1964', '000100180011', '永州市', '1963', '431100');
INSERT INTO `system_area2` VALUES ('1965', '0001001800110001', '零陵区', '1964', '431102');
INSERT INTO `system_area2` VALUES ('1966', '0001001800110002', '冷水滩区', '1965', '431103');
INSERT INTO `system_area2` VALUES ('1967', '0001001800110003', '祁阳县', '1966', '431121');
INSERT INTO `system_area2` VALUES ('1968', '0001001800110004', '东安县', '1967', '431122');
INSERT INTO `system_area2` VALUES ('1969', '0001001800110005', '双牌县', '1968', '431123');
INSERT INTO `system_area2` VALUES ('1970', '0001001800110006', '道县', '1969', '431124');
INSERT INTO `system_area2` VALUES ('1971', '0001001800110007', '江永县', '1970', '431125');
INSERT INTO `system_area2` VALUES ('1972', '0001001800110008', '宁远县', '1971', '431126');
INSERT INTO `system_area2` VALUES ('1973', '0001001800110009', '蓝山县', '1972', '431127');
INSERT INTO `system_area2` VALUES ('1974', '0001001800110010', '新田县', '1973', '431128');
INSERT INTO `system_area2` VALUES ('1975', '0001001800110011', '江华瑶族自治县', '1974', '431129');
INSERT INTO `system_area2` VALUES ('1976', '000100180012', '怀化市', '1975', '431200');
INSERT INTO `system_area2` VALUES ('1977', '0001001800120001', '鹤城区', '1976', '431202');
INSERT INTO `system_area2` VALUES ('1978', '0001001800120002', '中方县', '1977', '431221');
INSERT INTO `system_area2` VALUES ('1979', '0001001800120003', '沅陵县', '1978', '431222');
INSERT INTO `system_area2` VALUES ('1980', '0001001800120004', '辰溪县', '1979', '431223');
INSERT INTO `system_area2` VALUES ('1981', '0001001800120005', '溆浦县', '1980', '431224');
INSERT INTO `system_area2` VALUES ('1982', '0001001800120006', '会同县', '1981', '431225');
INSERT INTO `system_area2` VALUES ('1983', '0001001800120007', '麻阳苗族自治县', '1982', '431226');
INSERT INTO `system_area2` VALUES ('1984', '0001001800120008', '新晃侗族自治县', '1983', '431227');
INSERT INTO `system_area2` VALUES ('1985', '0001001800120009', '芷江侗族自治县', '1984', '431228');
INSERT INTO `system_area2` VALUES ('1986', '0001001800120010', '靖州苗族侗族自治县', '1985', '431229');
INSERT INTO `system_area2` VALUES ('1987', '0001001800120011', '通道侗族自治县', '1986', '431230');
INSERT INTO `system_area2` VALUES ('1988', '0001001800120012', '洪江市', '1987', '431281');
INSERT INTO `system_area2` VALUES ('1989', '000100180013', '娄底市', '1988', '431300');
INSERT INTO `system_area2` VALUES ('1990', '0001001800130001', '娄星区', '1989', '431302');
INSERT INTO `system_area2` VALUES ('1991', '0001001800130002', '双峰县', '1990', '431321');
INSERT INTO `system_area2` VALUES ('1992', '0001001800130003', '新化县', '1991', '431322');
INSERT INTO `system_area2` VALUES ('1993', '0001001800130004', '冷水江市', '1992', '431381');
INSERT INTO `system_area2` VALUES ('1994', '0001001800130005', '涟源市', '1993', '431382');
INSERT INTO `system_area2` VALUES ('1995', '000100180014', '湘西土家族苗族自治州', '1994', '433100');
INSERT INTO `system_area2` VALUES ('1996', '0001001800140001', '吉首市', '1995', '433101');
INSERT INTO `system_area2` VALUES ('1997', '0001001800140002', '泸溪县', '1996', '433122');
INSERT INTO `system_area2` VALUES ('1998', '0001001800140003', '凤凰县', '1997', '433123');
INSERT INTO `system_area2` VALUES ('1999', '0001001800140004', '花垣县', '1998', '433124');
INSERT INTO `system_area2` VALUES ('2000', '0001001800140005', '保靖县', '1999', '433125');
INSERT INTO `system_area2` VALUES ('2001', '0001001800140006', '古丈县', '2000', '433126');
INSERT INTO `system_area2` VALUES ('2002', '0001001800140007', '永顺县', '2001', '433127');
INSERT INTO `system_area2` VALUES ('2003', '0001001800140008', '龙山县', '2002', '433130');
INSERT INTO `system_area2` VALUES ('2004', '00010019', '广东省', '2003', '440000');
INSERT INTO `system_area2` VALUES ('2005', '000100190001', '广州市', '2004', '440100');
INSERT INTO `system_area2` VALUES ('2006', '0001001900010001', '荔湾区', '2005', '440103');
INSERT INTO `system_area2` VALUES ('2007', '0001001900010002', '越秀区', '2006', '440104');
INSERT INTO `system_area2` VALUES ('2008', '0001001900010003', '海珠区', '2007', '440105');
INSERT INTO `system_area2` VALUES ('2009', '0001001900010004', '天河区', '2008', '440106');
INSERT INTO `system_area2` VALUES ('2010', '0001001900010005', '白云区', '2009', '440111');
INSERT INTO `system_area2` VALUES ('2011', '0001001900010006', '黄埔区', '2010', '440112');
INSERT INTO `system_area2` VALUES ('2012', '0001001900010007', '番禺区', '2011', '440113');
INSERT INTO `system_area2` VALUES ('2013', '0001001900010008', '花都区', '2012', '440114');
INSERT INTO `system_area2` VALUES ('2014', '0001001900010009', '南沙区', '2013', '440115');
INSERT INTO `system_area2` VALUES ('2015', '0001001900010010', '萝岗区', '2014', '440116');
INSERT INTO `system_area2` VALUES ('2016', '0001001900010011', '增城市', '2015', '440183');
INSERT INTO `system_area2` VALUES ('2017', '0001001900010012', '从化市', '2016', '440184');
INSERT INTO `system_area2` VALUES ('2018', '0001001900010013', '东山区', '2017', '440188');
INSERT INTO `system_area2` VALUES ('2019', '000100190002', '韶关市', '2018', '440200');
INSERT INTO `system_area2` VALUES ('2020', '0001001900020001', '武江区', '2019', '440203');
INSERT INTO `system_area2` VALUES ('2021', '0001001900020002', '浈江区', '2020', '440204');
INSERT INTO `system_area2` VALUES ('2022', '0001001900020003', '曲江区', '2021', '440205');
INSERT INTO `system_area2` VALUES ('2023', '0001001900020004', '始兴县', '2022', '440222');
INSERT INTO `system_area2` VALUES ('2024', '0001001900020005', '仁化县', '2023', '440224');
INSERT INTO `system_area2` VALUES ('2025', '0001001900020006', '翁源县', '2024', '440229');
INSERT INTO `system_area2` VALUES ('2026', '0001001900020007', '乳源瑶族自治县', '2025', '440232');
INSERT INTO `system_area2` VALUES ('2027', '0001001900020008', '新丰县', '2026', '440233');
INSERT INTO `system_area2` VALUES ('2028', '0001001900020009', '乐昌市', '2027', '440281');
INSERT INTO `system_area2` VALUES ('2029', '0001001900020010', '南雄市', '2028', '440282');
INSERT INTO `system_area2` VALUES ('2030', '000100190003', '深圳市', '2029', '440300');
INSERT INTO `system_area2` VALUES ('2031', '0001001900030001', '罗湖区', '2030', '440303');
INSERT INTO `system_area2` VALUES ('2032', '0001001900030002', '福田区', '2031', '440304');
INSERT INTO `system_area2` VALUES ('2033', '0001001900030003', '南山区', '2032', '440305');
INSERT INTO `system_area2` VALUES ('2034', '0001001900030004', '宝安区', '2033', '440306');
INSERT INTO `system_area2` VALUES ('2035', '0001001900030005', '龙岗区', '2034', '440307');
INSERT INTO `system_area2` VALUES ('2036', '0001001900030006', '盐田区', '2035', '440308');
INSERT INTO `system_area2` VALUES ('2037', '0001001900030007', '光明新区', '2036', '440320');
INSERT INTO `system_area2` VALUES ('2038', '0001001900030008', '坪山新区', '2037', '440321');
INSERT INTO `system_area2` VALUES ('2039', '0001001900030009', '大鹏新区', '2038', '440322');
INSERT INTO `system_area2` VALUES ('2040', '0001001900030010', '龙华新区', '2039', '440323');
INSERT INTO `system_area2` VALUES ('2041', '000100190004', '珠海市', '2040', '440400');
INSERT INTO `system_area2` VALUES ('2042', '0001001900040001', '香洲区', '2041', '440402');
INSERT INTO `system_area2` VALUES ('2043', '0001001900040002', '斗门区', '2042', '440403');
INSERT INTO `system_area2` VALUES ('2044', '0001001900040003', '金湾区', '2043', '440404');
INSERT INTO `system_area2` VALUES ('2045', '0001001900040004', '金唐区', '2044', '440486');
INSERT INTO `system_area2` VALUES ('2046', '0001001900040005', '南湾区', '2045', '440487');
INSERT INTO `system_area2` VALUES ('2047', '000100190005', '汕头市', '2046', '440500');
INSERT INTO `system_area2` VALUES ('2048', '0001001900050001', '龙湖区', '2047', '440507');
INSERT INTO `system_area2` VALUES ('2049', '0001001900050002', '金平区', '2048', '440511');
INSERT INTO `system_area2` VALUES ('2050', '0001001900050003', '濠江区', '2049', '440512');
INSERT INTO `system_area2` VALUES ('2051', '0001001900050004', '潮阳区', '2050', '440513');
INSERT INTO `system_area2` VALUES ('2052', '0001001900050005', '潮南区', '2051', '440514');
INSERT INTO `system_area2` VALUES ('2053', '0001001900050006', '澄海区', '2052', '440515');
INSERT INTO `system_area2` VALUES ('2054', '0001001900050007', '南澳县', '2053', '440523');
INSERT INTO `system_area2` VALUES ('2055', '000100190006', '佛山市', '2054', '440600');
INSERT INTO `system_area2` VALUES ('2056', '0001001900060001', '禅城区', '2055', '440604');
INSERT INTO `system_area2` VALUES ('2057', '0001001900060002', '南海区', '2056', '440605');
INSERT INTO `system_area2` VALUES ('2058', '0001001900060003', '顺德区', '2057', '440606');
INSERT INTO `system_area2` VALUES ('2059', '0001001900060004', '三水区', '2058', '440607');
INSERT INTO `system_area2` VALUES ('2060', '0001001900060005', '高明区', '2059', '440608');
INSERT INTO `system_area2` VALUES ('2061', '000100190007', '江门市', '2060', '440700');
INSERT INTO `system_area2` VALUES ('2062', '0001001900070001', '蓬江区', '2061', '440703');
INSERT INTO `system_area2` VALUES ('2063', '0001001900070002', '江海区', '2062', '440704');
INSERT INTO `system_area2` VALUES ('2064', '0001001900070003', '新会区', '2063', '440705');
INSERT INTO `system_area2` VALUES ('2065', '0001001900070004', '台山市', '2064', '440781');
INSERT INTO `system_area2` VALUES ('2066', '0001001900070005', '开平市', '2065', '440783');
INSERT INTO `system_area2` VALUES ('2067', '0001001900070006', '鹤山市', '2066', '440784');
INSERT INTO `system_area2` VALUES ('2068', '0001001900070007', '恩平市', '2067', '440785');
INSERT INTO `system_area2` VALUES ('2069', '000100190008', '湛江市', '2068', '440800');
INSERT INTO `system_area2` VALUES ('2070', '0001001900080001', '赤坎区', '2069', '440802');
INSERT INTO `system_area2` VALUES ('2071', '0001001900080002', '霞山区', '2070', '440803');
INSERT INTO `system_area2` VALUES ('2072', '0001001900080003', '坡头区', '2071', '440804');
INSERT INTO `system_area2` VALUES ('2073', '0001001900080004', '麻章区', '2072', '440811');
INSERT INTO `system_area2` VALUES ('2074', '0001001900080005', '遂溪县', '2073', '440823');
INSERT INTO `system_area2` VALUES ('2075', '0001001900080006', '徐闻县', '2074', '440825');
INSERT INTO `system_area2` VALUES ('2076', '0001001900080007', '廉江市', '2075', '440881');
INSERT INTO `system_area2` VALUES ('2077', '0001001900080008', '雷州市', '2076', '440882');
INSERT INTO `system_area2` VALUES ('2078', '0001001900080009', '吴川市', '2077', '440883');
INSERT INTO `system_area2` VALUES ('2079', '000100190009', '茂名市', '2078', '440900');
INSERT INTO `system_area2` VALUES ('2080', '0001001900090001', '茂南区', '2079', '440902');
INSERT INTO `system_area2` VALUES ('2081', '0001001900090002', '茂港区', '2080', '440903');
INSERT INTO `system_area2` VALUES ('2082', '0001001900090003', '电白县', '2081', '440923');
INSERT INTO `system_area2` VALUES ('2083', '0001001900090004', '高州市', '2082', '440981');
INSERT INTO `system_area2` VALUES ('2084', '0001001900090005', '化州市', '2083', '440982');
INSERT INTO `system_area2` VALUES ('2085', '0001001900090006', '信宜市', '2084', '440983');
INSERT INTO `system_area2` VALUES ('2086', '000100190010', '肇庆市', '2085', '441200');
INSERT INTO `system_area2` VALUES ('2087', '0001001900100001', '端州区', '2086', '441202');
INSERT INTO `system_area2` VALUES ('2088', '0001001900100002', '鼎湖区', '2087', '441203');
INSERT INTO `system_area2` VALUES ('2089', '0001001900100003', '广宁县', '2088', '441223');
INSERT INTO `system_area2` VALUES ('2090', '0001001900100004', '怀集县', '2089', '441224');
INSERT INTO `system_area2` VALUES ('2091', '0001001900100005', '封开县', '2090', '441225');
INSERT INTO `system_area2` VALUES ('2092', '0001001900100006', '德庆县', '2091', '441226');
INSERT INTO `system_area2` VALUES ('2093', '0001001900100007', '高要市', '2092', '441283');
INSERT INTO `system_area2` VALUES ('2094', '0001001900100008', '四会市', '2093', '441284');
INSERT INTO `system_area2` VALUES ('2095', '000100190011', '惠州市', '2094', '441300');
INSERT INTO `system_area2` VALUES ('2096', '0001001900110001', '惠城区', '2095', '441302');
INSERT INTO `system_area2` VALUES ('2097', '0001001900110002', '惠阳区', '2096', '441303');
INSERT INTO `system_area2` VALUES ('2098', '0001001900110003', '博罗县', '2097', '441322');
INSERT INTO `system_area2` VALUES ('2099', '0001001900110004', '惠东县', '2098', '441323');
INSERT INTO `system_area2` VALUES ('2100', '0001001900110005', '龙门县', '2099', '441324');
INSERT INTO `system_area2` VALUES ('2101', '000100190012', '梅州市', '2100', '441400');
INSERT INTO `system_area2` VALUES ('2102', '0001001900120001', '梅江区', '2101', '441402');
INSERT INTO `system_area2` VALUES ('2103', '0001001900120002', '梅县', '2102', '441421');
INSERT INTO `system_area2` VALUES ('2104', '0001001900120003', '大埔县', '2103', '441422');
INSERT INTO `system_area2` VALUES ('2105', '0001001900120004', '丰顺县', '2104', '441423');
INSERT INTO `system_area2` VALUES ('2106', '0001001900120005', '五华县', '2105', '441424');
INSERT INTO `system_area2` VALUES ('2107', '0001001900120006', '平远县', '2106', '441426');
INSERT INTO `system_area2` VALUES ('2108', '0001001900120007', '蕉岭县', '2107', '441427');
INSERT INTO `system_area2` VALUES ('2109', '0001001900120008', '兴宁市', '2108', '441481');
INSERT INTO `system_area2` VALUES ('2110', '000100190013', '汕尾市', '2109', '441500');
INSERT INTO `system_area2` VALUES ('2111', '0001001900130001', '城区', '2110', '441502');
INSERT INTO `system_area2` VALUES ('2112', '0001001900130002', '海丰县', '2111', '441521');
INSERT INTO `system_area2` VALUES ('2113', '0001001900130003', '陆河县', '2112', '441523');
INSERT INTO `system_area2` VALUES ('2114', '0001001900130004', '陆丰市', '2113', '441581');
INSERT INTO `system_area2` VALUES ('2115', '000100190014', '河源市', '2114', '441600');
INSERT INTO `system_area2` VALUES ('2116', '0001001900140001', '源城区', '2115', '441602');
INSERT INTO `system_area2` VALUES ('2117', '0001001900140002', '紫金县', '2116', '441621');
INSERT INTO `system_area2` VALUES ('2118', '0001001900140003', '龙川县', '2117', '441622');
INSERT INTO `system_area2` VALUES ('2119', '0001001900140004', '连平县', '2118', '441623');
INSERT INTO `system_area2` VALUES ('2120', '0001001900140005', '和平县', '2119', '441624');
INSERT INTO `system_area2` VALUES ('2121', '0001001900140006', '东源县', '2120', '441625');
INSERT INTO `system_area2` VALUES ('2122', '000100190015', '阳江市', '2121', '441700');
INSERT INTO `system_area2` VALUES ('2123', '0001001900150001', '江城区', '2122', '441702');
INSERT INTO `system_area2` VALUES ('2124', '0001001900150002', '阳西县', '2123', '441721');
INSERT INTO `system_area2` VALUES ('2125', '0001001900150003', '阳东县', '2124', '441723');
INSERT INTO `system_area2` VALUES ('2126', '0001001900150004', '阳春市', '2125', '441781');
INSERT INTO `system_area2` VALUES ('2127', '000100190016', '清远市', '2126', '441800');
INSERT INTO `system_area2` VALUES ('2128', '0001001900160001', '清城区', '2127', '441802');
INSERT INTO `system_area2` VALUES ('2129', '0001001900160002', '佛冈县', '2128', '441821');
INSERT INTO `system_area2` VALUES ('2130', '0001001900160003', '阳山县', '2129', '441823');
INSERT INTO `system_area2` VALUES ('2131', '0001001900160004', '连山壮族瑶族自治县', '2130', '441825');
INSERT INTO `system_area2` VALUES ('2132', '0001001900160005', '连南瑶族自治县', '2131', '441826');
INSERT INTO `system_area2` VALUES ('2133', '0001001900160006', '清新县', '2132', '441827');
INSERT INTO `system_area2` VALUES ('2134', '0001001900160007', '英德市', '2133', '441881');
INSERT INTO `system_area2` VALUES ('2135', '0001001900160008', '连州市', '2134', '441882');
INSERT INTO `system_area2` VALUES ('2136', '000100190017', '东莞市', '2135', '441900');
INSERT INTO `system_area2` VALUES ('2137', '000100190018', '中山市', '2136', '442000');
INSERT INTO `system_area2` VALUES ('2138', '000100190019', '潮州市', '2137', '445100');
INSERT INTO `system_area2` VALUES ('2139', '0001001900190001', '湘桥区', '2138', '445102');
INSERT INTO `system_area2` VALUES ('2140', '0001001900190002', '潮安县', '2139', '445121');
INSERT INTO `system_area2` VALUES ('2141', '0001001900190003', '饶平县', '2140', '445122');
INSERT INTO `system_area2` VALUES ('2142', '0001001900190004', '枫溪区', '2141', '445185');
INSERT INTO `system_area2` VALUES ('2143', '000100190020', '揭阳市', '2142', '445200');
INSERT INTO `system_area2` VALUES ('2144', '0001001900200001', '榕城区', '2143', '445202');
INSERT INTO `system_area2` VALUES ('2145', '0001001900200002', '揭东县', '2144', '445221');
INSERT INTO `system_area2` VALUES ('2146', '0001001900200003', '揭西县', '2145', '445222');
INSERT INTO `system_area2` VALUES ('2147', '0001001900200004', '惠来县', '2146', '445224');
INSERT INTO `system_area2` VALUES ('2148', '0001001900200005', '普宁市', '2147', '445281');
INSERT INTO `system_area2` VALUES ('2149', '0001001900200006', '东山区', '2148', '445284');
INSERT INTO `system_area2` VALUES ('2150', '000100190021', '云浮市', '2149', '445300');
INSERT INTO `system_area2` VALUES ('2151', '0001001900210001', '云城区', '2150', '445302');
INSERT INTO `system_area2` VALUES ('2152', '0001001900210002', '新兴县', '2151', '445321');
INSERT INTO `system_area2` VALUES ('2153', '0001001900210003', '郁南县', '2152', '445322');
INSERT INTO `system_area2` VALUES ('2154', '0001001900210004', '云安县', '2153', '445323');
INSERT INTO `system_area2` VALUES ('2155', '0001001900210005', '罗定市', '2154', '445381');
INSERT INTO `system_area2` VALUES ('2156', '00010020', '广西壮族自治区', '2155', '450000');
INSERT INTO `system_area2` VALUES ('2157', '000100200001', '南宁市', '2156', '450100');
INSERT INTO `system_area2` VALUES ('2158', '0001002000010001', '兴宁区', '2157', '450102');
INSERT INTO `system_area2` VALUES ('2159', '0001002000010002', '青秀区', '2158', '450103');
INSERT INTO `system_area2` VALUES ('2160', '0001002000010003', '江南区', '2159', '450105');
INSERT INTO `system_area2` VALUES ('2161', '0001002000010004', '西乡塘区', '2160', '450107');
INSERT INTO `system_area2` VALUES ('2162', '0001002000010005', '良庆区', '2161', '450108');
INSERT INTO `system_area2` VALUES ('2163', '0001002000010006', '邕宁区', '2162', '450109');
INSERT INTO `system_area2` VALUES ('2164', '0001002000010007', '武鸣县', '2163', '450122');
INSERT INTO `system_area2` VALUES ('2165', '0001002000010008', '隆安县', '2164', '450123');
INSERT INTO `system_area2` VALUES ('2166', '0001002000010009', '马山县', '2165', '450124');
INSERT INTO `system_area2` VALUES ('2167', '0001002000010010', '上林县', '2166', '450125');
INSERT INTO `system_area2` VALUES ('2168', '0001002000010011', '宾阳县', '2167', '450126');
INSERT INTO `system_area2` VALUES ('2169', '0001002000010012', '横县', '2168', '450127');
INSERT INTO `system_area2` VALUES ('2170', '000100200002', '柳州市', '2169', '450200');
INSERT INTO `system_area2` VALUES ('2171', '0001002000020001', '城中区', '2170', '450202');
INSERT INTO `system_area2` VALUES ('2172', '0001002000020002', '鱼峰区', '2171', '450203');
INSERT INTO `system_area2` VALUES ('2173', '0001002000020003', '柳南区', '2172', '450204');
INSERT INTO `system_area2` VALUES ('2174', '0001002000020004', '柳北区', '2173', '450205');
INSERT INTO `system_area2` VALUES ('2175', '0001002000020005', '柳江县', '2174', '450221');
INSERT INTO `system_area2` VALUES ('2176', '0001002000020006', '柳城县', '2175', '450222');
INSERT INTO `system_area2` VALUES ('2177', '0001002000020007', '鹿寨县', '2176', '450223');
INSERT INTO `system_area2` VALUES ('2178', '0001002000020008', '融安县', '2177', '450224');
INSERT INTO `system_area2` VALUES ('2179', '0001002000020009', '融水苗族自治县', '2178', '450225');
INSERT INTO `system_area2` VALUES ('2180', '0001002000020010', '三江侗族自治县', '2179', '450226');
INSERT INTO `system_area2` VALUES ('2181', '000100200003', '桂林市', '2180', '450300');
INSERT INTO `system_area2` VALUES ('2182', '0001002000030001', '秀峰区', '2181', '450302');
INSERT INTO `system_area2` VALUES ('2183', '0001002000030002', '叠彩区', '2182', '450303');
INSERT INTO `system_area2` VALUES ('2184', '0001002000030003', '象山区', '2183', '450304');
INSERT INTO `system_area2` VALUES ('2185', '0001002000030004', '七星区', '2184', '450305');
INSERT INTO `system_area2` VALUES ('2186', '0001002000030005', '雁山区', '2185', '450311');
INSERT INTO `system_area2` VALUES ('2187', '0001002000030006', '阳朔县', '2186', '450321');
INSERT INTO `system_area2` VALUES ('2188', '0001002000030007', '临桂县', '2187', '450322');
INSERT INTO `system_area2` VALUES ('2189', '0001002000030008', '灵川县', '2188', '450323');
INSERT INTO `system_area2` VALUES ('2190', '0001002000030009', '全州县', '2189', '450324');
INSERT INTO `system_area2` VALUES ('2191', '0001002000030010', '兴安县', '2190', '450325');
INSERT INTO `system_area2` VALUES ('2192', '0001002000030011', '永福县', '2191', '450326');
INSERT INTO `system_area2` VALUES ('2193', '0001002000030012', '灌阳县', '2192', '450327');
INSERT INTO `system_area2` VALUES ('2194', '0001002000030013', '龙胜各族自治县', '2193', '450328');
INSERT INTO `system_area2` VALUES ('2195', '0001002000030014', '资源县', '2194', '450329');
INSERT INTO `system_area2` VALUES ('2196', '0001002000030015', '平乐县', '2195', '450330');
INSERT INTO `system_area2` VALUES ('2197', '0001002000030016', '荔浦县', '2196', '450331');
INSERT INTO `system_area2` VALUES ('2198', '0001002000030017', '恭城瑶族自治县', '2197', '450332');
INSERT INTO `system_area2` VALUES ('2199', '000100200004', '梧州市', '2198', '450400');
INSERT INTO `system_area2` VALUES ('2200', '0001002000040001', '万秀区', '2199', '450403');
INSERT INTO `system_area2` VALUES ('2201', '0001002000040002', '蝶山区', '2200', '450404');
INSERT INTO `system_area2` VALUES ('2202', '0001002000040003', '长洲区', '2201', '450405');
INSERT INTO `system_area2` VALUES ('2203', '0001002000040004', '苍梧县', '2202', '450421');
INSERT INTO `system_area2` VALUES ('2204', '0001002000040005', '藤县', '2203', '450422');
INSERT INTO `system_area2` VALUES ('2205', '0001002000040006', '蒙山县', '2204', '450423');
INSERT INTO `system_area2` VALUES ('2206', '0001002000040007', '岑溪市', '2205', '450481');
INSERT INTO `system_area2` VALUES ('2207', '000100200005', '北海市', '2206', '450500');
INSERT INTO `system_area2` VALUES ('2208', '0001002000050001', '海城区', '2207', '450502');
INSERT INTO `system_area2` VALUES ('2209', '0001002000050002', '银海区', '2208', '450503');
INSERT INTO `system_area2` VALUES ('2210', '0001002000050003', '铁山港区', '2209', '450512');
INSERT INTO `system_area2` VALUES ('2211', '0001002000050004', '合浦县', '2210', '450521');
INSERT INTO `system_area2` VALUES ('2212', '000100200006', '防城港市', '2211', '450600');
INSERT INTO `system_area2` VALUES ('2213', '0001002000060001', '港口区', '2212', '450602');
INSERT INTO `system_area2` VALUES ('2214', '0001002000060002', '防城区', '2213', '450603');
INSERT INTO `system_area2` VALUES ('2215', '0001002000060003', '上思县', '2214', '450621');
INSERT INTO `system_area2` VALUES ('2216', '0001002000060004', '东兴市', '2215', '450681');
INSERT INTO `system_area2` VALUES ('2217', '000100200007', '钦州市', '2216', '450700');
INSERT INTO `system_area2` VALUES ('2218', '0001002000070001', '钦南区', '2217', '450702');
INSERT INTO `system_area2` VALUES ('2219', '0001002000070002', '钦北区', '2218', '450703');
INSERT INTO `system_area2` VALUES ('2220', '0001002000070003', '灵山县', '2219', '450721');
INSERT INTO `system_area2` VALUES ('2221', '0001002000070004', '浦北县', '2220', '450722');
INSERT INTO `system_area2` VALUES ('2222', '000100200008', '贵港市', '2221', '450800');
INSERT INTO `system_area2` VALUES ('2223', '0001002000080001', '港北区', '2222', '450802');
INSERT INTO `system_area2` VALUES ('2224', '0001002000080002', '港南区', '2223', '450803');
INSERT INTO `system_area2` VALUES ('2225', '0001002000080003', '覃塘区', '2224', '450804');
INSERT INTO `system_area2` VALUES ('2226', '0001002000080004', '平南县', '2225', '450821');
INSERT INTO `system_area2` VALUES ('2227', '0001002000080005', '桂平市', '2226', '450881');
INSERT INTO `system_area2` VALUES ('2228', '000100200009', '玉林市', '2227', '450900');
INSERT INTO `system_area2` VALUES ('2229', '0001002000090001', '玉州区', '2228', '450902');
INSERT INTO `system_area2` VALUES ('2230', '0001002000090002', '容县', '2229', '450921');
INSERT INTO `system_area2` VALUES ('2231', '0001002000090003', '陆川县', '2230', '450922');
INSERT INTO `system_area2` VALUES ('2232', '0001002000090004', '博白县', '2231', '450923');
INSERT INTO `system_area2` VALUES ('2233', '0001002000090005', '兴业县', '2232', '450924');
INSERT INTO `system_area2` VALUES ('2234', '0001002000090006', '北流市', '2233', '450981');
INSERT INTO `system_area2` VALUES ('2235', '000100200010', '百色市', '2234', '451000');
INSERT INTO `system_area2` VALUES ('2236', '0001002000100001', '右江区', '2235', '451002');
INSERT INTO `system_area2` VALUES ('2237', '0001002000100002', '田阳县', '2236', '451021');
INSERT INTO `system_area2` VALUES ('2238', '0001002000100003', '田东县', '2237', '451022');
INSERT INTO `system_area2` VALUES ('2239', '0001002000100004', '平果县', '2238', '451023');
INSERT INTO `system_area2` VALUES ('2240', '0001002000100005', '德保县', '2239', '451024');
INSERT INTO `system_area2` VALUES ('2241', '0001002000100006', '靖西县', '2240', '451025');
INSERT INTO `system_area2` VALUES ('2242', '0001002000100007', '那坡县', '2241', '451026');
INSERT INTO `system_area2` VALUES ('2243', '0001002000100008', '凌云县', '2242', '451027');
INSERT INTO `system_area2` VALUES ('2244', '0001002000100009', '乐业县', '2243', '451028');
INSERT INTO `system_area2` VALUES ('2245', '0001002000100010', '田林县', '2244', '451029');
INSERT INTO `system_area2` VALUES ('2246', '0001002000100011', '西林县', '2245', '451030');
INSERT INTO `system_area2` VALUES ('2247', '0001002000100012', '隆林各族自治县', '2246', '451031');
INSERT INTO `system_area2` VALUES ('2248', '000100200011', '贺州市', '2247', '451100');
INSERT INTO `system_area2` VALUES ('2249', '0001002000110001', '八步区', '2248', '451102');
INSERT INTO `system_area2` VALUES ('2250', '0001002000110002', '昭平县', '2249', '451121');
INSERT INTO `system_area2` VALUES ('2251', '0001002000110003', '钟山县', '2250', '451122');
INSERT INTO `system_area2` VALUES ('2252', '0001002000110004', '富川瑶族自治县', '2251', '451123');
INSERT INTO `system_area2` VALUES ('2253', '000100200012', '河池市', '2252', '451200');
INSERT INTO `system_area2` VALUES ('2254', '0001002000120001', '金城江区', '2253', '451202');
INSERT INTO `system_area2` VALUES ('2255', '0001002000120002', '南丹县', '2254', '451221');
INSERT INTO `system_area2` VALUES ('2256', '0001002000120003', '天峨县', '2255', '451222');
INSERT INTO `system_area2` VALUES ('2257', '0001002000120004', '凤山县', '2256', '451223');
INSERT INTO `system_area2` VALUES ('2258', '0001002000120005', '东兰县', '2257', '451224');
INSERT INTO `system_area2` VALUES ('2259', '0001002000120006', '罗城仫佬族自治县', '2258', '451225');
INSERT INTO `system_area2` VALUES ('2260', '0001002000120007', '环江毛南族自治县', '2259', '451226');
INSERT INTO `system_area2` VALUES ('2261', '0001002000120008', '巴马瑶族自治县', '2260', '451227');
INSERT INTO `system_area2` VALUES ('2262', '0001002000120009', '都安瑶族自治县', '2261', '451228');
INSERT INTO `system_area2` VALUES ('2263', '0001002000120010', '大化瑶族自治县', '2262', '451229');
INSERT INTO `system_area2` VALUES ('2264', '0001002000120011', '宜州市', '2263', '451281');
INSERT INTO `system_area2` VALUES ('2265', '000100200013', '来宾市', '2264', '451300');
INSERT INTO `system_area2` VALUES ('2266', '0001002000130001', '兴宾区', '2265', '451302');
INSERT INTO `system_area2` VALUES ('2267', '0001002000130002', '忻城县', '2266', '451321');
INSERT INTO `system_area2` VALUES ('2268', '0001002000130003', '象州县', '2267', '451322');
INSERT INTO `system_area2` VALUES ('2269', '0001002000130004', '武宣县', '2268', '451323');
INSERT INTO `system_area2` VALUES ('2270', '0001002000130005', '金秀瑶族自治县', '2269', '451324');
INSERT INTO `system_area2` VALUES ('2271', '0001002000130006', '合山市', '2270', '451381');
INSERT INTO `system_area2` VALUES ('2272', '000100200014', '崇左市', '2271', '451400');
INSERT INTO `system_area2` VALUES ('2273', '0001002000140001', '江洲区', '2272', '451402');
INSERT INTO `system_area2` VALUES ('2274', '0001002000140002', '扶绥县', '2273', '451421');
INSERT INTO `system_area2` VALUES ('2275', '0001002000140003', '宁明县', '2274', '451422');
INSERT INTO `system_area2` VALUES ('2276', '0001002000140004', '龙州县', '2275', '451423');
INSERT INTO `system_area2` VALUES ('2277', '0001002000140005', '大新县', '2276', '451424');
INSERT INTO `system_area2` VALUES ('2278', '0001002000140006', '天等县', '2277', '451425');
INSERT INTO `system_area2` VALUES ('2279', '0001002000140007', '凭祥市', '2278', '451481');
INSERT INTO `system_area2` VALUES ('2280', '00010021', '海南省', '2279', '460000');
INSERT INTO `system_area2` VALUES ('2281', '000100210001', '海口市', '2280', '460100');
INSERT INTO `system_area2` VALUES ('2282', '0001002100010001', '秀英区', '2281', '460105');
INSERT INTO `system_area2` VALUES ('2283', '0001002100010002', '龙华区', '2282', '460106');
INSERT INTO `system_area2` VALUES ('2284', '0001002100010003', '琼山区', '2283', '460107');
INSERT INTO `system_area2` VALUES ('2285', '0001002100010004', '美兰区', '2284', '460108');
INSERT INTO `system_area2` VALUES ('2286', '000100210002', '三亚市', '2285', '460200');
INSERT INTO `system_area2` VALUES ('2287', '000100210003', '五指山市', '2286', '469001');
INSERT INTO `system_area2` VALUES ('2288', '000100210004', '琼海市', '2287', '469002');
INSERT INTO `system_area2` VALUES ('2289', '000100210005', '儋州市', '2288', '469003');
INSERT INTO `system_area2` VALUES ('2290', '000100210006', '文昌市', '2289', '469005');
INSERT INTO `system_area2` VALUES ('2291', '000100210007', '万宁市', '2290', '469006');
INSERT INTO `system_area2` VALUES ('2292', '000100210008', '东方市', '2291', '469007');
INSERT INTO `system_area2` VALUES ('2293', '000100210009', '定安县', '2292', '469025');
INSERT INTO `system_area2` VALUES ('2294', '000100210010', '屯昌县', '2293', '469026');
INSERT INTO `system_area2` VALUES ('2295', '000100210011', '澄迈县', '2294', '469027');
INSERT INTO `system_area2` VALUES ('2296', '000100210012', '临高县', '2295', '469028');
INSERT INTO `system_area2` VALUES ('2297', '000100210013', '白沙黎族自治县', '2296', '469030');
INSERT INTO `system_area2` VALUES ('2298', '000100210014', '昌江黎族自治县', '2297', '469031');
INSERT INTO `system_area2` VALUES ('2299', '000100210015', '乐东黎族自治县', '2298', '469033');
INSERT INTO `system_area2` VALUES ('2300', '000100210016', '陵水黎族自治县', '2299', '469034');
INSERT INTO `system_area2` VALUES ('2301', '000100210017', '保亭黎族苗族自治县', '2300', '469035');
INSERT INTO `system_area2` VALUES ('2302', '000100210018', '琼中黎族苗族自治县', '2301', '469036');
INSERT INTO `system_area2` VALUES ('2303', '000100210019', '西沙群岛', '2302', '469037');
INSERT INTO `system_area2` VALUES ('2304', '000100210020', '南沙群岛', '2303', '469038');
INSERT INTO `system_area2` VALUES ('2305', '000100210021', '中沙群岛的岛礁及其海域', '2304', '469039');
INSERT INTO `system_area2` VALUES ('2306', '00010022', '重庆', '2305', '500000');
INSERT INTO `system_area2` VALUES ('2307', '000100220001', '重庆市', '2306', '500100');
INSERT INTO `system_area2` VALUES ('2308', '0001002200010001', '万州区', '2307', '500101');
INSERT INTO `system_area2` VALUES ('2309', '0001002200010002', '涪陵区', '2308', '500102');
INSERT INTO `system_area2` VALUES ('2310', '0001002200010003', '渝中区', '2309', '500103');
INSERT INTO `system_area2` VALUES ('2311', '0001002200010004', '大渡口区', '2310', '500104');
INSERT INTO `system_area2` VALUES ('2312', '0001002200010005', '江北区', '2311', '500105');
INSERT INTO `system_area2` VALUES ('2313', '0001002200010006', '沙坪坝区', '2312', '500106');
INSERT INTO `system_area2` VALUES ('2314', '0001002200010007', '九龙坡区', '2313', '500107');
INSERT INTO `system_area2` VALUES ('2315', '0001002200010008', '南岸区', '2314', '500108');
INSERT INTO `system_area2` VALUES ('2316', '0001002200010009', '北碚区', '2315', '500109');
INSERT INTO `system_area2` VALUES ('2317', '0001002200010010', '万盛区', '2316', '500110');
INSERT INTO `system_area2` VALUES ('2318', '0001002200010011', '双桥区', '2317', '500111');
INSERT INTO `system_area2` VALUES ('2319', '0001002200010012', '渝北区', '2318', '500112');
INSERT INTO `system_area2` VALUES ('2320', '0001002200010013', '巴南区', '2319', '500113');
INSERT INTO `system_area2` VALUES ('2321', '0001002200010014', '黔江区', '2320', '500114');
INSERT INTO `system_area2` VALUES ('2322', '0001002200010015', '长寿区', '2321', '500115');
INSERT INTO `system_area2` VALUES ('2323', '0001002200010016', '綦江县', '2322', '500222');
INSERT INTO `system_area2` VALUES ('2324', '0001002200010017', '潼南县', '2323', '500223');
INSERT INTO `system_area2` VALUES ('2325', '0001002200010018', '铜梁县', '2324', '500224');
INSERT INTO `system_area2` VALUES ('2326', '0001002200010019', '大足县', '2325', '500225');
INSERT INTO `system_area2` VALUES ('2327', '0001002200010020', '荣昌县', '2326', '500226');
INSERT INTO `system_area2` VALUES ('2328', '0001002200010021', '璧山县', '2327', '500227');
INSERT INTO `system_area2` VALUES ('2329', '0001002200010022', '梁平县', '2328', '500228');
INSERT INTO `system_area2` VALUES ('2330', '0001002200010023', '城口县', '2329', '500229');
INSERT INTO `system_area2` VALUES ('2331', '0001002200010024', '丰都县', '2330', '500230');
INSERT INTO `system_area2` VALUES ('2332', '0001002200010025', '垫江县', '2331', '500231');
INSERT INTO `system_area2` VALUES ('2333', '0001002200010026', '武隆县', '2332', '500232');
INSERT INTO `system_area2` VALUES ('2334', '0001002200010027', '忠县', '2333', '500233');
INSERT INTO `system_area2` VALUES ('2335', '0001002200010028', '开县', '2334', '500234');
INSERT INTO `system_area2` VALUES ('2336', '0001002200010029', '云阳县', '2335', '500235');
INSERT INTO `system_area2` VALUES ('2337', '0001002200010030', '奉节县', '2336', '500236');
INSERT INTO `system_area2` VALUES ('2338', '0001002200010031', '巫山县', '2337', '500237');
INSERT INTO `system_area2` VALUES ('2339', '0001002200010032', '巫溪县', '2338', '500238');
INSERT INTO `system_area2` VALUES ('2340', '0001002200010033', '石柱土家族自治县', '2339', '500240');
INSERT INTO `system_area2` VALUES ('2341', '0001002200010034', '秀山土家族苗族自治县', '2340', '500241');
INSERT INTO `system_area2` VALUES ('2342', '0001002200010035', '酉阳土家族苗族自治县', '2341', '500242');
INSERT INTO `system_area2` VALUES ('2343', '0001002200010036', '彭水苗族土家族自治县', '2342', '500243');
INSERT INTO `system_area2` VALUES ('2344', '0001002200010037', '江津区', '2343', '500381');
INSERT INTO `system_area2` VALUES ('2345', '0001002200010038', '合川区', '2344', '500382');
INSERT INTO `system_area2` VALUES ('2346', '0001002200010039', '永川区', '2345', '500383');
INSERT INTO `system_area2` VALUES ('2347', '0001002200010040', '南川区', '2346', '500384');
INSERT INTO `system_area2` VALUES ('2348', '00010023', '四川省', '2347', '510000');
INSERT INTO `system_area2` VALUES ('2349', '000100230001', '成都市', '2348', '510100');
INSERT INTO `system_area2` VALUES ('2350', '0001002300010001', '锦江区', '2349', '510104');
INSERT INTO `system_area2` VALUES ('2351', '0001002300010002', '青羊区', '2350', '510105');
INSERT INTO `system_area2` VALUES ('2352', '0001002300010003', '金牛区', '2351', '510106');
INSERT INTO `system_area2` VALUES ('2353', '0001002300010004', '武侯区', '2352', '510107');
INSERT INTO `system_area2` VALUES ('2354', '0001002300010005', '成华区', '2353', '510108');
INSERT INTO `system_area2` VALUES ('2355', '0001002300010006', '龙泉驿区', '2354', '510112');
INSERT INTO `system_area2` VALUES ('2356', '0001002300010007', '青白江区', '2355', '510113');
INSERT INTO `system_area2` VALUES ('2357', '0001002300010008', '新都区', '2356', '510114');
INSERT INTO `system_area2` VALUES ('2358', '0001002300010009', '温江区', '2357', '510115');
INSERT INTO `system_area2` VALUES ('2359', '0001002300010010', '金堂县', '2358', '510121');
INSERT INTO `system_area2` VALUES ('2360', '0001002300010011', '双流县', '2359', '510122');
INSERT INTO `system_area2` VALUES ('2361', '0001002300010012', '郫县', '2360', '510124');
INSERT INTO `system_area2` VALUES ('2362', '0001002300010013', '大邑县', '2361', '510129');
INSERT INTO `system_area2` VALUES ('2363', '0001002300010014', '蒲江县', '2362', '510131');
INSERT INTO `system_area2` VALUES ('2364', '0001002300010015', '新津县', '2363', '510132');
INSERT INTO `system_area2` VALUES ('2365', '0001002300010016', '都江堰市', '2364', '510181');
INSERT INTO `system_area2` VALUES ('2366', '0001002300010017', '彭州市', '2365', '510182');
INSERT INTO `system_area2` VALUES ('2367', '0001002300010018', '邛崃市', '2366', '510183');
INSERT INTO `system_area2` VALUES ('2368', '0001002300010019', '崇州市', '2367', '510184');
INSERT INTO `system_area2` VALUES ('2369', '000100230002', '自贡市', '2368', '510300');
INSERT INTO `system_area2` VALUES ('2370', '0001002300020001', '自流井区', '2369', '510302');
INSERT INTO `system_area2` VALUES ('2371', '0001002300020002', '贡井区', '2370', '510303');
INSERT INTO `system_area2` VALUES ('2372', '0001002300020003', '大安区', '2371', '510304');
INSERT INTO `system_area2` VALUES ('2373', '0001002300020004', '沿滩区', '2372', '510311');
INSERT INTO `system_area2` VALUES ('2374', '0001002300020005', '荣县', '2373', '510321');
INSERT INTO `system_area2` VALUES ('2375', '0001002300020006', '富顺县', '2374', '510322');
INSERT INTO `system_area2` VALUES ('2376', '000100230003', '攀枝花市', '2375', '510400');
INSERT INTO `system_area2` VALUES ('2377', '0001002300030001', '东区', '2376', '510402');
INSERT INTO `system_area2` VALUES ('2378', '0001002300030002', '西区', '2377', '510403');
INSERT INTO `system_area2` VALUES ('2379', '0001002300030003', '仁和区', '2378', '510411');
INSERT INTO `system_area2` VALUES ('2380', '0001002300030004', '米易县', '2379', '510421');
INSERT INTO `system_area2` VALUES ('2381', '0001002300030005', '盐边县', '2380', '510422');
INSERT INTO `system_area2` VALUES ('2382', '000100230004', '泸州市', '2381', '510500');
INSERT INTO `system_area2` VALUES ('2383', '0001002300040001', '江阳区', '2382', '510502');
INSERT INTO `system_area2` VALUES ('2384', '0001002300040002', '纳溪区', '2383', '510503');
INSERT INTO `system_area2` VALUES ('2385', '0001002300040003', '龙马潭区', '2384', '510504');
INSERT INTO `system_area2` VALUES ('2386', '0001002300040004', '泸县', '2385', '510521');
INSERT INTO `system_area2` VALUES ('2387', '0001002300040005', '合江县', '2386', '510522');
INSERT INTO `system_area2` VALUES ('2388', '0001002300040006', '叙永县', '2387', '510524');
INSERT INTO `system_area2` VALUES ('2389', '0001002300040007', '古蔺县', '2388', '510525');
INSERT INTO `system_area2` VALUES ('2390', '000100230005', '德阳市', '2389', '510600');
INSERT INTO `system_area2` VALUES ('2391', '0001002300050001', '旌阳区', '2390', '510603');
INSERT INTO `system_area2` VALUES ('2392', '0001002300050002', '中江县', '2391', '510623');
INSERT INTO `system_area2` VALUES ('2393', '0001002300050003', '罗江县', '2392', '510626');
INSERT INTO `system_area2` VALUES ('2394', '0001002300050004', '广汉市', '2393', '510681');
INSERT INTO `system_area2` VALUES ('2395', '0001002300050005', '什邡市', '2394', '510682');
INSERT INTO `system_area2` VALUES ('2396', '0001002300050006', '绵竹市', '2395', '510683');
INSERT INTO `system_area2` VALUES ('2397', '000100230006', '绵阳市', '2396', '510700');
INSERT INTO `system_area2` VALUES ('2398', '0001002300060001', '涪城区', '2397', '510703');
INSERT INTO `system_area2` VALUES ('2399', '0001002300060002', '游仙区', '2398', '510704');
INSERT INTO `system_area2` VALUES ('2400', '0001002300060003', '三台县', '2399', '510722');
INSERT INTO `system_area2` VALUES ('2401', '0001002300060004', '盐亭县', '2400', '510723');
INSERT INTO `system_area2` VALUES ('2402', '0001002300060005', '安县', '2401', '510724');
INSERT INTO `system_area2` VALUES ('2403', '0001002300060006', '梓潼县', '2402', '510725');
INSERT INTO `system_area2` VALUES ('2404', '0001002300060007', '北川羌族自治县', '2403', '510726');
INSERT INTO `system_area2` VALUES ('2405', '0001002300060008', '平武县', '2404', '510727');
INSERT INTO `system_area2` VALUES ('2406', '0001002300060009', '高新区', '2405', '510751');
INSERT INTO `system_area2` VALUES ('2407', '0001002300060010', '江油市', '2406', '510781');
INSERT INTO `system_area2` VALUES ('2408', '000100230007', '广元市', '2407', '510800');
INSERT INTO `system_area2` VALUES ('2409', '0001002300070001', '利州区', '2408', '510802');
INSERT INTO `system_area2` VALUES ('2410', '0001002300070002', '元坝区', '2409', '510811');
INSERT INTO `system_area2` VALUES ('2411', '0001002300070003', '朝天区', '2410', '510812');
INSERT INTO `system_area2` VALUES ('2412', '0001002300070004', '旺苍县', '2411', '510821');
INSERT INTO `system_area2` VALUES ('2413', '0001002300070005', '青川县', '2412', '510822');
INSERT INTO `system_area2` VALUES ('2414', '0001002300070006', '剑阁县', '2413', '510823');
INSERT INTO `system_area2` VALUES ('2415', '0001002300070007', '苍溪县', '2414', '510824');
INSERT INTO `system_area2` VALUES ('2416', '000100230008', '遂宁市', '2415', '510900');
INSERT INTO `system_area2` VALUES ('2417', '0001002300080001', '船山区', '2416', '510903');
INSERT INTO `system_area2` VALUES ('2418', '0001002300080002', '安居区', '2417', '510904');
INSERT INTO `system_area2` VALUES ('2419', '0001002300080003', '蓬溪县', '2418', '510921');
INSERT INTO `system_area2` VALUES ('2420', '0001002300080004', '射洪县', '2419', '510922');
INSERT INTO `system_area2` VALUES ('2421', '0001002300080005', '大英县', '2420', '510923');
INSERT INTO `system_area2` VALUES ('2422', '000100230009', '内江市', '2421', '511000');
INSERT INTO `system_area2` VALUES ('2423', '0001002300090001', '市中区', '2422', '511002');
INSERT INTO `system_area2` VALUES ('2424', '0001002300090002', '东兴区', '2423', '511011');
INSERT INTO `system_area2` VALUES ('2425', '0001002300090003', '威远县', '2424', '511024');
INSERT INTO `system_area2` VALUES ('2426', '0001002300090004', '资中县', '2425', '511025');
INSERT INTO `system_area2` VALUES ('2427', '0001002300090005', '隆昌县', '2426', '511028');
INSERT INTO `system_area2` VALUES ('2428', '000100230010', '乐山市', '2427', '511100');
INSERT INTO `system_area2` VALUES ('2429', '0001002300100001', '市中区', '2428', '511102');
INSERT INTO `system_area2` VALUES ('2430', '0001002300100002', '沙湾区', '2429', '511111');
INSERT INTO `system_area2` VALUES ('2431', '0001002300100003', '五通桥区', '2430', '511112');
INSERT INTO `system_area2` VALUES ('2432', '0001002300100004', '金口河区', '2431', '511113');
INSERT INTO `system_area2` VALUES ('2433', '0001002300100005', '犍为县', '2432', '511123');
INSERT INTO `system_area2` VALUES ('2434', '0001002300100006', '井研县', '2433', '511124');
INSERT INTO `system_area2` VALUES ('2435', '0001002300100007', '夹江县', '2434', '511126');
INSERT INTO `system_area2` VALUES ('2436', '0001002300100008', '沐川县', '2435', '511129');
INSERT INTO `system_area2` VALUES ('2437', '0001002300100009', '峨边彝族自治县', '2436', '511132');
INSERT INTO `system_area2` VALUES ('2438', '0001002300100010', '马边彝族自治县', '2437', '511133');
INSERT INTO `system_area2` VALUES ('2439', '0001002300100011', '峨眉山市', '2438', '511181');
INSERT INTO `system_area2` VALUES ('2440', '000100230011', '南充市', '2439', '511300');
INSERT INTO `system_area2` VALUES ('2441', '0001002300110001', '顺庆区', '2440', '511302');
INSERT INTO `system_area2` VALUES ('2442', '0001002300110002', '高坪区', '2441', '511303');
INSERT INTO `system_area2` VALUES ('2443', '0001002300110003', '嘉陵区', '2442', '511304');
INSERT INTO `system_area2` VALUES ('2444', '0001002300110004', '南部县', '2443', '511321');
INSERT INTO `system_area2` VALUES ('2445', '0001002300110005', '营山县', '2444', '511322');
INSERT INTO `system_area2` VALUES ('2446', '0001002300110006', '蓬安县', '2445', '511323');
INSERT INTO `system_area2` VALUES ('2447', '0001002300110007', '仪陇县', '2446', '511324');
INSERT INTO `system_area2` VALUES ('2448', '0001002300110008', '西充县', '2447', '511325');
INSERT INTO `system_area2` VALUES ('2449', '0001002300110009', '阆中市', '2448', '511381');
INSERT INTO `system_area2` VALUES ('2450', '000100230012', '眉山市', '2449', '511400');
INSERT INTO `system_area2` VALUES ('2451', '0001002300120001', '东坡区', '2450', '511402');
INSERT INTO `system_area2` VALUES ('2452', '0001002300120002', '仁寿县', '2451', '511421');
INSERT INTO `system_area2` VALUES ('2453', '0001002300120003', '彭山县', '2452', '511422');
INSERT INTO `system_area2` VALUES ('2454', '0001002300120004', '洪雅县', '2453', '511423');
INSERT INTO `system_area2` VALUES ('2455', '0001002300120005', '丹棱县', '2454', '511424');
INSERT INTO `system_area2` VALUES ('2456', '0001002300120006', '青神县', '2455', '511425');
INSERT INTO `system_area2` VALUES ('2457', '000100230013', '宜宾市', '2456', '511500');
INSERT INTO `system_area2` VALUES ('2458', '0001002300130001', '翠屏区', '2457', '511502');
INSERT INTO `system_area2` VALUES ('2459', '0001002300130002', '宜宾县', '2458', '511521');
INSERT INTO `system_area2` VALUES ('2460', '0001002300130003', '南溪县', '2459', '511522');
INSERT INTO `system_area2` VALUES ('2461', '0001002300130004', '江安县', '2460', '511523');
INSERT INTO `system_area2` VALUES ('2462', '0001002300130005', '长宁县', '2461', '511524');
INSERT INTO `system_area2` VALUES ('2463', '0001002300130006', '高县', '2462', '511525');
INSERT INTO `system_area2` VALUES ('2464', '0001002300130007', '珙县', '2463', '511526');
INSERT INTO `system_area2` VALUES ('2465', '0001002300130008', '筠连县', '2464', '511527');
INSERT INTO `system_area2` VALUES ('2466', '0001002300130009', '兴文县', '2465', '511528');
INSERT INTO `system_area2` VALUES ('2467', '0001002300130010', '屏山县', '2466', '511529');
INSERT INTO `system_area2` VALUES ('2468', '000100230014', '广安市', '2467', '511600');
INSERT INTO `system_area2` VALUES ('2469', '0001002300140001', '广安区', '2468', '511602');
INSERT INTO `system_area2` VALUES ('2470', '0001002300140002', '岳池县', '2469', '511621');
INSERT INTO `system_area2` VALUES ('2471', '0001002300140003', '武胜县', '2470', '511622');
INSERT INTO `system_area2` VALUES ('2472', '0001002300140004', '邻水县', '2471', '511623');
INSERT INTO `system_area2` VALUES ('2473', '0001002300140005', '华蓥市', '2472', '511681');
INSERT INTO `system_area2` VALUES ('2474', '0001002300140006', '市辖区', '2473', '511682');
INSERT INTO `system_area2` VALUES ('2475', '000100230015', '达州市', '2474', '511700');
INSERT INTO `system_area2` VALUES ('2476', '0001002300150001', '通川区', '2475', '511702');
INSERT INTO `system_area2` VALUES ('2477', '0001002300150002', '达县', '2476', '511721');
INSERT INTO `system_area2` VALUES ('2478', '0001002300150003', '宣汉县', '2477', '511722');
INSERT INTO `system_area2` VALUES ('2479', '0001002300150004', '开江县', '2478', '511723');
INSERT INTO `system_area2` VALUES ('2480', '0001002300150005', '大竹县', '2479', '511724');
INSERT INTO `system_area2` VALUES ('2481', '0001002300150006', '渠县', '2480', '511725');
INSERT INTO `system_area2` VALUES ('2482', '0001002300150007', '万源市', '2481', '511781');
INSERT INTO `system_area2` VALUES ('2483', '000100230016', '雅安市', '2482', '511800');
INSERT INTO `system_area2` VALUES ('2484', '0001002300160001', '雨城区', '2483', '511802');
INSERT INTO `system_area2` VALUES ('2485', '0001002300160002', '名山县', '2484', '511821');
INSERT INTO `system_area2` VALUES ('2486', '0001002300160003', '荥经县', '2485', '511822');
INSERT INTO `system_area2` VALUES ('2487', '0001002300160004', '汉源县', '2486', '511823');
INSERT INTO `system_area2` VALUES ('2488', '0001002300160005', '石棉县', '2487', '511824');
INSERT INTO `system_area2` VALUES ('2489', '0001002300160006', '天全县', '2488', '511825');
INSERT INTO `system_area2` VALUES ('2490', '0001002300160007', '芦山县', '2489', '511826');
INSERT INTO `system_area2` VALUES ('2491', '0001002300160008', '宝兴县', '2490', '511827');
INSERT INTO `system_area2` VALUES ('2492', '000100230017', '巴中市', '2491', '511900');
INSERT INTO `system_area2` VALUES ('2493', '0001002300170001', '巴州区', '2492', '511902');
INSERT INTO `system_area2` VALUES ('2494', '0001002300170002', '通江县', '2493', '511921');
INSERT INTO `system_area2` VALUES ('2495', '0001002300170003', '南江县', '2494', '511922');
INSERT INTO `system_area2` VALUES ('2496', '0001002300170004', '平昌县', '2495', '511923');
INSERT INTO `system_area2` VALUES ('2497', '000100230018', '资阳市', '2496', '512000');
INSERT INTO `system_area2` VALUES ('2498', '0001002300180001', '雁江区', '2497', '512002');
INSERT INTO `system_area2` VALUES ('2499', '0001002300180002', '安岳县', '2498', '512021');
INSERT INTO `system_area2` VALUES ('2500', '0001002300180003', '乐至县', '2499', '512022');
INSERT INTO `system_area2` VALUES ('2501', '0001002300180004', '简阳市', '2500', '512081');
INSERT INTO `system_area2` VALUES ('2502', '000100230019', '阿坝藏族羌族自治州', '2501', '513200');
INSERT INTO `system_area2` VALUES ('2503', '0001002300190001', '汶川县', '2502', '513221');
INSERT INTO `system_area2` VALUES ('2504', '0001002300190002', '理县', '2503', '513222');
INSERT INTO `system_area2` VALUES ('2505', '0001002300190003', '茂县', '2504', '513223');
INSERT INTO `system_area2` VALUES ('2506', '0001002300190004', '松潘县', '2505', '513224');
INSERT INTO `system_area2` VALUES ('2507', '0001002300190005', '九寨沟县', '2506', '513225');
INSERT INTO `system_area2` VALUES ('2508', '0001002300190006', '金川县', '2507', '513226');
INSERT INTO `system_area2` VALUES ('2509', '0001002300190007', '小金县', '2508', '513227');
INSERT INTO `system_area2` VALUES ('2510', '0001002300190008', '黑水县', '2509', '513228');
INSERT INTO `system_area2` VALUES ('2511', '0001002300190009', '马尔康县', '2510', '513229');
INSERT INTO `system_area2` VALUES ('2512', '0001002300190010', '壤塘县', '2511', '513230');
INSERT INTO `system_area2` VALUES ('2513', '0001002300190011', '阿坝县', '2512', '513231');
INSERT INTO `system_area2` VALUES ('2514', '0001002300190012', '若尔盖县', '2513', '513232');
INSERT INTO `system_area2` VALUES ('2515', '0001002300190013', '红原县', '2514', '513233');
INSERT INTO `system_area2` VALUES ('2516', '000100230020', '甘孜藏族自治州', '2515', '513300');
INSERT INTO `system_area2` VALUES ('2517', '0001002300200001', '康定县', '2516', '513321');
INSERT INTO `system_area2` VALUES ('2518', '0001002300200002', '泸定县', '2517', '513322');
INSERT INTO `system_area2` VALUES ('2519', '0001002300200003', '丹巴县', '2518', '513323');
INSERT INTO `system_area2` VALUES ('2520', '0001002300200004', '九龙县', '2519', '513324');
INSERT INTO `system_area2` VALUES ('2521', '0001002300200005', '雅江县', '2520', '513325');
INSERT INTO `system_area2` VALUES ('2522', '0001002300200006', '道孚县', '2521', '513326');
INSERT INTO `system_area2` VALUES ('2523', '0001002300200007', '炉霍县', '2522', '513327');
INSERT INTO `system_area2` VALUES ('2524', '0001002300200008', '甘孜县', '2523', '513328');
INSERT INTO `system_area2` VALUES ('2525', '0001002300200009', '新龙县', '2524', '513329');
INSERT INTO `system_area2` VALUES ('2526', '0001002300200010', '德格县', '2525', '513330');
INSERT INTO `system_area2` VALUES ('2527', '0001002300200011', '白玉县', '2526', '513331');
INSERT INTO `system_area2` VALUES ('2528', '0001002300200012', '石渠县', '2527', '513332');
INSERT INTO `system_area2` VALUES ('2529', '0001002300200013', '色达县', '2528', '513333');
INSERT INTO `system_area2` VALUES ('2530', '0001002300200014', '理塘县', '2529', '513334');
INSERT INTO `system_area2` VALUES ('2531', '0001002300200015', '巴塘县', '2530', '513335');
INSERT INTO `system_area2` VALUES ('2532', '0001002300200016', '乡城县', '2531', '513336');
INSERT INTO `system_area2` VALUES ('2533', '0001002300200017', '稻城县', '2532', '513337');
INSERT INTO `system_area2` VALUES ('2534', '0001002300200018', '得荣县', '2533', '513338');
INSERT INTO `system_area2` VALUES ('2535', '000100230021', '凉山彝族自治州', '2534', '513400');
INSERT INTO `system_area2` VALUES ('2536', '0001002300210001', '西昌市', '2535', '513401');
INSERT INTO `system_area2` VALUES ('2537', '0001002300210002', '木里藏族自治县', '2536', '513422');
INSERT INTO `system_area2` VALUES ('2538', '0001002300210003', '盐源县', '2537', '513423');
INSERT INTO `system_area2` VALUES ('2539', '0001002300210004', '德昌县', '2538', '513424');
INSERT INTO `system_area2` VALUES ('2540', '0001002300210005', '会理县', '2539', '513425');
INSERT INTO `system_area2` VALUES ('2541', '0001002300210006', '会东县', '2540', '513426');
INSERT INTO `system_area2` VALUES ('2542', '0001002300210007', '宁南县', '2541', '513427');
INSERT INTO `system_area2` VALUES ('2543', '0001002300210008', '普格县', '2542', '513428');
INSERT INTO `system_area2` VALUES ('2544', '0001002300210009', '布拖县', '2543', '513429');
INSERT INTO `system_area2` VALUES ('2545', '0001002300210010', '金阳县', '2544', '513430');
INSERT INTO `system_area2` VALUES ('2546', '0001002300210011', '昭觉县', '2545', '513431');
INSERT INTO `system_area2` VALUES ('2547', '0001002300210012', '喜德县', '2546', '513432');
INSERT INTO `system_area2` VALUES ('2548', '0001002300210013', '冕宁县', '2547', '513433');
INSERT INTO `system_area2` VALUES ('2549', '0001002300210014', '越西县', '2548', '513434');
INSERT INTO `system_area2` VALUES ('2550', '0001002300210015', '甘洛县', '2549', '513435');
INSERT INTO `system_area2` VALUES ('2551', '0001002300210016', '美姑县', '2550', '513436');
INSERT INTO `system_area2` VALUES ('2552', '0001002300210017', '雷波县', '2551', '513437');
INSERT INTO `system_area2` VALUES ('2553', '00010024', '贵州省', '2552', '520000');
INSERT INTO `system_area2` VALUES ('2554', '000100240001', '贵阳市', '2553', '520100');
INSERT INTO `system_area2` VALUES ('2555', '0001002400010001', '南明区', '2554', '520102');
INSERT INTO `system_area2` VALUES ('2556', '0001002400010002', '云岩区', '2555', '520103');
INSERT INTO `system_area2` VALUES ('2557', '0001002400010003', '花溪区', '2556', '520111');
INSERT INTO `system_area2` VALUES ('2558', '0001002400010004', '乌当区', '2557', '520112');
INSERT INTO `system_area2` VALUES ('2559', '0001002400010005', '白云区', '2558', '520113');
INSERT INTO `system_area2` VALUES ('2560', '0001002400010006', '小河区', '2559', '520114');
INSERT INTO `system_area2` VALUES ('2561', '0001002400010007', '开阳县', '2560', '520121');
INSERT INTO `system_area2` VALUES ('2562', '0001002400010008', '息烽县', '2561', '520122');
INSERT INTO `system_area2` VALUES ('2563', '0001002400010009', '修文县', '2562', '520123');
INSERT INTO `system_area2` VALUES ('2564', '0001002400010010', '金阳开发区', '2563', '520151');
INSERT INTO `system_area2` VALUES ('2565', '0001002400010011', '清镇市', '2564', '520181');
INSERT INTO `system_area2` VALUES ('2566', '000100240002', '六盘水市', '2565', '520200');
INSERT INTO `system_area2` VALUES ('2567', '0001002400020001', '钟山区', '2566', '520201');
INSERT INTO `system_area2` VALUES ('2568', '0001002400020002', '六枝特区', '2567', '520203');
INSERT INTO `system_area2` VALUES ('2569', '0001002400020003', '水城县', '2568', '520221');
INSERT INTO `system_area2` VALUES ('2570', '0001002400020004', '盘县', '2569', '520222');
INSERT INTO `system_area2` VALUES ('2571', '000100240003', '遵义市', '2570', '520300');
INSERT INTO `system_area2` VALUES ('2572', '0001002400030001', '红花岗区', '2571', '520302');
INSERT INTO `system_area2` VALUES ('2573', '0001002400030002', '汇川区', '2572', '520303');
INSERT INTO `system_area2` VALUES ('2574', '0001002400030003', '遵义县', '2573', '520321');
INSERT INTO `system_area2` VALUES ('2575', '0001002400030004', '桐梓县', '2574', '520322');
INSERT INTO `system_area2` VALUES ('2576', '0001002400030005', '绥阳县', '2575', '520323');
INSERT INTO `system_area2` VALUES ('2577', '0001002400030006', '正安县', '2576', '520324');
INSERT INTO `system_area2` VALUES ('2578', '0001002400030007', '道真仡佬族苗族自治县', '2577', '520325');
INSERT INTO `system_area2` VALUES ('2579', '0001002400030008', '务川仡佬族苗族自治县', '2578', '520326');
INSERT INTO `system_area2` VALUES ('2580', '0001002400030009', '凤冈县', '2579', '520327');
INSERT INTO `system_area2` VALUES ('2581', '0001002400030010', '湄潭县', '2580', '520328');
INSERT INTO `system_area2` VALUES ('2582', '0001002400030011', '余庆县', '2581', '520329');
INSERT INTO `system_area2` VALUES ('2583', '0001002400030012', '习水县', '2582', '520330');
INSERT INTO `system_area2` VALUES ('2584', '0001002400030013', '赤水市', '2583', '520381');
INSERT INTO `system_area2` VALUES ('2585', '0001002400030014', '仁怀市', '2584', '520382');
INSERT INTO `system_area2` VALUES ('2586', '000100240004', '安顺市', '2585', '520400');
INSERT INTO `system_area2` VALUES ('2587', '0001002400040001', '西秀区', '2586', '520402');
INSERT INTO `system_area2` VALUES ('2588', '0001002400040002', '平坝县', '2587', '520421');
INSERT INTO `system_area2` VALUES ('2589', '0001002400040003', '普定县', '2588', '520422');
INSERT INTO `system_area2` VALUES ('2590', '0001002400040004', '镇宁布依族苗族自治县', '2589', '520423');
INSERT INTO `system_area2` VALUES ('2591', '0001002400040005', '关岭布依族苗族自治县', '2590', '520424');
INSERT INTO `system_area2` VALUES ('2592', '0001002400040006', '紫云苗族布依族自治县', '2591', '520425');
INSERT INTO `system_area2` VALUES ('2593', '000100240005', '铜仁地区', '2592', '522200');
INSERT INTO `system_area2` VALUES ('2594', '0001002400050001', '铜仁市', '2593', '522201');
INSERT INTO `system_area2` VALUES ('2595', '0001002400050002', '江口县', '2594', '522222');
INSERT INTO `system_area2` VALUES ('2596', '0001002400050003', '玉屏侗族自治县', '2595', '522223');
INSERT INTO `system_area2` VALUES ('2597', '0001002400050004', '石阡县', '2596', '522224');
INSERT INTO `system_area2` VALUES ('2598', '0001002400050005', '思南县', '2597', '522225');
INSERT INTO `system_area2` VALUES ('2599', '0001002400050006', '印江土家族苗族自治县', '2598', '522226');
INSERT INTO `system_area2` VALUES ('2600', '0001002400050007', '德江县', '2599', '522227');
INSERT INTO `system_area2` VALUES ('2601', '0001002400050008', '沿河土家族自治县', '2600', '522228');
INSERT INTO `system_area2` VALUES ('2602', '0001002400050009', '松桃苗族自治县', '2601', '522229');
INSERT INTO `system_area2` VALUES ('2603', '0001002400050010', '万山特区', '2602', '522230');
INSERT INTO `system_area2` VALUES ('2604', '000100240006', '黔西南布依族苗族自治州', '2603', '522300');
INSERT INTO `system_area2` VALUES ('2605', '0001002400060001', '兴义市', '2604', '522301');
INSERT INTO `system_area2` VALUES ('2606', '0001002400060002', '兴仁县', '2605', '522322');
INSERT INTO `system_area2` VALUES ('2607', '0001002400060003', '普安县', '2606', '522323');
INSERT INTO `system_area2` VALUES ('2608', '0001002400060004', '晴隆县', '2607', '522324');
INSERT INTO `system_area2` VALUES ('2609', '0001002400060005', '贞丰县', '2608', '522325');
INSERT INTO `system_area2` VALUES ('2610', '0001002400060006', '望谟县', '2609', '522326');
INSERT INTO `system_area2` VALUES ('2611', '0001002400060007', '册亨县', '2610', '522327');
INSERT INTO `system_area2` VALUES ('2612', '0001002400060008', '安龙县', '2611', '522328');
INSERT INTO `system_area2` VALUES ('2613', '000100240007', '毕节地区', '2612', '522400');
INSERT INTO `system_area2` VALUES ('2614', '0001002400070001', '毕节市', '2613', '522401');
INSERT INTO `system_area2` VALUES ('2615', '0001002400070002', '大方县', '2614', '522422');
INSERT INTO `system_area2` VALUES ('2616', '0001002400070003', '黔西县', '2615', '522423');
INSERT INTO `system_area2` VALUES ('2617', '0001002400070004', '金沙县', '2616', '522424');
INSERT INTO `system_area2` VALUES ('2618', '0001002400070005', '织金县', '2617', '522425');
INSERT INTO `system_area2` VALUES ('2619', '0001002400070006', '纳雍县', '2618', '522426');
INSERT INTO `system_area2` VALUES ('2620', '0001002400070007', '威宁彝族回族苗族自治县', '2619', '522427');
INSERT INTO `system_area2` VALUES ('2621', '0001002400070008', '赫章县', '2620', '522428');
INSERT INTO `system_area2` VALUES ('2622', '000100240008', '黔东南苗族侗族自治州', '2621', '522600');
INSERT INTO `system_area2` VALUES ('2623', '0001002400080001', '凯里市', '2622', '522601');
INSERT INTO `system_area2` VALUES ('2624', '0001002400080002', '黄平县', '2623', '522622');
INSERT INTO `system_area2` VALUES ('2625', '0001002400080003', '施秉县', '2624', '522623');
INSERT INTO `system_area2` VALUES ('2626', '0001002400080004', '三穗县', '2625', '522624');
INSERT INTO `system_area2` VALUES ('2627', '0001002400080005', '镇远县', '2626', '522625');
INSERT INTO `system_area2` VALUES ('2628', '0001002400080006', '岑巩县', '2627', '522626');
INSERT INTO `system_area2` VALUES ('2629', '0001002400080007', '天柱县', '2628', '522627');
INSERT INTO `system_area2` VALUES ('2630', '0001002400080008', '锦屏县', '2629', '522628');
INSERT INTO `system_area2` VALUES ('2631', '0001002400080009', '剑河县', '2630', '522629');
INSERT INTO `system_area2` VALUES ('2632', '0001002400080010', '台江县', '2631', '522630');
INSERT INTO `system_area2` VALUES ('2633', '0001002400080011', '黎平县', '2632', '522631');
INSERT INTO `system_area2` VALUES ('2634', '0001002400080012', '榕江县', '2633', '522632');
INSERT INTO `system_area2` VALUES ('2635', '0001002400080013', '从江县', '2634', '522633');
INSERT INTO `system_area2` VALUES ('2636', '0001002400080014', '雷山县', '2635', '522634');
INSERT INTO `system_area2` VALUES ('2637', '0001002400080015', '麻江县', '2636', '522635');
INSERT INTO `system_area2` VALUES ('2638', '0001002400080016', '丹寨县', '2637', '522636');
INSERT INTO `system_area2` VALUES ('2639', '000100240009', '黔南布依族苗族自治州', '2638', '522700');
INSERT INTO `system_area2` VALUES ('2640', '0001002400090001', '都匀市', '2639', '522701');
INSERT INTO `system_area2` VALUES ('2641', '0001002400090002', '福泉市', '2640', '522702');
INSERT INTO `system_area2` VALUES ('2642', '0001002400090003', '荔波县', '2641', '522722');
INSERT INTO `system_area2` VALUES ('2643', '0001002400090004', '贵定县', '2642', '522723');
INSERT INTO `system_area2` VALUES ('2644', '0001002400090005', '瓮安县', '2643', '522725');
INSERT INTO `system_area2` VALUES ('2645', '0001002400090006', '独山县', '2644', '522726');
INSERT INTO `system_area2` VALUES ('2646', '0001002400090007', '平塘县', '2645', '522727');
INSERT INTO `system_area2` VALUES ('2647', '0001002400090008', '罗甸县', '2646', '522728');
INSERT INTO `system_area2` VALUES ('2648', '0001002400090009', '长顺县', '2647', '522729');
INSERT INTO `system_area2` VALUES ('2649', '0001002400090010', '龙里县', '2648', '522730');
INSERT INTO `system_area2` VALUES ('2650', '0001002400090011', '惠水县', '2649', '522731');
INSERT INTO `system_area2` VALUES ('2651', '0001002400090012', '三都水族自治县', '2650', '522732');
INSERT INTO `system_area2` VALUES ('2652', '00010025', '云南省', '2651', '530000');
INSERT INTO `system_area2` VALUES ('2653', '000100250001', '昆明市', '2652', '530100');
INSERT INTO `system_area2` VALUES ('2654', '0001002500010001', '五华区', '2653', '530102');
INSERT INTO `system_area2` VALUES ('2655', '0001002500010002', '盘龙区', '2654', '530103');
INSERT INTO `system_area2` VALUES ('2656', '0001002500010003', '官渡区', '2655', '530111');
INSERT INTO `system_area2` VALUES ('2657', '0001002500010004', '西山区', '2656', '530112');
INSERT INTO `system_area2` VALUES ('2658', '0001002500010005', '东川区', '2657', '530113');
INSERT INTO `system_area2` VALUES ('2659', '0001002500010006', '呈贡县', '2658', '530121');
INSERT INTO `system_area2` VALUES ('2660', '0001002500010007', '晋宁县', '2659', '530122');
INSERT INTO `system_area2` VALUES ('2661', '0001002500010008', '富民县', '2660', '530124');
INSERT INTO `system_area2` VALUES ('2662', '0001002500010009', '宜良县', '2661', '530125');
INSERT INTO `system_area2` VALUES ('2663', '0001002500010010', '石林彝族自治县', '2662', '530126');
INSERT INTO `system_area2` VALUES ('2664', '0001002500010011', '嵩明县', '2663', '530127');
INSERT INTO `system_area2` VALUES ('2665', '0001002500010012', '禄劝彝族苗族自治县', '2664', '530128');
INSERT INTO `system_area2` VALUES ('2666', '0001002500010013', '寻甸回族彝族自治县', '2665', '530129');
INSERT INTO `system_area2` VALUES ('2667', '0001002500010014', '安宁市', '2666', '530181');
INSERT INTO `system_area2` VALUES ('2668', '000100250002', '曲靖市', '2667', '530300');
INSERT INTO `system_area2` VALUES ('2669', '0001002500020001', '麒麟区', '2668', '530302');
INSERT INTO `system_area2` VALUES ('2670', '0001002500020002', '马龙县', '2669', '530321');
INSERT INTO `system_area2` VALUES ('2671', '0001002500020003', '陆良县', '2670', '530322');
INSERT INTO `system_area2` VALUES ('2672', '0001002500020004', '师宗县', '2671', '530323');
INSERT INTO `system_area2` VALUES ('2673', '0001002500020005', '罗平县', '2672', '530324');
INSERT INTO `system_area2` VALUES ('2674', '0001002500020006', '富源县', '2673', '530325');
INSERT INTO `system_area2` VALUES ('2675', '0001002500020007', '会泽县', '2674', '530326');
INSERT INTO `system_area2` VALUES ('2676', '0001002500020008', '沾益县', '2675', '530328');
INSERT INTO `system_area2` VALUES ('2677', '0001002500020009', '宣威市', '2676', '530381');
INSERT INTO `system_area2` VALUES ('2678', '000100250003', '玉溪市', '2677', '530400');
INSERT INTO `system_area2` VALUES ('2679', '0001002500030001', '红塔区', '2678', '530402');
INSERT INTO `system_area2` VALUES ('2680', '0001002500030002', '江川县', '2679', '530421');
INSERT INTO `system_area2` VALUES ('2681', '0001002500030003', '澄江县', '2680', '530422');
INSERT INTO `system_area2` VALUES ('2682', '0001002500030004', '通海县', '2681', '530423');
INSERT INTO `system_area2` VALUES ('2683', '0001002500030005', '华宁县', '2682', '530424');
INSERT INTO `system_area2` VALUES ('2684', '0001002500030006', '易门县', '2683', '530425');
INSERT INTO `system_area2` VALUES ('2685', '0001002500030007', '峨山彝族自治县', '2684', '530426');
INSERT INTO `system_area2` VALUES ('2686', '0001002500030008', '新平彝族傣族自治县', '2685', '530427');
INSERT INTO `system_area2` VALUES ('2687', '0001002500030009', '元江哈尼族彝族傣族自治县', '2686', '530428');
INSERT INTO `system_area2` VALUES ('2688', '000100250004', '保山市', '2687', '530500');
INSERT INTO `system_area2` VALUES ('2689', '0001002500040001', '隆阳区', '2688', '530502');
INSERT INTO `system_area2` VALUES ('2690', '0001002500040002', '施甸县', '2689', '530521');
INSERT INTO `system_area2` VALUES ('2691', '0001002500040003', '腾冲县', '2690', '530522');
INSERT INTO `system_area2` VALUES ('2692', '0001002500040004', '龙陵县', '2691', '530523');
INSERT INTO `system_area2` VALUES ('2693', '0001002500040005', '昌宁县', '2692', '530524');
INSERT INTO `system_area2` VALUES ('2694', '000100250005', '昭通市', '2693', '530600');
INSERT INTO `system_area2` VALUES ('2695', '0001002500050001', '昭阳区', '2694', '530602');
INSERT INTO `system_area2` VALUES ('2696', '0001002500050002', '鲁甸县', '2695', '530621');
INSERT INTO `system_area2` VALUES ('2697', '0001002500050003', '巧家县', '2696', '530622');
INSERT INTO `system_area2` VALUES ('2698', '0001002500050004', '盐津县', '2697', '530623');
INSERT INTO `system_area2` VALUES ('2699', '0001002500050005', '大关县', '2698', '530624');
INSERT INTO `system_area2` VALUES ('2700', '0001002500050006', '永善县', '2699', '530625');
INSERT INTO `system_area2` VALUES ('2701', '0001002500050007', '绥江县', '2700', '530626');
INSERT INTO `system_area2` VALUES ('2702', '0001002500050008', '镇雄县', '2701', '530627');
INSERT INTO `system_area2` VALUES ('2703', '0001002500050009', '彝良县', '2702', '530628');
INSERT INTO `system_area2` VALUES ('2704', '0001002500050010', '威信县', '2703', '530629');
INSERT INTO `system_area2` VALUES ('2705', '0001002500050011', '水富县', '2704', '530630');
INSERT INTO `system_area2` VALUES ('2706', '000100250006', '丽江市', '2705', '530700');
INSERT INTO `system_area2` VALUES ('2707', '0001002500060001', '古城区', '2706', '530702');
INSERT INTO `system_area2` VALUES ('2708', '0001002500060002', '玉龙纳西族自治县', '2707', '530721');
INSERT INTO `system_area2` VALUES ('2709', '0001002500060003', '永胜县', '2708', '530722');
INSERT INTO `system_area2` VALUES ('2710', '0001002500060004', '华坪县', '2709', '530723');
INSERT INTO `system_area2` VALUES ('2711', '0001002500060005', '宁蒗彝族自治县', '2710', '530724');
INSERT INTO `system_area2` VALUES ('2712', '000100250007', '普洱市', '2711', '530800');
INSERT INTO `system_area2` VALUES ('2713', '0001002500070001', '思茅区', '2712', '530802');
INSERT INTO `system_area2` VALUES ('2714', '0001002500070002', '宁洱哈尼族彝族自治县', '2713', '530821');
INSERT INTO `system_area2` VALUES ('2715', '0001002500070003', '墨江哈尼族自治县', '2714', '530822');
INSERT INTO `system_area2` VALUES ('2716', '0001002500070004', '景东彝族自治县', '2715', '530823');
INSERT INTO `system_area2` VALUES ('2717', '0001002500070005', '景谷傣族彝族自治县', '2716', '530824');
INSERT INTO `system_area2` VALUES ('2718', '0001002500070006', '镇沅彝族哈尼族拉祜族自治县', '2717', '530825');
INSERT INTO `system_area2` VALUES ('2719', '0001002500070007', '江城哈尼族彝族自治县', '2718', '530826');
INSERT INTO `system_area2` VALUES ('2720', '0001002500070008', '孟连傣族拉祜族佤族自治县', '2719', '530827');
INSERT INTO `system_area2` VALUES ('2721', '0001002500070009', '澜沧拉祜族自治县', '2720', '530828');
INSERT INTO `system_area2` VALUES ('2722', '0001002500070010', '西盟佤族自治县', '2721', '530829');
INSERT INTO `system_area2` VALUES ('2723', '000100250008', '临沧市', '2722', '530900');
INSERT INTO `system_area2` VALUES ('2724', '0001002500080001', '临翔区', '2723', '530902');
INSERT INTO `system_area2` VALUES ('2725', '0001002500080002', '凤庆县', '2724', '530921');
INSERT INTO `system_area2` VALUES ('2726', '0001002500080003', '云县', '2725', '530922');
INSERT INTO `system_area2` VALUES ('2727', '0001002500080004', '永德县', '2726', '530923');
INSERT INTO `system_area2` VALUES ('2728', '0001002500080005', '镇康县', '2727', '530924');
INSERT INTO `system_area2` VALUES ('2729', '0001002500080006', '双江拉祜族佤族布朗族傣族自治县', '2728', '530925');
INSERT INTO `system_area2` VALUES ('2730', '0001002500080007', '耿马傣族佤族自治县', '2729', '530926');
INSERT INTO `system_area2` VALUES ('2731', '0001002500080008', '沧源佤族自治县', '2730', '530927');
INSERT INTO `system_area2` VALUES ('2732', '000100250009', '楚雄彝族自治州', '2731', '532300');
INSERT INTO `system_area2` VALUES ('2733', '0001002500090001', '楚雄市', '2732', '532301');
INSERT INTO `system_area2` VALUES ('2734', '0001002500090002', '双柏县', '2733', '532322');
INSERT INTO `system_area2` VALUES ('2735', '0001002500090003', '牟定县', '2734', '532323');
INSERT INTO `system_area2` VALUES ('2736', '0001002500090004', '南华县', '2735', '532324');
INSERT INTO `system_area2` VALUES ('2737', '0001002500090005', '姚安县', '2736', '532325');
INSERT INTO `system_area2` VALUES ('2738', '0001002500090006', '大姚县', '2737', '532326');
INSERT INTO `system_area2` VALUES ('2739', '0001002500090007', '永仁县', '2738', '532327');
INSERT INTO `system_area2` VALUES ('2740', '0001002500090008', '元谋县', '2739', '532328');
INSERT INTO `system_area2` VALUES ('2741', '0001002500090009', '武定县', '2740', '532329');
INSERT INTO `system_area2` VALUES ('2742', '0001002500090010', '禄丰县', '2741', '532331');
INSERT INTO `system_area2` VALUES ('2743', '000100250010', '红河哈尼族彝族自治州', '2742', '532500');
INSERT INTO `system_area2` VALUES ('2744', '0001002500100001', '个旧市', '2743', '532501');
INSERT INTO `system_area2` VALUES ('2745', '0001002500100002', '开远市', '2744', '532502');
INSERT INTO `system_area2` VALUES ('2746', '0001002500100003', '蒙自县', '2745', '532522');
INSERT INTO `system_area2` VALUES ('2747', '0001002500100004', '屏边苗族自治县', '2746', '532523');
INSERT INTO `system_area2` VALUES ('2748', '0001002500100005', '建水县', '2747', '532524');
INSERT INTO `system_area2` VALUES ('2749', '0001002500100006', '石屏县', '2748', '532525');
INSERT INTO `system_area2` VALUES ('2750', '0001002500100007', '弥勒县', '2749', '532526');
INSERT INTO `system_area2` VALUES ('2751', '0001002500100008', '泸西县', '2750', '532527');
INSERT INTO `system_area2` VALUES ('2752', '0001002500100009', '元阳县', '2751', '532528');
INSERT INTO `system_area2` VALUES ('2753', '0001002500100010', '红河县', '2752', '532529');
INSERT INTO `system_area2` VALUES ('2754', '0001002500100011', '金平苗族瑶族傣族自治县', '2753', '532530');
INSERT INTO `system_area2` VALUES ('2755', '0001002500100012', '绿春县', '2754', '532531');
INSERT INTO `system_area2` VALUES ('2756', '0001002500100013', '河口瑶族自治县', '2755', '532532');
INSERT INTO `system_area2` VALUES ('2757', '000100250011', '文山壮族苗族自治州', '2756', '532600');
INSERT INTO `system_area2` VALUES ('2758', '0001002500110001', '文山县', '2757', '532621');
INSERT INTO `system_area2` VALUES ('2759', '0001002500110002', '砚山县', '2758', '532622');
INSERT INTO `system_area2` VALUES ('2760', '0001002500110003', '西畴县', '2759', '532623');
INSERT INTO `system_area2` VALUES ('2761', '0001002500110004', '麻栗坡县', '2760', '532624');
INSERT INTO `system_area2` VALUES ('2762', '0001002500110005', '马关县', '2761', '532625');
INSERT INTO `system_area2` VALUES ('2763', '0001002500110006', '丘北县', '2762', '532626');
INSERT INTO `system_area2` VALUES ('2764', '0001002500110007', '广南县', '2763', '532627');
INSERT INTO `system_area2` VALUES ('2765', '0001002500110008', '富宁县', '2764', '532628');
INSERT INTO `system_area2` VALUES ('2766', '000100250012', '西双版纳傣族自治州', '2765', '532800');
INSERT INTO `system_area2` VALUES ('2767', '0001002500120001', '景洪市', '2766', '532801');
INSERT INTO `system_area2` VALUES ('2768', '0001002500120002', '勐海县', '2767', '532822');
INSERT INTO `system_area2` VALUES ('2769', '0001002500120003', '勐腊县', '2768', '532823');
INSERT INTO `system_area2` VALUES ('2770', '000100250013', '大理白族自治州', '2769', '532900');
INSERT INTO `system_area2` VALUES ('2771', '0001002500130001', '大理市', '2770', '532901');
INSERT INTO `system_area2` VALUES ('2772', '0001002500130002', '漾濞彝族自治县', '2771', '532922');
INSERT INTO `system_area2` VALUES ('2773', '0001002500130003', '祥云县', '2772', '532923');
INSERT INTO `system_area2` VALUES ('2774', '0001002500130004', '宾川县', '2773', '532924');
INSERT INTO `system_area2` VALUES ('2775', '0001002500130005', '弥渡县', '2774', '532925');
INSERT INTO `system_area2` VALUES ('2776', '0001002500130006', '南涧彝族自治县', '2775', '532926');
INSERT INTO `system_area2` VALUES ('2777', '0001002500130007', '巍山彝族回族自治县', '2776', '532927');
INSERT INTO `system_area2` VALUES ('2778', '0001002500130008', '永平县', '2777', '532928');
INSERT INTO `system_area2` VALUES ('2779', '0001002500130009', '云龙县', '2778', '532929');
INSERT INTO `system_area2` VALUES ('2780', '0001002500130010', '洱源县', '2779', '532930');
INSERT INTO `system_area2` VALUES ('2781', '0001002500130011', '剑川县', '2780', '532931');
INSERT INTO `system_area2` VALUES ('2782', '0001002500130012', '鹤庆县', '2781', '532932');
INSERT INTO `system_area2` VALUES ('2783', '000100250014', '德宏傣族景颇族自治州', '2782', '533100');
INSERT INTO `system_area2` VALUES ('2784', '0001002500140001', '瑞丽市', '2783', '533102');
INSERT INTO `system_area2` VALUES ('2785', '0001002500140002', '潞西市', '2784', '533103');
INSERT INTO `system_area2` VALUES ('2786', '0001002500140003', '梁河县', '2785', '533122');
INSERT INTO `system_area2` VALUES ('2787', '0001002500140004', '盈江县', '2786', '533123');
INSERT INTO `system_area2` VALUES ('2788', '0001002500140005', '陇川县', '2787', '533124');
INSERT INTO `system_area2` VALUES ('2789', '000100250015', '怒江傈僳族自治州', '2788', '533300');
INSERT INTO `system_area2` VALUES ('2790', '0001002500150001', '泸水县', '2789', '533321');
INSERT INTO `system_area2` VALUES ('2791', '0001002500150002', '福贡县', '2790', '533323');
INSERT INTO `system_area2` VALUES ('2792', '0001002500150003', '贡山独龙族怒族自治县', '2791', '533324');
INSERT INTO `system_area2` VALUES ('2793', '0001002500150004', '兰坪白族普米族自治县', '2792', '533325');
INSERT INTO `system_area2` VALUES ('2794', '000100250016', '迪庆藏族自治州', '2793', '533400');
INSERT INTO `system_area2` VALUES ('2795', '0001002500160001', '香格里拉县', '2794', '533421');
INSERT INTO `system_area2` VALUES ('2796', '0001002500160002', '德钦县', '2795', '533422');
INSERT INTO `system_area2` VALUES ('2797', '0001002500160003', '维西傈僳族自治县', '2796', '533423');
INSERT INTO `system_area2` VALUES ('2798', '00010026', '西藏自治区', '2797', '540000');
INSERT INTO `system_area2` VALUES ('2799', '000100260001', '拉萨市', '2798', '540100');
INSERT INTO `system_area2` VALUES ('2800', '0001002600010001', '城关区', '2799', '540102');
INSERT INTO `system_area2` VALUES ('2801', '0001002600010002', '林周县', '2800', '540121');
INSERT INTO `system_area2` VALUES ('2802', '0001002600010003', '当雄县', '2801', '540122');
INSERT INTO `system_area2` VALUES ('2803', '0001002600010004', '尼木县', '2802', '540123');
INSERT INTO `system_area2` VALUES ('2804', '0001002600010005', '曲水县', '2803', '540124');
INSERT INTO `system_area2` VALUES ('2805', '0001002600010006', '堆龙德庆县', '2804', '540125');
INSERT INTO `system_area2` VALUES ('2806', '0001002600010007', '达孜县', '2805', '540126');
INSERT INTO `system_area2` VALUES ('2807', '0001002600010008', '墨竹工卡县', '2806', '540127');
INSERT INTO `system_area2` VALUES ('2808', '000100260002', '昌都地区', '2807', '542100');
INSERT INTO `system_area2` VALUES ('2809', '0001002600020001', '昌都县', '2808', '542121');
INSERT INTO `system_area2` VALUES ('2810', '0001002600020002', '江达县', '2809', '542122');
INSERT INTO `system_area2` VALUES ('2811', '0001002600020003', '贡觉县', '2810', '542123');
INSERT INTO `system_area2` VALUES ('2812', '0001002600020004', '类乌齐县', '2811', '542124');
INSERT INTO `system_area2` VALUES ('2813', '0001002600020005', '丁青县', '2812', '542125');
INSERT INTO `system_area2` VALUES ('2814', '0001002600020006', '察雅县', '2813', '542126');
INSERT INTO `system_area2` VALUES ('2815', '0001002600020007', '八宿县', '2814', '542127');
INSERT INTO `system_area2` VALUES ('2816', '0001002600020008', '左贡县', '2815', '542128');
INSERT INTO `system_area2` VALUES ('2817', '0001002600020009', '芒康县', '2816', '542129');
INSERT INTO `system_area2` VALUES ('2818', '0001002600020010', '洛隆县', '2817', '542132');
INSERT INTO `system_area2` VALUES ('2819', '0001002600020011', '边坝县', '2818', '542133');
INSERT INTO `system_area2` VALUES ('2820', '000100260003', '山南地区', '2819', '542200');
INSERT INTO `system_area2` VALUES ('2821', '0001002600030001', '乃东县', '2820', '542221');
INSERT INTO `system_area2` VALUES ('2822', '0001002600030002', '扎囊县', '2821', '542222');
INSERT INTO `system_area2` VALUES ('2823', '0001002600030003', '贡嘎县', '2822', '542223');
INSERT INTO `system_area2` VALUES ('2824', '0001002600030004', '桑日县', '2823', '542224');
INSERT INTO `system_area2` VALUES ('2825', '0001002600030005', '琼结县', '2824', '542225');
INSERT INTO `system_area2` VALUES ('2826', '0001002600030006', '曲松县', '2825', '542226');
INSERT INTO `system_area2` VALUES ('2827', '0001002600030007', '措美县', '2826', '542227');
INSERT INTO `system_area2` VALUES ('2828', '0001002600030008', '洛扎县', '2827', '542228');
INSERT INTO `system_area2` VALUES ('2829', '0001002600030009', '加查县', '2828', '542229');
INSERT INTO `system_area2` VALUES ('2830', '0001002600030010', '隆子县', '2829', '542231');
INSERT INTO `system_area2` VALUES ('2831', '0001002600030011', '错那县', '2830', '542232');
INSERT INTO `system_area2` VALUES ('2832', '0001002600030012', '浪卡子县', '2831', '542233');
INSERT INTO `system_area2` VALUES ('2833', '000100260004', '日喀则地区', '2832', '542300');
INSERT INTO `system_area2` VALUES ('2834', '0001002600040001', '日喀则市', '2833', '542301');
INSERT INTO `system_area2` VALUES ('2835', '0001002600040002', '南木林县', '2834', '542322');
INSERT INTO `system_area2` VALUES ('2836', '0001002600040003', '江孜县', '2835', '542323');
INSERT INTO `system_area2` VALUES ('2837', '0001002600040004', '定日县', '2836', '542324');
INSERT INTO `system_area2` VALUES ('2838', '0001002600040005', '萨迦县', '2837', '542325');
INSERT INTO `system_area2` VALUES ('2839', '0001002600040006', '拉孜县', '2838', '542326');
INSERT INTO `system_area2` VALUES ('2840', '0001002600040007', '昂仁县', '2839', '542327');
INSERT INTO `system_area2` VALUES ('2841', '0001002600040008', '谢通门县', '2840', '542328');
INSERT INTO `system_area2` VALUES ('2842', '0001002600040009', '白朗县', '2841', '542329');
INSERT INTO `system_area2` VALUES ('2843', '0001002600040010', '仁布县', '2842', '542330');
INSERT INTO `system_area2` VALUES ('2844', '0001002600040011', '康马县', '2843', '542331');
INSERT INTO `system_area2` VALUES ('2845', '0001002600040012', '定结县', '2844', '542332');
INSERT INTO `system_area2` VALUES ('2846', '0001002600040013', '仲巴县', '2845', '542333');
INSERT INTO `system_area2` VALUES ('2847', '0001002600040014', '亚东县', '2846', '542334');
INSERT INTO `system_area2` VALUES ('2848', '0001002600040015', '吉隆县', '2847', '542335');
INSERT INTO `system_area2` VALUES ('2849', '0001002600040016', '聂拉木县', '2848', '542336');
INSERT INTO `system_area2` VALUES ('2850', '0001002600040017', '萨嘎县', '2849', '542337');
INSERT INTO `system_area2` VALUES ('2851', '0001002600040018', '岗巴县', '2850', '542338');
INSERT INTO `system_area2` VALUES ('2852', '000100260005', '那曲地区', '2851', '542400');
INSERT INTO `system_area2` VALUES ('2853', '0001002600050001', '那曲县', '2852', '542421');
INSERT INTO `system_area2` VALUES ('2854', '0001002600050002', '嘉黎县', '2853', '542422');
INSERT INTO `system_area2` VALUES ('2855', '0001002600050003', '比如县', '2854', '542423');
INSERT INTO `system_area2` VALUES ('2856', '0001002600050004', '聂荣县', '2855', '542424');
INSERT INTO `system_area2` VALUES ('2857', '0001002600050005', '安多县', '2856', '542425');
INSERT INTO `system_area2` VALUES ('2858', '0001002600050006', '申扎县', '2857', '542426');
INSERT INTO `system_area2` VALUES ('2859', '0001002600050007', '索县', '2858', '542427');
INSERT INTO `system_area2` VALUES ('2860', '0001002600050008', '班戈县', '2859', '542428');
INSERT INTO `system_area2` VALUES ('2861', '0001002600050009', '巴青县', '2860', '542429');
INSERT INTO `system_area2` VALUES ('2862', '0001002600050010', '尼玛县', '2861', '542430');
INSERT INTO `system_area2` VALUES ('2863', '000100260006', '阿里地区', '2862', '542500');
INSERT INTO `system_area2` VALUES ('2864', '0001002600060001', '普兰县', '2863', '542521');
INSERT INTO `system_area2` VALUES ('2865', '0001002600060002', '札达县', '2864', '542522');
INSERT INTO `system_area2` VALUES ('2866', '0001002600060003', '噶尔县', '2865', '542523');
INSERT INTO `system_area2` VALUES ('2867', '0001002600060004', '日土县', '2866', '542524');
INSERT INTO `system_area2` VALUES ('2868', '0001002600060005', '革吉县', '2867', '542525');
INSERT INTO `system_area2` VALUES ('2869', '0001002600060006', '改则县', '2868', '542526');
INSERT INTO `system_area2` VALUES ('2870', '0001002600060007', '措勤县', '2869', '542527');
INSERT INTO `system_area2` VALUES ('2871', '000100260007', '林芝地区', '2870', '542600');
INSERT INTO `system_area2` VALUES ('2872', '0001002600070001', '林芝县', '2871', '542621');
INSERT INTO `system_area2` VALUES ('2873', '0001002600070002', '工布江达县', '2872', '542622');
INSERT INTO `system_area2` VALUES ('2874', '0001002600070003', '米林县', '2873', '542623');
INSERT INTO `system_area2` VALUES ('2875', '0001002600070004', '墨脱县', '2874', '542624');
INSERT INTO `system_area2` VALUES ('2876', '0001002600070005', '波密县', '2875', '542625');
INSERT INTO `system_area2` VALUES ('2877', '0001002600070006', '察隅县', '2876', '542626');
INSERT INTO `system_area2` VALUES ('2878', '0001002600070007', '朗县', '2877', '542627');
INSERT INTO `system_area2` VALUES ('2879', '00010027', '陕西省', '2878', '610000');
INSERT INTO `system_area2` VALUES ('2880', '000100270001', '西安市', '2879', '610100');
INSERT INTO `system_area2` VALUES ('2881', '0001002700010001', '新城区', '2880', '610102');
INSERT INTO `system_area2` VALUES ('2882', '0001002700010002', '碑林区', '2881', '610103');
INSERT INTO `system_area2` VALUES ('2883', '0001002700010003', '莲湖区', '2882', '610104');
INSERT INTO `system_area2` VALUES ('2884', '0001002700010004', '灞桥区', '2883', '610111');
INSERT INTO `system_area2` VALUES ('2885', '0001002700010005', '未央区', '2884', '610112');
INSERT INTO `system_area2` VALUES ('2886', '0001002700010006', '雁塔区', '2885', '610113');
INSERT INTO `system_area2` VALUES ('2887', '0001002700010007', '阎良区', '2886', '610114');
INSERT INTO `system_area2` VALUES ('2888', '0001002700010008', '临潼区', '2887', '610115');
INSERT INTO `system_area2` VALUES ('2889', '0001002700010009', '长安区', '2888', '610116');
INSERT INTO `system_area2` VALUES ('2890', '0001002700010010', '蓝田县', '2889', '610122');
INSERT INTO `system_area2` VALUES ('2891', '0001002700010011', '周至县', '2890', '610124');
INSERT INTO `system_area2` VALUES ('2892', '0001002700010012', '户县', '2891', '610125');
INSERT INTO `system_area2` VALUES ('2893', '0001002700010013', '高陵县', '2892', '610126');
INSERT INTO `system_area2` VALUES ('2894', '000100270002', '铜川市', '2893', '610200');
INSERT INTO `system_area2` VALUES ('2895', '0001002700020001', '王益区', '2894', '610202');
INSERT INTO `system_area2` VALUES ('2896', '0001002700020002', '印台区', '2895', '610203');
INSERT INTO `system_area2` VALUES ('2897', '0001002700020003', '耀州区', '2896', '610204');
INSERT INTO `system_area2` VALUES ('2898', '0001002700020004', '宜君县', '2897', '610222');
INSERT INTO `system_area2` VALUES ('2899', '000100270003', '宝鸡市', '2898', '610300');
INSERT INTO `system_area2` VALUES ('2900', '0001002700030001', '渭滨区', '2899', '610302');
INSERT INTO `system_area2` VALUES ('2901', '0001002700030002', '金台区', '2900', '610303');
INSERT INTO `system_area2` VALUES ('2902', '0001002700030003', '陈仓区', '2901', '610304');
INSERT INTO `system_area2` VALUES ('2903', '0001002700030004', '凤翔县', '2902', '610322');
INSERT INTO `system_area2` VALUES ('2904', '0001002700030005', '岐山县', '2903', '610323');
INSERT INTO `system_area2` VALUES ('2905', '0001002700030006', '扶风县', '2904', '610324');
INSERT INTO `system_area2` VALUES ('2906', '0001002700030007', '眉县', '2905', '610326');
INSERT INTO `system_area2` VALUES ('2907', '0001002700030008', '陇县', '2906', '610327');
INSERT INTO `system_area2` VALUES ('2908', '0001002700030009', '千阳县', '2907', '610328');
INSERT INTO `system_area2` VALUES ('2909', '0001002700030010', '麟游县', '2908', '610329');
INSERT INTO `system_area2` VALUES ('2910', '0001002700030011', '凤县', '2909', '610330');
INSERT INTO `system_area2` VALUES ('2911', '0001002700030012', '太白县', '2910', '610331');
INSERT INTO `system_area2` VALUES ('2912', '000100270004', '咸阳市', '2911', '610400');
INSERT INTO `system_area2` VALUES ('2913', '0001002700040001', '秦都区', '2912', '610402');
INSERT INTO `system_area2` VALUES ('2914', '0001002700040002', '杨陵区', '2913', '610403');
INSERT INTO `system_area2` VALUES ('2915', '0001002700040003', '渭城区', '2914', '610404');
INSERT INTO `system_area2` VALUES ('2916', '0001002700040004', '三原县', '2915', '610422');
INSERT INTO `system_area2` VALUES ('2917', '0001002700040005', '泾阳县', '2916', '610423');
INSERT INTO `system_area2` VALUES ('2918', '0001002700040006', '乾县', '2917', '610424');
INSERT INTO `system_area2` VALUES ('2919', '0001002700040007', '礼泉县', '2918', '610425');
INSERT INTO `system_area2` VALUES ('2920', '0001002700040008', '永寿县', '2919', '610426');
INSERT INTO `system_area2` VALUES ('2921', '0001002700040009', '彬县', '2920', '610427');
INSERT INTO `system_area2` VALUES ('2922', '0001002700040010', '长武县', '2921', '610428');
INSERT INTO `system_area2` VALUES ('2923', '0001002700040011', '旬邑县', '2922', '610429');
INSERT INTO `system_area2` VALUES ('2924', '0001002700040012', '淳化县', '2923', '610430');
INSERT INTO `system_area2` VALUES ('2925', '0001002700040013', '武功县', '2924', '610431');
INSERT INTO `system_area2` VALUES ('2926', '0001002700040014', '兴平市', '2925', '610481');
INSERT INTO `system_area2` VALUES ('2927', '000100270005', '渭南市', '2926', '610500');
INSERT INTO `system_area2` VALUES ('2928', '0001002700050001', '临渭区', '2927', '610502');
INSERT INTO `system_area2` VALUES ('2929', '0001002700050002', '华县', '2928', '610521');
INSERT INTO `system_area2` VALUES ('2930', '0001002700050003', '潼关县', '2929', '610522');
INSERT INTO `system_area2` VALUES ('2931', '0001002700050004', '大荔县', '2930', '610523');
INSERT INTO `system_area2` VALUES ('2932', '0001002700050005', '合阳县', '2931', '610524');
INSERT INTO `system_area2` VALUES ('2933', '0001002700050006', '澄城县', '2932', '610525');
INSERT INTO `system_area2` VALUES ('2934', '0001002700050007', '蒲城县', '2933', '610526');
INSERT INTO `system_area2` VALUES ('2935', '0001002700050008', '白水县', '2934', '610527');
INSERT INTO `system_area2` VALUES ('2936', '0001002700050009', '富平县', '2935', '610528');
INSERT INTO `system_area2` VALUES ('2937', '0001002700050010', '韩城市', '2936', '610581');
INSERT INTO `system_area2` VALUES ('2938', '0001002700050011', '华阴市', '2937', '610582');
INSERT INTO `system_area2` VALUES ('2939', '000100270006', '延安市', '2938', '610600');
INSERT INTO `system_area2` VALUES ('2940', '0001002700060001', '宝塔区', '2939', '610602');
INSERT INTO `system_area2` VALUES ('2941', '0001002700060002', '延长县', '2940', '610621');
INSERT INTO `system_area2` VALUES ('2942', '0001002700060003', '延川县', '2941', '610622');
INSERT INTO `system_area2` VALUES ('2943', '0001002700060004', '子长县', '2942', '610623');
INSERT INTO `system_area2` VALUES ('2944', '0001002700060005', '安塞县', '2943', '610624');
INSERT INTO `system_area2` VALUES ('2945', '0001002700060006', '志丹县', '2944', '610625');
INSERT INTO `system_area2` VALUES ('2946', '0001002700060007', '吴起县', '2945', '610626');
INSERT INTO `system_area2` VALUES ('2947', '0001002700060008', '甘泉县', '2946', '610627');
INSERT INTO `system_area2` VALUES ('2948', '0001002700060009', '富县', '2947', '610628');
INSERT INTO `system_area2` VALUES ('2949', '0001002700060010', '洛川县', '2948', '610629');
INSERT INTO `system_area2` VALUES ('2950', '0001002700060011', '宜川县', '2949', '610630');
INSERT INTO `system_area2` VALUES ('2951', '0001002700060012', '黄龙县', '2950', '610631');
INSERT INTO `system_area2` VALUES ('2952', '0001002700060013', '黄陵县', '2951', '610632');
INSERT INTO `system_area2` VALUES ('2953', '000100270007', '汉中市', '2952', '610700');
INSERT INTO `system_area2` VALUES ('2954', '0001002700070001', '汉台区', '2953', '610702');
INSERT INTO `system_area2` VALUES ('2955', '0001002700070002', '南郑县', '2954', '610721');
INSERT INTO `system_area2` VALUES ('2956', '0001002700070003', '城固县', '2955', '610722');
INSERT INTO `system_area2` VALUES ('2957', '0001002700070004', '洋县', '2956', '610723');
INSERT INTO `system_area2` VALUES ('2958', '0001002700070005', '西乡县', '2957', '610724');
INSERT INTO `system_area2` VALUES ('2959', '0001002700070006', '勉县', '2958', '610725');
INSERT INTO `system_area2` VALUES ('2960', '0001002700070007', '宁强县', '2959', '610726');
INSERT INTO `system_area2` VALUES ('2961', '0001002700070008', '略阳县', '2960', '610727');
INSERT INTO `system_area2` VALUES ('2962', '0001002700070009', '镇巴县', '2961', '610728');
INSERT INTO `system_area2` VALUES ('2963', '0001002700070010', '留坝县', '2962', '610729');
INSERT INTO `system_area2` VALUES ('2964', '0001002700070011', '佛坪县', '2963', '610730');
INSERT INTO `system_area2` VALUES ('2965', '000100270008', '榆林市', '2964', '610800');
INSERT INTO `system_area2` VALUES ('2966', '0001002700080001', '榆阳区', '2965', '610802');
INSERT INTO `system_area2` VALUES ('2967', '0001002700080002', '神木县', '2966', '610821');
INSERT INTO `system_area2` VALUES ('2968', '0001002700080003', '府谷县', '2967', '610822');
INSERT INTO `system_area2` VALUES ('2969', '0001002700080004', '横山县', '2968', '610823');
INSERT INTO `system_area2` VALUES ('2970', '0001002700080005', '靖边县', '2969', '610824');
INSERT INTO `system_area2` VALUES ('2971', '0001002700080006', '定边县', '2970', '610825');
INSERT INTO `system_area2` VALUES ('2972', '0001002700080007', '绥德县', '2971', '610826');
INSERT INTO `system_area2` VALUES ('2973', '0001002700080008', '米脂县', '2972', '610827');
INSERT INTO `system_area2` VALUES ('2974', '0001002700080009', '佳县', '2973', '610828');
INSERT INTO `system_area2` VALUES ('2975', '0001002700080010', '吴堡县', '2974', '610829');
INSERT INTO `system_area2` VALUES ('2976', '0001002700080011', '清涧县', '2975', '610830');
INSERT INTO `system_area2` VALUES ('2977', '0001002700080012', '子洲县', '2976', '610831');
INSERT INTO `system_area2` VALUES ('2978', '000100270009', '安康市', '2977', '610900');
INSERT INTO `system_area2` VALUES ('2979', '0001002700090001', '汉滨区', '2978', '610902');
INSERT INTO `system_area2` VALUES ('2980', '0001002700090002', '汉阴县', '2979', '610921');
INSERT INTO `system_area2` VALUES ('2981', '0001002700090003', '石泉县', '2980', '610922');
INSERT INTO `system_area2` VALUES ('2982', '0001002700090004', '宁陕县', '2981', '610923');
INSERT INTO `system_area2` VALUES ('2983', '0001002700090005', '紫阳县', '2982', '610924');
INSERT INTO `system_area2` VALUES ('2984', '0001002700090006', '岚皋县', '2983', '610925');
INSERT INTO `system_area2` VALUES ('2985', '0001002700090007', '平利县', '2984', '610926');
INSERT INTO `system_area2` VALUES ('2986', '0001002700090008', '镇坪县', '2985', '610927');
INSERT INTO `system_area2` VALUES ('2987', '0001002700090009', '旬阳县', '2986', '610928');
INSERT INTO `system_area2` VALUES ('2988', '0001002700090010', '白河县', '2987', '610929');
INSERT INTO `system_area2` VALUES ('2989', '000100270010', '商洛市', '2988', '611000');
INSERT INTO `system_area2` VALUES ('2990', '0001002700100001', '商州区', '2989', '611002');
INSERT INTO `system_area2` VALUES ('2991', '0001002700100002', '洛南县', '2990', '611021');
INSERT INTO `system_area2` VALUES ('2992', '0001002700100003', '丹凤县', '2991', '611022');
INSERT INTO `system_area2` VALUES ('2993', '0001002700100004', '商南县', '2992', '611023');
INSERT INTO `system_area2` VALUES ('2994', '0001002700100005', '山阳县', '2993', '611024');
INSERT INTO `system_area2` VALUES ('2995', '0001002700100006', '镇安县', '2994', '611025');
INSERT INTO `system_area2` VALUES ('2996', '0001002700100007', '柞水县', '2995', '611026');
INSERT INTO `system_area2` VALUES ('2997', '00010028', '甘肃省', '2996', '620000');
INSERT INTO `system_area2` VALUES ('2998', '000100280001', '兰州市', '2997', '620100');
INSERT INTO `system_area2` VALUES ('2999', '0001002800010001', '城关区', '2998', '620102');
INSERT INTO `system_area2` VALUES ('3000', '0001002800010002', '七里河区', '2999', '620103');
INSERT INTO `system_area2` VALUES ('3001', '0001002800010003', '西固区', '3000', '620104');
INSERT INTO `system_area2` VALUES ('3002', '0001002800010004', '安宁区', '3001', '620105');
INSERT INTO `system_area2` VALUES ('3003', '0001002800010005', '红古区', '3002', '620111');
INSERT INTO `system_area2` VALUES ('3004', '0001002800010006', '永登县', '3003', '620121');
INSERT INTO `system_area2` VALUES ('3005', '0001002800010007', '皋兰县', '3004', '620122');
INSERT INTO `system_area2` VALUES ('3006', '0001002800010008', '榆中县', '3005', '620123');
INSERT INTO `system_area2` VALUES ('3007', '000100280002', '嘉峪关市', '3006', '620200');
INSERT INTO `system_area2` VALUES ('3008', '000100280003', '金昌市', '3007', '620300');
INSERT INTO `system_area2` VALUES ('3009', '0001002800030001', '金川区', '3008', '620302');
INSERT INTO `system_area2` VALUES ('3010', '0001002800030002', '永昌县', '3009', '620321');
INSERT INTO `system_area2` VALUES ('3011', '000100280004', '白银市', '3010', '620400');
INSERT INTO `system_area2` VALUES ('3012', '0001002800040001', '白银区', '3011', '620402');
INSERT INTO `system_area2` VALUES ('3013', '0001002800040002', '平川区', '3012', '620403');
INSERT INTO `system_area2` VALUES ('3014', '0001002800040003', '靖远县', '3013', '620421');
INSERT INTO `system_area2` VALUES ('3015', '0001002800040004', '会宁县', '3014', '620422');
INSERT INTO `system_area2` VALUES ('3016', '0001002800040005', '景泰县', '3015', '620423');
INSERT INTO `system_area2` VALUES ('3017', '000100280005', '天水市', '3016', '620500');
INSERT INTO `system_area2` VALUES ('3018', '0001002800050001', '秦州区', '3017', '620502');
INSERT INTO `system_area2` VALUES ('3019', '0001002800050002', '麦积区', '3018', '620503');
INSERT INTO `system_area2` VALUES ('3020', '0001002800050003', '清水县', '3019', '620521');
INSERT INTO `system_area2` VALUES ('3021', '0001002800050004', '秦安县', '3020', '620522');
INSERT INTO `system_area2` VALUES ('3022', '0001002800050005', '甘谷县', '3021', '620523');
INSERT INTO `system_area2` VALUES ('3023', '0001002800050006', '武山县', '3022', '620524');
INSERT INTO `system_area2` VALUES ('3024', '0001002800050007', '张家川回族自治县', '3023', '620525');
INSERT INTO `system_area2` VALUES ('3025', '000100280006', '武威市', '3024', '620600');
INSERT INTO `system_area2` VALUES ('3026', '0001002800060001', '凉州区', '3025', '620602');
INSERT INTO `system_area2` VALUES ('3027', '0001002800060002', '民勤县', '3026', '620621');
INSERT INTO `system_area2` VALUES ('3028', '0001002800060003', '古浪县', '3027', '620622');
INSERT INTO `system_area2` VALUES ('3029', '0001002800060004', '天祝藏族自治县', '3028', '620623');
INSERT INTO `system_area2` VALUES ('3030', '000100280007', '张掖市', '3029', '620700');
INSERT INTO `system_area2` VALUES ('3031', '0001002800070001', '甘州区', '3030', '620702');
INSERT INTO `system_area2` VALUES ('3032', '0001002800070002', '肃南裕固族自治县', '3031', '620721');
INSERT INTO `system_area2` VALUES ('3033', '0001002800070003', '民乐县', '3032', '620722');
INSERT INTO `system_area2` VALUES ('3034', '0001002800070004', '临泽县', '3033', '620723');
INSERT INTO `system_area2` VALUES ('3035', '0001002800070005', '高台县', '3034', '620724');
INSERT INTO `system_area2` VALUES ('3036', '0001002800070006', '山丹县', '3035', '620725');
INSERT INTO `system_area2` VALUES ('3037', '000100280008', '平凉市', '3036', '620800');
INSERT INTO `system_area2` VALUES ('3038', '0001002800080001', '崆峒区', '3037', '620802');
INSERT INTO `system_area2` VALUES ('3039', '0001002800080002', '泾川县', '3038', '620821');
INSERT INTO `system_area2` VALUES ('3040', '0001002800080003', '灵台县', '3039', '620822');
INSERT INTO `system_area2` VALUES ('3041', '0001002800080004', '崇信县', '3040', '620823');
INSERT INTO `system_area2` VALUES ('3042', '0001002800080005', '华亭县', '3041', '620824');
INSERT INTO `system_area2` VALUES ('3043', '0001002800080006', '庄浪县', '3042', '620825');
INSERT INTO `system_area2` VALUES ('3044', '0001002800080007', '静宁县', '3043', '620826');
INSERT INTO `system_area2` VALUES ('3045', '000100280009', '酒泉市', '3044', '620900');
INSERT INTO `system_area2` VALUES ('3046', '0001002800090001', '肃州区', '3045', '620902');
INSERT INTO `system_area2` VALUES ('3047', '0001002800090002', '金塔县', '3046', '620921');
INSERT INTO `system_area2` VALUES ('3048', '0001002800090003', '安西县', '3047', '620922');
INSERT INTO `system_area2` VALUES ('3049', '0001002800090004', '肃北蒙古族自治县', '3048', '620923');
INSERT INTO `system_area2` VALUES ('3050', '0001002800090005', '阿克塞哈萨克族自治县', '3049', '620924');
INSERT INTO `system_area2` VALUES ('3051', '0001002800090006', '玉门市', '3050', '620981');
INSERT INTO `system_area2` VALUES ('3052', '0001002800090007', '敦煌市', '3051', '620982');
INSERT INTO `system_area2` VALUES ('3053', '000100280010', '庆阳市', '3052', '621000');
INSERT INTO `system_area2` VALUES ('3054', '0001002800100001', '西峰区', '3053', '621002');
INSERT INTO `system_area2` VALUES ('3055', '0001002800100002', '庆城县', '3054', '621021');
INSERT INTO `system_area2` VALUES ('3056', '0001002800100003', '环县', '3055', '621022');
INSERT INTO `system_area2` VALUES ('3057', '0001002800100004', '华池县', '3056', '621023');
INSERT INTO `system_area2` VALUES ('3058', '0001002800100005', '合水县', '3057', '621024');
INSERT INTO `system_area2` VALUES ('3059', '0001002800100006', '正宁县', '3058', '621025');
INSERT INTO `system_area2` VALUES ('3060', '0001002800100007', '宁县', '3059', '621026');
INSERT INTO `system_area2` VALUES ('3061', '0001002800100008', '镇原县', '3060', '621027');
INSERT INTO `system_area2` VALUES ('3062', '000100280011', '定西市', '3061', '621100');
INSERT INTO `system_area2` VALUES ('3063', '0001002800110001', '兰州市', '3062', '620100');
INSERT INTO `system_area2` VALUES ('3064', '0001002800110002', '嘉峪关市', '3063', '620200');
INSERT INTO `system_area2` VALUES ('3065', '0001002800110003', '金昌市', '3064', '620300');
INSERT INTO `system_area2` VALUES ('3066', '0001002800110004', '白银市', '3065', '620400');
INSERT INTO `system_area2` VALUES ('3067', '0001002800110005', '天水市', '3066', '620500');
INSERT INTO `system_area2` VALUES ('3068', '0001002800110006', '武威市', '3067', '620600');
INSERT INTO `system_area2` VALUES ('3069', '0001002800110007', '张掖市', '3068', '620700');
INSERT INTO `system_area2` VALUES ('3070', '0001002800110008', '平凉市', '3069', '620800');
INSERT INTO `system_area2` VALUES ('3071', '0001002800110009', '酒泉市', '3070', '620900');
INSERT INTO `system_area2` VALUES ('3072', '0001002800110010', '庆阳市', '3071', '621000');
INSERT INTO `system_area2` VALUES ('3073', '0001002800110011', '定西市', '3072', '621100');
INSERT INTO `system_area2` VALUES ('3074', '0001002800110012', '陇南市', '3073', '621200');
INSERT INTO `system_area2` VALUES ('3075', '0001002800110013', '临夏回族自治州', '3074', '622900');
INSERT INTO `system_area2` VALUES ('3076', '0001002800110014', '甘南藏族自治州', '3075', '623000');
INSERT INTO `system_area2` VALUES ('3077', '000100280012', '陇南市', '3076', '621200');
INSERT INTO `system_area2` VALUES ('3078', '0001002800120001', '武都区', '3077', '621202');
INSERT INTO `system_area2` VALUES ('3079', '0001002800120002', '成县', '3078', '621221');
INSERT INTO `system_area2` VALUES ('3080', '0001002800120003', '文县', '3079', '621222');
INSERT INTO `system_area2` VALUES ('3081', '0001002800120004', '宕昌县', '3080', '621223');
INSERT INTO `system_area2` VALUES ('3082', '0001002800120005', '康县', '3081', '621224');
INSERT INTO `system_area2` VALUES ('3083', '0001002800120006', '西和县', '3082', '621225');
INSERT INTO `system_area2` VALUES ('3084', '0001002800120007', '礼县', '3083', '621226');
INSERT INTO `system_area2` VALUES ('3085', '0001002800120008', '徽县', '3084', '621227');
INSERT INTO `system_area2` VALUES ('3086', '0001002800120009', '两当县', '3085', '621228');
INSERT INTO `system_area2` VALUES ('3087', '000100280013', '临夏回族自治州', '3086', '622900');
INSERT INTO `system_area2` VALUES ('3088', '0001002800130001', '临夏市', '3087', '622901');
INSERT INTO `system_area2` VALUES ('3089', '0001002800130002', '临夏县', '3088', '622921');
INSERT INTO `system_area2` VALUES ('3090', '0001002800130003', '康乐县', '3089', '622922');
INSERT INTO `system_area2` VALUES ('3091', '0001002800130004', '永靖县', '3090', '622923');
INSERT INTO `system_area2` VALUES ('3092', '0001002800130005', '广河县', '3091', '622924');
INSERT INTO `system_area2` VALUES ('3093', '0001002800130006', '和政县', '3092', '622925');
INSERT INTO `system_area2` VALUES ('3094', '0001002800130007', '东乡族自治县', '3093', '622926');
INSERT INTO `system_area2` VALUES ('3095', '0001002800130008', '积石山保安族东乡族撒拉族自治县', '3094', '622927');
INSERT INTO `system_area2` VALUES ('3096', '000100280014', '甘南藏族自治州', '3095', '623000');
INSERT INTO `system_area2` VALUES ('3097', '0001002800140001', '合作市', '3096', '623001');
INSERT INTO `system_area2` VALUES ('3098', '0001002800140002', '临潭县', '3097', '623021');
INSERT INTO `system_area2` VALUES ('3099', '0001002800140003', '卓尼县', '3098', '623022');
INSERT INTO `system_area2` VALUES ('3100', '0001002800140004', '舟曲县', '3099', '623023');
INSERT INTO `system_area2` VALUES ('3101', '0001002800140005', '迭部县', '3100', '623024');
INSERT INTO `system_area2` VALUES ('3102', '0001002800140006', '玛曲县', '3101', '623025');
INSERT INTO `system_area2` VALUES ('3103', '0001002800140007', '碌曲县', '3102', '623026');
INSERT INTO `system_area2` VALUES ('3104', '0001002800140008', '夏河县', '3103', '623027');
INSERT INTO `system_area2` VALUES ('3105', '00010029', '青海省', '3104', '630000');
INSERT INTO `system_area2` VALUES ('3106', '000100290001', '西宁市', '3105', '630100');
INSERT INTO `system_area2` VALUES ('3107', '0001002900010001', '城东区', '3106', '630102');
INSERT INTO `system_area2` VALUES ('3108', '0001002900010002', '城中区', '3107', '630103');
INSERT INTO `system_area2` VALUES ('3109', '0001002900010003', '城西区', '3108', '630104');
INSERT INTO `system_area2` VALUES ('3110', '0001002900010004', '城北区', '3109', '630105');
INSERT INTO `system_area2` VALUES ('3111', '0001002900010005', '大通回族土族自治县', '3110', '630121');
INSERT INTO `system_area2` VALUES ('3112', '0001002900010006', '湟中县', '3111', '630122');
INSERT INTO `system_area2` VALUES ('3113', '0001002900010007', '湟源县', '3112', '630123');
INSERT INTO `system_area2` VALUES ('3114', '000100290002', '海东地区', '3113', '632100');
INSERT INTO `system_area2` VALUES ('3115', '0001002900020001', '平安县', '3114', '632121');
INSERT INTO `system_area2` VALUES ('3116', '0001002900020002', '民和回族土族自治县', '3115', '632122');
INSERT INTO `system_area2` VALUES ('3117', '0001002900020003', '乐都县', '3116', '632123');
INSERT INTO `system_area2` VALUES ('3118', '0001002900020004', '互助土族自治县', '3117', '632126');
INSERT INTO `system_area2` VALUES ('3119', '0001002900020005', '化隆回族自治县', '3118', '632127');
INSERT INTO `system_area2` VALUES ('3120', '0001002900020006', '循化撒拉族自治县', '3119', '632128');
INSERT INTO `system_area2` VALUES ('3121', '000100290003', '海北藏族自治州', '3120', '632200');
INSERT INTO `system_area2` VALUES ('3122', '0001002900030001', '门源回族自治县', '3121', '632221');
INSERT INTO `system_area2` VALUES ('3123', '0001002900030002', '祁连县', '3122', '632222');
INSERT INTO `system_area2` VALUES ('3124', '0001002900030003', '海晏县', '3123', '632223');
INSERT INTO `system_area2` VALUES ('3125', '0001002900030004', '刚察县', '3124', '632224');
INSERT INTO `system_area2` VALUES ('3126', '000100290004', '黄南藏族自治州', '3125', '632300');
INSERT INTO `system_area2` VALUES ('3127', '0001002900040001', '同仁县', '3126', '632321');
INSERT INTO `system_area2` VALUES ('3128', '0001002900040002', '尖扎县', '3127', '632322');
INSERT INTO `system_area2` VALUES ('3129', '0001002900040003', '泽库县', '3128', '632323');
INSERT INTO `system_area2` VALUES ('3130', '0001002900040004', '河南蒙古族自治县', '3129', '632324');
INSERT INTO `system_area2` VALUES ('3131', '000100290005', '海南藏族自治州', '3130', '632500');
INSERT INTO `system_area2` VALUES ('3132', '0001002900050001', '共和县', '3131', '632521');
INSERT INTO `system_area2` VALUES ('3133', '0001002900050002', '同德县', '3132', '632522');
INSERT INTO `system_area2` VALUES ('3134', '0001002900050003', '贵德县', '3133', '632523');
INSERT INTO `system_area2` VALUES ('3135', '0001002900050004', '兴海县', '3134', '632524');
INSERT INTO `system_area2` VALUES ('3136', '0001002900050005', '贵南县', '3135', '632525');
INSERT INTO `system_area2` VALUES ('3137', '000100290006', '果洛藏族自治州', '3136', '632600');
INSERT INTO `system_area2` VALUES ('3138', '0001002900060001', '玛沁县', '3137', '632621');
INSERT INTO `system_area2` VALUES ('3139', '0001002900060002', '班玛县', '3138', '632622');
INSERT INTO `system_area2` VALUES ('3140', '0001002900060003', '甘德县', '3139', '632623');
INSERT INTO `system_area2` VALUES ('3141', '0001002900060004', '达日县', '3140', '632624');
INSERT INTO `system_area2` VALUES ('3142', '0001002900060005', '久治县', '3141', '632625');
INSERT INTO `system_area2` VALUES ('3143', '0001002900060006', '玛多县', '3142', '632626');
INSERT INTO `system_area2` VALUES ('3144', '000100290007', '玉树藏族自治州', '3143', '632700');
INSERT INTO `system_area2` VALUES ('3145', '0001002900070001', '玉树县', '3144', '632721');
INSERT INTO `system_area2` VALUES ('3146', '0001002900070002', '杂多县', '3145', '632722');
INSERT INTO `system_area2` VALUES ('3147', '0001002900070003', '称多县', '3146', '632723');
INSERT INTO `system_area2` VALUES ('3148', '0001002900070004', '治多县', '3147', '632724');
INSERT INTO `system_area2` VALUES ('3149', '0001002900070005', '囊谦县', '3148', '632725');
INSERT INTO `system_area2` VALUES ('3150', '0001002900070006', '曲麻莱县', '3149', '632726');
INSERT INTO `system_area2` VALUES ('3151', '000100290008', '海西蒙古族藏族自治州', '3150', '632800');
INSERT INTO `system_area2` VALUES ('3152', '0001002900080001', '西宁市', '3151', '630100');
INSERT INTO `system_area2` VALUES ('3153', '0001002900080002', '海东地区', '3152', '632100');
INSERT INTO `system_area2` VALUES ('3154', '0001002900080003', '海北藏族自治州', '3153', '632200');
INSERT INTO `system_area2` VALUES ('3155', '0001002900080004', '黄南藏族自治州', '3154', '632300');
INSERT INTO `system_area2` VALUES ('3156', '0001002900080005', '海南藏族自治州', '3155', '632500');
INSERT INTO `system_area2` VALUES ('3157', '0001002900080006', '果洛藏族自治州', '3156', '632600');
INSERT INTO `system_area2` VALUES ('3158', '0001002900080007', '玉树藏族自治州', '3157', '632700');
INSERT INTO `system_area2` VALUES ('3159', '0001002900080008', '海西蒙古族藏族自治州', '3158', '632800');
INSERT INTO `system_area2` VALUES ('3160', '00010030', '宁夏回族自治区', '3159', '640000');
INSERT INTO `system_area2` VALUES ('3161', '000100300001', '银川市', '3160', '640100');
INSERT INTO `system_area2` VALUES ('3162', '0001003000010001', '兴庆区', '3161', '640104');
INSERT INTO `system_area2` VALUES ('3163', '0001003000010002', '西夏区', '3162', '640105');
INSERT INTO `system_area2` VALUES ('3164', '0001003000010003', '金凤区', '3163', '640106');
INSERT INTO `system_area2` VALUES ('3165', '0001003000010004', '永宁县', '3164', '640121');
INSERT INTO `system_area2` VALUES ('3166', '0001003000010005', '贺兰县', '3165', '640122');
INSERT INTO `system_area2` VALUES ('3167', '0001003000010006', '灵武市', '3166', '640181');
INSERT INTO `system_area2` VALUES ('3168', '000100300002', '石嘴山市', '3167', '640200');
INSERT INTO `system_area2` VALUES ('3169', '0001003000020001', '大武口区', '3168', '640202');
INSERT INTO `system_area2` VALUES ('3170', '0001003000020002', '惠农区', '3169', '640205');
INSERT INTO `system_area2` VALUES ('3171', '0001003000020003', '平罗县', '3170', '640221');
INSERT INTO `system_area2` VALUES ('3172', '000100300003', '吴忠市', '3171', '640300');
INSERT INTO `system_area2` VALUES ('3173', '0001003000030001', '利通区', '3172', '640302');
INSERT INTO `system_area2` VALUES ('3174', '0001003000030002', '红寺堡区', '3173', '640303');
INSERT INTO `system_area2` VALUES ('3175', '0001003000030003', '盐池县', '3174', '640323');
INSERT INTO `system_area2` VALUES ('3176', '0001003000030004', '同心县', '3175', '640324');
INSERT INTO `system_area2` VALUES ('3177', '0001003000030005', '青铜峡市', '3176', '640381');
INSERT INTO `system_area2` VALUES ('3178', '000100300004', '固原市', '3177', '640400');
INSERT INTO `system_area2` VALUES ('3179', '0001003000040001', '原州区', '3178', '640402');
INSERT INTO `system_area2` VALUES ('3180', '0001003000040002', '西吉县', '3179', '640422');
INSERT INTO `system_area2` VALUES ('3181', '0001003000040003', '隆德县', '3180', '640423');
INSERT INTO `system_area2` VALUES ('3182', '0001003000040004', '泾源县', '3181', '640424');
INSERT INTO `system_area2` VALUES ('3183', '0001003000040005', '彭阳县', '3182', '640425');
INSERT INTO `system_area2` VALUES ('3184', '000100300005', '中卫市', '3183', '640500');
INSERT INTO `system_area2` VALUES ('3185', '0001003000050001', '沙坡头区', '3184', '640502');
INSERT INTO `system_area2` VALUES ('3186', '0001003000050002', '中宁县', '3185', '640521');
INSERT INTO `system_area2` VALUES ('3187', '0001003000050003', '海原县', '3186', '640522');
INSERT INTO `system_area2` VALUES ('3188', '00010031', '新疆维吾尔自治区', '3187', '650000');
INSERT INTO `system_area2` VALUES ('3189', '000100310001', '乌鲁木齐市', '3188', '650100');
INSERT INTO `system_area2` VALUES ('3190', '0001003100010001', '天山区', '3189', '650102');
INSERT INTO `system_area2` VALUES ('3191', '0001003100010002', '沙依巴克区', '3190', '650103');
INSERT INTO `system_area2` VALUES ('3192', '0001003100010003', '新市区', '3191', '650104');
INSERT INTO `system_area2` VALUES ('3193', '0001003100010004', '水磨沟区', '3192', '650105');
INSERT INTO `system_area2` VALUES ('3194', '0001003100010005', '头屯河区', '3193', '650106');
INSERT INTO `system_area2` VALUES ('3195', '0001003100010006', '达坂城区', '3194', '650107');
INSERT INTO `system_area2` VALUES ('3196', '0001003100010007', '东山区', '3195', '650108');
INSERT INTO `system_area2` VALUES ('3197', '0001003100010008', '米东区', '3196', '650109');
INSERT INTO `system_area2` VALUES ('3198', '0001003100010009', '乌鲁木齐县', '3197', '650121');
INSERT INTO `system_area2` VALUES ('3199', '000100310002', '克拉玛依市', '3198', '650200');
INSERT INTO `system_area2` VALUES ('3200', '0001003100020001', '独山子区', '3199', '650202');
INSERT INTO `system_area2` VALUES ('3201', '0001003100020002', '克拉玛依区', '3200', '650203');
INSERT INTO `system_area2` VALUES ('3202', '0001003100020003', '白碱滩区', '3201', '650204');
INSERT INTO `system_area2` VALUES ('3203', '0001003100020004', '乌尔禾区', '3202', '650205');
INSERT INTO `system_area2` VALUES ('3204', '000100310003', '吐鲁番地区', '3203', '652100');
INSERT INTO `system_area2` VALUES ('3205', '0001003100030001', '吐鲁番市', '3204', '652101');
INSERT INTO `system_area2` VALUES ('3206', '0001003100030002', '鄯善县', '3205', '652122');
INSERT INTO `system_area2` VALUES ('3207', '0001003100030003', '托克逊县', '3206', '652123');
INSERT INTO `system_area2` VALUES ('3208', '000100310004', '哈密地区', '3207', '652200');
INSERT INTO `system_area2` VALUES ('3209', '0001003100040001', '哈密市', '3208', '652201');
INSERT INTO `system_area2` VALUES ('3210', '0001003100040002', '巴里坤哈萨克自治县', '3209', '652222');
INSERT INTO `system_area2` VALUES ('3211', '0001003100040003', '伊吾县', '3210', '652223');
INSERT INTO `system_area2` VALUES ('3212', '000100310005', '昌吉回族自治州', '3211', '652300');
INSERT INTO `system_area2` VALUES ('3213', '0001003100050001', '昌吉市', '3212', '652301');
INSERT INTO `system_area2` VALUES ('3214', '0001003100050002', '阜康市', '3213', '652302');
INSERT INTO `system_area2` VALUES ('3215', '0001003100050003', '米泉市', '3214', '652303');
INSERT INTO `system_area2` VALUES ('3216', '0001003100050004', '呼图壁县', '3215', '652323');
INSERT INTO `system_area2` VALUES ('3217', '0001003100050005', '玛纳斯县', '3216', '652324');
INSERT INTO `system_area2` VALUES ('3218', '0001003100050006', '奇台县', '3217', '652325');
INSERT INTO `system_area2` VALUES ('3219', '0001003100050007', '吉木萨尔县', '3218', '652327');
INSERT INTO `system_area2` VALUES ('3220', '0001003100050008', '木垒哈萨克自治县', '3219', '652328');
INSERT INTO `system_area2` VALUES ('3221', '000100310006', '博尔塔拉蒙古自治州', '3220', '652700');
INSERT INTO `system_area2` VALUES ('3222', '0001003100060001', '博乐市', '3221', '652701');
INSERT INTO `system_area2` VALUES ('3223', '0001003100060002', '精河县', '3222', '652722');
INSERT INTO `system_area2` VALUES ('3224', '0001003100060003', '温泉县', '3223', '652723');
INSERT INTO `system_area2` VALUES ('3225', '000100310007', '巴音郭楞蒙古自治州', '3224', '652800');
INSERT INTO `system_area2` VALUES ('3226', '0001003100070001', '库尔勒市', '3225', '652801');
INSERT INTO `system_area2` VALUES ('3227', '0001003100070002', '轮台县', '3226', '652822');
INSERT INTO `system_area2` VALUES ('3228', '0001003100070003', '尉犁县', '3227', '652823');
INSERT INTO `system_area2` VALUES ('3229', '0001003100070004', '若羌县', '3228', '652824');
INSERT INTO `system_area2` VALUES ('3230', '0001003100070005', '且末县', '3229', '652825');
INSERT INTO `system_area2` VALUES ('3231', '0001003100070006', '焉耆回族自治县', '3230', '652826');
INSERT INTO `system_area2` VALUES ('3232', '0001003100070007', '和静县', '3231', '652827');
INSERT INTO `system_area2` VALUES ('3233', '0001003100070008', '和硕县', '3232', '652828');
INSERT INTO `system_area2` VALUES ('3234', '0001003100070009', '博湖县', '3233', '652829');
INSERT INTO `system_area2` VALUES ('3235', '000100310008', '阿克苏地区', '3234', '652900');
INSERT INTO `system_area2` VALUES ('3236', '0001003100080001', '阿克苏市', '3235', '652901');
INSERT INTO `system_area2` VALUES ('3237', '0001003100080002', '温宿县', '3236', '652922');
INSERT INTO `system_area2` VALUES ('3238', '0001003100080003', '库车县', '3237', '652923');
INSERT INTO `system_area2` VALUES ('3239', '0001003100080004', '沙雅县', '3238', '652924');
INSERT INTO `system_area2` VALUES ('3240', '0001003100080005', '新和县', '3239', '652925');
INSERT INTO `system_area2` VALUES ('3241', '0001003100080006', '拜城县', '3240', '652926');
INSERT INTO `system_area2` VALUES ('3242', '0001003100080007', '乌什县', '3241', '652927');
INSERT INTO `system_area2` VALUES ('3243', '0001003100080008', '阿瓦提县', '3242', '652928');
INSERT INTO `system_area2` VALUES ('3244', '0001003100080009', '柯坪县', '3243', '652929');
INSERT INTO `system_area2` VALUES ('3245', '000100310009', '克孜勒苏柯尔克孜自治州', '3244', '653000');
INSERT INTO `system_area2` VALUES ('3246', '0001003100090001', '阿图什市', '3245', '653001');
INSERT INTO `system_area2` VALUES ('3247', '0001003100090002', '阿克陶县', '3246', '653022');
INSERT INTO `system_area2` VALUES ('3248', '0001003100090003', '阿合奇县', '3247', '653023');
INSERT INTO `system_area2` VALUES ('3249', '0001003100090004', '乌恰县', '3248', '653024');
INSERT INTO `system_area2` VALUES ('3250', '000100310010', '喀什地区', '3249', '653100');
INSERT INTO `system_area2` VALUES ('3251', '0001003100100001', '喀什市', '3250', '653101');
INSERT INTO `system_area2` VALUES ('3252', '0001003100100002', '疏附县', '3251', '653121');
INSERT INTO `system_area2` VALUES ('3253', '0001003100100003', '疏勒县', '3252', '653122');
INSERT INTO `system_area2` VALUES ('3254', '0001003100100004', '英吉沙县', '3253', '653123');
INSERT INTO `system_area2` VALUES ('3255', '0001003100100005', '泽普县', '3254', '653124');
INSERT INTO `system_area2` VALUES ('3256', '0001003100100006', '莎车县', '3255', '653125');
INSERT INTO `system_area2` VALUES ('3257', '0001003100100007', '叶城县', '3256', '653126');
INSERT INTO `system_area2` VALUES ('3258', '0001003100100008', '麦盖提县', '3257', '653127');
INSERT INTO `system_area2` VALUES ('3259', '0001003100100009', '岳普湖县', '3258', '653128');
INSERT INTO `system_area2` VALUES ('3260', '0001003100100010', '伽师县', '3259', '653129');
INSERT INTO `system_area2` VALUES ('3261', '0001003100100011', '巴楚县', '3260', '653130');
INSERT INTO `system_area2` VALUES ('3262', '0001003100100012', '塔什库尔干塔吉克自治县', '3261', '653131');
INSERT INTO `system_area2` VALUES ('3263', '000100310011', '和田地区', '3262', '653200');
INSERT INTO `system_area2` VALUES ('3264', '0001003100110001', '和田市', '3263', '653201');
INSERT INTO `system_area2` VALUES ('3265', '0001003100110002', '和田县', '3264', '653221');
INSERT INTO `system_area2` VALUES ('3266', '0001003100110003', '墨玉县', '3265', '653222');
INSERT INTO `system_area2` VALUES ('3267', '0001003100110004', '皮山县', '3266', '653223');
INSERT INTO `system_area2` VALUES ('3268', '0001003100110005', '洛浦县', '3267', '653224');
INSERT INTO `system_area2` VALUES ('3269', '0001003100110006', '策勒县', '3268', '653225');
INSERT INTO `system_area2` VALUES ('3270', '0001003100110007', '于田县', '3269', '653226');
INSERT INTO `system_area2` VALUES ('3271', '0001003100110008', '民丰县', '3270', '653227');
INSERT INTO `system_area2` VALUES ('3272', '000100310012', '伊犁哈萨克自治州', '3271', '654000');
INSERT INTO `system_area2` VALUES ('3273', '0001003100120001', '伊宁市', '3272', '654002');
INSERT INTO `system_area2` VALUES ('3274', '0001003100120002', '奎屯市', '3273', '654003');
INSERT INTO `system_area2` VALUES ('3275', '0001003100120003', '伊宁县', '3274', '654021');
INSERT INTO `system_area2` VALUES ('3276', '0001003100120004', '察布查尔锡伯自治县', '3275', '654022');
INSERT INTO `system_area2` VALUES ('3277', '0001003100120005', '霍城县', '3276', '654023');
INSERT INTO `system_area2` VALUES ('3278', '0001003100120006', '巩留县', '3277', '654024');
INSERT INTO `system_area2` VALUES ('3279', '0001003100120007', '新源县', '3278', '654025');
INSERT INTO `system_area2` VALUES ('3280', '0001003100120008', '昭苏县', '3279', '654026');
INSERT INTO `system_area2` VALUES ('3281', '0001003100120009', '特克斯县', '3280', '654027');
INSERT INTO `system_area2` VALUES ('3282', '0001003100120010', '尼勒克县', '3281', '654028');
INSERT INTO `system_area2` VALUES ('3283', '000100310013', '塔城地区', '3282', '654200');
INSERT INTO `system_area2` VALUES ('3284', '0001003100130001', '塔城市', '3283', '654201');
INSERT INTO `system_area2` VALUES ('3285', '0001003100130002', '乌苏市', '3284', '654202');
INSERT INTO `system_area2` VALUES ('3286', '0001003100130003', '额敏县', '3285', '654221');
INSERT INTO `system_area2` VALUES ('3287', '0001003100130004', '沙湾县', '3286', '654223');
INSERT INTO `system_area2` VALUES ('3288', '0001003100130005', '托里县', '3287', '654224');
INSERT INTO `system_area2` VALUES ('3289', '0001003100130006', '裕民县', '3288', '654225');
INSERT INTO `system_area2` VALUES ('3290', '0001003100130007', '和布克赛尔蒙古自治县', '3289', '654226');
INSERT INTO `system_area2` VALUES ('3291', '000100310014', '阿勒泰地区', '3290', '654300');
INSERT INTO `system_area2` VALUES ('3292', '0001003100140001', '阿勒泰市', '3291', '654301');
INSERT INTO `system_area2` VALUES ('3293', '0001003100140002', '布尔津县', '3292', '654321');
INSERT INTO `system_area2` VALUES ('3294', '0001003100140003', '富蕴县', '3293', '654322');
INSERT INTO `system_area2` VALUES ('3295', '0001003100140004', '福海县', '3294', '654323');
INSERT INTO `system_area2` VALUES ('3296', '0001003100140005', '哈巴河县', '3295', '654324');
INSERT INTO `system_area2` VALUES ('3297', '0001003100140006', '青河县', '3296', '654325');
INSERT INTO `system_area2` VALUES ('3298', '0001003100140007', '吉木乃县', '3297', '654326');
INSERT INTO `system_area2` VALUES ('3299', '000100310015', '石河子市', '3298', '659001');
INSERT INTO `system_area2` VALUES ('3300', '000100310016', '阿拉尔市', '3299', '659002');
INSERT INTO `system_area2` VALUES ('3301', '000100310017', '图木舒克市', '3300', '659003');
INSERT INTO `system_area2` VALUES ('3302', '000100310018', '五家渠市', '3301', '659004');
INSERT INTO `system_area2` VALUES ('3303', '00010032', '台湾省', '3302', '710000');
INSERT INTO `system_area2` VALUES ('3304', '000100320001', '台北市', '3303', '710100');
INSERT INTO `system_area2` VALUES ('3305', '0001003200010001', '中正区', '3304', '710101');
INSERT INTO `system_area2` VALUES ('3306', '0001003200010002', '大同区', '3305', '710102');
INSERT INTO `system_area2` VALUES ('3307', '0001003200010003', '中山区', '3306', '710103');
INSERT INTO `system_area2` VALUES ('3308', '0001003200010004', '松山区', '3307', '710104');
INSERT INTO `system_area2` VALUES ('3309', '0001003200010005', '大安区', '3308', '710105');
INSERT INTO `system_area2` VALUES ('3310', '0001003200010006', '万华区', '3309', '710106');
INSERT INTO `system_area2` VALUES ('3311', '0001003200010007', '信义区', '3310', '710107');
INSERT INTO `system_area2` VALUES ('3312', '0001003200010008', '士林区', '3311', '710108');
INSERT INTO `system_area2` VALUES ('3313', '0001003200010009', '北投区', '3312', '710109');
INSERT INTO `system_area2` VALUES ('3314', '0001003200010010', '内湖区', '3313', '710110');
INSERT INTO `system_area2` VALUES ('3315', '0001003200010011', '南港区', '3314', '710111');
INSERT INTO `system_area2` VALUES ('3316', '0001003200010012', '文山区', '3315', '710112');
INSERT INTO `system_area2` VALUES ('3317', '000100320002', '高雄市', '3316', '710200');
INSERT INTO `system_area2` VALUES ('3318', '0001003200020001', '新兴区', '3317', '710201');
INSERT INTO `system_area2` VALUES ('3319', '0001003200020002', '前金区', '3318', '710202');
INSERT INTO `system_area2` VALUES ('3320', '0001003200020003', '芩雅区', '3319', '710203');
INSERT INTO `system_area2` VALUES ('3321', '0001003200020004', '盐埕区', '3320', '710204');
INSERT INTO `system_area2` VALUES ('3322', '0001003200020005', '鼓山区', '3321', '710205');
INSERT INTO `system_area2` VALUES ('3323', '0001003200020006', '旗津区', '3322', '710206');
INSERT INTO `system_area2` VALUES ('3324', '0001003200020007', '前镇区', '3323', '710207');
INSERT INTO `system_area2` VALUES ('3325', '0001003200020008', '三民区', '3324', '710208');
INSERT INTO `system_area2` VALUES ('3326', '0001003200020009', '左营区', '3325', '710209');
INSERT INTO `system_area2` VALUES ('3327', '0001003200020010', '楠梓区', '3326', '710210');
INSERT INTO `system_area2` VALUES ('3328', '0001003200020011', '小港区', '3327', '710211');
INSERT INTO `system_area2` VALUES ('3329', '000100320003', '台南市', '3328', '710300');
INSERT INTO `system_area2` VALUES ('3330', '0001003200030001', '中西区', '3329', '710301');
INSERT INTO `system_area2` VALUES ('3331', '0001003200030002', '东区', '3330', '710302');
INSERT INTO `system_area2` VALUES ('3332', '0001003200030003', '南区', '3331', '710303');
INSERT INTO `system_area2` VALUES ('3333', '0001003200030004', '北区', '3332', '710304');
INSERT INTO `system_area2` VALUES ('3334', '0001003200030005', '安平区', '3333', '710305');
INSERT INTO `system_area2` VALUES ('3335', '0001003200030006', '安南区', '3334', '710306');
INSERT INTO `system_area2` VALUES ('3336', '000100320004', '台中市', '3335', '710400');
INSERT INTO `system_area2` VALUES ('3337', '0001003200040001', '中区', '3336', '710401');
INSERT INTO `system_area2` VALUES ('3338', '0001003200040002', '东区', '3337', '710402');
INSERT INTO `system_area2` VALUES ('3339', '0001003200040003', '南区', '3338', '710403');
INSERT INTO `system_area2` VALUES ('3340', '0001003200040004', '西区', '3339', '710404');
INSERT INTO `system_area2` VALUES ('3341', '0001003200040005', '北区', '3340', '710405');
INSERT INTO `system_area2` VALUES ('3342', '0001003200040006', '北屯区', '3341', '710406');
INSERT INTO `system_area2` VALUES ('3343', '0001003200040007', '西屯区', '3342', '710407');
INSERT INTO `system_area2` VALUES ('3344', '0001003200040008', '南屯区', '3343', '710408');
INSERT INTO `system_area2` VALUES ('3345', '000100320005', '金门县', '3344', '710500');
INSERT INTO `system_area2` VALUES ('3346', '000100320006', '南投县', '3345', '710600');
INSERT INTO `system_area2` VALUES ('3347', '000100320007', '基隆市', '3346', '710700');
INSERT INTO `system_area2` VALUES ('3348', '0001003200070001', '仁爱区', '3347', '710701');
INSERT INTO `system_area2` VALUES ('3349', '0001003200070002', '信义区', '3348', '710702');
INSERT INTO `system_area2` VALUES ('3350', '0001003200070003', '中正区', '3349', '710703');
INSERT INTO `system_area2` VALUES ('3351', '0001003200070004', '中山区', '3350', '710704');
INSERT INTO `system_area2` VALUES ('3352', '0001003200070005', '安乐区', '3351', '710705');
INSERT INTO `system_area2` VALUES ('3353', '0001003200070006', '暖暖区', '3352', '710706');
INSERT INTO `system_area2` VALUES ('3354', '0001003200070007', '七堵区', '3353', '710707');
INSERT INTO `system_area2` VALUES ('3355', '000100320008', '新竹市', '3354', '710800');
INSERT INTO `system_area2` VALUES ('3356', '0001003200080001', '东区', '3355', '710801');
INSERT INTO `system_area2` VALUES ('3357', '0001003200080002', '北区', '3356', '710802');
INSERT INTO `system_area2` VALUES ('3358', '0001003200080003', '香山区', '3357', '710803');
INSERT INTO `system_area2` VALUES ('3359', '000100320009', '嘉义市', '3358', '710900');
INSERT INTO `system_area2` VALUES ('3360', '0001003200090001', '东区', '3359', '710901');
INSERT INTO `system_area2` VALUES ('3361', '0001003200090002', '西区', '3360', '710902');
INSERT INTO `system_area2` VALUES ('3362', '000100320010', '新北市', '3361', '711100');
INSERT INTO `system_area2` VALUES ('3363', '000100320011', '宜兰县', '3362', '711200');
INSERT INTO `system_area2` VALUES ('3364', '000100320012', '新竹县', '3363', '711300');
INSERT INTO `system_area2` VALUES ('3365', '000100320013', '桃园县', '3364', '711400');
INSERT INTO `system_area2` VALUES ('3366', '000100320014', '苗栗县', '3365', '711500');
INSERT INTO `system_area2` VALUES ('3367', '000100320015', '彰化县', '3366', '711700');
INSERT INTO `system_area2` VALUES ('3368', '000100320016', '嘉义县', '3367', '711900');
INSERT INTO `system_area2` VALUES ('3369', '000100320017', '云林县', '3368', '712100');
INSERT INTO `system_area2` VALUES ('3370', '000100320018', '屏东县', '3369', '712400');
INSERT INTO `system_area2` VALUES ('3371', '000100320019', '台东县', '3370', '712500');
INSERT INTO `system_area2` VALUES ('3372', '000100320020', '花莲县', '3371', '712600');
INSERT INTO `system_area2` VALUES ('3373', '000100320021', '澎湖县', '3372', '712700');
INSERT INTO `system_area2` VALUES ('3374', '00010033', '香港特别行政区', '3373', '810000');
INSERT INTO `system_area2` VALUES ('3375', '000100330001', '香港岛', '3374', '810100');
INSERT INTO `system_area2` VALUES ('3376', '0001003300010001', '中西区', '3375', '810101');
INSERT INTO `system_area2` VALUES ('3377', '0001003300010002', '湾仔', '3376', '810102');
INSERT INTO `system_area2` VALUES ('3378', '0001003300010003', '东区', '3377', '810103');
INSERT INTO `system_area2` VALUES ('3379', '0001003300010004', '南区', '3378', '810104');
INSERT INTO `system_area2` VALUES ('3380', '000100330002', '九龙', '3379', '810200');
INSERT INTO `system_area2` VALUES ('3381', '0001003300020001', '九龙城区', '3380', '810201');
INSERT INTO `system_area2` VALUES ('3382', '0001003300020002', '油尖旺区', '3381', '810202');
INSERT INTO `system_area2` VALUES ('3383', '0001003300020003', '深水埗区', '3382', '810203');
INSERT INTO `system_area2` VALUES ('3384', '0001003300020004', '黄大仙区', '3383', '810204');
INSERT INTO `system_area2` VALUES ('3385', '0001003300020005', '观塘区', '3384', '810205');
INSERT INTO `system_area2` VALUES ('3386', '000100330003', '新界', '3385', '810300');
INSERT INTO `system_area2` VALUES ('3387', '0001003300030001', '北区', '3386', '810301');
INSERT INTO `system_area2` VALUES ('3388', '0001003300030002', '大埔区', '3387', '810302');
INSERT INTO `system_area2` VALUES ('3389', '0001003300030003', '沙田区', '3388', '810303');
INSERT INTO `system_area2` VALUES ('3390', '0001003300030004', '西贡区', '3389', '810304');
INSERT INTO `system_area2` VALUES ('3391', '0001003300030005', '元朗区', '3390', '810305');
INSERT INTO `system_area2` VALUES ('3392', '0001003300030006', '屯门区', '3391', '810306');
INSERT INTO `system_area2` VALUES ('3393', '0001003300030007', '荃湾区', '3392', '810307');
INSERT INTO `system_area2` VALUES ('3394', '0001003300030008', '葵青区', '3393', '810308');
INSERT INTO `system_area2` VALUES ('3395', '0001003300030009', '离岛区', '3394', '810309');
INSERT INTO `system_area2` VALUES ('3396', '00010034', '澳门特别行政区', '3395', '820000');
INSERT INTO `system_area2` VALUES ('3397', '000100340001', '澳门半岛', '3396', '820100');
INSERT INTO `system_area2` VALUES ('3398', '000100340002', '离岛', '3397', '820200');
INSERT INTO `system_area2` VALUES ('3399', '00010035', '海外', '3398', '990000');
INSERT INTO `system_area2` VALUES ('3400', '000100350001', 'Afghanistan/阿富汗', '3399', '2');
INSERT INTO `system_area2` VALUES ('3401', '000100350002', 'Aland Islands/奥兰群岛', '3400', '3');
INSERT INTO `system_area2` VALUES ('3402', '000100350003', 'Alaska(U.S.A)/阿拉斯加', '3401', '4');
INSERT INTO `system_area2` VALUES ('3403', '000100350004', 'Albania/阿尔巴尼亚', '3402', '5');
INSERT INTO `system_area2` VALUES ('3404', '000100350005', 'Algeria/阿尔及利亚', '3403', '6');
INSERT INTO `system_area2` VALUES ('3405', '000100350006', 'American Samoa/东萨摩亚(美)', '3404', '7');
INSERT INTO `system_area2` VALUES ('3406', '000100350007', 'Andorra/安道尔', '3405', '8');
INSERT INTO `system_area2` VALUES ('3407', '000100350008', 'Angola/安哥拉', '3406', '9');
INSERT INTO `system_area2` VALUES ('3408', '000100350009', 'Anguilla/安圭拉岛(英)', '3407', '10');
INSERT INTO `system_area2` VALUES ('3409', '000100350010', 'Antarctica/南极', '3408', '11');
INSERT INTO `system_area2` VALUES ('3410', '000100350011', 'Antigua and Barbuda/安提瓜和巴布达', '3409', '12');
INSERT INTO `system_area2` VALUES ('3411', '000100350012', 'Argentina/阿根廷', '3410', '13');
INSERT INTO `system_area2` VALUES ('3412', '000100350013', 'Armenia/亚美尼亚', '3411', '14');
INSERT INTO `system_area2` VALUES ('3413', '000100350014', 'Aruba/阿鲁巴岛', '3412', '15');
INSERT INTO `system_area2` VALUES ('3414', '000100350015', 'Australia/澳大利亚', '3413', '16');
INSERT INTO `system_area2` VALUES ('3415', '000100350016', 'Austria/奥地利', '3414', '17');
INSERT INTO `system_area2` VALUES ('3416', '000100350017', 'Azerbaijan/阿塞拜疆', '3415', '18');
INSERT INTO `system_area2` VALUES ('3417', '000100350018', 'Bahrain/巴林', '3416', '19');
INSERT INTO `system_area2` VALUES ('3418', '000100350019', 'Bailiwick of Guernsey/根西岛(英)', '3417', '20');
INSERT INTO `system_area2` VALUES ('3419', '000100350020', 'Bangladesh/孟加拉国', '3418', '21');
INSERT INTO `system_area2` VALUES ('3420', '000100350021', 'Barbados/巴巴多斯', '3419', '22');
INSERT INTO `system_area2` VALUES ('3421', '000100350022', 'Belarus/白俄罗斯', '3420', '23');
INSERT INTO `system_area2` VALUES ('3422', '000100350023', 'Belgium/比利时', '3421', '24');
INSERT INTO `system_area2` VALUES ('3423', '000100350024', 'Belize/伯利兹', '3422', '25');
INSERT INTO `system_area2` VALUES ('3424', '000100350025', 'Benin/贝宁', '3423', '26');
INSERT INTO `system_area2` VALUES ('3425', '000100350026', 'Bermuda/百慕大群岛(英)', '3424', '27');
INSERT INTO `system_area2` VALUES ('3426', '000100350027', 'Bhutan/不丹', '3425', '28');
INSERT INTO `system_area2` VALUES ('3427', '000100350028', 'Bolivia/玻利维亚', '3426', '29');
INSERT INTO `system_area2` VALUES ('3428', '000100350029', 'Bosnia and Herzegovina/波斯尼亚和黑塞哥维那', '3427', '30');
INSERT INTO `system_area2` VALUES ('3429', '000100350030', 'Botswana/博茨瓦纳', '3428', '31');
INSERT INTO `system_area2` VALUES ('3430', '000100350031', 'Brazil/巴西', '3429', '32');
INSERT INTO `system_area2` VALUES ('3431', '000100350032', 'Bulgaria/保加利亚', '3430', '33');
INSERT INTO `system_area2` VALUES ('3432', '000100350033', 'Burkinafaso/布基纳法索', '3431', '34');
INSERT INTO `system_area2` VALUES ('3433', '000100350034', 'Burundi/布隆迪', '3432', '35');
INSERT INTO `system_area2` VALUES ('3434', '000100350035', 'Cameroon/喀麦隆', '3433', '36');
INSERT INTO `system_area2` VALUES ('3435', '000100350036', 'Canada/加拿大', '3434', '37');
INSERT INTO `system_area2` VALUES ('3436', '000100350037', 'Canaries Island/加那利群岛', '3435', '38');
INSERT INTO `system_area2` VALUES ('3437', '000100350038', 'Cape Verde/佛得角', '3436', '39');
INSERT INTO `system_area2` VALUES ('3438', '000100350039', 'Cayman Islands/开曼群岛(英)', '3437', '40');
INSERT INTO `system_area2` VALUES ('3439', '000100350040', 'Central African Republic/中非', '3438', '41');
INSERT INTO `system_area2` VALUES ('3440', '000100350041', 'Chad/乍得', '3439', '42');
INSERT INTO `system_area2` VALUES ('3441', '000100350042', 'Chile/智利', '3440', '43');
INSERT INTO `system_area2` VALUES ('3442', '000100350043', 'Christmas Island/圣诞岛', '3441', '44');
INSERT INTO `system_area2` VALUES ('3443', '000100350044', 'Cocos (Keeling) Islands/科科斯岛', '3442', '45');
INSERT INTO `system_area2` VALUES ('3444', '000100350045', 'Colombia/哥伦比亚', '3443', '46');
INSERT INTO `system_area2` VALUES ('3445', '000100350046', 'Comoros/科摩罗', '3444', '47');
INSERT INTO `system_area2` VALUES ('3446', '000100350047', 'Congo/刚果', '3445', '48');
INSERT INTO `system_area2` VALUES ('3447', '000100350048', 'Cook Island/科克群岛(新)', '3446', '49');
INSERT INTO `system_area2` VALUES ('3448', '000100350049', 'Costa Rica/哥斯达黎加', '3447', '50');
INSERT INTO `system_area2` VALUES ('3449', '000100350050', 'Croatia/克罗地亚', '3448', '51');
INSERT INTO `system_area2` VALUES ('3450', '000100350051', 'Cuba/古巴', '3449', '52');
INSERT INTO `system_area2` VALUES ('3451', '000100350052', 'Cyprus/塞浦路斯', '3450', '53');
INSERT INTO `system_area2` VALUES ('3452', '000100350053', 'Czech/捷克', '3451', '54');
INSERT INTO `system_area2` VALUES ('3453', '000100350054', 'Democratic Republic of the Congo/刚果(金)', '3452', '55');
INSERT INTO `system_area2` VALUES ('3454', '000100350055', 'Denmark/丹麦', '3453', '56');
INSERT INTO `system_area2` VALUES ('3455', '000100350056', 'Diego Garcia/迪戈加西亚岛', '3454', '57');
INSERT INTO `system_area2` VALUES ('3456', '000100350057', 'Djibouti/吉布提', '3455', '58');
INSERT INTO `system_area2` VALUES ('3457', '000100350058', 'Dominica/多米尼克国', '3456', '59');
INSERT INTO `system_area2` VALUES ('3458', '000100350059', 'Dominican Republic/多米尼加共和国', '3457', '60');
INSERT INTO `system_area2` VALUES ('3459', '000100350060', 'Ecuador/厄瓜多尔', '3458', '61');
INSERT INTO `system_area2` VALUES ('3460', '000100350061', 'Egypt/埃及', '3459', '62');
INSERT INTO `system_area2` VALUES ('3461', '000100350062', 'El Salvador/萨尔瓦多', '3460', '63');
INSERT INTO `system_area2` VALUES ('3462', '000100350063', 'Equatorial Guinea/赤道几内亚', '3461', '64');
INSERT INTO `system_area2` VALUES ('3463', '000100350064', 'Eritrea/厄立特里亚', '3462', '65');
INSERT INTO `system_area2` VALUES ('3464', '000100350065', 'Estonia/爱沙尼亚', '3463', '66');
INSERT INTO `system_area2` VALUES ('3465', '000100350066', 'Ethiopia/埃塞俄比亚', '3464', '67');
INSERT INTO `system_area2` VALUES ('3466', '000100350067', 'Falkland Islands (Malvinas)/福克兰群岛', '3465', '68');
INSERT INTO `system_area2` VALUES ('3467', '000100350068', 'Faroe Islands/法罗群岛(丹)', '3466', '69');
INSERT INTO `system_area2` VALUES ('3468', '000100350069', 'Fiji/斐济', '3467', '70');
INSERT INTO `system_area2` VALUES ('3469', '000100350070', 'Finland/芬兰', '3468', '71');
INSERT INTO `system_area2` VALUES ('3470', '000100350071', 'France/法国', '3469', '72');
INSERT INTO `system_area2` VALUES ('3471', '000100350072', 'French Polynesia/法属波里尼西亚', '3470', '73');
INSERT INTO `system_area2` VALUES ('3472', '000100350073', 'Gabon/加蓬', '3471', '74');
INSERT INTO `system_area2` VALUES ('3473', '000100350074', 'Gambia/冈比亚', '3472', '75');
INSERT INTO `system_area2` VALUES ('3474', '000100350075', 'Georgia/格鲁吉亚', '3473', '76');
INSERT INTO `system_area2` VALUES ('3475', '000100350076', 'Germany/德国', '3474', '77');
INSERT INTO `system_area2` VALUES ('3476', '000100350077', 'Ghana/加纳', '3475', '78');
INSERT INTO `system_area2` VALUES ('3477', '000100350078', 'Gibraltar/直布罗陀(英)', '3476', '79');
INSERT INTO `system_area2` VALUES ('3478', '000100350079', 'Greece/希腊', '3477', '80');
INSERT INTO `system_area2` VALUES ('3479', '000100350080', 'Greenland/格陵兰岛', '3478', '81');
INSERT INTO `system_area2` VALUES ('3480', '000100350081', 'Grenada/格林纳达', '3479', '82');
INSERT INTO `system_area2` VALUES ('3481', '000100350082', 'Guadeloupe/瓜德罗普岛(法)', '3480', '83');
INSERT INTO `system_area2` VALUES ('3482', '000100350083', 'Guam/关岛(美)', '3481', '84');
INSERT INTO `system_area2` VALUES ('3483', '000100350084', 'Guatemala/危地马拉', '3482', '85');
INSERT INTO `system_area2` VALUES ('3484', '000100350085', 'Guinea/几内亚', '3483', '86');
INSERT INTO `system_area2` VALUES ('3485', '000100350086', 'Guinea-bissau/几内亚比绍', '3484', '87');
INSERT INTO `system_area2` VALUES ('3486', '000100350087', 'Guyana/法属圭亚那', '3485', '88');
INSERT INTO `system_area2` VALUES ('3487', '000100350088', 'Guyana/圭亚那', '3486', '89');
INSERT INTO `system_area2` VALUES ('3488', '000100350089', 'Haiti/海地', '3487', '90');
INSERT INTO `system_area2` VALUES ('3489', '000100350090', 'Honduras/洪都拉斯', '3488', '91');
INSERT INTO `system_area2` VALUES ('3490', '000100350091', 'HunGary/匈牙利', '3489', '92');
INSERT INTO `system_area2` VALUES ('3491', '000100350092', 'Iceland/冰岛', '3490', '93');
INSERT INTO `system_area2` VALUES ('3492', '000100350093', 'India/印度', '3491', '94');
INSERT INTO `system_area2` VALUES ('3493', '000100350094', 'Indonesia/印度尼西亚', '3492', '95');
INSERT INTO `system_area2` VALUES ('3494', '000100350095', 'Iran/伊郎', '3493', '96');
INSERT INTO `system_area2` VALUES ('3495', '000100350096', 'Iraq/伊拉克', '3494', '97');
INSERT INTO `system_area2` VALUES ('3496', '000100350097', 'Ireland/爱尔兰', '3495', '98');
INSERT INTO `system_area2` VALUES ('3497', '000100350098', 'Isle of Man/马恩岛(英)', '3496', '99');
INSERT INTO `system_area2` VALUES ('3498', '000100350099', 'Israel/以色列', '3497', '100');
INSERT INTO `system_area2` VALUES ('3499', '000100350100', 'Italy/意大利', '3498', '101');
INSERT INTO `system_area2` VALUES ('3500', '000100350101', 'Ivory Coast/科特迪瓦', '3499', '102');
INSERT INTO `system_area2` VALUES ('3501', '000100350102', 'Jamaica/牙买加', '3500', '103');
INSERT INTO `system_area2` VALUES ('3502', '000100350103', 'Japan/日本', '3501', '104');
INSERT INTO `system_area2` VALUES ('3503', '000100350104', 'Jersey/泽西岛(英)', '3502', '105');
INSERT INTO `system_area2` VALUES ('3504', '000100350105', 'Jordan/约旦', '3503', '106');
INSERT INTO `system_area2` VALUES ('3505', '000100350106', 'Kampuchea/柬埔塞', '3504', '107');
INSERT INTO `system_area2` VALUES ('3506', '000100350107', 'Kazakhstan/哈萨克斯坦', '3505', '108');
INSERT INTO `system_area2` VALUES ('3507', '000100350108', 'Kenya/肯尼亚', '3506', '109');
INSERT INTO `system_area2` VALUES ('3508', '000100350109', 'Kiribati/基里巴斯', '3507', '110');
INSERT INTO `system_area2` VALUES ('3509', '000100350110', 'Kuwait/科威特', '3508', '111');
INSERT INTO `system_area2` VALUES ('3510', '000100350111', 'Kyrgyzstan/吉尔吉斯斯坦', '3509', '112');
INSERT INTO `system_area2` VALUES ('3511', '000100350112', 'Laos/老挝', '3510', '113');
INSERT INTO `system_area2` VALUES ('3512', '000100350113', 'Latvia/拉脱维亚', '3511', '114');
INSERT INTO `system_area2` VALUES ('3513', '000100350114', 'Lebanon/黎巴嫩', '3512', '115');
INSERT INTO `system_area2` VALUES ('3514', '000100350115', 'Lesotho/莱索托', '3513', '116');
INSERT INTO `system_area2` VALUES ('3515', '000100350116', 'Liberia/利比里亚', '3514', '117');
INSERT INTO `system_area2` VALUES ('3516', '000100350117', 'Libya/利比亚', '3515', '118');
INSERT INTO `system_area2` VALUES ('3517', '000100350118', 'Liechtenstein/列支敦士登', '3516', '119');
INSERT INTO `system_area2` VALUES ('3518', '000100350119', 'Lithuania/立陶宛', '3517', '120');
INSERT INTO `system_area2` VALUES ('3519', '000100350120', 'Luxembourg/卢森堡', '3518', '121');
INSERT INTO `system_area2` VALUES ('3520', '000100350121', 'Macedonia/马其顿', '3519', '122');
INSERT INTO `system_area2` VALUES ('3521', '000100350122', 'Madagascar/马达加斯加', '3520', '123');
INSERT INTO `system_area2` VALUES ('3522', '000100350123', 'Malawi/马拉维', '3521', '124');
INSERT INTO `system_area2` VALUES ('3523', '000100350124', 'Malaysia/马来西亚', '3522', '125');
INSERT INTO `system_area2` VALUES ('3524', '000100350125', 'Maldives/马尔代夫', '3523', '126');
INSERT INTO `system_area2` VALUES ('3525', '000100350126', 'Mali/马里', '3524', '127');
INSERT INTO `system_area2` VALUES ('3526', '000100350127', 'Malta/马耳他', '3525', '128');
INSERT INTO `system_area2` VALUES ('3527', '000100350128', 'Marshall Island/马绍尔群岛', '3526', '129');
INSERT INTO `system_area2` VALUES ('3528', '000100350129', 'Martinique/马提尼克(法)', '3527', '130');
INSERT INTO `system_area2` VALUES ('3529', '000100350130', 'Mauritania/毛里塔尼亚', '3528', '131');
INSERT INTO `system_area2` VALUES ('3530', '000100350131', 'Mauritius/毛里求斯', '3529', '132');
INSERT INTO `system_area2` VALUES ('3531', '000100350132', 'Mayotte/马约特岛', '3530', '133');
INSERT INTO `system_area2` VALUES ('3532', '000100350133', 'Mexico/墨西哥', '3531', '134');
INSERT INTO `system_area2` VALUES ('3533', '000100350134', 'Micronesia/密克罗尼西亚(美)', '3532', '135');
INSERT INTO `system_area2` VALUES ('3534', '000100350135', 'Midway Island/中途岛(美)', '3533', '136');
INSERT INTO `system_area2` VALUES ('3535', '000100350136', 'Monaco/摩纳哥', '3534', '137');
INSERT INTO `system_area2` VALUES ('3536', '000100350137', 'Mongolia/蒙古', '3535', '138');
INSERT INTO `system_area2` VALUES ('3537', '000100350138', 'Montenegro/黑山', '3536', '139');
INSERT INTO `system_area2` VALUES ('3538', '000100350139', 'Montserrat/蒙特塞拉特岛(英)', '3537', '140');
INSERT INTO `system_area2` VALUES ('3539', '000100350140', 'Morocco/摩洛哥', '3538', '141');
INSERT INTO `system_area2` VALUES ('3540', '000100350141', 'Mozambique/莫桑比克', '3539', '142');
INSERT INTO `system_area2` VALUES ('3541', '000100350142', 'Myanmar/缅甸', '3540', '143');
INSERT INTO `system_area2` VALUES ('3542', '000100350143', 'Namibia/纳米比亚', '3541', '144');
INSERT INTO `system_area2` VALUES ('3543', '000100350144', 'Nauru/瑙鲁', '3542', '145');
INSERT INTO `system_area2` VALUES ('3544', '000100350145', 'Nepal/尼泊尔', '3543', '146');
INSERT INTO `system_area2` VALUES ('3545', '000100350146', 'Netherlands/荷兰', '3544', '147');
INSERT INTO `system_area2` VALUES ('3546', '000100350147', 'Netherlands Antilles/荷属安的列斯群岛', '3545', '148');
INSERT INTO `system_area2` VALUES ('3547', '000100350148', 'New Caledonia/新喀里多尼亚群岛(法)', '3546', '149');
INSERT INTO `system_area2` VALUES ('3548', '000100350149', 'New Zealand/新西兰', '3547', '150');
INSERT INTO `system_area2` VALUES ('3549', '000100350150', 'Nicaragua/尼加拉瓜', '3548', '151');
INSERT INTO `system_area2` VALUES ('3550', '000100350151', 'Niger/尼日尔', '3549', '152');
INSERT INTO `system_area2` VALUES ('3551', '000100350152', 'Nigeria/尼日利亚', '3550', '153');
INSERT INTO `system_area2` VALUES ('3552', '000100350153', 'Niue/纽埃岛(新)', '3551', '154');
INSERT INTO `system_area2` VALUES ('3553', '000100350154', 'Norfolk Island/诺福克岛(澳)', '3552', '155');
INSERT INTO `system_area2` VALUES ('3554', '000100350155', 'North Korea/朝鲜', '3553', '156');
INSERT INTO `system_area2` VALUES ('3555', '000100350156', 'Northern Mariana Islands/马里亚纳群岛', '3554', '157');
INSERT INTO `system_area2` VALUES ('3556', '000100350157', 'Norway/挪威', '3555', '158');
INSERT INTO `system_area2` VALUES ('3557', '000100350158', 'Oman/阿曼', '3556', '159');
INSERT INTO `system_area2` VALUES ('3558', '000100350159', 'Pakistan/巴基斯坦', '3557', '160');
INSERT INTO `system_area2` VALUES ('3559', '000100350160', 'Palau/帕劳(美)', '3558', '161');
INSERT INTO `system_area2` VALUES ('3560', '000100350161', 'Panama/巴拿马', '3559', '162');
INSERT INTO `system_area2` VALUES ('3561', '000100350162', 'Papua New Guinea/巴布亚新几内亚', '3560', '163');
INSERT INTO `system_area2` VALUES ('3562', '000100350163', 'Paraguay/巴拉圭', '3561', '164');
INSERT INTO `system_area2` VALUES ('3563', '000100350164', 'Peru/秘鲁', '3562', '165');
INSERT INTO `system_area2` VALUES ('3564', '000100350165', 'Philippines/菲律宾', '3563', '166');
INSERT INTO `system_area2` VALUES ('3565', '000100350166', 'Poland/波兰', '3564', '167');
INSERT INTO `system_area2` VALUES ('3566', '000100350167', 'Portugal/葡萄牙', '3565', '168');
INSERT INTO `system_area2` VALUES ('3567', '000100350168', 'Puerto Rico/波多黎各(美)', '3566', '169');
INSERT INTO `system_area2` VALUES ('3568', '000100350169', 'Qatar/卡塔尔', '3567', '170');
INSERT INTO `system_area2` VALUES ('3569', '000100350170', 'Republic of Moldova/摩尔多瓦', '3568', '171');
INSERT INTO `system_area2` VALUES ('3570', '000100350171', 'Reunion/留尼汪岛', '3569', '172');
INSERT INTO `system_area2` VALUES ('3571', '000100350172', 'Romania/罗马尼亚', '3570', '173');
INSERT INTO `system_area2` VALUES ('3572', '000100350173', 'Russian Federation/俄罗斯', '3571', '174');
INSERT INTO `system_area2` VALUES ('3573', '000100350174', 'Rwanda/卢旺达', '3572', '175');
INSERT INTO `system_area2` VALUES ('3574', '000100350175', 'Saint Helena, Ascension and Tristan da Cunha/阿森松(英)', '3573', '176');
INSERT INTO `system_area2` VALUES ('3575', '000100350176', 'Saint Helena, Ascension and Tristan da Cunha/圣赫勒拿', '3574', '177');
INSERT INTO `system_area2` VALUES ('3576', '000100350177', 'Saint Kitts and Nevis/圣克里斯托弗和尼维斯', '3575', '178');
INSERT INTO `system_area2` VALUES ('3577', '000100350178', 'Saint Lucia/圣卢西亚', '3576', '179');
INSERT INTO `system_area2` VALUES ('3578', '000100350179', 'Saint Pierre and Miquelon/圣皮埃尔岛及密克隆岛', '3577', '180');
INSERT INTO `system_area2` VALUES ('3579', '000100350180', 'Saint Vincent and the Grenadines/圣文森特岛(英)', '3578', '181');
INSERT INTO `system_area2` VALUES ('3580', '000100350181', 'Samoa/西萨摩亚', '3579', '182');
INSERT INTO `system_area2` VALUES ('3581', '000100350182', 'San Marino/圣马力诺', '3580', '183');
INSERT INTO `system_area2` VALUES ('3582', '000100350183', 'Sao Tome and Principe/圣多美和普林西比', '3581', '184');
INSERT INTO `system_area2` VALUES ('3583', '000100350184', 'Saudi Arabia/沙特阿拉伯', '3582', '185');
INSERT INTO `system_area2` VALUES ('3584', '000100350185', 'Senegal/塞内加尔', '3583', '186');
INSERT INTO `system_area2` VALUES ('3585', '000100350186', 'Serbia/塞尔维亚', '3584', '187');
INSERT INTO `system_area2` VALUES ('3586', '000100350187', 'Seychelles/塞舌尔', '3585', '188');
INSERT INTO `system_area2` VALUES ('3587', '000100350188', 'Sierra Leone/塞拉利昂', '3586', '189');
INSERT INTO `system_area2` VALUES ('3588', '000100350189', 'Singapore/新加坡', '3587', '190');
INSERT INTO `system_area2` VALUES ('3589', '000100350190', 'Sint Maarten/圣马丁(荷)', '3588', '191');
INSERT INTO `system_area2` VALUES ('3590', '000100350191', 'Slovakia/斯洛伐克', '3589', '192');
INSERT INTO `system_area2` VALUES ('3591', '000100350192', 'Slovenia/斯洛文尼亚', '3590', '193');
INSERT INTO `system_area2` VALUES ('3592', '000100350193', 'Solomon Islands/所罗门群岛', '3591', '194');
INSERT INTO `system_area2` VALUES ('3593', '000100350194', 'Somalia/索马里', '3592', '195');
INSERT INTO `system_area2` VALUES ('3594', '000100350195', 'South Africa/南非', '3593', '196');
INSERT INTO `system_area2` VALUES ('3595', '000100350196', 'South Georgia and The South Sandwich Islands/南乔治亚与南桑威奇群岛', '3594', '197');
INSERT INTO `system_area2` VALUES ('3596', '000100350197', 'South korea/韩国', '3595', '198');
INSERT INTO `system_area2` VALUES ('3597', '000100350198', 'Spain/西班牙', '3596', '199');
INSERT INTO `system_area2` VALUES ('3598', '000100350199', 'Sri Lanka/斯里兰卡', '3597', '200');
INSERT INTO `system_area2` VALUES ('3599', '000100350200', 'Sudan/苏丹', '3598', '201');
INSERT INTO `system_area2` VALUES ('3600', '000100350201', 'Suriname/苏里南', '3599', '202');
INSERT INTO `system_area2` VALUES ('3601', '000100350202', 'Svalbard and Jan Mayen/斯瓦尔巴群岛(挪)', '3600', '203');
INSERT INTO `system_area2` VALUES ('3602', '000100350203', 'Swaziland/斯威士兰', '3601', '204');
INSERT INTO `system_area2` VALUES ('3603', '000100350204', 'Sweden/瑞典', '3602', '205');
INSERT INTO `system_area2` VALUES ('3604', '000100350205', 'Switzerland/瑞士', '3603', '206');
INSERT INTO `system_area2` VALUES ('3605', '000100350206', 'Syria/叙利亚', '3604', '207');
INSERT INTO `system_area2` VALUES ('3606', '000100350207', 'Tajikistan/塔吉克斯坦', '3605', '208');
INSERT INTO `system_area2` VALUES ('3607', '000100350208', 'Thailand/泰国', '3606', '209');
INSERT INTO `system_area2` VALUES ('3608', '000100350209', 'The Commonwealth of The Bahamas/巴哈马国', '3607', '210');
INSERT INTO `system_area2` VALUES ('3609', '000100350210', 'The Vatican City State/梵蒂冈', '3608', '211');
INSERT INTO `system_area2` VALUES ('3610', '000100350211', 'Timor-leste/东帝汶', '3609', '212');
INSERT INTO `system_area2` VALUES ('3611', '000100350212', 'Togo/多哥', '3610', '213');
INSERT INTO `system_area2` VALUES ('3612', '000100350213', 'Tokelau/托克劳群岛(新)', '3611', '214');
INSERT INTO `system_area2` VALUES ('3613', '000100350214', 'Tonga/汤加', '3612', '215');
INSERT INTO `system_area2` VALUES ('3614', '000100350215', 'Trinidad and Tobago/特立尼达和多巴哥', '3613', '216');
INSERT INTO `system_area2` VALUES ('3615', '000100350216', 'Tunisia/突尼斯', '3614', '217');
INSERT INTO `system_area2` VALUES ('3616', '000100350217', 'Turkey/土耳其', '3615', '218');
INSERT INTO `system_area2` VALUES ('3617', '000100350218', 'Turkmenistan/土库曼斯坦', '3616', '219');
INSERT INTO `system_area2` VALUES ('3618', '000100350219', 'Turks and Caicos Islands/特克斯和凯科斯群岛(英)', '3617', '220');
INSERT INTO `system_area2` VALUES ('3619', '000100350220', 'Tuvalu/图瓦卢', '3618', '221');
INSERT INTO `system_area2` VALUES ('3620', '000100350221', 'Uganda/乌干达', '3619', '222');
INSERT INTO `system_area2` VALUES ('3621', '000100350222', 'Ukraine/乌克兰', '3620', '223');
INSERT INTO `system_area2` VALUES ('3622', '000100350223', 'United Arab Emirates/阿拉伯联合酋长国', '3621', '224');
INSERT INTO `system_area2` VALUES ('3623', '000100350224', 'United Kingdom/英国', '3622', '225');
INSERT INTO `system_area2` VALUES ('3624', '000100350225', 'United Republic of Tanzania/坦桑尼亚', '3623', '226');
INSERT INTO `system_area2` VALUES ('3625', '000100350226', 'United States Minor Outlying Islands/美国本土外小岛屿', '3624', '227');
INSERT INTO `system_area2` VALUES ('3626', '000100350227', 'United States of America/美国', '3625', '228');
INSERT INTO `system_area2` VALUES ('3627', '000100350228', 'Uruguay/乌拉圭', '3626', '229');
INSERT INTO `system_area2` VALUES ('3628', '000100350229', 'Uzbekistan/乌兹别克斯坦', '3627', '230');
INSERT INTO `system_area2` VALUES ('3629', '000100350230', 'Vanuatu/瓦努阿图', '3628', '231');
INSERT INTO `system_area2` VALUES ('3630', '000100350231', 'Venezuela/委内瑞拉', '3629', '232');
INSERT INTO `system_area2` VALUES ('3631', '000100350232', 'Vietnam/越南', '3630', '233');
INSERT INTO `system_area2` VALUES ('3632', '000100350233', 'Virgin Islands, British/维尔京群岛(英)', '3631', '234');
INSERT INTO `system_area2` VALUES ('3633', '000100350234', 'Virgin Islands, U.S./维尔京群岛(美)', '3632', '235');
INSERT INTO `system_area2` VALUES ('3634', '000100350235', 'Wallis And Futuna/瓦里斯和富士那群岛(法)', '3633', '236');
INSERT INTO `system_area2` VALUES ('3635', '000100350236', 'Western sahara/西撒哈拉', '3634', '237');
INSERT INTO `system_area2` VALUES ('3636', '000100350237', 'Yemen/也门', '3635', '238');
INSERT INTO `system_area2` VALUES ('3637', '000100350238', 'Yugoslavia/南斯拉夫', '3636', '239');
INSERT INTO `system_area2` VALUES ('3638', '000100350239', 'Zambia/赞比亚', '3637', '240');
INSERT INTO `system_area2` VALUES ('3639', '000100350240', 'Zanzibar/桑给巴尔', '3638', '241');
INSERT INTO `system_area2` VALUES ('3640', '000100350241', 'Zimbabwe/津巴布韦', '3639', '242');

-- ----------------------------
-- Table structure for system_cache
-- ----------------------------
DROP TABLE IF EXISTS `system_cache`;
CREATE TABLE `system_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '缓存名称',
  `cache_name` varchar(255) DEFAULT NULL COMMENT '缓存名称 必须与CacheConstant中保持一致',
  `state` tinyint(3) unsigned DEFAULT '0' COMMENT '缓存更新状态 0:未更新 1:更新成功 2:更新失败',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='缓存信息管理表';

-- ----------------------------
-- Records of system_cache
-- ----------------------------
INSERT INTO `system_cache` VALUES ('1', '系统参数缓存', 'system_config', '1', '2019-01-24 13:52:43', '全局系统参数缓存(查询缓存)');
INSERT INTO `system_cache` VALUES ('2', '数据字典缓存', 'system_dict', '1', '2019-01-24 13:52:43', '全局数据字典缓存(查询缓存)');
INSERT INTO `system_cache` VALUES ('3', 'vip等级配置缓存', 'vip_config', '1', '2019-01-24 13:52:43', '业务vip缓存(查询缓存)');
INSERT INTO `system_cache` VALUES ('4', '用户登陆token缓存', 'access_token', '1', '2019-01-24 13:52:43', '登陆信息(保存缓存)');
INSERT INTO `system_cache` VALUES ('5', '积分类型缓存', 'integral_classify', '1', '2019-01-24 13:52:43', '业务积分类型缓存(查询缓存)');
INSERT INTO `system_cache` VALUES ('6', '异步结果缓存', 'async_response', '1', '2019-01-24 13:52:43', '异步信息(保存缓存)');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nid` varchar(50) NOT NULL COMMENT '参数标示符',
  `title` varchar(50) DEFAULT NULL COMMENT '参数名称',
  `content` varchar(1000) NOT NULL COMMENT '参数值',
  `classify` tinyint(2) unsigned DEFAULT NULL COMMENT '参数类型,见system_dict表nid=config_classify',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态(禁止编辑) 0:未锁定,1:锁定',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `reserve_content` varchar(1000) DEFAULT NULL COMMENT '备用值,如果不在有效期内自动启用备用值',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `nid_index` (`nid`),
  KEY `type_index` (`classify`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='系统参数配置信息表';

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'application_name', '后台系统名称', '后台管理系统', '1', '\0', '2019-01-17 00:00:00', '2019-02-19 00:00:00', '阿斯顿', '', '2018-01-12 10:01:04', '2019-01-22 17:37:12');
INSERT INTO `system_config` VALUES ('2', 'enterprise_name', '企业名称', '二哥很猛', '1', '\0', null, null, null, null, '2018-02-08 14:38:59', null);
INSERT INTO `system_config` VALUES ('3', 'enterprise_address', '企业地址', '浙江省杭州市西湖区教工路79号', '1', '\0', null, null, null, null, '2018-02-08 14:40:01', null);
INSERT INTO `system_config` VALUES ('4', 'enterprise_phone', '企业电话', '0571-65800000', '1', '\0', null, null, null, null, '2018-02-08 14:40:46', null);
INSERT INTO `system_config` VALUES ('5', 'enterprise_email', '企业邮箱', '664956140@qq.com', '1', '\0', null, null, null, null, '2018-02-08 14:41:22', null);
INSERT INTO `system_config` VALUES ('6', 'ios_latest_version', 'ios最新版本号', '1.2.3', '1', '\0', null, null, null, '最新版本号,格式必须为x.x.x', '2018-09-28 10:50:03', null);
INSERT INTO `system_config` VALUES ('7', 'android_latest_version', 'android最新版本', '1.2.3', '1', '\0', null, null, null, '最新版本号,格式必须为x.x.x', '2018-09-28 10:50:41', null);
INSERT INTO `system_config` VALUES ('8', 'min_tender_age', '最小投标年龄', '18', '1', '\0', null, null, null, '用户必须满足该年龄后才能进行投标操作', '2018-10-10 15:56:23', null);
INSERT INTO `system_config` VALUES ('9', 'once_min_tender_amount', '单次最小投标金额', '100', '1', '\0', null, null, null, '单次最小投标金额', '2018-10-11 09:22:29', null);
INSERT INTO `system_config` VALUES ('10', 'personal_max_loan', '个人借款人最大借款总额', '200000', '1', '\0', null, null, null, '借款总额(剩余可借=personal_max_loan-待还本金)', '2018-10-11 09:26:15', null);
INSERT INTO `system_config` VALUES ('11', 'system_domain', '前台系统域名', 'http://www.eghm.top', '1', '\0', null, null, null, '前台提供服务的域名', '2018-11-25 21:02:17', null);
INSERT INTO `system_config` VALUES ('12', 'system_ip', '前台系统IP', 'http://127.0.0.1:8080', '1', '\0', null, null, null, '前台提供服务的ip', '2018-11-25 21:03:13', null);
INSERT INTO `system_config` VALUES ('13', 'manage_domain', '后台系统域名', 'http://www.baidu.com', '1', '\0', null, null, null, null, '2018-11-29 16:41:04', null);
INSERT INTO `system_config` VALUES ('14', 'operation_log_switch', '操作日志开关', '1', '1', '\0', null, null, null, '操作日志开关 0:不开启操作日志 1:开启操作日志', '2019-01-17 16:50:54', null);
INSERT INTO `system_config` VALUES ('15', 'env', '系统环境', '2', '2', '\0', null, null, '', '1 生产 2 开发 3  测试', '2019-01-22 17:23:19', null);
INSERT INTO `system_config` VALUES ('16', 'timestamp_deviation', '客户端与服务端时间容错值', '300000', '1', '\0', null, null, null, '单位:毫秒', '2019-07-10 16:50:31', '2019-07-10 16:52:43');
INSERT INTO `system_config` VALUES ('17', 'addresser', '系统邮件发件人', '', null, '\0', null, null, null, null, '2019-07-10 16:53:01', '2019-07-10 16:53:14');

-- ----------------------------
-- Table structure for system_department
-- ----------------------------
DROP TABLE IF EXISTS `system_department`;
CREATE TABLE `system_department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `code` varchar(64) DEFAULT NULL COMMENT '部门编号',
  `parent_code` varchar(64) DEFAULT NULL COMMENT '父级编号',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:未删除 1:已删除',
  `province` varchar(50) DEFAULT NULL COMMENT '所属省份',
  `city` varchar(50) DEFAULT NULL COMMENT '所属城市',
  `area` varchar(50) DEFAULT NULL COMMENT '所属区域(县区)',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_index` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='部门信息表';

-- ----------------------------
-- Records of system_department
-- ----------------------------
INSERT INTO `system_department` VALUES ('3', '销售部-经理', '100101', '100', '2018-12-13 16:12:41', null, '\0', null, null, null, null);
INSERT INTO `system_department` VALUES ('4', '销售部-业务员', '100101101', '100101', '2018-12-13 16:15:06', null, '\0', null, null, null, null);

-- ----------------------------
-- Table structure for system_dict
-- ----------------------------
DROP TABLE IF EXISTS `system_dict`;
CREATE TABLE `system_dict` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) DEFAULT NULL COMMENT '字典中文名称',
  `nid` varchar(50) DEFAULT NULL COMMENT '数据字典nid(英文名称)',
  `hidden_value` tinyint(2) unsigned DEFAULT NULL COMMENT '数据字典隐藏值 1~∞',
  `show_value` varchar(50) DEFAULT NULL COMMENT '显示值',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态(禁止编辑):0:未锁定 1:锁定',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='系统数据字典表';

-- ----------------------------
-- Records of system_dict
-- ----------------------------
INSERT INTO `system_dict` VALUES ('1', '图片分类', 'image_classify', '1', 'pc首页', '\0', '', '2018-11-27 17:14:49', null, null);
INSERT INTO `system_dict` VALUES ('2', '图片分类', 'image_classify', '2', 'app首页', '\0', '', '2018-11-27 17:15:33', null, null);
INSERT INTO `system_dict` VALUES ('3', '图片分类', 'image_classify', '3', 'h5首页', '\0', '', '2018-11-27 17:15:55', null, null);
INSERT INTO `system_dict` VALUES ('4', '系统参数分类', 'config_classify', '1', '业务参数', '\0', '', '2019-01-11 11:02:39', '2019-01-15 10:11:36', '');
INSERT INTO `system_dict` VALUES ('5', '系统参数分类', 'config_classify', '2', '系统参数', '\0', '', '2019-01-11 11:03:00', '2019-01-15 10:11:57', '是东方闪电2131');

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(10) NOT NULL COMMENT '菜单名称',
  `nid` varchar(50) NOT NULL COMMENT '菜单标示符 唯一',
  `pid` int(10) unsigned NOT NULL COMMENT '父节点ID,一级菜单默认为0',
  `url` varchar(255) DEFAULT NULL COMMENT '菜单地址',
  `path` varchar(255) DEFAULT NULL COMMENT '权限拦截路径',
  `classify` tinyint(1) unsigned DEFAULT '1' COMMENT '菜单分类 0:左侧菜单 1: 按钮菜单',
  `sort` int(3) DEFAULT '0' COMMENT '排序规则 小的排在前面',
  `deleted` bit(1) DEFAULT b'0' COMMENT '状态:0:正常,1:已删除',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nid_unique_index` (`nid`,`deleted`) USING BTREE,
  KEY `pid_index` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES ('1001', '系统管理', 'systemManage', '0', null, null, '0', '0', '\0', null, '2018-01-25 16:13:54', null);
INSERT INTO `system_menu` VALUES ('1004', '菜单管理', 'menuManage', '1001', '/public/system/menu/manage_menu_page', '/system/menu/menu_list_page', '0', '1', '\0', '', '2018-01-25 16:14:01', '2019-01-21 16:43:47');
INSERT INTO `system_menu` VALUES ('1007', '系统参数', 'systemParamter', '1001', '/public/system/config/manage_config_page', null, '0', '2', '\0', null, '2018-01-25 16:14:31', null);
INSERT INTO `system_menu` VALUES ('1008', '用户管理', 'systemUser', '1001', '/public/system/operator/manage_operator_page', null, '0', '3', '\0', null, '2018-01-25 16:14:40', null);
INSERT INTO `system_menu` VALUES ('1009', '角色管理', 'roleManage', '1001', '/public/system/role/manage_role_page', null, '0', '4', '\0', null, '2018-01-25 16:14:56', null);
INSERT INTO `system_menu` VALUES ('1010', '图片管理', 'imageManage', '1001', '/public/operation/image/manage_image_page', null, '0', '5', '\0', null, '2018-11-28 17:02:36', null);
INSERT INTO `system_menu` VALUES ('1011', '数据字典', 'dictManage', '1001', '/public/system/dict/manage_dict_page', null, '0', '6', '\0', null, '2019-01-11 17:51:31', null);
INSERT INTO `system_menu` VALUES ('1012', '缓存管理', 'cacheManage', '1001', '/public/system/cache/manage_cache_page', null, '0', '7', '\0', null, '2019-01-14 15:27:58', null);
INSERT INTO `system_menu` VALUES ('1013', '操作日志', 'operationManage', '1001', '/public/system/operation/manage_operation_page', null, '0', '8', '\0', null, '2019-01-16 14:31:01', null);
INSERT INTO `system_menu` VALUES ('1014', '部门管理', 'departmentManage', '1001', '/public/system/department/manage_department_page', null, '0', '9', '\0', null, '2019-01-17 18:03:54', null);
INSERT INTO `system_menu` VALUES ('1015', '新增', 'menuManageQuery', '1004', '/public/system/menu/add_menu_page', '/system/menu/add_menu', '1', '2', '\0', '按钮权限', '2019-01-22 14:16:11', '2019-01-22 14:19:09');
INSERT INTO `system_menu` VALUES ('1016', '基础', 'menuManageBase', '1004', '', '', '1', '1', '\0', '基础按钮', '2019-01-22 14:19:01', '2019-01-22 14:19:29');

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '公告标题',
  `classify` tinyint(2) unsigned DEFAULT NULL COMMENT '公告类型(数据字典表notice_classify)',
  `content` text COMMENT '公告内容(富文本)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统公告信息表';

-- ----------------------------
-- Records of system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for system_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `system_operation_log`;
CREATE TABLE `system_operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `url` varchar(200) DEFAULT NULL COMMENT '请求地址',
  `operator_id` int(10) DEFAULT NULL COMMENT '操作人',
  `request` varchar(1000) DEFAULT NULL COMMENT '请求参数',
  `response` text COMMENT '响应参数',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问ip',
  `business_time` bigint(12) unsigned DEFAULT NULL COMMENT '业务耗时',
  `classify` tinyint(255) unsigned DEFAULT NULL COMMENT '操作日志分类,参考:MethodType',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=596 DEFAULT CHARSET=utf8 COMMENT='后台操作记录';

-- ----------------------------
-- Table structure for system_operator
-- ----------------------------
DROP TABLE IF EXISTS `system_operator`;
CREATE TABLE `system_operator` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `operator_name` varchar(20) NOT NULL COMMENT '用户名称',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码(登陆账户)',
  `state` tinyint(1) unsigned DEFAULT '1' COMMENT '用户状态:0:锁定,1:正常',
  `pwd` varchar(128) DEFAULT NULL COMMENT '登陆密码MD5',
  `init_pwd` varchar(128) DEFAULT NULL COMMENT '初始密码',
  `department` varchar(64) DEFAULT NULL COMMENT '所属部门',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `name_index` (`operator_name`),
  KEY `mobile_index` (`mobile`),
  KEY `status_index` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理后台用户表';

-- ----------------------------
-- Records of system_operator
-- ----------------------------
INSERT INTO `system_operator` VALUES ('1', '超管', '13000000000', '1', '$2a$10$5r2rvlqCSSwOHRvoBxQNkecRVKOqcIFF3NY3.FHnrTdtTp7Fmhomy', '$2a$10$5r2rvlqCSSwOHRvoBxQNkecRVKOqcIFF3NY3.FHnrTdtTp7Fmh2omy', '0', '\0', '2018-01-26 10:38:20', '2019-01-15 11:25:18', '');

-- ----------------------------
-- Table structure for system_operator_role
-- ----------------------------
DROP TABLE IF EXISTS `system_operator_role`;
CREATE TABLE `system_operator_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `operator_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`operator_id`),
  KEY `role_id_index` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色与用户关系表';

-- ----------------------------
-- Records of system_operator_role
-- ----------------------------
INSERT INTO `system_operator_role` VALUES ('5', '1', '1');

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(10) DEFAULT NULL COMMENT '角色名称',
  `role_type` varchar(20) DEFAULT NULL COMMENT '角色类型',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态:0:正常,1:已删除',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `role_name_index` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES ('1', '超级管理员', 'administrator', '2018-01-29 13:45:49', '2019-01-15 15:30:07', '\0', '');

-- ----------------------------
-- Table structure for system_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_role_menu`;
CREATE TABLE `system_role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) unsigned DEFAULT NULL COMMENT '角色Id',
  `menu_id` int(10) unsigned DEFAULT NULL COMMENT '菜单Id',
  PRIMARY KEY (`id`),
  KEY `role_id_index` (`role_id`) USING BTREE,
  KEY `menu_id_index` (`menu_id`),
  CONSTRAINT `role_id_FK` FOREIGN KEY (`role_id`) REFERENCES `system_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8 COMMENT='角色与菜单关系表';

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
INSERT INTO `system_role_menu` VALUES ('215', '1', '1001');
INSERT INTO `system_role_menu` VALUES ('216', '1', '1004');
INSERT INTO `system_role_menu` VALUES ('217', '1', '1016');
INSERT INTO `system_role_menu` VALUES ('218', '1', '1015');
INSERT INTO `system_role_menu` VALUES ('219', '1', '1007');
INSERT INTO `system_role_menu` VALUES ('220', '1', '1008');
INSERT INTO `system_role_menu` VALUES ('221', '1', '1009');
INSERT INTO `system_role_menu` VALUES ('222', '1', '1010');
INSERT INTO `system_role_menu` VALUES ('223', '1', '1011');
INSERT INTO `system_role_menu` VALUES ('224', '1', '1012');
INSERT INTO `system_role_menu` VALUES ('225', '1', '1013');
INSERT INTO `system_role_menu` VALUES ('226', '1', '1014');

-- ----------------------------
-- Table structure for tips
-- ----------------------------
DROP TABLE IF EXISTS `tips`;
CREATE TABLE `tips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(20) NOT NULL COMMENT '标签名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '标签备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  PRIMARY KEY (`id`),
  KEY `name_index` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签类型表';

-- ----------------------------
-- Records of tips
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `deposit_no` varchar(64) DEFAULT NULL COMMENT '存管账号',
  `deposit_status` tinyint(1) unsigned DEFAULT NULL COMMENT '存管状态',
  `password` varchar(128) NOT NULL COMMENT '登陆密码',
  `state` bit(1) DEFAULT b'1' COMMENT '状态 1正常 0:锁定',
  `channel` tinyint(3) unsigned DEFAULT '0' COMMENT '注册渠道 pc,android,ios,h5,other',
  `register_ip` varchar(32) DEFAULT NULL COMMENT '注册地址',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`),
  KEY `email_index` (`email`),
  KEY `status_index` (`state`),
  KEY `channel_index` (`channel`),
  KEY `deposit_no_index` (`deposit_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投资人基本信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '15966666666', null, null, null, '12', '', '0', null, '2018-01-11 15:59:08', null);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `state` tinyint(1) unsigned DEFAULT '1' COMMENT '地址状态:0:普通地址 1:默认地址',
  `province_nid` char(10) DEFAULT NULL COMMENT '省份编号',
  `city_nid` char(10) DEFAULT NULL COMMENT '城市编号',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status_index` (`state`),
  KEY `user_id_index` (`user_id`),
  KEY `province_nid_index` (`province_nid`),
  KEY `city_nid_index` (`city_nid`),
  KEY `deleted_index` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人地址信息表';

-- ----------------------------
-- Records of user_address
-- ----------------------------

-- ----------------------------
-- Table structure for user_extend
-- ----------------------------
DROP TABLE IF EXISTS `user_extend`;
CREATE TABLE `user_extend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '投资人用户ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `id_card` varchar(128) DEFAULT NULL COMMENT '身份证号码(前10位加密[18位身份证],前8位加密[15位身份证])',
  `birthday` char(8) DEFAULT NULL COMMENT '生日yyyyMMdd',
  `integral_num` int(10) unsigned DEFAULT '0' COMMENT '可用积分总数',
  `grade` tinyint(2) unsigned DEFAULT '0' COMMENT '用户等级',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_index` (`user_id`) USING BTREE COMMENT '唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人扩展信息表';

-- ----------------------------
-- Records of user_extend
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `state` tinyint(1) unsigned DEFAULT '0' COMMENT '状态 0:未读 1:已读',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:未删除 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人站内信';

-- ----------------------------
-- Records of user_message
-- ----------------------------

-- ----------------------------
-- Table structure for vip_config
-- ----------------------------
DROP TABLE IF EXISTS `vip_config`;
CREATE TABLE `vip_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `vip_name` char(20) DEFAULT NULL COMMENT '等级名称',
  `grade` tinyint(2) unsigned DEFAULT NULL COMMENT 'vip等级',
  `sort` tinyint(2) DEFAULT NULL COMMENT '排序规则:小(前面)<->大(后面)',
  `amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '当前等级最小待收金额',
  `state` bit(1) DEFAULT b'1' COMMENT '状态 0:关闭 1:开启',
  `withdraw` tinyint(2) unsigned DEFAULT NULL COMMENT '月免费提现次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='vip等级配置表';

-- ----------------------------
-- Records of vip_config
-- ----------------------------
INSERT INTO `vip_config` VALUES ('1', '新手', '0', '0', '0.00', '', '0');
INSERT INTO `vip_config` VALUES ('2', '青铜会员', '1', '1', '1000.00', '', '1');
INSERT INTO `vip_config` VALUES ('3', '白银会员', '2', '2', '5000.00', '', '2');
INSERT INTO `vip_config` VALUES ('4', '黄金会员', '3', '3', '10000.00', '', '3');
INSERT INTO `vip_config` VALUES ('5', '铂金会员', '4', '4', '50000.00', '', '4');
INSERT INTO `vip_config` VALUES ('6', '钻石会员', '5', '5', '200000.00', '', '5');
INSERT INTO `vip_config` VALUES ('7', '至尊会员', '6', '6', '500000.00', '', '6');
INSERT INTO `vip_config` VALUES ('8', '王者会员', '7', '7', '2000000.00', '', '7');

-- ----------------------------
-- Table structure for withdraw_log
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_log`;
CREATE TABLE `withdraw_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `state` tinyint(1) DEFAULT '0' COMMENT '提现状态 -1:提现撤销 0:录入中 1:提现申请 2:提现成功,3:提现审核失败,4:提现失败',
  `user_type` tinyint(1) DEFAULT NULL COMMENT '用户类型 0:投资人 1:借款人',
  `amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现金额',
  `real_amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现到账金额',
  `fee` decimal(6,2) unsigned DEFAULT '0.00' COMMENT '提现手续费',
  `use_free` bit(1) DEFAULT b'1' COMMENT '是否使用免费提现 0:否 1是',
  `bank_num` varchar(32) DEFAULT NULL COMMENT '提现银行卡号',
  `bank_code` char(20) DEFAULT NULL COMMENT '提现银行卡编码',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `order_no` varchar(128) DEFAULT NULL COMMENT '订单号',
  `remark` varchar(200) DEFAULT NULL COMMENT '提现备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提现记录表';

-- ----------------------------
-- Records of withdraw_log
-- ----------------------------

-- ----------------------------
-- Procedure structure for idata
-- ----------------------------
DROP PROCEDURE IF EXISTS `idata`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `idata`()
begin
    declare i int;
    set i=1;
    while(i<=100000)do
      insert into t values(i, i, i);
      set i=i+1;
    end while;
  end
;;
DELIMITER ;
