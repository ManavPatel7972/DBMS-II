--Lab-2 Stored Procedure

--Part – A 

------use CSE_4B_331


--1. INSERT Procedures: Create stored procedures to insert records into STUDENT tables 
--(SP_INSERT_STUDENT)
CREATE OR ALTER PROC PR_INSERT_STUDENT
@STUID INT,
@NAME VARCHAR(100),
@EMAIL VARCHAR(100),
@PHONE VARCHAR(15),
@DEPARTMENT VARCHAR(50),
@DOB DATE,
@ENROLLMENTYEAR INT
AS
BEGIN
	INSERT INTO STUDENT VALUES (@STUID,@NAME,@EMAIL,@PHONE,@DEPARTMENT,@DOB,@ENROLLMENTYEAR)
END

EXEC PR_INSERT_STUDENT 10,'HARSH PARMAR','HARSH@UNIV.EDU','9876543219','CSE','2005-09-18',2023

SELECT * FROM STUDENT

EXEC PR_INSERT_STUDENT 11,'OM PATEL','OM@UNIV.EDU','9876543210','IT','2002-08-22',2022



--2. INSERT Procedures: Create stored procedures to insert records into COURSE tables  
--(SP_INSERT_COURSE) 

CREATE PROCEDURE PR_INSERT_COURSE
    @CourseID VARCHAR(10),
    @CourseName VARCHAR(100),
    @CourseCredits INT,
    @CourseDepartment VARCHAR(50),
    @CourseSemester INT
AS
BEGIN
    INSERT INTO COURSE (CourseID, CourseName, CourseCredits, CourseDepartment, CourseSemester)
    VALUES (@CourseID, @CourseName, @CourseCredits, @CourseDepartment, @CourseSemester);
END;


EXEC PR_INSERT_COURSE 'CS330','Computer Networks', 4,'CSE', 5;

SELECT * FROM COURSE



--3. UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in 
--STUDENT table. (Update using studentID) 

CREATE PROCEDURE PR_UPDATE_STUDENT
    @StudentID INT,
    @StuEmail VARCHAR(100),
    @StuPhone VARCHAR(15)
AS
BEGIN
    UPDATE STUDENT
    SET 
        StuEmail = @StuEmail,
        StuPhone = @StuPhone
    WHERE 
        StudentID = @StudentID;
END;

EXEC PR_UPDATE_STUDENT 
    @StudentID = 11,
    @StuEmail = 'student11@gmail.com',
    @StuPhone = '9876543221';

SELECT * FROM STUDENT


--4. DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT 
--where Student Name is Om Patel.

CREATE PROCEDURE PR_DELETE_STUDENT
AS
BEGIN
    DELETE FROM STUDENT
    WHERE StuName = 'Om Patel';
END;

EXEC PR_DELETE_STUDENT;

SELECT * FROM STUDENT


--5. SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key 
--(SP_SELECT_STUDENT_BY_ID) from Student table. 
CREATE PROCEDURE PR_SELECT_STUDENT_BY_ID
    @StudentID INT
AS
BEGIN
    SELECT 
        StudentID,
        StuName,
        StuEmail,
        StuPhone,
        StuDepartment,
        StuDateOfBirth,
        StuEnrollmentYear
    FROM STUDENT
    WHERE StudentID = @StudentID;
END;

EXEC PR_SELECT_STUDENT_BY_ID 5;

SELECT * FROM STUDENT

--6. Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear. 
CREATE PROCEDURE PR_SELECT_TOP5_STUDENTS
AS
BEGIN
    SELECT TOP 5
        StudentID,
        StuName,
        StuEmail,
        StuPhone,
        StuDepartment,
        StuDateOfBirth,
        StuEnrollmentYear
    FROM STUDENT
    ORDER BY StuEnrollmentYear;
END;


EXEC PR_SELECT_TOP5_STUDENTS

--PART - B

--7. Create a stored procedure which displays faculty designation-wise count. 
SELECT * FROM FACULTY

CREATE PROCEDURE PR_FACULTY_COUNT_BY_DESIGNATION
AS
BEGIN
    SELECT 
        FacultyDesignation,
        COUNT(*) AS TotalFaculty
    FROM FACULTY
    GROUP BY FacultyDesignation;
END;

EXEC PR_FACULTY_COUNT_BY_DESIGNATION;


--8. Create a stored procedure that takes department name as input and returns all students in that 
--department.
SELECT * FROM STUDENT

CREATE PROCEDURE PR_GET_STUDENTS_BY_DEPARTMENT
    @DeptName VARCHAR(50)
AS
BEGIN
    SELECT 
        StudentID,
        StuName,
        StuEmail,
        StuPhone,
        StuDepartment,
        StuDateOfBirth,
        StuEnrollmentYear
    FROM STUDENT
    WHERE StuDepartment = @DeptName;
END;

EXEC PR_GET_STUDENTS_BY_DEPARTMENT 'CSE';


--9. Create a stored procedure which displays department-wise maximum, minimum, and average credits 
--of courses. 
SELECT * FROM STUDENT
SELECT * FROM COURSE

CREATE OR ALTER PROC PR_DEPARTMENTWISE_CREDITS
AS
BEGIN
    SELECT StuDepartment,MAX(C.CourseCredits) AS MaxCredit, MIN(C.CourseCredits) AS MinCredit, AVG(C.CourseCredits) AS AvgCredit
    FROM COURSE C 
    JOIN ENROLLMENT E ON C.CourseID = E.CourseID
    JOIN STUDENT S ON E.StudentID = S.StudentID
    GROUP BY StuDepartment
END


EXEC PR_DEPARTMENTWISE_CREDITS


--10. Create a stored procedure that accepts StudentID as parameter and returns all courses the student is 
--enrolled in with their grades.


CREATE PROCEDURE PR_GETSTUDENTCOURSESWITHGRADES
    @StudentID INT
AS
BEGIN
    SELECT 
        S.StudentID,
        S.StuName,
        C.CourseID,
        C.CourseName,
        C.CourseCredits,
        E.EnrollmentDate,
        E.Grade,
        E.EnrollmentStatus
    FROM ENROLLMENT E
     JOIN STUDENT S 
        ON E.StudentID = S.StudentID
     JOIN COURSE C 
        ON E.CourseID = C.CourseID
    WHERE S.StudentID = @StudentID;
END;

EXEC PR_GETSTUDENTCOURSESWITHGRADES 5

