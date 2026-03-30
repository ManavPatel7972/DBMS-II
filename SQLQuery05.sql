use CSE_4B_330

--Part – A

--1. Create a cursor Course_Cursor to fetch all rows from COURSE table and display them.

DECLARE @CourseID   VARCHAR(10)
,       @CourseName VARCHAR(100)
,       @Credits    INT
,       @Dept       VARCHAR(50)
,       @Sem        INT

DECLARE Course_Cursor CURSOR FOR
SELECT CourseID
,      CourseName
,      CourseCredits
,      CourseDepartment
,      CourseSemester
FROM COURSE

OPEN Course_Cursor
FETCH NEXT FROM Course_Cursor INTO @CourseID, @CourseName, @Credits, @Dept, @Sem

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @CourseID + ' | ' + @CourseName + ' | ' + CAST(@Credits AS VARCHAR)
	FETCH NEXT FROM Course_Cursor INTO @CourseID, @CourseName, @Credits, @Dept, @Sem
END

CLOSE Course_Cursor
DEALLOCATE Course_Cursor


--2. Create a cursor Student_Cursor_Fetch to fetch records in form of StudentID_StudentName (Example:-- 1_Raj Patel).

DECLARE @SID   INT
,       @SName VARCHAR(100)

DECLARE Student_Cursor_Fetch CURSOR FOR
SELECT StudentID
,      StuName
FROM STUDENT

OPEN Student_Cursor_Fetch
FETCH NEXT FROM Student_Cursor_Fetch INTO @SID, @SName

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT CAST(@SID AS VARCHAR) + '_' + @SName
	FETCH NEXT FROM Student_Cursor_Fetch INTO @SID, @SName
END

CLOSE Student_Cursor_Fetch
DEALLOCATE Student_Cursor_Fetch


--3. Create a cursor to find and display all courses with Credits greater than 3.

DECLARE @CName   VARCHAR(100)
,       @Credits INT

DECLARE Course_Credit_Cursor CURSOR FOR
SELECT CourseName
,      CourseCredits
FROM COURSE
WHERE CourseCredits > 3

OPEN Course_Credit_Cursor
FETCH NEXT FROM Course_Credit_Cursor INTO @CName, @Credits

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @CName + ' - ' + CAST(@Credits AS VARCHAR)
	FETCH NEXT FROM Course_Credit_Cursor INTO @CName, @Credits
END

CLOSE Course_Credit_Cursor
DEALLOCATE Course_Credit_Cursor

--4. Create a cursor to display all students who enrolled in year 2021 or later.

select *
from STUDENT

DECLARE @Name VARCHAR(100)
,       @Year INT

DECLARE Student_Year_Cursor CURSOR FOR
SELECT StuName
,      StuEnrollmentYear
FROM STUDENT
WHERE StuEnrollmentYear >= 2021

OPEN Student_Year_Cursor
FETCH NEXT FROM Student_Year_Cursor INTO @Name, @Year

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @Name + ' - ' + CAST(@Year AS VARCHAR)
	FETCH NEXT FROM Student_Year_Cursor INTO @Name, @Year
END

CLOSE Student_Year_Cursor
DEALLOCATE Student_Year_Cursor



--5. Create a cursor Course_CursorUpdate that retrieves all courses and increases Credits by 1 for courses
--with Credits less than 4.

DECLARE COURSE_CURSORUPDATE CURSOR
FOR
SELECT COURSEID
,      COURSECREDITS
FROM COURSE;

DECLARE @CID    VARCHAR(10)
,       @CREDIT INT;

OPEN COURSE_CURSORUPDATE;
FETCH NEXT FROM COURSE_CURSORUPDATE INTO @CID, @CREDIT;

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @CREDIT < 4
		UPDATE COURSE
		SET COURSECREDITS = COURSECREDITS + 1
		WHERE COURSEID = @CID;

	FETCH NEXT FROM COURSE_CURSORUPDATE INTO @CID, @CREDIT;
END

CLOSE COURSE_CURSORUPDATE;
DEALLOCATE COURSE_CURSORUPDATE;

--6. Create a Cursor to fetch Student Name with Course Name (Example: Raj Patel is enrolled in Database
--Management System)

