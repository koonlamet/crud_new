-- phpMyAdmin SQL Dump
-- Database: `app_db`
-- Comprehensive Mock Data for Personnel Evaluation System
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
(27, 'admin02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อาจารย์ดวงกมล นิติบดี (Admin วิชาการ)', 'admin', 'active'),
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
(28, 'evaluator11', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ดร.อรทัย วิเศษคุณ', 'evaluator', 'active'),
(29, 'evaluator12', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'ผศ.ดร.ธีรพงษ์ สุวรรณเวช', 'evaluator', 'active'),
(12, 'evaluatee01', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.สุนิสา ใจดี', 'evaluatee', 'active'),
(13, 'evaluatee02', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.กัญญา มีทรัพย์', 'evaluatee', 'active'),
(14, 'evaluatee03', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.สุภาพร ศรีสวัสดิ์', 'evaluatee', 'active'),
(15, 'evaluatee04', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.พลอยไพลิน ดวงเนตร', 'evaluatee', 'active'),
(16, 'evaluatee05', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ศิริพร บุญตา', 'evaluatee', 'active'),
(17, 'evaluatee06', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ณัฐพร วงศ์สว่าง', 'evaluatee', 'newbie'),
(18, 'evaluatee07', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ดวงใจ แก้วมณี', 'evaluatee', 'active'),
(19, 'evaluatee08', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.รัตนา พิสุทธิ์', 'evaluatee', 'active'),
(20, 'evaluatee09', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.เบญจมาศ ทองคำ', 'evaluatee', 'suspend'),
(21, 'evaluatee10', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.วิไลวรรณ ชื่นชอบ', 'evaluatee', 'active'),
(22, 'evaluatee11', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ชลธิชา สมบูรณ์', 'evaluatee', 'active'),
(23, 'evaluatee12', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ภานุมาศ วัฒนพาณิชย์', 'evaluatee', 'active'),
(24, 'evaluatee13', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.ธนดล เลิศวิริยะ', 'evaluatee', 'newbie'),
(25, 'evaluatee14', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.กมลวรรณ ทวีสุข', 'evaluatee', 'active'),
(26, 'evaluatee15', '$2a$12$Kmcjkgnc2JEbs482qJCZD.3TS97M2RqgyxU2AOe5UQCPHL7jjFSsq', 'อ.อนุรักษ์ บุญธรรม', 'evaluatee', 'active');

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
(3, 'การประเมินเพื่อขอมีหรือเลื่อนวิทยฐานะ (PA)', 'ประเมินข้อตกลงในการพัฒนางาน ประจำปีงบประมาณ 2567', '2026-08-01', '2026-08-31', 0),
(4, 'การประเมินสมรรถนะการปฏิบัติงานของบุคลากรสายสนับสนุน ประจำปี 2567', 'การประเมินสมรรถนะหลักและสมรรถนะประจำสายงาน สำหรับบุคลากรสายสนับสนุนวิชาการ', '2026-09-05', '2026-09-28', 1),
(5, 'การประเมินผลการเตรียมความพร้อมและพัฒนาอย่างเข้ม (ครูผู้ช่วย ครั้งที่ 1)', 'รอบการประเมินเพื่อประเมินความพร้อมและพัฒนาอย่างเข้มสำหรับครูผู้ช่วยบรรจุใหม่', '2026-09-10', '2026-10-15', 1);

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
(1, 1, '1_4', 3, '1. ผลสัมฤทธิ์ของงานตามภาระงานสอนและการพัฒนาผู้เรียน (KPIs)', '["pdf","image"]', '["แผนการสอน.pdf","ภาพกิจกรรม.jpg"]', '["uploads/plan.pdf","uploads/act.jpg"]', 'https://drive.google.com/sample'),
(2, 1, '1_4', 2, '2. ผลงานด้านงานวิจัย นวัตกรรม และบริการวิชาการ', '["pdf","url"]', '["รายงานวิจัย.pdf"]', '["uploads/research.pdf"]', 'https://github.com/project'),
(3, 1, '1_4', 2, '3. สมรรถนะหลักและการทำงานร่วมกับผู้อื่น (Core Competency)', '["pdf"]', '["เกียรติบัตร.pdf"]', '["uploads/cert.pdf"]', NULL),
(4, 1, 'yes_no', 1, '4. การมีวินัย คุณธรรม จริยธรรม และจรรยาบรรณวิชาชีพ (ไม่ขาด ไม่ลาเกินเกณฑ์)', '["pdf"]', '["สถิติการมาทำงาน.pdf"]', '["uploads/attendance.pdf"]', NULL),
(5, 2, '1_4', 3, '1. คุณภาพและประสิทธิภาพการจัดการเรียนรู้บูรณาการสู่ศตวรรษที่ 21', '["pdf","image"]', '["แผนบูรณาการ.pdf"]', '["uploads/plan_topic2.pdf"]', 'https://drive.google.com/topic2/plan'),
(6, 2, '1_4', 2, '2. การมีส่วนร่วมในกิจกรรมส่งเสริมการเรียนรู้ของสถานศึกษาและชุมชน', '["image","url"]', '["ภาพกิจกรรมชุมชน.jpg"]', '["uploads/act_community.jpg"]', 'https://facebook.com/college-activity'),
(7, 2, '1_4', 2, '3. การพัฒนาตนเองทางวิชาการและวิชาชีพอย่างต่อเนื่อง', '["pdf"]', '["วุฒิบัตรอบรม.pdf"]', '["uploads/cert_training.pdf"]', NULL),
(8, 2, 'yes_no', 1, '4. วินัยและการรักษาวินัยราชการ ไม่เคยถูกลงโทษทางวินัย', '["pdf"]', '["หนังสือรับรองวินัย.pdf"]', '["uploads/discipline_cert.pdf"]', NULL),
(9, 3, '1_4', 3, 'ด้านที่ 1 ด้านการจัดการเรียนรู้ (สร้าง พัฒนาหลักสูตร และออกแบบหน่วยการเรียนรู้)', '["pdf","url"]', '["เอกสารหลักสูตรรายวิชา.pdf"]', '["uploads/pa_curriculum.pdf"]', 'https://drive.google.com/pa_docs'),
(10, 3, '1_4', 2, 'ด้านที่ 2 ด้านการส่งเสริมและสนับสนุนการจัดการเรียนรู้ (ระบบดูแลผู้เรียนและชุมชน PLC)', '["pdf","image"]', '["รายงานPLC.pdf"]', '["uploads/plc_report.pdf"]', NULL),
(11, 3, '1_4', 2, 'ด้านที่ 3 ด้านการพัฒนาตนเองและวิชาชีพ (การเข้าร่วมอบรม/สัมมนา)', '["pdf"]', '["เกียรติบัตรPA.pdf"]', '["uploads/cert_pa.pdf"]', NULL),
(12, 3, 'yes_no', 1, 'ข้อตกลงในการพัฒนางานที่เป็นประเด็นท้าทายในการพัฒนาผลลัพธ์การเรียนรู้ของผู้เรียน', '["pdf","url"]', '["รายงานประเด็นท้าทาย.pdf"]', '["uploads/challenge_pa.pdf"]', 'https://youtube.com/watch?v=sample_challenge'),
(13, 4, '1_4', 3, '1. ผลสัมฤทธิ์ของงานตามภาระงานที่ได้รับมอบหมายและงานประจำ', '["pdf"]', '["สรุปผลงานสนับสนุน.pdf"]', '["uploads/support_summary.pdf"]', NULL),
(14, 4, '1_4', 2, '2. ความสามารถในการใช้เทคโนโลยีดิจิทัลและพัฒนานวัตกรรมการทำงาน', '["pdf","url"]', '["คู่มือระบบงานดิจิทัล.pdf"]', '["uploads/manual_sys.pdf"]', 'https://support.college.ac.th'),
(15, 4, '1_4', 2, '3. การบริการด้วยความใส่ใจและสร้างความประทับใจแก่ผู้รับบริการ (Service Mind)', '["pdf"]', '["แบบสำรวจความพึงพอใจ.pdf"]', '["uploads/satisfaction.pdf"]', NULL),
(16, 4, 'yes_no', 1, '4. การปฏิบัติตามกฎ ระเบียบ ข้อบังคับ และวินัยการทำงาน', '["pdf"]', '["รายงานเวลาปฏิบัติราชการ.pdf"]', '["uploads/attendance_support.pdf"]', NULL),
(17, 5, '1_4', 3, '1. การจัดการเรียนการสอนและการบริหารจัดการชั้นเรียน', '["pdf","image"]', '["แผนการสอนครูผู้ช่วย.pdf"]', '["uploads/assistant_teach.pdf"]', NULL),
(18, 5, '1_4', 2, '2. การมีส่วนร่วมในกิจกรรมพัฒนาผู้เรียนและงานที่ได้รับมอบหมายพิเศษ', '["image"]', '["รูปกิจกรรมผู้เรียน.jpg"]', '["uploads/student_act.jpg"]', NULL),
(19, 5, '1_4', 1, '3. การพัฒนาตนเองและการทำงานร่วมกับชุมชน', '["pdf"]', '["บันทึกการเรียนรู้.pdf"]', '["uploads/self_dev.pdf"]', NULL),
(20, 5, 'yes_no', 1, '4. การปฏิบัติตนตามมาตรฐานวิชาชีพและจรรยาบรรณวิชาชีพครู', '["pdf"]', '["รายงานการประพฤติตน.pdf"]', '["uploads/conduct_report.pdf"]', NULL);

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
(1, 1, 2, 12, 'ปฏิบัติหน้าที่ดีเด่น ตรงตามข้อตกลงและแผนงาน มีการจัดการเรียนการสอนมีคุณภาพสูง', 'chair', 'committed', 'signatures/sign_2_12.png'),
(2, 1, 3, 12, 'ผลงานชัดเจน มีนวัตกรรมการสอนที่ยอดเยี่ยม เอกสารประกอบการสอนครบถ้วนสมบูรณ์', 'member', 'committed', 'signatures/sign_3_12.png'),
(3, 1, 2, 13, 'ผลงานดีมาก มีความรับผิดชอบและตรงต่อเวลา บันทึกการสอนเป็นปัจจุบัน', 'chair', 'committed', 'signatures/sign_2_13.png'),
(4, 1, 4, 13, 'ร่างคะแนนรอบแรก รอตรวจเอกสารวิจัยฉบับสมบูรณ์เพิ่มเติม', 'member', 'draft', NULL),
(5, 1, 5, 14, 'อยู่ระหว่างรวบรวมหลักฐานและรอการประเมิน', 'chair', 'pending', NULL),
(6, 1, 6, 14, NULL, 'member', 'pending', NULL),
(7, 1, 5, 15, 'ปฏิบัติงานยอดเยี่ยม ผลงานนักเรียนโดดเด่น คว้ารางวัลระดับภาค', 'chair', 'committed', 'signatures/sign_5_15.png'),
(8, 1, 7, 15, 'ดีเด่น มีจิตสาธารณะและการทำงานร่วมกันดีมาก ผลสัมฤทธิ์ผู้เรียนสูงกว่าเกณฑ์', 'member', 'committed', 'signatures/sign_7_15.png'),
(9, 1, 8, 16, 'ผลการปฏิบัติงานเป็นไปตามมาตรฐานที่กำหนด สมควรได้รับการพิจารณาเลื่อนขั้น', 'chair', 'committed', 'signatures/sign_8_16.png'),
(10, 1, 9, 16, 'บันทึกคะแนนเบื้องต้นแล้ว รอการยืนยันสรุปผลรอบสุดท้าย', 'member', 'draft', NULL),
(11, 1, 10, 17, NULL, 'chair', 'pending', NULL),
(12, 1, 11, 17, NULL, 'member', 'pending', NULL),
(13, 1, 3, 18, 'ผ่านเกณฑ์ตามมาตรฐานการปฏิบัติงาน มีการนำสื่อดิจิทัลมาช่วยสอน', 'chair', 'committed', 'signatures/sign_3_18.png'),
(14, 1, 7, 18, 'ผลงานตามเกณฑ์ระดับดีมาก ปฏิบัติงานร่วมกับผู้อื่นได้ราบรื่น', 'member', 'committed', 'signatures/sign_7_18.png'),
(15, 1, 4, 19, 'การปฏิบัติหน้าที่เรียบร้อย มีผลสัมฤทธิ์ดี ตรงตามเกณฑ์ของวิทยาลัย', 'chair', 'committed', 'signatures/sign_4_19.png'),
(16, 1, 8, 19, 'ผลงานการสอนดี สื่อการสอนทันสมัยและน่าสนใจ', 'member', 'committed', 'signatures/sign_8_19.png'),
(17, 1, 6, 20, NULL, 'chair', 'pending', NULL),
(18, 1, 9, 20, NULL, 'member', 'pending', NULL),
(19, 1, 10, 21, 'มีความทุ่มเทในการปฏิบัติงาน อุทิศเวลาเพื่อผู้เรียนและสถานศึกษา', 'chair', 'committed', 'signatures/sign_10_21.png'),
(20, 1, 11, 21, 'ผลการปฏิบัติงานระดับดีเยี่ยม ปฏิบัติตามกฎระเบียบและวินัยอย่างเคร่งครัด', 'member', 'committed', 'signatures/sign_11_21.png'),
(21, 1, 2, 22, 'ผลงานดีเด่น จัดกิจกรรมการเรียนการสอนแบบ Active Learning ได้มีประสิทธิภาพ', 'chair', 'committed', 'signatures/sign_2_22.png'),
(22, 1, 6, 22, 'ให้ความร่วมมือในกิจกรรมของแผนกดีเยี่ยม การจัดทำเอกสารเรียบร้อย', 'member', 'committed', 'signatures/sign_6_22.png'),
(23, 1, 3, 23, 'ตรวจแฟ้มสะสมงานแล้ว มีความครบถ้วน อยู่ระหว่างการสรุปผล', 'chair', 'draft', NULL),
(24, 1, 9, 23, NULL, 'member', 'pending', NULL),
(25, 2, 4, 12, NULL, 'chair', 'pending', NULL),
(26, 2, 5, 12, NULL, 'member', 'pending', NULL),
(27, 2, 6, 13, NULL, 'chair', 'pending', NULL),
(28, 2, 7, 13, NULL, 'member', 'pending', NULL),
(29, 2, 2, 15, NULL, 'chair', 'pending', NULL),
(30, 2, 8, 15, NULL, 'member', 'pending', NULL),
(31, 2, 3, 18, NULL, 'chair', 'pending', NULL),
(32, 2, 10, 21, NULL, 'chair', 'pending', NULL),
(33, 3, 2, 12, 'ผ่านการประเมินข้อตกลงในการพัฒนางาน (PA) ระดับดีเยี่ยม มีผลงานเชิงประจักษ์', 'chair', 'committed', 'signatures/sign_pa_2_12.png'),
(34, 3, 4, 12, 'ประเด็นท้าทายสำเร็จตามเป้าหมาย เกิดประโยชน์ต่อผู้เรียนอย่างแท้จริง', 'member', 'committed', 'signatures/sign_pa_4_12.png'),
(35, 3, 5, 15, 'ผลการประเมิน PA ผ่านเกณฑ์ทุกตัวชี้วัด แผนพัฒนาตนเองและผู้เรียนชัดเจน', 'chair', 'committed', 'signatures/sign_pa_5_15.png'),
(36, 3, 7, 15, 'นวัตกรรมการจัดการเรียนรู้ตอบสนองผลลัพธ์การเรียนรู้ของผู้เรียนได้ยอดเยี่ยม', 'member', 'committed', 'signatures/sign_pa_7_15.png'),
(37, 3, 3, 18, 'ผ่านเกณฑ์การประเมิน PA ประจำปีงบประมาณ 2567 สมบูรณ์ครบถ้วน', 'chair', 'committed', 'signatures/sign_pa_3_18.png'),
(38, 3, 8, 18, 'เอกสารหลักฐานครบถ้วน มีการนำกระบวนการ PLC มาประยุกต์ใช้ในการแก้ปัญหา', 'member', 'committed', 'signatures/sign_pa_8_18.png'),
(39, 4, 28, 24, 'การตรวจทานเอกสารรอบแรกมีความสมบูรณ์ อยู่ระหว่างเตรียมสรุปผล', 'chair', 'draft', NULL),
(40, 4, 9, 24, NULL, 'member', 'pending', NULL),
(41, 5, 2, 17, 'การประเมินพัฒนาอย่างเข้มครูผู้ช่วย ผลงานการจัดการเรียนรู้ก้าวหน้าดีมาก', 'chair', 'draft', NULL),
(42, 5, 29, 17, NULL, 'member', 'pending', NULL);

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
  `url` varchar(500) DEFAULT NULL,
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
INSERT INTO `evidence` (`id`, `topic_id`, `evaluatee_id`, `indicator_id`, `detail`, `self_score`, `self_note`, `url`) VALUES
(1, 1, 12, 1, '["จัดการเรียนการสอนครบ 18 สัปดาห์ มีแผนการสอนบูรณาการและบันทึกหลังสอนครบถ้วน","จัดทำสื่อการสอนดิจิทัลและใบงานแบบฝึกทักษะ 12 หน่วย"]', 4, 'ดำเนินการได้ครบถ้วน บรรลุตามตัวชี้วัดทุกประการ นักเรียนมีผลสัมฤทธิ์สูงขึ้น', 'https://drive.google.com/drive/folders/1A2B3C4D5E6F7G8H9-plan2567'),
(2, 1, 12, 2, '["เผยแพร่งานวิจัยในชั้นเรียน 1 เรื่อง นวัตกรรมการพัฒนาโปรแกรมเว็บแอปพลิเคชัน","บทความวิจัยได้รับการตีพิมพ์ในรายงานการประชุมวิชาการระดับชาติ"]', 3.5, 'ตีพิมพ์เผยแพร่ในวารสารและนำผลวิจัยมาปรับใช้ในการสอนจริง', 'https://github.com/sunisa-kru/student-web-portal'),
(3, 1, 12, 3, '["ทำงานร่วมกับเพื่อนครูในแผนก ให้ความร่วมมือในทุกกิจกรรมของวิทยาลัย","ได้รับมอบหมายหน้าที่หัวหน้างานหลักสูตรการเรียนการสอน"]', 4, 'ได้รับคำชมเชยจากเพื่อนร่วมงานและหัวหน้าแผนก ให้ความร่วมมือด้วยความเต็มใจเสมอ', 'https://sites.google.com/view/sunisa-portfolio2567'),
(4, 1, 12, 4, '["ไม่เคยขาดหรือมาสาย มีเวลาปฏิบัติราชการครบ 100%","ปฏิบัติตามจรรยาบรรณวิชาชีพและระเบียบวินัยเคร่งครัด"]', 1, 'ปฏิบัติตามระเบียบและวินัยอย่างเคร่งครัด ไม่มีข้อบกพร่องเรื่องเวลา', NULL),
(5, 1, 13, 1, '["จัดทำแผนการสอนรายวิชาการเขียนโปรแกรมบนอุปกรณ์เคลื่อนที่","ออกแบบกิจกรรมการเรียนรู้แบบ Project-based Learning"]', 3.5, 'สอนตามเกณฑ์มาตรฐานรายวิชา และส่งเสริมนักเรียนสร้างผลงานจริง', 'https://drive.google.com/drive/folders/1Kanya-MobileApp-Lesson'),
(6, 1, 13, 2, '["จัดทำสื่อการสอนออนไลน์ผ่าน YouTube ช่อง KruKanya Channel","มีคลิปวิดีโอสาธิตการเขียนโปรแกรมจำนวน 15 ตอน"]', 3, 'มีคลิปการสอนครบ 15 บทเรียน มีนักเรียนและบุคคลทั่วไปเข้าชมต่อเนื่อง', 'https://www.youtube.com/playlist?list=PL_sample_teaching_2026'),
(7, 1, 13, 3, '["ช่วยเหลืองานฝ่ายวิชาการและงานทะเบียนนักเรียนนักศึกษา","ร่วมเป็นคณะกรรมการจัดงานเปิดบ้านวิชาการ Open House"]', 3.5, 'ปฏิบัติหน้าที่เวรประจำวันและงานที่ได้รับมอบหมายด้วยความรับผิดชอบสูง', NULL),
(8, 1, 13, 4, '["มาปฏิบัติราชการตรงเวลา ลาป่วยตามความจำเป็น 1 วัน","ไม่เคยมีประวัติการทำผิดวินัยใดๆ"]', 1, 'รักษาวินัยในการปฏิบัติงานและปฏิบัติตามคำสั่งผู้บังคับบัญชา', NULL),
(9, 1, 14, 1, '["ส่งแผนการสอนเบื้องต้นเรียบร้อยแล้ว ครอบคลุมสาระสำคัญของหลักสูตร"]', 3, 'อยู่ระหว่างปรับปรุงบันทึกหลังการสอนและแบบวัดประเมินผล', 'https://drive.google.com/drive/folders/1Supaporn-CoursePlan'),
(10, 1, 14, 2, '["จัดทำเอกสารประกอบการสอนวิชาคอมพิวเตอร์กราฟิกส์ 1 รายวิชา"]', 3, 'รวบรวมตัวอย่างชิ้นงานนักเรียนเพื่อประกอบการทำรายงานวิจัยในชั้นเรียน', NULL),
(11, 1, 15, 1, '["ผลสัมฤทธิ์ผู้เรียนผ่านเกณฑ์ร้อยละ 94 มีผลการประเมินความพึงพอใจระดับดีมาก","นำเทคนิค Gamification มาประยุกต์ในการจัดการเรียนรู้"]', 4, 'นักเรียนผ่านเกณฑ์การประเมินมาตรฐานทุกคน และมีเจตคติที่ดีต่อวิชาเรียน', 'https://drive.google.com/drive/folders/1Ploy-Gamification-Teaching'),
(12, 1, 15, 2, '["เป็นครูที่ปรึกษาโครงงานสิ่งประดิษฐ์คนรุ่นใหม่ ได้รับรางวัลชนะเลิศระดับภาค","เผยแพร่ผลงานนวัตกรรมสู่ชุมชนและสถานศึกษาใกล้เคียง"]', 4, 'ทุ่มเทนำนักเรียนเข้าร่วมการแข่งขันและคว้าชัยชนะสร้างชื่อเสียงให้วิทยาลัย', 'https://padlet.com/teacher_ploy/science_fair_project'),
(13, 1, 15, 3, '["มีมนุษยสัมพันธ์ดีเยี่ยม ให้ความร่วมมือในกิจกรรมแผนกและสถานศึกษาอย่างสม่ำเสมอ","เป็นวิทยากรอบรมการใช้ AI สำหรับเพื่อนครูในสถานศึกษา"]', 3.5, 'ร่วมกิจกรรมของสถานศึกษาครบถ้วน และพร้อมถ่ายทอดความรู้ใหม่ๆ ให้เพื่อนร่วมงาน', 'https://sites.google.com/view/ploy-innovation-ai'),
(14, 1, 15, 4, '["สถิติการมาปฏิบัติราชการคิดเป็นร้อยละ 99.5 ไม่เคยขาดงาน","ประพฤติปฏิบัติตนตามระเบียบแบบแผนของทางราชการ"]', 1, 'ไม่มีประวัติขาดงานหรือละทิ้งหน้าที่ มีความซื่อสัตย์สุจริต', NULL),
(15, 1, 16, 1, '["จัดการเรียนการสอนรายวิชาคณิตศาสตร์คอมพิวเตอร์ครบถ้วนตามหลักสูตร","จัดทำแบบทดสอบก่อนเรียน-หลังเรียนบนแพลตฟอร์ม Google Form"]', 3.5, 'จัดทำแบบบันทึกผลการเรียนรู้อย่างเป็นระบบ นักเรียนมีพัฒนาการที่วัดผลได้', 'https://drive.google.com/drive/folders/1Siriporn-Math-Doc'),
(16, 1, 16, 2, '["จัดทำชุดการเรียนรู้ด้วยตนเอง เรื่องระบบเลขฐานและตรรกศาสตร์"]', 3, 'เอกสารแบบฝึกหัดพัฒนาขึ้นเพื่อแก้ปัญหาการคำนวณของผู้เรียน', NULL),
(17, 1, 16, 3, '["ปฏิบัติหน้าที่กรรมการฝ่ายการเงินและพัสดุของแผนกวิชา","ประสานงานจัดซื้อจัดจ้างอย่างโปร่งใส ตรวจสอบได้"]', 3.5, 'ทำงานเอกสารการเงินถูกต้องตามระเบียบ ปฏิบัติหน้าที่ด้วยความรอบคอบ', NULL),
(18, 1, 16, 4, '["มีประวัติการมาปฏิบัติหน้าที่สม่ำเสมอ ไม่เคยทำผิดวินัย"]', 1, 'รักษาวินัยและมาตรฐานทางวิชาชีพครูอย่างเคร่งครัด', NULL),
(19, 1, 17, 1, '["จัดทำแผนการสอนวิชาเบื้องต้น และเข้าสอนตรงเวลาทุกคาบ"]', 3, 'ครูบรรจุใหม่ กำลังเรียนรู้และพัฒนาเทคนิคการถ่ายทอดความรู้', 'https://drive.google.com/drive/folders/1Nattaporn-Lesson'),
(20, 1, 18, 1, '["จัดการเรียนการสอนวิชาเครือข่ายคอมพิวเตอร์ มีการฝึกปฏิบัติจริงในห้อง Lab","นักเรียนสร้างโมเดลเครือข่ายเสมือนจริงผ่าน Cisco Packet Tracer"]', 3.5, 'เน้นการลงมือปฏิบัติจริง นักเรียนมีความรู้ความเข้าใจในเชิงลึก', 'https://github.com/duangjai/smart-classroom-iot'),
(21, 1, 18, 2, '["พัฒนาชุดอุปกรณ์ IoT จำลอง Smart Farming เพื่อการศึกษา","นำไปจัดแสดงในนิทรรศการผลงานสิ่งประดิษฐ์ของวิทยาลัย"]', 3.5, 'ชิ้นงานทำงานได้จริง และมีคู่มือการประกอบอย่างละเอียด', 'https://drive.google.com/drive/folders/1Duangjai-IoT-Project'),
(22, 1, 18, 3, '["เข้าร่วมกิจกรรมและประสานงานความร่วมมือกับภาคเอกชน (ทวิภาคี)","นิเทศติดตามนักศึกษาฝึกงานในสถานประกอบการครบ 100%"]', 4, 'สร้างเครือข่ายความร่วมมือที่ดีกับสถานประกอบการ นักศึกษาได้รับการชื่นชม', 'https://sites.google.com/view/duangjai-dve'),
(23, 1, 18, 4, '["รักษาวินัยการมาทำงาน และมีจิตสำนึกที่ดีในการให้บริการทางวิชาชีพ"]', 1, 'ไม่เคยมีข้อร้องเรียนด้านวินัยหรือพฤติกรรม', NULL),
(24, 1, 19, 1, '["แผนการสอนรายวิชาบัญชีเบื้องต้น ครอบคลุมมาตรฐานและตรงตามคำอธิบายรายวิชา","มีใบงาน แบบฝึกปฏิบัติ และสื่ออินโฟกราฟิกสรุปแต่ละบทเรียน"]', 3.5, 'ผู้เรียนเข้าใจเนื้อหาที่มีความซับซ้อนได้ง่ายขึ้น มีผลการสอบผ่านเกณฑ์ 90%', 'https://drive.google.com/drive/folders/1Rattana-Accounting-Plan'),
(25, 1, 19, 2, '["จัดทำบทเรียน e-Learning รายวิชาภาษีอากรเพื่อธุรกิจ","เอกสารประกอบการสอนได้รับการกลั่นกรองจากผู้เชี่ยวชาญ"]', 3, 'ระบบออนไลน์เปิดให้ผู้เรียนทบทวนได้ตลอด 24 ชั่วโมง', 'https://sites.google.com/view/rattana-tax-elearning'),
(26, 1, 19, 3, '["ให้ความช่วยเหลือครูในแผนกและช่วยเหลืองานตรวจข้อสอบกลาง","ปฏิบัติหน้าที่อาจารย์ที่ปรึกษา ดูแลนักเรียนอย่างใกล้ชิด"]', 3.5, 'ดูแลเอาใจใส่ผู้เรียนทั้งด้านการเรียนและการดำเนินชีวิต', NULL),
(27, 1, 19, 4, '["ปฏิบัติตามระเบียบของทางราชการ ไม่ขาด ไม่สาย มีเวลาสอนครบถ้วน"]', 1, 'มีความซื่อสัตย์และรักษาจรรยาบรรณทางวิชาชีพ', NULL),
(28, 1, 21, 1, '["จัดการเรียนการสอนวิชาภาษาอังกฤษเพื่อการสื่อสารในการทำงาน","นำแอปพลิเคชันฝึกภาษา Duolingo และ Quizlet มาเสริมทักษะ"]', 4, 'นักเรียนมีพัฒนาการด้านการสื่อสารภาษาอังกฤษอย่างเห็นได้ชัด กล้าแสดงออกมากขึ้น', 'https://drive.google.com/drive/folders/1Wilaiwan-EnglishClass'),
(29, 1, 21, 2, '["เขียนบทความวิชาการเรื่อง เทคนิคการจัดการเรียนรู้วิชาภาษาต่างประเทศ","ได้รับคัดเลือกให้นำเสนอในงานประชุมวิชาการระดับสถาบัน"]', 3.5, 'สร้างผลงานวิชาการเพื่อต่อยอดการเรียนรู้และยกระดับมาตรฐานการศึกษา', 'https://sites.google.com/view/wilaiwan-portfolio'),
(30, 1, 21, 3, '["ทำหน้าที่หัวหน้างานประชาสัมพันธ์ของวิทยาลัย ดูแลสื่อสังคมออนไลน์","จัดทำสื่อประชาสัมพันธ์ภาพลักษณ์สถานศึกษาอย่างต่อเนื่อง"]', 4, 'มีผลงานประชาสัมพันธ์เชิงรุก ยอดผู้ติดตามเพจวิทยาลัยเพิ่มขึ้นกว่า 30%', 'https://facebook.com/college-pr-team'),
(31, 1, 21, 4, '["ปฏิบัติงานด้วยความตั้งใจและมีวินัย อุทิศตนเพื่องานราชการ"]', 1, 'ไม่มีประวัติการมาสายหรือขาดงาน เป็นตัวอย่างที่ดีแก่เพื่อนครูและนักเรียน', NULL),
(32, 1, 22, 1, '["แผนการจัดการเรียนรู้รายวิชาการออกแบบกราฟิกและสื่อดิจิทัล","ใช้กระบวนการ Design Thinking ให้นักเรียนฝึกคิดและผลิตสื่อสร้างสรรค์"]', 4, 'นักเรียนมีผลงานการออกแบบที่สามารถนำไปใช้งานจริงในการโปรโมทกิจกรรมของวิทยาลัย', 'https://drive.google.com/drive/folders/1Cholticha-DesignThinking'),
(33, 1, 22, 2, '["นำนักเรียนส่งผลงานเข้าประกวดคลิปสั้นรณรงค์ระดับจังหวัด ได้รับรางวัลรองชนะเลิศ","ร่วมทำวิจัยสถาบันเรื่องพฤติกรรมการเสพสื่อดิจิทัลของวัยรุ่น"]', 3.5, 'ผลงานนักเรียนได้รับเกียรติบัตรและเงินรางวัล และงานวิจัยมีข้อมูลเชิงประจักษ์', 'https://youtube.com/watch?v=short_clip_award_2026'),
(34, 1, 22, 3, '["อุทิศเวลาเพื่อกิจกรรมชมรมศิลปะและการออกแบบ ให้คำปรึกษาแก่นักเรียนนอกเวลาสอน","ร่วมมือกับหน่วยงานภายนอกจัดเวิร์กชอปแก่นักศึกษา"]', 4, 'นักเรียนมีความรักในวิชาชีพ มีความสัมพันธ์อันดีและทัศนคติที่ดีต่อสถานศึกษา', 'https://padlet.com/cholticha/student_art_gallery'),
(35, 1, 22, 4, '["รักษาวินัยการมาปฏิบัติงานอย่างสมบูรณ์แบบ ไม่เคยลาป่วยหรือลากิจเกินกำหนด"]', 1, 'ประพฤติตนเหมาะสมตามระเบียบข้าราชการและจรรยาบรรณวิชาชีพ', NULL),
(36, 1, 23, 1, '["จัดทำแผนการสอนวิชางานระบบปรับอากาศและทำความเย็น","เน้นความปลอดภัยในการปฏิบัติงานในโรงฝึกงาน (Safety First)"]', 3.5, 'ควบคุมดูแลการปฏิบัติงานในโรงฝึกงานอย่างเข้มงวด ไม่มีอุบัติเหตุเกิดขึ้นตลอดภาคเรียน', 'https://drive.google.com/drive/folders/1Panumas-HVAC-Plan'),
(37, 1, 23, 2, '["จัดทำคู่มือและวีดีโอสาธิตการตรวจซ่อมเครื่องปรับอากาศระบบอินเวอร์เตอร์"]', 3, 'ใช้เป็นสื่อเสริมสำหรับนักเรียนที่ต้องการทบทวนขั้นตอนการทำงานจริง', 'https://youtube.com/watch?v=hvac_inverter_repair'),
(38, 2, 12, 5, '["เตรียมร่างแผนการสอนบูรณาการสู่ศตวรรษที่ 21 สำหรับรอบที่ 2","เน้นทักษะการคิดวิเคราะห์และการแก้ปัญหาทางเทคโนโลยี"]', 4, 'เตรียมความพร้อมเอกสารและสื่อการสอนล่วงหน้าเรียบร้อยแล้ว', 'https://drive.google.com/drive/folders/1Sunisa-Round2-Plan21'),
(39, 2, 12, 6, '["โครงการพัฒนาเว็บไซต์แนะนำสถานที่ท่องเที่ยวของชุมชนท้องถิ่น"]', 3.5, 'นำนักเรียนลงพื้นที่เก็บข้อมูลเพื่อฝึกทักษะการบริการวิชาการแก่สังคม', 'https://sites.google.com/view/local-community-tourism'),
(40, 2, 15, 5, '["จัดทำสื่อการสอนแบบ interactive simulation สำหรับวิชาวิทยาศาสตร์ประยุกต์"]', 4, 'นักเรียนสามารถทดลองเสมือนจริงผ่านเว็บบราวเซอร์ได้ทุกที่ทุกเวลา', 'https://drive.google.com/drive/folders/1Ploy-SimulationLab'),
(41, 2, 15, 6, '["จัดกิจกรรมค่ายวิทยาศาสตร์สัญจรสู่โรงเรียนประถมศึกษาในเขตพื้นที่"]', 3.5, 'เผยแพร่ความรู้และสร้างแรงบันดาลใจด้านสะเต็มศึกษาแก่นักเรียนรุ่นเยาว์', 'https://facebook.com/science-camp-tour'),
(42, 2, 15, 7, '["เข้ารับการอบรมหลักสูตรผู้นำการเปลี่ยนแปลงด้านการศึกษาดิจิทัล 30 ชั่วโมง"]', 4, 'ได้รับวุฒิบัตรและนำองค์ความรู้มาขยายผลภายในแผนกวิชา', NULL),
(43, 3, 12, 9, '["จัดทำหลักสูตรรายวิชาการพัฒนาแอปพลิเคชันบนคลาวด์ สอดคล้องกับมาตรฐานอาชีพสากล","ออกแบบโครงสร้างหน่วยการเรียนรู้และเกณฑ์การวัดผลแบบ Rubric"]', 4, 'หลักสูตรได้รับการอนุมัติและนำมาใช้จัดการเรียนการสอนจริง มีผู้ทรงคุณวุฒิรับรอง', 'https://drive.google.com/drive/folders/1PA-Sunisa-Domain1'),
(44, 3, 12, 10, '["จัดตั้งกลุ่มชุมชนการเรียนรู้ทางวิชาชีพ (PLC) หัวข้อ การจัดการเรียนรู้ด้วยโครงงานเป็นฐาน","บันทึกการประชุม PLC จำนวน 10 ครั้ง มีการสะท้อนผลและปรับปรุงการสอนจริง"]', 3.5, 'กระบวนการ PLC ช่วยให้ครูในแผนกพัฒนารูปแบบการสอนและแก้ปัญหาการเรียนได้ตรงจุด', 'https://drive.google.com/file/d/1PA-PLC-Summary-2567/view'),
(45, 3, 12, 11, '["เข้าร่วมอบรมออนไลน์หลักสูตร Certified Cloud Developer 60 ชั่วโมง","จัดทำแผนพัฒนาตนเอง (ID Plan) และปฏิบัติตามแผนครบถ้วน"]', 4, 'สอบผ่านใบรับรองมาตรฐานวิชาชีพ และนำมาพัฒนาวิชาการให้กับสถานศึกษา', NULL),
(46, 3, 12, 12, '["ประเด็นท้าทาย: การพัฒนาผลสัมฤทธิ์ทางการเรียนวิชาพัฒนาเว็บไซต์ด้วยโครงงานจริง","นักเรียนร้อยละ 85 มีคะแนนผลสัมฤทธิ์ผ่านเกณฑ์ดีขึ้นกว่าภาคเรียนก่อนอย่างมีนัยสำคัญ"]', 1, 'บรรลุข้อตกลงในการพัฒนางานตามประเด็นท้าทายที่ได้ทำไว้กับผู้อำนวยการวิทยาลัย', 'https://github.com/sunisa-kru/pa-challenge-report'),
(47, 3, 15, 9, '["สร้างชุดการเรียนรู้วิทยาศาสตร์สะเต็มศึกษา (STEM) เชื่อมโยงบริบทสิ่งแวดล้อม","แผนการจัดการเรียนรู้ได้รับการประเมินระดับดีเด่นจากคณะกรรมการ"]', 4, 'ผลสัมฤทธิ์และผลงานนวัตกรรมของผู้เรียนได้รับการยอมรับในระดับภูมิภาค', 'https://drive.google.com/drive/folders/1PA-Ploy-STEM-Plan'),
(48, 3, 15, 10, '["ระบบดูแลช่วยเหลือนักเรียนผ่านแอปพลิเคชัน Line Official และการเยี่ยมบ้านแบบออนไลน์","ให้คำปรึกษาและช่วยเหลือนักเรียนกลุ่มเสี่ยงจนสำเร็จการศึกษาได้ทุกคน"]', 4, 'มีระบบติดตามที่เข้าถึงง่าย นักเรียนและผู้ปกครองมีความพึงพอใจสูงมาก', 'https://drive.google.com/file/d/1LineOA-StudentCare/view'),
(49, 3, 15, 11, '["เข้าร่วมการประชุมวิชาการระดับชาติด้านการศึกษา และนำเสนอผลงานวิจัย","ได้รับรางวัลครูผู้นำนวัตกรรมการสอนดีเด่น ประจำปี 2567"]', 4, 'มุ่งมั่นพัฒนาตนเองอย่างต่อเนื่องเพื่อเป็นแบบอย่างที่ดีในการจัดการศึกษา', NULL),
(50, 3, 15, 12, '["ประเด็นท้าทาย: การยกระดับผลสัมฤทธิ์ด้านการคิดเชิงนวัตกรรมผ่านกิจกรรมโครงงานสะเต็มศึกษา"]', 1, 'นักเรียนทุกคนสร้างชิ้นงานนวัตกรรมและสามารถนำเสนอได้อย่างเชี่ยวชาญ', 'https://youtube.com/watch?v=ploy_stem_challenge_doc'),
(51, 3, 18, 9, '["พัฒนาหลักสูตรรายวิชาอินเทอร์เน็ตของสรรพสิ่ง (IoT) สำหรับงานอุตสาหกรรม"]', 3.5, 'นักเรียนได้เรียนรู้การเชื่อมต่อ Sensor กับ Cloud Platform', 'https://drive.google.com/drive/folders/1PA-Duangjai-IoT-Plan'),
(52, 3, 18, 10, '["สร้างระบบติดตามความก้าวหน้าโครงงานนักศึกษาผ่าน GitHub Classroom","เปิดช่องทางแลกเปลี่ยนเรียนรู้ระหว่างครูและศิษย์เก่าในสายงาน"]', 3.5, 'นักศึกษาได้รับการตรวจโค้ดและรับคำแนะนำอย่างรวดเร็ว', 'https://github.com/duangjai/pa-class-monitoring'),
(53, 3, 18, 11, '["ผ่านการสอบใบรับรอง Network Associate และอบรมมาตรฐานความปลอดภัยไซเบอร์"]', 4, 'นำความรู้มาอัปเดตหลักสูตรให้ทันกับภัยคุกคามทางเทคโนโลยีสมัยใหม่', NULL),
(54, 3, 18, 12, '["ประเด็นท้าทาย: การพัฒนาทักษะด้าน Cyber Security ในผู้เรียนระดับ ปวส."]นักเรียนทุกคนผ่านการทดสอบมาตรฐานความปลอดภัยพื้นฐาน', 1, 'บรรลุตัวชี้วัดท้าทายตามข้อตกลง PA ทุกประการ', 'https://drive.google.com/file/d/1CyberSecurity-ChallengeReport/view'),
(55, 4, 24, 13, '["จัดทำรายงานและสรุปข้อมูลงานสารบรรณอิเล็กทรอนิกส์ (e-Saraban) ประจำเดือน","ลงทะเบียนรับ-ส่งเอกสารราชการกว่า 1,200 ฉบับ รวดเร็ว ถูกต้อง ไร้ข้อผิดพลาด"]', 3.5, 'บริหารจัดการระบบสารบรรณอย่างมีประสิทธิภาพ ช่วยลดการใช้กระดาษในองค์กร', 'https://drive.google.com/drive/folders/1Thanadol-Support-Reports'),
(56, 4, 24, 14, '["พัฒนาระบบจองห้องประชุมและอุปกรณ์ออนไลน์ด้วย Google Apps Script","มีระบบแจ้งเตือนการจองผ่าน Line Notify อัตโนมัติ"]', 4, 'เพิ่มความสะดวกให้แก่บุคลากรในการจองห้องประชุม ลดความซ้ำซ้อนในการใช้สถานที่', 'https://github.com/thanadol/room-booking-automation'),
(57, 5, 17, 17, '["จัดทำแผนการสอนวิชาคอมพิวเตอร์และสารสนเทศเพื่องานอาชีพ","บันทึกการจัดกิจกรรมการเรียนรู้และสรุปผลหลังการสอน"]', 3.5, 'มีความตั้งใจในการเตรียมการสอน รับฟังคำแนะนำจากครูพี่เลี้ยงและปรับปรุงสม่ำเสมอ', 'https://drive.google.com/drive/folders/1Nattaporn-TeacherAssistant'),
(58, 5, 17, 18, '["ร่วมปฏิบัติหน้าที่ครูเวรประจำวัน ควบคุมแถวนักเรียน และดูแลความเรียบร้อย","เข้าร่วมกิจกรรมวันสำคัญของวิทยาลัยและงานบริการชุมชนครบทุกครั้ง"]', 4, 'มีความเสียสละ อุทิศเวลาและให้ความร่วมมือกับงานส่วนรวมเป็นอย่างดี', NULL);

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
(1, 1, 'แผนการจัดการเรียนรู้บูรณาการ_2567.pdf', 'uploads/evidence/lesson_plan_12_1.pdf', 'application/pdf', 2458900),
(2, 1, 'รูปถ่ายกิจกรรมการเรียนการสอน.jpg', 'uploads/evidence/teaching_act_12_1.jpg', 'image/jpeg', 1542000),
(3, 1, 'ใบสรุปผลการประเมินนักเรียน.pdf', 'uploads/evidence/student_eval_12_1.pdf', 'application/pdf', 890400),
(4, 2, 'บทความวิจัย_ฉบับสมบูรณ์_2567.pdf', 'uploads/evidence/research_paper_12_2.pdf', 'application/pdf', 4890120),
(5, 2, 'หนังสือรับรองการตีพิมพ์ผลงาน.pdf', 'uploads/evidence/publication_cert_12_2.pdf', 'application/pdf', 720500),
(6, 3, 'เกียรติบัตรครูดีเด่น_วิทยาลัย.pdf', 'uploads/evidence/cert_12_3.pdf', 'application/pdf', 1120400),
(7, 3, 'คำสั่งแต่งตั้งหัวหน้างานหลักสูตร.pdf', 'uploads/evidence/appoint_order_12_3.pdf', 'application/pdf', 654200),
(8, 4, 'ใบรายงานสถิติเวลาปฏิบัติงาน_100เปอร์เซ็นต์.pdf', 'uploads/evidence/attendance_12_4.pdf', 'application/pdf', 890300),
(9, 5, 'แผนการสอนวิชาเขียนโปรแกรมมือถือ.pdf', 'uploads/evidence/plan_prog_13_1.pdf', 'application/pdf', 1980000),
(10, 5, 'ภาพชิ้นงานแอปพลิเคชันของนักเรียน.jpg', 'uploads/evidence/student_app_13_1.jpg', 'image/jpeg', 2340000),
(11, 6, 'เอกสารสรุปยอดผู้เข้าชมสื่อออนไลน์.pdf', 'uploads/evidence/youtube_analytics_13_2.pdf', 'application/pdf', 1230000),
(12, 7, 'คำสั่งปฏิบัติงานฝ่ายวิชาการและทะเบียน.pdf', 'uploads/evidence/order_academic_13_3.pdf', 'application/pdf', 540000),
(13, 8, 'รายงานประวัติการลาประจำปี.pdf', 'uploads/evidence/leave_record_13_4.pdf', 'application/pdf', 430000),
(14, 9, 'โครงร่างแผนการสอนรายวิชากราฟิกส์.pdf', 'uploads/evidence/draft_plan_14_1.pdf', 'application/pdf', 1150000),
(15, 11, 'สรุปผลสัมฤทธิ์ทางการเรียน_94เปอร์เซ็นต์.pdf', 'uploads/evidence/grade_summary_15_1.pdf', 'application/pdf', 1204000),
(16, 11, 'ภาพบรรยากาศการสอนแบบGamification.jpg', 'uploads/evidence/gamification_act_15_1.jpg', 'image/jpeg', 3120000),
(17, 12, 'เกียรติบัตรรางวัลชนะเลิศสิ่งประดิษฐ์.pdf', 'uploads/evidence/invention_award_15_2.pdf', 'application/pdf', 3410000),
(18, 12, 'เล่มรายงานโครงงานสิ่งประดิษฐ์คนรุ่นใหม่.pdf', 'uploads/evidence/project_book_15_2.pdf', 'application/pdf', 8920000),
(19, 13, 'ภาพการเป็นวิทยากรบรรยายการใช้AI.jpg', 'uploads/evidence/speaker_ai_15_3.jpg', 'image/jpeg', 2140000),
(20, 14, 'สถิติการมาปฏิบัติราชการ_อ_พลอยไพลิน.pdf', 'uploads/evidence/attendance_15_4.pdf', 'application/pdf', 670000),
(21, 15, 'แผนการจัดการเรียนรู้คณิตศาสตร์คอมพิวเตอร์.pdf', 'uploads/evidence/math_plan_16_1.pdf', 'application/pdf', 1850000),
(22, 16, 'ชุดแบบฝึกหัดพัฒนาทักษะการคำนวณ.pdf', 'uploads/evidence/exercise_book_16_2.pdf', 'application/pdf', 2900000),
(23, 17, 'รายงานสรุปการเงินและพัสดุแผนกวิชา.pdf', 'uploads/evidence/finance_report_16_3.pdf', 'application/pdf', 1450000),
(24, 18, 'หนังสือรับรองความประพฤติและวินัย.pdf', 'uploads/evidence/conduct_cert_16_4.pdf', 'application/pdf', 410000),
(25, 19, 'แผนการสอนครูผู้ช่วย_ณัฐพร.pdf', 'uploads/evidence/assistant_plan_17_1.pdf', 'application/pdf', 1650000),
(26, 20, 'แผนการสอนระบบเครือข่าย_IoT.pdf', 'uploads/evidence/network_plan_18_1.pdf', 'application/pdf', 2300000),
(27, 20, 'ภาพผลงานLab_PacketTracer.jpg', 'uploads/evidence/packet_tracer_lab_18_1.jpg', 'image/jpeg', 1890000),
(28, 21, 'คู่มือชุดอุปกรณ์SmartFarming_IoT.pdf', 'uploads/evidence/smart_farm_manual_18_2.pdf', 'application/pdf', 4200000),
(29, 22, 'สมุดนิเทศนักศึกษาฝึกงานทวิภาคี.pdf', 'uploads/evidence/dve_supervision_18_3.pdf', 'application/pdf', 1980000),
(30, 24, 'แผนการสอนวิชาการบัญชีเบื้องต้น.pdf', 'uploads/evidence/acc_plan_19_1.pdf', 'application/pdf', 2100000),
(31, 28, 'แผนการสอนวิชาภาษาอังกฤษเพื่อการสื่อสาร.pdf', 'uploads/evidence/english_plan_21_1.pdf', 'application/pdf', 2250000),
(32, 29, 'บทความวิชาการภาษาต่างประเทศ.pdf', 'uploads/evidence/english_article_21_2.pdf', 'application/pdf', 1340000),
(33, 30, 'รายงานผลการประชาสัมพันธ์วิทยาลัย.pdf', 'uploads/evidence/pr_report_21_3.pdf', 'application/pdf', 3890000),
(34, 32, 'แผนการสอนวิชาการออกแบบกราฟิก.pdf', 'uploads/evidence/graphic_plan_22_1.pdf', 'application/pdf', 2780000),
(35, 33, 'เกียรติบัตรรางวัลการประกวดคลิปสั้น.pdf', 'uploads/evidence/short_clip_cert_22_2.pdf', 'application/pdf', 980000),
(36, 43, 'เอกสารหลักสูตรวิชาCloudApplication_PA.pdf', 'uploads/evidence/pa_cloud_doc_12_9.pdf', 'application/pdf', 5400000),
(37, 44, 'รายงานสรุปผลกระบวนการPLC_PA.pdf', 'uploads/evidence/pa_plc_report_12_10.pdf', 'application/pdf', 3100000),
(38, 45, 'ใบรับรองCertifiedCloudDeveloper.pdf', 'uploads/evidence/cloud_cert_12_11.pdf', 'application/pdf', 1250000),
(39, 46, 'รายงานผลการแก้ปัญหาประเด็นท้าทาย_PA.pdf', 'uploads/evidence/pa_challenge_full_12_12.pdf', 'application/pdf', 6800000),
(40, 47, 'เล่มหลักสูตรSTEMสะเต็มศึกษา_PA.pdf', 'uploads/evidence/pa_stem_doc_15_9.pdf', 'application/pdf', 4900000),
(41, 48, 'รายงานระบบดูแลช่วยเหลือนักเรียน_PA.pdf', 'uploads/evidence/pa_student_care_15_10.pdf', 'application/pdf', 2700000),
(42, 50, 'รายงานผลประเด็นท้าทายนวัตกรรมสะเต็ม_PA.pdf', 'uploads/evidence/pa_ploy_challenge_15_12.pdf', 'application/pdf', 5600000),
(43, 55, 'สถิติการรับส่งหนังสือราชการ_eSaraban.pdf', 'uploads/evidence/esaraban_stats_24_13.pdf', 'application/pdf', 1540000),
(44, 56, 'คู่มือระบบจองห้องประชุมออนไลน์.pdf', 'uploads/evidence/room_booking_guide_24_14.pdf', 'application/pdf', 2150000),
(45, 57, 'สมุดบันทึกการพัฒนาอย่างเข้มครูผู้ช่วย.pdf', 'uploads/evidence/assistant_logbook_17_17.pdf', 'application/pdf', 3800000);

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
(1, 1, 1, 4),
(2, 1, 2, 3.8),
(3, 1, 3, 4),
(4, 1, 4, 1),
(5, 2, 1, 3.8),
(6, 2, 2, 3.7),
(7, 2, 3, 3.9),
(8, 2, 4, 1),
(9, 3, 1, 3.5),
(10, 3, 2, 3.2),
(11, 3, 3, 3.5),
(12, 3, 4, 1),
(13, 4, 1, 3.5),
(14, 4, 2, 3),
(15, 7, 1, 4),
(16, 7, 2, 4),
(17, 7, 3, 3.8),
(18, 7, 4, 1),
(19, 8, 1, 4),
(20, 8, 2, 4),
(21, 8, 3, 3.9),
(22, 8, 4, 1),
(23, 9, 1, 3.6),
(24, 9, 2, 3.2),
(25, 9, 3, 3.5),
(26, 9, 4, 1),
(27, 10, 1, 3.5),
(28, 10, 2, 3),
(29, 13, 1, 3.6),
(30, 13, 2, 3.5),
(31, 13, 3, 3.8),
(32, 13, 4, 1),
(33, 14, 1, 3.5),
(34, 14, 2, 3.6),
(35, 14, 3, 3.7),
(36, 14, 4, 1),
(37, 15, 1, 3.5),
(38, 15, 2, 3.2),
(39, 15, 3, 3.5),
(40, 15, 4, 1),
(41, 16, 1, 3.6),
(42, 16, 2, 3.1),
(43, 16, 3, 3.6),
(44, 16, 4, 1),
(45, 19, 1, 4),
(46, 19, 2, 3.8),
(47, 19, 3, 4),
(48, 19, 4, 1),
(49, 20, 1, 3.9),
(50, 20, 2, 3.7),
(51, 20, 3, 4),
(52, 20, 4, 1),
(53, 21, 1, 4),
(54, 21, 2, 3.7),
(55, 21, 3, 4),
(56, 21, 4, 1),
(57, 22, 1, 3.8),
(58, 22, 2, 3.6),
(59, 22, 3, 3.9),
(60, 22, 4, 1),
(61, 23, 1, 3.5),
(62, 23, 2, 3),
(63, 33, 9, 4),
(64, 33, 10, 3.8),
(65, 33, 11, 4),
(66, 33, 12, 1),
(67, 34, 9, 3.9),
(68, 34, 10, 3.7),
(69, 34, 11, 4),
(70, 34, 12, 1),
(71, 35, 9, 4),
(72, 35, 10, 4),
(73, 35, 11, 4),
(74, 35, 12, 1),
(75, 36, 9, 4),
(76, 36, 10, 3.9),
(77, 36, 11, 4),
(78, 36, 12, 1),
(79, 37, 9, 3.7),
(80, 37, 10, 3.6),
(81, 37, 11, 3.9),
(82, 37, 12, 1),
(83, 38, 9, 3.6),
(84, 38, 10, 3.6),
(85, 38, 11, 3.8),
(86, 38, 12, 1),
(87, 39, 13, 3.6),
(88, 39, 14, 3.8),
(89, 41, 17, 3.5),
(90, 41, 18, 3.8);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
