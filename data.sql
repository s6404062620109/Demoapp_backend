-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.2.1-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for demo_project
CREATE DATABASE IF NOT EXISTS `demo_project` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `demo_project`;

-- Dumping structure for table demo_project.building
CREATE TABLE IF NOT EXISTS `building` (
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `building` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `floor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  PRIMARY KEY (`ip`),
  KEY `building` (`building`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.building: ~27 rows (approximately)
REPLACE INTO `building` (`ip`, `building`, `floor`, `number`) VALUES
	('01BGEL14A', 'O1B', 'G', 'EL1,4(A1)'),
	('01BGEL15A', 'O1B', 'G', 'EL1,5(A2)'),
	('H32ES3B', 'H3', '2', 'ES3(A3)'),
	('H32ES4B', 'H3', '2', 'ES4(A4)'),
	('H3GES1A', 'H3', 'G', 'ES1(A1)'),
	('H3GES2A', 'H3', 'G', 'ES2(A2)'),
	('H469EL11A', 'H4', '69', 'EL1(A1)'),
	('H469EL12A', 'H4', '69', 'EL1(A2)'),
	('O1B1EL31C', 'O1B', '1', 'EL3,1(A6)'),
	('O1B1EL32C', 'O1B', '1', 'EL3,2(A7)'),
	('O1B1EL33C', 'O1B', '1', 'EL3,3(A8)'),
	('O1BMEL21B', 'O1B', 'M', 'EL2,1(A3)'),
	('O1BMEL22B', 'O1B', 'M', 'EL2,2(A4)'),
	('O1BMEL23B', 'O1B', 'M', 'EL2,3(A5)'),
	('O2GEL11A', 'O2', 'G', 'EL1,1(A1)'),
	('O2GEL12A', 'O2', 'G', 'EL1,2(A2)'),
	('O2GEL13A', 'O2', 'G', 'EL1,3(A3)'),
	('O31ES1A', 'O3', '1', 'ES1(A1)'),
	('O31ES2A', 'O3', '1', 'ES2(A2)'),
	('O32ES3B', 'O3', '2', 'ES3(A3)'),
	('O32ES4B', 'O3', '2', 'ES4(A4)'),
	('O41EL211B', 'O4', '1', 'EL2.1-1(A3)'),
	('O41EL212B', 'O4', '1', 'EL2.1-2(A4)'),
	('O41EL221C', 'O4', '1', 'EL2.2-1(A5)'),
	('O41EL222C', 'O4', '1', 'EL2.2-2(A6)'),
	('O4GEL111A', 'O4', 'G', 'EL1.1-1(A1)'),
	('O4GEL112A', 'O4', 'G', 'EL1.1-2(A2)');

-- Dumping structure for table demo_project.encoder_input
CREATE TABLE IF NOT EXISTS `encoder_input` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `event` int(1) unsigned zerofill DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`no`),
  KEY `FK_encoder_input_building` (`ip`),
  CONSTRAINT `FK_encoder_input_building` FOREIGN KEY (`ip`) REFERENCES `building` (`ip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.encoder_input: ~53 rows (approximately)
REPLACE INTO `encoder_input` (`no`, `status`, `dir`, `event`, `ip`, `datetime`) VALUES
	(33, 'NORM', 'up', 0, 'H32ES3B', '2023-11-23 17:48:37'),
	(34, 'NORM', 'up', 0, 'H32ES4B', '2023-11-23 17:48:56'),
	(35, 'STOP', 'null', 0, 'H3GES1A', '2023-11-23 17:49:41'),
	(36, 'COMM', 'err', 0, 'H3GES2A', '2023-11-23 17:50:08'),
	(37, 'ERR', 'err', 1, '01BGEL14A', '2023-11-23 17:50:35'),
	(39, 'STOP', 'err', 0, '01BGEL14A', '2023-11-23 17:53:07'),
	(40, 'NORM', 'down', 0, '01BGEL14A', '2023-11-23 17:53:30'),
	(41, 'NORM', 'up', 0, '01BGEL15A', '2023-11-23 17:56:32'),
	(42, 'ERR', 'err', 1, 'H469EL11A', '2023-11-23 17:57:37'),
	(43, 'STOP', 'err', 1, 'H469EL12A', '2023-11-23 17:58:03'),
	(44, 'NORM', 'up', 0, 'O1B1EL31C', '2023-11-23 17:58:34'),
	(45, 'NORM', 'down', 0, 'O1B1EL32C', '2023-11-23 17:58:52'),
	(46, 'COMM', 'err', 0, 'O1B1EL33C', '2023-11-23 17:59:10'),
	(47, 'ERR', 'err', 1, 'O1BMEL21B', '2023-11-23 17:59:30'),
	(48, 'STOP', 'null', 0, 'O2GEL12A', '2023-11-23 18:02:28'),
	(49, 'NORM', 'down', 0, 'O2GEL11A', '2023-11-23 18:02:59'),
	(50, 'COMM', 'err', 0, 'O31ES2A', '2023-11-23 18:03:30'),
	(51, 'ERR', 'err', 1, 'O32ES3B', '2023-11-23 18:03:53'),
	(52, 'NORM', 'up', 0, 'O41EL212B', '2023-11-23 18:04:41'),
	(53, 'NORM', 'up', 0, 'O41EL222C', '2023-11-23 18:04:49'),
	(54, 'NORM', 'down', 0, 'O4GEL112A', '2023-11-23 18:05:20'),
	(55, 'NORM', 'down', 0, 'H3GES2A', '2023-11-24 01:36:12'),
	(56, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:04:44'),
	(57, 'NORM', 'up', 0, 'H3GES2A', '2023-11-24 02:04:44'),
	(58, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:06:51'),
	(59, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:06:59'),
	(60, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:07:07'),
	(61, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:07:15'),
	(62, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:07:23'),
	(63, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:07:31'),
	(64, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:07:39'),
	(65, 'STOP', 'null', 0, 'H3GES2A', '2023-11-24 02:07:47'),
	(66, 'NORM', 'down', 0, 'H3GES2A', '2023-11-24 02:12:32'),
	(67, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:24:35'),
	(68, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:24:43'),
	(69, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:24:51'),
	(70, 'STOP', 'null', 0, 'H3GES2A', '2023-11-24 02:24:59'),
	(71, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:15'),
	(72, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:23'),
	(73, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:31'),
	(74, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:39'),
	(75, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:47'),
	(76, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:36:55'),
	(77, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:37:03'),
	(78, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:37:11'),
	(79, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 02:38:04'),
	(80, 'STOP', 'null', 0, 'H3GES2A', '2023-11-24 02:38:26'),
	(81, 'STOP', 'err', 0, 'H3GES2A', '2023-11-24 14:54:10'),
	(82, 'NORM', 'up', 0, 'H3GES2A', '2023-11-24 14:55:13'),
	(83, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 14:56:05'),
	(84, 'STOP', 'down', 1, 'H3GES2A', '2023-11-24 15:03:31'),
	(85, 'COMM', 'err', 0, 'H3GES2A', '2023-11-24 15:03:48'),
	(86, 'COMM', 'err', 0, 'O1BMEL21B', '2023-11-24 18:43:24');

-- Dumping structure for table demo_project.history
CREATE TABLE IF NOT EXISTS `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `building` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `group` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_history_building` (`building`),
  KEY `FK_history_building_2` (`number`),
  CONSTRAINT `FK_history_building` FOREIGN KEY (`building`) REFERENCES `building` (`building`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_history_building_2` FOREIGN KEY (`number`) REFERENCES `building` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.history: ~6 rows (approximately)
REPLACE INTO `history` (`id`, `date`, `time`, `building`, `group`, `number`, `information`) VALUES
	(13, '2023-11-23', '17:50:35', 'O1B', 'A', 'EL1,4(A1)', 'Communication by 01BGEL14A'),
	(14, '2023-11-23', '17:57:37', 'H4', 'A', 'EL1(A1)', 'Communication by H469EL11A'),
	(15, '2023-11-23', '17:58:03', 'H4', 'A', 'EL1(A2)', 'Communication by H469EL12A'),
	(16, '2023-11-23', '17:59:30', 'O1B', 'B', 'EL2,1(A3)', 'Communication by O1BMEL21B'),
	(17, '2023-11-23', '18:03:53', 'O3', 'B', 'ES3(A3)', 'Communication by O32ES3B'),
	(18, '2023-11-24', '15:03:31', 'H3', 'A', 'ES2(A2)', 'Communication by H3GES2A');

-- Dumping structure for table demo_project.user
CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `role` varchar(255) DEFAULT '',
  `token` varchar(255) DEFAULT '',
  `iat` datetime DEFAULT NULL,
  `exp` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.user: ~8 rows (approximately)
REPLACE INTO `user` (`username`, `password`, `role`, `token`, `iat`, `exp`) VALUES
	('admin1@gmail.com', 'test1234', 'admin', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluMUBnbWFpbC5jb20iLCJpYXQiOjE3MDA4MjU2NjAsImV4cCI6MTcwMDgyOTI2MH0.LRAswhkGZXaJx6UtXJZ_fI8D8FT-WTZF3wrMDFzHi7g', '2023-11-24 18:34:20', '2023-11-24 19:34:20'),
	('hotel3@gmail.com', 'htof2468', 'hotel_3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhvdGVsM0BnbWFpbC5jb20iLCJpYXQiOjE3MDA4MjU4NjUsImV4cCI6MTcwMDgyOTQ2NX0.mI3p9qs8jvIvBhiCscn_Y90KwDiz4EsIT_FyG7qrO9Y', '2023-11-24 18:37:45', '2023-11-24 19:37:45'),
	('hotel4@gmail.com', 'htof1357', 'hotel_4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhvdGVsNEBnbWFpbC5jb20iLCJpYXQiOjE3MDA4MjU3MDksImV4cCI6MTcwMDgyOTMwOX0.ED3vGYjc5ono-nPG-2Xe-_AxrqI8AA8hXtRYvERWmL4', '2023-11-24 18:35:09', '2023-11-24 19:35:09'),
	('office1b@hotmail.com', 'of1b', 'office_1b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9mZmljZTFiQGhvdG1haWwuY29tIiwiaWF0IjoxNzAwODI2MTg5LCJleHAiOjE3MDA4Mjk3ODl9.L8B9JFcbHZd5yaTTJq1TPqHhspN7F2aFxMDHE1yUoBE', '2023-11-24 18:43:09', '2023-11-24 19:43:09'),
	('office2@hotmail.com', 'of2', 'office_2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9mZmljZTJAaG90bWFpbC5jb20iLCJpYXQiOjE3MDA4MjU3NzIsImV4cCI6MTcwMDgyOTM3Mn0.f-CoEJfJVkblUk01snIfAudtOkbetQTr72kJuT1gWt8', '2023-11-24 18:36:12', '2023-11-24 19:36:12'),
	('office3@hotmail.com', 'of3', 'office_3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9mZmljZTNAaG90bWFpbC5jb20iLCJpYXQiOjE3MDA4MjU3OTYsImV4cCI6MTcwMDgyOTM5Nn0.uFl8drJaG6izWHPv7RHReA7OvFh5ifMsB98fpx3Yz88', '2023-11-24 18:36:36', '2023-11-24 19:36:36'),
	('office4@hotmail.com', 'of4', 'office_4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9mZmljZTRAaG90bWFpbC5jb20iLCJpYXQiOjE3MDA4MjU4MjQsImV4cCI6MTcwMDgyOTQyNH0.W_IZGlCDMianetjJXtWyOqfrwdUlwVAj3hnrj4TCVa8', '2023-11-24 18:37:04', '2023-11-24 19:37:04'),
	('test123@gmail.com', 'zaza5555', 'admin', '', NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
