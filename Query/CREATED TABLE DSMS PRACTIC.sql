CREATE TABLE "Schools" (
  "SchoolID" BIGSERIAL PRIMARY KEY,
  "SchoolName" VARCHAR(150) NOT NULL,
  "Address" TEXT,
  "Phone" VARCHAR(20),
  "Email" VARCHAR(150),
  "CreatedAt" TIMESTAMP DEFAULT NOW()
);

CREATE TABLE "Users" (
  "UserID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "Username" VARCHAR(80) NOT NULL,
  "PasswordHash" TEXT NOT NULL,
  "Role" VARCHAR(20) NOT NULL,
  "IsActive" BOOLEAN NOT NULL DEFAULT TRUE,
  "CreatedAt" TIMESTAMP DEFAULT NOW(),

  CONSTRAINT "FK_Users_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "CHK_Users_Role"
    CHECK ("Role" IN ('Admin','Teacher','Parent','Student')),

  CONSTRAINT "UQ_Users_School_Username"
    UNIQUE ("SchoolID","Username")
);


CREATE TABLE "Classes" (
  "ClassID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "Grade" VARCHAR(20) NOT NULL,
  "Section" VARCHAR(10) NOT NULL,
  "AcademicYear" VARCHAR(20) NOT NULL,
  "CreatedAt" TIMESTAMP DEFAULT NOW(),

  CONSTRAINT "FK_Classes_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "UQ_Classes_Grade_Section_Year"
    UNIQUE ("SchoolID","Grade","Section","AcademicYear")
);

CREATE TABLE "Teachers" (
  "TeacherID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "UserID" BIGINT,
  "TeacherName" VARCHAR(150) NOT NULL,
  "Phone" VARCHAR(20),
  "Email" VARCHAR(150),
  "CreatedAt" TIMESTAMP DEFAULT NOW(),

  CONSTRAINT "FK_Teachers_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "FK_Teachers_Users"
    FOREIGN KEY ("UserID") REFERENCES "Users"("UserID")
);

CREATE TABLE "Students" (
  "StudentID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "ClassID" BIGINT NOT NULL,
  "UserID" BIGINT,
  "AdmissionNo" VARCHAR(40) NOT NULL,
  "FirstName" VARCHAR(80) NOT NULL,
  "LastName" VARCHAR(80),
  "DOB" DATE,
  "Gender" VARCHAR(10),
  "Phone" VARCHAR(20),
  "CreatedAt" TIMESTAMP DEFAULT NOW(),

  CONSTRAINT "FK_Students_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "FK_Students_Classes"
    FOREIGN KEY ("ClassID") REFERENCES "Classes"("ClassID"),

  CONSTRAINT "FK_Students_Users"
    FOREIGN KEY ("UserID") REFERENCES "Users"("UserID"),

  CONSTRAINT "UQ_Students_AdmissionNo"
    UNIQUE ("SchoolID","AdmissionNo")
);

CREATE TABLE "Subjects" (
  "SubjectID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "SubjectName" VARCHAR(120) NOT NULL,

  CONSTRAINT "FK_Subjects_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "UQ_Subjects_Name"
    UNIQUE ("SchoolID","SubjectName")
);

CREATE TABLE "Attendance" (
  "AttendanceID" BIGSERIAL PRIMARY KEY,
  "SchoolID" BIGINT NOT NULL,
  "StudentID" BIGINT NOT NULL,
  "AttendanceDate" DATE NOT NULL,
  "Status" VARCHAR(10) NOT NULL,
  "MarkedByTeacherID" BIGINT,
  "MarkedAt" TIMESTAMP DEFAULT NOW(),

  CONSTRAINT "FK_Attendance_Schools"
    FOREIGN KEY ("SchoolID") REFERENCES "Schools"("SchoolID"),

  CONSTRAINT "FK_Attendance_Students"
    FOREIGN KEY ("StudentID") REFERENCES "Students"("StudentID"),

  CONSTRAINT "FK_Attendance_Teachers"
    FOREIGN KEY ("MarkedByTeacherID") REFERENCES "Teachers"("TeacherID"),

  CONSTRAINT "CHK_Attendance_Status"
    CHECK ("Status" IN ('Present','Absent','Late')),

  CONSTRAINT "UQ_Attendance_OnePerDay"
    UNIQUE ("SchoolID","StudentID","AttendanceDate")
);

CREATE INDEX "IDX_Students_School_Class"
ON "Students" ("SchoolID","ClassID");

CREATE INDEX "IDX_Attendance_School_Date"
ON "Attendance" ("SchoolID","AttendanceDate");


