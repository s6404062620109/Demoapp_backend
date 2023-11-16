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
  PRIMARY KEY (`no`),
  KEY `FK_encoder_input_building` (`ip`),
  CONSTRAINT `FK_encoder_input_building` FOREIGN KEY (`ip`) REFERENCES `building` (`ip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.encoder_input: ~19 rows (approximately)
REPLACE INTO `encoder_input` (`no`, `status`, `dir`, `event`, `ip`) VALUES
	(1, 'NORM', 'UP', 0, '01BGEL14A'),
	(2, 'NORM', 'DOWN', 0, '01BGEL14A'),
	(3, 'NORM', 'UP', 0, 'H32ES4B'),
	(4, 'NORM', 'UP', 0, 'O1BMEL23B'),
	(5, 'NORM', 'DOWN', 0, 'O32ES4B'),
	(6, 'NORM', 'DOWN', 0, 'O41EL222C'),
	(7, 'NORM', 'DOWN', 0, 'H469EL12A'),
	(8, 'NORM', 'DOWN', 0, 'O2GEL13A'),
	(9, 'NORM', 'UP', 0, 'O2GEL13A'),
	(10, 'COMM', 'err', 0, 'H32ES3B'),
	(11, 'STOP', 'err', 0, 'H3GES1A'),
	(12, 'ERR', 'err', 0, 'O1B1EL31C'),
	(13, 'COMM', 'err', 0, 'O1B1EL31C'),
	(14, 'ERR', 'null', 0, 'O2GEL13A'),
	(21, 'ERR', 'err', 1, 'O31ES2A'),
	(22, 'NORM', 'UP', 0, 'O31ES2A'),
	(23, 'COMM', 'err', 1, 'O4GEL112A'),
	(24, 'NORM', 'UP', 0, '01BGEL15A'),
	(25, 'ERR', 'err', 1, '01BGEL15A');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table demo_project.history: ~3 rows (approximately)
REPLACE INTO `history` (`id`, `date`, `time`, `building`, `group`, `number`, `information`) VALUES
	(5, '2023-11-15', '00:14:04', 'O3', 'A', 'ES2(A2)', 'Communication by O31ES2A'),
	(6, '2023-11-16', '12:16:33', 'O4', 'A', 'EL1.1-2(A2)', 'Communication by O4GEL112A'),
	(7, '2023-11-16', '18:49:14', 'O1B', 'A', 'EL1,5(A2)', 'Communication by 01BGEL15A');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
