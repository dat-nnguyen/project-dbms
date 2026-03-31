CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

CREATE TABLE deparments (
    department_id VARCHAR(10) PRIMARY KEY,
    deparment_name varchar(100) NOT NULL,
    established_year YEAR,
    location VARCHAR(100)
);

CREATE TABLE major (
    major_id VARCHAR(10) PRIMARY KEY,
    major_name VARCHAR(100) NOT NULL,
    department_id VARCHAR(10),
    FOREIGN KEY (department_id) REFERENCES deparments(department_id)
);

CREATE TABLE student (
    student_id VARCHAR(15) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    status ENUM('Studying', 'Graduated', 'Suspended', 'Dropped Out'),
    enrollment_year YEAR,
    major_id VARCHAR(10),
    gpa FLOAT DEFAULT 0.0,
    FOREIGN KEY (major_id) REFERENCES major(major_id),
    INDEX idx_full_name (full_name) 
);

CREATE TABLE lecturer (lecturer_id VARCHAR(15) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    department_id VARCHAR(10),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    department_id VARCHAR(10),
    FOREIGN KEY (department_id) REFERENCES deparments(department_id)
);

CREATE TABLE course_section (
    section_id VARCHAR(20) PRIMARY KEY,
    course_id VARCHAR(10),
    semester INT,
    academic_year YEAR,
    max_capacity INT DEFAULT 40,
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE teaching_assignment (
    lecturer_id VARCHAR(15),
    section_id VARCHAR(20),
    PRIMARY KEY (lecturer_id, section_id),
    FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id),
    FOREIGN KEY (section_id) REFERENCES course_section(section_id)
);