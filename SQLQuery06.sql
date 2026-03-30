use CSE_4B_330

select *
from COURSE;

-- Table : Log(LogMessage varchar(100), logDate Datetime)

    CREATE TABLE Log (
    LogMessage VARCHAR(100),
    LogDate DATETIME DEFAULT GETDATE()
);

select *
from Log;

-- Part – A
-- 1. Create trigger for printing appropriate message after student registration.
CREATE TRIGGER trg_AfterStudentInsert
ON STUDENT
AFTER INSERT
AS
BEGIN
    PRINT 'New student registered successfully.';
END;

    select *
    from STUDENT;

    insert into STUDENT values (101,'Manav','manav@mail.com','123456','CSE','2025-04-22',2025)

    DROP TRIGGER trg_AfterStudentInsert
-- 2. Create trigger for printing appropriate message after faculty deletion.
CREATE TRIGGER trg_AfterFacultyDelete
ON FACULTY
AFTER DELETE
AS
BEGIN
    PRINT 'Faculty record deleted successfully.';
END;

    select *
    from FACULTY;

DELETE FROM FACULTY
WHERE FacultyID = 107;

    DROP TRIGGER trg_AfterFacultyDelete

-- 3. Create trigger for monitoring all events on course table. (print only appropriate message)
    CREATE TRIGGER trg_CourseEvent
    ON COURSE
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
            PRINT 'Course record updated.';
        ELSE IF EXISTS (SELECT * FROM inserted)
            PRINT 'New course added.';
        ELSE IF EXISTS (SELECT * FROM deleted)
            PRINT 'Course deleted.';
    END;

select *
from COURSE;

INSERT INTO COURSE
VALUES ('CS401', 'Machine Learning', 4, 'CSE', 7);

UPDATE COURSE
SET CourseCredits = 5
WHERE CourseID = 'CS101';

DELETE FROM COURSE
WHERE CourseID = 'ME101';

drop trigger trg_CourseEvent

-- 4. Create trigger for logging data on new student registration in Log table.
select *
from STUDENT;

CREATE TRIGGER trg_LogStudentInsert
ON STUDENT
AFTER INSERT
AS
BEGIN
    INSERT INTO Log (LogMessage)
    SELECT
        'Student Registered: ' + StuName
    FROM inserted;
END;

INSERT INTO STUDENT
VALUES (102, 'Vikas Patel', 'vikas@univ.edu', '9876543221', 'IT', '2004-01-12', 2022);

    select *
    from Log;

drop TRIGGER trg_LogStudentInsert

-- 5. Create trigger for auto-uppercasing faculty names.
CREATE TRIGGER trg_UpperFacultyName
ON FACULTY
AFTER INSERT, UPDATE
AS
BEGIN
    select FacultyName from inserted;
--     UPDATE FACULTY
--     SET FacultyName = UPPER(FacultyName)
--     WHERE FacultyID IN (SELECT FacultyID FROM inserted);
END;

    select *
    from FACULTY;
drop trigger trg_UpperFacultyName

    INSERT INTO FACULTY
    VALUES (501, 'another', 'mehta@univ.edu', 'CSE', 'Professor', '2016-05-10',10),
           (502, 'another', 'mehta@univ.edu', 'CSE', 'Professor', '2016-05-10',10);


-- 6. Create trigger for calculating faculty experience (Note: Add required column in faculty table)
ALTER TABLE FACULTY
ADD FacultyExperience INT;

CREATE TRIGGER trg_FacultyExperience
ON FACULTY
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE FACULTY
    SET FacultyExperience = DATEDIFF(YEAR, FacultyJoiningDate, GETDATE())
    WHERE FacultyID IN (SELECT FacultyID FROM inserted);
END;

    select *
    from FACULTY;


-- Part – B

-- 7. Create trigger for auto-stamping enrollment dates.

CREATE TRIGGER trg_AutoEnrollmentDate
ON ENROLLMENT
AFTER INSERT
AS
BEGIN
    UPDATE ENROLLMENT
    SET EnrollmentDate = GETDATE()
    WHERE EnrollmentID IN (
        SELECT EnrollmentID FROM inserted
        WHERE EnrollmentDate IS NULL
    );
END;


    INSERT INTO ENROLLMENT (StudentID, CourseID, Grade, EnrollmentStatus)
VALUES (3, 'CS301', NULL, 'Active');

    select *
    from ENROLLMENT;
SELECT EnrollmentDate FROM ENROLLMENT
WHERE StudentID = 3 AND CourseID = 'CS301';

-- 8. Create trigger for logging data After course assignment - log course and faculty detail.\

CREATE TRIGGER trg_LogCourseAssignment
ON COURSE_ASSIGNMENT
AFTER INSERT
AS
BEGIN
    INSERT INTO Log (LogMessage)
    SELECT
        'Course ' + CourseID +
        ' assigned to Faculty ID ' + CAST(FacultyID AS VARCHAR)
    FROM inserted;
END;

-- Part - C
-- 9. Create trigger for updating student phone and print the old and new phone number.
-- 10. Create trigger for updating course credit log old and new credits in log table.