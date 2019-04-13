-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: localhost    Database: test_db
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `UsersRoles`
--

DROP TABLE IF EXISTS `UsersRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UsersRoles` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `usersroles_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usersroles_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsersRoles`
--

LOCK TABLES `UsersRoles` WRITE;
/*!40000 ALTER TABLE `UsersRoles` DISABLE KEYS */;
INSERT INTO `UsersRoles` VALUES ('2019-04-05 11:10:00','2019-04-05 11:10:00',1,1),('2019-04-05 12:10:30','2019-04-05 12:10:30',1,2),('2019-04-05 12:10:36','2019-04-05 12:10:36',1,3),('2019-04-05 14:14:59','2019-04-05 14:14:59',2,1);
/*!40000 ALTER TABLE `UsersRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `families`
--

DROP TABLE IF EXISTS `families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `families` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `families`
--

LOCK TABLES `families` WRITE;
/*!40000 ALTER TABLE `families` DISABLE KEYS */;
INSERT INTO `families` VALUES (1,1,'/uploads/families/image1.png','Family one','family.one@themail.com','2019-03-06 09:40:13','2019-03-06 09:40:13'),(2,2,'/uploads/families/image2.png','Family two','family.two@themail.com','2019-03-06 09:40:13','2019-03-06 09:40:13');
/*!40000 ALTER TABLE `families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `main` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `ProductId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `images_ibfk_1` (`ProductId`),
  CONSTRAINT `images_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (48071809908,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',30),(48071810766,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',30),(48071811314,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',30),(48072310894,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',27),(48072311449,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',27),(48072362663,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',28),(48072409322,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',29),(48072707210,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',32),(48072708428,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',32),(48072709909,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',32),(48258121497,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',34),(48258262148,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',33),(48258263103,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',33),(48258312836,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',31),(48258313728,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',31),(48258413523,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',11),(48258414439,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',11),(48398109282,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',29),(48398110356,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',29),(48398192565,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',28),(48398193241,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',28),(48398292329,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',26),(48398292897,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',26),(48398293891,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',26),(48431464599,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',24),(48431465778,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',24),(48431466744,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',24),(48431583783,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',19),(48431584211,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',19),(48431585464,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',19),(48431666421,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',18),(48431666951,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',18),(48431667551,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',18),(48431711792,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',13),(48431711949,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',13),(48431713286,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',13),(48433130957,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',20),(48433131404,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',20),(48433132737,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',20),(48433224560,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',21),(48433225164,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',21),(48433581680,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',14),(48433582434,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',14),(48433583574,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',14),(48433838285,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',15),(48433839504,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',15),(48433839741,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',15),(48433962476,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',25),(48433962686,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',25),(48433963960,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',25),(48434098215,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',22),(48434099201,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',22),(48434100614,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',22),(48434138723,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',23),(48434138825,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',23),(48434139591,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',23),(48434223918,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',16),(48434224844,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',16),(48434225365,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',16),(48434262494,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',17),(48434263509,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',17),(48434264434,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',17),(48434390655,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',12),(48434391131,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',12),(48434392984,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',12),(48434471327,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',9),(48434472467,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',9),(48434474169,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',9),(48434527897,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',10),(48434528457,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',10),(48434529211,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',10),(48504682186,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',5),(48504682572,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',5),(48504683662,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',5),(48504733989,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',6),(48504734469,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',6),(48504734985,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',6),(48517156810,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(48517157744,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(48517157922,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(48517205406,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(48517206142,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(48517206968,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(48517321400,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',7),(48517322432,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',7),(48517323987,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',7),(48517362293,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',8),(48517362357,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',8),(48517363317,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',8),(48517415367,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',3),(48517416681,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',3),(48517417707,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',3),(48517449794,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',4),(48517450267,'mainImage',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',4),(48517451441,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',4),(49103634646,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',27),(49104518273,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',34),(49104518411,'image3d',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',34),(52975673186,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',11),(52975699173,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',21),(52975731488,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',31),(52975745226,'image360',0,'2019-04-05 13:52:02','2019-04-05 13:52:02',33);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `type` smallint(5) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `FamilyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FamilyId` (`FamilyId`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`FamilyId`) REFERENCES `families` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'name1','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(2,'name2','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(3,'name3','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(4,'name4','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(5,'name5','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(6,'name6','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(7,'name7','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(8,'name8','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(9,'name9','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(10,'name10','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(11,'name11','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(12,'name12','Blue',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(13,'name13','Blue',2,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(14,'name14','Blue',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',1),(15,'name15','Blue',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(16,'name16','Blue',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(17,'name17','Blue',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(18,'name18','Blue',2,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(19,'name19','Blue',2,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(20,'name20','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(21,'name21','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(22,'name22','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(23,'name23','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(24,'name24','Red',2,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(25,'name25','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(26,'name26','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(27,'name27','Red',2,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(28,'name28','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(29,'name29','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(30,'name30','Red',3,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(31,'name31','Red',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(32,'name32','Red',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(33,'name33','Red',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',2),(34,'name34','Red',1,'2019-04-05 13:52:02','2019-04-05 13:52:02',2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'aunthenticated','2019-04-05 11:09:42','2019-04-05 11:09:42'),(2,'member','2019-04-05 12:10:12','2019-04-05 12:10:12'),(3,'admin','2019-04-05 12:10:21','2019-04-05 12:10:21');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jwebcoder@mymail.com','João Moura',NULL,'2019-04-05 11:10:00','2019-04-05 11:10:00'),(2,'joaogsleite@mymail.com','João Leite','$2a$10$kqh09pVk6oJoeo98h8qpAOZ962XSIfWkMxItlpxWxApUKkklMzfG6','2019-04-05 14:14:59','2019-04-05 14:16:14');
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

-- Dump completed on 2019-04-13 23:19:43
