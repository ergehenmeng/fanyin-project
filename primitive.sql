/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : easyui

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2018-09-07 15:51:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for fy_app_user
-- ----------------------------
DROP TABLE IF EXISTS `fy_app_user`;
CREATE TABLE `fy_app_user` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名,昵称',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `pwd` varchar(128) DEFAULT NULL COMMENT '密码',
  `gesture_pwd` varchar(128) DEFAULT NULL COMMENT '手势密码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of fy_app_user
-- ----------------------------
INSERT INTO `fy_app_user` VALUES ('C812458CDC9ACE71221F49931D4B81D2', '13755555555', '13755555555', 'DC9ACE71221F4993', '879F9A925015BD5D', '664956140@qq.com');

-- ----------------------------
-- Table structure for fy_token
-- ----------------------------
DROP TABLE IF EXISTS `fy_token`;
CREATE TABLE `fy_token` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `oauth_token` varchar(32) DEFAULT NULL COMMENT 'token值',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `expire_time` int(10) DEFAULT NULL COMMENT '超时时间 秒',
  `token_type` varchar(50) DEFAULT NULL COMMENT 'token类型',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of fy_token
-- ----------------------------
INSERT INTO `fy_token` VALUES ('1', 'FEBCBAAE13751F7F8E44C2F107AFB08D', '2017-03-13 13:53:17', '150000', 'mobile', 'C812458CDC9ACE71221F49931D4B81D2');

-- ----------------------------
-- Table structure for fy_user
-- ----------------------------
DROP TABLE IF EXISTS `fy_user`;
CREATE TABLE `fy_user` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名,昵称',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `pwd` varchar(128) DEFAULT NULL COMMENT '密码',
  `gesture_pwd` varchar(128) DEFAULT NULL COMMENT '手势密码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of fy_user
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` int(10) DEFAULT NULL,
  `num` int(10) DEFAULT NULL,
  `sid` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '10', '01');
INSERT INTO `product` VALUES ('1', '20', '02');
INSERT INTO `product` VALUES ('2', '8', '01');
INSERT INTO `product` VALUES ('3', '11', '01');
INSERT INTO `product` VALUES ('3', '8', '03');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mark_name` varchar(50) DEFAULT NULL COMMENT '系统参数名称',
  `sys_name` varchar(50) DEFAULT NULL COMMENT '系统参数key',
  `sys_value` varchar(500) DEFAULT NULL COMMENT '系统参数value',
  `is_del` bit(1) DEFAULT b'1' COMMENT '参数状态0:无效1:有效',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8 COMMENT='系统参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('10000', 'system_name', '系统名称', '二哥很猛', '', '2017-07-20 14:05:27', null, '2017-07-27 11:51:04', '10001', '设置整个后台系统的名称');
