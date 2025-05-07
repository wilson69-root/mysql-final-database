CREATE DATABASE School;

USE school;

-- Table for School
CREATE TABLE School (
    school_id INT PRIMARY KEY AUTO_INCREMENT,
    school_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    contact_phone VARCHAR(50),
    contact_email VARCHAR(100)
);

-- Table for Academic Year / Term
CREATE TABLE Academic_Year_Term (
    term_id INT PRIMARY KEY AUTO_INCREMENT,
    school_id INT NOT NULL,
    year INT NOT NULL,
    term_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (school_id) REFERENCES School(school_id)
);

-- Table for General Person Information
CREATE TABLE Person (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    phone_number VARCHAR(50),
    email_address VARCHAR(100) UNIQUE,
    person_type VARCHAR(50) NOT NULL
);

-- Table for Students (linking to Person)
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT UNIQUE NOT NULL,
    enrollment_date DATE,
    grade_level VARCHAR(50),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Table for Teachers (linking to Person)
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT UNIQUE NOT NULL,
    hire_date DATE,
    employee_id VARCHAR(50) UNIQUE,
    department VARCHAR(100),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Table for Courses offered
CREATE TABLE Course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(50) UNIQUE NOT NULL,
    course_name VARCHAR(255) NOT NULL,
    credits DECIMAL(4, 2),
    description TEXT
);

-- Table for Physical Locations
CREATE TABLE Location (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    building_name VARCHAR(100),
    room_number VARCHAR(50) UNIQUE NOT NULL,
    capacity INT
);

-- Table for Specific Class Sections offered in a Term
CREATE TABLE Class_Section (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    term_id INT NOT NULL,
    course_id INT NOT NULL,
    teacher_id INT,
    location_id INT,
    section_number VARCHAR(50) NOT NULL,
    schedule_time VARCHAR(255),
    max_students INT,
    FOREIGN KEY (term_id) REFERENCES Academic_Year_Term(term_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Table for Student Enrollments in Class Sections
CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (class_id) REFERENCES Class_Section(class_id),
    UNIQUE (student_id, class_id)
);

-- Table for Grades received by Students in Enrollments
CREATE TABLE Grade (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    assignment_name VARCHAR(255) NOT NULL,
    grade_type VARCHAR(50),
    score DECIMAL(5, 2),
    percentage DECIMAL(5, 2),
    letter_grade VARCHAR(10),
    grade_date DATE,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id)
);

-- Table for Student Attendance in Enrollments
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id),
    UNIQUE (enrollment_id, attendance_date)
);

-- Table for Parent or Guardian information (linking to Person)
CREATE TABLE Parent_Guardian (
    parent_guardian_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT UNIQUE NOT NULL,
    relationship_to_student VARCHAR(100),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);

-- Linking table for Students and Parents/Guardians (Many-to-Many relationship)
CREATE TABLE Student_Parent_Guardian (
    student_id INT NOT NULL,
    parent_guardian_id INT NOT NULL,
    PRIMARY KEY (student_id, parent_guardian_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (parent_guardian_id) REFERENCES Parent_Guardian(parent_guardian_id)
);