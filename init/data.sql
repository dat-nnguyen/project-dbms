-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `class_id` varchar(15) NOT NULL,
  `class_name` varchar(45) NOT NULL,
  `major_id` varchar(15) NOT NULL,
  `academic_year` varchar(20) DEFAULT NULL,
  `advisor_teacher_id` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  KEY `fk_classes_majors_idx` (`major_id`),
  KEY `fk_classes_lecturers_idx` (`advisor_teacher_id`),
  CONSTRAINT `fk_classes_lecturers` FOREIGN KEY (`advisor_teacher_id`) REFERENCES `lecturers` (`lecturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_classes_majors` FOREIGN KEY (`major_id`) REFERENCES `majors` (`major_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES ('L01','CNTT K18A','N01','2022-2026','GV001'),('L02','CNTT K18B','N01','2022-2026','GV002'),('L03','KTPM K18A','N02','2022-2026','GV003'),('L04','ATTT K18A','N03','2022-2026','GV001'),('L05','QTKD K18A','N04','2022-2026','GV004'),('L06','KT K18A','N05','2022-2026','GV005'),('L07','Dien K18A','N07','2022-2026','GV006'),('L08','NNA K18A','N09','2022-2026','GV008');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_sections`
--

DROP TABLE IF EXISTS `course_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_sections` (
  `section_id` varchar(15) NOT NULL,
  `course_id` varchar(15) NOT NULL,
  `lecturer_id` varchar(15) NOT NULL,
  `semester` varchar(5) NOT NULL,
  `academic_year` varchar(20) NOT NULL,
  `section_name` varchar(50) DEFAULT NULL,
  `room` varchar(10) DEFAULT NULL,
  `schedule` varchar(100) DEFAULT NULL,
  `max_students` int(11) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `fk_course_sections_courses_idx` (`course_id`),
  KEY `fk_course_sections_lecturers_idx` (`lecturer_id`),
  CONSTRAINT `fk_course_sections_courses` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_sections_lecturers` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_sections`
--

LOCK TABLES `course_sections` WRITE;
/*!40000 ALTER TABLE `course_sections` DISABLE KEYS */;
INSERT INTO `course_sections` VALUES ('HP001','MH001','GV001','HK1','2024-2025','CSDL 01','A101','Thu 2 - Tiet 1-3',60),('HP002','MH002','GV002','HK1','2024-2025','Java 01','A102','Thu 3 - Tiet 1-3',55),('HP003','MH003','GV003','HK1','2024-2025','MMT 01','A201','Thu 4 - Tiet 4-6',50),('HP004','MH004','GV001','HK2','2024-2025','AI 01','A301','Thu 5 - Tiet 1-3',45),('HP005','MH005','GV004','HK1','2024-2025','QTH 01','B101','Thu 2 - Tiet 7-9',70),('HP006','MH006','GV005','HK1','2024-2025','KTTC 01','B102','Thu 3 - Tiet 4-6',65),('HP007','MH007','GV004','HK2','2024-2025','Marketing 01','B201','Thu 6 - Tiet 1-3',60),('HP008','MH008','GV006','HK1','2024-2025','Mach dien 01','C101','Thu 4 - Tiet 1-3',40),('HP009','MH009','GV007','HK2','2024-2025','Dien tu 01','C102','Thu 5 - Tiet 4-6',40),('HP010','MH010','GV008','HK1','2024-2025','TA giao tiep 01','D101','Thu 7 - Tiet 1-3',80);
/*!40000 ALTER TABLE `course_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `course_id` varchar(15) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credits` int(11) NOT NULL,
  `faculty_id` varchar(15) NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `fk_courses_faculties_idx` (`faculty_id`),
  CONSTRAINT `fk_courses_faculties` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`faculty_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('MH001','Co so du lieu',3,'K01'),('MH002','Lap trinh Java',3,'K01'),('MH003','Mang may tinh',3,'K01'),('MH004','Tri tue nhan tao',3,'K01'),('MH005','Quan tri hoc',3,'K02'),('MH006','Ke toan tai chinh',3,'K02'),('MH007','Marketing can ban',2,'K02'),('MH008','Mach dien',3,'K03'),('MH009','Dien tu co ban',3,'K03'),('MH010','Tieng Anh giao tiep',2,'K04');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(15) NOT NULL,
  `section_id` varchar(15) NOT NULL,
  `enrollment_date` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  UNIQUE KEY `uq_students_sections` (`student_id`,`section_id`),
  KEY `fk_enrollments_course_sections` (`section_id`),
  CONSTRAINT `fk_enrollments_course_sections` FOREIGN KEY (`section_id`) REFERENCES `course_sections` (`section_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollments_students` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES (1,'SV001','HP001','2024-08-20','Dang hoc'),(2,'SV001','HP002','2024-08-20','Dang hoc'),(3,'SV001','HP003','2024-08-20','Dang hoc'),(4,'SV002','HP001','2024-08-21','Dang hoc'),(5,'SV002','HP010','2024-08-21','Dang hoc'),(6,'SV003','HP002','2024-08-21','Dang hoc'),(7,'SV003','HP003','2024-08-21','Dang hoc'),(8,'SV004','HP001','2024-08-22','Dang hoc'),(9,'SV004','HP004','2024-08-22','Dang hoc'),(10,'SV005','HP002','2024-08-22','Dang hoc'),(11,'SV005','HP004','2024-08-22','Dang hoc'),(12,'SV006','HP001','2024-08-23','Dang hoc'),(13,'SV007','HP003','2024-08-23','Dang hoc'),(14,'SV008','HP004','2024-08-23','Dang hoc'),(15,'SV009','HP005','2024-08-24','Dang hoc'),(16,'SV009','HP007','2024-08-24','Dang hoc'),(17,'SV010','HP005','2024-08-24','Dang hoc'),(18,'SV011','HP006','2024-08-25','Dang hoc'),(19,'SV012','HP006','2024-08-25','Dang hoc'),(20,'SV013','HP008','2024-08-25','Dang hoc'),(21,'SV014','HP009','2024-08-26','Dang hoc'),(22,'SV015','HP010','2024-08-26','Dang hoc');
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculties` (
  `faculty_id` varchar(15) NOT NULL,
  `faculty_name` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `office_location` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES ('K01','Khoa Cong nghe thong tin','0238388881','Tang 3 - Toa A'),('K02','Khoa Kinh te','0238388882','Tang 2 - Toa B'),('K03','Khoa Dien - Dien tu','0238388883','Tang 4 - Toa C'),('K04','Khoa Ngoai ngu','0238388884','Tang 5 - Toa D');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `enrollment_id` int(11) NOT NULL,
  `attendance_score` decimal(4,2) DEFAULT NULL,
  `midterm_score` decimal(4,2) DEFAULT NULL,
  `final_score` decimal(4,2) DEFAULT NULL,
  `total_score` decimal(4,2) DEFAULT NULL,
  `letter_grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`grade_id`),
  UNIQUE KEY `enrollment_id_UNIQUE` (`enrollment_id`),
  CONSTRAINT `fk_grades_enrollments` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
INSERT INTO `grades` VALUES (1,1,9.00,8.50,8.00,8.40,'B+'),(2,2,8.00,7.50,8.50,8.00,'B'),(3,3,7.50,8.00,7.00,7.40,'B'),(4,4,9.50,9.00,8.50,8.90,'A'),(5,5,8.00,8.50,9.00,8.60,'B+'),(6,6,7.00,7.50,8.00,7.50,'B'),(7,7,8.00,7.00,7.50,7.50,'B'),(8,8,8.50,8.00,9.00,8.50,'B+'),(9,9,7.50,8.00,8.50,8.00,'B'),(10,10,9.00,8.50,9.50,9.00,'A'),(11,11,8.50,8.00,8.00,8.10,'B+'),(12,12,7.00,7.50,7.00,7.10,'C+'),(13,13,8.00,8.00,7.50,7.80,'B'),(14,14,9.00,9.00,8.50,8.80,'A'),(15,15,7.50,7.00,7.50,7.30,'B'),(16,16,8.00,8.50,8.00,8.10,'B+'),(17,17,8.50,8.00,8.50,8.30,'B+'),(18,18,7.00,7.50,8.00,7.50,'B'),(19,19,8.00,8.00,8.50,8.20,'B+'),(20,20,9.00,8.50,8.00,8.40,'B+'),(21,21,7.50,7.00,7.50,7.30,'B'),(22,22,8.50,9.00,8.50,8.70,'A');
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `lecturer_id` varchar(15) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `degree` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `faculty_id` varchar(15) NOT NULL,
  PRIMARY KEY (`lecturer_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_lecturers_faculties_idx` (`faculty_id`),
  CONSTRAINT `fk_lecturers_faculties` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`faculty_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES ('GV001','Nguyen Van An','Tien si','an@university.edu','0901000001','K01'),('GV002','Tran Thi Bich','Thac si','bich@university.edu','0901000002','K01'),('GV003','Le Minh Hoang','Tien si','hoang@university.edu','0901000003','K01'),('GV004','Pham Thu Ha','Thac si','ha@university.edu','0901000004','K02'),('GV005','Do Quang Huy','Tien si','huy@university.edu','0901000005','K02'),('GV006','Ngo Thi Lan','Thac si','lan@university.edu','0901000006','K03'),('GV007','Vu Duc Long','Tien si','long@university.edu','0901000007','K03'),('GV008','Bui Minh Chau','Thac si','chau@university.edu','0901000008','K04');
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `majors`
--

DROP TABLE IF EXISTS `majors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `majors` (
  `major_id` varchar(15) NOT NULL,
  `major_name` varchar(100) NOT NULL,
  `faculty_id` varchar(15) NOT NULL,
  PRIMARY KEY (`major_id`),
  KEY `fk_majors_faculties_idx` (`faculty_id`),
  CONSTRAINT `fk_majors_faculties` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`faculty_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `majors`
--

LOCK TABLES `majors` WRITE;
/*!40000 ALTER TABLE `majors` DISABLE KEYS */;
INSERT INTO `majors` VALUES ('N01','Cong nghe thong tin','K01'),('N02','Ky thuat phan mem','K01'),('N03','An toan thong tin','K01'),('N04','Quan tri kinh doanh','K02'),('N05','Ke toan','K02'),('N06','Tai chinh ngan hang','K02'),('N07','Ky thuat dien','K03'),('N08','Ky thuat dieu khien','K03'),('N09','Ngon ngu Anh','K04');
/*!40000 ALTER TABLE `majors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` varchar(15) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `class_id` varchar(15) NOT NULL,
  `admission_year` int(11) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_students_classes_idx` (`class_id`),
  CONSTRAINT `fk_students_classes` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('SV001','Nguyen Hoang Minh','2004-01-15','Nam','sv001@university.edu','0911000001','Ha Noi','L01',2022,'Dang hoc'),('SV002','Tran Thu Trang','2004-03-21','Nu','sv002@university.edu','0911000002','Nghe An','L01',2022,'Dang hoc'),('SV003','Le Quoc Bao','2004-05-12','Nam','sv003@university.edu','0911000003','Da Nang','L02',2022,'Dang hoc'),('SV004','Pham Minh Anh','2004-06-18','Nu','sv004@university.edu','0911000004','Hai Phong','L02',2022,'Dang hoc'),('SV005','Do Gia Huy','2004-02-09','Nam','sv005@university.edu','0911000005','Thanh Hoa','L03',2022,'Dang hoc'),('SV006','Ngo Bao Chau','2004-07-01','Nu','sv006@university.edu','0911000006','Quang Binh','L03',2022,'Dang hoc'),('SV007','Vu Tuan Kiet','2004-04-10','Nam','sv007@university.edu','0911000007','Hue','L04',2022,'Dang hoc'),('SV008','Bui Ngoc Han','2004-09-22','Nu','sv008@university.edu','0911000008','Nam Dinh','L04',2022,'Dang hoc'),('SV009','Dang Duc Anh','2004-10-30','Nam','sv009@university.edu','0911000009','Ha Tinh','L05',2022,'Dang hoc'),('SV010','Nguyen Thi Yen','2004-11-11','Nu','sv010@university.edu','0911000010','Thai Binh','L05',2022,'Dang hoc'),('SV011','Tran Van Nam','2004-12-05','Nam','sv011@university.edu','0911000011','Ninh Binh','L06',2022,'Dang hoc'),('SV012','Le Thi Huong','2004-08-19','Nu','sv012@university.edu','0911000012','Ha Noi','L06',2022,'Dang hoc'),('SV013','Pham Quang Hieu','2004-03-15','Nam','sv013@university.edu','0911000013','Vinh','L07',2022,'Dang hoc'),('SV014','Doan Thu Phuong','2004-05-20','Nu','sv014@university.edu','0911000014','Da Nang','L07',2022,'Dang hoc'),('SV015','Ngo Minh Duc','2004-06-27','Nam','sv015@university.edu','0911000015','Quang Tri','L08',2022,'Dang hoc');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-12 10:14:31
