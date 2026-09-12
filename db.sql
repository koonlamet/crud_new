-- phpMyAdmin SQL Dump
-- Database: `app_db`
-- Mock data for Personnel Evaluation System
-- Compatible with MySQL 8.0+

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Drop existing tables in reverse dependency order
--
DROP TABLE IF EXISTS `review`;
DROP TABLE IF EXISTS `evidence_file`;
DROP TABLE IF EXISTS `evidence`;
DROP TABLE IF EXISTS `assignment`;
DROP TABLE IF EXISTS `indicator`;
DROP TABLE IF EXISTS `topic`;
DROP TABLE IF EXISTS `user`;

-- --------------------------------------------------------

--
-- Table structure for table `user`
-- All accounts have default password: "1234"
--
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `role` enum('admin','evaluator','evaluatee') DEFAULT 'evaluatee',
  `status` enum('newbie','suspend','active') DEFAULT 'newbie',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
-- Password hash for '1234'
--
INSERT INTO `user` (`id`, `username`, `password`, `fname`, `role`, `status`) VALUES
(1, 'admin', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ผู้ดูแลระบบ (Admin System)', 'admin', 'active'),
(2, 'evaluator01', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ดร.สมชาย มั่นคง', 'evaluator', 'active'),
(3, 'evaluator02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.สมศักดิ์ ปัญญาดี', 'evaluator', 'active'),
(4, 'evaluator03', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ผศ.วิชัย เกียรติขจร', 'evaluator', 'active'),
(5, 'evaluator04', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ดร.อนันต์ วิจิตรศิลป์', 'evaluator', 'active'),
(6, 'evaluator05', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ประเสริฐ ชูเกียรติ', 'evaluator', 'active'),
(7, 'evaluator06', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ณรงค์ สุทธิสาร', 'evaluator', 'active'),
(8, 'evaluator07', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ดร.กิตติศักดิ์ เจริญพร', 'evaluator', 'active'),
(9, 'evaluator08', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ชัยวัฒน์ นุ่มนวล', 'evaluator', 'active'),
(10, 'evaluator09', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ธวัชชัย รุ่งเรือง', 'evaluator', 'active'),
(11, 'evaluator10', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ผศ.บุญส่ง สุขเกษม', 'evaluator', 'active'),
(12, 'evaluatee01', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.สุนิสา ใจดี', 'evaluatee', 'active'),
(13, 'evaluatee02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.กัญญา มีทรัพย์', 'evaluatee', 'active'),
(14, 'evaluatee03', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.สุภาพร ศรีสวัสดิ์', 'evaluatee', 'active'),
(15, 'evaluatee04', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.พลอยไพลิน ดวงเนตร', 'evaluatee', 'active'),
(16, 'evaluatee05', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ศิริพร บุญตา', 'evaluatee', 'active'),
(17, 'evaluatee06', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ณัฐพร วงศ์สว่าง', 'evaluatee', 'newbie'),
(18, 'evaluatee07', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ดวงใจ แก้วมณี', 'evaluatee', 'active'),
(19, 'evaluatee08', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.รัตนา พิสุทธิ์', 'evaluatee', 'active'),
(20, 'evaluatee09', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.เบญจมาศ ทองคำ', 'evaluatee', 'suspend'),
(21, 'evaluatee10', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.วิไลวรรณ ชื่นชอบ', 'evaluatee', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--
CREATE TABLE `topic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(255) NOT NULL,
  `description` text,
  `sdate` date NOT NULL,
  `edate` date NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `topic`
--
INSERT INTO `topic` (`id`, `topic_name`, `description`, `sdate`, `edate`, `isActive`) VALUES
(1, 'การประเมินผลการปฏิบัติงานเพื่อเลื่อนขั้นเงินเดือน รอบที่ 1/2567', 'รอบการประเมินผลการปฏิบัติงานตั้งแต่วันที่ 1 ต.ค. 2566 ถึง 31 มี.ค. 2567', '2026-09-01', '2026-09-30', 1),
(2, 'การประเมินผลการปฏิบัติงานเพื่อเลื่อนขั้นเงินเดือน รอบที่ 2/2567', 'รอบการประเมินผลการปฏิบัติงานตั้งแต่วันที่ 1 เม.ย. 2567 ถึง 30 ก.ย. 2567', '2026-10-01', '2026-10-31', 1),
(3, 'การประเมินเพื่อขอมีหรือเลื่อนวิทยฐานะ (PA)', 'ประเมินข้อตกลงในการพัฒนางาน ประจำปีงบประมาณ 2567', '2026-08-01', '2026-08-31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `indicator`
--
CREATE TABLE `indicator` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic_id` int NOT NULL,
  `type` enum('1_4','yes_no') DEFAULT NULL,
  `weight` decimal(3,1) DEFAULT '1.0',
  `description` text,
  `evidence_kind` varchar(50) DEFAULT NULL,
  `evidence_name` varchar(255) DEFAULT NULL,
  `evidence_path` varchar(255) DEFAULT NULL,
  `evidence_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `indicator_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `indicator`
--
INSERT INTO `indicator` (`id`, `topic_id`, `type`, `weight`, `description`, `evidence_kind`, `evidence_name`, `evidence_path`, `evidence_url`) VALUES
(1, 1, '1_4', 40.0, '1. ผลสัมฤทธิ์ของงานตามภาระงานสอนและการพัฒนาผู้เรียน (KPIs)', '["pdf","image"]', '["แผนการสอน.pdf","ภาพกิจกรรม.jpg"]', '["uploads/plan.pdf","uploads/act.jpg"]', 'https://drive.google.com/sample'),
(2, 1, '1_4', 30.0, '2. ผลงานด้านงานวิจัย นวัตกรรม และบริการวิชาการ', '["pdf","url"]', '["รายงานวิจัย.pdf"]', '["uploads/research.pdf"]', 'https://github.com/project'),
(3, 1, '1_4', 20.0, '3. สมรรถนะหลักและการทำงานร่วมกับผู้อื่น (Core Competency)', '["pdf"]', '["เกียรติบัตร.pdf"]', '["uploads/cert.pdf"]', NULL),
(4, 1, 'yes_no', 10.0, '4. การมีวินัย คุณธรรม จริยธรรม และจรรยาบรรณวิชาชีพ (ไม่ขาด ไม่ลาเกินเกณฑ์)', '["pdf"]', '["สถิติการมาทำงาน.pdf"]', '["uploads/attendance.pdf"]', NULL),
(5, 2, '1_4', 50.0, '1. คุณภาพและประสิทธิภาพการจัดการเรียนรู้', '["pdf"]', NULL, NULL, NULL),
(6, 2, '1_4', 30.0, '2. การมีส่วนร่วมในกิจกรรมส่งเสริมการเรียนรู้ของสถานศึกษา', '["image"]', NULL, NULL, NULL),
(7, 2, 'yes_no', 20.0, '3. วินัยและการรักษาวินัยราชการ', '["pdf"]', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--
CREATE TABLE `assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic_id` int NOT NULL,
  `evaluator_id` int NOT NULL,
  `evaluatee_id` int NOT NULL,
  `description` text,
  `committee_role` enum('chair','member') DEFAULT 'member',
  `status` enum('pending','draft','committed') DEFAULT 'pending',
  `signature_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_assign` (`topic_id`,`evaluator_id`,`evaluatee_id`),
  KEY `evaluator_id` (`evaluator_id`),
  KEY `evaluatee_id` (`evaluatee_id`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`evaluator_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignment_ibfk_3` FOREIGN KEY (`evaluatee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignment`
--
INSERT INTO `assignment` (`id`, `topic_id`, `evaluator_id`, `evaluatee_id`, `description`, `committee_role`, `status`, `signature_path`) VALUES
(1, 1, 2, 12, 'ปฏิบัติหน้าที่ดีเด่น ตรงตามข้อตกลงและแผนงาน', 'chair', 'committed', 'signatures/sign_2_12.png'),
(2, 1, 3, 12, 'ผลงานชัดเจน มีนวัตกรรมการสอนที่ยอดเยี่ยม', 'member', 'committed', 'signatures/sign_3_12.png'),
(3, 1, 2, 13, 'ผลงานดีมาก มีความรับผิดชอบและตรงต่อเวลา', 'chair', 'committed', 'signatures/sign_2_13.png'),
(4, 1, 4, 13, 'ร่างคะแนนรอบแรก รอตรวจเอกสารวิจัยฉบับสมบูรณ์เพิ่มเติม', 'member', 'draft', NULL),
(5, 1, 5, 14, NULL, 'chair', 'pending', NULL),
(6, 1, 6, 14, NULL, 'member', 'pending', NULL),
(7, 1, 5, 15, 'ปฏิบัติงานยอดเยี่ยม ผลงานนักเรียนโดดเด่น', 'chair', 'committed', 'signatures/sign_5_15.png'),
(8, 1, 7, 15, 'ดีเด่น มีจิตสาธารณะและการทำงานร่วมกันดีมาก', 'member', 'committed', 'signatures/sign_7_15.png'),
(9, 1, 8, 16, NULL, 'chair', 'pending', NULL),
(10, 1, 9, 16, 'บันทึกคะแนนเบื้องต้นแล้ว รอการยืนยัน', 'member', 'draft', NULL),
(11, 1, 10, 17, NULL, 'chair', 'pending', NULL),
(12, 1, 11, 17, NULL, 'member', 'pending', NULL),
(13, 1, 3, 18, 'ผ่านเกณฑ์ตามมาตรฐานการปฏิบัติงาน', 'chair', 'committed', 'signatures/sign_3_18.png'),
(14, 1, 7, 18, 'ผลงานตามเกณฑ์ระดับดีมาก', 'member', 'committed', 'signatures/sign_7_18.png');

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--
CREATE TABLE `evidence` (
  `id` int NOT NULL AUTO_INCREMENT,
  `topic_id` int NOT NULL,
  `evaluatee_id` int NOT NULL,
  `indicator_id` int NOT NULL,
  `detail` text,
  `self_score` decimal(3,1) DEFAULT NULL,
  `self_note` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_evidence` (`topic_id`,`evaluatee_id`,`indicator_id`),
  KEY `evaluatee_id` (`evaluatee_id`),
  KEY `indicator_id` (`indicator_id`),
  CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`evaluatee_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evidence_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evidence_ibfk_3` FOREIGN KEY (`topic_id`) REFERENCES `topic` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `evidence`
--
INSERT INTO `evidence` (`id`, `topic_id`, `evaluatee_id`, `indicator_id`, `detail`, `self_score`, `self_note`) VALUES
(1, 1, 12, 1, 'จัดการเรียนการสอนครบ 18 สัปดาห์ มีแผนการสอนบูรณาการและบันทึกหลังสอนครบถ้วน', 4.0, 'ดำเนินการได้ครบถ้วน บรรลุตามตัวชี้วัดทุกประการ'),
(2, 1, 12, 2, 'เผยแพร่งานวิจัยในชั้นเรียน 1 เรื่อง นวัตกรรมการพัฒนาโปรแกรมเว็บแอปพลิเคชัน', 3.5, 'ตีพิมพ์เผยแพร่ในวารสารระดับสถานศึกษา'),
(3, 1, 12, 3, 'ทำงานร่วมกับเพื่อนครูในแผนก ให้ความร่วมมือในทุกกิจกรรมของวิทยาลัย', 4.0, 'ได้รับคำชมเชยจากเพื่อนร่วมงานและหัวหน้าแผนก'),
(4, 1, 12, 4, 'ไม่เคยขาดหรือมาสาย มีเวลาปฏิบัติราชการครบ 100%', 1.0, 'ปฏิบัติตามระเบียบและวินัยอย่างเคร่งครัด'),
(5, 1, 13, 1, 'จัดทำแผนการสอนรายวิชาการเขียนโปรแกรมบนอุปกรณ์เคลื่อนที่', 3.5, 'สอนตามเกณฑ์มาตรฐานรายวิชา'),
(6, 1, 13, 2, 'จัดทำสื่อการสอนออนไลน์ผ่าน Youtube และเว็บไซต์ประกอบการเรียน', 3.0, 'มีคลิปการสอนครบ 10 บทเรียน'),
(7, 1, 13, 3, 'ช่วยเหลืองานฝ่ายวิชาการและงานทะเบียนนักเรียนนักศึกษา', 3.5, 'ปฏิบัติหน้าที่เวรประจำวันและงานที่ได้รับมอบหมาย'),
(8, 1, 14, 1, 'ส่งแผนการสอนเบื้องต้นเรียบร้อยแล้ว', 3.0, 'อยู่ระหว่างปรับปรุงบันทึกหลังการสอน'),
(9, 1, 15, 1, 'ผลสัมฤทธิ์ผู้เรียนผ่านเกณฑ์ 92% มีผลการประเมินความพึงพอใจระดับดีมาก', 4.0, 'นักเรียนผ่านเกณฑ์การประเมินมาตรฐานทุกคน'),
(10, 1, 15, 2, 'คว้ารางวัลชนะเลิศโครงงานสิ่งประดิษฐ์ของคนรุ่นใหม่ระดับภาค', 4.0, 'ทำหน้าที่ครูที่ปรึกษาโครงงานสิ่งประดิษฐ์'),
(11, 1, 15, 3, 'มีมนุษยสัมพันธ์ดีเยี่ยม ให้ความร่วมมือในกิจกรรมแผนกและสถานศึกษาอย่างสม่ำเสมอ', 3.5, 'ร่วมกิจกรรมของสถานศึกษาครบถ้วน'),
(12, 1, 15, 4, 'สถิติการมาปฏิบัติราชการคิดเป็นร้อยละ 99.5', 1.0, 'ไม่มีประวัติขาดงานหรือละทิ้งหน้าที่');

-- --------------------------------------------------------

--
-- Table structure for table `evidence_file`
--
CREATE TABLE `evidence_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `evidence_id` int NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_mime` varchar(100) DEFAULT NULL,
  `file_size` int UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `evidence_id` (`evidence_id`),
  CONSTRAINT `evidence_file_ibfk_1` FOREIGN KEY (`evidence_id`) REFERENCES `evidence` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `evidence_file`
--
INSERT INTO `evidence_file` (`id`, `evidence_id`, `file_name`, `file_path`, `file_mime`, `file_size`) VALUES
(1, 1, 'แผนการสอน_ภาคเรียนที่1.pdf', 'uploads/evidence/lesson_plan_12_1.pdf', 'application/pdf', 2458900),
(2, 1, 'รูปกิจกรรมการสอน.jpg', 'uploads/evidence/teaching_act_12_1.jpg', 'image/jpeg', 1542000),
(3, 2, 'บทความวิจัย_2567.pdf', 'uploads/evidence/research_paper_12_2.pdf', 'application/pdf', 4890120),
(4, 3, 'เกียรติบัตรครูดีเด่น.pdf', 'uploads/evidence/cert_12_3.pdf', 'application/pdf', 1120400),
(5, 4, 'ใบรายงานเวลาปฏิบัติงาน.pdf', 'uploads/evidence/attendance_12_4.pdf', 'application/pdf', 890300),
(6, 5, 'แผนการสอนวิชาโปรแกรม.pdf', 'uploads/evidence/plan_prog_13_1.pdf', 'application/pdf', 1980000),
(7, 9, 'สรุปผลการเรียนนักเรียน.pdf', 'uploads/evidence/grade_summary_15_1.pdf', 'application/pdf', 1204000),
(8, 10, 'เกียรติบัตรรางวัลสิ่งประดิษฐ์.pdf', 'uploads/evidence/invention_award_15_2.pdf', 'application/pdf', 3410000);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assignment_id` int NOT NULL,
  `indicator_id` int NOT NULL,
  `score` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_review` (`assignment_id`,`indicator_id`),
  KEY `indicator_id` (`indicator_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `review`
--
INSERT INTO `review` (`id`, `assignment_id`, `indicator_id`, `score`) VALUES
-- Assignment 1: ดร.สมชาย ตรวจ อ.สุนิสา (Committed)
(1, 1, 1, 3.8),
(2, 1, 2, 3.5),
(3, 1, 3, 3.7),
(4, 1, 4, 1.0),
-- Assignment 2: อ.สมศักดิ์ ตรวจ อ.สุนิสา (Committed)
(5, 2, 1, 3.6),
(6, 2, 2, 3.7),
(7, 2, 3, 3.5),
(8, 2, 4, 1.0),
-- Assignment 3: ดร.สมชาย ตรวจ อ.กัญญา (Committed)
(9, 3, 1, 3.5),
(10, 3, 2, 3.0),
(11, 3, 3, 3.2),
(12, 3, 4, 1.0),
-- Assignment 4: ผศ.วิชัย ตรวจ อ.กัญญา (Draft)
(13, 4, 1, 3.2),
(14, 4, 2, 2.8),
-- Assignment 7: ดร.อนันต์ ตรวจ อ.พลอยไพลิน (Committed)
(15, 7, 1, 4.0),
(16, 7, 2, 3.9),
(17, 7, 3, 3.8),
(18, 7, 4, 1.0),
-- Assignment 8: อ.ณรงค์ ตรวจ อ.พลอยไพลิน (Committed)
(19, 8, 1, 3.9),
(20, 8, 2, 4.0),
(21, 8, 3, 3.7),
(22, 8, 4, 1.0),
-- Assignment 13: อ.สมศักดิ์ ตรวจ อ.ดวงใจ (Committed)
(23, 13, 1, 3.2),
(24, 13, 2, 3.0),
(25, 13, 3, 3.1),
(26, 13, 4, 1.0),
-- Assignment 14: อ.ณรงค์ ตรวจ อ.ดวงใจ (Committed)
(27, 14, 1, 3.0),
(28, 14, 2, 3.1),
(29, 14, 3, 3.0),
(30, 14, 4, 1.0);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
