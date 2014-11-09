/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : sail

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2014-11-09 21:12:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `friend_list`
-- ----------------------------
DROP TABLE IF EXISTS `friend_list`;
CREATE TABLE `friend_list` (
  `id` int(11) NOT NULL,
  `user_id` varchar(32) NOT NULL,
  `friend_id` varchar(32) NOT NULL,
  `group_name` varchar(255) DEFAULT '我的好友',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `friend_id` (`friend_id`),
  CONSTRAINT `friend_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `friend_list_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friend_list
-- ----------------------------

-- ----------------------------
-- Table structure for `group`
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `travel_route` text,
  `expense_min` int(11) DEFAULT NULL,
  `expense_max` int(11) DEFAULT NULL,
  `peope_max_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group
-- ----------------------------

-- ----------------------------
-- Table structure for `group_user_list`
-- ----------------------------
DROP TABLE IF EXISTS `group_user_list`;
CREATE TABLE `group_user_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL,
  `group_id` int(11) NOT NULL,
  `type` enum('creator','member') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_user_list_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `group_user_list_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_user_list
-- ----------------------------

-- ----------------------------
-- Table structure for `msg_broadcast`
-- ----------------------------
DROP TABLE IF EXISTS `msg_broadcast`;
CREATE TABLE `msg_broadcast` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_broadcast
-- ----------------------------
INSERT INTO `msg_broadcast` VALUES ('12', null, '2014-11-09 12:58:43');

-- ----------------------------
-- Table structure for `msg_friend_request`
-- ----------------------------
DROP TABLE IF EXISTS `msg_friend_request`;
CREATE TABLE `msg_friend_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invitor_id` varchar(32) NOT NULL,
  `invitee_id` varchar(32) NOT NULL,
  `verify_content` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `state` enum('') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invitor_user_id` (`invitor_id`),
  KEY `invited_user_id` (`invitee_id`),
  CONSTRAINT `msg_friend_request_ibfk_1` FOREIGN KEY (`invitor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `msg_friend_request_ibfk_2` FOREIGN KEY (`invitee_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_friend_request
-- ----------------------------
INSERT INTO `msg_friend_request` VALUES ('12', 'john', 'john', null, '2014-11-09 12:58:43', null);

-- ----------------------------
-- Table structure for `msg_group_chat`
-- ----------------------------
DROP TABLE IF EXISTS `msg_group_chat`;
CREATE TABLE `msg_group_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `sender_id` varchar(32) NOT NULL,
  `type` enum('text','photo') NOT NULL,
  `content` text NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `sender_id` (`sender_id`),
  CONSTRAINT `msg_group_chat_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `msg_group_chat_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_group_chat
-- ----------------------------

-- ----------------------------
-- Table structure for `msg_group_request`
-- ----------------------------
DROP TABLE IF EXISTS `msg_group_request`;
CREATE TABLE `msg_group_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL,
  `group_id` int(11) NOT NULL,
  `verify_content` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `type` enum('request','invitation') DEFAULT NULL,
  `state` enum('sended','received','accepted','rejected') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msg_group_request
-- ----------------------------

-- ----------------------------
-- Table structure for `private_letter`
-- ----------------------------
DROP TABLE IF EXISTS `private_letter`;
CREATE TABLE `private_letter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(32) NOT NULL,
  `receiver_id` varchar(32) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `state` enum('sended','received') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invitor_user_id` (`sender_id`),
  KEY `invited_user_id` (`receiver_id`),
  CONSTRAINT `private_letter_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`),
  CONSTRAINT `private_letter_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of private_letter
-- ----------------------------
INSERT INTO `private_letter` VALUES ('12', 'john', 'john', null, '2014-11-09 12:58:43', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nick_name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` decimal(32,0) DEFAULT NULL,
  `sex` enum('male','female') DEFAULT NULL,
  `nation` varchar(255) DEFAULT NULL,
  `hobby` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `birth_date` timestamp NULL DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `desc` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('john', 'john', '41232', null, null, null, null, null, null, null, null, null, null, null, null);
