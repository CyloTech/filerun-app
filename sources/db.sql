-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: filerun
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

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
-- Table structure for table `df_file_handlers`
--

DROP TABLE IF EXISTS `df_file_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_file_handlers` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `handler` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_file_handlers`
--

LOCK TABLES `df_file_handlers` WRITE;
/*!40000 ALTER TABLE `df_file_handlers` DISABLE KEYS */;
INSERT INTO `df_file_handlers` VALUES (1,NULL,'txt',NULL,'code_editor'),(2,NULL,'img',NULL,'image_viewer'),(3,NULL,'wvideo',NULL,'video_player'),(4,NULL,'mp3',NULL,'audio_player'),(5,NULL,'office',NULL,'office_web_viewer'),(6,NULL,'ooffice',NULL,'office_web_viewer'),(7,NULL,'arch',NULL,'arch'),(8,NULL,NULL,'odt','webodf'),(9,NULL,NULL,'ods','webodf'),(10,NULL,NULL,'odp','webodf'),(11,NULL,NULL,'pdf','open_in_browser'),(12,NULL,NULL,'url','handle_url'),(13,NULL,NULL,'html','html_editor'),(14,NULL,NULL,'kml','kml_viewer'),(15,NULL,NULL,'kmz','kml_viewer'),(16,NULL,NULL,'gpx','bing_kml_viewer'),(17,NULL,NULL,'md','markdown_viewer'),(18,NULL,NULL,'epub','epub_reader'),(19,NULL,NULL,'gpx','bing_kml_viewer');
/*!40000 ALTER TABLE `df_file_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_file_logs`
--

DROP TABLE IF EXISTS `df_file_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_file_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `uid` mediumint(9) NOT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '2002-02-02 00:00:00',
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` mediumint(9) NOT NULL DEFAULT '0',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_logs`
--

