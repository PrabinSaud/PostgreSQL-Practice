
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
-- Q9. Show attendance list on date 2026-01-10 with student name + status
-- Q10. Show total students count class-wise
-- Q11. Count Present / Absent / Late for SchoolID = 1 on 2026-01-10
-- Q12. Show only Absent students on 2026-01-10 with class details
-- Q13. Show class-wise absent count on 2026-01-10
-- Q14. Show teacher-wise attendance marked count
