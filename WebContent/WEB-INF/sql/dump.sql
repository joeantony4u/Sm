-- MySQL dump 10.13  Distrib 5.1.50, for Win32 (ia32)
--
-- Host: localhost    Database: stoman
-- ------------------------------------------------------
-- Server version	5.1.50-community

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

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `street_name_1` varchar(45) DEFAULT NULL,
  `street_name_2` varchar(45) DEFAULT NULL,
  `area` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'','','','',0,'',''),(32,'','','','',0,'lovely',''),(39,'','','','',0,'',''),(56,'','','','',0,'',''),(57,'','','','',0,'',''),(58,'ghfg','jkb','jkbj','bj',0,'b','jbj'),(59,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(60,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(61,'dvfgy','yvyuv','','',0,'','');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materials` (
  `material_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `sensitivity` int(11) DEFAULT NULL,
  `importance` int(11) DEFAULT NULL,
  PRIMARY KEY (`material_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'',1,1),(2,'brick',1,1),(3,'sand',1,1),(4,'rod',1,1),(5,'brick2',NULL,NULL),(6,'brick3',NULL,NULL),(7,'brick4',NULL,NULL),(8,'material121',1,1),(9,'brick45',NULL,NULL),(10,'brickw',NULL,NULL);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_materials`
--

DROP TABLE IF EXISTS `purchase_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_materials` (
  `purchase_material_id` int(11) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `vendor_material_id` int(11) NOT NULL,
  `ordered_quantity` int(11) NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_date` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `delievered_date` datetime DEFAULT NULL,
  `cancelled_date` datetime DEFAULT NULL,
  PRIMARY KEY (`purchase_material_id`),
  KEY `fk_purshase_orders_purshase_order_materials` (`purchase_order_id`),
  KEY `fk_vendor_materials_purchase_order_materials` (`vendor_material_id`),
  KEY `fk_users_purchase_materials` (`modified_by`),
  CONSTRAINT `fk_purshase_orders_purshase_order_materials` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchase_materials` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendor_materials_purchase_order_materials` FOREIGN KEY (`vendor_material_id`) REFERENCES `vendor_materials` (`vendor_material_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_materials`
--

LOCK TABLES `purchase_materials` WRITE;
/*!40000 ALTER TABLE `purchase_materials` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_monitors`
--

DROP TABLE IF EXISTS `purchase_order_monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_monitors` (
  `purchase_order_monitor_id` int(11) NOT NULL,
  `purchase_material_id` int(11) NOT NULL,
  `received_date` datetime NOT NULL,
  `received_quantity` int(11) NOT NULL,
  `modified_date` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  PRIMARY KEY (`purchase_order_monitor_id`),
  KEY `fk_purchase_materials_purchase_order_monitors` (`purchase_material_id`),
  KEY `fk_users_purchase_order_monitors` (`modified_by`),
  CONSTRAINT `fk_purchase_materials_purchase_order_monitors` FOREIGN KEY (`purchase_material_id`) REFERENCES `purchase_materials` (`purchase_material_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_purchase_order_monitors` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_monitors`
--

LOCK TABLES `purchase_order_monitors` WRITE;
/*!40000 ALTER TABLE `purchase_order_monitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_monitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_orders` (
  `purchase_order_id` int(11) NOT NULL,
  PRIMARY KEY (`purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_orders`
--

LOCK TABLES `purchase_orders` WRITE;
/*!40000 ALTER TABLE `purchase_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank_archives`
--

DROP TABLE IF EXISTS `rank_archives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rank_archives` (
  `rank_archive_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `expired_date` varchar(45) NOT NULL,
  `modified_by` int(11) NOT NULL,
  PRIMARY KEY (`rank_archive_id`),
  KEY `fk_vendors_rank_archives` (`vendor_id`),
  KEY `fk_users_rank_archives` (`modified_by`),
  CONSTRAINT `fk_users_rank_archives` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_rank_archives` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank_archives`
--

LOCK TABLES `rank_archives` WRITE;
/*!40000 ALTER TABLE `rank_archives` DISABLE KEYS */;
/*!40000 ALTER TABLE `rank_archives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ranks`
--

DROP TABLE IF EXISTS `ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranks` (
  `rank_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `trust_level` varchar(45) DEFAULT NULL,
  `modified_date` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  PRIMARY KEY (`rank_id`),
  UNIQUE KEY `vendor_id_UNIQUE` (`vendor_id`),
  KEY `fk_vendors_ranks` (`vendor_id`),
  KEY `fk_users_ranks` (`modified_by`),
  CONSTRAINT `fk_users_ranks` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_ranks` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranks`
--

LOCK TABLES `ranks` WRITE;
/*!40000 ALTER TABLE `ranks` DISABLE KEYS */;
INSERT INTO `ranks` VALUES (1,1,1,'1','2000-01-01 00:00:00',1),(2,32,2,'2','2000-01-01 00:00:00',1),(3,39,3,'3','2000-01-01 00:00:00',1),(4,56,4,'4','2000-01-01 00:00:00',1),(5,57,5,'5','2000-01-01 00:00:00',1),(6,58,6,'6','2000-01-01 00:00:00',1),(7,59,0,NULL,'2011-01-16 17:33:05',1),(8,60,0,NULL,'2011-01-16 17:52:05',1),(9,61,0,NULL,'2011-01-17 21:35:24',1),(10,63,0,NULL,'2011-01-20 14:26:16',1),(11,64,0,NULL,'2011-01-30 12:48:37',1);
/*!40000 ALTER TABLE `ranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_addresses_users` (`address_id`),
  CONSTRAINT `fk_addresses_users` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin',1,'2000-01-01 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_material_archives`
--

DROP TABLE IF EXISTS `vendor_material_archives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_material_archives` (
  `vendor_material_archive_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `price_start_date` datetime DEFAULT NULL,
  `price_end_date` datetime DEFAULT NULL,
  `modified_date` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  PRIMARY KEY (`vendor_material_archive_id`),
  KEY `fk_vendors_vendor_material_archives` (`vendor_id`),
  KEY `fk_materials_vendor_material_archives` (`material_id`),
  KEY `fk_users_vendor_material_archives` (`modified_by`),
  CONSTRAINT `fk_materials_vendor_material_archives` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_vendor_material_archives` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendor_material_archives` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_material_archives`
--

LOCK TABLES `vendor_material_archives` WRITE;
/*!40000 ALTER TABLE `vendor_material_archives` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_material_archives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_materials`
--

DROP TABLE IF EXISTS `vendor_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_materials` (
  `vendor_material_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `price_start_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `modified_by` int(11) NOT NULL,
  `max_qty_per_order` int(11) DEFAULT '65535',
  PRIMARY KEY (`vendor_material_id`),
  KEY `fk_materials_vendor_materials` (`material_id`),
  KEY `fk_vendors_vendor_materials` (`vendor_id`),
  KEY `fk_users_vendor_materials` (`modified_by`),
  CONSTRAINT `fk_materials_vendor_materials` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_vendor_materials` FOREIGN KEY (`modified_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendors_vendor_materials` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_materials`
--

LOCK TABLES `vendor_materials` WRITE;
/*!40000 ALTER TABLE `vendor_materials` DISABLE KEYS */;
INSERT INTO `vendor_materials` VALUES (1,32,2,'2000-01-01 00:00:00','2000-01-01 00:00:00',1,65535),(2,39,3,'2000-01-01 00:00:00','2000-01-01 00:00:00',1,65535),(3,59,5,'2011-01-16 17:33:05','2011-01-16 17:33:05',1,NULL),(4,60,6,'2011-01-16 17:52:05','2011-01-16 17:52:05',1,NULL),(5,61,7,'2011-01-17 21:35:24','2011-01-17 21:35:24',1,NULL),(6,63,9,'2011-01-20 14:26:16','2011-01-20 14:26:16',1,NULL),(7,64,10,'2011-01-30 12:48:37','2011-01-30 12:48:37',1,NULL);
/*!40000 ALTER TABLE `vendor_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendors` (
  `vendor_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address_id` int(11) DEFAULT '1',
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_addresses_vendors` (`address_id`),
  CONSTRAINT `fk_addresses_vendors` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendors`
--

LOCK TABLES `vendors` WRITE;
/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
INSERT INTO `vendors` VALUES (1,'duu',1),(32,'gdf',32),(39,'vndr1',39),(56,'vvv',56),(57,'vdf1',57),(58,'vendor1',58),(59,'vendor2',59),(60,'vendor3',60),(61,'vendor4',1),(62,'testing',61),(63,'v12',1),(64,'vdd',1);
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-01-30 14:20:26
