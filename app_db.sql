-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Sep 10, 2026 at 10:00 AM
-- Server version: 8.0.46
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `id` int NOT NULL,
  `topic_id` int NOT NULL,
  `evaluator_id` int NOT NULL,
  `evaluatee_id` int NOT NULL,
  `description` text,
  `committee_role` enum('chair','member') DEFAULT 'member',
  `status` enum('pending','draft','committed') DEFAULT 'pending',
  `signature_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`id`, `topic_id`, `evaluator_id`, `evaluatee_id`, `description`, `committee_role`, `status`, `signature_path`) VALUES
(1, 1, 3, 13, NULL, 'chair', 'pending', NULL),
(4, 1, 7, 13, NULL, 'member', 'pending', NULL),
(5, 1, 4, 12, NULL, 'chair', 'pending', NULL),
(6, 1, 6, 12, NULL, 'member', 'pending', NULL),
(7, 1, 3, 17, NULL, 'member', 'pending', NULL),
(10, 1, 2, 12, NULL, 'member', 'pending', NULL),
(11, 1, 7, 12, NULL, 'member', 'pending', NULL),
(12, 1, 10, 13, NULL, 'member', 'pending', NULL),
(14, 1, 11, 13, NULL, 'member', 'pending', NULL),
(20, 1, 11, 12, NULL, 'member', 'pending', NULL),
(21, 1, 10, 21, NULL, 'member', 'pending', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--

CREATE TABLE `evidence` (
  `id` int NOT NULL,
  `topic_id` int NOT NULL,
  `evaluatee_id` int NOT NULL,
  `indicator_id` int NOT NULL,
  `detail` text,
  `self_score` decimal(3,1) DEFAULT NULL,
  `self_note` text,
  `url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `evidence_file`
--

CREATE TABLE `evidence_file` (
  `id` int NOT NULL,
  `evidence_id` int NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_mime` varchar(100) DEFAULT NULL,
  `file_size` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `indicator`
--

CREATE TABLE `indicator` (
  `id` int NOT NULL,
  `topic_id` int NOT NULL,
  `type` enum('1_4','yes_no') DEFAULT NULL,
  `weight` decimal(3,1) DEFAULT '1.0',
  `description` text,
  `evidence_kind` varchar(50) DEFAULT NULL,
  `evidence_name` varchar(255) DEFAULT NULL,
  `evidence_path` varchar(255) DEFAULT NULL,
  `evidence_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `indicator`
--

INSERT INTO `indicator` (`id`, `topic_id`, `type`, `weight`, `description`, `evidence_kind`, `evidence_name`, `evidence_path`, `evidence_url`) VALUES
(1, 1, '1_4', 1.0, 'ให้คะแนนตัวเอง', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `id` int NOT NULL,
  `assignment_id` int NOT NULL,
  `indicator_id` int NOT NULL,
  `score` decimal(3,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE `topic` (
  `id` int NOT NULL,
  `topic_name` varchar(255) NOT NULL,
  `description` text,
  `sdate` date NOT NULL,
  `edate` date NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `topic`
--

INSERT INTO `topic` (`id`, `topic_name`, `description`, `sdate`, `edate`, `isActive`) VALUES
(1, 'ประเมินเงินเดือน', 'รอบ 1', '2026-09-08', '2026-09-09', 1),
(7, 'ประเมินวิทยฐานะ PA 2', 'ประจำปีการศึกษา 2569', '2026-09-01', '2026-09-15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `role` enum('admin','evaluator','evaluatee') DEFAULT 'evaluatee',
  `status` enum('newbie','suspend','active') DEFAULT 'newbie'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `fname`, `role`, `status`) VALUES
(1, 'admin', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'koonlamet', 'admin', 'active'),
(2, 'evaluator01', '$2b$10$2h3L1TtXSWUvm5ES3zUrpO8wKluNzA9xuLD7v3dQPVwOqTX3oOBhi', 'Somchai', 'evaluator', 'active'),
(3, 'evaluator02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Somsak', 'evaluator', 'suspend'),
(4, 'evaluator03', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Wichai', 'evaluator', 'active'),
(5, 'evaluator04', '$2b$10$gdbqIq3kwGt.CJ/Cu2ux3esjH1Fw4qrXidfrzP7c/361nw.5Dhgni', 'Anan', 'evaluator', 'active'),
(6, 'evaluator05', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Prasert', 'evaluator', 'active'),
(7, 'evaluator06', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Narong', 'evaluator', 'active'),
(8, 'evaluator07', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Kittisak', 'evaluator', 'active'),
(9, 'evaluator08', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Chaiwat', 'evaluator', 'active'),
(10, 'evaluator09', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Thawat', 'evaluator', 'active'),
(11, 'evaluator10', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Boonsong', 'evaluator', 'active'),
(12, 'evaluatee01', '$2b$10$sDy9fXaFA1HRY6x/DeqByO9z/KMac6//PD2P5/fM7YIqsB9xPgRym', 'Sunisa', 'evaluatee', 'active'),
(13, 'evaluatee02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Kanya', 'evaluatee', 'active'),
(14, 'evaluatee03', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Supaporn', 'evaluatee', 'active'),
(15, 'evaluatee04', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Ploy', 'evaluatee', 'active'),
(16, 'evaluatee05', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Siriporn', 'evaluatee', 'active'),
(17, 'evaluatee06', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Nattaporn', 'evaluatee', 'active'),
(18, 'evaluatee07', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Duangjai', 'evaluatee', 'active'),
(19, 'evaluatee08', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Rattana', 'evaluatee', 'active'),
(20, 'evaluatee09', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Benjamas', 'evaluatee', 'active'),
(21, 'evaluatee10', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'Wilaiwan', 'evaluatee', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_assign` (`topic_id`,`evaluator_id`,`evaluatee_id`),
  ADD KEY `evaluator_id` (`evaluator_id`),
  ADD KEY `evaluatee_id` (`evaluatee_id`);

--
-- Indexes for table `evidence`
--
ALTER TABLE `evidence`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_evidence` (`topic_id`,`evaluatee_id`,`indicator_id`),
  ADD KEY `evaluatee_id` (`evaluatee_id`),
  ADD KEY `indicator_id` (`indicator_id`);

--
-- Indexes for table `evidence_file`
--
ALTER TABLE `evidence_file`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evidence_id` (`evidence_id`);

--
-- Indexes for table `indicator`
--
ALTER TABLE `indicator`
  ADD PRIMARY KEY (`id`),
  ADD KEY `topic_id` (`topic_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_review` (`assignment_id`,`indicator_id`),
  ADD KEY `indicator_id` (`indicator_id`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `evidence`
--
ALTER TABLE `evidence`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `evidence_file`
--
ALTER TABLE `evidence_file`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `indicator`
--
ALTER TABLE `indicator`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topic`
--
ALTER TABLE `topic`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`evaluator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`evaluatee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evidence`
--
ALTER TABLE `evidence`
  ADD CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`evaluatee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evidence_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evidence_file`
--
ALTER TABLE `evidence_file`
  ADD CONSTRAINT `evidence_file_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `indicator`
--
ALTER TABLE `indicator`
  ADD CONSTRAINT `indicator_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
