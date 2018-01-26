/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : p2p

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2018-01-26 17:48:04
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
  `wait_capital` decimal(12,2) DEFAULT '0.00',
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
  `type` tinyint(2) DEFAULT NULL COMMENT '资金类型',
  `ie_type` tinyint(1) DEFAULT NULL COMMENT '收支类型 -1:支出 0:不支出不收入 1:收入',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `available_balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '可用余额(已清算+未清算)',
  `recharge` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '充值金额(未清算)',
  `tender_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '投标冻结金额',
  `withdraw_freeze` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '提现冻结金额',
  `accumulated_income` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '累计收益',
  `wait_capital` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收本金',
  `wait_interest` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '待收利息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_log
-- ----------------------------

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL COMMENT '银行编码类型:ABC,ICBC',
  `name` varchar(50) NOT NULL COMMENT '银行名称',
  `quota` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单卡操作限额',
  `quota_remark` varchar(50) NOT NULL COMMENT '银行限额说明',
  `icon` varchar(500) DEFAULT NULL COMMENT '银行图标(长图)',
  `logo` varchar(500) DEFAULT NULL COMMENT '银行图标logo(短图)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态:0:正常 1:已删除(数据库可见,后台不可见)',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态 0:未锁定1:锁定(相当于下架,后台可见,前台不可见)',
  PRIMARY KEY (`id`),
  KEY `type_index` (`type`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行信息表';

-- ----------------------------
-- Records of bank
-- ----------------------------

-- ----------------------------
-- Table structure for bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bank_card`;
CREATE TABLE `bank_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户ID',
  `user_type` tinyint(1) DEFAULT '0' COMMENT '用户类型 0:投资人 1:借款人',
  `bank_type` varchar(10) DEFAULT NULL COMMENT '银行编号:ABC,ICBC',
  `bank_num` varchar(32) DEFAULT NULL COMMENT '银行卡号',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `user_type_index` (`user_type`),
  KEY `bank_type_index` (`bank_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='银行卡信息表';

-- ----------------------------
-- Records of bank_card
-- ----------------------------

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键标的ID',
  `borrower_id` int(10) unsigned NOT NULL COMMENT '借款人ID',
  `code` varchar(50) DEFAULT NULL COMMENT '标的编号',
  `status` tinyint(2) DEFAULT '0' COMMENT '标的状态:-2:废弃-1:标的撤回,0待初审,1:待复审,2:募集中,3:满标待复审,4:还款中,5:还款完成',
  `name` varchar(50) DEFAULT NULL COMMENT '标的名称',
  `amount` decimal(12,2) DEFAULT '100.00' COMMENT '计划募集金额',
  `raise_amount` decimal(12,2) DEFAULT '0.00' COMMENT '已募集金额',
  `apr` decimal(3,1) DEFAULT '0.0' COMMENT '标的基础利息 单位%',
  `platform_apr` decimal(2,1) DEFAULT '0.0' COMMENT '平台加息利息 单位%',
  `period` tinyint(2) DEFAULT NULL COMMENT '期限',
  `period_unit` tinyint(1) DEFAULT '1' COMMENT '期限单位 0:天,1:月,2:年',
  `repayment_type` tinyint(1) DEFAULT NULL COMMENT '还款方式,0:等额本息,1:按月付息,到期还本',
  `presell_time` datetime DEFAULT NULL COMMENT '预售时间(非空即表示预售标)',
  `min_tender` decimal(12,2) DEFAULT '100.00' COMMENT '最小投标金额',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '标的信息录入时间',
  `publish_time` datetime DEFAULT NULL COMMENT '标的发布时间(复审通过时间)',
  PRIMARY KEY (`id`),
  KEY `borrower_id_index` (`borrower_id`),
  KEY `code_index` (`code`),
  KEY `status_index` (`status`),
  KEY `period_index` (`period`),
  KEY `name_index` (`name`),
  KEY `repayment_type_index` (`repayment_type`),
  KEY `period_unit_index` (`period_unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的信息表';

-- ----------------------------
-- Records of borrow
-- ----------------------------

-- ----------------------------
-- Table structure for borrower
-- ----------------------------
DROP TABLE IF EXISTS `borrower`;
CREATE TABLE `borrower` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `real_name` varchar(20) DEFAULT NULL,
  `id_card` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `id_card_encrypt` varchar(512) DEFAULT NULL COMMENT '身份证年月日加密',
  `password` varchar(128) DEFAULT NULL COMMENT '登陆密码MD5',
  `password_random` varchar(10) DEFAULT NULL COMMENT '登陆密码随机加密串',
  `pay_password` varchar(128) DEFAULT NULL COMMENT '支付密码',
  `pay_password_random` varchar(100) DEFAULT NULL COMMENT '支付密码随机串',
  `pay_error` tinyint(2) unsigned DEFAULT NULL COMMENT '支付密码错误次数',
  `locked` bit(1) DEFAULT b'0' COMMENT '用户状态 0:未锁定 1:锁定(不可登陆系统)',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:正常 1:已删除(仅数据库可见)',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`),
  KEY `real_name_index` (`real_name`),
  KEY `id_card_index` (`id_card`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='借款人信息';

-- ----------------------------
-- Records of borrower
-- ----------------------------

-- ----------------------------
-- Table structure for borrow_ext
-- ----------------------------
DROP TABLE IF EXISTS `borrow_ext`;
CREATE TABLE `borrow_ext` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrow_id` int(10) unsigned NOT NULL COMMENT '标的信息表',
  `details` text COMMENT '项目详细信息(富文本)',
  PRIMARY KEY (`id`),
  KEY `borrow_id_index` (`borrow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的附加信息表';

-- ----------------------------
-- Records of borrow_ext
-- ----------------------------

-- ----------------------------
-- Table structure for borrow_tips
-- ----------------------------
DROP TABLE IF EXISTS `borrow_tips`;
CREATE TABLE `borrow_tips` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `borrow_id` int(10) unsigned NOT NULL COMMENT '标的ID',
  `tips_id` int(10) unsigned DEFAULT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  KEY `borrow_id_index` (`borrow_id`),
  KEY `tips_id_index` (`tips_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标的标签关系表';

-- ----------------------------
-- Records of borrow_tips
-- ----------------------------

-- ----------------------------
-- Table structure for recharge_bank
-- ----------------------------
DROP TABLE IF EXISTS `recharge_bank`;
CREATE TABLE `recharge_bank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL COMMENT '银行编号(与第三方充值合作的银行编号)',
  `type` varchar(20) DEFAULT NULL COMMENT '银行类型:ABC,ICBC',
  `name` varchar(50) DEFAULT NULL COMMENT '银行名称',
  `icon` varchar(500) DEFAULT NULL COMMENT '银行图标',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted` bit(1) DEFAULT b'0' COMMENT '删除状态 0:未删除 1:已删除(数据库可见,后台不可见)',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态 0:未锁定 1:锁定(相当于下架,后台可见,前台不可见)',
  PRIMARY KEY (`id`),
  KEY `code_index` (`code`),
  KEY `type_index` (`type`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值银行信息表';

-- ----------------------------
-- Records of recharge_bank
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nid` varchar(50) NOT NULL COMMENT '参数标示符',
  `value` varchar(2000) NOT NULL COMMENT '参数值',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `type` tinyint(2) unsigned DEFAULT NULL COMMENT '参数类型,见system_dict表nid=system_config_type',
  `locked` bit(1) DEFAULT b'0' COMMENT '锁定状态(禁止编辑) 0:未锁定,1:锁定',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `nid_index` (`nid`),
  KEY `type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统参数配置信息表';

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES ('1', 'application_name', '1231231', null, null, '\0', '2018-01-12 10:01:04', '2018-01-18 15:21:21');

-- ----------------------------
-- Table structure for system_dict
-- ----------------------------
DROP TABLE IF EXISTS `system_dict`;
CREATE TABLE `system_dict` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '字典中文名称',
  `nid` varchar(50) DEFAULT NULL COMMENT '数据字典nid(英文名称)',
  `hidden_value` tinyint(2) DEFAULT NULL COMMENT '数据字典隐藏值',
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
INSERT INTO `system_menu` VALUES ('1000', '基础管理', 'baseManage', '0', null, '', '0', '\0', null, '2018-01-25 16:13:25', null);
INSERT INTO `system_menu` VALUES ('1001', '系统管理', 'systemManage', '0', null, '', '0', '\0', null, '2018-01-25 16:13:54', null);
INSERT INTO `system_menu` VALUES ('1002', '业务管理', 'businessManage', '0', null, '', '0', '\0', null, '2018-01-25 16:14:00', null);
INSERT INTO `system_menu` VALUES ('1003', '运营管理', 'operateManage', '1000', null, '', '0', '\0', null, '2018-01-25 16:14:00', null);
INSERT INTO `system_menu` VALUES ('1004', '菜单管理', 'menuManage', '1001', '/admin/system/menu/menuManage', '', '0', '\0', null, '2018-01-25 16:14:01', null);
INSERT INTO `system_menu` VALUES ('1005', '一级菜单', 'oneMenu', '0', null, '', '0', '\0', null, '2018-01-25 16:14:04', null);
INSERT INTO `system_menu` VALUES ('1006', '二级菜单', 'sencond', '1005', null, '', '0', '\0', null, '2018-01-25 16:14:04', null);
INSERT INTO `system_menu` VALUES ('1007', '系统参数', 'systemParamter', '1001', '/admin/system/config/systemConfigManage', '', '0', '\0', null, '2018-01-25 16:14:31', null);
INSERT INTO `system_menu` VALUES ('1008', '用户管理', 'systemUser', '1001', '/admin/system/user/userManage', '', '0', '\0', null, '2018-01-25 16:14:40', null);
INSERT INTO `system_menu` VALUES ('1009', '角色管理', 'roleManage', '1001', '/admin/system/role/roleManage', '', '0', '\0', null, '2018-01-25 16:14:56', null);

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
  `password_random` varchar(10) DEFAULT NULL COMMENT '登陆密码随机串',
  `department` int(2) DEFAULT NULL,
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
INSERT INTO `system_operator` VALUES ('1', '超管', '13000000000', '1', 'e9547f82c857a5eac526c2110af54f6f', 'e9547f82c857a5eac526c2110af54f6f', 'RcTaX5', '0', '\0', '2018-01-26 10:38:20', null, null);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与用户关系表';

-- ----------------------------
-- Records of system_operator_role
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of system_role
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与菜单关系表';

-- ----------------------------
-- Records of system_role_menu
-- ----------------------------

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
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `id_card` varchar(128) DEFAULT NULL COMMENT '身份证号(年月日加密)',
  `id_card_encrypt` varchar(512) DEFAULT NULL COMMENT '年月日加密',
  `password` varchar(128) NOT NULL COMMENT '登陆密码随机串',
  `password_random` varchar(10) NOT NULL COMMENT '登陆密码随机串',
  `pay_password` varchar(128) DEFAULT NULL COMMENT '交易密码',
  `pay_password_random` varchar(10) DEFAULT NULL COMMENT '交易密码随机串',
  `pay_error` tinyint(2) unsigned DEFAULT NULL COMMENT '支付密码输入错误次数',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` bit(1) DEFAULT b'1' COMMENT '状态 1正常 0:锁定',
  `channel` tinyint(3) unsigned DEFAULT '0' COMMENT '注册渠道0:pc,1:android,2:ios,3:h5,第三方渠道注册',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '邀请人的ID',
  `add_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `type` tinyint(1) DEFAULT '0' COMMENT '用户类型:0:投资人 1:代偿人',
  PRIMARY KEY (`id`),
  KEY `mobile_index` (`mobile`),
  KEY `email_index` (`email`),
  KEY `real_name_index` (`real_name`),
  KEY `id_card_index` (`id_card`),
  KEY `status_index` (`status`),
  KEY `channel_index` (`channel`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投资人信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '15966666666', null, null, null, null, '12', '1', null, null, null, null, '', '0', null, '2018-01-11 15:59:08', null, null);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户地址信息表';

-- ----------------------------
-- Records of user_address
-- ----------------------------
