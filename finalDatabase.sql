-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: final_project
-- ------------------------------------------------------
-- Server version	5.7.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `file` varchar(500) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `user` varchar(500) DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES ('SA1.jpg','18:08:51  2020-4-19','xiong','a'),('SA1.jpg','18:09:30  2020-4-19','xiong','aa'),('SA2.jpg','22:37:29  2020-4-19','xiong','a'),('Totoro1.jpg','01:45:41  2020-4-20','xiong','this is good picture'),('SA3.jpg','22:54:16  2020-4-20','xiong','aaaaaaaaaaaaaaaaaaa'),('dark-edge.jpg','17:04:26  2020-4-21','shawn','I like this'),('SA4.jpg','17:15:53  2020-4-21','shawn','Nice picture'),('To3.jpg','20:09:32  2020-4-22','xiong','Nice picture'),('SA3.jpg','11:04:11  2020-4-24','jixiong','good'),('hometown.jpg','11:05:29  2020-4-24','jixiong','Nice photo'),('brighton.jpg','11:05:40  2020-4-24','jixiong','like'),('To1.jpg','11:05:59  2020-4-24','jixiong','good');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `file` varchar(500) DEFAULT NULL,
  `date` varchar(500) NOT NULL,
  `user` varchar(500) DEFAULT NULL,
  `thumb` int(11) NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES ('SA3.jpg','11:02:28  2020-4-24','xiong',0),('SA1.jpg','11:02:33  2020-4-24','xiong',0),('SA2.jpg','11:02:57  2020-4-24','shawn',0),('To3.jpg','11:03:02  2020-4-24','shawn',0),('To2.jpg','11:03:08  2020-4-24','shawn',0),('To1.jpg','11:03:31  2020-4-24','jixiong',0),('brighton.jpg','11:03:42  2020-4-24','jixiong',0),('york.jpg','11:03:54  2020-4-24','jixiong',0),('hometown.jpg','11:04:01  2020-4-24','jixiong',0);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `thumb` int(11) NOT NULL,
  `user` varchar(500) DEFAULT NULL,
  `file` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (14,'xiong','SA1.jpg'),(3,'xiong','SA2.jpg'),(1,'xiong','SA4.jpg'),(2,'xiong','To3.jpg'),(3,'shawn','dark-edge.jpg'),(2,'shawn','brighton.jpg'),(0,'shawn','sea.jpg'),(1,'xiong','hometown.jpg'),(0,'xjx','got.jpg'),(1,'xiong','SA3.jpg'),(14,'xiong','SA1.jpg'),(3,'shawn','SA2.jpg'),(2,'shawn','To3.jpg'),(1,'shawn','To2.jpg'),(1,'jixiong','To1.jpg'),(2,'jixiong','brighton.jpg'),(1,'jixiong','york.jpg'),(1,'jixiong','hometown.jpg');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('jixiong','xiong','xiao','123',NULL),('petry','petry','xiao','123',NULL),('Shawn','jixiong','xiao','123456',NULL),('xiong','xiong','xiao','123',NULL),('xjx','xjx','xiao','123',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-24 11:08:09
