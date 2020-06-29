
CREATE SCHEMA School;
GO


CREATE TABLE School.Student (
	--columns go here
	--name of the colums, type, constraints
	Id INT IDENTITY (1, 1) NOT NULL,
	Name NVARCHAR(200) NOT NULL
);

--DROP TABLE School.Course;
CREATE TABLE School.Course (
	Id INT NOT NULL,
	CourseNumber NVARCHAR(10) NOT NULL,
	-- put below as null because sectionnumber is not required for this table 
	SectionNumber NVARCHAR(10) NULL,
	--constraints
	UNIQUE (CourseNumber, SectionNumber)
);

--DROP TABLE School.Enrollment;
-- this is the 3rd table (junction table)
CREATE TABLE School.Enrollment (
	StudentId INT NOT NULL,
	CourseId INT NOT NULL,
	CONSTRAINT PK_Enrollment_StudentId_CourseId PRIMARY KEY (StudentId, CourseId)
);

ALTER TABLE School.Enrollment
	ADD CONSTRAINT FK_Enrollment_Student_StudentId FOREIGN KEY (StudentId)
		REFERENCES School.Student (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE School.Enrollment
	ADD CONSTRAINT FK_Enrollment_Course_CourseId FOREIGN KEY (CourseId)
		REFERENCES School.Course (Id) ON DELETE CASCADE ON UPDATE CASCADE;


-- create the constraint on an existing table
ALTER TABLE School.Student
	ADD CONSTRAINT PK_Student_Id PRIMARY KEY (Id);
				--constraint name			--list of columns in PK

ALTER TABLE School.Course
	ADD CONSTRAINT PK_Course_Id PRIMARY KEY (Id);



-- do this so that you don't have to manually look for the date every time there was a change to the column (like an insertion)
ALTER TABLE School.Course
	ADD DateModified DATETIME2 DEFAULT SYSUTCDATETIME();

--adds 3 rows to Student and Course tables
INSERT INTO School.Student (Name) VALUES ('Ray'), ('Nick'), ('Alfred');
INSERT INTO School.Course (Id, CourseNumber) VALUES (1, 'CS101'), (2, 'CS102'), (3, 'CS103');

INSERT INTO School.Enrollment (StudentId, CourseId) VALUES
	((SELECT Id FROM School.Student WHERE Name = 'Nick'),
		(SELECT Id FROM School.Course WHERE CourseNumber = 'CS101'));


SELECT * FROM Employee;
SELECT * FROM Worker;
SELECT * FROM School.Student;
SELECT * FROM School.Course;
SELECT * FROM School.Enrollment;

