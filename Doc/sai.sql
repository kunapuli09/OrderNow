-- MySQL dump 10.10
--
-- Host: localhost    Database: orderservice2009
-- ------------------------------------------------------
-- Server version	5.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--update CATEGORY set parent_category_id=2 where category_id in(3,4,6,7,10,11,12);
--
-- Table structure for table `CATEGORIZED_ITEM`
--

DROP TABLE IF EXISTS `CATEGORIZED_ITEM`;
CREATE TABLE `CATEGORIZED_ITEM` (
  `CATEGORY_ID` bigint(20) NOT NULL,
  `ITEM_ID` bigint(20) NOT NULL,
  `ADDED_BY_USER` varchar(16) NOT NULL,
  `ADDED_ON` datetime default NULL,
  PRIMARY KEY  (`CATEGORY_ID`,`ITEM_ID`),
  KEY `FK_CATEGORIZED_ITEM_ITEM_ID` (`ITEM_ID`),
  KEY `FK_CATEGORIZED_ITEM_CATEGORY_ID` (`CATEGORY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `CATEGORY`
--

DROP TABLE IF EXISTS `CATEGORY`;
CREATE TABLE `CATEGORY` (
  `CATEGORY_ID` bigint(20) NOT NULL auto_increment,
  `OBJ_VERSION` int(11) default NULL,
  `CATEGORY_NAME` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL,
  `PARENT_CATEGORY_ID` bigint(20) default NULL,
  PRIMARY KEY  (`CATEGORY_ID`),
  UNIQUE KEY `CATEGORY_NAME` (`CATEGORY_NAME`,`PARENT_CATEGORY_ID`),
  KEY `FK_CATEGORY_PARENT_ID` (`PARENT_CATEGORY_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `CATEGORY_ITEMS_BY_USER`
--

DROP TABLE IF EXISTS `CATEGORY_ITEMS_BY_USER`;
CREATE TABLE `CATEGORY_ITEMS_BY_USER` (
  `CATEGORY_ID` bigint(20) NOT NULL,
  `USER_ID` bigint(20) NOT NULL,
  `ITEM_ID` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`CATEGORY_ID`,`ITEM_ID`),
  KEY `FK94CC139375117D1A` (`ITEM_ID`),
  KEY `FK_CATEGORY_ITEMS_BY_USER_CATEGORY_ID` (`CATEGORY_ID`),
  KEY `FK_CATEGORY_ITEMS_BY_USER_USER_ID` (`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `CREDIT_CARD`
--

DROP TABLE IF EXISTS `CREDIT_CARD`;
CREATE TABLE `CREDIT_CARD` (
  `CC_TYPE` varchar(255) NOT NULL,
  `CC_NUMBER` varchar(16) NOT NULL,
  `CC_EXP_MONTH` varchar(2) NOT NULL,
  `CC_EXP_YEAR` varchar(4) NOT NULL,
  `CREDIT_CARD_ID` bigint(20) NOT NULL,
  PRIMARY KEY  (`CREDIT_CARD_ID`),
  KEY `FK6FFB0096DDCB334D` (`CREDIT_CARD_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
CREATE TABLE `CUSTOMER` (
  `CUSTOMER_ID` bigint(20) NOT NULL auto_increment,
  `inDeliveryArea` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_hint` varchar(255) default NULL,
  `password_hint_answer` varchar(255) default NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) default NULL,
  `address` varchar(150) default NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `zip_code` varchar(10) NOT NULL,
  `version` int(11) default NULL,
  `account_enabled` bit(1) default NULL,
  `account_expired` bit(1) NOT NULL,
  `account_locked` bit(1) NOT NULL,
  `credentials_expired` bit(1) NOT NULL,
  PRIMARY KEY  (`CUSTOMER_ID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `CUSTOMER_SERVICES`
--

DROP TABLE IF EXISTS `CUSTOMER_SERVICES`;
CREATE TABLE `CUSTOMER_SERVICES` (
  `CUSTOMER_ID` bigint(20) NOT NULL,
  `SERVICES_ID` bigint(20) default NULL,
  PRIMARY KEY  (`CUSTOMER_ID`),
  KEY `FK_CUSTOMER_SERVICES_CUSTOMER_ID` (`SERVICES_ID`),
  KEY `FK1315BB9F4E1253A` (`CUSTOMER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `FOOD_ORDER`
--

DROP TABLE IF EXISTS `FOOD_ORDER`;
CREATE TABLE `FOOD_ORDER` (
  `ORDER_ID` bigint(20) NOT NULL auto_increment,
  `TOTAL` float default NULL,
  `TAX` float default NULL,
  `STATUS` varchar(255) NOT NULL,
  `CREDIT_APPROVE_NUM` varchar(255),
  `CREDIT_VOID_RECNUM` varchar(255),
  `ORDER_DATE` varchar(255) NOT NULL,
  `ORDER_TIME` varchar(255) NOT NULL,
  `ORDER_NOTE` varchar(255) default NULL,
  `OBJ_VERSION` int(11) default NULL,
  PRIMARY KEY  (`ORDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ITEM`
--

DROP TABLE IF EXISTS `ITEM`;
CREATE TABLE `ITEM` (
  `ITEM_ID` bigint(20) NOT NULL auto_increment,
  `OBJ_VERSION` int(11) default NULL,
  `VALUE` decimal(12,2) default NULL,
  `CURRENCY` varchar(255) default NULL,
  `ITEM_NAME` varchar(255) NOT NULL,
  `DESCRIPTION` text NOT NULL,
  `START_DATE` datetime NOT NULL,
  `END_DATE` datetime NOT NULL,
  `ITEM_STATE` varchar(255) NOT NULL,
  `APPROVAL_DATETIME` datetime default NULL,
  `CREATED` datetime NOT NULL,
  `APPROVED_BY_USER_ID` bigint(20) default NULL,
  PRIMARY KEY  (`ITEM_ID`),
  KEY `IDX_END_DATE` (`END_DATE`),
  KEY `FK_APPROVED_BY_USER_ID` (`APPROVED_BY_USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ITEM_IMAGES`
--

DROP TABLE IF EXISTS `ITEM_IMAGES`;
CREATE TABLE `ITEM_IMAGES` (
  `ITEM_ID` bigint(20) NOT NULL,
  `FILENAME` varchar(255) default NULL,
  `ITEM_IMAGE_ID` bigint(20) NOT NULL auto_increment,
  PRIMARY KEY  (`ITEM_IMAGE_ID`),
  KEY `FK_ITEM_IMAGE_ITEM_ID` (`ITEM_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ITEM_OPTION`
--

DROP TABLE IF EXISTS `ITEM_OPTION`;
CREATE TABLE `ITEM_OPTION` (
  `ITEM_OPTION_ID` bigint(20) NOT NULL auto_increment,
  `DESCRIPTION` varchar(255) default NULL,
  `VALUE` decimal(12,2) default NULL,
  `CURRENCY` varchar(255) default NULL,
  `ITEM_ID` bigint(20) default NULL,
  PRIMARY KEY  (`ITEM_OPTION_ID`),
  KEY `FKFF49FB2175117D1A` (`ITEM_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ITEM_PROMOTION`
--

DROP TABLE IF EXISTS `ITEM_PROMOTION`;
CREATE TABLE `ITEM_PROMOTION` (
  `ITEM_PROMOTION_ID` bigint(20) NOT NULL auto_increment,
  `DESCRIPTION` varchar(255) default NULL,
  `VALUE` decimal(12,2) default NULL,
  `CURRENCY` varchar(255) default NULL,
  `IMAGE_FILE_NAME` varchar(255) default NULL,
  `STATUS` varchar(255) NOT NULL,
  `START_DATE` datetime NOT NULL,
  `END_DATE` datetime NOT NULL,
  `ITEM_ID` bigint(20) default NULL,
  PRIMARY KEY  (`ITEM_PROMOTION_ID`),
  KEY `IDX_PROMOTION_END_DATE` (`END_DATE`),
  KEY `FKA49DFE5775117D1A` (`ITEM_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ORDER_BUYER`
--

DROP TABLE IF EXISTS `ORDER_BUYER`;
CREATE TABLE `ORDER_BUYER` (
  `ORDER_ID` bigint(20) NOT NULL,
  `USER_ID` bigint(20) default NULL,
  PRIMARY KEY  (`ORDER_ID`),
  KEY `FK_ORDER_BUYER_USER_ID` (`USER_ID`),
  KEY `FK2B9D614230CF46BA` (`ORDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ORDER_ITEM`
--

DROP TABLE IF EXISTS `ORDER_ITEM`;
CREATE TABLE `ORDER_ITEM` (
  `ORDER_ID` bigint(20) NOT NULL,
  `ITEM_ID` bigint(20) NOT NULL,
  `QUANTITY` int(11) NOT NULL,
  PRIMARY KEY  (`ORDER_ID`,`ITEM_ID`,`QUANTITY`),
  KEY `FK4BBDE98475117D1A` (`ITEM_ID`),
  KEY `FK4BBDE98430CF46BA` (`ORDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ORDER_SELLER`
--

DROP TABLE IF EXISTS `ORDER_SELLER`;
CREATE TABLE `ORDER_SELLER` (
  `ORDER_ID` bigint(20) NOT NULL,
  `USER_ID` bigint(20) default NULL,
  PRIMARY KEY  (`ORDER_ID`),
  KEY `FK_ORDER_SELLER_USER_ID` (`USER_ID`),
  KEY `FK6429E1B030CF46BA` (`ORDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `ORDER_SHIPMENT`
--

DROP TABLE IF EXISTS `ORDER_SHIPMENT`;
CREATE TABLE `ORDER_SHIPMENT` (
  `ORDER_ID` bigint(20) NOT NULL,
  `SHIPMENT_ID` bigint(20) NOT NULL,
  PRIMARY KEY  (`SHIPMENT_ID`),
  KEY `FK_ORDER_SHIPMENT_USER_ID` (`SHIPMENT_ID`),
  KEY `FK9B08378B30CF46BA` (`ORDER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `PAYMENT_DETAIL`
--

DROP TABLE IF EXISTS `PAYMENT_DETAIL`;
CREATE TABLE `PAYMENT_DETAIL` (
  `PAYMENT_DETAIL_TYPE` varchar(31) NOT NULL,
  `PAYMENT_DETAIL_ID` bigint(20) NOT NULL auto_increment,
  `OBJ_VERSION` int(11) default NULL,
  `CREATED` datetime NOT NULL,
  `PAYMENT_DATE` datetime default NULL,
  `PAYMENT_AMOUNT` double default NULL,
  `PAYMENT_RECEIVED` bit(1) default NULL,
  `BA_ACCOUNT` varchar(255) default NULL,
  `BA_BANKNAME` varchar(255) default NULL,
  `BA_SWIFT` varchar(255) default NULL,
  `CHECK_NUMBER` varchar(255) default NULL,
  `USER_ID` bigint(20) default NULL,
  PRIMARY KEY  (`PAYMENT_DETAIL_ID`),
  KEY `FK_USER_ID` (`USER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `SERVICES`
--

DROP TABLE IF EXISTS `SERVICES`;
CREATE TABLE `SERVICES` (
  `SERVICES_ID` bigint(20) NOT NULL auto_increment,
  `emailService` bit(1) default NULL,
  `phoneService` bit(1) default NULL,
  `faxService` bit(1) default NULL,
  `deliveryService` bit(1) default NULL,
  `creditService` bit(1) default NULL,
  `ordersService` bit(1) default NULL,
  `updateOrdersService` bit(1) default NULL,
  PRIMARY KEY  (`SERVICES_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `SHIPMENT`
--

DROP TABLE IF EXISTS `SHIPMENT`;
CREATE TABLE `SHIPMENT` (
  `SHIPMENT_ID` bigint(20) NOT NULL auto_increment,
  `OBJ_VERSION` int(11) default NULL,
  `address` varchar(150) default NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `zip_code` varchar(10) NOT NULL,
  `INSPECTION_PERIOD_DAYS` int(11) NOT NULL,
  `SHIPMENT_STATE` varchar(255) NOT NULL,
  `SHIPMENT_TYPE` varchar(255) NOT NULL,
  `CREATED` datetime NOT NULL,
  PRIMARY KEY  (`SHIPMENT_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `USER_PRIVILEGE`
--

DROP TABLE IF EXISTS `USER_PRIVILEGE`;
CREATE TABLE `USER_PRIVILEGE` (
  `id` int(11) NOT NULL auto_increment,
  `privilege` varchar(255) default NULL,
  `customer_CUSTOMER_ID` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK695E31DB0482659` (`customer_CUSTOMER_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

