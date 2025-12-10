USE CSE_4B_330

--Lab-1 SQL Concepts Revision

--Part � A  
--1. Retrieve all unique departments from the STUDENT table. 
--2. Insert a new student record into the STUDENT table. 
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021) 
--3. Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table) 
--4. Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table. 
--5. Retrieve all courses whose CourseName starts with 'Data'. (COURSE table) 
--6. Retrieve all students whose Name contains 'Shah'. (STUDENT table) 
--7. Display all Faculty Names in UPPERCASE. (FACULTY table) 
--8. Find all faculty who joined after 2015. (FACULTY table) 
--9. Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table) 
--10. Find the Current Date using SQL Server in-built function. 
--11. Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table) 
--12. Find all enrollments that were made in the year 2022. (ENROLLMENT table) 
--13. Find the number of courses offered by each department. (COURSE table) 
--14. Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table) 
--15. Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table) 
--16. Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table) 
--17. Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  
--course name. (STUDENT, COURSE, ENROLLMENT,  table) 
--18. Retrieve the student�s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT 
--TABLE) 
--19. Display course name having second highest credit. (COURSE table) 

CREATE TABLE ENROLLMENT (
  EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
  StudentID INT NOT NULL,
  CourseID VARCHAR(10) NOT NULL,
  EnrollmentDate DATE NULL,
  Grade VARCHAR(2) NULL,
  EnrollmentStatus VARCHAR(20) NOT NULL CHECK (EnrollmentStatus IN ('Active', 'Completed', 'Dropped')),
  FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
  FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

--1. Retrieve all unique departments from the STUDENT table.
select DISTINCT(STUDENT.StuDepartment)
from STUDENT

--2. Insert a new student record into the STUDENT table. 
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021) 

insert into STUDENT values(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

select * from STUDENT


--3. Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
update STUDENT
set StuEmail = 'raj.p@univ.edu'
where StuName = 'Raj Patel'

select * from STUDENT


--4. Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
ALTER TABLE STUDENT ADD CGPA DECIMAL(3,2)
select * from STUDENT

--5. Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
SELECT CourseName FROM COURSE WHERE CourseName LIKE 'Data%'

--6. Retrieve all students whose Name contains 'Shah'. (STUDENT table)
SELECT StuName FROM STUDENT WHERE StuName LIKE '%Shah%'

--7. Display all Faculty Names in UPPERCASE. (FACULTY table)
SELECT UPPER(FacultyName) FacultyName FROM FACULTY

--8. Find all faculty who joined after 2015. (FACULTY table)
SELECT FacultyName FROM FACULTY WHERE FacultyJoiningDate > '2015-01-01'

--9. Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
SELECT SQRT(CourseCredits) as CourseCredits FROM COURSE WHERE CourseName = 'Database Management Systems'

--10.Find the Current Date using SQL Server in-built function.
SELECT GETDATE() AS CURRENTDATE

--11.Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
SELECT TOP 3 StuName,StuEnrollmentYear 
FROM STUDENT 
order by StuEnrollmentYear

select * from STUDENT
select * from ENROLLMENT

--12.Find all enrollments that were made in the year 2022. (ENROLLMENT table)
select * 
from ENROLLMENT
where EnrollmentDate BETWEEN '2022-01-01' AND '2022-12-31'


--13.Find the number of courses offered by each department. (COURSE table)
SELECT CourseDepartment ,COUNT(CourseID) as Count_course  FROM COURSE GROUP BY CourseDepartment

--14. Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
select ENROLLMENT.CourseID,COUNT(CourseID)
from ENROLLMENT
group by CourseID
having COUNT(CourseID) > 2

--15. Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table) 
select STUDENT.StuName,ENROLLMENT.EnrollmentStatus
from STUDENT
join ENROLLMENT 
on STUDENT.StudentID = ENROLLMENT.StudentID

