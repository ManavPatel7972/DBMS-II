--Lab-3 Advanced Stored Procedure 
-- Part – A 


--1. Create a stored procedure that accepts a date and returns all faculty members who joined on that 
--date. 

CREATE OR ALTER PROCEDURE PR_GetFacultyByJoiningDate
    @JoiningDate DATE
AS
BEGIN
    SELECT 
        FacultyID,
        FacultyName,
        FacultyEmail,
        FacultyDepartment,
        FacultyDesignation,
        FacultyJoiningDate
    FROM FACULTY
    WHERE FacultyJoiningDate = @JoiningDate;
END;

SELECT * FROM FACULTY

EXEC PR_GetFacultyByJoiningDate '2010-07-15';

--2. Create a stored procedure for ENROLLMENT table where user enters either StudentID OR COURSEID and returns EnrollmentID, EnrollmentDate, Grade, and Status. 

SELECT * FROM ENROLLMENT

CREATE OR ALTER PROC PR_GetEnrollIdDateGradeStatus
@STUID INT = NULL,
@COURID VARCHAR(20) = NULL
AS 
    BEGIN
    SELECT ENROLLMENT.EnrollmentID,ENROLLMENT.EnrollmentDate,ENROLLMENT.Grade,ENROLLMENT.EnrollmentStatus
    FROM ENROLLMENT
    WHERE StudentID = @STUID OR CourseID = @COURID
    END;

EXEC PR_GetEnrollIdDateGradeStatus @STUID = 1,@COURID = 'CS101' 


--3. Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.  

CREATE OR ALTER PROCEDURE PR_GetCoursesByCreditRange
    @MinCredits INT,
    @MaxCredits INT
AS
BEGIN
    SELECT 
        CourseID,
        CourseName,
        CourseCredits,
        CourseDepartment,
        CourseSemester
    FROM COURSE
    WHERE CourseCredits BETWEEN @MinCredits AND @MaxCredits;
END;

EXEC PR_GetCoursesByCreditRange 2, 3;

--4. Create a stored procedure that accepts Course Name and returns the lis of students enrolled in that course. 

CREATE OR ALTER PROCEDURE PR_GetStudentsByCourseName
    @CourseName VARCHAR(100)
AS
BEGIN
    SELECT S.StudentID,S.StuName
    FROM ENROLLMENT E
    INNER JOIN STUDENT S 
        ON E.StudentID = S.StudentID
    INNER JOIN COURSE C 
        ON E.CourseID = C.CourseID
    WHERE C.CourseName = @CourseName;
END;

SELECT * FROM COURSE

EXEC PR_GetStudentsByCourseName @CourseName = 'Data Structures';

--5. Create a stored procedure that accepts Faculty Name and returns all course assignments. 
CREATE OR ALTER PROCEDURE PR_GetCourseAssignmentsByFacultyName
    @FacultyName VARCHAR(100)
AS
BEGIN
    SELECT
        F.FacultyID,
        F.FacultyName,
        C.CourseID,
        C.CourseName,
        C.CourseCredits,
        C.CourseDepartment,
        C.CourseSemester
    FROM COURSE_ASSIGNMENT CA
    JOIN FACULTY F
        ON CA.FacultyID = F.FacultyID
    JOIN COURSE C
        ON CA.CourseID = C.CourseID
    WHERE F.FacultyName = @FacultyName;
END;

EXEC PR_GetCourseAssignmentsByFacultyName 'Dr.Seth';

--6. Create a stored procedure that accepts Semester number and Year, and returns all course 
--assignments with faculty and classroom details. 
CREATE OR ALTER PROC PR_AllCourse_Assingment
@semester INT,
@year INT
AS
    BEGIN
    SELECT C.CourseName, F.FACU
    FROM COURSE_ASSIGNMENT CA
    JOIN COURSE C
    ON C.CourseID = CA.CourseID
    JOIN F.
    WHERE @semester = C.CourseSemester AND @year = CA.Year
    END;