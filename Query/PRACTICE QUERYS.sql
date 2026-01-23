
-- Q1. Show all schools list
SELECT * FROM "Schools";

-- Q2. Show all students list
SELECT * FROM "Students";

-- Q3. Show all teachers list
SELECT * FROM "Teachers";

-- Q4. Show all subjects list for SchoolID = 1
SELECT * FROM "Subjects"
WHERE "SchoolID" = 1;

-- Q5. Show students whose FirstName starts with “A”
SELECT "FirstName" FROM "Students"
WHERE "FirstName" ILIKE 'A%';

-- Q6. Show students order by FirstName (A–Z)
SELECT * FROM "Students"
ORDER BY "FirstName" ASC;

-- Q7. Show top 5 highest StudentID students
SELECT *
FROM "Students"
ORDER BY "StudentID" DESC
LIMIT 5;


-- Q8. Show student list with their class (Grade, Section, AcademicYear)
SELECT
  s."StudentID",
  s."AdmissionNo",
  s."FirstName",
  s."LastName",
  c."Grade",
  c."Section",
  c."AcademicYear"
FROM "Students" s
JOIN "Classes" c
ON s."ClassID" = c."ClassID"
ORDER BY s."StudentID";


-- Q9. Show attendance list on date 2026-01-10 with student name + status
SELECT
  a."AttendanceDate",
  s."StudentID",
  s."FirstName",
  s."LastName",
  a."Status"
FROM "Attendance" a
JOIN "Students" s
ON a."StudentID" = s."StudentID"
WHERE a."AttendanceDate" = DATE '2026-01-10'
ORDER BY s."FirstName", s."LastName";


-- Q10. Show total students count class-wise
SELECT
  c."ClassID",
  c."Grade",
  c."Section",
  c."AcademicYear",
  COUNT(s."StudentID") AS "TotalStudents"
FROM "Classes" c
LEFT JOIN "Students" s
ON s."ClassID" = c."ClassID"
GROUP BY c."ClassID", c."Grade", c."Section", c."AcademicYear"
ORDER BY "TotalStudents" DESC;


-- Q11. Count Present / Absent / Late for SchoolID = 1 on 2026-01-10
SELECT
  a."Status",
  COUNT(*) AS "Total"
FROM "Attendance" a
WHERE a."SchoolID" = 1
AND a."AttendanceDate" = DATE '2026-01-10'
GROUP BY a."Status"
ORDER BY "Total" DESC;


-- Q12. Show only Absent students on 2026-01-10 with class details
SELECT
  s."StudentID",
  s."FirstName",
  s."LastName",
  c."Grade",
  c."Section",
  c."AcademicYear",
  a."AttendanceDate",
  a."Status"
FROM "Attendance" a
JOIN "Students" s
ON a."StudentID" = s."StudentID"
JOIN "Classes" c
ON s."ClassID" = c."ClassID"
WHERE a."AttendanceDate" = DATE '2026-01-10'
  AND a."Status" = 'Absent'
ORDER BY c."Grade", c."Section", s."FirstName";


-- Q13. Show class-wise absent count on 2026-01-10
SELECT
  c."ClassID",
  c."Grade",
  c."Section",
  COUNT(*) AS "AbsentCount"
FROM "Attendance" a
JOIN "Students" s
  ON a."StudentID" = s."StudentID"
JOIN "Classes" c
ON s."ClassID" = c."ClassID"
WHERE a."AttendanceDate" = DATE '2026-01-10'
  AND a."Status" = 'Absent'
GROUP BY c."ClassID", c."Grade", c."Section"
ORDER BY "AbsentCount" DESC;


-- Q14. Show teacher-wise attendance marked count
SELECT
  t."TeacherID",
  t."TeacherName",
  COUNT(a."AttendanceID") AS "MarkedCount"
FROM "Teachers" t
LEFT JOIN "Attendance" a
ON a."MarkedByTeacherID" = t."TeacherID"
GROUP BY t."TeacherID", t."TeacherName"
ORDER BY "MarkedCount" DESC;

