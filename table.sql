/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : p2p

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2018-10-11 16:54:31
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
  `withdraw_freeze` decimal(12,2) DEFAULT '0.00' COMMENT '提现冻结',
  `accumulated_income` decimal(12,2) DEFAULT '0.00' COMMENT '累计收益',
  `wait_capital` decimal(12,2) DEFAULT '0.00' COMMENT '待收本金',
  `wait_interest` decimal(12,2) DEFAULT '0.00' COMMENT '待收利息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资产账户表';

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for account_log
-- ----------------------------
DROP TABLE IF EXISTS `account_log`;
CREATE TABLE `account_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `amount` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '实际操作金额',
  `type` tinyint(2) DEFAULT NULL COMMENT '资金详细类型',
  `available_balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '可用余额(已清算+未清算)',
  `recharge` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '充值金额(未清算)',
  `tender_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '投标冻结金额',
  `withdraw_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现冻结金额',
  `accumulated_income` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '累计收益',
  `wait_capital` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收本金',
  `wait_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收利息',
  `add_time` datetime DEFAULT NULL COMMENT '发生时间',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资产变动详细记录表';

-- ----------------------------
-- Records of account_log
-- ----------------------------

-- ----------------------------
-- Table structure for app_feedback
-- ----------------------------
DROP TABLE IF EXISTS `app_feedback`;
CREATE TABLE `app_feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态: 0:待解决 1:已解决',
  `version` varchar(50) DEFAULT NULL COMMENT '软件版本',
  `system_version` varchar(50) DEFAULT NULL COMMENT '系统版本',
  `content` varchar(200) DEFAULT NULL COMMENT '反馈内容',
  `add_time` datetime DEFAULT NULL COMMENT '反馈时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_status` (`status`)
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
  `type` char(20) DEFAULT NULL COMMENT '版本类型 IOS,ANDROID',
  `version` char(10) DEFAULT NULL COMMENT '版本号:1.2.8',
  `force_update` bit(1) DEFAULT b'0' COMMENT '是否强制更新 0:否 1:是',
  `url` varchar(500) DEFAULT NULL COMMENT '下载地址,android为实际下载地址,ios是跳转到app_store',
  `add_time` datetime DEFAULT NULL COMMENT '上传时间',
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
  `nid` varchar(50) DEFAULT NULL COMMENT '所属模板nid,例如充值,开户,提现等',
  `code` varchar(20) NOT NULL COMMENT '银行编码类型:ABC,ICBC',
  `name` varchar(50) NOT NULL COMMENT '银行名称',
  `limit_amount` decimal(10,2) DEFAULT '0.00' COMMENT '单卡当日限额',
  `remark` varchar(100) DEFAULT NULL COMMENT '银行卡限额说明',
  `icon` varchar(500) DEFAULT NULL COMMENT '银行图标(长图)',
  `logo` varchar(500) DEFAULT NULL COMMENT '银行图标logo(短图)',
  `bank_num` varchar(50) DEFAULT NULL COMMENT '第三方充值银行编码(三方支付公司采用的编码可能不是ABC,ICBC等)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态:0:正常 1:已删除(数据库可见,后台不可见)',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态 0:未锁定1:锁定(相当于下架,后台可见,前台不可见)',
  PRIMARY KEY (`id`),
  KEY `type_index` (`code`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='银行信息表';

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES ('1', null, '1', '我是出借,你是出借吗', '0.00', '去', null, null, null, '2018-04-25 14:36:43', null, '\0', '\0');

-- ----------------------------
-- Table structure for bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bank_card`;
CREATE TABLE `bank_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `user_type` tinyint(1) DEFAULT '0' COMMENT '用户类型 0:投资人 1:借款人',
  `bank_code` varchar(10) DEFAULT NULL COMMENT '银行编号:ABC,ICBC',
  `bank_num` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `mobile` varchar(15) DEFAULT NULL COMMENT '银行预留手机号',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `user_type_index` (`user_type`),
  KEY `bank_type_index` (`bank_code`)
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
  `type` tinyint(2) DEFAULT NULL COMMENT '轮播图类型:由system_dict的banner_type维护(不同模块的轮播均在该表中维护)',
  `client_type` tinyint(1) DEFAULT NULL COMMENT '客户端类型 0:PC 1:APP',
  `img_url` varchar(500) NOT NULL COMMENT '轮播图片地址',
  `turn_url` varchar(500) DEFAULT NULL COMMENT '轮播图点击后跳转的URL',
  `index` tinyint(2) unsigned DEFAULT NULL COMMENT '轮播图顺序(小<->大) 最小的在最前面',
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '开始展示时间(可在指定时间后开始展示)',
  `end_time` datetime DEFAULT NULL COMMENT '取消展示的时间(只在某个时间段展示)',
  `click` bit(1) DEFAULT b'1' COMMENT '是否可点击 0:否 1:可以',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='轮播图维护表';

-- ----------------------------
-- Records of banner
-- ----------------------------

-- ----------------------------
-- Table structure for borrower
-- ----------------------------
DROP TABLE IF EXISTS `borrower`;
CREATE TABLE `borrower` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `password` varchar(128) DEFAULT NULL COMMENT '登陆密码MD5',
  `locked` bit(1) DEFAULT b'0' COMMENT '用户状态 0:未锁定 1:锁定(不可登陆系统)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除(仅数据库可见)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='个人借款人信息';

-- ----------------------------
-- Records of borrower
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
-- Table structure for integral_log
-- ----------------------------
DROP TABLE IF EXISTS `integral_log`;
CREATE TABLE `integral_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL,
  `num` smallint(6) unsigned DEFAULT '1' COMMENT '积分数',
  `type` int(10) NOT NULL COMMENT '积分类型(表integral_type主键)',
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
  `nid` varchar(20) DEFAULT NULL COMMENT '积分类型nid',
  `name` varchar(200) DEFAULT NULL COMMENT '积分类型名称',
  `status` bit(1) DEFAULT b'1' COMMENT '积分类型状态 0:不可用 1:可用',
  `score` smallint(6) DEFAULT NULL COMMENT '积分个数',
  `type` tinyint(1) DEFAULT '0' COMMENT '积分类型 0:收入 1:支出',
  `random` bit(1) DEFAULT b'0' COMMENT '是否为随机积分 0:不是 1:是',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分类型表';

-- ----------------------------
-- Records of integral_type
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
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
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
  `code` varchar(50) DEFAULT NULL COMMENT '标的编号',
  `status` tinyint(2) DEFAULT '0' COMMENT '标的状态:-2:废弃-1:标的撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成,6:逾期结清',
  `type` tinyint(2) DEFAULT '0' COMMENT '标的类型 0:个人车贷,1:企业车贷',
  `name` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `amount` decimal(12,2) DEFAULT '100.00' COMMENT '计划募集金额',
  `raise_amount` decimal(12,2) DEFAULT '0.00' COMMENT '已募集金额',
  `min_tender` decimal(12,2) DEFAULT '100.00' COMMENT '单次最小投标金额',
  `max_tender` decimal(12,2) DEFAULT NULL COMMENT '单次最大投标金额',
  `apr` decimal(3,1) DEFAULT '0.0' COMMENT '标的基础利息 单位%',
  `platform_apr` decimal(2,1) DEFAULT '0.0' COMMENT '平台加息利息 单位%',
  `period` tinyint(2) DEFAULT NULL COMMENT '期限(月)',
  `repayment_type` tinyint(1) DEFAULT NULL COMMENT '还款方式,0:等额本息,1:按月付息,到期还本,2:按天计息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '标的信息录入时间',
  `presell_time` datetime DEFAULT NULL COMMENT '预售时间(默认标的发布时间)',
  `publish_time` datetime DEFAULT NULL COMMENT '标的发布时间(复审通过时间)',
  `recheck_time` datetime DEFAULT NULL COMMENT '满标复审时间',
  `end_time` datetime DEFAULT NULL COMMENT '标的完结时间(废弃,撤标,还款完成,逾期结清)等',
  PRIMARY KEY (`id`),
  KEY `borrower_id_index` (`borrower_id`),
  KEY `code_index` (`code`),
  KEY `status_index` (`status`),
  KEY `period_index` (`period`),
  KEY `name_index` (`name`),
  KEY `repayment_type_index` (`repayment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for project_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `project_audit_log`;
CREATE TABLE `project_audit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL COMMENT '标的ID',
  `remark` varchar(200) DEFAULT NULL COMMENT '审核记录',
  `add_time` datetime DEFAULT NULL COMMENT '审核时间',
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
  `status` tinyint(1) DEFAULT '0' COMMENT '回款状态 0:待回款 1:已回款',
  `tender_id` int(10) DEFAULT NULL COMMENT '投标ID',
  `project_id` int(10) DEFAULT NULL COMMENT '项目ID',
  `period` tinyint(2) DEFAULT NULL COMMENT '第几期回款',
  `periods` tinyint(2) DEFAULT NULL COMMENT '总期数',
  `capital` decimal(12,2) DEFAULT NULL COMMENT '应还本金',
  `interest` decimal(12,2) DEFAULT NULL COMMENT '预计回款利息(基础利息)',
  `platform_interest` decimal(12,2) DEFAULT '0.00' COMMENT '预计平台加息利息',
  `coupon_interest` decimal(12,2) DEFAULT '0.00' COMMENT '预计加息券利息',
  `receive_time` date DEFAULT NULL COMMENT '预计回款时间(精确到天)',
  `real_receive_time` datetime DEFAULT NULL COMMENT '实际回款时间',
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
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '借款人ID',
  `project_id` int(10) unsigned DEFAULT NULL COMMENT '标的ID',
  `status` bit(1) DEFAULT b'0' COMMENT '是否还款 0:未还款 1:已还款',
  `mode` tinyint(1) DEFAULT '0' COMMENT '还款方式 0:正常还款,1:提前还款,2:逾期还款',
  `period` tinyint(4) unsigned DEFAULT NULL COMMENT '第几期还款',
  `periods` tinyint(3) unsigned DEFAULT NULL COMMENT '总期数',
  `capital` decimal(12,2) unsigned DEFAULT NULL COMMENT '预计还款本金',
  `interest` decimal(12,2) unsigned DEFAULT NULL COMMENT '预计还款利息',
  `repay_time` date DEFAULT NULL COMMENT '预计还款时间(精确到天)',
  `real_repay_time` datetime DEFAULT NULL COMMENT '实际还款时间(精确到秒)',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`user_id`),
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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `project_id` int(10) DEFAULT NULL COMMENT '标的id',
  `account` decimal(12,2) unsigned DEFAULT NULL COMMENT '投标金额(元)',
  `base_interest` decimal(12,2) unsigned DEFAULT NULL COMMENT '基础利息(预计利息)',
  `platform_interest` decimal(12,2) unsigned DEFAULT NULL COMMENT '平台加息利息(预计利息)',
  `coupon_interest` decimal(12,2) unsigned DEFAULT NULL COMMENT '加息券利息(预计利息)',
  `status` tinyint(2) DEFAULT '0' COMMENT '投标状态:-3标的撤销,-2:已转让,-1:转让申请中,0:投标加入,1:回款中,2:还款完成',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_tender
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
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nid` varchar(50) NOT NULL COMMENT '参数标示符',
  `name` varchar(50) DEFAULT NULL COMMENT '参数名称',
  `value` varchar(2000) NOT NULL COMMENT '参数值',
  `type` tinyint(2) unsigned DEFAULT NULL COMMENT '参数类型,见system_dict表nid=system_config_type',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态(禁止编辑) 0:未锁定,1:锁定',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `nid_index` (`nid`),
  KEY `type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='系统参数配置信息表';

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'application_name', '系统名称', '后台管理系统', null, '\0', '', '2018-01-12 10:01:04', '2018-01-29 18:33:32');
INSERT INTO `system_config` VALUES ('2', 'enterprise_name', '企业名称', '二哥很猛', null, '\0', null, '2018-02-08 14:38:59', null);
INSERT INTO `system_config` VALUES ('3', 'enterprise_address', '企业地址', '浙江省杭州市西湖区教工路79号', null, '\0', null, '2018-02-08 14:40:01', null);
INSERT INTO `system_config` VALUES ('4', 'enterprise_phone', '企业电话', '0571-65800000', null, '\0', null, '2018-02-08 14:40:46', null);
INSERT INTO `system_config` VALUES ('5', 'enterprise_email', '企业邮箱', '664956140@qq.com', null, '\0', null, '2018-02-08 14:41:22', null);
INSERT INTO `system_config` VALUES ('6', 'ios_latest_version', 'ios最新版本号', '1.2.3', null, '\0', '用于指定最新版本号,格式只能是三类版本,不能少一位,也不能多一位', '2018-09-28 10:50:03', null);
INSERT INTO `system_config` VALUES ('7', 'android_latest_version', 'android最新版本', '1.2.3', null, '\0', '用于指定最新版本号,格式只能是三类版本,不能少一位,也不能多一位', '2018-09-28 10:50:41', null);
INSERT INTO `system_config` VALUES ('8', 'min_tender_age', '最小投标年龄', '18', null, '\0', '用户必须满足该年龄后才能进行投标操作', '2018-10-10 15:56:23', null);
INSERT INTO `system_config` VALUES ('9', 'once_min_tender_amount', '单次最小投标金额', '100', null, '\0', '单次最小投标金额', '2018-10-11 09:22:29', null);
INSERT INTO `system_config` VALUES ('10', 'max_tender_amount', '总最大投标金额', '200000', null, '\0', '投标金额-已回款本金(投标金额包含未复审金额)', '2018-10-11 09:26:15', null);

-- ----------------------------
-- Table structure for system_dict
-- ----------------------------
DROP TABLE IF EXISTS `system_dict`;
CREATE TABLE `system_dict` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '字典中文名称',
  `nid` varchar(50) DEFAULT NULL COMMENT '数据字典nid(英文名称)',
  `hidden_value` tinyint(2) DEFAULT NULL COMMENT '数据字典隐藏值 1~∞',
  `value` varchar(50) DEFAULT NULL COMMENT '显示值',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态(禁止编辑):0:未锁定 1:锁定',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统数据字典表';

-- ----------------------------
-- Records of system_dict
-- ----------------------------

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(8) NOT NULL COMMENT '菜单名称',
  `nid` varchar(20) NOT NULL COMMENT '菜单标示符 唯一',
  `pid` int(10) unsigned NOT NULL COMMENT '父节点ID,一级菜单默认为0',
  `url` varchar(255) DEFAULT NULL COMMENT '菜单地址',
  `sub_url` varchar(2000) DEFAULT NULL COMMENT '该菜单包含的子url以分号做分割',
  `main_menu` bit(1) DEFAULT b'1' COMMENT '是否为左侧主菜单 0:不是,1:是',
  `sort` int(3) DEFAULT '0' COMMENT '排序规则 小的排在前面',
  `deleted` bit(1) DEFAULT b'0' COMMENT '状态:0:正常,1:已删除',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES ('1001', '系统管理', 'systemManage', '0', null, null, '', '0', '\0', null, '2018-01-25 16:13:54', null);
INSERT INTO `system_menu` VALUES ('1004', '菜单管理', 'menuManage', '1001', '/public/system/menu/menu_manage_page', null, '', '1', '\0', null, '2018-01-25 16:14:01', null);
INSERT INTO `system_menu` VALUES ('1007', '系统参数', 'systemParamter', '1001', '/public/system/config/config_manage_page', null, '', '2', '\0', null, '2018-01-25 16:14:31', null);
INSERT INTO `system_menu` VALUES ('1008', '用户管理', 'systemUser', '1001', '/public/system/user/user_manage_page', null, '', '3', '\0', null, '2018-01-25 16:14:40', null);
INSERT INTO `system_menu` VALUES ('1009', '角色管理', 'roleManage', '1001', '/public/system/role/role_manage_page', null, '', '4', '\0', null, '2018-01-25 16:14:56', null);

-- ----------------------------
-- Table structure for system_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_notice`;
CREATE TABLE `system_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL COMMENT '公告标题',
  `type` tinyint(2) DEFAULT NULL COMMENT '公告类型(数据字典表system_notice_type)',
  `content` text COMMENT '公告内容(富文本)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统公告信息表';

-- ----------------------------
-- Records of system_notice
-- ----------------------------

-- ----------------------------
-- Table structure for system_operator
-- ----------------------------
DROP TABLE IF EXISTS `system_operator`;
CREATE TABLE `system_operator` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) NOT NULL COMMENT '用户名称',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码(登陆账户)',
  `status` tinyint(1) DEFAULT '1' COMMENT '用户状态:0:锁定,1:正常',
  `password` varchar(128) DEFAULT NULL COMMENT '登陆密码MD5',
  `init_password` varchar(128) DEFAULT NULL COMMENT '初始密码',
  `department` int(2) DEFAULT NULL COMMENT '所属部门',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `mobile_index` (`mobile`),
  KEY `status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_operator
-- ----------------------------
INSERT INTO `system_operator` VALUES ('1', '超管', '13000000000', '1', '$2a$10$5r2rvlqCSSwOHRvoBxQNkecRVKOqcIFF3NY3.FHnrTdtTp7Fmhomy', '$2a$10$5r2rvlqCSSwOHRvoBxQNkecRVKOqcIFF3NY3.FHnrTdtTp7Fmhomy', '0', '\0', '2018-01-26 10:38:20', null, null);

-- ----------------------------
-- Table structure for system_operator_role
-- ----------------------------
DROP TABLE IF EXISTS `system_operator_role`;
CREATE TABLE `system_operator_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户id',
  `role_id` int(10) unsigned DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `role_id_index` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色与用户关系表';

-- ----------------------------
-- Records of system_operator_role
-- ----------------------------
INSERT INTO `system_operator_role` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for system_role
-- ----------------------------
DROP TABLE IF EXISTS `system_role`;
CREATE TABLE `system_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(10) DEFAULT NULL COMMENT '角色名称',
  `role_type` varchar(20) DEFAULT NULL COMMENT '角色类型',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态:0:正常,1:已删除',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `role_name_index` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of system_role
-- ----------------------------
INSERT INTO `system_role` VALUES ('1', '超级管理员', 'administator', '2018-01-29 13:45:49', null, '\0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='角色与菜单关系表';

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------
INSERT INTO `system_role_menu` VALUES ('2', '1', '1001');
INSERT INTO `system_role_menu` VALUES ('5', '1', '1004');
INSERT INTO `system_role_menu` VALUES ('8', '1', '1007');
INSERT INTO `system_role_menu` VALUES ('9', '1', '1008');
INSERT INTO `system_role_menu` VALUES ('10', '1', '1009');

-- ----------------------------
-- Table structure for tips
-- ----------------------------
DROP TABLE IF EXISTS `tips`;
CREATE TABLE `tips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(20) NOT NULL COMMENT '标签名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '标签备注信息',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常,1:已删除',
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`)
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
  `type` tinyint(1) DEFAULT '0' COMMENT '用户类型:0:投资人 1:代偿人',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `deposit_no` varchar(64) DEFAULT NULL COMMENT '存管账号',
  `password` varchar(128) NOT NULL COMMENT '登陆密码',
  `status` bit(1) DEFAULT b'1' COMMENT '状态 1正常 0:锁定',
  `channel` tinyint(3) unsigned DEFAULT '0' COMMENT '注册渠道0:pc,1:android,2:ios,3:h5,第三方渠道注册',
  `register_ip` varchar(32) DEFAULT NULL COMMENT '注册地址',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`),
  KEY `email_index` (`email`),
  KEY `status_index` (`status`),
  KEY `channel_index` (`channel`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投资人基本信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '0', '15966666666', null, null, '12', '', '0', null, '2018-01-11 15:59:08', null);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '地址状态:0:普通地址 1:默认地址',
  `province_nid` char(10) DEFAULT NULL COMMENT '省份编号',
  `city_nid` char(10) DEFAULT NULL COMMENT '城市编号',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `status_index` (`status`),
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
  `integral_num` int(10) unsigned DEFAULT '0' COMMENT '可用积分总数',
  `cash_num` smallint(6) unsigned DEFAULT '0' COMMENT '免费提现次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投资人扩展信息表';

-- ----------------------------
-- Records of user_extend
-- ----------------------------