DECLARE STUDENT_COURSE_CURSOR CURSOR
FOR
SELECT S.STUNAME
,      C.COURSENAME
FROM STUDENT    S
JOIN ENROLLMENT E ON S.STUDENTID = E.STUDENTID
JOIN COURSE     C ON E.COURSEID = C.COURSEID;

DECLARE @SNAME VARCHAR(100)
,       @CNAME VARCHAR(100);

OPEN STUDENT_COURSE_CURSOR;
FETCH NEXT FROM STUDENT_COURSE_CURSOR INTO @SNAME, @CNAME;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @SNAME + ' is enrolled in ' + @CNAME;
	FETCH NEXT FROM STUDENT_COURSE_CURSOR INTO @SNAME, @CNAME;
END

CLOSE STUDENT_COURSE_CURSOR;
DEALLOCATE STUDENT_COURSE_CURSOR;

--7. Create a cursor to insert data into new table if student belong to ‘CSE’ department. (create new table
--CSEStudent with relevant columns)
CREATE TABLE CSEStudent
(
    STUDENTID INT ,
    STUNAME VARCHAR(20),
    STUDEPARTMENT VARCHAR(10)
)


DECLARE CSE_dept_CURSOR CURSOR
FOR
SELECT STUDENTID, STUNAME
FROM STUDENT
WHERE STUDEPARTMENT = 'CSE';

DECLARE @SID INT, @SNAME VARCHAR(100);

OPEN CSE_dept_CURSOR;
FETCH NEXT FROM CSE_dept_CURSOR INTO @SID, @SNAME;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO CSEStudent VALUES (@SID, @SNAME, 'CSE');
    FETCH NEXT FROM CSE_dept_CURSOR INTO @SID, @SNAME;
END

CLOSE CSE_dept_CURSOR;
DEALLOCATE CSE_dept_CURSOR;

SELECT * FROM CSEStudent 


--Part – B
--8. Create a cursor to update all NULL grades to 'F' for enrollments with Status 'Completed'

DECLARE UPDATE_GRADE_CURSOR CURSOR
FOR
SELECT ENROLLMENTID
FROM ENROLLMENT
WHERE GRADE IS NULL
AND ENROLLMENTSTATUS = 'COMPLETED';

DECLARE @EID INT;

OPEN UPDATE_GRADE_CURSOR;
FETCH NEXT FROM UPDATE_GRADE_CURSOR INTO @EID;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE ENROLLMENT
    SET GRADE = 'F'
    WHERE ENROLLMENTID = @EID;

    FETCH NEXT FROM UPDATE_GRADE_CURSOR INTO @EID;
END

CLOSE UPDATE_GRADE_CURSOR;
DEALLOCATE UPDATE_GRADE_CURSOR;

SELE

--9. Cursor to show Faculty with Course they teach (EX: Dr. Sheth teaches Data structure)
--Part – C
--10. Cursor to calculate total credits per student (Example: Raj Patel has total credits = 15)
















































DECLARE @StuName    VARCHAR(100)
,       @CourseName VARCHAR(100)

DECLARE Student_Course_Cursor CURSOR FOR
SELECT S.StuName
,      C.CourseName
FROM STUDENT    S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
JOIN COURSE     C ON E.CourseID = C.CourseID

OPEN Student_Course_Cursor
FETCH NEXT FROM Student_Course_Cursor INTO @StuName, @CourseName

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @StuName + ' is enrolled in ' + @CourseName
	FETCH NEXT FROM Student_Course_Cursor INTO @StuName, @CourseName
END

CLOSE Student_Course_Cursor
DEALLOCATE Student_Course_Cursor












CREATE TABLE CSEStudent ( StudentID     INT
,                         StuName       VARCHAR(100)
,                         StuDepartment VARCHAR(50) )

DECLARE @ID   INT
,       @Name VARCHAR(100)
,       @Dept VARCHAR(50)

DECLARE CSE_Cursor CURSOR FOR
SELECT StudentID
,      StuName
,      StuDepartment
FROM STUDENT
WHERE StuDepartment = 'CSE'

OPEN CSE_Cursor
FETCH NEXT FROM CSE_Cursor INTO @ID, @Name, @Dept

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO CSEStudent
	VALUES ( @ID, @Name, @Dept )
	FETCH NEXT FROM CSE_Cursor INTO @ID, @Name, @Dept
END

CLOSE CSE_Cursor
DEALLOCATE CSE_Cursor
