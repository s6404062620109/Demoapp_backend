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

-- Dumping data for table demo_project.building: ~26 rows (approximately)
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
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.encoder_input: ~128 rows (approximately)
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
	(86, 'NORM', 'up', 0, 'O1BMEL21B', '2023-11-25 18:43:24'),
	(87, 'STOP', 'err', 0, 'O1BMEL21B', '2023-11-25 20:46:22'),
	(88, 'NORM', 'up', 0, 'O1BMEL21B', '2023-11-25 20:47:12'),
	(89, 'COMM', 'err', 0, 'H469EL12A', '2023-11-25 20:56:23'),
	(90, 'STOP', 'down', 0, 'O1BMEL21B', '2023-11-26 13:05:51'),
	(91, 'COMM', 'down', 0, 'O1BMEL21B', '2023-11-26 14:02:43'),
	(92, 'STOP', 'up', 0, 'O2GEL11A', '2023-11-26 14:04:26'),
	(93, 'COMM', 'up', 0, 'O2GEL11A', '2023-11-26 14:04:34'),
	(94, 'NORM', 'up', 0, 'O2GEL11A', '2023-11-26 14:08:46'),
	(95, 'COMM', 'up', 0, 'O2GEL11A', '2023-11-26 14:08:54'),
	(96, 'NORM', 'down', 1, 'O2GEL11A', '2023-11-26 21:30:06'),
	(97, 'NORM', 'down', 1, 'O2GEL11A', '2023-11-26 21:30:58'),
	(98, 'COMM', 'down', 0, 'O2GEL11A', '2023-11-26 21:36:12'),
	(99, 'NORM', 'up', 0, 'O2GEL11A', '2023-11-26 21:38:47'),
	(100, 'COMM', 'up', 0, 'O2GEL11A', '2023-11-26 21:38:55'),
	(101, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-26 22:34:23'),
	(102, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-26 22:36:03'),
	(103, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-26 22:36:20'),
	(104, 'NORM', 'down', 0, 'O4GEL112A', '2023-11-26 22:39:10'),
	(105, 'NORM', 'down', 0, 'O4GEL112A', '2023-11-26 22:42:27'),
	(106, 'NORM', 'down', 0, 'O4GEL112A', '2023-11-26 22:43:12'),
	(107, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 07:36:59'),
	(108, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 07:37:53'),
	(109, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 08:02:12'),
	(110, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:26:05'),
	(111, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:26:42'),
	(112, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:26:54'),
	(113, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:26:55'),
	(114, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:27:00'),
	(115, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:27:14'),
	(116, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:27:14'),
	(117, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:27:23'),
	(118, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 08:27:29'),
	(119, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:31:39'),
	(120, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:31:40'),
	(121, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:31:50'),
	(122, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:31:55'),
	(123, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:32:02'),
	(124, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 08:32:09'),
	(125, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 08:34:28'),
	(126, 'COMM', 'down', 0, 'O4GEL112A', '2023-11-27 08:46:48'),
	(127, 'COMM', 'down', 0, 'O4GEL112A', '2023-11-27 08:47:04'),
	(128, 'NORM', 'up', 0, 'O4GEL112A', '2023-11-27 10:47:46'),
	(129, 'STOP', 'down', 0, 'O4GEL112A', '2023-11-27 10:48:57'),
	(130, 'STOP', 'up', 0, 'O4GEL112A', '2023-11-27 10:49:41'),
	(131, 'COMM', 'up', 0, 'O4GEL112A', '2023-11-27 10:49:56'),
	(132, 'NORM', 'up', 0, 'O41EL221C', '2023-11-27 10:52:26'),
	(133, 'COMM', 'up', 0, 'O41EL221C', '2023-11-27 10:52:36'),
	(134, 'COMM', 'up', 0, 'O41EL221C', '2023-11-27 10:52:47'),
	(135, 'COMM', 'up', 0, 'O41EL221C', '2023-11-27 10:53:02'),
	(136, 'NORM', 'down', 0, 'O41EL221C', '2023-11-27 10:54:42'),
	(137, 'COMM', 'down', 0, 'O41EL221C', '2023-11-27 10:54:56'),
	(138, 'STOP', 'down', 1, 'O41EL221C', '2023-11-27 10:56:27'),
	(139, 'NORM', 'down', 0, 'O41EL221C', '2023-11-27 10:59:00'),
	(140, 'COMM', 'down', 0, 'O41EL221C', '2023-11-27 10:59:11'),
	(141, 'STOP', 'down', 1, 'O41EL221C', '2023-11-27 11:00:50'),
	(142, 'COMM', 'down', 0, 'O41EL221C', '2023-11-27 11:00:09'),
	(143, 'COMM', 'down', 0, 'O41EL221C', '2023-11-27 11:01:05'),
	(144, 'STOP', 'down', 1, 'O41EL221C', '2023-11-28 01:42:10'),
	(145, 'STOP', 'down', 1, 'O41EL221C', '2023-11-28 01:42:10'),
	(146, 'STOP', 'down', 1, 'O41EL221C', '2023-11-28 01:42:11'),
	(147, 'STOP', 'down', 1, 'O41EL221C', '2023-11-28 01:42:11'),
	(148, 'STOP', 'down', 1, 'O41EL221C', '2023-11-28 01:42:12'),
	(149, 'NORM', 'down', 1, 'H3GES2A', '2023-11-28 02:21:13'),
	(150, 'NORM', 'up', 1, 'H3GES2A', '2023-11-28 02:21:23'),
	(151, 'NORM', 'up', 1, 'H3GES2A', '2023-11-28 02:21:24'),
	(152, 'NORM', 'up', 1, 'H32ES4B', '2023-11-28 02:27:00'),
	(153, 'NORM', 'up', 1, 'H32ES4B', '2023-11-28 02:27:01'),
	(154, 'NORM', 'up', 1, 'H3GES1A', '2023-11-28 02:27:06'),
	(155, 'COMM', 'up', 1, 'O1BMEL22B', '2023-11-29 01:06:09'),
	(156, 'ERR', 'up', 1, 'O1BMEL22B', '2023-11-29 01:06:24'),
	(157, 'ERR', 'up', 1, 'O1BMEL22B', '2023-11-29 01:06:43'),
	(158, 'ERR', 'up', 1, 'O1B1EL33C', '2023-11-29 01:07:00'),
	(159, 'ERR', 'up', 1, 'O1B1EL33C', '2023-11-29 01:07:02'),
	(160, 'COMM', 'up', 1, 'O1B1EL31C', '2023-11-29 01:07:26'),
	(161, 'COMM', 'up', 1, 'O1B1EL31C', '2023-11-29 01:07:26');

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.history: ~28 rows (approximately)
REPLACE INTO `history` (`id`, `date`, `time`, `building`, `group`, `number`, `information`) VALUES
	(13, '2023-11-23', '17:50:35', 'O1B', 'A', 'EL1,4(A1)', 'Communication by 01BGEL14A'),
	(14, '2023-11-23', '17:57:37', 'H4', 'A', 'EL1(A1)', 'Communication by H469EL11A'),
	(15, '2023-11-23', '17:58:03', 'H4', 'A', 'EL1(A2)', 'Communication by H469EL12A'),
	(16, '2023-11-23', '17:59:30', 'O1B', 'B', 'EL2,1(A3)', 'Communication by O1BMEL21B'),
	(17, '2023-11-23', '18:03:53', 'O3', 'B', 'ES3(A3)', 'Communication by O32ES3B'),
	(18, '2023-11-24', '15:03:31', 'H3', 'A', 'ES2(A2)', 'Communication by H3GES2A'),
	(19, '2023-11-26', '21:30:06', 'O2', 'A', 'EL1,1(A1)', 'Communication by O2GEL11A'),
	(20, '2023-11-26', '21:30:58', 'O2', 'A', 'EL1,1(A1)', 'Communication by O2GEL11A'),
	(21, '2023-11-27', '10:56:27', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(22, '2023-11-27', '10:59:59', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(23, '2023-11-28', '01:42:10', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(24, '2023-11-28', '01:42:10', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(25, '2023-11-28', '01:42:11', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(26, '2023-11-28', '01:42:11', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(27, '2023-11-28', '01:42:12', 'O4', 'C', 'EL2.2-1(A5)', 'Communication by O41EL221C'),
	(28, '2023-11-28', '02:21:13', 'H3', 'A', 'ES2(A2)', 'Communication by H3GES2A'),
	(29, '2023-11-28', '02:21:23', 'H3', 'A', 'ES2(A2)', 'Communication by H3GES2A'),
	(30, '2023-11-28', '02:21:24', 'H3', 'A', 'ES2(A2)', 'Communication by H3GES2A'),
	(31, '2023-11-28', '02:27:00', 'H3', 'B', 'ES4(A4)', 'Communication by H32ES4B'),
	(32, '2023-11-28', '02:27:01', 'H3', 'B', 'ES4(A4)', 'Communication by H32ES4B'),
	(33, '2023-11-28', '02:27:06', 'H3', 'A', 'ES1(A1)', 'Communication by H3GES1A'),
	(34, '2023-11-29', '01:06:09', 'O1B', 'B', 'EL2,2(A4)', 'COMM'),
	(35, '2023-11-29', '01:06:24', 'O1B', 'B', 'EL2,2(A4)', 'ERR'),
	(36, '2023-11-29', '01:06:43', 'O1B', 'B', 'EL2,2(A4)', 'ERR'),
	(37, '2023-11-29', '01:07:00', 'O1B', 'C', 'EL3,3(A8)', 'ERR'),
	(38, '2023-11-29', '01:07:02', 'O1B', 'C', 'EL3,3(A8)', 'ERR'),
	(39, '2023-11-29', '01:07:26', 'O1B', 'C', 'EL3,1(A6)', 'COMM'),
	(40, '2023-11-29', '01:07:26', 'O1B', 'C', 'EL3,1(A6)', 'COMM');

-- Dumping structure for table demo_project.user
CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `role` varchar(255) DEFAULT '',
  `token` varchar(255) DEFAULT '',
  `iat` datetime DEFAULT NULL,
  `exp` datetime DEFAULT NULL,
  `time_confirm` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.user: ~5 rows (approximately)
REPLACE INTO `user` (`username`, `password`, `role`, `token`, `iat`, `exp`, `time_confirm`) VALUES
	('admin1@gmail.com', 'test1234', 'admin', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluMUBnbWFpbC5jb20iLCJpYXQiOjE3MDExMTA3NzMsImV4cCI6MTcwMTExNDM3M30.su7SeQRr3-40Xb8nQ5HRLC3IKDL8VbZ_Re98atnyWEA', '2023-11-28 01:46:13', '2023-11-28 02:46:13', NULL),
	('hotel3@gmail.com', 'htof2468', 'hotel_3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhvdGVsM0BnbWFpbC5jb20iLCJpYXQiOjE3MDExOTM0NjQsImV4cCI6MTcwMTE5NzA2NH0.6nZ_M9Bo_xpC2e6hspvisroZiEcCWpMbuGw4AsIXUrk', '2023-11-29 00:44:24', '2023-11-29 01:44:24', '2023-11-29 00:05:00'),
	('hotel4@gmail.com', 'htof1357', 'hotel_4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImhvdGVsNEBnbWFpbC5jb20iLCJpYXQiOjE3MDExOTM0NTMsImV4cCI6MTcwMTE5NzA1M30.gK_WCPP0keZ5p9vYF-Os1iocKDOMXFIsZEAjbUeCFmE', '2023-11-29 00:44:13', '2023-11-29 01:44:13', NULL),
	('office5678@hotmail.com', 'of1b234', 'office', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im9mZmljZTU2NzhAaG90bWFpbC5jb20iLCJpYXQiOjE3MDEzNDIxMDEsImV4cCI6MTcwMTM0NTcwMX0.-YzllggXO1NTJ_8b5FKYIt5WY_K2Tyh9us1cl6fTPhM', '2023-11-30 18:01:41', '2023-11-30 19:01:41', '2023-11-29 01:07:00'),
	('test123@gmail.com', 'zaza5555', 'admin', '', NULL, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
