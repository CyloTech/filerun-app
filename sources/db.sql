-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: filerun
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `df_collections`
--

DROP TABLE IF EXISTS `df_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('regular','album') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `uid` mediumint NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_collections`
--

LOCK TABLES `df_collections` WRITE;
/*!40000 ALTER TABLE `df_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_collections_items`
--

DROP TABLE IF EXISTS `df_collections_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_collections_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cid` int NOT NULL,
  `pid` int NOT NULL,
  `share_id` int DEFAULT NULL,
  `added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uid` mediumint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_pid` (`cid`),
  KEY `pid` (`pid`),
  KEY `cid` (`cid`,`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_collections_items`
--

LOCK TABLES `df_collections_items` WRITE;
/*!40000 ALTER TABLE `df_collections_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_collections_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_file_handlers`
--

DROP TABLE IF EXISTS `df_file_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_file_handlers` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` mediumint DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handler` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handler_edit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weblink_handler` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weblink_edit_handler` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_file_handlers`
--

LOCK TABLES `df_file_handlers` WRITE;
/*!40000 ALTER TABLE `df_file_handlers` DISABLE KEYS */;
INSERT INTO `df_file_handlers` VALUES (1,NULL,'txt',NULL,'plain_text_viewer','code_editor','plain_text_viewer','code_editor'),(2,NULL,'code',NULL,'code_editor','code_editor','code_editor','code_editor'),(3,NULL,'img',NULL,'image_viewer','image_editor','image_viewer','image_editor'),(4,NULL,'img2',NULL,'image_viewer','image_editor','image_viewer','image_editor'),(5,NULL,'raw',NULL,'image_viewer','image_editor','image_viewer',NULL),(6,NULL,'wvideo',NULL,'video_player',NULL,'video_player',NULL),(7,NULL,'mp3',NULL,'audio_player',NULL,'audio_player',NULL),(8,NULL,'office',NULL,'libreoffice_viewer',NULL,'libreoffice_viewer',NULL),(9,NULL,'ooffice',NULL,'libreoffice_viewer',NULL,'libreoffice_viewer',NULL),(10,NULL,'arch',NULL,'arch',NULL,NULL,NULL),(11,NULL,'3d',NULL,'3d_viewer',NULL,'3d_viewer',NULL),(12,NULL,'cad',NULL,'autodesk',NULL,'autodesk',NULL),(13,NULL,NULL,'odt','webodf',NULL,'webodf',NULL),(14,NULL,NULL,'ods','webodf',NULL,'webodf',NULL),(15,NULL,NULL,'odp','webodf',NULL,'webodf',NULL),(16,NULL,NULL,'pdf','open_in_browser',NULL,'open_in_browser',NULL),(17,NULL,NULL,'url','handle_url',NULL,'handle_url',NULL),(18,NULL,NULL,'html','code_editor','code_editor','code_editor','code_editor'),(19,NULL,NULL,'kml','kml_viewer',NULL,'kml_viewer',NULL),(20,NULL,NULL,'kmz','kml_viewer',NULL,'kml_viewer',NULL),(21,NULL,NULL,'gpx','bing_kml_viewer',NULL,'bing_kml_viewer',NULL),(22,NULL,NULL,'md','markdown_viewer','code_editor','markdown_viewer','code_editor'),(23,NULL,NULL,'epub','epub_reader',NULL,'epub_reader',NULL),(24,NULL,NULL,'csv','csv_editor','csv_editor','csv_editor','csv_editor');
/*!40000 ALTER TABLE `df_file_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_file_logs`
--

DROP TABLE IF EXISTS `df_file_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_file_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `uid` mediumint NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`),
  KEY `action` (`action`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_file_logs`
--

LOCK TABLES `df_file_logs` WRITE;
/*!40000 ALTER TABLE `df_file_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_file_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_logs`
--

DROP TABLE IF EXISTS `df_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '2002-02-02 00:00:00',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` mediumint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `df_modules_folders_notifications`
--

DROP TABLE IF EXISTS `df_modules_folders_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_folders_notifications` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `pathid` int NOT NULL,
  `shareid` int DEFAULT NULL,
  `notify_write` int NOT NULL DEFAULT '0',
  `notify_read` int NOT NULL DEFAULT '0',
  `notify_social` int NOT NULL DEFAULT '0',
  `notify_misc` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`pathid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_folders_notifications`
--

LOCK TABLES `df_modules_folders_notifications` WRITE;
/*!40000 ALTER TABLE `df_modules_folders_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_folders_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_dt`
--

DROP TABLE IF EXISTS `df_modules_metadata_dt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_metadata_dt` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `owner` mediumint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ext` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `system` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_dt`
--

LOCK TABLES `df_modules_metadata_dt` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_dt` DISABLE KEYS */;
INSERT INTO `df_modules_metadata_dt` VALUES (1,0,'Documents','System type','pdf,txt','office,ooffice',1),(2,0,'Photos','System type','psb,psd,tiff,tif,bmp','img,raw',1),(3,0,'Audio','System type','','mp3,audio',1),(4,0,'Video','System type','','wvideo,video',1);
/*!40000 ALTER TABLE `df_modules_metadata_dt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_fields`
--

DROP TABLE IF EXISTS `df_modules_metadata_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_metadata_fields` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `fsid` mediumint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `autocomplete` smallint DEFAULT NULL,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hide_fieldset_name_in_column` smallint NOT NULL DEFAULT '0',
  `hide_field_via_weblinks` smallint NOT NULL DEFAULT '0',
  `show_column_by_default` smallint NOT NULL DEFAULT '0',
  `system` smallint NOT NULL DEFAULT '0',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `system` (`system`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_fields`
--

LOCK TABLES `df_modules_metadata_fields` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_fields` DISABLE KEYS */;
INSERT INTO `df_modules_metadata_fields` VALUES (1,0,'comment','Comments (System)','',NULL,'',0,0,0,1,NULL,NULL),(2,0,'filelog','File Logs (System)','',NULL,'',0,0,0,1,NULL,NULL),(3,0,'label','Labels (System)','',NULL,'',0,0,0,1,NULL,NULL),(4,0,'star','Stars (System)','',NULL,'',0,0,0,1,NULL,NULL),(5,0,'filename','Search (System)','',NULL,'',0,0,0,1,NULL,NULL),(6,0,'zoho_collab','Zoho Collaborative Editing (System)','',NULL,'',0,0,0,1,NULL,NULL),(7,0,'autodesk_urn','Autodesk Viewer (System)','',NULL,'',0,0,0,1,NULL,NULL),(8,0,'Tags','','multiple',NULL,'',0,0,0,1,'Tags',NULL),(9,3,'Width','','small',NULL,'',1,0,0,0,'MWG->width',1),(10,3,'Height','','small',NULL,'',1,0,0,0,'MWG->height',2),(11,3,'Date taken','','date',NULL,'',1,0,0,0,'MWG->DateCreated',3),(12,3,'Author','','multiple',NULL,'',1,0,0,0,'MWG->Creator',4),(13,3,'Description','','large',NULL,'',1,0,0,0,'MWG->Description',5),(14,3,'Copyright','','',NULL,'',1,0,0,0,'MWG->Copyright',6),(15,3,'GPS latitude','','small',NULL,'',1,0,0,0,'MWG->GPSlatitude',7),(16,3,'GPS longitude','','small',NULL,'',1,0,0,0,'MWG->GPSlongitude',8),(17,4,'Date taken','','date',NULL,'',1,0,0,0,'video->DateCreated',1),(18,4,'Movie title','','',NULL,'',1,0,0,0,'video->title',2),(19,4,'Width','','small',NULL,'',1,0,0,0,'video->width',3),(20,4,'Height','','small',NULL,'',1,0,0,0,'video->height',4),(21,4,'Codec','','',NULL,'',1,0,0,0,'video->codec',5),(22,4,'GPS latitude','','small',NULL,'',1,0,0,0,'video->GPSLatitude',6),(23,4,'GPS longitude','','small',NULL,'',1,0,0,0,'video->GPSLongitude',7),(24,5,'Artist','','',NULL,'',1,0,0,0,'audio->artist',1),(25,5,'Title','','',NULL,'',1,0,0,0,'audio->title',2),(26,5,'Album','','',NULL,'',1,0,0,0,'audio->album',3),(27,5,'Duration','','small',NULL,'',1,0,0,0,'audio->playtime',4),(28,5,'Codec','','',NULL,'',1,0,0,0,'audio->codec',5),(29,6,'Author','','',NULL,'',1,0,0,0,NULL,1),(30,6,'Description','','',NULL,'',1,0,0,0,NULL,2),(31,0,'Rating','','stars',NULL,'',1,0,0,1,'Rating',NULL);
/*!40000 ALTER TABLE `df_modules_metadata_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_fieldsets`
--

DROP TABLE IF EXISTS `df_modules_metadata_fieldsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_metadata_fieldsets` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `owner` mediumint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `generic` smallint NOT NULL DEFAULT '0',
  `system` smallint NOT NULL DEFAULT '0',
  `visible` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_fieldsets`
--

LOCK TABLES `df_modules_metadata_fieldsets` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_fieldsets` DISABLE KEYS */;
INSERT INTO `df_modules_metadata_fieldsets` VALUES (1,0,'Comments (System)','Required for the file commenting system',1,1,0),(2,0,'Label (System)','Required for the label system',1,1,0),(3,0,'Image properties','',0,1,1),(4,0,'Video properties','',0,1,1),(5,0,'Audio properties','',0,1,1),(6,0,'Various information','',1,0,1);
/*!40000 ALTER TABLE `df_modules_metadata_fieldsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_files`
--

DROP TABLE IF EXISTS `df_modules_metadata_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_metadata_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `type_id` mediumint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`),
  KEY `type_id` (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_files`
--

LOCK TABLES `df_modules_metadata_files` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_metadata_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_values`
--

DROP TABLE IF EXISTS `df_modules_metadata_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_metadata_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `uid` mediumint NOT NULL,
  `share_id` mediumint DEFAULT NULL,
  `file_id` mediumint NOT NULL,
  `field_id` mediumint NOT NULL,
  `val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `date_added` (`date_added`),
  KEY `uid` (`uid`,`file_id`,`field_id`),
  KEY `file_id` (`file_id`,`field_id`),
  KEY `uid_2` (`uid`,`field_id`),
  KEY `val` (`val`(100)),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_values`
--

LOCK TABLES `df_modules_metadata_values` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_metadata_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_notifications`
--

DROP TABLE IF EXISTS `df_modules_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_notifications` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `owner` mediumint DEFAULT NULL,
  `object_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `object_id` mediumint NOT NULL DEFAULT '0',
  `action` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_notifications`
--

LOCK TABLES `df_modules_notifications` WRITE;
/*!40000 ALTER TABLE `df_modules_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_search_index_queue`
--

DROP TABLE IF EXISTS `df_modules_search_index_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_search_index_queue` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` mediumint NOT NULL,
  `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_search_index_queue`
--

LOCK TABLES `df_modules_search_index_queue` WRITE;
/*!40000 ALTER TABLE `df_modules_search_index_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_search_index_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_shares`
--

DROP TABLE IF EXISTS `df_modules_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_shares` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` mediumint NOT NULL,
  `created` datetime NOT NULL,
  `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `with_gid` mediumint DEFAULT NULL,
  `with_uid` mediumint DEFAULT NULL,
  `anonymous` smallint NOT NULL DEFAULT '0',
  `perms_upload` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_download` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_comment` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_read_comments` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_alter` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_share` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`path`(248))
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_shares`
--

LOCK TABLES `df_modules_shares` WRITE;
/*!40000 ALTER TABLE `df_modules_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_trash`
--

DROP TABLE IF EXISTS `df_modules_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_trash` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` mediumint NOT NULL,
  `relative_path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_deleted` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_trash`
--

LOCK TABLES `df_modules_trash` WRITE;
/*!40000 ALTER TABLE `df_modules_trash` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_user_groups`
--

DROP TABLE IF EXISTS `df_modules_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_user_groups` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` mediumint DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_user_groups`
--

LOCK TABLES `df_modules_user_groups` WRITE;
/*!40000 ALTER TABLE `df_modules_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_user_roles`
--

DROP TABLE IF EXISTS `df_modules_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_user_roles` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `system` smallint NOT NULL DEFAULT '0',
  `owner` mediumint DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_users` smallint NOT NULL DEFAULT '0',
  `admin_roles` smallint NOT NULL DEFAULT '0',
  `admin_notifications` smallint NOT NULL DEFAULT '0',
  `admin_logs` smallint NOT NULL DEFAULT '0',
  `admin_metadata` smallint NOT NULL DEFAULT '0',
  `admin_over` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_max_users` smallint NOT NULL DEFAULT '0',
  `admin_homefolder_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `homefolder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_folder` smallint NOT NULL DEFAULT '1',
  `space_quota_max` int DEFAULT NULL,
  `space_quota_current` int NOT NULL DEFAULT '0',
  `readonly` smallint DEFAULT NULL,
  `upload` smallint DEFAULT NULL,
  `upload_max_size` bigint DEFAULT NULL,
  `upload_limit_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `download` smallint DEFAULT NULL,
  `preview` smallint DEFAULT '1',
  `download_folders` smallint DEFAULT NULL,
  `read_comments` smallint DEFAULT NULL,
  `write_comments` smallint DEFAULT NULL,
  `email` smallint NOT NULL DEFAULT '0',
  `weblink` smallint NOT NULL DEFAULT '0',
  `share` smallint NOT NULL DEFAULT '0',
  `share_guests` smallint NOT NULL DEFAULT '0',
  `metadata` smallint NOT NULL DEFAULT '0',
  `file_history` smallint NOT NULL DEFAULT '0',
  `users_may_see` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `change_pass` smallint NOT NULL DEFAULT '1',
  `edit_profile` smallint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_user_roles`
--

LOCK TABLES `df_modules_user_roles` WRITE;
/*!40000 ALTER TABLE `df_modules_user_roles` DISABLE KEYS */;
INSERT INTO `df_modules_user_roles` VALUES (1,1,NULL,'Guest','Automatically deleted when there are no files shared with.','',0,0,0,0,0,'',0,'','',0,NULL,0,1,0,NULL,NULL,1,1,0,0,0,0,0,0,0,0,0,'-ALL-',0,0);
/*!40000 ALTER TABLE `df_modules_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_weblinks`
--

DROP TABLE IF EXISTS `df_modules_weblinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_modules_weblinks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_rnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `uid` mediumint NOT NULL,
  `pathid` int DEFAULT NULL,
  `cid` int DEFAULT NULL,
  `share_id` mediumint DEFAULT NULL,
  `short_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `expiry` datetime DEFAULT NULL,
  `download_limit` mediumint DEFAULT NULL,
  `allow_uploads` int NOT NULL DEFAULT '0',
  `allow_editing` int NOT NULL DEFAULT '0',
  `allow_downloads` int NOT NULL DEFAULT '1',
  `system` smallint NOT NULL DEFAULT '0',
  `notify` mediumint NOT NULL DEFAULT '0',
  `download_terms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `show_comments` tinyint(1) NOT NULL DEFAULT '0',
  `show_comments_names` tinyint(1) NOT NULL DEFAULT '0',
  `show_metadata` tinyint(1) NOT NULL DEFAULT '0',
  `require_login` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_rnd` (`id_rnd`),
  KEY `uid` (`uid`,`pathid`),
  KEY `expiry` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_weblinks`
--

LOCK TABLES `df_modules_weblinks` WRITE;
/*!40000 ALTER TABLE `df_modules_weblinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_modules_weblinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_notifications_logs`
--

DROP TABLE IF EXISTS `df_notifications_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_notifications_logs` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `has_errors` smallint NOT NULL DEFAULT '0',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_notifications_logs`
--

LOCK TABLES `df_notifications_logs` WRITE;
/*!40000 ALTER TABLE `df_notifications_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_notifications_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_access_token_scopes`
--

DROP TABLE IF EXISTS `df_oauth_access_token_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_access_token_scopes` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `access_token_id` mediumint NOT NULL,
  `scope` mediumint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `access_token_id` (`access_token_id`),
  KEY `scope` (`scope`),
  CONSTRAINT `df_oauth_access_token_scopes_ibfk_1` FOREIGN KEY (`access_token_id`) REFERENCES `df_oauth_access_tokens` (`id`) ON DELETE CASCADE,
  CONSTRAINT `df_oauth_access_token_scopes_ibfk_2` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_access_token_scopes`
--

LOCK TABLES `df_oauth_access_token_scopes` WRITE;
/*!40000 ALTER TABLE `df_oauth_access_token_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_access_token_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_access_tokens`
--

DROP TABLE IF EXISTS `df_oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_access_tokens` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `access_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sid` mediumint NOT NULL,
  `expiry` int NOT NULL,
  `device_uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `sid` (`sid`),
  CONSTRAINT `df_oauth_access_tokens_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_access_tokens`
--

LOCK TABLES `df_oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `df_oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_auth_code_scopes`
--

DROP TABLE IF EXISTS `df_oauth_auth_code_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_auth_code_scopes` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `auth_code_id` mediumint NOT NULL,
  `scope` mediumint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_code_id` (`auth_code_id`),
  KEY `scope` (`scope`),
  CONSTRAINT `df_oauth_auth_code_scopes_ibfk_1` FOREIGN KEY (`auth_code_id`) REFERENCES `df_oauth_auth_codes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `df_oauth_auth_code_scopes_ibfk_2` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_auth_code_scopes`
--

LOCK TABLES `df_oauth_auth_code_scopes` WRITE;
/*!40000 ALTER TABLE `df_oauth_auth_code_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_auth_code_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_auth_codes`
--

DROP TABLE IF EXISTS `df_oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_auth_codes` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `auth_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sid` mediumint NOT NULL,
  `redirect_uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  CONSTRAINT `df_oauth_auth_codes_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_auth_codes`
--

LOCK TABLES `df_oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `df_oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_client_redirect_uris`
--

DROP TABLE IF EXISTS `df_oauth_client_redirect_uris`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_client_redirect_uris` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `cid` mediumint NOT NULL,
  `uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `df_oauth_client_redirect_uris_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `df_oauth_clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_client_redirect_uris`
--

LOCK TABLES `df_oauth_client_redirect_uris` WRITE;
/*!40000 ALTER TABLE `df_oauth_client_redirect_uris` DISABLE KEYS */;
INSERT INTO `df_oauth_client_redirect_uris` VALUES (1,1,'filerun://'),(2,2,'nc://');
/*!40000 ALTER TABLE `df_oauth_client_redirect_uris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_clients`
--

DROP TABLE IF EXISTS `df_oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_clients` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `enabled` smallint NOT NULL DEFAULT '0',
  `cid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `publisher_website` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_clients`
--

LOCK TABLES `df_oauth_clients` WRITE;
/*!40000 ALTER TABLE `df_oauth_clients` DISABLE KEYS */;
INSERT INTO `df_oauth_clients` VALUES (1,1,'FileRun0000000000000000000Mobile','0000000000000000NoSecret0000000000000000','https://filerun.com/images/logo-mobile-app.png','FileRun Mobile','FileRun, Lda','Authentication for the mobile apps','https://filerun.com','https://filerun.com'),(2,1,'Nextcloud0000000000000000000Apps','0000000000000000NoSecret0000000000000000','https://filerun.com/images/nextcloud-square-logo.png','Nextcloud','Nextcloud GmbH','Authentication for the Nextcloud apps','https://nextcloud.com/install/#install-clients','https://nextcloud.com'),(3,1,'Generic0000000000000000000WebDAV','0000000000000000NoSecret0000000000000000','https://filerun.com/images/dav.png','WebDAV Protocol','','Authentication for the WebDAV apps','https://docs.filerun.com/webdav','http://www.webdav.org');
/*!40000 ALTER TABLE `df_oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `df_oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_refresh_tokens` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `access_token_id` mediumint NOT NULL,
  `expiry` int NOT NULL,
  `device_uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `refresh_token` (`refresh_token`),
  KEY `access_token_id` (`access_token_id`),
  CONSTRAINT `df_oauth_refresh_tokens_ibfk_1` FOREIGN KEY (`access_token_id`) REFERENCES `df_oauth_access_tokens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_refresh_tokens`
--

LOCK TABLES `df_oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `df_oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_scopes`
--

DROP TABLE IF EXISTS `df_oauth_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_scopes` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_scopes`
--

LOCK TABLES `df_oauth_scopes` WRITE;
/*!40000 ALTER TABLE `df_oauth_scopes` DISABLE KEYS */;
INSERT INTO `df_oauth_scopes` VALUES (1,'profile',''),(2,'download',''),(3,'upload',''),(4,'modify',''),(5,'delete',''),(6,'list',''),(7,'email',''),(8,'weblink',''),(9,'upload.sandbox',''),(10,'weblink.sandbox',''),(11,'delete.sandbox',''),(12,'admin',''),(13,'list.sandbox',''),(14,'download.sandbox',''),(15,'share',''),(16,'share.sandbox',''),(17,'metadata',''),(18,'webdav','');
/*!40000 ALTER TABLE `df_oauth_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_session_scopes`
--

DROP TABLE IF EXISTS `df_oauth_session_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_session_scopes` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `sid` mediumint NOT NULL,
  `scope` mediumint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`),
  KEY `scope` (`scope`),
  CONSTRAINT `df_oauth_session_scopes_ibfk_1` FOREIGN KEY (`scope`) REFERENCES `df_oauth_scopes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `df_oauth_session_scopes_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `df_oauth_sessions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_session_scopes`
--

LOCK TABLES `df_oauth_session_scopes` WRITE;
/*!40000 ALTER TABLE `df_oauth_session_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_session_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_sessions`
--

DROP TABLE IF EXISTS `df_oauth_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_oauth_sessions` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `owner_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cid` mediumint NOT NULL,
  `redirect_uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `date_created` datetime DEFAULT NULL,
  `client_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nc_login_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `df_oauth_sessions_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `df_oauth_clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_sessions`
--

LOCK TABLES `df_oauth_sessions` WRITE;
/*!40000 ALTER TABLE `df_oauth_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_oauth_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_paths`
--

DROP TABLE IF EXISTS `df_paths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_paths` (
  `id` int NOT NULL AUTO_INCREMENT,
  `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `depth` smallint NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `uniq` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq` (`uniq`),
  KEY `filename` (`filename`(248),`depth`),
  KEY `path` (`path`(250))
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_paths`
--

LOCK TABLES `df_paths` WRITE;
/*!40000 ALTER TABLE `df_paths` DISABLE KEYS */;
INSERT INTO `df_paths` VALUES (1,'/APPBOX_DATA','APPBOX_DATA',1,'2023-04-05 10:29:46','ed79e20d4f69ddd5d612d4bc252ec206'),(2,'/APPBOX_DATA/apps','apps',2,'2023-04-05 10:29:46','568fa1f1215a3bfea62355357d541d1c'),(3,'/APPBOX_DATA/storage','storage',2,'2023-04-05 10:29:46','6c6b448ab6bf4008ff58637107342244');
/*!40000 ALTER TABLE `df_paths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_relationships`
--

DROP TABLE IF EXISTS `df_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_relationships` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `related_to_id` mediumint NOT NULL DEFAULT '0',
  `object_id` mediumint NOT NULL DEFAULT '0',
  `relation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `id` (`id`),
  KEY `object_id` (`object_id`,`relation_type`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_relationships`
--

LOCK TABLES `df_relationships` WRITE;
/*!40000 ALTER TABLE `df_relationships` DISABLE KEYS */;
INSERT INTO `df_relationships` VALUES (1,2,3,'meta-fs2dt'),(2,4,4,'meta-fs2dt'),(3,3,5,'meta-fs2dt'),(4,4,5,'meta-fs2dt'),(5,1,6,'meta-fs2dt');
/*!40000 ALTER TABLE `df_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_settings`
--

DROP TABLE IF EXISTS `df_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_settings` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `var` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `var` (`var`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_settings`
--

LOCK TABLES `df_settings` WRITE;
/*!40000 ALTER TABLE `df_settings` DISABLE KEYS */;
INSERT INTO `df_settings` VALUES (1,'currentVersion','20220519'),(2,'app_title','FileRun'),(3,'smtp_enable','0'),(4,'smtp_host',''),(5,'smtp_port',''),(6,'smtp_username',''),(7,'smtp_password',''),(8,'smtp_auth','0'),(9,'smtp_security','ssl'),(10,'last_email_notification','4'),(11,'instant_email_notifications','1'),(12,'default_notification_address','configure-me@example.com'),(13,'user_registration_enable','0'),(14,'user_registration_generate_passwords','1'),(15,'user_registration_email_verification','0'),(16,'user_registration_approval','0'),(17,'user_registration_reqfields_email','1'),(18,'user_registration_reqfields_company','0'),(19,'user_registration_reqfields_website','0'),(20,'user_registration_reqfields_description','0'),(21,'user_registration_default_groups','a:0:{}'),(22,'user_registration_default_role',''),(23,'auth_plugin_default_role',''),(24,'user_registration_change_pass','1'),(25,'captcha','0'),(26,'allow_change_pass','1'),(27,'max_login_attempts','5'),(28,'allow_persistent_login','1'),(29,'logout_redirect',''),(30,'password_recovery_enable','1'),(31,'password_recovery_force_change','1'),(32,'search_enable','0'),(33,'search_elastic_host_url','http://localhost:9200'),(34,'search_default_mode','filename'),(35,'search_tika_path','/path/to/tika-app-1.22.jar'),(36,'search_tika_port','9998'),(37,'search_include_img','0'),(38,'search_tika_server_ocr_pdf','0'),(39,'thumbnails_vips','1'),(40,'thumbnails_vips_mode',''),(41,'thumbnails_vips_path','\"/usr/bin/vipsthumbnail\"'),(42,'thumbnails_vips_ext','exr, gif, hdr, heic, jpeg, jpg, pdf, png, svg, tif, tiff, webp'),(43,'thumbnails_imagemagick','1'),(44,'thumbnails_imagemagick_imagick','1'),(45,'thumbnails_imagemagick_path','\"/usr/bin/convert\"'),(46,'thumbnails_imagemagick_ext','3fr, ai, arw, cr2, cr3, crw, dcr, dng, eps, erf, exr, fff, gif, heic, iiq, jpe, jpeg, jpg, kdc, mdc, mef, mos, mrw, nef, nrw, orf, pdf, pef, plt, png, ppm, psb, psd, raf, raw, rw2, srw, svg, tif, tiff, tst, webp, x3f'),(47,'thumbnails_ffmpeg','1'),(48,'thumbnails_ffmpeg_path','\"/usr/bin/ffmpeg\"'),(49,'thumbnails_ffmpeg_ext','3g2, 3gp, asf, asx, avi, divx, flv, m2ts, m2v, m4v, mkv, mov, mp4, mpeg, mpg, mts, mxf, ogv, rm, swf, webm, wmv'),(50,'thumbnails_libreoffice','1'),(51,'thumbnails_libreoffice_path','\"/usr/bin/soffice\"'),(52,'thumbnails_libreoffice_ext','doc, docx, html, odp, ods, odt, pps, ppt, pptx, rtf, xls, xlsx'),(53,'thumbnails_filesize_limit_min','8'),(54,'thumbnails_small_filesize_check_res','1'),(55,'thumbnails_size','170'),(56,'thumbnails_stl_path','\"stl-thumb\"'),(57,'thumbnails_pngquant_path','\"/usr/bin/pngquant\"'),(58,'ui_file_page_size','300'),(59,'ui_preview_size','automatic'),(60,'ui_preview_filesize_limit_min','4'),(61,'ui_preview_small_filesize_check_res','1'),(62,'weblinks_default_mode','grid'),(63,'versioning_max','2'),(64,'quota_warning_level','90'),(65,'ui_default_language','english'),(66,'ui_display_language_menu','1'),(67,'ui_double_click','preview'),(68,'ui_login_logo',''),(69,'ui_login_text',''),(70,'ui_login_title',''),(71,'ui_title_logo','0'),(72,'ui_enable_favicons','1'),(73,'ui_logo_url','?page=logo&version=2021.12.07'),(74,'ui_default_view','thumbnails'),(75,'ui_enable_collections','1'),(76,'gravatar_enabled','1'),(77,'upload_blocked_types',''),(78,'allow_folder_notifications','0'),(79,'disable_file_history','0'),(80,'pushercom_app_id',''),(81,'pushercom_app_key',''),(82,'pushercom_app_secret',''),(83,'pushercom_enable','0'),(84,'file_history_entry_lifetime','7'),(85,'user_activity_logs_entry_lifetime','7'),(86,'maintenance','0'),(87,'maintenance_message_public','Our FileRun website is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),(88,'maintenance_message_users','This application is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),(89,'send_from_custom_email','0'),(90,'0','passwords_min_length'),(91,'1','4'),(92,'2','passwords_letters_and_digits'),(93,'3','0'),(94,'4','passwords_requires_uppercase'),(95,'5','0'),(96,'6','passwords_requires_special'),(97,'7','0'),(98,'8','passwords_prevent_seq'),(99,'9','0'),(100,'10','passwords_prevent_common'),(101,'11','0'),(102,'12','passwords_life_time'),(103,'13','365'),(104,'logout_inactivity','30'),(105,'auth_plugin',''),(106,'auth_allow_local','1'),(107,'notifications_template','Hi {$info.userInfo.name},<br>\n		<br>\n\n		{foreach from=$info.actions item=action}\n			{$action.message}\n		{/foreach}\n\n		<br>\n		Best regards,<br>\n		<br>\n		<a href=\"{$config.url.root}\">{$config.url.root}</a>\n'),(108,'notifications_subject_template','{$settings.app_title|safeHTML} notifications ({$info.actions[0].info.userInfo.name}: {$info.actions[0].info.actionDescription})'),(109,'ui_media_folders_music_enable','1'),(110,'ui_media_folders_photos_enable','1'),(111,'ui_media_folders_videos_enable','0'),(112,'guest_users','1'),(113,'guest_users_delete','1m'),(114,'ui_thumbs_in_detailed','1'),(115,'ui_enable_rating','1'),(116,'ui_photos_thumbnail_size','200'),(117,'ui_theme','purple'),(118,'ui_enable_download_cart','0'),(119,'search_result_limit','200'),(120,'search_mode','broad'),(121,'plugins_html_editor_use_purifier','1'),(122,'custom_action_html_editor_hide_create_new','0'),(123,'disable_custom_action_html_editor','1'),(124,'ui_hide_dotfiles','1'),(125,'thumbnails_ffmpeg_ss','1'),(126,'thumbnails_ratio','1.33'),(127,'ui_theme_dark_mode','never'),(128,'thumbnails_stl','1'),(129,'download_accelerator','xsendfile'),(130,'thumbnails_pngquant','1');
/*!40000 ALTER TABLE `df_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users`
--

DROP TABLE IF EXISTS `df_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_users` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_step_enabled` int NOT NULL DEFAULT '0',
  `two_step_secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_otp` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_pass_change` datetime DEFAULT NULL,
  `cookie` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` mediumint DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  `activated` smallint NOT NULL DEFAULT '0',
  `expiration_date` datetime DEFAULT NULL,
  `require_password_change` int NOT NULL DEFAULT '0',
  `failed_login_attempts` smallint NOT NULL DEFAULT '0',
  `last_access_date` timestamp NULL DEFAULT NULL,
  `last_notif_delivery_date` timestamp NULL DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `last_logout_date` datetime DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_notifications` smallint NOT NULL DEFAULT '0',
  `new_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `expiration_date` (`expiration_date`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users`
--

LOCK TABLES `df_users` WRITE;
/*!40000 ALTER TABLE `df_users` DISABLE KEYS */;
INSERT INTO `df_users` VALUES (1,'superuser','$2y$10$dDeH4fp87kPyZE.m8x2the9c9EfnaKPLF/C4KO/av52cw4u1gICoe',0,NULL,NULL,'2023-04-07 07:47:03',NULL,NULL,'2023-04-04 10:32:40',1,NULL,0,0,'2023-04-07 07:47:27','2023-04-04 10:32:50','2023-04-07 07:47:27',NULL,'',0,NULL,'Superuser','','','','','','','{\"type\":\"gravatar\",\"last_check\":1680604374}');
/*!40000 ALTER TABLE `df_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_permissions`
--

DROP TABLE IF EXISTS `df_users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_users_permissions` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `uid` mediumint NOT NULL,
  `role` mediumint DEFAULT NULL,
  `admin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_users` smallint NOT NULL DEFAULT '0',
  `admin_roles` smallint NOT NULL DEFAULT '0',
  `admin_notifications` smallint NOT NULL DEFAULT '0',
  `admin_logs` smallint NOT NULL DEFAULT '0',
  `admin_metadata` smallint NOT NULL DEFAULT '0',
  `admin_over` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `admin_max_users` smallint NOT NULL DEFAULT '0',
  `admin_homefolder_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homefolder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_quota_max` int DEFAULT NULL,
  `space_quota_current` int NOT NULL DEFAULT '0',
  `readonly` smallint DEFAULT NULL,
  `upload` smallint DEFAULT NULL,
  `upload_max_size` bigint DEFAULT NULL,
  `upload_limit_types` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `download` smallint DEFAULT NULL,
  `preview` smallint DEFAULT '1',
  `download_folders` smallint DEFAULT NULL,
  `read_comments` smallint DEFAULT NULL,
  `write_comments` smallint DEFAULT NULL,
  `email` smallint NOT NULL DEFAULT '0',
  `weblink` smallint NOT NULL DEFAULT '0',
  `share` smallint NOT NULL DEFAULT '0',
  `share_guests` smallint NOT NULL DEFAULT '0',
  `metadata` smallint NOT NULL DEFAULT '0',
  `file_history` smallint NOT NULL DEFAULT '0',
  `users_may_see` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `change_pass` smallint NOT NULL DEFAULT '1',
  `edit_profile` smallint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users_permissions`
--

LOCK TABLES `df_users_permissions` WRITE;
/*!40000 ALTER TABLE `df_users_permissions` DISABLE KEYS */;
INSERT INTO `df_users_permissions` VALUES (2,1,NULL,'',0,0,0,0,0,'-ALL-',0,'','/APPBOX_DATA',NULL,0,0,1,NULL,'',1,1,1,1,1,1,1,1,1,1,1,'-ALL-',1,1);
/*!40000 ALTER TABLE `df_users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_sessions`
--

DROP TABLE IF EXISTS `df_users_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_users_sessions` (
  `id` mediumint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `csrf_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users_sessions`
--

LOCK TABLES `df_users_sessions` WRITE;
/*!40000 ALTER TABLE `df_users_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_users_sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-07  7:56:17