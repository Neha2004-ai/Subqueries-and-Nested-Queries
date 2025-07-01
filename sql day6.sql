CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
-- Step 1: Drop old tables (order matters due to foreign key)
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Students;

-- Step 2: Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Step 3: Create Marks table
CREATE TABLE Marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
-- Insert students
INSERT INTO Students (student_id, name, age) VALUES
(1, 'Luca Moretti', 21),
(2, 'Amira El-Sayed', 22),
(3, 'Jinwoo Park', 20),
(4, 'Elena García', 23),
(5, 'Rajiv Kapoor', 22);

-- Insert marks
INSERT INTO Marks (student_id, marks) VALUES
(1, 78),
(1, 85),
(2, 92),
(2, 88),
(3, 45),
(3, 30),
(4, 95),
(4, 98),
(5, 39),
(5, 60);
SELECT 
    name,
    (SELECT AVG(marks) 
     FROM Marks 
     WHERE Marks.student_id = Students.student_id) AS avg_marks
FROM Students;
SELECT name 
FROM Students 
WHERE student_id IN (
    SELECT student_id 
    FROM Marks 
    WHERE marks > 80
);

SELECT name 
FROM Students S
WHERE EXISTS (
    SELECT 1 
    FROM Marks M 
    WHERE M.student_id = S.student_id AND M.marks < 40
);
SELECT name 
FROM Students S
WHERE EXISTS (
    SELECT 1 
    FROM Marks M 
    WHERE M.student_id = S.student_id AND M.marks < 40
);
SELECT name 
FROM Students 
WHERE age = (
    SELECT MAX(age) 
    FROM Students
);