--Part-A 

--1. Write a scalar function to print "Welcome to DBMS Lab".
CREATE OR ALTER FUNCTION fn_WelcomeMessage()
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'Welcome to DBMS Lab'
END

SELECT dbo.fn_WelcomeMessage()




--2. Write a scalar function to calculate simple interest. 
CREATE OR ALTER FUNCTION fn_SimpleInterest
(
    @p DECIMAL(10,2),
    @r DECIMAL(5,2),
    @t INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (@p * @r * @t) / 100
END

SELECT dbo.fn_SimpleInterest(10000, 5, 2)

GO
--3. Function to Get Difference in Days Between Two Given Dates 
CREATE OR ALTER FUNCTION dbo.fn_DateDiffInDays
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @StartDate, @EndDate);
END;

SELECT dbo.fn_DateDiffInDays('2024-01-01', '2024-01-10');



--4. Write a scalar function which returns the sum of Credits for two given CourseIDs. 

CREATE OR ALTER FUNCTION dbo.fn_SumOfCourseCredits
(
    @CourseID1 VARCHAR(10),
    @CourseID2 VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalCredits INT;

    SELECT @TotalCredits = SUM(CourseCredits)
    FROM COURSE
    WHERE CourseID IN (@CourseID1, @CourseID2);

    RETURN @TotalCredits;
END;

SELECT dbo.fn_SumOfCourseCredits('CS101','CS201');


--5. Write a function to check whether the given number is ODD or EVEN.

CREATE OR ALTER FUNCTION dbo.fn_CheckOddEven
(
    @Number INT
)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN
        CASE
            WHEN @Number % 2 = 0 THEN 'EVEN'
            ELSE 'ODD'
        END;
END;

SELECT dbo.fn_CheckOddEven(24);


--6. Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION dbo.fn_Print1ToN
(
    @N INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @Result VARCHAR(MAX) = '';

    WHILE @i <= @N
    BEGIN
        SET @Result = @Result + CAST(@i AS VARCHAR) + ' ';
        SET @i = @i + 1;
    END

    RETURN @Result;
END;

SELECT dbo.fn_Print1ToN(10);


--7. Write a scalar function to calculate factorial of total credits for a given CourseID. 
CREATE OR ALTER FUNCTION dbo.fn_FactorialOfCourseCredits
(
    @CourseID VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    DECLARE @Credits INT;
    DECLARE @Fact INT = 1;
    DECLARE @i INT = 1;

    SELECT @Credits = CourseCredits
    FROM COURSE
    WHERE CourseID = @CourseID;

    WHILE @i <= @Credits
    BEGIN
        SET @Fact = @Fact * @i;
        SET @i = @i + 1;
    END

    RETURN @Fact;
END;

SELECT dbo.fn_FactorialOfCourseCredits('CS101');


--8. Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case 
--statement) 
CREATE OR ALTER FUNCTION dbo.fn_CheckEnrollmentYear
(
    @EnrollmentYear INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN
        CASE
            WHEN @EnrollmentYear < YEAR(GETDATE()) THEN 'PAST'
            WHEN @EnrollmentYear = YEAR(GETDATE()) THEN 'CURRENT'
            ELSE 'FUTURE'
        END;
END;

SELECT dbo.fn_CheckEnrollmentYear(2021) AS YearCOl;

--9. Write a table-valued function that returns details of students whose names start with a given letter. 
CREATE OR ALTER FUNCTION dbo.fn_StudentsByName
(
    @Letter CHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM STUDENT
    WHERE StuName LIKE @Letter + '%'
);


SELECT * FROM dbo.fn_StudentsByName('a');
SELECT * FROM STUDENT


--10. Write a table-valued function that returns unique department names from the STUDENT table.
CREATE OR ALTER FUNCTION dbo.fn_UniqueStudentDepartments()
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT StuDepartment
    FROM STUDENT
);

SELECT * FROM dbo.fn_UniqueStudentDepartments();


--Part-B 

--11. Write a scalar function that calculates age in years given a DateOfBirth.
CREATE OR ALTER FUNCTION dbo.fn_CalculateAge
(
    @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;

    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

    IF (MONTH(@DateOfBirth) > MONTH(GETDATE()))
       OR (MONTH(@DateOfBirth) = MONTH(GETDATE()) 
           AND DAY(@DateOfBirth) > DAY(GETDATE()))
    BEGIN
        SET @Age = @Age - 1;
    END

    RETURN @Age;
END;

SELECT dbo.fn_CalculateAge('2003-05-15');



--12. Write a scalar function to check whether given number is palindrome or not. 
--13. Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department. 
--14. Write a table-valued function that returns all courses taught by faculty with a specific designation.