LOCK TABLES `df_logs` WRITE;
/*!40000 ALTER TABLE `df_logs` DISABLE KEYS */;
INSERT INTO `df_logs` VALUES (1,'2018-11-26 14:54:07','login','a:1:{s:2:\"IP\";s:12:\"192.168.1.65\";}',1,''),(2,'2018-11-26 14:56:01','user_edited','a:3:{s:3:\"uid\";s:1:\"1\";s:9:\"user_info\";a:15:{s:8:\"username\";s:9:\"superuser\";s:8:\"password\";s:60:\"$2y$10$XSFq6/kratbx5lEZ7LSqcO3tSaoHjC88No/Z..Ssycordtt4AkuGe\";s:23:\"require_password_change\";i:0;s:16:\"two_step_enabled\";i:0;s:15:\"expiration_date\";s:4:\"NULL\";s:9:\"activated\";i:1;s:4:\"name\";s:9:\"Superuser\";s:5:\"name2\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:7:\"company\";s:0:\"\";s:5:\"email\";s:0:\"\";s:7:\"website\";s:0:\"\";s:8:\"logo_url\";s:0:\"\";s:11:\"description\";s:0:\"\";s:21:\"receive_notifications\";i:0;}s:11:\"permissions\";a:29:{s:10:\"admin_type\";s:0:\"\";s:4:\"role\";s:4:\"NULL\";s:10:\"admin_over\";s:5:\"-ALL-\";s:10:\"homefolder\";s:12:\"/APPBOX_DATA\";s:15:\"space_quota_max\";N;s:15:\"admin_max_users\";i:0;s:25:\"admin_homefolder_template\";s:0:\"\";s:11:\"admin_users\";i:0;s:11:\"admin_roles\";i:0;s:19:\"admin_notifications\";i:0;s:10:\"admin_logs\";i:0;s:14:\"admin_metadata\";i:0;s:8:\"readonly\";i:0;s:6:\"upload\";i:1;s:15:\"upload_max_size\";N;s:18:\"upload_limit_types\";s:0:\"\";s:8:\"download\";i:1;s:16:\"download_folders\";i:1;s:13:\"read_comments\";i:1;s:14:\"write_comments\";i:1;s:5:\"email\";i:1;s:7:\"weblink\";i:1;s:5:\"share\";i:1;s:12:\"share_guests\";i:1;s:8:\"metadata\";i:1;s:12:\"file_history\";i:1;s:11:\"change_pass\";i:1;s:12:\"edit_profile\";i:1;s:13:\"users_may_see\";s:5:\"-ALL-\";}}',1,''),(3,'2018-11-26 14:56:34','user_edited','a:3:{s:3:\"uid\";s:1:\"1\";s:9:\"user_info\";a:15:{s:8:\"username\";s:9:\"superuser\";s:8:\"password\";s:60:\"$2y$10$XSFq6/kratbx5lEZ7LSqcO3tSaoHjC88No/Z..Ssycordtt4AkuGe\";s:23:\"require_password_change\";i:0;s:16:\"two_step_enabled\";i:0;s:15:\"expiration_date\";s:4:\"NULL\";s:9:\"activated\";i:1;s:4:\"name\";s:9:\"Superuser\";s:5:\"name2\";s:0:\"\";s:5:\"phone\";s:0:\"\";s:7:\"company\";s:0:\"\";s:5:\"email\";s:0:\"\";s:7:\"website\";s:0:\"\";s:8:\"logo_url\";s:0:\"\";s:11:\"description\";s:0:\"\";s:21:\"receive_notifications\";i:0;}s:11:\"permissions\";a:29:{s:10:\"admin_type\";s:0:\"\";s:4:\"role\";s:4:\"NULL\";s:10:\"admin_over\";s:5:\"-ALL-\";s:10:\"homefolder\";s:12:\"/APPBOX_DATA\";s:15:\"space_quota_max\";N;s:15:\"admin_max_users\";i:0;s:25:\"admin_homefolder_template\";s:0:\"\";s:11:\"admin_users\";i:0;s:11:\"admin_roles\";i:0;s:19:\"admin_notifications\";i:0;s:10:\"admin_logs\";i:0;s:14:\"admin_metadata\";i:0;s:8:\"readonly\";i:0;s:6:\"upload\";i:1;s:15:\"upload_max_size\";N;s:18:\"upload_limit_types\";s:0:\"\";s:8:\"download\";i:1;s:16:\"download_folders\";i:1;s:13:\"read_comments\";i:1;s:14:\"write_comments\";i:1;s:5:\"email\";i:1;s:7:\"weblink\";i:1;s:5:\"share\";i:1;s:12:\"share_guests\";i:1;s:8:\"metadata\";i:1;s:12:\"file_history\";i:1;s:11:\"change_pass\";i:1;s:12:\"edit_profile\";i:1;s:13:\"users_may_see\";s:5:\"-ALL-\";}}',1,''),(4,'2018-11-26 14:56:56','logout','',1,''),(5,'2018-11-26 14:57:01','login','a:1:{s:2:\"IP\";s:12:\"192.168.1.65\";}',1,''),(6,'2018-11-26 14:57:05','download','a:4:{s:9:\"full_path\";s:30:\"/APPBOX_DATA/somethingelse.txt\";s:13:\"relative_path\";s:28:\"/ROOT/HOME/somethingelse.txt\";s:9:\"file_size\";s:1:\"0\";s:6:\"method\";s:11:\"Code Editor\";}',1,''),(7,'2018-11-26 14:58:26','download','a:4:{s:9:\"full_path\";s:30:\"/APPBOX_DATA/somethingelse.txt\";s:13:\"relative_path\";s:28:\"/ROOT/HOME/somethingelse.txt\";s:9:\"file_size\";s:1:\"0\";s:6:\"method\";s:11:\"Code Editor\";}',1,''),(8,'2018-11-26 15:07:31','password_changed','a:1:{s:4:\"data\";a:5:{s:8:\"password\";s:60:\"$2y$10$.esQ.rI9.u0V.WqzG0.d6OyB1A/GC8FPSuWTMq273tweENm45mmA.\";s:16:\"last_pass_change\";s:5:\"NOW()\";s:15:\"two_step_secret\";N;s:8:\"last_otp\";N;s:21:\"failed_login_attempts\";i:0;}}',1,''),(9,'2018-11-26 15:07:39','logout','',1,''),(10,'2018-11-26 15:07:45','login','a:1:{s:2:\"IP\";s:12:\"192.168.1.65\";}',1,'');
/*!40000 ALTER TABLE `df_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_folders_notifications`
--

DROP TABLE IF EXISTS `df_modules_folders_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_folders_notifications` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` int(9) NOT NULL,
  `pathid` int(10) NOT NULL,
  `shareid` int(8) DEFAULT NULL,
  `notify_write` int(1) NOT NULL DEFAULT '0',
  `notify_read` int(1) NOT NULL DEFAULT '0',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_metadata_dt` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ext` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_types` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `system` smallint(1) NOT NULL DEFAULT '0',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_metadata_fields` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `fsid` mediumint(9) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hide_fieldset_name_in_column` smallint(1) NOT NULL DEFAULT '0',
  `show_column_by_default` smallint(1) NOT NULL DEFAULT '0',
  `system` smallint(1) NOT NULL DEFAULT '0',
  `source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `system` (`system`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_metadata_fields`
--

LOCK TABLES `df_modules_metadata_fields` WRITE;
/*!40000 ALTER TABLE `df_modules_metadata_fields` DISABLE KEYS */;
INSERT INTO `df_modules_metadata_fields` VALUES (1,0,'comment','Comments (System)','','',0,0,1,NULL,NULL),(2,0,'filelog','File Logs (System)','','',0,0,1,NULL,NULL),(3,0,'label','Labels (System)','','',0,0,1,NULL,NULL),(4,0,'star','Stars (System)','','',0,0,1,NULL,NULL),(5,0,'filename','Search (System)','','',0,0,1,NULL,NULL),(6,0,'zoho_collab','Zoho Collaborative Editing (System)','','',0,0,1,NULL,NULL),(7,0,'Tags','','multiple','',0,0,1,'MWG->Keywords',NULL),(8,3,'Width','','small','',1,0,0,'MWG->width',1),(9,3,'Height','','small','',1,0,0,'MWG->height',2),(10,3,'Date taken','','date','',1,0,0,'MWG->DateCreated',3),(11,3,'Author','','multiple','',1,0,0,'MWG->Creator',4),(12,3,'Description','','large','',1,0,0,'MWG->Description',5),(13,3,'Copyright','','','',1,0,0,'MWG->Copyright',6),(14,3,'GPS latitude','','small','',1,0,0,'MWG->GPSlatitude',7),(15,3,'GPS longitude','','small','',1,0,0,'MWG->GPSlongitude',8),(16,4,'Movie title','','','',1,0,0,'info->quicktime->moov->subatoms->3->subatoms->0->subatoms->1->subatoms->0->data',1),(17,4,'Width','','small','',1,0,0,'info->video->resolution_x',2),(18,4,'Height','','small','',1,0,0,'info->video->resolution_y',3),(19,4,'Codec','','','',1,0,0,'info->video->dataformat',4),(20,5,'Artist','','','',1,0,0,'info->comments->artist',1),(21,5,'Title','','','',1,0,0,'info->comments->title',2),(22,5,'Album','','','',1,0,0,'info->comments->album',3),(23,5,'Duration','','small','',1,0,0,'info->playtime_string',4),(24,5,'Codec','','','',1,0,0,'info->audio->codec',5),(25,6,'Author','','','',1,0,0,NULL,1),(26,6,'Description','','','',1,0,0,NULL,2),(27,0,'Rating','','stars','',1,0,1,'Rating',NULL);
/*!40000 ALTER TABLE `df_modules_metadata_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_metadata_fieldsets`
--

DROP TABLE IF EXISTS `df_modules_metadata_fieldsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_metadata_fieldsets` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `generic` smallint(1) NOT NULL DEFAULT '0',
  `system` smallint(1) NOT NULL DEFAULT '0',
  `visible` smallint(1) NOT NULL DEFAULT '0',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_metadata_files` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `type_id` mediumint(9) DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_metadata_values` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date_added` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `uid` mediumint(9) NOT NULL,
  `share_id` mediumint(9) DEFAULT NULL,
  `file_id` mediumint(9) NOT NULL,
  `field_id` mediumint(9) NOT NULL,
  `val` text COLLATE utf8mb4_unicode_ci,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_notifications` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `owner` mediumint(9) DEFAULT NULL,
  `object_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `object_id` mediumint(9) NOT NULL DEFAULT '0',
  `action` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_search_index_queue` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_shares` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `created` datetime NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `with_gid` mediumint(9) DEFAULT NULL,
  `with_uid` mediumint(9) DEFAULT NULL,
  `anonymous` smallint(1) NOT NULL DEFAULT '0',
  `perms_upload` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_download` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_comment` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_read_comments` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_alter` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `perms_share` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_trash` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `relative_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_user_groups` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` mediumint(9) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_user_roles` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `system` smallint(1) NOT NULL DEFAULT '0',
  `owner` mediumint(9) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_users` smallint(1) NOT NULL DEFAULT '0',
  `admin_roles` smallint(1) NOT NULL DEFAULT '0',
  `admin_notifications` smallint(1) NOT NULL DEFAULT '0',
  `admin_logs` smallint(1) NOT NULL DEFAULT '0',
  `admin_metadata` smallint(1) NOT NULL DEFAULT '0',
  `admin_over` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_max_users` smallint(7) NOT NULL DEFAULT '0',
  `admin_homefolder_template` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `homefolder` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_folder` smallint(1) NOT NULL DEFAULT '1',
  `space_quota_max` int(20) DEFAULT NULL,
  `space_quota_current` int(20) NOT NULL DEFAULT '0',
  `readonly` smallint(1) DEFAULT NULL,
  `upload` smallint(1) DEFAULT NULL,
  `upload_max_size` bigint(20) DEFAULT NULL,
  `upload_limit_types` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `download` smallint(1) DEFAULT NULL,
  `download_folders` smallint(1) DEFAULT NULL,
  `read_comments` smallint(1) DEFAULT NULL,
  `write_comments` smallint(1) DEFAULT NULL,
  `email` smallint(1) NOT NULL DEFAULT '0',
  `weblink` smallint(1) NOT NULL DEFAULT '0',
  `share` smallint(1) NOT NULL DEFAULT '0',
  `share_guests` smallint(1) NOT NULL DEFAULT '0',
  `metadata` smallint(1) NOT NULL DEFAULT '0',
  `file_history` smallint(1) NOT NULL DEFAULT '0',
  `users_may_see` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '-ALL-',
  `change_pass` smallint(1) NOT NULL DEFAULT '1',
  `edit_profile` smallint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_modules_user_roles`
--

LOCK TABLES `df_modules_user_roles` WRITE;
/*!40000 ALTER TABLE `df_modules_user_roles` DISABLE KEYS */;
INSERT INTO `df_modules_user_roles` VALUES (1,1,NULL,'Guest','Automatically deleted when there are no files shared with.','',0,0,0,0,0,'',0,'','',0,NULL,0,1,0,NULL,NULL,1,0,0,0,0,0,0,0,0,0,'-ALL-',0,0);
/*!40000 ALTER TABLE `df_modules_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_modules_weblinks`
--

DROP TABLE IF EXISTS `df_modules_weblinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_modules_weblinks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_rnd` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `uid` mediumint(9) NOT NULL,
  `pathid` int(10) NOT NULL,
  `share_id` mediumint(9) DEFAULT NULL,
  `short_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `expiry` datetime DEFAULT NULL,
  `download_limit` mediumint(6) DEFAULT NULL,
  `allow_uploads` int(1) NOT NULL DEFAULT '0',
  `allow_downloads` int(1) NOT NULL DEFAULT '1',
  `force_save` tinyint(1) DEFAULT '0',
  `system` smallint(1) NOT NULL DEFAULT '0',
  `notify` mediumint(1) NOT NULL DEFAULT '0',
  `download_terms` text COLLATE utf8mb4_unicode_ci,
  `show_comments` tinyint(1) NOT NULL DEFAULT '0',
  `show_comments_names` tinyint(1) NOT NULL DEFAULT '0',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_notifications_logs` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `has_errors` smallint(1) NOT NULL DEFAULT '0',
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_access_token_scopes` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `access_token_id` mediumint(8) NOT NULL,
  `scope` mediumint(8) NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_access_tokens` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `access_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sid` mediumint(8) NOT NULL,
  `expiry` int(11) NOT NULL,
  `device_uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_auth_code_scopes` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `auth_code_id` mediumint(9) NOT NULL,
  `scope` mediumint(8) NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_auth_codes` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `auth_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sid` mediumint(8) NOT NULL,
  `redirect_uri` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiry` int(11) DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_client_redirect_uris` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `cid` mediumint(8) NOT NULL,
  `uri` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `df_oauth_client_redirect_uris_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `df_oauth_clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_client_redirect_uris`
--

LOCK TABLES `df_oauth_client_redirect_uris` WRITE;
/*!40000 ALTER TABLE `df_oauth_client_redirect_uris` DISABLE KEYS */;
INSERT INTO `df_oauth_client_redirect_uris` VALUES (1,1,'filerun://');
/*!40000 ALTER TABLE `df_oauth_client_redirect_uris` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_clients`
--

DROP TABLE IF EXISTS `df_oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_clients` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `enabled` smallint(1) NOT NULL DEFAULT '0',
  `cid` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` text COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publisher` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` text COLLATE utf8mb4_unicode_ci,
  `publisher_website` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_clients`
--

LOCK TABLES `df_oauth_clients` WRITE;
/*!40000 ALTER TABLE `df_oauth_clients` DISABLE KEYS */;
INSERT INTO `df_oauth_clients` VALUES (1,1,'FileRun0000000000000000000Mobile','0000000000000000NoSecret0000000000000000','https://www.filerun.com/images/logo-mobile-app.png','FileRun Mobile','Afian AB','Authentication for the mobile apps','http://www.filerun.com','http://www.afian.se');
/*!40000 ALTER TABLE `df_oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `df_oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_refresh_tokens` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` mediumint(9) NOT NULL,
  `expiry` int(11) NOT NULL,
  `device_uuid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_scopes` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_oauth_scopes`
--

LOCK TABLES `df_oauth_scopes` WRITE;
/*!40000 ALTER TABLE `df_oauth_scopes` DISABLE KEYS */;
INSERT INTO `df_oauth_scopes` VALUES (1,'profile',''),(2,'download',''),(3,'upload',''),(4,'modify',''),(5,'delete',''),(6,'list',''),(7,'email',''),(8,'weblink',''),(9,'upload.sandbox',''),(10,'weblink.sandbox',''),(11,'delete.sandbox',''),(12,'admin',''),(13,'list.sandbox',''),(14,'download.sandbox',''),(15,'share',''),(16,'share.sandbox',''),(17,'metadata','');
/*!40000 ALTER TABLE `df_oauth_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_oauth_session_scopes`
--

DROP TABLE IF EXISTS `df_oauth_session_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_session_scopes` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `sid` mediumint(9) NOT NULL,
  `scope` mediumint(9) NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_oauth_sessions` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `owner_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cid` mediumint(8) NOT NULL,
  `redirect_uri` text COLLATE utf8mb4_unicode_ci,
  `date_created` datetime DEFAULT NULL,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_paths` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `path` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `depth` smallint(3) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `uniq` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq` (`uniq`),
  KEY `filename` (`filename`(248),`depth`),
  KEY `path` (`path`(250))
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_paths`
--

LOCK TABLES `df_paths` WRITE;
/*!40000 ALTER TABLE `df_paths` DISABLE KEYS */;
INSERT INTO `df_paths` VALUES (1,'/APPBOX_DATA/somethingelse.txt','somethingelse.txt',2,'2018-11-26 14:57:02','09d569e1855315a7b5cc51e419373b89'),(2,'/APPBOX_DATA/something','something',2,'2018-11-26 14:57:02','d1c5b8a3f771009727368292400c7cd0');
/*!40000 ALTER TABLE `df_paths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_relationships`
--

DROP TABLE IF EXISTS `df_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_relationships` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `related_to_id` mediumint(9) NOT NULL DEFAULT '0',
  `object_id` mediumint(9) NOT NULL DEFAULT '0',
  `relation_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_settings` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `var` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `val` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `var` (`var`)
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_settings`
--

LOCK TABLES `df_settings` WRITE;
/*!40000 ALTER TABLE `df_settings` DISABLE KEYS */;
INSERT INTO `df_settings` VALUES (1,'currentVersion','2018.11.11'),(2,'app_title','FileRun'),(3,'smtp_enable','0'),(4,'smtp_host',''),(5,'smtp_port',''),(6,'smtp_username',''),(7,'smtp_password',''),(8,'smtp_auth','0'),(9,'smtp_security','ssl'),(10,'last_email_notification','10'),(11,'instant_email_notifications','1'),(12,'default_notification_address','configure-me@example.com'),(13,'user_registration_enable','0'),(14,'user_registration_generate_passwords','1'),(15,'user_registration_email_verification','0'),(16,'user_registration_approval','0'),(17,'user_registration_reqfields_email','1'),(18,'user_registration_reqfields_company','0'),(19,'user_registration_reqfields_website','0'),(20,'user_registration_reqfields_description','0'),(21,'user_registration_default_groups','a:0:{}'),(22,'user_registration_default_role',''),(23,'user_registration_change_pass','1'),(24,'captcha','0'),(25,'allow_change_pass','1'),(26,'max_login_attempts','5'),(27,'allow_persistent_login','1'),(28,'logout_redirect',''),(29,'password_recovery_enable','1'),(30,'password_recovery_force_change','1'),(31,'search_enable','0'),(32,'search_elastic_host_url','http://localhost:9200'),(33,'search_default_mode','filename'),(34,'search_tika_path','/path/to/tika-app-1.12.jar'),(35,'thumbnails_enable','1'),(36,'thumbnails_imagemagick','1'),(37,'thumbnails_imagemagick_path','/usr/bin/convert'),(38,'thumbnails_size','140'),(39,'thumbnails_imagemagick_ext','psd,psb,eps,tst,plt,ai,pdf,jpg,jpeg,gif,png,jpe,erf,dng,cr2,crw,3fr,fff,ppm,raw,kdc,dcr,nef,mef,mos,nrw,orf,raf,mrw,mdc,rw2,pef,x3f,srw,arw,iiq,svg'),(40,'thumbnails_ffmpeg','1'),(41,'thumbnails_ffmpeg_path','/usr/bin/ffmpeg'),(42,'thumbnails_ffmpeg_ext','mpg,mpeg,mp4,mov,avi,divx,mkv,wmv,rm,flv,asx,asf,swf,3gp,3g2,m4v,m2ts,mts,m2v,ogv,webm'),(43,'versioning_max','2'),(44,'quota_warning_level','90'),(45,'ui_default_language','english'),(46,'ui_display_language_menu','1'),(47,'ui_double_click','preview'),(48,'ui_login_logo',''),(49,'ui_login_text',''),(50,'ui_login_title',''),(51,'ui_title_logo','1'),(52,'ui_logo_url',NULL),(53,'ui_default_view','thumbnails'),(54,'gravatar_enabled','1'),(55,'upload_blocked_types',''),(56,'allow_folder_notifications','0'),(57,'disable_file_history','0'),(58,'pushercom_app_id',''),(59,'pushercom_app_key',''),(60,'pushercom_app_secret',''),(61,'pushercom_enable','0'),(62,'file_history_entry_lifetime','7'),(63,'user_activity_logs_entry_lifetime','7'),(64,'maintenance','0'),(65,'maintenance_message_public','Our FileRun website is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),(66,'maintenance_message_users','This application is currently undergoing scheduled maintenance. Will be back online shortly.\nThank you for your patience!'),(67,'send_from_custom_email','0'),(68,'passwords_min_length','4'),(69,'passwords_letters_and_digits','0'),(70,'passwords_requires_uppercase','0'),(71,'passwords_requires_special','0'),(72,'passwords_prevent_seq','0'),(73,'passwords_prevent_common','0'),(74,'passwords_life_time','365'),(75,'logout_inactivity','30'),(76,'auth_plugin',''),(77,'auth_allow_local','1'),(78,'notifications_template','<div style=\"font-family:tahoma,arial,verdana,sans-serif;font-size:13px;\">\n		Hi {$info.userInfo.name},<br>\n		<br>\n\n		{foreach from=$info.actions item=action}\n			{$action.message}\n		{/foreach}\n\n		<br>\n		Best regards,<br>\n		<br>\n		<a href=\"{$config.url.root}\">{$config.url.root}</a>\n</div>'),(79,'notifications_subject_template','{$settings.app_title|safeHTML} notifications ({$info.actions[0].info.userInfo.name}: {$info.actions[0].info.actionDescription})'),(80,'ui_media_folders_music_enable','1'),(81,'ui_media_folders_photos_enable','1'),(82,'guest_users','1'),(83,'guest_users_delete','1m'),(84,'ui_thumbs_in_detailed','1'),(85,'ui_enable_rating','1'),(86,'ui_photos_thumbnail_size','200'),(87,'ui_theme','custom'),(88,'search_result_limit','200'),(89,'search_mode','broad'),(90,'thumbnails_pngquant_path','/usr/bin/pngquant'),(91,'thumbnails_pngquant','1'),(92,'oauth2','1');
/*!40000 ALTER TABLE `df_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users`
--

DROP TABLE IF EXISTS `df_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_step_enabled` int(1) NOT NULL DEFAULT '0',
  `two_step_secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_otp` varchar(35) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_pass_change` datetime DEFAULT NULL,
  `cookie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` mediumint(9) DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  `activated` smallint(1) NOT NULL DEFAULT '0',
  `expiration_date` datetime DEFAULT NULL,
  `require_password_change` int(1) NOT NULL DEFAULT '0',
  `failed_login_attempts` smallint(1) NOT NULL DEFAULT '0',
  `last_access_date` timestamp NULL DEFAULT NULL,
  `last_notif_delivery_date` timestamp NULL DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `last_logout_date` datetime DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receive_notifications` smallint(1) NOT NULL DEFAULT '0',
  `new_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `df_users` VALUES (1,'superuser','$2y$10$.esQ.rI9.u0V.WqzG0.d6OyB1A/GC8FPSuWTMq273tweENm45mmA.',0,NULL,NULL,'2018-11-26 15:07:31',NULL,NULL,'2018-11-26 14:42:50',1,NULL,0,0,'2018-11-26 15:07:45','2018-11-26 14:54:07','2018-11-26 15:07:45','2018-11-26 15:07:39','',0,NULL,'Superuser','','','','','','','{\"type\":\"generated\",\"color\":[89,69,209],\"text\":\"Su\",\"lastUpdate\":1543244049}');
/*!40000 ALTER TABLE `df_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_permissions`
--

DROP TABLE IF EXISTS `df_users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users_permissions` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(9) NOT NULL,
  `role` mediumint(9) DEFAULT NULL,
  `admin_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_users` smallint(1) NOT NULL DEFAULT '0',
  `admin_roles` smallint(1) NOT NULL DEFAULT '0',
  `admin_notifications` smallint(1) NOT NULL DEFAULT '0',
  `admin_logs` smallint(1) NOT NULL DEFAULT '0',
  `admin_metadata` smallint(1) NOT NULL DEFAULT '0',
  `admin_over` text COLLATE utf8mb4_unicode_ci,
  `admin_max_users` smallint(7) NOT NULL DEFAULT '0',
  `admin_homefolder_template` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homefolder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_quota_max` int(20) DEFAULT NULL,
  `space_quota_current` int(20) NOT NULL DEFAULT '0',
  `readonly` smallint(1) DEFAULT NULL,
  `upload` smallint(1) DEFAULT NULL,
  `upload_max_size` bigint(20) DEFAULT NULL,
  `upload_limit_types` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `download` smallint(1) DEFAULT NULL,
  `download_folders` smallint(1) DEFAULT NULL,
  `read_comments` smallint(1) DEFAULT NULL,
  `write_comments` smallint(1) DEFAULT NULL,
  `email` smallint(1) NOT NULL DEFAULT '0',
  `weblink` smallint(1) NOT NULL DEFAULT '0',
  `share` smallint(1) NOT NULL DEFAULT '0',
  `share_guests` smallint(1) NOT NULL DEFAULT '0',
  `metadata` smallint(1) NOT NULL DEFAULT '0',
  `file_history` smallint(1) NOT NULL DEFAULT '0',
  `users_may_see` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-ALL-',
  `change_pass` smallint(1) NOT NULL DEFAULT '1',
  `edit_profile` smallint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_users_permissions`
--

LOCK TABLES `df_users_permissions` WRITE;
/*!40000 ALTER TABLE `df_users_permissions` DISABLE KEYS */;
INSERT INTO `df_users_permissions` VALUES (1,1,NULL,'',0,0,0,0,0,'-ALL-',0,'','/APPBOX_DATA',NULL,0,0,1,NULL,'',1,1,1,1,1,1,1,1,1,1,'-ALL-',1,1);
/*!40000 ALTER TABLE `df_users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_users_sessions`
--

DROP TABLE IF EXISTS `df_users_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `df_users_sessions` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `csrf_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

-- Dump completed on 2018-11-26 15:19:13