INSERT INTO "Schools" ("SchoolName","Address","Phone","Email")
VALUES
('Shree Everest Secondary School','Kathmandu','01-5551111','everestschool@gmail.com'),
('Green Valley Academy','Pokhara','061-5552222','greenvalley@gmail.com'),
('Himalayan Public School','Lalitpur',NULL,'himalayanpublic@gmail.com'),
('Sunrise English Boarding','Biratnagar','021-5553333',NULL),
('Janata Model School','Butwal',NULL,NULL),
('National Bright Future School','Dharan','025-5554444','brightfuture@gmail.com'),
('Mount Annapurna School','Chitwan','056-5555555','annapurna@gmail.com'),
('Peace Zone School','Nepalgunj',NULL,'peacezone@gmail.com'),
('New Horizon Academy','Hetauda','057-5556666',NULL),
('Shree Bagmati School','Bhaktapur','01-5557777','bagmatischool@gmail.com');

INSERT INTO "Users" ("SchoolID","Username","PasswordHash","Role","IsActive")
VALUES
(1,'admin1','hash_admin1','Admin',true),
(1,'teacher1','hash_teacher1','Teacher',true),
(1,'teacher2','hash_teacher2','Teacher',true),
(1,'parent1','hash_parent1','Parent',true),
(1,'student1','hash_student1','Student',true),
(2,'admin2','hash_admin2','Admin',true),
(2,'teacher3','hash_teacher3','Teacher',true),
(2,'parent2','hash_parent2','Parent',false),
(3,'admin3','hash_admin3','Admin',true),
(4,'teacher4','hash_teacher4','Teacher',true);

INSERT INTO "Classes" ("SchoolID","Grade","Section","AcademicYear")
VALUES
(1,'10','A','2082/2083'),
(1,'10','B','2082/2083'),
(1,'9','A','2082/2083'),
(1,'8','A','2082/2083'),
(2,'10','A','2082/2083'),
(2,'9','A','2082/2083'),
(3,'10','A','2082/2083'),
(3,'7','A','2082/2083'),
(4,'6','A','2082/2083'),
(5,'5','A','2082/2083');

INSERT INTO "Teachers" ("SchoolID","UserID","TeacherName","Phone","Email")
VALUES
(1,2,'Ramesh Adhikari','9841000001','ramesh@gmail.com'),
(1,3,'Sushma Karki','9841000002',NULL),
(1,NULL,'Deepak Shrestha',NULL,'deepak@gmail.com'),
(2,7,'Manoj Thapa','9841000003','manoj@gmail.com'),
(2,NULL,'Pratima Rai','9841000004',NULL),
(3,NULL,'Bikash Gurung',NULL,NULL),
(3,NULL,'Nisha Tamang','9841000005','nisha@gmail.com'),
(4,10,'Arjun Bhandari',NULL,'arjun@gmail.com'),
(5,NULL,'Sita Joshi','9841000006',NULL),
(1,NULL,'Kiran Yadav','9841000007','kiran@gmail.com');


INSERT INTO "Students"
("SchoolID","ClassID","UserID","AdmissionNo","FirstName","LastName","DOB","Gender","Phone")
VALUES
(1,1,5,'ADM001','Amit','Kumar','2010-05-12','Male','9800000001'),
(1,1,NULL,'ADM002','Sita','Rai','2010-11-20','Female',NULL),
(1,2,NULL,'ADM003','Rohan','Singh',NULL,'Male','9800000003'),
(1,3,NULL,'ADM004','Nisha','Shrestha','2011-04-15','Female','9800000004'),
(1,4,NULL,'ADM005','Kiran','Thapa','2012-02-01','Male',NULL),
(2,5,NULL,'ADM006','Pooja','Joshi','2010-09-10','Female','9800000006'),
(2,6,NULL,'ADM007','Raj','Verma',NULL,'Male','9800000007'),
(3,7,NULL,'ADM008','Mina','Gurung','2010-01-30','Female',NULL),
(3,8,NULL,'ADM009','Deepak','Yadav','2013-07-18','Male','9800000009'),
(4,9,NULL,'ADM010','Anita','Bhandari','2014-03-05','Female','9800000010');

INSERT INTO "Subjects" ("SchoolID","SubjectName")
VALUES
(1,'English'),
(1,'Mathematics'),
(1,'Science'),
(1,'Social Studies'),
(1,'Computer'),
(2,'English'),
(2,'Mathematics'),
(2,'Science'),
(3,'Nepali'),
(4,'Health');

INSERT INTO "Attendance"
("SchoolID","StudentID","AttendanceDate","Status","MarkedByTeacherID")
VALUES
(1,1,'2026-01-10','Present',1),
(1,2,'2026-01-10','Absent',2),
(1,3,'2026-01-10','Late',2),
(1,4,'2026-01-10','Present',1),
(1,5,'2026-01-10','Present',1),
(2,6,'2026-01-10','Absent',4),
(2,7,'2026-01-10','Present',4),
(3,8,'2026-01-10','Late',6),
(3,9,'2026-01-10','Present',7),
(4,10,'2026-01-10','Absent',8);


SELECT * FROM "Schools";
SELECT * FROM "Users";
SELECT * FROM "Classes";
SELECT * FROM "Teachers";
SELECT * FROM "Students";
SELECT * FROM "Subjects";
SELECT * FROM "Attendance";