INSERT INTO `sys_config` VALUES ('10001', 'rsaEnable', '是否开启加密', '0', '', '2017-07-20 14:05:27', null, '2017-07-21 10:07:18', '10001', '');
INSERT INTO `sys_config` VALUES ('10002', 'locked', '密码输入错误次数', '5', '', '2017-07-20 14:05:27', null, '2017-07-21 10:08:19', '10001', '');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nid` varchar(20) DEFAULT NULL COMMENT '数据字典nid',
  `nid_name` varchar(20) DEFAULT NULL COMMENT '数据字典名称',
  `name` varchar(100) DEFAULT NULL COMMENT '数据字典列名称',
  `value` int(5) DEFAULT NULL COMMENT '值',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态:0删除 1:正常',
  `sort` int(5) DEFAULT NULL COMMENT '排序',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menu_name` varchar(8) DEFAULT NULL COMMENT '菜单名称',
  `menu_mark` varchar(20) DEFAULT NULL COMMENT '菜单标示符 唯一',
  `parent_id` int(10) DEFAULT NULL COMMENT '父节点ID,一级菜单默认为0',
  `menu_url` varchar(255) DEFAULT NULL COMMENT '菜单地址',
  `is_menu` bit(1) DEFAULT b'1' COMMENT '是否为左侧主菜单1:是 0:不是',
  `sort` int(3) DEFAULT NULL COMMENT '排序规则 小的排在前面',
  `is_del` bit(1) DEFAULT b'1' COMMENT '状态:0删除 1正常',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` bigint(11) DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `updated_by` bigint(11) DEFAULT NULL COMMENT '修改人',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1000', '基础管理', 'baseManage', '0', '', '', '1', '', '2017-07-19 10:43:26', null, '2017-07-24 17:33:15', '10001', '一级节点,不需要url');
INSERT INTO `sys_menu` VALUES ('1001', '系统管理', 'systemManage', '0', '', '', '3', '', '2017-07-19 10:43:26', null, '2017-07-20 09:38:40', '10001', '1');
INSERT INTO `sys_menu` VALUES ('1002', '业务管理', 'businessManage', '0', '', '', '2', '\0', '2017-07-19 10:43:26', null, '2017-07-20 10:38:35', '10001', '一级节点不需要url');
INSERT INTO `sys_menu` VALUES ('1003', '运营管理', 'operateManage', '1000', '', '', '1', '\0', '2017-07-19 10:43:26', null, '2017-07-20 10:38:24', '10001', '2');
INSERT INTO `sys_menu` VALUES ('1004', '菜单管理', 'menuManage', '1001', '/admin/system/menu/menuManage', '', '1', '', '2017-07-19 10:43:26', null, '2017-08-24 14:52:21', '10001', '1');
INSERT INTO `sys_menu` VALUES ('1005', '一级菜单', 'oneMenu', '0', '', '', '4', '\0', '2017-07-20 10:33:07', '10001', '2017-07-20 10:38:14', '10001', '测试的');
INSERT INTO `sys_menu` VALUES ('1006', '二级菜单', 'sencond', '1005', 'url', '', '1', '\0', '2017-07-20 10:33:53', '10001', '2017-07-20 10:37:19', '10001', '水电费');
INSERT INTO `sys_menu` VALUES ('1009', '系统参数', 'systemParamter', '1001', '/admin/system/config/systemConfigManage', '', '5', '', '2017-07-20 10:45:42', '10001', '2017-07-27 11:49:31', '10001', '');
INSERT INTO `sys_menu` VALUES ('1010', '用户管理', 'systemUser', '1001', '/admin/system/user/userManage', '', '3', '', '2017-07-25 14:10:20', null, '2017-07-25 14:10:20', null, null);
INSERT INTO `sys_menu` VALUES ('1012', '角色管理', 'roleManage', '1001', '/admin/system/role/roleManage', '', '4', '', '2017-07-26 14:44:07', null, '2017-07-27 11:50:40', '10001', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_name` varchar(10) DEFAULT NULL COMMENT '角色名称',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `created_by` int(11) DEFAULT NULL COMMENT '添加人员',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` int(11) DEFAULT '0' COMMENT '更新人',
  `is_del` bit(1) DEFAULT b'1' COMMENT '删除状态:1:正常 0:删除',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1000', '超级角色', '2016-07-05 15:02:15', '1000', '2017-07-27 11:57:40', '10001', '', '超管角色');
INSERT INTO `sys_role` VALUES ('1002', '业务部', '2017-07-26 15:21:38', '10001', '2017-07-27 15:05:22', '10004', '', '测试的');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(10) DEFAULT NULL COMMENT '角色Id',
  `menu_id` int(10) DEFAULT NULL COMMENT '菜单Id',
  PRIMARY KEY (`id`),
  KEY `role_id_FK` (`role_id`),
  CONSTRAINT `role_id_FK` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='角色与菜单关系表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('38', '1000', '1000');
INSERT INTO `sys_role_menu` VALUES ('39', '1000', '1001');
INSERT INTO `sys_role_menu` VALUES ('40', '1000', '1004');
INSERT INTO `sys_role_menu` VALUES ('41', '1000', '1010');
INSERT INTO `sys_role_menu` VALUES ('42', '1000', '1012');
INSERT INTO `sys_role_menu` VALUES ('43', '1000', '1009');
INSERT INTO `sys_role_menu` VALUES ('44', '1002', '1004');
INSERT INTO `sys_role_menu` VALUES ('45', '1002', '1010');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `account_name` varchar(50) DEFAULT NULL COMMENT '账户名称',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '显示名称',
  `pwd` varchar(64) DEFAULT NULL COMMENT '账户密码',
  `init_pwd` varchar(64) DEFAULT NULL COMMENT '初始密码',
  `mobile` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `status` tinyint(1) DEFAULT '1' COMMENT '账户状态:1:正常 0:锁定',
  `is_del` bit(1) DEFAULT b'1' COMMENT '删除状态:1正常 0:删除',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `created_by` int(11) DEFAULT NULL COMMENT '添加人',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `updated_by` int(11) DEFAULT NULL COMMENT '更新人员',
  `remarks` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('10001', 'admin', '超级管理员', 'C3CA77CE1EA738918F3B7B0287A7CC3D', '8CED92EF42797F58CE7EC9376F1544E9', '15968869548', '1', '', '2016-07-05 15:05:19', null, '2017-08-24 15:55:01', '10001', '水电费');
INSERT INTO `sys_user` VALUES ('10004', 'sigehenmeng', '四个很猛', 'C3CA77CE1EA738918F3B7B0287A7CC3D', '8CED92EF42797F58CE7EC9376F1544E9', '15333335513', '1', '', '2017-07-26 10:56:06', '10001', '2017-08-24 15:42:46', '10001', '');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) DEFAULT NULL COMMENT '用户id',
  `role_id` int(10) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色与用户关系表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('3', '10002', '1000');
INSERT INTO `sys_user_role` VALUES ('7', '10004', '1002');
INSERT INTO `sys_user_role` VALUES ('13', '10001', '1000');

-- ----------------------------
-- Function structure for getDict
-- ----------------------------
DROP FUNCTION IF EXISTS `getDict`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getDict`(`abca` varchar(200),`values` int(10)) RETURNS varchar(20) CHARSET utf8
BEGIN
	DECLARE abcdef varchar(20) default '';
	
	select account_name into abcdef from sys_user where mobile = abca;
	RETURN abcdef;
END
;;
DELIMITER ;