--16. Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
select STUDENT.StuName,COURSE.CourseName
from STUDENT
join ENROLLMENT
on STUDENT.StudentID = ENROLLMENT.StudentID
join COURSE
on ENROLLMENT.CourseID = COURSE.CourseID

--17. Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  
--course name. (STUDENT, COURSE, ENROLLMENT,  table)
CREATE OR ALTER VIEW ActiveEnrollments
as 
SELECT STUDENT.StuName,ENROLLMENT.EnrollmentStatus,COURSE.CourseName
from STUDENT 
join ENROLLMENT 
on STUDENT.StudentID = ENROLLMENT.StudentID
join COURSE 
on COURSE.CourseID = ENROLLMENT.CourseID
where ENROLLMENT.EnrollmentStatus = 'Active'

select * from ActiveEnrollments

--18. Retrieve the student�s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT 
--TABLE) 
select STUDENT.StuName
from STUDENT
where StudentID NOT IN (select StudentID from ENROLLMENT)

--19. Display course name having second highest credit. (COURSE table)
select top 1 COURSE.CourseName,COURSE.CourseCredits
from COURSE 
where CourseCredits = (select DISTINCT TOP 2 CourseCredits from )




-- Part – B  
-- 20. Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table) 
-- 21. Retrieve the total number of enrollments for each status, showing only statuses that have more than 
-- 2 enrollments. (ENROLLMENT table) 
-- 22. Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, 
-- COURSE_ASSIGNMENT table)

-- 20. Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
SELECT 
    C.CourseID,
    C.CourseName,
    COUNT(E.StudentID) AS TotalEnrolled
FROM COURSE C
LEFT JOIN ENROLLMENT E
    ON C.CourseID = E.CourseID
GROUP BY C.CourseID, C.CourseName
ORDER BY TotalEnrolled DESC;

-- 21. Retrieve the total number of enrollments for each status, showing only statuses that have more than 
-- 2 enrollments. (ENROLLMENT table)
SELECT 
    EnrollmentStatus,
    COUNT(*) AS TotalCount
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(*) > 2;

-- 22. Retrieve all courses taught by 'Dr.Sheth' and order them by Credits. (FACULTY, COURSE, 
SELECT 
    C.CourseID,
    C.CourseName,
    C.CourseCredits
FROM COURSE C
JOIN COURSE_ASSIGNMENT CA 
    ON C.CourseID = CA.CourseID
JOIN FACULTY F
    ON CA.FacultyID = F.FacultyID
WHERE F.FacultyName = 'Dr.Sheth'
ORDER BY C.CourseCredits;




-- Part – C  
-- 23. List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table) 
-- 24. Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, 
-- ENROLLMENT table) 
-- 25. Retrieve department-wise count of faculty members along with their average years of experience 
-- (calculate experience from JoiningDate). (Faculty table) 


-- 23. List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table) 
SELECT 
    S.StudentID,
    S.StuName,
    COUNT(E.CourseID) AS TotalCourses
FROM STUDENT S
JOIN ENROLLMENT E
    ON S.StudentID = E.StudentID
GROUP BY S.StudentID, S.StuName
HAVING COUNT(E.CourseID) > 3;


-- 24. Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, 
-- ENROLLMENT table) 
SELECT StuName, StudentID
FROM STUDENT
WHERE StudentID IN (
        SELECT StudentID 
        FROM ENROLLMENT 
        WHERE CourseID = 'CS101'
)
AND StudentID IN (
        SELECT StudentID 
        FROM ENROLLMENT 
        WHERE CourseID = 'CS201'
);


-- 25. Retrieve department-wise count of faculty members along with their average years of experience 
-- (calculate experience from JoiningDate). (Faculty table) 
SELECT 
    FacultyDepartment,
    COUNT(*) AS TotalFaculty,
    AVG(DATEDIFF(YEAR, FacultyJoiningDate, GETDATE())) AS AvgExperienceYears
FROM FACULTY
GROUP BY FacultyDepartment;



