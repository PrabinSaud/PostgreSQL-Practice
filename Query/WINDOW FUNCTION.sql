-- 1.Show all students with a row number ordered by StudentID DESC
SELECT
	"StudentID",
	"FirstName",
	"LastName",
	ROW_NUMBER() OVER(ORDER BY "StudentID" DESC) AS "RowNum"
FROM "Students";

-- 2. Show students with row number inside each class, ordered by "StudentID".
SELECT 
"ClassID",
"StudentID",
"FirstName",
ROW_NUMBER() OVER(PARTITION BY "ClassID" ORDER BY "StudentID") AS "RowNumClass"
FROM "Students";

-- 3. Rank classes by total number of students
SELECT
"ClassID",
COUNT("StudentID") AS "TotalStudents",
RANK() OVER(ORDER BY COUNT("StudentID") DESC ) AS "RankByStrength"
FROM "Students"
GROUP BY "ClassID";

-- 4. For each student, show attendance with previous + next status
SELECT
"StudentID",
"AttendanceDate",
"Status",
LAG("Status") OVER(PARTITION BY "StudentID" ORDER BY "AttendanceDate") AS "PreviousStatus",
LEAD("Status") OVER(PARTITION BY "StudentID" ORDER BY "AttendanceDate") AS "NextsStatus"
FROM "Attendance";

-- 5. Show each student’s latest attendance record only (latest date status)
SELECT
"StudentID",
"AttendanceDate",
"Status"
FROM
	(SELECT
	"StudentID",
	"AttendanceDate",
	"Status",
	ROW_NUMBER() OVER( PARTITION BY "StudentID" ORDER BY "AttendanceDate" DESC)AS "LatestDate"
	FROM "Attendance") as t
WHERE "LatestDate" = 1
ORDER BY "StudentID";

-- 6.Show the latest attendance record for each student (with count)..
SELECT
"StudentID",
"PresentCount",
"Rank"
FROM
	(SELECT
	"StudentID",
	"AttendanceDate",
	COUNT("Status") AS "PresentCount",
	RANK() OVER( PARTITION BY "StudentID" ORDER BY "AttendanceDate" DESC)AS "Rank"
	FROM "Attendance"
	GROUP BY "StudentID","AttendanceDate") as t
WHERE "Rank" = 1
ORDER BY "StudentID" DESC;

-- 7. Show attendance count per student + rank students by total Present count (highest first).

SELECT
  "StudentID",
  COUNT(*) FILTER (WHERE "Status" = 'Present') AS "PresentCount",
  RANK() OVER (ORDER BY COUNT(*) FILTER (WHERE "Status" = 'Present') DESC) AS "PresentRank"
FROM "Attendance"
GROUP BY "StudentID"
ORDER BY "PresentRank";

-- 8. Show each class’s total Present count and rank classes by Present count (highest first).
SELECT
  c."ClassID",
  COUNT(*) FILTER (WHERE a."Status" = 'Present') AS "PresentCount",
  DENSE_RANK() OVER (ORDER BY COUNT(*) FILTER (WHERE a."Status" = 'Present') DESC) AS "ClassRank"
FROM "Classes" c
LEFT JOIN "Students" s
ON s."ClassID" = c."ClassID"
LEFT JOIN "Attendance" a
ON a."StudentID" = s."StudentID"
GROUP BY c."ClassID"
ORDER BY "ClassRank", c."ClassID";
