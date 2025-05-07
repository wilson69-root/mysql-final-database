# School Management System Database

This is a comprehensive database schema for a school management system. The database is designed to handle various aspects of school operations including student management, course management, attendance tracking, and more.

## Database Overview

The database consists of 15 tables that work together to manage all aspects of a school system:

1. `School` - Core school information
2. `Academic_Year_Term` - Academic terms and years
3. `Person` - Base table for all individuals
4. `Student` - Student-specific information
5. `Teacher` - Teacher-specific information
6. `Course` - Course catalog
7. `Location` - Physical locations and rooms
8. `Class_Section` - Specific class offerings
9. `Enrollment` - Student enrollments in classes
10. `Grade` - Student grades and assessments
11. `Attendance` - Student attendance records
12. `Parent_Guardian` - Parent/guardian information
13. `Student_Parent_Guardian` - Student-parent relationships

## Entity Relationship Diagram (ERD)

An Entity Relationship Diagram (ERD) has been provided in the `erd` directory. The ERD visually represents:
- All database tables and their relationships
- Primary and foreign key connections
- Cardinality between tables
- Entity attributes

The ERD is available in both PNG and PDF formats for easy viewing and printing.

## Table Relationships

### Core Entities
- `School` is the top-level entity
- `Person` serves as the base table for all individuals (students, teachers, parents)
- `Student`, `Teacher`, and `Parent_Guardian` extend `Person` with role-specific information

### Academic Structure
- `Academic_Year_Term` defines the academic calendar
- `Course` defines available courses
- `Class_Section` links courses to specific terms, teachers, and locations
- `Enrollment` connects students to class sections

### Student Records
- `Grade` tracks student performance
- `Attendance` monitors student presence
- `Student_Parent_Guardian` manages parent-student relationships

## Key Features

1. **Person Management**
   - Centralized person information
   - Role-based extensions (Student, Teacher, Parent)
   - Contact information tracking

2. **Academic Management**
   - Course catalog
   - Class scheduling
   - Term management
   - Grade tracking

3. **Attendance System**
   - Daily attendance tracking
   - Status tracking (Present, Absent, Late, Excused)
   - Notes for special circumstances

4. **Parent Communication**
   - Parent/guardian information
   - Student-parent relationships
   - Multiple guardians per student support

## Database Constraints

The database implements several important constraints:

1. **Primary Keys**
   - All tables have unique primary keys
   - Most use AUTO_INCREMENT for simplicity

2. **Foreign Keys**
   - Maintains referential integrity
   - Links related tables appropriately

3. **Unique Constraints**
   - Email addresses
   - Student ID numbers
   - Employee IDs
   - Room numbers

4. **Required Fields**
   - Essential information marked as NOT NULL
   - Appropriate default values where needed

## Usage Examples

### Finding a Student's Classes
```sql
SELECT c.course_name, cs.section_number, cs.schedule_time
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Class_Section cs ON e.class_id = cs.class_id
JOIN Course c ON cs.course_id = c.course_id
WHERE s.student_id = [student_id];
```

### Getting Student Grades
```sql
SELECT c.course_name, g.assignment_name, g.score, g.letter_grade
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Class_Section cs ON e.class_id = cs.class_id
JOIN Course c ON cs.course_id = c.course_id
JOIN Grade g ON e.enrollment_id = g.enrollment_id
WHERE s.student_id = [student_id];
```

### Checking Attendance
```sql
SELECT a.attendance_date, a.status, a.notes
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Attendance a ON e.enrollment_id = a.enrollment_id
WHERE s.student_id = [student_id]
ORDER BY a.attendance_date DESC;
```

## Maintenance

### Regular Tasks
1. Backup the database regularly
2. Monitor index performance
3. Archive old records as needed
4. Update academic terms annually

### Security Considerations
1. Implement proper access controls
2. Regular security audits
3. Data encryption for sensitive information
4. Regular backup verification

## Future Enhancements

Potential areas for future development:
1. Add support for extracurricular activities
2. Implement a messaging system
3. Add support for online learning
4. Enhance reporting capabilities
5. Add support for multiple schools

## Contributing

When contributing to this database schema:
1. Follow the existing naming conventions
2. Maintain referential integrity
3. Document all changes
4. Test thoroughly before implementation





